Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8F436BF5E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 08:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbhD0Gjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 02:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhD0Gjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 02:39:44 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E31C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 23:39:00 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id b23so9454138lfv.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 23:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I0nfqSqzuzoOBPv7mcSdmp3bMcP96BtuMMzceqfKSHY=;
        b=UzGdvQoQPnzaqSYnWcX+X0MPOC6GeNU8dTbot/n97HOMCsdPm0TvNoL8/hxZ6bhBYO
         mMOHy10IgtT5Oo75J275fTxnQ0rO4vF6UjmHuEWcz7cN+A8SIXItnLYaOM/eCrOq0PBS
         Hk8oL/+YUpb5Dgy1JXkOyQcq6NZLP7lPz6NimY04Ad0kSWvcZ1nvCGUQvdxjniX92BT4
         HdnyKEvpgss1Xats7Byg2sgL6j3LduTuEA8DbR0yPVjl+a5HZBZvFAfBcnOUysiXQMLd
         SP3rrCjD2FPBy8NLSzwCW3Z2W3PH7tIR1l0l7tJtihR3LHq0pR/BgxeaL+VM75+EkQwn
         Z1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I0nfqSqzuzoOBPv7mcSdmp3bMcP96BtuMMzceqfKSHY=;
        b=b3NoZYdJTr0fkp5E3h3YOCyACJJduNTNICfsdbsKMuSYbftuD2Ma45EdtlVocruQyH
         HfIp9CQ5O+5LbphXxq6EgarX9CD6VcEhnV+nUzCNvNWTuCVmm7FQy7MHknqXgY+IIVr3
         ZwjoX938MCIx+9rfQz0E+twN+xAFJnZJsbSAFd7YDP24hOQL2W94fQ+UmCCXzess8HJZ
         Iu/Vh1kRSZQAbahjPveI6FZ/yOQDHXXAFmF8ouADO0d7P5xc2/MEKL0Mv2RADg61bHKb
         hWTpYVY3719eRr7b2xnBGHw3UJxglMJevOBg45kBECxAG5bvYUMabrHYL/Rx7NbEM1PX
         c2iQ==
X-Gm-Message-State: AOAM533ikzJz+ocajfWM8UsVMhJ6wlG4FSh8ZcSDynHaUKv8/ujiDuCI
        ihDXTXX8Jo9Ov5b18AM4GxkQrY4Y2oWCQvoy
X-Google-Smtp-Source: ABdhPJx+KO56jhsdLthXdxaC8oop0qjrOY5t1e/D5vODde0kO5v9CUu/8o/jO+hLXZWTIQjXbKaQTA==
X-Received: by 2002:a05:6512:410:: with SMTP id u16mr15664838lfk.641.1619505538497;
        Mon, 26 Apr 2021 23:38:58 -0700 (PDT)
Received: from [10.0.0.42] (91-155-111-71.elisa-laajakaista.fi. [91.155.111.71])
        by smtp.gmail.com with ESMTPSA id w23sm1621933lfu.132.2021.04.26.23.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 23:38:57 -0700 (PDT)
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, amistry@google.com,
        nartemiev@google.com, Alexander.Deucher@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1619195089-29710-1-git-send-email-Vijendar.Mukunda@amd.com>
 <20210423164617.GG5507@sirena.org.uk>
 <e1268120-7a91-da49-0bb6-89d5cb4e2cce@gmail.com>
 <b32fcc42-d67e-bfbd-ed83-7f7274fb2f79@amd.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: dwc: add a quirk DW_I2S_QUIRK_STOP_ON_SHUTDOWN
 to dwc driver
Message-ID: <ac5244d1-643d-6577-80cd-bf6867e75ca2@gmail.com>
Date:   Tue, 27 Apr 2021 09:40:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <b32fcc42-d67e-bfbd-ed83-7f7274fb2f79@amd.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/21 3:21 PM, Mukunda,Vijendar wrote:

>>> What is the design constraint here - can't we fix the design?  Or is it
>>> a hardware design constraint (presumably broken signalling between the
>>> I2S and DMA blocks)?
> 
> Its a hardware design constraint.
> 
> 
> I2S driver is not directly exposing DMA interface to host.
> ACP 2.x has unique design where ACP driver controls data flow between
> host and I2S as mentioned above.
> ACP IP has different IP blocks within it which includes I2S controller
> and DMA controller.
> 
> ACP DMA Driver is responsible for DMA transactions between system memory
> and I2S controller.It uses two step DMA mechanism to copy data between
> system memory <-> ACP SRAM and ACP SRAM <-> I2S FIFO for
> playback/capture use cases.
> ACP driver program two DMA channels for DMA transfers between System
> memory & I2S FIFO.
> 
> ACP DMA driver isn't general purpose DMA controller driver where we can
> implement terminate_all() API.
> 
> I2S controller DMA transactions are tightly coupled with ACP DMA
> controller.
> while DMA transfer ongoing between ACP SRAM and I2S FIFO, Stopping I2S
> DMA prior to ACP DMA stop resulting DMA Channel stop failure.
> Its not related to I2S FIFO flushing related handling.
> Once the DMA channel failure observed during the closure of the stream,
> when again new stream opened, DMA won't progress at all.

Thanks for the explanation.
This is not upstream, right?

What is still not clear to me is which channel fails?
A) the DMA between ACP FIFO and the I2S
B) the DMA between ACP FIFO and system memory

in acp-pcm-dma.c on stop you have a busy loop (10000 iterations) to
check if the channel is in fact stopped in response to the cleared run,
IOCEn bits and the set Rst bit.

Channel closer to the destination is stopped first which sounds
reasonable, but on playback you ignore timeout from A, on capture you
ignore the timeout from B.

Still the issue sounds like exactly what I have described. One of the
DMA is failing to drain because the IP is stopped?

> Need find a right place to implement a work around only for AMD
> stoneyridge platform.

Is this really only affecting stoneyridge platform? Are there other
platforms using drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c ?

-- 
Péter
