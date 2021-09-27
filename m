Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A19419D05
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238480AbhI0Rhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:37:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22569 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237362AbhI0Rfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632764047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VGALT2fxCpmPpY+7KVSQkrZnOp9lkNjd+JdjPKf4UQA=;
        b=DdOvoJa/KAW9ebIVgjaksf/n6uGbBjg+Q6LkVPD9ZmyDmouZ9kcYvV32EIpB2QB75z5kHq
        Xv1/4et6LSFrWKAURZn8t6/0R7cHyj+pXdLxehNRFIo5W16hWEWsuvEhRvIRszA8NmnJJu
        ivXc58qzgW+WEpD1LFFcx3VHEl+Aqp0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-mG6sMS9cOXyZnjodKtB6SQ-1; Mon, 27 Sep 2021 13:34:05 -0400
X-MC-Unique: mG6sMS9cOXyZnjodKtB6SQ-1
Received: by mail-wm1-f70.google.com with SMTP id d12-20020a1c730c000000b0030b4e0ecf5dso210020wmb.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 10:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VGALT2fxCpmPpY+7KVSQkrZnOp9lkNjd+JdjPKf4UQA=;
        b=XJe/Txyn+0CWPV/6ycbBJyPBjt0yPw2ljxajbMTGYIRUsZJlF3m4+vQw6lrW2dLuEn
         X2zjDa5v2/zb48FuZNAq8nbdLWycE9Kvsw4MbeDq/p9sEnp7Md/prDN+KdmzgjNQArno
         /JOs9eIsoLHMgHUJs/5NcGoX3r8apNu6b11tGGKSBrxwpa+LdTSJr7FI8GxEcJsShCuQ
         TGVNOpHDfbOPhU8q76S6xDF+XQpUIzxsMgjLBDfspDblf3AljonsSl5TWCI2b0KjRwg4
         wVPexo9gHDuhcMD8j+a6X9vwQz3gXBcJV42R/03em5lLTwjM2nDkq76Wf8GWCV2Qi4Nc
         xLUg==
X-Gm-Message-State: AOAM5335ClnutG1B7HeDlUMOXxVlkPUl8pfqA2+Hf8RvW1G4fQJQGQ5l
        8IBO/Pjj1WxvLNM/kVumkqEFHgVRM4/4Mswu9R48b065+qrkfoRuue5cYvgg8XiecawQqZUSq0O
        ygGWzPigEAVHbzqzAP11YnMSz
X-Received: by 2002:a7b:ca45:: with SMTP id m5mr303850wml.104.1632764044564;
        Mon, 27 Sep 2021 10:34:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxFQPFgP0cvYwAaKpVOANDrVGsVbbDWtlyDelOIxzvbsD6mtpCVJttOjDtlebYZSOAscAoqQ==
X-Received: by 2002:a7b:ca45:: with SMTP id m5mr303828wml.104.1632764044352;
        Mon, 27 Sep 2021 10:34:04 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c654d.dip0.t-ipconnect.de. [91.12.101.77])
        by smtp.gmail.com with ESMTPSA id r6sm547676wrp.41.2021.09.27.10.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 10:34:03 -0700 (PDT)
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
References: <cover.1632437225.git.quic_cgoldswo@quicinc.com>
 <595d09279824faf1f54961cef52b745609b05d97.1632437225.git.quic_cgoldswo@quicinc.com>
 <4f4f6e93-ddc2-c9bb-ef47-4a40f2c3d0d7@quicinc.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC] arm64: mm: update max_pfn after memory hotplug
Message-ID: <1b9c4377-0a6b-b7d4-7a6b-a69f9469bb70@redhat.com>
Date:   Mon, 27 Sep 2021 19:34:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4f4f6e93-ddc2-c9bb-ef47-4a40f2c3d0d7@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.09.21 19:22, Georgi Djakov wrote:
> On 9/24/2021 1:54 AM, Chris Goldsworthy wrote:
>> From: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
>>
>> After new memory blocks have been hotplugged, max_pfn and max_low_pfn
>> needs updating to reflect on new PFNs being hot added to system.
>>
>> Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
>> Signed-off-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
> 
> Thanks for the patch, Chris!
> 
> With this patch, the data in /proc/kpageflags appears to be correct and
> memory tools like procrank work again on arm64 platforms.
> 
> Tested-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> 
> Maybe we should add fixes tag, as it has been broken since the following
> commit:
> Fixes: abec749facff ("fs/proc/page.c: allow inspection of last section
> and fix end detection")

Are you sure that that commit broke it?

I recall that we would naturally run into the limit, because

count = min_t(size_t, count, (max_pfn * KPMSIZE) - src);

wouldn't really do what you would expect either. But you could 
force-read beyond max_pfn, yes, because the count computation was just 
weird.


I think the real issue is not properly adjusting max_pfn in the first 
place when we introduced memoruy hotplug on arm64.

-- 
Thanks,

David / dhildenb

