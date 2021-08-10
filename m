Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266AA3E58B0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbhHJK5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236996AbhHJK5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:57:44 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4D2C061798
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 03:57:22 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g138so909630wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 03:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tYhapPe5H4mgp99/xIK0U3JAgB8Az9f2F1V7ARndpoI=;
        b=AhB9IzC8N70Gkz+16zkOwjsZF/JBPizz4JhvEBW8U0aZ6Wi5VbDm8loljB0HEFNPoq
         AvzkUISNyWFs/12scBaSXcdcHM0WRbYHdkbvvPy6CTQ0D2RhIJuRRabU4QizyWpgkAMv
         M4rdVgbR9O0/GV+/cUKoRJTWKvA9wUlW/RSfip2F9BCutzu9neQgm5LhhMro6IaUURRT
         g3g3vR5m+ilAjyMo2VNDgldGvH6jkjyW59laaO0TQXlGmqlo1etTkHVlQnJeNA8DePRi
         sInHmvZlz6RwYdOqXbmADv7YCBgHjBCTOwokBMFXbtRyvKypW1X3kM0EUkCQN2py0KuZ
         62Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tYhapPe5H4mgp99/xIK0U3JAgB8Az9f2F1V7ARndpoI=;
        b=EFBvkV5XHpyoO3Ko3EOuHW2VggNLsdnHcNXj4LBiiCTKKxtMrV2b+8KfdSow2BAYpv
         9jd/0XVlSfpOFQCRJKMbTnIq7TUyiX+C9MRkwbeKw/z3nq66TU8gqQ2bSKr9sOgvaiQo
         4NbI83ibLPkvgu4cnTZaoKfNGZf89ncPUJBWDAR13id7lllDaFq+6kdMjM4NpmbKTLJJ
         Y/jo8ffQk3gbtxx3lGFOnIQtll32XE3JSG43/xIn/Eo5kz77a3DARfoM77TIKnpLP3n0
         j11dwvUnKt4houJqyyLOdDdYbxhrQqamw1P/M32whtHi+V2hKa3yhwnpjF7IClCf0/Iz
         VNMQ==
X-Gm-Message-State: AOAM532o9CFWn5AwQro1A/TDAk2t1vBRIpQBHCa4Keg+RRLofLV17RR/
        Z4hpb1FmXSQkis92O33vt+5IWToVhohetw==
X-Google-Smtp-Source: ABdhPJx+VZCy4y7O0qYRDJKBrvGIBsNubqdg/hBRfB6E8JiB0w1awHjnpL/wVPnZe4LlEaivmn3SVg==
X-Received: by 2002:a7b:c7d7:: with SMTP id z23mr21542255wmk.136.1628593040855;
        Tue, 10 Aug 2021 03:57:20 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id q17sm925952wrr.91.2021.08.10.03.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 03:57:20 -0700 (PDT)
Subject: Re: [PATCH v4 0/5] nvmem: nintendo-otp: Add new driver for the Wii
 and Wii U OTP
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Rob Herring <robh+dt@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Cc:     Ash Logan <ash@heyquark.com>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.ne@posteo.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
References: <20210701225743.14631-1-linkmauve@linkmauve.fr>
 <20210801073822.12452-1-linkmauve@linkmauve.fr>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <cd854a84-7fd3-38bd-5a28-9306867a990f@linaro.org>
Date:   Tue, 10 Aug 2021 11:57:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210801073822.12452-1-linkmauve@linkmauve.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/08/2021 08:38, Emmanuel Gil Peyrot wrote:
> The OTP is a read-only memory area which contains various keys and
> signatures used to decrypt, encrypt or verify various pieces of storage.
> 
> Its size depends on the console, it is 128 bytes on the Wii and
> 1024 bytes on the Wii U (split into eight 128 bytes banks).
> 
> It can be used directly by writing into one register and reading from
> the other one, without any additional synchronisation.
> 
> This series has been tested on both the Wii U (using my downstream
> master-wiiu branch[1]), as well as on the Wii on mainline.
> 
> [1] https://gitlab.com/linkmauve/linux-wiiu/-/commits/master-wiiu
> 
> Changes since v1:
> - Fixed the commit messages so they can be accepted by other email
>    servers, sorry about that.
> 
> Changes since v2:
> - Switched the dt binding documentation to YAML.
> - Used more obvious register arithmetic, and tested that gcc (at -O1 and
>    above) outputs the exact same rlwinm instructions for them.
> - Use more #defines to make the code easier to read.
> - Include some links to the reversed documentation.
> - Avoid overlapping dt regions by changing the existing control@d800100
>    node to end before the OTP registers, with some bigger dt refactoring
>    left for a future series.
> 
> Changes since v3:
> - Relicense the dt-binding documentation under GPLv2-only or
>    BSD-2-clauses.
> 
> Emmanuel Gil Peyrot (5):
>    nvmem: nintendo-otp: Add new driver for the Wii and Wii U OTP
>    dt-bindings: nintendo-otp: Document the Wii and Wii U OTP support


Applied 1/5 and 2/5 to nvmem next,
rest of the patches should go via powerpc dts tree.

thanks,
--srini
>    powerpc: wii.dts: Reduce the size of the control area
>    powerpc: wii.dts: Expose the OTP on this platform
>    powerpc: wii_defconfig: Enable OTP by default
> 
>   .../bindings/nvmem/nintendo-otp.yaml          |  44 +++++++
>   arch/powerpc/boot/dts/wii.dts                 |  13 +-
>   arch/powerpc/configs/wii_defconfig            |   1 +
>   drivers/nvmem/Kconfig                         |  11 ++
>   drivers/nvmem/Makefile                        |   2 +
>   drivers/nvmem/nintendo-otp.c                  | 124 ++++++++++++++++++
>   6 files changed, 194 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml
>   create mode 100644 drivers/nvmem/nintendo-otp.c
> 
