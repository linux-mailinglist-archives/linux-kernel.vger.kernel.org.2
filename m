Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72D236AC15
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 08:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhDZGTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 02:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhDZGTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 02:19:15 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B46C061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 23:18:32 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 12so86276800lfq.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 23:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3/FI0KZmj3/CnqR1rFz6WI/MezYTXitzSUOb5NDvbRs=;
        b=UH+91n2GgKGYLhNJGgbWrMmFMSQp7+hB3JdqzI4Z5Jpt48DTVc0Uc2QgUpeJ1cntOz
         dv4+aLPU7I5FYp0feRXoQ4SXU+n0H55FzFX55kylUeOSDN29GvtzaRrydnWqJz/jBVNq
         zxHjCv/F/bKptm6xJzyhUW4k2Zk8m0GgWo+GT1rWCODNSraG9D+NvQhLqyg/cqVnjNxx
         CZG0H1Eni+ylpIxmj0iS+qRGM6sNz1rxuAcfoG2DjhzUHanGO29Lwga8fdgvpYTez5Rt
         kfi2gWd1KKSgj5iRej3rY5aeZ/JPX+mb2BXKfV5Bh3p7OGbGbu9YIWTIhbLFECRgVZeQ
         cxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3/FI0KZmj3/CnqR1rFz6WI/MezYTXitzSUOb5NDvbRs=;
        b=D/IGRbSnWe/dR17g7FfHQN9lc55daS+J9OOaPv3/0CWziHHb36GQnfhy/PHJgZl3en
         X1UVzZcRcDD96wu+KJ+AzYpUiDzOTsXXeCtZEIwcXWxw/WfMYQuiBysdGAb6mXiX7wk9
         p4BC0RGzzDnSo8JbeAweOznaccFWJr5XZEItatiuLoAm1BY6qj0zQmqXs/6zhiUCAfpe
         9kpxWzRHI2bsmgTspmSuWlafBF7h+96s88jNvpfOyhNPVi7FXtjGnD/tB9pliS6t5Ahy
         d7HMsE8IRcIeMNxcOAnOkeN3U+SUJ0MbawdYbzNPjchUjLOXjQziyxllp0O8qIrGUY1n
         KjoA==
X-Gm-Message-State: AOAM532Vf7iwaJqyc+IOqRirXj5d+PjEyLTaaFtx951Gm7MpF06ody22
        i/+Rl9NgOaf6Kt9LrsSnzApS2Vfclh3vxw==
X-Google-Smtp-Source: ABdhPJxdnk6vol2grAYYXH63/e4b+6M+0f15V1fJOR5NpMu07HNj6554KPRrwkxAZObzYkxVzgLIIQ==
X-Received: by 2002:ac2:5dc9:: with SMTP id x9mr11800050lfq.215.1619417910333;
        Sun, 25 Apr 2021 23:18:30 -0700 (PDT)
Received: from [10.0.0.42] (91-155-111-71.elisa-laajakaista.fi. [91.155.111.71])
        by smtp.gmail.com with ESMTPSA id v8sm1413972ljn.17.2021.04.25.23.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Apr 2021 23:18:29 -0700 (PDT)
To:     Mark Brown <broonie@kernel.org>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
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
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: dwc: add a quirk DW_I2S_QUIRK_STOP_ON_SHUTDOWN
 to dwc driver
Message-ID: <e1268120-7a91-da49-0bb6-89d5cb4e2cce@gmail.com>
Date:   Mon, 26 Apr 2021 09:19:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210423164617.GG5507@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/23/21 7:46 PM, Mark Brown wrote:
> On Fri, Apr 23, 2021 at 09:54:38PM +0530, Vijendar Mukunda wrote:
> 
>> For CZ/StoneyRidge platforms, ACP DMA between ACP SRAM and
>> I2S FIFO should be stopped before stopping I2S Controller DMA.
> 
>> When DMA is progressing and stop request received, while DMA transfer
>> ongoing between ACP SRAM and I2S FIFO, Stopping I2S DMA prior to ACP DMA
>> stop resulting DMA Channel stop failure.
> 
> This again...  copying in Peter for the sequencing discussion.  If we
> need to do this I'm not convinced that bodging it in the driver is a
> good idea, and especially not deferring it outside of the trigger
> operation - for example on a suspend or pause we won't actually do a
> shutdown() so the trigger will end up not happening which seems like it
> may cause problems.

It will certainly leave the i2s running and can lead to hard to explain
issues

> We'd probably be better off with the core knowing
> what's going on and being able to reorder the callbacks although
> designing an interface for that seems a bit annoying.

I agree, it would be better to have some sort of flag which tells the
core that there is an integration issue between the DMA and peripheral.
I believe this is only affecting playback?

>> This issue can't be fixed in ACP DMA driver due to design constraint.
> 
> What is the design constraint here - can't we fix the design?  Or is it
> a hardware design constraint (presumably broken signalling between the
> I2S and DMA blocks)?

From the description my guess is that stop on the DMA want to flush it's
FIFO (complete the in progress packet, segment). Since the peripheral is
stopped it will not pull in more data -> the DMA will time out internally.

The question: how the ACP DMA driver's terminate_all is implemented? It
can not really wait for the DMA to stop, we can not use
terminate_all_sync() in trigger, it must just set a stop bit and make
sure at synchronize() time that it has stopped, right?

What happens if the time between the DMA stop and the DAI stop is less
then it would take to flush the DMA FIFO? You would have the same issue,
but in a rather hard to reproducible way?

As sidenote: TI's k3-udma initially had similar issue at the design
phase on the playback side which got solved by a flush bit on the
channel to detach it from the peripheral and set it to free run to drain
w/o peripheral.
On capture however I need to push a dummy 'drain' packet to flush out
the data from the DMA (if the stop happens when we did not have active
descriptor on the channel).

With a flag to reorder the DMA/DAI stop sequence it might work most of
the time, but imho it is going to introduce a nasty time-bomb of failure.
Also your DAI will underflow instead of the DMA error.

-- 
Péter
