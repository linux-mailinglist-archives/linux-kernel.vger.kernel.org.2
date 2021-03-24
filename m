Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361A0348108
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbhCXSzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237532AbhCXSzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:55:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5E8861A0A;
        Wed, 24 Mar 2021 18:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616612136;
        bh=39W/A/1MQN2qtx5XidDcwhzMqYmkDys9KGwGNqwlSLM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=dyOVzEDFOTG/8Rmm24H7HWnMKg7Hnvl/oPc0YO55xsLglGs7Rxm0pCXMlg8wXW5Mp
         Rl9SayRFv2Qu9u4paCNpJ8nQUV1zJwH55TtFyLY6gsulID3avz1k07SXQVrJakHrm3
         qw9XT/YrtqBxeOpp9oGiZF5Ap4IH20w5U19fGmgt80j1jJu8/fWXekPNGLpSMEkz/g
         ePo77yCta25T3uMGNVfaKnSQnPrC9DaEQkmJFSY67X9d8DajUvUWMCI4/06PhzeWYy
         85GFOYI+4Z5YlzqyYq7UoIni/Ni7khuzS6N0s3Cjccrs/fCCnFzpZ0AnDky3VpqCUp
         Z0nLWSBBHU86w==
Date:   Wed, 24 Mar 2021 11:55:34 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     sstabellini@kernel.org, linux@armlinux.org.uk,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, jgross@suse.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH] ARM: xen/mm.c: A mundane typo fix
In-Reply-To: <20210324133036.17665-1-unixbhaskar@gmail.com>
Message-ID: <alpine.DEB.2.21.2103241154320.439@sstabellini-ThinkPad-T480s>
References: <20210324133036.17665-1-unixbhaskar@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021, Bhaskar Chowdhury wrote:
> s/acrros/across/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  arch/arm/xen/mm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> index 467fa225c3d0..be7c942c74bf 100644
> --- a/arch/arm/xen/mm.c
> +++ b/arch/arm/xen/mm.c
> @@ -105,7 +105,7 @@ bool xen_arch_need_swiotlb(struct device *dev,
>  	 *	- The Linux page refers to foreign memory
>  	 *	- The device doesn't support coherent DMA request
>  	 *
> -	 * The Linux page may be spanned acrros multiple Xen page, although
> +	 * The Linux page may be spanned across multiple Xen page, although
>  	 * it's not possible to have a mix of local and foreign Xen page.
>  	 * Furthermore, range_straddles_page_boundary is already checking
>  	 * if buffer is physically contiguous in the host RAM.
> --
> 2.30.1
> 
