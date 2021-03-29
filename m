Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D8834C3E8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 08:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhC2Gev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 02:34:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230504AbhC2Gef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 02:34:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 377056192B;
        Mon, 29 Mar 2021 06:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616999675;
        bh=pG64FB9rWovZQplGtwnKbEowT24yQaVuAwZw82YgEGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rMxe+QBYAVmedAAlAj9m7ayc0pQrClYyyMyDUnn5p7vuHDudjo4ivpJFWZ6/jnjuy
         uhwTy8+kP1qCW/ekLsRlwWr/zO7IF2dgCpVtAvpbh+wfpoRqntC/DAR+6t+Tl5Z4CN
         cdYT7WImi5szh693yk9loi3udsqdQ3IAG3DnE45GI7tO+YaBwEh9bg2IVzPjoa4jnB
         lVvRSDImw3yJNDbxg5193wcV1rW+B657WpiOrPNwNs6zCl/1sd8bIfW3eakuF3MJLb
         2sd/YKaUlios5/zL0Lv1JyisqEUSt2NA2+6DGnjmEpbYYrG0rEBTUlqVpNXM0IqyBI
         NYkB4mWjrRcng==
Date:   Mon, 29 Mar 2021 09:34:31 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Hyunsoon Kim <h10.kim@samsung.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, dseok.yi@samsung.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: add ___GFP_NOINIT flag which disables zeroing on
 alloc
Message-ID: <YGF09yYtxeNj4Bcc@unreal>
References: <CGME20210329054156epcas2p31650fa755e6cbcc55c4f33a79878256f@epcas2p3.samsung.com>
 <1616995751-83180-1-git-send-email-h10.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616995751-83180-1-git-send-email-h10.kim@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 02:29:10PM +0900, Hyunsoon Kim wrote:
> This patch allows programmer to avoid zero initialization on page
> allocation even when the kernel config "CONFIG_INIT_ON_ALLOC_DEFAULT"
> is enabled. The configuration is made to prevent uninitialized
> heap memory flaws, and Android has applied this for security and
> deterministic execution times. Please refer to below.
> 
> https://android-review.googlesource.com/c/kernel/common/+/1235132
> 
> However, there is a case that the zeroing page memory is unnecessary
> when the page is used on specific purpose and will be zeroed
> automatically by hardware that accesses the memory through DMA.
> For instance, page allocation used for IP packet reception from Exynos
> modem is solely used for packet reception. Although the page will be
> freed eventually and reused for some other purpose, initialization at
> that moment of reuse will be sufficient to avoid uninitialized heap
> memory flaws. To support this kind of control, this patch creates new
> gfp type called ___GFP_NOINIT, that allows no zeroing at the moment
> of page allocation, called by many related APIs such as page_frag_alloc,
> alloc_pages, etc.
> 
> Signed-off-by: Hyunsoon Kim <h10.kim@samsung.com>
> ---
>  include/linux/gfp.h | 2 ++
>  include/linux/mm.h  | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)

Let's assume that we will use this new flag, and users are smart enough
to figure when it needs to be used, what will be the performance gain?

Thanks
