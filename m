Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8F535937D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbhDID7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbhDID7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:59:36 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2E0C061760;
        Thu,  8 Apr 2021 20:59:23 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id f12so3264295qtq.4;
        Thu, 08 Apr 2021 20:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z20sdUnyZzZOig2XtRkgruY6oFSC2WoIIhXStpsksq4=;
        b=JL7cGwF9Amcsh9Eg2BR+Psbo7ObACT5lMqdA4c/UZqq0JGkxdLZbInZueVfsLlQn2K
         830c08og0OxCo+EVVfLrPM8A+IJ5f1txjIWdBpi8qdm9tsHtRFBBlREJK+swIFpedyPu
         mcvjTXgtEqyToMN865cFGPqecTCz6A+mz0T5tmH4U2RXbxh7oIOpdJKk621REdsiFhX0
         MwYdkbtnIM0CBB2wbxo1SzLbez9RWM7kK2xZQke7ZIDz0XTXzHLmHYqqHAv0gv0GKHDg
         7SM/nIRANvYpFtAWV82IKaZKu1cavnU+cJATf+8AmGqKrlKVWlNHJY73K4YavR4gDx8S
         j2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z20sdUnyZzZOig2XtRkgruY6oFSC2WoIIhXStpsksq4=;
        b=P3dITVcG8Z3usWhTOOfVWQLBhlDyykSCmzxVexzJ7ld4ydHWZSLT2mJvA6INe9XfFF
         uVq5FgXY1aOeteK3u7aGjKk31x3MxwCjPSMCajVHQrT0msmzAn5rdc5re6LBs9ONhUAM
         AgU/1iA57Ao/P0hlN72ZEj+FOdbIkxLVIyckdHei5s10P/WsZSW2KLQkFr9LVe87htPE
         d13ILSScEfBcuBj7iCdXtvlez1p0EI9bBO3xJ0VPjK6s8vod7bvdebWP4xTIDOTdaamc
         VGM4uMnNLkdkRm5v24kcDKHxZIxvVpPUdQTydL00/G42vRnUzVmPnCRd2A8nE793Dijj
         H0og==
X-Gm-Message-State: AOAM5334BgbYUTCFzKDk1KMxVI995Tq/NG20Fnz+VEC2dCP4QUCLJEqb
        S7ldyTgg+qmpoUzQrCryRj8=
X-Google-Smtp-Source: ABdhPJwdqUiReSPEqldRyhZJwGPCNrmosA9eez7Wxp6KYK3rzKbb4Z+bS/udP50cpstAuIWc74Zpdg==
X-Received: by 2002:ac8:7747:: with SMTP id g7mr10695921qtu.144.1617940763166;
        Thu, 08 Apr 2021 20:59:23 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id d10sm978923qko.70.2021.04.08.20.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 20:59:22 -0700 (PDT)
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
 <c625202a-0530-adbd-d4f8-0935d3ed37e2@gmail.com>
 <b081277a-763e-fdd4-43e3-483869a7e5c5@roeck-us.net>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <95d8ce8d-9210-bbda-4dd9-e98e860c35af@gmail.com>
