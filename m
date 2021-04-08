Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D0435876C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhDHOtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhDHOtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:49:06 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C96C061760;
        Thu,  8 Apr 2021 07:48:54 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id j1so993743qvp.6;
        Thu, 08 Apr 2021 07:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6VjuQCoKbrALyyH2GKbL+5FXnX22zjxdnuwp3TqHzf0=;
        b=EgEoHnUN3M3PHsStjWlk88TN4gRZpFpq0CFSjhMdIUJewhweF/It+9VxwrtIVqMbEL
         f+9VhgI15BoJP+0C9RDjwtIxlip34CyHfu4pc9w0+Qji9J1lvJtQXgJ573a/WNkQ8CL3
         PcKBVyB3jOunlkBKn+zlqr9nrANdQX26o+Nsov9P1hMOlgAyTG9Sfc3/LBQ8ggx7HJKm
         sLP8WADLSzstDf2bnaS4xKbquaO9/U37sPhBV3T9iTsyBJtGD0DsbEIkm7fSeW+mDNBu
         TFXcKZuizgxw/jFY4FTcAPjJfo3BJVrsIrxsK3hbCdugsH+wmk7UPjUaooHEa3Q8eHoR
         TfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6VjuQCoKbrALyyH2GKbL+5FXnX22zjxdnuwp3TqHzf0=;
        b=S7c/ZSxFxKsEVeSMZy1zyEBPnEHA/9aQYU2PkmmcvdGEXsaUe8iX3Bs0Iq8Og5H6Uu
         P377NYigEPpQx0Sd2X9IoEMya5RraZJRy6/mWtFc5gvbcsf7FQ+Mh9vLe58lzIicI2F7
         81hT1DLPJXKQLQG/cMeMYuIsK9G7sShoLb1ptqnuXFIE4q8zP8oiZZrwGfkdejKFQ6Df
         KmksYOZoQG2iwgmJnppB4FfDT0pVIgq7v4XoSr3ybgPo7utK+JoZmO//DtLtwk/Wnjdq
         J32QYlqUjF4cNmWkikrGjsosVkR8DKBI/GbBbcMA1viTubGySfk/g0P81DjblvY6AqO2
         GwHw==
X-Gm-Message-State: AOAM531EjdqgAx+4FJ6IDxeM2IE5RDXPMHCfOlrRC1Tk9hobKxjo0Eto
        G80k7K/Q93cH6V0IR4v0W44=
X-Google-Smtp-Source: ABdhPJxCnuLDXiDrC3hMhC1DPLHedlb5VK/IEx88Y4OQb8vnc1VGXGrSg8r3f1nLoybmhMl5uPpSsw==
X-Received: by 2002:a0c:ff45:: with SMTP id y5mr3188150qvt.36.1617893334061;
        Thu, 08 Apr 2021 07:48:54 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id g6sm21178846qkd.62.2021.04.08.07.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 07:48:53 -0700 (PDT)
Subject: Re: [PATCH 1/1] of: unittest: overlay: ensure proper alignment of
 copied FDT
To:     Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
References: <20210407205110.2173976-1-frowand.list@gmail.com>
 <0851cec1-99d1-7de0-81dc-2c82532dc6f7@gmail.com>
 <09bb81a4-e9e3-8cbf-8c41-c5f0846711ba@roeck-us.net>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <e48ffddd-42a4-0396-0a9a-a007c3d25ce9@gmail.com>
Date:   Thu, 8 Apr 2021 09:48:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <09bb81a4-e9e3-8cbf-8c41-c5f0846711ba@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/21 5:01 PM, Guenter Roeck wrote:
> On 4/7/21 1:59 PM, Frank Rowand wrote:
>> Hi Guenter,
>>
>> On 4/7/21 3:51 PM, frowand.list@gmail.com wrote:
>>> From: Frank Rowand <frank.rowand@sony.com>
>>>
>>> The Devicetree standard specifies an 8 byte alignment of the FDT.
>>> Code in libfdt expects this alignment for an FDT image in memory.
>>> kmemdup() returns 4 byte alignment on openrisc.  Replace kmemdup()
>>> with kmalloc(), align pointer, memcpy() to get proper alignment.
>>>
>>> The 4 byte alignment exposed a related bug which triggered a crash
>>> on openrisc with:
>>> commit 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9")
>>> as reported in:
>>> https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/
>>
>> Can you please test this patch?
>>
> 
> Sure, will do, after you fixed the problem pointed out by Rob.
> 
> Sorry, I should have mentioned it - that problem was the reason
> why I didn't propose a fix myself.

No problem, I was aware of the issue but then spaced on actually
dealing with it.

- Space Cadet Frank

> 
> Guenter
> 

