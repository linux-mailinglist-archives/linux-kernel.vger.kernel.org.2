Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1363F36542A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhDTIcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:32:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhDTIcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:32:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C246C60FE3;
        Tue, 20 Apr 2021 08:31:32 +0000 (UTC)
Date:   Tue, 20 Apr 2021 10:31:29 +0200
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
Subject: Re: [PATCH] capabilities: require CAP_SETFCAP to map uid 0 (v3.3)
Message-ID: <20210420083129.exyn7ptahx2fg72e@wittgenstein>
References: <20210416045851.GA13811@mail.hallyn.com>
 <20210416150501.zam55gschpn2w56i@wittgenstein>
 <20210416213453.GA29094@mail.hallyn.com>
 <20210417021945.GA687@mail.hallyn.com>
 <20210417200434.GA17430@mail.hallyn.com>
 <20210419122514.GA20598@mail.hallyn.com>
 <20210419160911.5pguvpj7kfuj6rnr@wittgenstein>
 <20210420034208.GA2830@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210420034208.GA2830@mail.hallyn.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 10:42:08PM -0500, Serge Hallyn wrote:
> On Mon, Apr 19, 2021 at 06:09:11PM +0200, Christian Brauner wrote:
> > On Mon, Apr 19, 2021 at 07:25:14AM -0500, Serge Hallyn wrote:
> > > cap_setfcap is required to create file capabilities.
> > > 
> > > Since 8db6c34f1dbc ("Introduce v3 namespaced file capabilities"), a
> > > process running as uid 0 but without cap_setfcap is able to work around
> > > this as follows: unshare a new user namespace which maps parent uid 0
> > > into the child namespace.  While this task will not have new
> > > capabilities against the parent namespace, there is a loophole due to
> > > the way namespaced file capabilities are represented as xattrs.  File
> > > capabilities valid in userns 1 are distinguished from file capabilities
> > > valid in userns 2 by the kuid which underlies uid 0.  Therefore the
> > > restricted root process can unshare a new self-mapping namespace, add a
> > > namespaced file capability onto a file, then use that file capability in
> > > the parent namespace.
> > > 
> > > To prevent that, do not allow mapping parent uid 0 if the process which
> > > opened the uid_map file does not have CAP_SETFCAP, which is the capability
> > > for setting file capabilities.
> > > 
> > > As a further wrinkle:  a task can unshare its user namespace, then
> > > open its uid_map file itself, and map (only) its own uid.  In this
> > > case we do not have the credential from before unshare,  which was
> > > potentially more restricted.  So, when creating a user namespace, we
> > > record whether the creator had CAP_SETFCAP.  Then we can use that
> > > during map_write().
> > > 
> > > With this patch:
> > > 
> > > 1. Unprivileged user can still unshare -Ur
> > > 
> > > ubuntu@caps:~$ unshare -Ur
> > > root@caps:~# logout
> > > 
> > > 2. Root user can still unshare -Ur
> > > 
> > > ubuntu@caps:~$ sudo bash
> > > root@caps:/home/ubuntu# unshare -Ur
> > > root@caps:/home/ubuntu# logout
> > > 
> > > 3. Root user without CAP_SETFCAP cannot unshare -Ur:
> > > 
> > > root@caps:/home/ubuntu# /sbin/capsh --drop=cap_setfcap --
> > > root@caps:/home/ubuntu# /sbin/setcap cap_setfcap=p /sbin/setcap
> > > unable to set CAP_SETFCAP effective capability: Operation not permitted
> > > root@caps:/home/ubuntu# unshare -Ur
> > > unshare: write failed /proc/self/uid_map: Operation not permitted
> > > 
> > > Note: an alternative solution would be to allow uid 0 mappings by
> > > processes without CAP_SETFCAP, but to prevent such a namespace from
> > > writing any file capabilities.  This approach can be seen here:
> > >     https://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git/log/?h=2021-04-15/setfcap-nsfscaps-v4
> > > 
> > 
> > Ah, can you link to the previous fix and its revert, please? I think
> > that was mentioned in the formerly private thread as well but we forgot:
> > 
> > commit 95ebabde382c371572297915b104e55403674e73
> > Author: Eric W. Biederman <ebiederm@xmission.com>
> > Date:   Thu Dec 17 09:42:00 2020 -0600
> > 
> >     capabilities: Don't allow writing ambiguous v3 file capabilities
> > 
> > commit 3b0c2d3eaa83da259d7726192cf55a137769012f
> > Author: Eric W. Biederman <ebiederm@xmission.com>
> > Date:   Fri Mar 12 15:07:09 2021 -0600
> > 
> >     Revert 95ebabde382c ("capabilities: Don't allow writing ambiguous v3 file capabilities")
> 
> Sure.
> 
> Is there a tag for that kind of thing or do I just mention it at the end
> of the description?

In this case it might make sense to just have a little paragraph that
explains the regression. How do you feel about adding?:

  Commit 95ebabde382 ("capabilities: Don't allow writing ambiguous v3 file
  capabilities") tried to fix the issue by preventing v3 fscaps to be
  written to disk when the root uid would map to the same uid in nested
  user namespaces. This led to regressions for various workloads. For
  example, see [1]. Ultimately this is a valid use-case we have to support
  meaning we had to revert this change in 3b0c2d3eaa83 ("Revert
  95ebabde382c ("capabilities: Don't allow writing ambiguous v3 file
  capabilities")").
  
  [1]: https://github.com/containers/buildah/issues/3071
