Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315AA327811
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 08:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhCAHJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 02:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbhCAHIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 02:08:13 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F253EC061756
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 23:07:29 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id b13so10041959edx.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 23:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DYtRy3yB5Mwslt+yJOER3GwxZYF8eTP3aAHJxAyC5bg=;
        b=PAE89XNRN4JmSZ+dGX+cOFaS5BTaXu/klkdTkYzBdV/oMITtlp57dMCWtyTV564QTf
         873K64P8tw8oNGHzua6CDF6X92fqH1S+/aImbTQBSjF2A/ZShRWRhRxBBDPE/gSVI97n
         mSLXfZbJ9r8iQeO/ZZUBcU/RRQ9fBDOSdkgyQGp78yLikZwycB+xq1+5VLWoPJIVGQCm
         V3WuZyexbxH3+LErGEr7PoqHmevVPP0MmqSreggHNBRtQxTAuclLm74fECuK5+ZBVZwg
         27QkiRsCMghU2uQNXCHquHcgMP/srieWGDwtqnTTkdLh+6+yY3pujQ7r/iC6RgPhRKA6
         j0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DYtRy3yB5Mwslt+yJOER3GwxZYF8eTP3aAHJxAyC5bg=;
        b=qO33RQLMtrbUwUctkLcRR8XOBgys+gSVNvZOz+EG5MKAUvzuHjP6Sa6GoQY4FwUQPK
         tESiXWNIN9q6hFxZuC7LGR+IXodjjHPzBFt3dM/eX8VTt95QAtpJ1gENHXUTdLXL0olr
         8JqhJHx17jLBn0XbSXFuA/ebo4YN6eLIXN9suZjAubX8nF12qPgKntNsJsO8pPjK1vNg
         A3GWYHRCUlEA2qIoOVeV9nUo/C/upQxr3DojKHwmBCQuAN3LjIulJ/W4O1spIJV0Xc0j
         RniYROphfMaMmnUHBtrw0J4uc3kIJXpCw9yC/HIpEmxz6DtmCljGT4jSAEitACPxZ6gU
         JmgA==
X-Gm-Message-State: AOAM532rUrKa8+Q5qlT3zK+Qh4K6ufC2IKG4mhHvM6Rp64tqsUfche/K
        7bvkib5Rr9qepnHdRjW+GThR7A==
X-Google-Smtp-Source: ABdhPJzU97fS4x+QIpbcGx8eNIDjWR1iyMkyZKUI9B2lqOj7lmI9OqlGCtafetceHBh0yQseHGHpGA==
X-Received: by 2002:aa7:c3c4:: with SMTP id l4mr5666090edr.335.1614582448655;
        Sun, 28 Feb 2021 23:07:28 -0800 (PST)
Received: from ?IPv6:2a02:768:2307:40d6::648? ([2a02:768:2307:40d6::648])
        by smtp.gmail.com with ESMTPSA id y12sm6423721ejb.104.2021.02.28.23.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Feb 2021 23:07:28 -0800 (PST)
Subject: Re: [PATCH v3 1/3] firmware: xilinx: Add pinctrl support
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc:     saikrishna12468@gmail.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        git@xilinx.com, linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1613131643-60062-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <1613131643-60062-2-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <CABMQnVJ+hQ_sdXMdLzhv2Y65QW8Vi01VAjV=SCeOei-zOZ5dwQ@mail.gmail.com>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <ecef1943-fec3-9b35-a326-87764512c691@monstr.eu>
Date:   Mon, 1 Mar 2021 08:07:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CABMQnVJ+hQ_sdXMdLzhv2Y65QW8Vi01VAjV=SCeOei-zOZ5dwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Noburiho,

On 2/28/21 1:17 AM, Nobuhiro Iwamatsu wrote:
> Hi,
> 
> 2021年2月12日(金) 21:10 Sai Krishna Potthuri
> <lakshmi.sai.krishna.potthuri@xilinx.com>:
>>
>> Adding pinctrl support to query platform specific information (pins)
>> from firmware.
>>
>> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
>> Acked-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>  drivers/firmware/xilinx/zynqmp.c     | 114 +++++++++++++++++++++++++++
>>  include/linux/firmware/xlnx-zynqmp.h |  90 +++++++++++++++++++++
>>  2 files changed, 204 insertions(+)
>>
>> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
>> index efb8a66efc68..299c3d5a9ebd 100644
>> --- a/drivers/firmware/xilinx/zynqmp.c
>> +++ b/drivers/firmware/xilinx/zynqmp.c
>> @@ -784,6 +784,120 @@ int zynqmp_pm_fpga_get_status(u32 *value)
>>  }
>>  EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_get_status);
>>
> 
> <snip>
> 
>> @@ -125,6 +131,12 @@ enum pm_query_id {
>>         PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS,
>>         PM_QID_CLOCK_GET_PARENTS,
>>         PM_QID_CLOCK_GET_ATTRIBUTES,
>> +       PM_QID_PINCTRL_GET_NUM_PINS = 6,
>> +       PM_QID_PINCTRL_GET_NUM_FUNCTIONS = 7,
>> +       PM_QID_PINCTRL_GET_NUM_FUNCTION_GROUPS = 8,
>> +       PM_QID_PINCTRL_GET_FUNCTION_NAME = 9,
>> +       PM_QID_PINCTRL_GET_FUNCTION_GROUPS = 10,
>> +       PM_QID_PINCTRL_GET_PIN_GROUPS = 11,
> 
> These do not have to have values, Because PM_QID_INVALID is 0.
> 
>>         PM_QID_CLOCK_GET_NUM_CLOCKS = 12,
> 
> And you can drop value from this.

Please take a look at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/firmware/xlnx-zynqmp.h?h=v5.12-rc1&id=1077d4367ab3b97f6db2f66c87289af863652215

We are using explicit values as was recommended by Greg.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

