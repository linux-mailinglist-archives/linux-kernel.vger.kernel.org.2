Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BDF359005
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 00:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbhDHWx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 18:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbhDHWxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 18:53:24 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C6BC061760;
        Thu,  8 Apr 2021 15:53:12 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id z10so4033918qkz.13;
        Thu, 08 Apr 2021 15:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/Q6ViLCHPm36Ds023XtZI8X+biRfAfx253hJcmCLWz0=;
        b=U9+zy44FLk8TENK38IgPCc2RK3Di7tBkNjAD3qTNYnIL8DR0EFnfbMuLLZQTq/6Gk8
         MYY3il8gKOGIJ6tB9hbcZv+ixeVCP9QF71gWLbJMwHHGwOD2qnkPpzQdO1D3vwac4q6+
         LhpIxtppOSWcIY/81scF9aCuOTcoOBTHeePYBAE8809+2itKHqzf+nKk2Bj2e2wriqfl
         utGAw8pSXXnpkjxL/IoDeKcUreedg6fcJnHGBUTwjx4NzPAOlsKdWP8Yao4LaZLl2Jwo
         cT+KyMj/YDCJtE4ItSAcUBxZgZ8DfD13SHM/JwtyUj+2t62/5cCoJmZQwJ0IjGXzaxii
         BvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Q6ViLCHPm36Ds023XtZI8X+biRfAfx253hJcmCLWz0=;
        b=b0svh+RdqAQj7elTN8PchpuEGsAc25nQ9P+wGOiZsNF4RDw0LcjXi8CTDwwPVTC22o
         NYSc+Yk/mr87r8IUGBvXhVb3ZM5IpCEodprwNRdJEth5M8BWhNrhOirzXoS3J/3O+RZB
         7tcojGfvSrETL/6PLwJxRQKuOA2eWM3GNL9h/zBQ46NfUZ3NeR/VC4Qw8U+HthXHhWPv
         1OaFP3oATkjvSzJeQKHPp8G5ogeNs+QTHfK+82yu8PnuKMBksNypFBJuXpTB3N+pcC6H
         exAVR9n92nR5paURFr3wmqBxQA/Qg+44JQtDNs1IVzPCF8vaqD8QH4C0hIOu3iRD4+ZB
         ZuwA==
X-Gm-Message-State: AOAM531Lan8z4kysWwJ0qMmS6yvecB829NfMx+XTfiw4/Damh6Mc/Led
        kyq0tUR1beUgnq4qlTQY6cA=
X-Google-Smtp-Source: ABdhPJySPompxVrcysWJRaIa7S5JTwdagzcLG4VVIhmGjp9CiFS5EqY03e5TVi9GeqNKC7B/INPcuw==
X-Received: by 2002:a37:44e:: with SMTP id 75mr10866732qke.150.1617922391980;
        Thu, 08 Apr 2021 15:53:11 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id n1sm643776qtp.76.2021.04.08.15.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 15:53:11 -0700 (PDT)
Subject: Re: [PATCH v4 1/1] of: unittest: overlay: ensure proper alignment of
 copied FDT
To:     Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210408204508.2276230-1-frowand.list@gmail.com>
 <CAL_Jsq+Os6O6CpRYurmf_4-Xnzgpkd1jbDbnp0en1TPbZXTf7w@mail.gmail.com>
 <b73965c7-e975-6c48-3367-411f6c754181@roeck-us.net>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <c625202a-0530-adbd-d4f8-0935d3ed37e2@gmail.com>
Date:   Thu, 8 Apr 2021 17:53:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b73965c7-e975-6c48-3367-411f6c754181@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/21 4:54 PM, Guenter Roeck wrote:
> On 4/8/21 2:28 PM, Rob Herring wrote:
>>
>> Applying now so this gets into linux-next this week.
>>
> The patch doesn't apply on top of today's -next; it conflicts
> with "of: properly check for error returned by fdt_get_name()".
> 
> I reverted that patch and applied this one, and the DT unittests
> run with it on openrisc. I do get a single test failure, but I that
> is a different problem (possibly with the test case itself).
> 
> ### dt-test ### FAIL of_unittest_dma_ranges_one():923 of_dma_get_range: wrong DMA addr 0x00000000
> 	(expecting 100000000) on node /testcase-data/address-tests/bus@80000000/device@1000

That is a known regression on the target that I use for testing (and
has been since 5.10-rc1) - the 8074 dragonboard, arm 32.  No
one else has reported it on the list, so even though I want to debug
and fix it "promptly", other tasks have had higher priority.  In my
notes I list two suspect commits:

  e0d072782c73 dma-mapping: introduce DMA range map, supplanting dma_pfn_offset
  0a0f0d8be76d dma-mapping: split <linux/dma-mapping.h>

I think that was purely based on looking at the list of commits that
may have touched OF dma.  I have not done a bisect.

One specific report of not seeing the FAIL was Vireshk on 5.11-rc6 with
a Hikey board.

> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks for testing!

> 
> Guenter
> 

