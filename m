Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20173591EA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 04:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbhDICUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 22:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhDICUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 22:20:36 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC24C061760;
        Thu,  8 Apr 2021 19:20:24 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id a8so4271693oic.11;
        Thu, 08 Apr 2021 19:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rmOjBwpL4Q1nyIe9hUH1/jVTOJmvFoqkXPcEHdU8FVA=;
        b=TrjsgPQxp9cn453svP6nTYmZqbUJLu4bo69Aepv7I4LFZO9+TdKB6fvE69YhyBtIyh
         4VWXsjaF85poDTy4Sm9EI0mGpk3kP8mitJP1PD40hAQL2xTcr2T0dzXKjI6ah4Ti5oNZ
         EgnpUwCFJs8GB7r4F6+LCNJuAk1HdELpGFvMd+8Swq5Uqoy9uAizOw5ooMIijVf2AwdN
         58TaobQbOItimaHMBT0Xceio7Dn+OTXatm1eIXkOMDBOe7MJdBJldRXAiPnOvoZshq0y
         Vq/rCflXDrOlp+p3G85Uad5H796gktMq4hmw12ebHsTWdVmXhfMuXjvDpUsrVxwLZlLd
         Qm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rmOjBwpL4Q1nyIe9hUH1/jVTOJmvFoqkXPcEHdU8FVA=;
        b=VV2bpoY4YwVgnckOA08yXMsHFWTSfcuazdlt2cdCmuARKeb61YBO3x7N70kBbm5gvr
         FSsHFfdXmB2uV2IyeHn88Z6KIxnOpK4HFcxVj7+YpvVlc5tTurinN4rJo8BQjA9ZGfIt
         V4Czw4QpV1IjVJN5SZ3ZTy41dAFiDPm9Dw6sLtf+gWNCnpzF4m/KcDZ54shM37Puwk17
         kgzjuFL29BWHpgQhcBLpfh8Bt43ydO1ZsyiLxTtmlKz9Bw5BsfTKEEBhA+vkzLHaX991
         /PMVeshcoFKXzKlh2U2Rh7AAih5zUkJqdQ/S82iGlFxBkxGTTuH6PBxV9v3f8mMg+30/
         uYoQ==
X-Gm-Message-State: AOAM530tzkpDHVDa3Bl2Qvh+C99kkXkd5Cu85Vx4IwNgb/G9GHrxtJju
        p/Glch43ArhPjB+ITEK83jh0Nxg1pWA=
X-Google-Smtp-Source: ABdhPJxrksno3Id9WLxpGTlIy6P2vXTeMn8+luUI4APYUhoG6wkNY8edsZgGpn2FoVbhX/REI/oqXA==
X-Received: by 2002:aca:d485:: with SMTP id l127mr8524306oig.21.1617934823430;
        Thu, 08 Apr 2021 19:20:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v23sm309518ots.63.2021.04.08.19.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 19:20:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v4 1/1] of: unittest: overlay: ensure proper alignment of
 copied FDT
To:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210408204508.2276230-1-frowand.list@gmail.com>
 <CAL_Jsq+Os6O6CpRYurmf_4-Xnzgpkd1jbDbnp0en1TPbZXTf7w@mail.gmail.com>
 <b73965c7-e975-6c48-3367-411f6c754181@roeck-us.net>
 <c625202a-0530-adbd-d4f8-0935d3ed37e2@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <b081277a-763e-fdd4-43e3-483869a7e5c5@roeck-us.net>
Date:   Thu, 8 Apr 2021 19:20:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c625202a-0530-adbd-d4f8-0935d3ed37e2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/21 3:53 PM, Frank Rowand wrote:
> On 4/8/21 4:54 PM, Guenter Roeck wrote:
>> On 4/8/21 2:28 PM, Rob Herring wrote:
>>>
>>> Applying now so this gets into linux-next this week.
>>>
>> The patch doesn't apply on top of today's -next; it conflicts
>> with "of: properly check for error returned by fdt_get_name()".
>>
>> I reverted that patch and applied this one, and the DT unittests
>> run with it on openrisc. I do get a single test failure, but I that
>> is a different problem (possibly with the test case itself).
>>
>> ### dt-test ### FAIL of_unittest_dma_ranges_one():923 of_dma_get_range: wrong DMA addr 0x00000000
>> 	(expecting 100000000) on node /testcase-data/address-tests/bus@80000000/device@1000
> 
> That is a known regression on the target that I use for testing (and
> has been since 5.10-rc1) - the 8074 dragonboard, arm 32.  No
> one else has reported it on the list, so even though I want to debug
> and fix it "promptly", other tasks have had higher priority.  In my
> notes I list two suspect commits:
> 
>   e0d072782c73 dma-mapping: introduce DMA range map, supplanting dma_pfn_offset
>   0a0f0d8be76d dma-mapping: split <linux/dma-mapping.h>
> 
> I think that was purely based on looking at the list of commits that
> may have touched OF dma.  I have not done a bisect.
> 

