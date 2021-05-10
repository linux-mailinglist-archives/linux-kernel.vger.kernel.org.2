Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB9337906E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbhEJORc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:17:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46433 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241990AbhEJOOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:14:11 -0400
Received: from mail-qt1-f197.google.com ([209.85.160.197])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lg6eg-00049e-FU
        for linux-kernel@vger.kernel.org; Mon, 10 May 2021 14:13:06 +0000
Received: by mail-qt1-f197.google.com with SMTP id e28-20020ac84b5c0000b02901cd9b2b2170so10506756qts.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 07:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yHK+cQr8MhVm2w7dksdyD//Uz1iT2UJzqYpI2qAr1FI=;
        b=OFV725ckbn1qUNdT7RT8rBi1xJDFKdLOc+wJMgaSXSB+eN4mC+zeU3hJ4hd6CfYeRf
         rQu9XAN2kw524tWe1pQHNdaOIMLOVpIIYq9d3AZ6vThFUmA5bJJCffRbb8oYxkbQwkV8
         vSu8TbzxYJGGDlHjh8VQVleJEpcYaydj8Vre5+yBHLpoEaPuudncpoxyPsC2sa7xGsiV
         pifuAbrEuS+7jytIKE75iKUYfKpVNavW2OrE3j6XevM25eKvlRq9G4PAu/qOyRG9/mOn
         2AbsyfvG1AR5Abb4ph8ZXYkrxag9L7FofFMIW3JqDVvyIwjHaxrVq8UEDwQA8JiUhgp4
         ihmg==
X-Gm-Message-State: AOAM531WaxqHedskWZxn+ztZb2ASObUGZDsQmufGmyTJJJBnV4doPso9
        qkc91pKz10+xmE8VdjGV57d236VAOypgykaT3HZx3U2qWGxzEO/SmG5MfrvJIjYR6rTanElfr80
        23J70azmIiXSaUxaBtrMs5yXoDgbvKV1fuzyyVNFfbg==
X-Received: by 2002:ad4:46a9:: with SMTP id br9mr23481794qvb.35.1620655985334;
        Mon, 10 May 2021 07:13:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/TofY+XlduMi5T79Lk3yk44+wBaFq1AMtF3DneP6jD4ViCnAcK0LiJUs5mEdc7LO86ewL+A==
X-Received: by 2002:ad4:46a9:: with SMTP id br9mr23481784qvb.35.1620655985223;
        Mon, 10 May 2021 07:13:05 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.49.2])
        by smtp.gmail.com with ESMTPSA id g9sm3356087qka.38.2021.05.10.07.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 07:13:04 -0700 (PDT)
Subject: Re: [PATCH 2/4] extcon: extcon-max14577: Fix potential work-queue
 cancellation race
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
References: <cover.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
 <70dfbe28725bac3383f77d02037f4f7f37839989.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <9a706f57-6c2a-6680-e24b-ff00fe15b95f@canonical.com>
Date:   Mon, 10 May 2021 10:13:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <70dfbe28725bac3383f77d02037f4f7f37839989.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2021 04:11, Matti Vaittinen wrote:
> The extcon IRQ schedules a work item. IRQ is requested using devm while
> WQ is cancelld at remove(). This mixing of devm and manual unwinding has
> potential case where the WQ has been emptied (.remove() was ran) but
> devm unwinding of IRQ was not yet done. It is possible the IRQ is triggered
> at this point scheduling new work item to the already flushed queue.
> 
> Use new devm_work_autocancel() to remove the remove() and to kill the bug.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> 
> Please note that the change is compile-tested only. All proper testing is
> highly appreciated.
> ---
>  drivers/extcon/extcon-max14577.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 

I don't have the HW anymore for this testing, but looks good:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
