Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C432D4406CE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 03:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhJ3Br7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 21:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhJ3Br6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 21:47:58 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4F6C061570;
        Fri, 29 Oct 2021 18:45:29 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id bp7so5957873qkb.10;
        Fri, 29 Oct 2021 18:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iNQ0++hmy0A6R3WdtnuMuf9ZRK3yKg0+/OsDBDaHLUw=;
        b=aypbOqafFEourQou7KVhHk7s2A3iyPBWtMWL8dYUtRY1LUJgt+bS+ENIN2tBL7ZrxF
         GnGgPge5Zadb2aTYhoSANZjzVPKCraUgYPVoovRkXpKS8d/KJeUrX/l034nnUDWsTFDH
         z4hY+7RhXcIuhVWJa12MiJb3OxSDKOQkHA4AvohJOpmdyxoNGN+v06nSS52NUjFp4HXd
         H+B06ihPBoNV9uthwRZxosTkK/Aa7dKEght6dfF6DK3zwTPKhN/ItZ3cFF9h4FxDk//H
         l0vA5Pqv/5QwVjMfBjN+3PG87tSsWBkv0XaDwpBagpDGWqVu5YEnN9SP6Rw69LYhjCWH
         toUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iNQ0++hmy0A6R3WdtnuMuf9ZRK3yKg0+/OsDBDaHLUw=;
        b=I9cINYyUhp4JTcZXUc5qJdS8RAMbn2Q8O8wvvTP+06zMNd3C47jmMuzplaRHWjnsnL
         P4JVg5nTK1j8Cy8ub13nQr5af/lhaOf2rfwlpuQCNKRvzHSAvGYadlSH3QjXn/nHI89Z
         fYiHfKItxX+WsPDuC5obXBFTH1LYUokQsjYtFxXuVKPnpXqtcTw0VcUUWRA8HazgxWL+
         z3QZ7zUDvWqunWafV3PNhM732nk/4fuUhh3xnZqUDcq5lf1F/2FYUTuOu3OthbTSCHkT
         /A+NicZDMh+N3Or4iFQDiAVElPiRIjx67lQWdgllPA9IiyiuHYkoGu9xnpC+BgUuoADg
         XADg==
X-Gm-Message-State: AOAM531rN5MXBI2vk6C+zA2AvJx+v78b5yU4O+FeUmnMb9b2jWL6N32J
        XpKCNH/gg+Tl30w1hWyZlEs=
X-Google-Smtp-Source: ABdhPJyqHJXkjHfPFqLXj+W310DuAE7tkqY5CwBlO9pBcSJCtFVkE7f75XNwlHmyolK6IRuRemfHRg==
X-Received: by 2002:a05:620a:bd6:: with SMTP id s22mr11451090qki.306.1635558328632;
        Fri, 29 Oct 2021 18:45:28 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id b193sm3098436qkg.3.2021.10.29.18.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 18:45:28 -0700 (PDT)
Subject: Re: [PATCH v2] of/unittest: Disable new dtc
 node_name_vs_property_name and interrupt_map warnings
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20211028130423.4025578-1-robh@kernel.org>
 <ab53d658-aeec-7606-3089-3b1e8b299138@gmail.com>
Message-ID: <23f6c4f5-531d-56e1-1d68-305c37c01510@gmail.com>
Date:   Fri, 29 Oct 2021 20:45:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ab53d658-aeec-7606-3089-3b1e8b299138@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/21 8:12 PM, Frank Rowand wrote:
> Hi Rob,
> 
> On 10/28/21 8:04 AM, Rob Herring wrote:
>> The unittest dtbs have various intentional errors which cause warnings.
>> With the latest dtc sync to v1.6.1-19-g0a3a9d3449c8, we need to disable
>> some new checks: node_name_vs_property_name and interrupt_map warnings.
>> These warnings are also generated for static_base_1.dtb, so add
>> DTC_FLAGS for it.
>>
>> Note that the interrupt_map warnings only appear once interrupt_provider
>> warning is re-enabled globally.
>>
>> drivers/of/unittest-data/tests-interrupts.dtsi:32.26-35.6: Warning (interrupt_map): /testcase-data/interrupts/intmap1: Missing '#address-cells' in interrupt-map provider
>>
>> Fixes: e76187b9792e ("scripts/dtc: Update to upstream version v1.6.1-19-g0a3a9d3449c8")
>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> Cc: Frank Rowand <frowand.list@gmail.com>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>>  drivers/of/unittest-data/Makefile | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
>> index a5d2d9254b2c..fbded24c608c 100644
>> --- a/drivers/of/unittest-data/Makefile
>> +++ b/drivers/of/unittest-data/Makefile
>> @@ -37,7 +37,9 @@ DTC_FLAGS_overlay_base += -@
>>  DTC_FLAGS_testcases += -@
>>  
>>  # suppress warnings about intentional errors
>> -DTC_FLAGS_testcases += -Wno-interrupts_property
>> +DTC_FLAGS_testcases += -Wno-interrupts_property \
>> +	-Wno-node_name_vs_property_name \
>> +	-Wno-interrupt_map
>>  
>>  # Apply overlays statically with fdtoverlay.  This is a build time test that
>>  # the overlays can be applied successfully by fdtoverlay.  This does not
>> @@ -82,6 +84,10 @@ apply_static_overlay_1 := overlay_0.dtbo \
>>  
>>  apply_static_overlay_2 := overlay.dtbo
>>  
>> +DTC_FLAGS_static_base_1 += -Wno-interrupts_property \
>> +	-Wno-node_name_vs_property_name \
>> +	-Wno-interrupt_map
>> +
>>  static_test_1-dtbs := static_base_1.dtb $(apply_static_overlay_1)
>>  static_test_2-dtbs := static_base_2.dtb $(apply_static_overlay_2)
>>  
>>
> 
> Thanks for splitting the DTC_FLAGS into per file values.
> 
> I dug into the unittest code that uses the dts node that causes the
> interrupt map warning and do not see any reason not to fix the dts
> so that the warning will not occur, instead of masking it with
> the DTC_FLAGS.  I just now submitted a patch to fix the .dtsi at
> 
>   https://lore.kernel.org/all/20211029005802.2047081-1-frowand.list@gmail.com/

That thread ended up deciding that the .dtsi should not be fixed to
avoid the warning (it was a deliberate error to allow a specific test),

so for the [v2] patch that started this thread:

Reviewed-by: Frank Rowand <frowand.list@gmail.com>
Tested-by: Frank Rowand <frowand.list@gmail.com>

> 
> -Frank
> 

