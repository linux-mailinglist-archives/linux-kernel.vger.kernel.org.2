Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45BA38398A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345953AbhEQQVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:21:31 -0400
Received: from mail.hallyn.com ([178.63.66.53]:41580 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245156AbhEQQSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 12:18:36 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id A7D1C937; Mon, 17 May 2021 11:17:13 -0500 (CDT)
Date:   Mon, 17 May 2021 11:17:13 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Giuseppe Scrivano <gscrivan@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        dwalsh@redhat.com, ebiederm@xmission.com
Subject: Re: [RFC PATCH 1/3] setgroups: new mode 'shadow' for
 /proc/PID/setgroups
Message-ID: <20210517161713.GB25644@mail.hallyn.com>
References: <20210510130011.1441834-1-gscrivan@redhat.com>
 <20210510130011.1441834-2-gscrivan@redhat.com>
 <20210515015157.GB2845@mail.hallyn.com>
 <87y2cdqyhj.fsf@redhat.com>
 <20210517143321.en2jy2gaxrhdhvub@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517143321.en2jy2gaxrhdhvub@wittgenstein>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 04:33:21PM +0200, Christian Brauner wrote:
> On Mon, May 17, 2021 at 03:30:16PM +0200, Giuseppe Scrivano wrote:
> > >> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> > >> index 8d62863721b0..b1940b63f7ac 100644
> > >> --- a/kernel/user_namespace.c
> > >> +++ b/kernel/user_namespace.c
> > >> @@ -123,6 +123,7 @@ int create_user_ns(struct cred *new)
> > >>  		ns->ucount_max[i] = INT_MAX;
> > >>  	}
> > >>  	ns->ucounts = ucounts;
> > >> +	ns->shadow_group_info = get_current_groups();
> > >
> > > If userns u1 unshares u2 with shadow set, then when u2 unshares
> > > u3, should u3 get the same shadowed set that u2 has, or should it
> > > get all of u2's groups as u3's initial shadow set?
> > 
> > good question.  Thinking more of it, I think a reasonable interface is
> > to expect a child userns to inherit the same shadow groups as its parent
> > userns.  If "shadow" is written again to the /proc/PID/setgroups file
> > then it grows shadow groups set to include the ones the userns had at
> > creation time (which includes the parent shadow groups).  What do you
> > think of it?  I'll play more with this idea and see if it works.
> 
> So when I initially looked at that proposal I was neither "yay" or "nay"
> since it seemed useful to people and it looked somewhat straightforward
> to implement.
> 
> But I do have concerns now after seeing this. The whole
> /proc/<pid>/setgroups API is terrible in the first place and causes even
> more special-casing in container runtimes then there already is. But it
> fixes a security issue so ok we'll live with it.
> 
> But I'm not happy about extending its format to include more options. I
> really don't want the precedent of adding magic keywords into this file.
> 
> Which brings me to my second concern. I think starting to magically
> inherit group ids isn't a great idea. It's got a lot of potential for
> confusion.
> 
> The point Serge here made makes this pretty obvious imho. I don't think
> introducing the complexities of magic group inheritance is something we
> should do.
> 
> Alternative proposal, can we solve this in userspace instead?
> 
> As has been pointed out there is a solution to this problem already
> which is to explicitly map those groups through, i.e. punch holes for
> the groups to be inherited.
> 
> So can't we introduce a new mode for newgidmap by e.g. introducing
> another /etc/setgroups file or something similar that can be configured
> by the administrator. It could take options, e.g. "shadow=always" which
> could mean "everyone must inherit their groups" so newgidmap will punch
> holes for the caller's groups when writing the gid mapping. We could
> also extend this by making newgidmap take a command line switch so it's
> on a case-by-case basis.
> 
> This is even more flexible since you could extend the new /etc/setgroups
> file to specify a list of groups that must always be preserved. I'd
> rather see something like this rather than a magic inheritance switch.
> 
> Christian

That sounds reasonable, but my concern is that admins currently using
groups to deny file access will need to take extra steps to maintain
that guarantee.  I think that falls under the category of a regression.
Unless we make 'shadow=always' the default.  But then *that* will regress
users who currently do not want that feature :)

Anyway, if we do go this route - or maybe a login.defs option
"ALLOW_UNPRIV_GROUPS_DROP" - perhaps we can also add a new /etc/subauxgroups
file (TODO find a better name) which admins who are in the know can use to say
"hallyn 2000" meaning "user hallyn cannot drop group 2000"

-serge
