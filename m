Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FACB3D54FE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 10:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbhGZHZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 03:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbhGZHZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:25:36 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FF8C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 01:06:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b7so9953282wri.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 01:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HKcRDyROSUfmhioHNtTU2vbTLt65NepdrupybIKsatE=;
        b=QWtDTo3PH9OIra/tbq5G0k8/bcuONoStvRoeIx6dl2igAeFjuivveZV9iQHyxdCIil
         Yn87o5dx66AOK8DjSJLRYGv8kl/TNDv31M+u2yAeTFX9NTjmAKAlFBdDTA9MsgYVivc9
         IZ6qUhkKEbF9U/2cba3Y5ToX/bdVSJMXaDes/IWeeJ7pgqxPqERJ7P38cZDcbFAXQKkT
         TSVeBIm5MXTamyxlcDLOZd9NFPtfoxJ7wGwLaKEGKTxd0cOagvDZ28ld3FOrBrJzGRsR
         Mzw1gb4HnK0AlAop1zvF3lalWxQrJFgZvRDXpI/CfBxGMV3gFyP6sHADkL7mOhyr+TRS
         1ufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HKcRDyROSUfmhioHNtTU2vbTLt65NepdrupybIKsatE=;
        b=eBQtbT3X9hg1vegVZSv2jUf/COFVUDDr4e8Z4OHsfvBiL0V1M2cZVEDoSWpNDO4IWZ
         Fnyu7zStaJTmQBb3oMUyZHAzQDEgj3MiugOtcAQA5EvFXGM91jBd3NSvfxxv7leG8gp5
         aslwfMUguEyYUEQKuVSIpzx6YEHxEjLIBpVYYuvWcVBeNhR/F39vetX/7MqcnxYlY9Bg
         wStIlnu24co6ItvJwPc83aBO8sWDx/CbbgJCWCdGlJ29RazhVRizzQe2tjgzGjF3RZL0
         ar6GiAmy694WNV9T7XrthQP4gcjG8Fdc1jHM0BssFJFx2I6Smhgek2B5T771e5DpI9Yf
         IdOQ==
X-Gm-Message-State: AOAM530hhPwijQgnbtr0umWLlLdFnx2uXAwLTwECBadeuexhWLVsBuwO
        V//NkLD2xXMCdixuT17OiDl6uw==
X-Google-Smtp-Source: ABdhPJwi40vXErY3FPEwP7VEauGhUJFLjrSL3ftinSAJ2+sp3LZXXwk1xmJgrYPBvmvoSrhtCou9xQ==
X-Received: by 2002:adf:db85:: with SMTP id u5mr17884676wri.167.1627286763668;
        Mon, 26 Jul 2021 01:06:03 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:32b6:aa71:d2df:4f1d? ([2001:861:44c0:66c0:32b6:aa71:d2df:4f1d])
        by smtp.gmail.com with ESMTPSA id d10sm41243990wro.43.2021.07.26.01.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 01:06:03 -0700 (PDT)
Subject: Re: [PATCHv2 1/3] ARM: dts: meson8b: odroidc1: Fix the pwm regulator
 supply properties
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Anand Moon <linux.amoon@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org
References: <20210705112358.3554-1-linux.amoon@gmail.com>
 <20210705112358.3554-2-linux.amoon@gmail.com>
 <CAFBinCDaiu-tuo654_UTmxb0yeqQ8YqxCC7oVxq1EU4AmQRQdA@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <f07da67e-3d67-85a5-699d-d528212a867f@baylibre.com>
Date:   Mon, 26 Jul 2021 10:06:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCDaiu-tuo654_UTmxb0yeqQ8YqxCC7oVxq1EU4AmQRQdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/07/2021 14:58, Martin Blumenstingl wrote:
> On Mon, Jul 5, 2021 at 1:25 PM Anand Moon <linux.amoon@gmail.com> wrote:
>>
>> After enabling CONFIG_REGULATOR_DEBUG=y we observer below debug logs.
> I think there's a typo here: observer -> observe
> maybe Kevin or Neil can fix this up (in this and the following two
> patches) while applying the patch so you don't have to re-spin a v3

Fixed while applying !

> 
>> Changes help link VCCK and VDDEE pwm regulator to 5V regulator supply
>> instead of dummy regulator.
>>
>> [    7.117140] pwm-regulator regulator-vcck: Looking up pwm-supply from device tree
>> [    7.117153] pwm-regulator regulator-vcck: Looking up pwm-supply property in node /regulator-vcck failed
>> [    7.117184] VCCK: supplied by regulator-dummy
>> [    7.117194] regulator-dummy: could not add device link regulator.8: -ENOENT
>> [    7.117266] VCCK: 860 <--> 1140 mV at 986 mV, enabled
>> [    7.118498] VDDEE: will resolve supply early: pwm
>> [    7.118515] pwm-regulator regulator-vddee: Looking up pwm-supply from device tree
>> [    7.118526] pwm-regulator regulator-vddee: Looking up pwm-supply property in node /regulator-vddee failed
>> [    7.118553] VDDEE: supplied by regulator-dummy
>> [    7.118563] regulator-dummy: could not add device link regulator.9: -ENOENT
>>
>> Fixes: 524d96083b66 ("ARM: dts: meson8b: odroidc1: add the CPU voltage regulator")
>> Fixes: 8bdf38be712d ("ARM: dts: meson8b: odroidc1: add the VDDEE regulator")
>>
>> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 

Neil
