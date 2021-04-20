Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FB0365A5C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 15:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhDTNlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 09:41:22 -0400
Received: from mail.hallyn.com ([178.63.66.53]:40168 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230408AbhDTNlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:41:20 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 46FDE471; Tue, 20 Apr 2021 08:40:47 -0500 (CDT)
Date:   Tue, 20 Apr 2021 08:40:47 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Andrew G. Morgan" <morgan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        security@kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Andy Lutomirski <luto@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] capabilities: require CAP_SETFCAP to map uid 0 (v3.2)
Message-ID: <20210420134047.GA11346@mail.hallyn.com>
References: <20210416045851.GA13811@mail.hallyn.com>
 <20210416150501.zam55gschpn2w56i@wittgenstein>
 <20210416213453.GA29094@mail.hallyn.com>
 <20210417021945.GA687@mail.hallyn.com>
 <20210417200434.GA17430@mail.hallyn.com>
 <m135vne1ez.fsf@fess.ebiederm.org>
 <87mttu9sqg.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mttu9sqg.fsf@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 05:52:39PM +0200, Giuseppe Scrivano wrote:
> ebiederm@xmission.com (Eric W. Biederman) writes:
> 
> > Guiseppe can you take a look at this?
> >
> > This is a second attempt at tightening up the semantics of writing to
> > file capabilities from a user namespace.
> >
> > The first attempt was reverted with 3b0c2d3eaa83 ("Revert 95ebabde382c
> > ("capabilities: Don't allow writing ambiguous v3 file capabilities")"),
> > which corrected the issue reported in:
> > https://github.com/containers/buildah/issues/3071
> >
> > There is a report the podman testsuite passes.  While different this
> > looks in many ways much more strict than the code that was reverted.  So
> > while I can imagine this change doesn't cause problems as is, I will be
> > surprised.
> 
> thanks for pulling me in the discussion.
> 
> I've tested the patch with several cases similar to the issue we had in
> the past and the patch seems to work well.  
> 
> Podman creates all the user namespaces within the same parent user
> namespace.  In the parent user namespace all the capabilities are kept
> and AFAIK Docker does the same.  I'd expect a change in behavior only
> for nested user namespaces in containers where CAP_SETFCAP is not
> granted, but that is not a common configuration given that CAP_SETFCAP
> is added by default.
> 
> 
> > "Serge E. Hallyn" <serge@hallyn.com> writes:
> >
> >> +/**
> >> + * verify_root_map() - check the uid 0 mapping
> >> + * @file: idmapping file
> >> + * @map_ns: user namespace of the target process
> >> + * @new_map: requested idmap
> >> + *
> >> + * If a process requested a mapping for uid 0 onto uid 0, verify that the
> >> + * process writing the map had the CAP_SETFCAP capability as the target process
> >> + * will be able to write fscaps that are valid in ancestor user namespaces.
> >> + *
> >> + * Return: true if the mapping is allowed, false if not.
> >> + */
> >> +static bool verify_root_map(const struct file *file,
> >> +			    struct user_namespace *map_ns,
> >> +			    struct uid_gid_map *new_map)
> >> +{
> >> +	int idx;
> >> +	const struct user_namespace *file_ns = file->f_cred->user_ns;
> >> +	struct uid_gid_extent *extent0 = NULL;
> >> +
> >> +	for (idx = 0; idx < new_map->nr_extents; idx++) {
> >> +		u32 lower_first;
> 
> nit: lower_first seems unused?

Drat - I noticed that Sunday or Monday and forgot to remove it, thanks.

> >> +
> >> +		if (new_map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
> >> +			extent0 = &new_map->extent[idx];
> >> +		else
> >> +			extent0 = &new_map->forward[idx];
> >> +		if (extent0->lower_first == 0)
> >> +			break;
> >> +
> >> +		extent0 = NULL;
> >> +	}
> 
> Tested-by: Giuseppe Scrivano <gscrivan@redhat.com>

Awesome - thanks for testing.
