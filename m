Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFB4427C51
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 19:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhJIRUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 13:20:37 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:49554
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229928AbhJIRUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 13:20:36 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3B6133FFEC
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 17:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633799912;
        bh=6vTs51Lr8vLHY4n076CsFn/gLEdhdBV/K1u6U6+j1dg=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=qU7kRu1ooq4DiwA76+/cW2PhNcRR9JSQH2Pyh1nz9vUVYJQHnPri3eqLhDqVztGh0
         SqIYN1OTjQ/BLOTfr0CQ/sq+NFQonvitWDBcYa975ksICmfdLVBaT1nku9PLe43xNG
         YmRUUDXVkSMbVWovpR+wf331cdjHT79W1mvWaWezubEBiCFAWcBMUQRPYop6GGsWNd
         ova3UFfrL+ayOz/SfX4tdoNvQbU/U67UskWzQAanPe9mQyDgeOP5aYQczEVksAcxE0
         vhWs2eNrZvhKxFsl8jpw7p/kbwv4/wwfWvv2JYY758Jx/M3LCeH9g3apYHCY7B4iGm
         IbMxmkC7CBceQ==
Received: by mail-ed1-f72.google.com with SMTP id e14-20020a056402088e00b003db6ebb9526so2353502edy.22
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 10:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6vTs51Lr8vLHY4n076CsFn/gLEdhdBV/K1u6U6+j1dg=;
        b=kVVqaOLLp8ApebM5/7UGSHm8m9xvXKIbG33IK9dNFWfLx66bRFiU6t8Q7Czf3uJY1T
         uVDR9DXQ3tnLZQgXEiJHq2jgAfN4SdnDq999+xbLBc1dcRCKhGo3Ekfthrv1Zja6HOdV
         350odZbBndl4sF7NZ1NAMI2TRzqi0qSeLHMDZHjCt9+wO4KOwFpUscMC4V4MpEDNoLBI
         AmiayMIochdl3kxyGar6ztq7fy4IBQawJfNPOmgFrsEgnYp1SZ2L6nD55//NNYoreVsA
         ht1cblX6JQvCHdI89/1j016Zp2ConIK+N2Dy6Q5Vtg2PGoSgHg4YhCSsYWZnUbcXL0mS
         KeXA==
X-Gm-Message-State: AOAM533TmDsMgagwG+nEzfyn/uNl5fvZnc9/UP14YP92KysZEJAMBPRM
        ifYYOF1h8K9pATHNwpxPnsv/IMBRS4dyDG2oadEBV+71ikcMICINsDnznsfXq8Qur7FjnMOx4Z7
        U2GupeliSERCALPjILLI464Gf035dRUPJHyRyBuGqmQ==
X-Received: by 2002:a17:906:2ccf:: with SMTP id r15mr12596556ejr.182.1633799911927;
        Sat, 09 Oct 2021 10:18:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTFK3yvDCh4cP+YD8IAgX0mwfVS3GVAk+kiNZrMFqKNDBoZ+Nedcqb9ctSXXgWuVyyuZbFrw==
X-Received: by 2002:a17:906:2ccf:: with SMTP id r15mr12596540ejr.182.1633799911789;
        Sat, 09 Oct 2021 10:18:31 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y19sm321830edd.39.2021.10.09.10.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 10:18:31 -0700 (PDT)
Subject: Re: [PATCH] power: supply: max17040: fix null-ptr-deref in
 max17040_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     sre@kernel.org, iskren.chernev@gmail.com
References: <20211008063150.822066-1-yangyingliang@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <394b0984-50a6-af80-195b-033bf9624dea@canonical.com>
Date:   Sat, 9 Oct 2021 19:18:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211008063150.822066-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/2021 08:31, Yang Yingliang wrote:
> Add check the return value of devm_regmap_init_i2c(), otherwise
> later access may cause null-ptr-deref as follows:
> 
> KASAN: null-ptr-deref in range [0x0000000000000360-0x0000000000000367]
> RIP: 0010:regmap_read+0x33/0x170
> Call Trace:
>   max17040_probe+0x61b/0xff0 [max17040_battery]
>  ? write_comp_data+0x2a/0x90
>  ? max17040_set_property+0x1d0/0x1d0 [max17040_battery]
>  ? tracer_hardirqs_on+0x33/0x520
>  ? __sanitizer_cov_trace_pc+0x1d/0x50
>  ? _raw_spin_unlock_irqrestore+0x4b/0x60
>  ? trace_hardirqs_on+0x63/0x2d0
>  ? write_comp_data+0x2a/0x90
>  ? __sanitizer_cov_trace_pc+0x1d/0x50
>  ? max17040_set_property+0x1d0/0x1d0 [max17040_battery]
>  i2c_device_probe+0xa31/0xbe0
> 
> Fixes: 6455a8a84bdf ("power: supply: max17040: Use regmap i2c")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/power/supply/max17040_battery.c | 2 ++
>  1 file changed, 2 insertions(+)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
