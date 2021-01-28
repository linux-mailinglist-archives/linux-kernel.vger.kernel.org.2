Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65CD3080FF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 23:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhA1WQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 17:16:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229658AbhA1WQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:16:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71E5E60C41;
        Thu, 28 Jan 2021 22:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1611872133;
        bh=f+DCj2JfUNSoZg7jQcx8ZSeyCgEmsK+gf0UClqfV8/c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xqHNrx2L0rzVIHXj1eaVcjrpukXSsiToIagJcPFfsRuUKZPNr7blDMX1Tvra8b+aq
         zEJRuwIn+4iqZd6m/MrnjGDOUMkmR6IDt8JWov1EqHjTxf3hHtEcDqycOAfiJQWNmD
         s8eBer9fxaO1vX0esOiywcxH+E1Ir6yOnkVsBzVE=
Date:   Thu, 28 Jan 2021 14:15:31 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH v3 3/5] hugetlb: only set HPageMigratable for migratable
 hstates
Message-Id: <20210128141531.17fec31e6075fe0eb6e33683@linux-foundation.org>
In-Reply-To: <12187293-e972-acd8-7789-22ebfa736f95@oracle.com>
References: <20210122195231.324857-1-mike.kravetz@oracle.com>
        <20210122195231.324857-4-mike.kravetz@oracle.com>
        <20210127103523.GI827@dhcp22.suse.cz>
        <2196d93e-f573-7163-183e-0ad2cec7555e@oracle.com>
        <20210128055221.GA3166@localhost.localdomain>
        <20210128133733.ce1fb2eac98ab5696c08f288@linux-foundation.org>
        <12187293-e972-acd8-7789-22ebfa736f95@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jan 2021 14:00:29 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> On 1/28/21 1:37 PM, Andrew Morton wrote:
> > On Thu, 28 Jan 2021 06:52:21 +0100 Oscar Salvador <osalvador@suse.de> wrote:
> > 
> >> On Wed, Jan 27, 2021 at 03:36:41PM -0800, Mike Kravetz wrote:
> >>> Yes, this patch is somewhat optional.  It should be a minor improvement
> >>> in cases where we are dealing with hpages in a non-migratable hstate.
> >>> Although, I do not believe this is the common case.
> >>>
> >>> The real reason for even looking into this was a comment by Oscar.  With
> >>> the name change to HPageMigratable, it implies that the page is migratable.
> >>> However, this is not the case if the page's hstate does not support migration.
> >>> So, if we check the hstate when setting the flag we can eliminate those
> >>> cases where the page is certainly not migratable.
> >>>
> >>> I don't really love this patch.  It has minimal functional value.
> >>>
> >>> Oscar, what do you think about dropping this?
> >>
> >> Yeah, I remember this topic arose during a discussion of patch#2 in the
> >> early versions, about whether the renaming to HPageMigratable made
> >> sense.
> >>
> >> Back then I thought that we could have this in one place at fault-path [1],
> >> which should have made this prettier, but it is not the case.
> >> True is that the optimization is little, so I am fine with dropping this
> >> patch.
> > 
> > I've dropped it.
> 
> Thanks Andrew.
> 
> Michal suggested that comments describing synchronization be added for each
> flag.  Since I did 'one patch per flag', that would be an update to each patch.
> Or, I could simply add a patch to update the comment block based on what you
> already have.
> 
> Let me know what is best/easiest for you.

I guess just one patch is best for reviewers.  Then I'll split up into
a sprinkle of -fix patches if I'm feeling energetic ;)
