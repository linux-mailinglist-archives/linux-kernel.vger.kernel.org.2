Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98B832547E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhBYRWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbhBYRV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:21:59 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2536C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 09:21:18 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id o3so6797595oic.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 09:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=QP8wik+2o5omyOnnYki4P85PvKiXC4TVtgCE2LHXuUg=;
        b=KfPK9SYm6gD/9Iv7tlbdngynvJMG/5ekBBKEfv0A89GryOsGFaL3BHQW2BYtE1cplT
         Dq+mg3kRrGUgQkkJL47CLVd9aYgeF3REdYPdQSxyXL+cNTiDRQ2e69qPiWDc+C4HVCAV
         5ntef4kB8VHzUM6jrnJ79Zu4Kk3ymdI+WuYZNAWxZl26HFfGmeI8fcgMZjt9tG8GqEqB
         JU++T4rni/U2/vv1OOVxqK1NrRBtG/ZJxoJ6Ad4/j8Z/9HzrXIOBBmnmdQ6OAbWFMTRF
         jXhmXP4/210cF8CxzipMuy1PV3Ix73ZeHyUQNkNM3TpDI6qCeng8AIAmDEH+fUZ1TgyO
         S3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=QP8wik+2o5omyOnnYki4P85PvKiXC4TVtgCE2LHXuUg=;
        b=bUp7qVSkMtzY1fON8StiFQpcTvsOiEOJe7k5UNzACoL1AFSGfxWo5aZyolovAV1JNx
         YoQbMMfwlnFuxUe/3Xr5OlDTaL82lO6yNS2JQ7v51MNOm0Ql33SnV0Ao2NqXzfmmfcAV
         54eHntkn7D9+OuGccv/0OjsvGO3DxoPSiXG24lunlNIJtroN2xoiXLkA6OMx4/CDZbPN
         LQhg2ZwVna2DW5ALhWOcfnJ216Z42rUUjAiFp1NE5jgwL23lZbu1r1JtVU6ENPM13HJi
         FSJb4r2yyS9hJFrzdMgMcyqqSR3CKRvssqiw+XITP2tRoROxruR+W8ufNAAVooPzM0K/
         qYrQ==
X-Gm-Message-State: AOAM533gfx0FvB7lYc/gQjxgJUxOlfesQ2A8UAyMHjaMPwnKFO3d5Vi2
        4hTkDm5c/yAFT+6vO+OtmqWFnA==
X-Google-Smtp-Source: ABdhPJxT008u6Mx8R7E2Rb9HdqEjl0MRBTlVsijJC9UySPKw0Ot8rczlZ98TR1RSzBxf4YZiTnqu+A==
X-Received: by 2002:aca:5f44:: with SMTP id t65mr2721122oib.46.1614273677560;
        Thu, 25 Feb 2021 09:21:17 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g18sm1235379otq.33.2021.02.25.09.21.16
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 25 Feb 2021 09:21:17 -0800 (PST)
Date:   Thu, 25 Feb 2021 09:21:04 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Roman Gushchin <guro@fb.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: vmstat: fix /proc/sys/vm/stat_refresh generating
 false warnings
In-Reply-To: <YDcDAOxKXSopVe3b@carbon.dhcp.thefacebook.com>
Message-ID: <alpine.LSU.2.11.2102250905350.11720@eggly.anvils>
References: <alpine.LSU.2.11.2007291902340.6363@eggly.anvils> <20200730162348.GA679955@carbon.dhcp.thefacebook.com> <alpine.LSU.2.11.2007302018350.2410@eggly.anvils> <20200801011821.GA859734@carbon.dhcp.thefacebook.com> <alpine.LSU.2.11.2007311915130.9716@eggly.anvils>
 <20200804004012.GA1049259@carbon.dhcp.thefacebook.com> <alpine.LSU.2.11.2008051913580.8184@eggly.anvils> <20200806233804.GB1217906@carbon.dhcp.thefacebook.com> <20200806182555.d7a7fc9853b5a239ffe9f846@linux-foundation.org> <alpine.LSU.2.11.2102232210130.9202@eggly.anvils>
 <YDcDAOxKXSopVe3b@carbon.dhcp.thefacebook.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Feb 2021, Roman Gushchin wrote:
> On Tue, Feb 23, 2021 at 11:24:23PM -0800, Hugh Dickins wrote:
> > On Thu, 6 Aug 2020, Andrew Morton wrote:
> > > On Thu, 6 Aug 2020 16:38:04 -0700 Roman Gushchin <guro@fb.com> wrote:
> > 
> > August, yikes, I thought it was much more recent.
> > 
> > > 
> > > > it seems that Hugh and me haven't reached a consensus here.
> > > > Can, you, please, not merge this patch into 5.9, so we would have
> > > > more time to find a solution, acceptable for all?
> > > 
> > > No probs.  I already had a big red asterisk on it ;)
> > 
> > I've a suspicion that Andrew might be tiring of his big red asterisk,
> > and wanting to unload
> > mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings.patch
> > mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix.patch
> > mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix-2.patch
> > into 5.12.
> > 
> > I would prefer not, and reiterate my Nack: but no great harm will
> > befall the cosmos if he overrules that, and it does go through to
> > 5.12 - I'll just want to revert it again later.  And I do think a
> > more straightforward way of suppressing those warnings would be just
> > to delete the code that issues them, rather than brushing them under
> > a carpet of overtuning.
> 
> I'm actually fine with either option. My only concern is that if somebody
> will try to use the hugetlb_cma boot option AND /proc/sys/vm/stat_refresh
> together, they will get a false warning and report them to mm@ or will
> waste their time trying to debug a non-existing problem. It's not the end
> of the world.
> We can also make the warning conditional on CONFIG_DEBUG_VM, for example.
> 
> Please, let me know what's your preferred way to go forward.

My preferred way forward (for now: since we're all too busy to fix
the misbehaving stats) is for Andrew to drop your patch, and I'll post
three patches against current 5.12 in a few hours: one to restore the
check on the missing NR_VM_NODE_STAT_ITEMS, one to remove the -EINVAL
(which upsets test scripts at our end), one to suppress the warning on
nr_zone_write_pending, nr_writeback and nr_free_cma.

Hugh
