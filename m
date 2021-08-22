Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED0E3F4048
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 17:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbhHVPaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 11:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhHVPay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 11:30:54 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6198C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 08:30:12 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h9so26552153ljq.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 08:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UUbd05FldiIoBAm96I7gNRChHATg0GhZfAiC5EXuLrA=;
        b=TDxe6Pr+2JgQIav8J1lASsQ2sQ5sNJ3gUFRzgjvzbgdD+IR8rEXPHn53p8EkgO99t1
         eQGS3TE6OaygCfGxNPPaDhQYJZHgHuC17R5eAqNLuSkEVclYS/o2gBYyvqe1yI8QEXkR
         UKULvCp9s9/sEz4i5BcZ5+s1yF/vfv2W5VCGQaTOKhhXiFWqCcGwWFl4u+LRhtxTt+Yp
         SWG0qUvbS0qD90RNYl/kNRugcs3hVYNhuJYIp+igABrADYQIwPzXnWaF2/18h1HqyXgq
         NmMzbC9JkGwHHk2wJVjmWkYAuMbSgp2C6+iCObrVfPPhCf2UdmZTeBhtLDNglKBUsny/
         P2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UUbd05FldiIoBAm96I7gNRChHATg0GhZfAiC5EXuLrA=;
        b=XNW9BetkOvMPGd1No62eryP84v1e0umqGHk9NUjvxauXsybPe+eLQLdmQmytpa+vow
         Qpx65M4TGiRi9okdbVNmQ7uQMGv2dcMEvnPy22hpS4RwpWa2rwFm5BufXsyljWthYfzE
         FopZUyTs+GFC0Z2+GnJvkpnDIg9sDVGg2zL9laIspLjn1UM64dGeau2LJ7g0VmyjnsSO
         E4AvR6iRsiZyMzkTltqLCJViBxQ/OtiAnTJ7u8gHNhN+FSPkwTFgRurCynyuG251T9vX
         aNlYJMQkPT6vr29aXyPhVTqVsggJRs/Fe06/SN7PuS+cWYDDLsG/WJqlkTNX3c0lSUj6
         zT9Q==
X-Gm-Message-State: AOAM532qNtrnvsNexhhH8kG7Dc2IyKnGIEihM4Il7G1bNnuFsowOPWmC
        zOCAbZddm6+LgDfqcV7Q1kbFbwWskmNZckeC
X-Google-Smtp-Source: ABdhPJx8sDEPnIXalJagpmfAMZRPgoYxbLiwPl2oRJ2mNqbBrSnc4p9uSU4JLR9R3Ot4hSsPYkNUeA==
X-Received: by 2002:a2e:534c:: with SMTP id t12mr23231914ljd.133.1629646210630;
        Sun, 22 Aug 2021 08:30:10 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id u1sm1219570lfk.96.2021.08.22.08.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 08:30:10 -0700 (PDT)
Subject: Re: [PATCH RFC v2 0/6] staging: r8188eu: avoid uninit value bugs
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <6182ed46-d79d-7f66-c7c0-096486410b4d@gmail.com>
 <cover.1629642658.git.paskripkin@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <44fc34ec-6bbe-9cd0-0c51-78836bad7e0c@gmail.com>
Date:   Sun, 22 Aug 2021 18:30:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <cover.1629642658.git.paskripkin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/21 5:35 PM, Pavel Skripkin wrote:
> Hi, Greg, Larry and Phillip!
> 
> I noticed, that new staging driver was added like 3 weeks ago and I decided
> to look at the code, because drivers in staging directory are always buggy.
> 
> The first thing I noticed is *no one* was checking read operations result, but
> it can fail and driver may start writing random stack values into registers. It
> can cause driver misbehavior or device misbehavior.
> 
> To avoid this type of bugs, i've changed rtw_read* API. Now all rtw_read
> funtions return an error, when something went wrong with usb transfer.
> 
> It helps callers to break/return earlier and don't write random values to
> registers or to rely on random values.
> 
> Why is this pacth series RFC?
>    1. I don't have this device and I cannot test these changes.
>    2. I don't know how to handle errors in each particular case. For now, function
>       just returns or returns an error. That's all. I hope, driver maintainers will
>       help with these bits.
>    3. I guess, I handled not all uninit value bugs here. I hope, I fixed
>       at least half of them
> 
> 
> v1 -> v2:
>    1. Make rtw_read*() return an error instead of initializing pointer to error
>    2. Split one huge patch to smaller ones for each rtw_read{8,16,32} function
>       changes
>    3. Add new macro for printing register values (It helps to not copy-paste error
>       handling)
>    4. Removed {read,write}_macreg (Suggested by Phillip)
>    5. Rebased on top of staging-next
>    6. Cleaned checkpatch errors and warnings
> 
> Only build-tested, since I don't have device with r8118eu chip
> 

BTW, can you recommend any devices with this chip except for ASUS 
USB-N10 Nano? I didn't find any of them with delivery/reasonable 
delivery price to Russia.

I want to help with testing and moving this driver out of staging 
directory :)



With regards,
Pavel Skripkin
