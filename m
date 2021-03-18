Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C362340E91
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbhCRTnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbhCRTnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:43:23 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E9AC06174A;
        Thu, 18 Mar 2021 12:43:22 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so3268632pjb.4;
        Thu, 18 Mar 2021 12:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CXffwwYrcucz6PkLWpGV6NoHESkAqtw1CcNDZMWpdBQ=;
        b=jNduKqJSMUt5WOZPCi3HQPsGOMYzo1qxNn0d+yLtF8QzHmxYn0MVxo7w12d1iPqQVu
         lvV1OiEOTwUp2o4S66sZfnfNbFJAXalm65NDQLl5JFIpsz2/PxhHDEO5fUST3hzhU+mH
         QV0redUgqcnqebnNyc9hcJiAsUnwxbefH1YOrrPEcbzenRZZoFdQFvXYulMAb3FTk1CU
         C1PYz88MNF/+3hNqyhITzujGZhpofOKCKiQ+9SWg6Xvzo2IDCHreg4+/JEpmFrTgIJUH
         /PZOX1aPLFEPHOqy7a1rTPBzFhbKjm7PPxroYyHK2xEU66pnZGpHDpuWZn6ouI3cCnh9
         mwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CXffwwYrcucz6PkLWpGV6NoHESkAqtw1CcNDZMWpdBQ=;
        b=TPia4v9vAdOKjzcIaY0NcYCyXJmTCHGiRLOn0hmLcz/vESwn09eqmcI7jtkAIPaAxK
         LYQetoT4BqD4YP+l92XG12FXhkYhz2x5SsuXKZc7bv3PXWahQVE5xPD/aLrzpzsrPp4e
         YQA4SHVyanc6znh9alWD7hh1y/EiINf9s1mgRP6ZA5aPo3A2ENM8j2DYuKBYB9cN8vn+
         ND2ZddftfdDP4PcW1GpwWNGeqtmh80IGWhUbSPGLF9puZuBCRmnJ14JtvrjqugrqmcSf
         1DZWw46So0CsPgJOY1YbpymqKjodrliQKvcu7S73aeexpdbISudZVs/f3v1elgnPBhww
         qKAw==
X-Gm-Message-State: AOAM5329VOnjjdH+C0hu/mOMTMAi6+eV2Dq5QOF8RTEfS6dDUNpGSOwc
        6s20uZkzKGCEZlqCvjHEM0I=
X-Google-Smtp-Source: ABdhPJx6whDMKDzC33BODdtY7U0RVIN3SJu2/2BSqs7xQbfPQVncsAi7MXbvsiinVYE9JAwpBX4ArA==
X-Received: by 2002:a17:90a:d507:: with SMTP id t7mr6128138pju.54.1616096602323;
        Thu, 18 Mar 2021 12:43:22 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e190sm3109763pfe.3.2021.03.18.12.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 12:43:21 -0700 (PDT)
Subject: Re: [PATCH] swiotlb: Add swiotlb=off to disable SWIOTLB
To:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Cc:     opendmb@gmail.com, Jonathan Corbet <corbet@lwn.net>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>
References: <20210318191816.4185226-1-f.fainelli@gmail.com>
 <bbd44c42-cedc-7bd6-a443-c991fd080298@gmail.com>
 <e7850feb-b7cd-e279-e3fc-a9bdba162423@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f0940ea7-79f6-af57-aa7d-d121abb99012@gmail.com>
Date:   Thu, 18 Mar 2021 12:43:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <e7850feb-b7cd-e279-e3fc-a9bdba162423@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/2021 12:34 PM, Robin Murphy wrote:
> On 2021-03-18 19:22, Florian Fainelli wrote:
>>
>>
>> On 3/18/2021 12:18 PM, Florian Fainelli wrote:
>>> It may be useful to disable the SWIOTLB completely for testing or when a
>>> platform is known not to have any DRAM addressing limitations what so
>>> ever.
> 
> Isn't that what "swiotlb=noforce" is for? If you're confident that we've
> really ironed out *all* the awkward corners that used to blow up if
> various internal bits were left uninitialised, then it would make sense
> to just tweak the implementation of what we already have.

swiotlb=noforce does prevent dma_direct_map_page() from resorting to the
swiotlb, however what I am also after is reclaiming these 64MB of
default SWIOTLB bounce buffering memory because my systems run with
large amounts of reserved memory into ZONE_MOVABLE and everything in
ZONE_NORMAL is precious at that point.

> 
> I wouldn't necessarily disagree with adding "off" as an additional alias
> for "noforce", though, since it does come across as a bit wacky for
> general use.
> 
>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>
>> Christoph, in addition to this change, how would you feel if we
>> qualified the swiotlb_init() in arch/arm/mm/init.c with a:
>>
>>
>> if (memblock_end_of_DRAM() >= SZ_4G)
>>     swiotlb_init(1)
> 
> Modulo "swiotlb=force", of course ;)

Indeed, we would need to handle that case as well. Does it sound
reasonable to do that to you as well?
-- 
Florian
