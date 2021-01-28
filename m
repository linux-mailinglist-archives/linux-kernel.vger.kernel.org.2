Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC6A306885
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 01:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhA1ASv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 19:18:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:53556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231147AbhA1ASh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 19:18:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8167A64DD1;
        Thu, 28 Jan 2021 00:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1611793076;
        bh=gket93QkDzc1u3zC/b47KPkU1uZdkl7O52e5jROE9r8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hy5Bu3gEdXNa8Sjf4GfI+2liI+Jb7rCNj47E+l1D29lvXaUanjw3Yl12jUxUGj2cq
         hbKbZI8ApA5V3pFDw9asiLtBVEy7gdy/EAu0RPAMjZ7UN8VvJ8WjbHp0QzRAgzw65O
         QnK8o2/bkNP0Aa2YVCV1VNFyHbQ+7zHQL9xTGjCw=
Date:   Wed, 27 Jan 2021 16:17:55 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/hugetlb: Fix use after free when subpool max_hpages
 accounting is not enabled
Message-Id: <20210127161755.68bf43047007a8a2889e302a@linux-foundation.org>
In-Reply-To: <d8dfb9e4-1823-cc79-3d8c-18240fdd0567@huawei.com>
References: <20210126115510.53374-1-linmiaohe@huawei.com>
        <a5952a6f-aaf4-b542-f9f1-5603658a602a@oracle.com>
        <d8dfb9e4-1823-cc79-3d8c-18240fdd0567@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021 10:08:22 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> On 2021/1/27 8:06, Mike Kravetz wrote:
> > On 1/26/21 3:55 AM, Miaohe Lin wrote:
> >> When subpool max_hpages accounting is not enabled, used_hpages is always 0
> >> and might lead to release subpool prematurely because it indicates no pages
> >> are used now while there might be.
> > 
> > It might be good to say that you need min_hpages accounting (min_size mount
> > option) enabled for this issue to occur.  Or, perhaps say this is possible
> > if a hugetlbfs filesystem is created with the min_size option and without
> > the size option.
> > 
> > That might better explain the conditions in which a user could see the issue.
> 
> So commit log might looks like this ?
> """
> If a hugetlbfs filesystem is created with the min_size option and without
> the size option, used_hpages is always 0 and might lead to release subpool
> prematurely because it indicates no pages are used now while there might
> be.
> 
> In order to fix this issue, we should check used_hpages == 0 iff max_hpages
> accounting is enabled. As max_hpages accounting should be enabled in most
> common case, this is not worth a Cc stable.
> """
> 
> If so, should I send a V2 or Andrew would kindly do this?
> Many thanks.

I made that change, thanks.
