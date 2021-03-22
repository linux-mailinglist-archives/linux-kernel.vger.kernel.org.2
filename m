Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC59345134
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 21:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhCVUzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 16:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhCVUzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 16:55:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6D9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 13:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=b3Ab64gMwLXEjOKWzRYzhgtkfQ7yGZ0iEhUU73fIUU8=; b=ELAKB/0n1zibeXStmS+wwJQt9x
        Ixo0pWMKt+9VlcCYoCCeJ3Rc6c5t+sUBRmeKPHLEjZZoFvrFDy0ww5l+S9cj8YZQ/pGAonAL8fxdm
        ht9K8VzKy5NnhBoG/rBwGljCySo23xjMIMM/qzE9NVY0Dufbwbsh7I9I6krQGQmTppuljG5KpKSSN
        QfsE2UHL+NoKWQqUgV2ueUYP9Tyej2hCNVO5aIShW5/x3mvDYYWtvzvRHixLaBemXCBIQbiIN3G0G
        NcUAtZEZiA2c9WXzlPiKG62fPr/xMAruv7CtJxa1/N5KbY3CpxSU1BkIH+LfoYEP54TF/LVSR18yF
        roeGZsSw==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lORZr-0094Ia-Hb; Mon, 22 Mar 2021 20:55:09 +0000
Subject: Re: [PATCH V2] staging: rtl8723bs: Mundane typo fixes
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20210322201648.137317-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <af9c4139-80f4-1003-d484-ee984232869c@infradead.org>
Date:   Mon, 22 Mar 2021 13:55:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322201648.137317-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 1:16 PM, Bhaskar Chowdhury wrote:
> s/stoping/stopping/
> s/arragement/arrangement/
> s/eralier/earlier/
> 
> Plus one extra word in the sentence "the" removed.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>   Changes from V1:
>   Greg,pointed out my mistake of introducing typo to typo , corrected.
> 
>  drivers/staging/rtl8723bs/include/hal_com_reg.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/hal_com_reg.h b/drivers/staging/rtl8723bs/include/hal_com_reg.h
> index 37fa59a352d6..b555826760d0 100644
> --- a/drivers/staging/rtl8723bs/include/hal_com_reg.h
> +++ b/drivers/staging/rtl8723bs/include/hal_com_reg.h
> @@ -1002,9 +1002,9 @@ Current IOREG MAP
>  	/* 		 8192C (TXPAUSE) transmission pause	(Offset 0x522, 8 bits) */
>  	/*  */
>  /*  Note: */
> -/* 	The the bits of stoping AC(VO/VI/BE/BK) queue in datasheet RTL8192S/RTL8192C are wrong, */
> -/* 	the correct arragement is VO - Bit0, VI - Bit1, BE - Bit2, and BK - Bit3. */
> -/* 	8723 and 88E may be not correct either in the eralier version. Confirmed with DD Tim. */
> +/* 	The  bits of stopping AC(VO/VI/BE/BK) queue in datasheet RTL8192S/RTL8192C are wrong, */
> +/* 	the correct arrangement is VO - Bit0, VI - Bit1, BE - Bit2, and BK - Bit3. */
> +/* 	8723 and 88E may be not correct either in the earlier version. Confirmed with DD Tim. */
>  /*  By Bruce, 2011-09-22. */
>  #define StopBecon		BIT6
>  #define StopHigh			BIT5
> --


-- 
~Randy

