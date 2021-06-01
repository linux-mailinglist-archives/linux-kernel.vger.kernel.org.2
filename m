Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB11838E276
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 10:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhEXIox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 04:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhEXIov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 04:44:51 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C4CC06138A
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 01:43:23 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id h12so2118249plf.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 01:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MjMSw6JkJ3i+fscbkM2syJzOK3oeShi36fMtZEjyMNs=;
        b=nohoYVKtZXuHTwTn3O8RxPNvaAdv5rJX7Zo8d90Wii3cPlFrjzdoDpSQoC7IHxEaCU
         DcZhtSHAmxLE1GpFjM0WFDWJXinPAEOcEgD9VrVFWeuUmTK6dhRY3XYsVFrLg71xLx6n
         tRCu3Xj5l9V8dMf8y+/hfkQh23Lq2TyslSG03i0fBXscXS9xmiJGr2NUsoVIkCs+Gm6N
         8G7UwzQo89K0NHgiHr3CBOKGB5rhH3diq9oazfAyFAgGMogJXpHqCcDkyEhrRdIUqs42
         6jA1T2OXYEyi5iBCqv8UK3+g4h0D6+ESHpNdBua38AjwgqZKtQE7j5xrX6AB9hsduB44
         sK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MjMSw6JkJ3i+fscbkM2syJzOK3oeShi36fMtZEjyMNs=;
        b=tezLuW1Vpdavgyxx1gWDTHz4r72tfLEYogF4l4ToaxZk8YvV+DaKdIKmgSQOxK0Ma4
         lo0vMXD39zJFvYQARTyRj1GZmEuJamFUvLMUby902020fhhQRmR+OvpD0gHn+Yz0uAmT
         hLnrLOHQx9g7RGlm05eqOzI35wHhHZbSCBBv4q+UBzAlqCAKpa2TcxBZY09MzqBtAeAq
         96Rs94qo3Gih8XD27y+ccKFKL+FYhmLIZyjPoKn9C9/YWR18jmLq/Yy0grIAyeqRESJ7
         TZZ0CFq9GCYGQKHiqgz/WShYLKNcOGEbfsjTq29VsFROamvStab4m+q+9dcGFYheyF5E
         LfuQ==
X-Gm-Message-State: AOAM532JuSC01W3tY0pp1tSfxHgXCedcG51pNAj+Vdrwyn7CqEDn3DCY
        YJQe4URNUKDG7usgjEng9fqy
X-Google-Smtp-Source: ABdhPJxkPjTW5y7cL79NQ02rVczpjAotpBArCZGu1B5M/vZwN1ohB6tRfUPnfVcMZZ/YTL3HOcGZbA==
X-Received: by 2002:a17:90a:520f:: with SMTP id v15mr23501633pjh.23.1621845802722;
        Mon, 24 May 2021 01:43:22 -0700 (PDT)
Received: from work ([120.138.12.242])
        by smtp.gmail.com with ESMTPSA id q3sm10629201pff.142.2021.05.24.01.43.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 May 2021 01:43:22 -0700 (PDT)
Date:   Mon, 24 May 2021 14:13:18 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Baochen Qiang <bqiang@codeaurora.org>, hemantk@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath11k@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] bus: mhi: Wait for M2 state during system resume
Message-ID: <20210524084318.GA27389@work>
References: <20210524040312.14409-1-bqiang@codeaurora.org>
 <YKtPXWrTb6Qj+E9l@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKtPXWrTb6Qj+E9l@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 09:01:49AM +0200, Greg KH wrote:
> On Mon, May 24, 2021 at 12:03:12PM +0800, Baochen Qiang wrote:
> > During system resume, MHI host triggers M3->M0 transition and then waits
> > for target device to enter M0 state. Once done, the device queues a state
> > change event into ctrl event ring and notifies MHI host by raising an
> > interrupt, where a tasklet is scheduled to process this event. In most cases,
> > the tasklet is served timely and wait operation succeeds.
> > 
> > However, there are cases where CPU is busy and cannot serve this tasklet
> > for some time. Once delay goes long enough, the device moves itself to M1
> > state and also interrupts MHI host after inserting a new state change
> > event to ctrl ring. Later CPU finally has time to process the ring, however
> > there are two events in it now:
> > 	1. for M3->M0 event, which is processed first as queued first,
> > 	   tasklet handler updates device state to M0 and wakes up the task,
> > 	   i.e., the MHI host.
> > 	2. for M0->M1 event, which is processed later, tasklet handler
> > 	   triggers M1->M2 transition and updates device state to M2 directly,
> > 	   then wakes up the MHI host(if still sleeping on this wait queue).
> > Note that although MHI host has been woken up while processing the first
> > event, it may still has no chance to run before the second event is processed.
> > In other words, MHI host has to keep waiting till timeout cause the M0 state
> > has been missed.
> > 
> > kernel log here:
> > ...
> > Apr 15 01:45:14 test-NUC8i7HVK kernel: [ 4247.911251] mhi 0000:06:00.0: Entered with PM state: M3, MHI state: M3
> > Apr 15 01:45:14 test-NUC8i7HVK kernel: [ 4247.917762] mhi 0000:06:00.0: State change event to state: M0
> > Apr 15 01:45:14 test-NUC8i7HVK kernel: [ 4247.917767] mhi 0000:06:00.0: State change event to state: M1
> > Apr 15 01:45:14 test-NUC8i7HVK kernel: [ 4338.788231] mhi 0000:06:00.0: Did not enter M0 state, MHI state: M2, PM state: M2
> > ...
> > 
> > Fix this issue by simply adding M2 as a valid state for resume.
> > 
> > Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> > 
> > Fixes: 0c6b20a1d720 ("bus: mhi: core: Add support for MHI suspend and resume")
> > Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
> > Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
> > ---
> >  drivers/bus/mhi/core/pm.c | 1 +
> >  1 file changed, 1 insertion(+)
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 

I've applied this patch to mhi tree with tag "Cc: stable@vger.kernel.org".

Thanks,
Mani

> </formletter>
