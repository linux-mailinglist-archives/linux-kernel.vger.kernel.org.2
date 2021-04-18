Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896E63636FB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 19:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbhDRRWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 13:22:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229783AbhDRRVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 13:21:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE01861001;
        Sun, 18 Apr 2021 17:21:22 +0000 (UTC)
Date:   Sun, 18 Apr 2021 19:21:17 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Andrew G. Morgan" <morgan@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        security@kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] capabilities: require CAP_SETFCAP to map uid 0 (v3.2)
Message-ID: <20210418172117.mjjaahgnd2hoxhf5@wittgenstein>
References: <20210416045851.GA13811@mail.hallyn.com>
 <20210416150501.zam55gschpn2w56i@wittgenstein>
 <20210416213453.GA29094@mail.hallyn.com>
 <20210417021945.GA687@mail.hallyn.com>
 <20210417200434.GA17430@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210417200434.GA17430@mail.hallyn.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 03:04:34PM -0500, Serge Hallyn wrote:
> A process running as uid 0 but without cap_setfcap currently can simply
> unshare a new user namespace with uid 0 mapped to 0.  While this task
> will not have new capabilities against the parent namespace, there is
> a loophole due to the way namespaced file capabilities work.  File
> capabilities valid in userns 1 are distinguised from file capabilities
> valid in userns 2 by the kuid which underlies uid 0.  Therefore
> the restricted root process can unshare a new self-mapping namespace,
> add a namespaced file capability onto a file, then use that file
> capability in the parent namespace.
> 
> To prevent that, do not allow mapping uid 0 if the process which
> opened the uid_map file does not have CAP_SETFCAP, which is the capability
> for setting file capabilities.
> 
> A further wrinkle:  a task can unshare its user namespace, then
> open its uid_map file itself, and map (only) its own uid.  In this
> case we do not have the credential from before unshare,  which was
> potentially more restricted.  So, when creating a user namespace, we
> record whether the creator had CAP_SETFCAP.  Then we can use that
> during map_write().
> 
> With this patch:
> 
> 1. unprivileged user can still unshare -Ur
> 
> ubuntu@caps:~$ unshare -Ur
> root@caps:~# logout
> 
> 2. root user can still unshare -Ur
> 
> ubuntu@caps:~$ sudo bash
> root@caps:/home/ubuntu# unshare -Ur
> root@caps:/home/ubuntu# logout
> 
> 3. root user without CAP_SETFCAP cannot unshare -Ur:
> 
> root@caps:/home/ubuntu# /sbin/capsh --drop=cap_setfcap --
> root@caps:/home/ubuntu# /sbin/setcap cap_setfcap=p /sbin/setcap
> unable to set CAP_SETFCAP effective capability: Operation not permitted
> root@caps:/home/ubuntu# unshare -Ur
> unshare: write failed /proc/self/uid_map: Operation not permitted
> 
> Signed-off-by: Serge Hallyn <serge@hallyn.com>
> 
> Changelog:
>    * fix logic in the case of writing to another task's uid_map
>    * rename 'ns' to 'map_ns', and make a file_ns local variable
>    * use /* comments */
>    * update the CAP_SETFCAP comment in capability.h
>    * rename parent_unpriv to parent_can_setfcap (and reverse the
>      logic)
>    * remove printks
>    * clarify (i hope) the code comments
>    * update capability.h comment
>    * renamed parent_can_setfcap to parent_could_setfcap
>    * made the check its own disallowed_0_mapping() fn
>    * moved the check into new_idmap_permitted
>    * rename disallowed_0_mapping to verify_root_mapping
>    * change verify_root_mapping to Christian's suggested flow
> ---

Thank you. This looks good. I tested this with:

- fstests
- LXD testsuite
- Podman testsuite
- libcap testsuite

Tested-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
