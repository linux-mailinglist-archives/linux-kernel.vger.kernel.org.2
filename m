Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C2F3BADAA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 17:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhGDPab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 11:30:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64609 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhGDPaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 11:30:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8E88BB61E;
        Sun,  4 Jul 2021 11:27:54 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=V/1t9Mn1a6sicAT1L3K4yl60YZZOfQbgaqgDSO
        Tmal8=; b=G61zAq5TIF1rdiKmUe63uotbepJ19+SQ2ZT4EVLlWYLLXDnlqzmzyF
        24R1LJScIQfrQH+Nh8YFPpKO382QRjQASqPItOloGX0l4mPVplcWzeSJfDRHtG3x
        45FVCZBnFZh8DG4+LZPeBR9sfBFlRzWZ+taDiBJ7YuYU2TdgjjIUQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B1604BB61C;
        Sun,  4 Jul 2021 11:27:54 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=V/1t9Mn1a6sicAT1L3K4yl60YZZOfQbgaqgDSOTmal8=; b=YDVzzKvdxL4RmizmQMYDKTvkHgChrJv8K8o+napspDIrdU0xPrLEI6snlSj3tktWRoRU3PWZydH/HQYQsJEU5IAG59DwqZ+766tK/UWh9GfeGHTp6OeWAdwrgxPmoVa0kThIVuJtp8/JAYFit0mbPBuIE5sdiIJzRxXf3Ocretk=
Received: from yoda.home (unknown [96.21.170.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 34D92BB61B;
        Sun,  4 Jul 2021 11:27:54 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 3BEBF2DA0064;
        Sun,  4 Jul 2021 11:27:53 -0400 (EDT)
Date:   Sun, 4 Jul 2021 11:27:53 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Colin King <colin.king@canonical.com>
cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cramfs: Fix spelling mistake "adressed" -> "addressed"
In-Reply-To: <20210704092521.34660-1-colin.king@canonical.com>
Message-ID: <p5681o7-4p56-n873-61o3-96p7ons97or8@syhkavp.arg>
References: <20210704092521.34660-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 66E80622-DCDC-11EB-8306-FD8818BA3BAF-78420484!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jul 2021, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in the Kconfig text. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Nicolas Pitre <nico@fluxnic.net>

> ---
>  fs/cramfs/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/cramfs/Kconfig b/fs/cramfs/Kconfig
> index d98cef0dbb6b..a8af8c6ac15d 100644
> --- a/fs/cramfs/Kconfig
> +++ b/fs/cramfs/Kconfig
> @@ -38,7 +38,7 @@ config CRAMFS_MTD
>  	default y if !CRAMFS_BLOCKDEV
>  	help
>  	  This option allows the CramFs driver to load data directly from
> -	  a linear adressed memory range (usually non volatile memory
> +	  a linear addressed memory range (usually non volatile memory
>  	  like flash) instead of going through the block device layer.
>  	  This saves some memory since no intermediate buffering is
>  	  necessary.
> -- 
> 2.31.1
> 
> 
