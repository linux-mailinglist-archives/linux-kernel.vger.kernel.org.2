Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8CD360F16
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 17:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbhDOPh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 11:37:59 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:42497 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhDOPhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 11:37:38 -0400
Received: by mail-pl1-f169.google.com with SMTP id w8so9940748plg.9;
        Thu, 15 Apr 2021 08:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a8rtqGj6DddCpHF5nNlZPwGIng9Wf32Y0rfcCg7Hsvw=;
        b=OfyRoSsnjFd2kc4B1xxW+SFDqX+7v3H6EDKmHlKPLM1D2OR+xsQ6H4HifEJwLib4be
         tUKbIluL3dPPB3I1wDC4H4WsibdAJqJmjQP/wyV/5dZDYEedVq7HzTqP6I6HR7oExsTv
         vYQaH5sqLi3ksmmsF811/nAk9Fvak4Qv/ip1beZQ6XIug2S3qwgASZ56WPmKTWuq2sFQ
         wqJO9mzZ48cCR929AeBIK5ats+yRzNmLiwspSNFxvSfy4CQRxwNWjdybPsRR8afLyf7q
         KT7x27VIA9JqBIG96JsN0TApdyXAF36EEXoucpQGaPm/JJuB5xhB3D3PLJ7GOSFrhuuR
         bO7A==
X-Gm-Message-State: AOAM5328jjBrZYmPW44ezgFEkuiMlfqefn314Z2Cpccnlq16bZRC4Zdf
        7gzsZUiXDf2+8vEvXNpGL/g7EJ6UTj0=
X-Google-Smtp-Source: ABdhPJxnCKVtL5N0uBYOwWSbCVPc3NwNH5zjj+7W/67FbYxRs+hThpnJ7iV7DwSGe8jffZZNpE3G8g==
X-Received: by 2002:a17:90b:88f:: with SMTP id bj15mr4616984pjb.147.1618501033095;
        Thu, 15 Apr 2021 08:37:13 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:f031:1d3a:7e95:2876? ([2601:647:4000:d7:f031:1d3a:7e95:2876])
        by smtp.gmail.com with ESMTPSA id f2sm2565595pfe.177.2021.04.15.08.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 08:37:12 -0700 (PDT)
Subject: Re: [PATCH] block: remove unused function
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1618475975-106537-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <defd9b0d-9ec7-2259-6f67-83bd8cd47973@acm.org>
Date:   Thu, 15 Apr 2021 08:37:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <1618475975-106537-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/21 1:39 AM, Jiapeng Chong wrote:
> Fix the following clang warning:
> 
> block/blk-zoned.c:55:24: warning: unused function 'blk_zone_start'
> [-Wunused-function].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  block/blk-zoned.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index c0276b42..250cb76 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -52,14 +52,6 @@ const char *blk_zone_cond_str(enum blk_zone_cond zone_cond)
>  }
>  EXPORT_SYMBOL_GPL(blk_zone_cond_str);
>  
> -static inline sector_t blk_zone_start(struct request_queue *q,
> -				      sector_t sector)
> -{
> -	sector_t zone_mask = blk_queue_zone_sectors(q) - 1;
> -
> -	return sector & ~zone_mask;
> -}

A similar patch is already in Jens' for-5.13/block branch. See also
commit 540ad3f3da25 ("blk-zoned: Remove the definition of
blk_zone_start()").

Bart.
