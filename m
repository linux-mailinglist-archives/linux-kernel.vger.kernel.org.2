Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2548C3DA6DD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237540AbhG2OvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhG2OvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:51:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52175C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 07:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=c0pAqr7WjXOmFqze5UYuYquQopW+1yGLNu5EKWRUiGc=; b=u07QTVbfnWNQmvKswjiJGLv5mf
        Q/+cUcRYtTRvAYz8JLJDravtb7cFv1rgmMreNJc+/FZFvZmmmLsCy8hfkY9AAO3GLBZuSDnDB13A0
        KeEDjVoqDilEMP7JpmQMz7/24sdJlq8TuUiCNwXZZkIK7W8Dj8YXGTb418+5InGY9owxuPbhJAiyM
        ODzwpFNN2sfYOH1E4SIvzNsONFVaT4xYZAgmIGR/y/oHIfUXl1WHC9af5JJnMzU3emr2eqQXHnYN3
        cgdCThNaqLag18GqTJ9pVFn1C6rFP/VLZCj57ySHNOecjZEqBwJuLyFyuIY/J8r347uVNGXYpiTfQ
        Aj6sNKOg==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m97NQ-004biU-Ic; Thu, 29 Jul 2021 14:51:12 +0000
Subject: Re: [PATCH] staging: vt665X: remove unused CONFIG_PATH
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Cc:     forest@alittletooquiet.net, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
References: <20210729095812.1693061-1-gregkh@linuxfoundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <68f85669-71a8-b0c9-d23f-0dc7e1de2f12@infradead.org>
Date:   Thu, 29 Jul 2021 07:51:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729095812.1693061-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/21 2:58 AM, Greg Kroah-Hartman wrote:
> The vt6655 and vt6656 drivers have an unused CONFIG_PATH define floating
> around in the code, but it is never used.  Remove it as drivers should
> never be reading from config files anyway, even if these were valid
> files.
> 
> Reported-by: Joe Perches <joe@perches.com>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/staging/vt6655/device_cfg.h | 3 ---
>  drivers/staging/vt6656/device.h     | 2 --
>  2 files changed, 5 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/device_cfg.h b/drivers/staging/vt6655/device_cfg.h
> index db0304f6e21c..2d647a3619ba 100644
> --- a/drivers/staging/vt6655/device_cfg.h
> +++ b/drivers/staging/vt6655/device_cfg.h
> @@ -38,9 +38,6 @@
>  
>  #include <linux/fs.h>
>  #include <linux/fcntl.h>
> -#ifndef CONFIG_PATH
> -#define CONFIG_PATH            "/etc/vntconfiguration.dat"
> -#endif
>  
>  #define PKT_BUF_SZ          2390
>  
> diff --git a/drivers/staging/vt6656/device.h b/drivers/staging/vt6656/device.h
> index 947530fefe94..2c93a2e66c8a 100644
> --- a/drivers/staging/vt6656/device.h
> +++ b/drivers/staging/vt6656/device.h
> @@ -77,8 +77,6 @@
>  #define FIRMWARE_NAME			"vntwusb.fw"
>  #define FIRMWARE_CHUNK_SIZE		0x400
>  
> -#define CONFIG_PATH			"/etc/vntconfiguration.dat"
> -
>  #define MAX_UINTS			8
>  #define OPTION_DEFAULT			{ [0 ... MAX_UINTS - 1] = -1}
>  
> 


-- 
~Randy

