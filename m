Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474BE30D587
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 09:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhBCIsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 03:48:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45768 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232637AbhBCIst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 03:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612342042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c16gMcF1C5gT8hYeleLK98M6WcNpQSgNkal3Q+qS8Ms=;
        b=XmCPMvokvcHQrOQebk1B6dKlHbtYZZLyt8LcSQhpAR9kX6foPvBXqsbxv96ixq9rJiAfdr
        i0frCCOLhqzeqfuDaJVYtuehRawIKiTqkh0x4VlI+YpW/w7ZpxbtR7HD9rGZUVMQeGYA2N
        /2BQ+iOuodtzXS99CdkMm+9c0Vxkw94=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-VzprArnKNH-2lCjbJvb_cg-1; Wed, 03 Feb 2021 03:47:20 -0500
X-MC-Unique: VzprArnKNH-2lCjbJvb_cg-1
Received: by mail-wm1-f72.google.com with SMTP id 5so1505727wmq.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 00:47:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c16gMcF1C5gT8hYeleLK98M6WcNpQSgNkal3Q+qS8Ms=;
        b=MAJm3Cs70Fs5qkBBuhmnIoNrIuNMOWkb/v0orsU2QcZfMgMSPLijQV1EmlWYxpbKP4
         IoD+LvV78okBNMpspCbJ9DXb3dSesibAF18azUXY7ioJer0zyzkYk4R3EiPrqSI46JH0
         STw/DYxpXZyyRctyEioE50pd0CKovWuP+1vsFA9/xJsVOLIN+GSkwpTXmb2RPP/CVDIE
         TO+EBrjMJwqKxXNE5Mlc4pUPLxTw6DoO1f9Zdn7/7H+e/TVNM4dtNsHLAznvLEkuzSfN
         nVd5/z1vDCtO0rWvEc9/fsWBICGlmFTCNgxNxSF5xNcMWFmvQu9V7PJHqo/tWTN9eiQL
         GAPg==
X-Gm-Message-State: AOAM5318/jMmr2dyTDLGZClMMutnCOTVWGfUlmtXAHQBsTZqXPDitQSv
        +1sSpj5jmtdV3ZAmw+kwcZ3khhYg3aP4Nrbdp0NJr3uj80isqUtqvlxlI5Z+QPdxqrUSzMX3QqU
        PYO78O+cZgiqRm4uN7mMdt+S6
X-Received: by 2002:adf:ba0c:: with SMTP id o12mr2204357wrg.322.1612342036189;
        Wed, 03 Feb 2021 00:47:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx+9m0nusfIy0q0Zz444RrUMfSQMYE4OPcqoerglQ3JMbXNdg5VDvV9lF2hc2Lc7Qwmv415Tg==
X-Received: by 2002:adf:ba0c:: with SMTP id o12mr2204345wrg.322.1612342036057;
        Wed, 03 Feb 2021 00:47:16 -0800 (PST)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id m18sm2455269wrx.17.2021.02.03.00.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 00:47:15 -0800 (PST)
Subject: Re: [RFC PATCH 3/5] arm64: aarch64-insn: Add barrier encodings
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org
References: <20210120171745.1657762-1-jthierry@redhat.com>
 <20210120171745.1657762-4-jthierry@redhat.com>
 <20210202111512.GC59049@C02TD0UTHF1T.local>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <a2466e6b-5b9b-6db6-496e-f8353e097d7e@redhat.com>
Date:   Wed, 3 Feb 2021 09:47:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210202111512.GC59049@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/2/21 12:15 PM, Mark Rutland wrote:
> On Wed, Jan 20, 2021 at 06:17:43PM +0100, Julien Thierry wrote:
>> Create necessary functions to encode/decode aarch64 data/instruction
>> barriers.
>>
>> Signed-off-by: Julien Thierry <jthierry@redhat.com>
>> ---
>>   arch/arm64/include/asm/aarch64-insn.h | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/aarch64-insn.h b/arch/arm64/include/asm/aarch64-insn.h
>> index 200bee726172..d0fee47bbe6e 100644
>> --- a/arch/arm64/include/asm/aarch64-insn.h
>> +++ b/arch/arm64/include/asm/aarch64-insn.h
>> @@ -379,6 +379,9 @@ __AARCH64_INSN_FUNCS(eret_auth,	0xFFFFFBFF, 0xD69F0BFF)
>>   __AARCH64_INSN_FUNCS(mrs,	0xFFF00000, 0xD5300000)
>>   __AARCH64_INSN_FUNCS(msr_imm,	0xFFF8F01F, 0xD500401F)
>>   __AARCH64_INSN_FUNCS(msr_reg,	0xFFF00000, 0xD5100000)
>> +__AARCH64_INSN_FUNCS(dmb,	0xFFFFF0FF, 0xD50330BF)
>> +__AARCH64_INSN_FUNCS(dsb,	0xFFFFF0FF, 0xD503309F)
>> +__AARCH64_INSN_FUNCS(isb,	0xFFFFF0FF, 0xD50330DF)
> 
> These match the encodings in ARM DDI 0487G.a, with a couple of caveats
> for DSB.
> 
> Per section C6.2.82 on page C6-1000, when CRm != 0x00, the instruction
> isn't considered a DSB. I believe per the "barriers" decode table on
> page C4-289 that here "0x00" is actually a binary string and 'x' is a
> "don't care" -- I've raised a ticket to get the documentation clarified.
> I suspect we need to write a function to handle that.
> 

Ah, I did miss that part. Thanks for pointing it out (and for clarifying 
it's probably not hexa, but the binary string makes sense since it's a 4 
bits field)

> There's also a secondary encoding for DSB with FEAT_XS, which we don't
> currently use but might want to add.
> 

Ah, yes, had to pick up a newer version of the Arm ARM! I'll add it.

>>   #undef	__AARCH64_INSN_FUNCS
>>   
>> @@ -390,6 +393,12 @@ static inline bool aarch64_insn_is_adr_adrp(u32 insn)
>>   	return aarch64_insn_is_adr(insn) || aarch64_insn_is_adrp(insn);
>>   }
>>   
>> +static inline bool aarch64_insn_is_barrier(u32 insn)
>> +{
>> +	return aarch64_insn_is_dmb(insn) || aarch64_insn_is_dsb(insn) ||
>> +	       aarch64_insn_is_isb(insn);
>> +}
> 
> I assume this is meant to match the barriers instruction class, as per
> the table on page C4-289? That also contains CLREX, SB, SSBB, and PSSBB,
> and it might be worth adding them at the same time.
> 

Yes, I have to admit I only added the ones that objtool saw and 
complained about "unreachable instruction" (mostly barriers after 
ret/eret). I'll add them as well.

Thanks,

-- 
Julien Thierry

