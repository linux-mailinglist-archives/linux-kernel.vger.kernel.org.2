Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C4A3D0517
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 01:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhGTWeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 18:34:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229726AbhGTWdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 18:33:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46CB760FE7;
        Tue, 20 Jul 2021 23:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1626822862;
        bh=nEnjKOxUloIQfSQL7a+2WVoIz2kHnvdbpqmipDdcQII=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=asJZYUWGeUCXEMHNcgGFRAG/YdCc5ucna4fYThfnH6elAMAExzgEYCremlJelES1R
         H5xyNCRFILz36ZhahLc4oktKOkbnRMklrUbRAAoEoF0z7gFZAq+pw8H77B9yvDx1zw
         /nukVTRmXzzte9RPc7RrDPONIP+pA3r9KNH85Loo=
Date:   Tue, 20 Jul 2021 16:14:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, tglx@linutronix.de,
        hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
Subject: Re: [PATCH 1/7] mm: fix the deadlock in finish_fault()
Message-Id: <20210720161421.f4874db77e0b13192d0ab895@linux-foundation.org>
In-Reply-To: <9e97cedc-9fd7-4290-9f44-04b96acea15d@bytedance.com>
References: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
        <20210718043034.76431-2-zhengqi.arch@bytedance.com>
        <20210718212814.suvziikndiyezi6m@box.shutemov.name>
        <9e97cedc-9fd7-4290-9f44-04b96acea15d@bytedance.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jul 2021 17:53:12 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> 
> 
> On 7/19/21 5:28 AM, Kirill A. Shutemov wrote:
> > On Sun, Jul 18, 2021 at 12:30:27PM +0800, Qi Zheng wrote:
> >> The commit 63f3655f9501(mm, memcg: fix reclaim deadlock with writeback)
> >> fix a deadlock bug by pre-allocating the pte page table outside of the
> >> page lock, the commit f9ce0be71d1f(mm: Cleanup faultaround and
> >> finish_fault() codepaths) rework the relevant code but ignore this race,
> >> fix it.
> >>
> >> Fixes: f9ce0be71d1f(mm: Cleanup faultaround and finish_fault() codepaths)
> >> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > 
> > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > 
> > and add stable@, please.
> > 
> 
> OK, I will add these in the patch v2, thanks.

Please send this as a separate standalone patch, not as a part of the
main series.

Also, please include in the changelog a description of the user-visible
impact of the bug which is being fixed.

