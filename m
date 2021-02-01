Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9705C30A393
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 09:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbhBAIva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 03:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbhBAIv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 03:51:26 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB15C061574;
        Mon,  1 Feb 2021 00:50:46 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o10so11010097wmc.1;
        Mon, 01 Feb 2021 00:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rIiV2l/8Qf1juG7z36n1KVoCTNYEzigbbx8ySlcRFIU=;
        b=qpwS4+w0No/kjqi9pPJi0b1UkW42lwpu9GiFvxw5B5qU8wh1TT4PzZOFNDpV9x0aMB
         559Kf9cmqogMtj/58X+kijNdaqWOrLanYVn7vOKPJR+6NMGAp+UDs5yjnIOxA8ZbHom8
         K+S4th4Ji8cxYidORiMybefEIwPFmaW1sWNSBBOeOkbRQOJGBdbAMYnIr1fHpb8SojfV
         oDCBSmWrgxZ3USTPdliDl16vLjnQCKaBnLZDW4aQMkTfabhI8rTbZgk5pHszFLVnFoEx
         b2RivGZucjjOGAl3nYOd6XdNBnRpZoyt8Z2+neh1jBYCDvbcACDgJwUrOh1J4GoQkfM8
         eKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rIiV2l/8Qf1juG7z36n1KVoCTNYEzigbbx8ySlcRFIU=;
        b=UKBnB/9HXMf1T16MN1mBiSku3zURAYjieKgKi08RGsmCxA+FHZQPB25ROcFdnr0rTp
         Wz4iiKo9ydTlGoKRxLwVPsbom2If/FfTn1vjKO11Op/X1i4pKQT+BydV2aA6q5nsPlUN
         5Sja0h/MaSS+KKkoRFcqv+K7ZBxL2o86s+IYs7/+Rh+gX0EwV+03WJkWTlFLp+2GbXKA
         2bZzTieictof2EKy+S/QApyRu/0CoaN1SJSdw33YJ34RZBJxkAClwv6xhhZ5UkQN3B89
         BxX1o+cl8m4/IOrd9A4EOObaShe1BovVx9ETFk6vGsroiZnAtYfqVenGL8lG++7hgw2O
         7vQQ==
X-Gm-Message-State: AOAM533UIatAyaeR38NT57m0HOPB5llG5RKm8yLbvDMaDC9QGanP89Uf
        kn6jU3MSIqve3TO6L1mJ9qA=
X-Google-Smtp-Source: ABdhPJwMG9i1Sej5MLrrFago+IjOeLAh/IFRWk11NBhciLuq+1qoY42wMuzwOISDhylXSmgSrk7Few==
X-Received: by 2002:a1c:408a:: with SMTP id n132mr5037245wma.86.1612169445107;
        Mon, 01 Feb 2021 00:50:45 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id i7sm15842882wmq.2.2021.02.01.00.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 00:50:44 -0800 (PST)
Subject: Re: [PATCH v1 2/2] arm64: configs: Support DEVAPC on MediaTek
 platforms
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Neal Liu <neal.liu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, SoC Team <soc@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Hanks Chen <Hanks.Chen@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Jackson-kt Chang <Jackson-kt.Chang@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1608713092-26952-1-git-send-email-neal.liu@mediatek.com>
 <1608713092-26952-3-git-send-email-neal.liu@mediatek.com>
 <68442164-d649-aee0-cfe8-c9ebb868612d@gmail.com>
 <CAK8P3a1DLX6y5GM3O7+T0gMH_JLRp6nUkHFZc4Shjn_bTKWWSw@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <7001eef4-42bd-0c17-50a3-4d619d0fc80a@gmail.com>
Date:   Mon, 1 Feb 2021 09:50:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1DLX6y5GM3O7+T0gMH_JLRp6nUkHFZc4Shjn_bTKWWSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/01/2021 23:23, Arnd Bergmann wrote:
> On Sun, Jan 31, 2021 at 3:07 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>> On 23/12/2020 09:44, Neal Liu wrote:
>>> Support DEVAPC on MediaTek platforms by enabling CONFIG_MTK_DEVAPC.
>>>
>>> Signed-off-by: Neal Liu <neal.liu@mediatek.com>
>>> ---
>>>  arch/arm64/configs/defconfig |    1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>> index 17a2df6..a373776 100644
>>> --- a/arch/arm64/configs/defconfig
>>> +++ b/arch/arm64/configs/defconfig
>>> @@ -257,6 +257,7 @@ CONFIG_MTD_NAND_MARVELL=y
>>>  CONFIG_MTD_NAND_FSL_IFC=y
>>>  CONFIG_MTD_NAND_QCOM=y
>>>  CONFIG_MTD_SPI_NOR=y
>>> +CONFIG_MTK_DEVAPC=m
>>>  CONFIG_SPI_CADENCE_QUADSPI=y
>>>  CONFIG_BLK_DEV_LOOP=y
>>>  CONFIG_BLK_DEV_NBD=m
>>>
>>
>> From my understanding, defconfig is for a minimal config that allows to boot a
>> machine. As MTK_DEVAPC is a rather exotic driver to detect bus access
>> violations, I think it's not a good candidate for inclusion in defconfig.
>>
>> In any case, I added the SoC maintainer, so that they can correct me, if I'm
>> wrong :)
> 
> I generally don't mind adding platform specific drivers as loadable modules
> even if they are somewhat obscure. For built-in drivers, this is
> different though,
> as those have a noticeable impact on other platforms.
> 
> I haven't kept track of what this particular driver does, but from the Kconfig
> description, I'd say it should get enabled in defconfig.
> 

Thanks for the feedback Arnd.
Applied now to v5.11-next/defconfig