Here you are:

# bad: [2c85ebc57b3e1817b6ce1a6b703928e113a90442] Linux 5.10
# good: [bbf5c979011a099af5dc76498918ed7df445635b] Linux 5.9
git bisect start 'v5.10' 'v5.9'
# bad: [4d0e9df5e43dba52d38b251e3b909df8fa1110be] lib, uaccess: add failure injection to usercopy functions
git bisect bad 4d0e9df5e43dba52d38b251e3b909df8fa1110be
# good: [f888bdf9823c85fe945c4eb3ba353f749dec3856] Merge tag 'devicetree-for-5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
git bisect good f888bdf9823c85fe945c4eb3ba353f749dec3856
# good: [640eee067d9aae0bb98d8706001976ff1affaf00] Merge tag 'drm-misc-next-fixes-2020-10-13' of git://anongit.freedesktop.org/drm/drm-misc into drm-next
git bisect good 640eee067d9aae0bb98d8706001976ff1affaf00
# good: [c6dbef7307629cce855aa6b482b60cbf7777ed88] Merge tag 'usb-5.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
git bisect good c6dbef7307629cce855aa6b482b60cbf7777ed88
# good: [ce1558c285f9ad04c03b46833a028230771cc0a7] ALSA: hda/hdmi: fix incorrect locking in hdmi_pcm_close
git bisect good ce1558c285f9ad04c03b46833a028230771cc0a7
# good: [c48b75b7271db23c1b2d1204d6e8496d91f27711] Merge tag 'sound-5.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good c48b75b7271db23c1b2d1204d6e8496d91f27711
# bad: [0cd7d9795fa82226e7516d38b474bddae8b1ff26] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching
git bisect bad 0cd7d9795fa82226e7516d38b474bddae8b1ff26
# good: [b1839e7c2a42ccd9a0587c0092e880c7a213ee2a] dmaengine: xilinx: dpdma: convert tasklets to use new tasklet_setup() API
git bisect good b1839e7c2a42ccd9a0587c0092e880c7a213ee2a
# bad: [0de327969b61a245e3a47b60009eae73fe513cef] cma: decrease CMA_ALIGNMENT lower limit to 2
git bisect bad 0de327969b61a245e3a47b60009eae73fe513cef
# good: [6eb0233ec2d0df288fe8515d5b0b2b15562e05bb] usb: don't inherity DMA properties for USB devices
git bisect good 6eb0233ec2d0df288fe8515d5b0b2b15562e05bb
# bad: [48d15814dd0fc429e3205b87f1af6cc472018478] lib82596: move DMA allocation into the callers of i82596_probe
git bisect bad 48d15814dd0fc429e3205b87f1af6cc472018478
# bad: [eba304c6861613a649ba46cfab835b1eddeacd8e] dma-mapping: better document dma_addr_t and DMA_MAPPING_ERROR
git bisect bad eba304c6861613a649ba46cfab835b1eddeacd8e
# bad: [b9bb694b9f62f4b31652223ed3ca38cf98bbb370] iommu/io-pgtable-arm: Clean up faulty sanity check
git bisect bad b9bb694b9f62f4b31652223ed3ca38cf98bbb370
# bad: [a97740f81874c8063c12c24f34d25f10c4f5e9aa] dma-debug: convert comma to semicolon
git bisect bad a97740f81874c8063c12c24f34d25f10c4f5e9aa
# bad: [e0d072782c734d27f5af062c62266f2598f68542] dma-mapping: introduce DMA range map, supplanting dma_pfn_offset
git bisect bad e0d072782c734d27f5af062c62266f2598f68542
# first bad commit: [e0d072782c734d27f5af062c62266f2598f68542] dma-mapping: introduce DMA range map, supplanting dma_pfn_offset

Guenter
