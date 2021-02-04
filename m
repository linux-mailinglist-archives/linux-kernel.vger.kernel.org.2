Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEDF30FDCC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239955AbhBDUI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239965AbhBDUGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 15:06:36 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85710C061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 12:05:56 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id e15so3352145qte.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 12:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PNpabScqAJL/H2mjmh5glVW/nkx6cWA4Jun5NHUQOrM=;
        b=rpVczFjAy+Eo1fHw1BDYqgKj2CQrvpHaS52itpgYB9u+R9fd0OhJLGQIGcLuIThgmO
         1EtEXj/HZXv0cMrN3wwlbjmxFv0no8HWWMeBsQOOozyuyAktfcg83i2gOzL6ta27x3jZ
         fcYwOlWIODDKif1RHsWfYyVzyy7fGIJFXDzn99yB7VC74nQEq23Y/RURT9mndO8E2/ea
         lgGcPE4IFkvVV1lL135khk1YP8UB8EI2+F7IoJqlBqN4rYvkp8AZoq05eM+aOdE9R0tT
         IcJk3AlHMA4eXi43FufTKxW8GKY3BaUaqYy7gBV8GBlAwhvBG0lGamR6wHXHPGv6HXg6
         vkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PNpabScqAJL/H2mjmh5glVW/nkx6cWA4Jun5NHUQOrM=;
        b=Eb67pMC+2A64005/6GRjToDGcnJ7tQ8vbf0su2G7ba9WmPpsyIn5u91xNDcndnER9W
         h+656L8euGaLNBKbYSoAEPEdfcEIoD9ULXTsbQQBOSSM5nIgVWahU1xg3WClcCuRymqw
         bDxlSNw7TvILMi7h3rvh26DHrY9M9VbAkWCPHAL5FnTF1LVVQIKG8sc2VfMa+ok66vNW
         6jvZVGw4eht6WhvpTSVHYHUtNpIM6WH1z9bZQE+bmPK1QPyTGhadLwsw0QgTQFLL+Wxr
         mD5JRsx4DrzRMx61VucvK0PB/UWXObfcy005UNiUpUdqhJiQFoA98e//pYUNlD1zUt2J
         naBw==
X-Gm-Message-State: AOAM530eJdGyKyc9WQYWdVVmLXzQaXB48o3xeh0UocY2l/sl4yBhDici
        YMG5i7iVewbDzr5JM6qh2FYrOw==
X-Google-Smtp-Source: ABdhPJyZZA46ofyz59zphWQtKYjnhI0FsTngAQYc0CmeWI9YcxVNaC1vxMTQKCToJYvsy/ymtjimsg==
X-Received: by 2002:ac8:16f2:: with SMTP id y47mr1296485qtk.96.1612469155734;
        Thu, 04 Feb 2021 12:05:55 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id f8sm5332143qth.6.2021.02.04.12.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:05:54 -0800 (PST)
Date:   Thu, 4 Feb 2021 15:05:53 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 6/7] mm: memcontrol: switch to rstat
Message-ID: <YBxToaRrlRUXfIod@cmpxchg.org>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-7-hannes@cmpxchg.org>
 <20210203014726.GE1812008@carbon.dhcp.thefacebook.com>
 <YBwgOHL8dTjJpnKU@cmpxchg.org>
 <20210204184520.GC1837780@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204184520.GC1837780@carbon.DHCP.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 10:45:20AM -0800, Roman Gushchin wrote:
> On Thu, Feb 04, 2021 at 11:26:32AM -0500, Johannes Weiner wrote:
> > On Tue, Feb 02, 2021 at 05:47:26PM -0800, Roman Gushchin wrote:
> > > On Tue, Feb 02, 2021 at 01:47:45PM -0500, Johannes Weiner wrote:
> > > >  	for_each_node(node) {
> > > >  		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
> > > > +		unsigned long stat[NR_VM_NODE_STAT_ITEMS] = {0, };
> > >                                                               ^^
> > > I'd drop the comma here. It seems that "{0}" version is way more popular
> > > over the mm code and in the kernel in general.
> > 
> > Is there a downside to the comma? I'm finding more { 0, } than { 0 }
> > in mm code, and at least kernel-wide it seems both are acceptable
> > (although { 0 } is more popular overall).
> 
> { 0 } is more obvious and saves a character.

The comma signals that the author is aware that the array or structure
has more elements than specified, and that they expect the rest to be
zeroed. We use it extensively to initialize structures (like struct
cgroup_subsys inits, cftypes, struct address_space_operations, etc.)

So I'd say "more obvious" is subjective. I find the comma version a
bit more obvious.

> The "problem" with comma version is that { 1, } and { 0, } have a
> different meaning.

...which is? They both mean set the first element to x and zerofill
the rest, no?

Again, I don't really care too much either way, I'm just wondering if
I'm missing something bigger here.