Date:   Thu, 8 Apr 2021 22:59:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b081277a-763e-fdd4-43e3-483869a7e5c5@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/21 9:20 PM, Guenter Roeck wrote:
> On 4/8/21 3:53 PM, Frank Rowand wrote:
>> On 4/8/21 4:54 PM, Guenter Roeck wrote:
>>> On 4/8/21 2:28 PM, Rob Herring wrote:
>>>>
>>>> Applying now so this gets into linux-next this week.
>>>>
>>> The patch doesn't apply on top of today's -next; it conflicts
>>> with "of: properly check for error returned by fdt_get_name()".
>>>
>>> I reverted that patch and applied this one, and the DT unittests
>>> run with it on openrisc. I do get a single test failure, but I that
>>> is a different problem (possibly with the test case itself).
>>>
>>> ### dt-test ### FAIL of_unittest_dma_ranges_one():923 of_dma_get_range: wrong DMA addr 0x00000000
>>> 	(expecting 100000000) on node /testcase-data/address-tests/bus@80000000/device@1000
>>
>> That is a known regression on the target that I use for testing (and
>> has been since 5.10-rc1) - the 8074 dragonboard, arm 32.  No
>> one else has reported it on the list, so even though I want to debug
>> and fix it "promptly", other tasks have had higher priority.  In my
>> notes I list two suspect commits:
>>
>>   e0d072782c73 dma-mapping: introduce DMA range map, supplanting dma_pfn_offset
>>   0a0f0d8be76d dma-mapping: split <linux/dma-mapping.h>
>>
>> I think that was purely based on looking at the list of commits that
>> may have touched OF dma.  I have not done a bisect.
>>
> 
> Here you are:
> 
> # bad: [2c85ebc57b3e1817b6ce1a6b703928e113a90442] Linux 5.10
> # good: [bbf5c979011a099af5dc76498918ed7df445635b] Linux 5.9
> git bisect start 'v5.10' 'v5.9'
> # bad: [4d0e9df5e43dba52d38b251e3b909df8fa1110be] lib, uaccess: add failure injection to usercopy functions
> git bisect bad 4d0e9df5e43dba52d38b251e3b909df8fa1110be
> # good: [f888bdf9823c85fe945c4eb3ba353f749dec3856] Merge tag 'devicetree-for-5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
> git bisect good f888bdf9823c85fe945c4eb3ba353f749dec3856
> # good: [640eee067d9aae0bb98d8706001976ff1affaf00] Merge tag 'drm-misc-next-fixes-2020-10-13' of git://anongit.freedesktop.org/drm/drm-misc into drm-next
> git bisect good 640eee067d9aae0bb98d8706001976ff1affaf00
> # good: [c6dbef7307629cce855aa6b482b60cbf7777ed88] Merge tag 'usb-5.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
> git bisect good c6dbef7307629cce855aa6b482b60cbf7777ed88
> # good: [ce1558c285f9ad04c03b46833a028230771cc0a7] ALSA: hda/hdmi: fix incorrect locking in hdmi_pcm_close
> git bisect good ce1558c285f9ad04c03b46833a028230771cc0a7
> # good: [c48b75b7271db23c1b2d1204d6e8496d91f27711] Merge tag 'sound-5.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
> git bisect good c48b75b7271db23c1b2d1204d6e8496d91f27711
> # bad: [0cd7d9795fa82226e7516d38b474bddae8b1ff26] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching
> git bisect bad 0cd7d9795fa82226e7516d38b474bddae8b1ff26
> # good: [b1839e7c2a42ccd9a0587c0092e880c7a213ee2a] dmaengine: xilinx: dpdma: convert tasklets to use new tasklet_setup() API
> git bisect good b1839e7c2a42ccd9a0587c0092e880c7a213ee2a
> # bad: [0de327969b61a245e3a47b60009eae73fe513cef] cma: decrease CMA_ALIGNMENT lower limit to 2
> git bisect bad 0de327969b61a245e3a47b60009eae73fe513cef
> # good: [6eb0233ec2d0df288fe8515d5b0b2b15562e05bb] usb: don't inherity DMA properties for USB devices
> git bisect good 6eb0233ec2d0df288fe8515d5b0b2b15562e05bb
> # bad: [48d15814dd0fc429e3205b87f1af6cc472018478] lib82596: move DMA allocation into the callers of i82596_probe
> git bisect bad 48d15814dd0fc429e3205b87f1af6cc472018478
> # bad: [eba304c6861613a649ba46cfab835b1eddeacd8e] dma-mapping: better document dma_addr_t and DMA_MAPPING_ERROR
> git bisect bad eba304c6861613a649ba46cfab835b1eddeacd8e
> # bad: [b9bb694b9f62f4b31652223ed3ca38cf98bbb370] iommu/io-pgtable-arm: Clean up faulty sanity check
> git bisect bad b9bb694b9f62f4b31652223ed3ca38cf98bbb370
> # bad: [a97740f81874c8063c12c24f34d25f10c4f5e9aa] dma-debug: convert comma to semicolon
> git bisect bad a97740f81874c8063c12c24f34d25f10c4f5e9aa
> # bad: [e0d072782c734d27f5af062c62266f2598f68542] dma-mapping: introduce DMA range map, supplanting dma_pfn_offset
> git bisect bad e0d072782c734d27f5af062c62266f2598f68542
> # first bad commit: [e0d072782c734d27f5af062c62266f2598f68542] dma-mapping: introduce DMA range map, supplanting dma_pfn_offset
> 
> Guenter
> 

Thank you !!!!!!!!!!!!!!!!

