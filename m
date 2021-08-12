Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A6E3EA2A1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 12:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236521AbhHLKBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 06:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236458AbhHLKAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:00:52 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643D0C0613D3;
        Thu, 12 Aug 2021 03:00:27 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id n6so9710267ljp.9;
        Thu, 12 Aug 2021 03:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jYxtYofaGMDRnCOvMLiIQdoApxEkmLE6s0Nqc2Nq0iQ=;
        b=KAGtdPD3QipmQjQKmbVsYcAT9QGWsqJ5Qog40OyNchP7QVtpff4taRJGnNUxqO2Ykh
         4epWeZRo6AKMFcq0cGUfYHjk6E7AKU42axe09nfdPPkeSsReEnz51uA/361iqmB/g91O
         YiftfWNIt68MBqlvU88l3VIy2IoXB43QXdUn0AQtBMnoZNo6Vkx1pnUPjUE1cvKE26nc
         wj5/vHzxbiouGMjoSWTsyM4M0MNA2ZGiKJb/1FCDOHY2MXYjx7Qxzp7SFIynJeGZHlVn
         8/MHK2+dVb1/ApWMeuIThnS7FenTzqzvC0QrLelz0p75RV6DIUXp/9X/3zw/+3h6ESOt
         bjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jYxtYofaGMDRnCOvMLiIQdoApxEkmLE6s0Nqc2Nq0iQ=;
        b=YLc/Lf0RMUIQ7PL9MCSKbX55DfS9PNZwaq/K8GGJ+bBYpRNzAOrYZlo7Pgj6pg/lJ5
         YSxpINf3h90Uj0dFrvUNYg0VVQJlScXCODY8xcZxtxfySrMwAw4HKwb6UMCfuch0UTVo
         J21CU0Ui+4TQ5OJ1+a0YPemWZoeqeBikkVhTy8mXsbtGW1IxMuVK/xAMK0B5Erb3X1Hn
         Lvup7/hxRXriD1RwHl5cViswnlVv/ex9uAhU3n8a9DLlnQLELL/JLXUrzalI8XeuIUHH
         or+0tsXVd9iHo2J5f5B7fK8pFJU8GqpaJtZnj7YV7KhhNFhrfjCz18COB7aUbBND2mYd
         bsSw==
X-Gm-Message-State: AOAM531f/iQY8fFLi4iK/t2eJWYYyW+hwew1X1DjsL4Qh8t9+mLmIPGv
        x57JjMR4eMTB41PEnSjAqanSLKH09n0=
X-Google-Smtp-Source: ABdhPJyGkL5YNsFpuCBCJcMQJnhiH8/botxRqC7BC54dBFKaqbAXb/ZX1lGs8xMyATZitzEimc/qHg==
X-Received: by 2002:a05:651c:160b:: with SMTP id f11mr2390108ljq.496.1628762424677;
        Thu, 12 Aug 2021 03:00:24 -0700 (PDT)
Received: from [192.168.1.100] ([31.173.82.69])
        by smtp.gmail.com with ESMTPSA id x14sm256336ljj.47.2021.08.12.03.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 03:00:24 -0700 (PDT)
Subject: Re: [PATCH] [v2,1/1] This aims to support Foxconn SDX55
To:     Slark Xiao <slark_xiao@163.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210811085635.4699-1-slark_xiao@163.com>
 <c62d60aa-2e2d-8465-b0d9-e2409ef4de5a@gmail.com>
 <4e38db09.53c.17b37e7bc99.Coremail.slark_xiao@163.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <1a4fb2d3-23f3-0b50-bce2-3ad45495027d@gmail.com>
Date:   Thu, 12 Aug 2021 13:00:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <4e38db09.53c.17b37e7bc99.Coremail.slark_xiao@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 12.08.2021 4:08, Slark Xiao wrote:

> HI Sergei,
>    Yes. Our produt has 3 mode: PCIe mode only, USB mode only, and PCIE+USB.
>    When we need to reproduce some crash issue, we will let it enter into 
> PCIE+USB mode.
>    In this scenario, USB would have a diag port to capture memory dump.

    That's all fine, I was just pointing out the typo. :-)
    Couldn't open your another reply...

> At 2021-08-11 18:58:09, "Sergei Shtylyov" <sergei.shtylyov@gmail.com> wrote:
>>Hello!
>>
>>On 11.08.2021 11:56, Slark Xiao wrote:
>>
>>> Foxconn SDX55 T77W175 device is working in PCIe mode normally.
>>> You can find it in drivers/bus/mhi/pci_geneirc.c file.
>>
>>    pci_generic? :-)
>>
>>> But in some scenario, we need to capture the memory dump once it crashed.
>>> So a diag port driver is needed.
>>> 
>>> Signed-off-by: Slark Xiao <slark_xiao@163.com>

[...]

MBR, Sergei
