Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828553F9402
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 07:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbhH0FW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 01:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhH0FWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 01:22:24 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79392C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 22:21:35 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s3so9328008ljp.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 22:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0p6vTDOyfqxWKW7a1GMUzTnoosuYrgMBPc/iRd7p3L8=;
        b=tm4oLmjCTB0m7p++ZI2HJ48pqub0621+hbPq1+hwqUiuL7NFVMSbvFMV0L4N2jDNfg
         0c668OeaKkYrsHEwzDB1vFs6VdXKkvescMwx9CgCsVOqamMULrOTaWTUqENC7roe2Gcg
         oplWmskS1IwrvrE3XxHvSq904mQc7wreQZIxoYh4sdScaee8h8Nx983X1/BVOtfWRSaO
         UyuQrMPtWeBRTKXyWpBPjy1vyW9oBp27EU5n4lsfaHEhLWyJyqOv4SV1DeLgRunWvmtf
         KjOv071+3S7qGJsVVweMfCF+y7nnvad/PJAdxwwTXW8EBKbVO0FFa6pR4I0pNFNKj2m+
         U4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0p6vTDOyfqxWKW7a1GMUzTnoosuYrgMBPc/iRd7p3L8=;
        b=CFqsRATWYUx53otQOVWUnBBMAmYjPZSN/ltTA+TEPLLalNHH+FN0p9btZsdCFujQIJ
         6buw7fs+sSTWalRhjUrdN+IYdh/t918+HAh9FhA09f0zK5Zc4jtCh4GK62zZFLle6SKd
         cn9sQxVOZ8IG9oC3NTjWBGPRCYjsOddBMArZHyAakb+ZO7PYWiofFiwyTVLF2wQfDPAh
         c+mrec/bbErN+MV0u7pP/e3irr0Iy7eyyS00lST5GgBEq8cK8qPwXYR7tG8MmnIeaff1
         wNxuwdFfj4d2wpo2Hn3qH287R5MqlFT92XGqw5hCSnJu8ZGtfKa4hbGNU5sNl9p8P1D6
         uO0g==
X-Gm-Message-State: AOAM53132AQ47v8gv0kklKXPkdTfBOND/k1D8psGI3QRktYgiDPOhMOl
        DUlwBmKkNdV4KVMuXIN52NeMh/rzwwk=
X-Google-Smtp-Source: ABdhPJyz35lV+9ek1HRpaCyOdDZacdhUU7+DaZE6w9ytkdBRUYia/iHFrwOSMyfTIO2KxSc0ZKSWtw==
X-Received: by 2002:a2e:87c4:: with SMTP id v4mr6205790ljj.444.1630041693739;
        Thu, 26 Aug 2021 22:21:33 -0700 (PDT)
Received: from [192.168.2.145] (94-29-17-251.dynamic.spd-mgts.ru. [94.29.17.251])
        by smtp.googlemail.com with ESMTPSA id x6sm532223lfu.220.2021.08.26.22.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 22:21:33 -0700 (PDT)
Subject: Re: [PATCH v2] platform/chrome: cros_ec_trace: Fix format warnings
To:     Gwendal Grignou <gwendal@chromium.org>, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org
References: <20210825181802.2838484-1-gwendal@chromium.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9d000f0c-ef4a-e92a-44ee-6a887d45f70b@gmail.com>
Date:   Fri, 27 Aug 2021 08:21:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210825181802.2838484-1-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.08.2021 21:18, Gwendal Grignou пишет:
> Fix printf format issues in new tracing events.
> 
> Fixes: 814318242 ("platform/chrome: cros_ec_trace: Add fields to command traces")
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes since v1:
> - Use %u instead of %d for ec timestamp, it is presented as a u32.
> 
>  drivers/platform/chrome/cros_ec_trace.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_trace.h b/drivers/platform/chrome/cros_ec_trace.h
> index f50b9f9b8610..9d0c848af310 100644
> --- a/drivers/platform/chrome/cros_ec_trace.h
> +++ b/drivers/platform/chrome/cros_ec_trace.h
> @@ -92,7 +92,7 @@ TRACE_EVENT(cros_ec_sensorhub_timestamp,
>  		__entry->current_time = current_time;
>  		__entry->delta = current_timestamp - current_time;
>  	),
> -	TP_printk("ec_ts: %12lld, ec_fifo_ts: %12lld, fifo_ts: %12lld, curr_ts: %12lld, curr_time: %12lld, delta %12lld",
> +	TP_printk("ec_ts: %9d, ec_fifo_ts: %9u, fifo_ts: %12lld, curr_ts: %12lld, curr_time: %12lld, delta %12lld",

ec_ts unsigned

>  		  __entry->ec_sample_timestamp,
>  		__entry->ec_fifo_timestamp,
>  		__entry->fifo_timestamp,
> @@ -122,7 +122,7 @@ TRACE_EVENT(cros_ec_sensorhub_data,
>  		__entry->current_time = current_time;
>  		__entry->delta = current_timestamp - current_time;
>  	),
> -	TP_printk("ec_num: %4d, ec_fifo_ts: %12lld, fifo_ts: %12lld, curr_ts: %12lld, curr_time: %12lld, delta %12lld",
> +	TP_printk("ec_num: %4d, ec_fifo_ts: %9u, fifo_ts: %12lld, curr_ts: %12lld, curr_time: %12lld, delta %12lld",

ec_num unsigned

