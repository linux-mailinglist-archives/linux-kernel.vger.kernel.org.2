Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A5438397E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344562AbhEQQRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:17:47 -0400
Received: from mail.hallyn.com ([178.63.66.53]:41466 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346889AbhEQQKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 12:10:19 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id BDB195F6; Mon, 17 May 2021 11:08:59 -0500 (CDT)
Date:   Mon, 17 May 2021 11:08:59 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        dwalsh@redhat.com, christian.brauner@ubuntu.com,
        ebiederm@xmission.com
Subject: Re: [RFC PATCH 1/3] setgroups: new mode 'shadow' for
 /proc/PID/setgroups
Message-ID: <20210517160859.GA25644@mail.hallyn.com>
References: <20210510130011.1441834-1-gscrivan@redhat.com>
 <20210510130011.1441834-2-gscrivan@redhat.com>
 <20210515015157.GB2845@mail.hallyn.com>
 <87y2cdqyhj.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2cdqyhj.fsf@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 03:30:16PM +0200, Giuseppe Scrivano wrote:
> Hi Serge,
> 
> thanks for the review.
> 
> "Serge E. Hallyn" <serge@hallyn.com> writes:
> >> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> >> index 8d62863721b0..b1940b63f7ac 100644
> >> --- a/kernel/user_namespace.c
> >> +++ b/kernel/user_namespace.c
> >> @@ -123,6 +123,7 @@ int create_user_ns(struct cred *new)
> >>  		ns->ucount_max[i] = INT_MAX;
> >>  	}
> >>  	ns->ucounts = ucounts;
> >> +	ns->shadow_group_info = get_current_groups();
> >
> > If userns u1 unshares u2 with shadow set, then when u2 unshares
> > u3, should u3 get the same shadowed set that u2 has, or should it
> > get all of u2's groups as u3's initial shadow set?
> 
> good question.  Thinking more of it, I think a reasonable interface is
> to expect a child userns to inherit the same shadow groups as its parent
> userns.  If "shadow" is written again to the /proc/PID/setgroups file
> then it grows shadow groups set to include the ones the userns had at
> creation time (which includes the parent shadow groups).  What do you
> think of it?  I'll play more with this idea and see if it works.

That's what I was thinking would make the most sense.
