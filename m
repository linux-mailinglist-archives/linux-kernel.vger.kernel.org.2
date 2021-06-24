Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7798B3B31BC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 16:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhFXOuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 10:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhFXOuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:50:17 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEC9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 07:47:58 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso3623518pjp.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 07:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IrG0wOJ5P1GDUb+N+U96ej0QrbrzyokARjLQb7OkIzM=;
        b=PllruDXKPfp5ngayDBicU57D3b5d9Ho9G0eKRxR3h4KSjbdiHBNEqdth7FeaMmv48/
         JnQQpErBny0euY8EgBE9kI0Ooy7wQ43yZ8mOp5Vq9zrPz2cnopGTyq5W9RDPljqaOzPA
         UpG/1Cgqv2k7Jp+16NpjHgsr6arxjASe1mC4JOonbhd5AFV7tVenezfWrytURA4O7NjP
         TMx6DOlHjFnnYlpJg25AFFhxb7MYGTZAMI/7htRv+Bykl2Bx2yfjCECdKVneaEB6MauM
         TvdWfSaxIF5wxk6EnlZ3huT5m1kJoHrQLlzoLk2b+FRn9tgod+u9Hd1ZuwQekXxJLUk3
         uXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IrG0wOJ5P1GDUb+N+U96ej0QrbrzyokARjLQb7OkIzM=;
        b=CcVnSSEneghdVBzMHb3Ff3AK4A2hWZ6V7KbHGraO7LpZzSAPaR636B3Vjl/hOJnF8K
         0uFhr+MnLRb/NCgWFohBrrYzNWvql659dkdz4Sbsl4oaAc6h+6LoTAIJ1IZOn27ewiDA
         sW0Bc5Klm1Hu+vk7ToaIiK2l3PW9Ms9yhuspo6jXbh1SZIapyfg2+NTmHhLkYhxqO5A0
         7zDX3pbfk2MA9hpjl3tPNXg5Vesz6EHEh1dl5SmgcO/XyZgnI/liEKO9Ej6h17Wlfy/b
         8zPOTg2IvKtAGI86IVCo4x2kOZCqFy6ZmjxMIjXS1rZvWuFStGnR2nrbBj75ZfkKMLRs
         gIVg==
X-Gm-Message-State: AOAM533Rz4zn6fqmxPztQ9KOm9zcsQY5m7GS2AYz63LQxw1JGgxc8HTq
        f7MUQoFqp9p18AJYbzUf/Nfo
X-Google-Smtp-Source: ABdhPJxcIW3X52gLYnHUODRyuXIH49B1VqMlFBV7YVfbRIBVgWvMUf2mQe5qRDvbB6Ubs2TX2+/Yfg==
X-Received: by 2002:a17:90a:7c43:: with SMTP id e3mr5725560pjl.5.1624546077116;
        Thu, 24 Jun 2021 07:47:57 -0700 (PDT)
Received: from workstation ([120.138.12.173])
        by smtp.gmail.com with ESMTPSA id ne11sm8422359pjb.40.2021.06.24.07.47.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jun 2021 07:47:56 -0700 (PDT)
Date:   Thu, 24 Jun 2021 20:17:52 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, stable@vger.kernel.org,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: Re: [PATCH 1/8] bus: mhi: core: Validate channel ID when processing
 command completions
Message-ID: <20210624144752.GD6108@workstation>
References: <20210621161616.77524-1-manivannan.sadhasivam@linaro.org>
 <20210621161616.77524-2-manivannan.sadhasivam@linaro.org>
 <YNSNtQxVaegArG2f@kroah.com>
 <20210624143248.GC6108@workstation>
 <YNSZNxMjX/vNvae+@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNSZNxMjX/vNvae+@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 04:39:51PM +0200, Greg KH wrote:
> On Thu, Jun 24, 2021 at 08:02:48PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Jun 24, 2021 at 03:50:45PM +0200, Greg KH wrote:
> > > On Mon, Jun 21, 2021 at 09:46:09PM +0530, Manivannan Sadhasivam wrote:
> > > > From: Bhaumik Bhatt <bbhatt@codeaurora.org>
> > > > 
> > > > MHI reads the channel ID from the event ring element sent by the
> > > > device which can be any value between 0 and 255. In order to
> > > > prevent any out of bound accesses, add a check against the maximum
> > > > number of channels supported by the controller and those channels
> > > > not configured yet so as to skip processing of that event ring
> > > > element.
> > > > 
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 1d3173a3bae7 ("bus: mhi: core: Add support for processing events from client device")
> > > > Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> > > > Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
> > > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > > > Link: https://lore.kernel.org/r/1619481538-4435-1-git-send-email-bbhatt@codeaurora.org
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  drivers/bus/mhi/core/main.c | 15 ++++++++++-----
> > > >  1 file changed, 10 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> > > > index 22acde118bc3..ed07421c4870 100644
> > > > --- a/drivers/bus/mhi/core/main.c
> > > > +++ b/drivers/bus/mhi/core/main.c
> > > > @@ -773,11 +773,16 @@ static void mhi_process_cmd_completion(struct mhi_controller *mhi_cntrl,
> > > >  	cmd_pkt = mhi_to_virtual(mhi_ring, ptr);
> > > >  
> > > >  	chan = MHI_TRE_GET_CMD_CHID(cmd_pkt);
> > > > -	mhi_chan = &mhi_cntrl->mhi_chan[chan];
> > > > -	write_lock_bh(&mhi_chan->lock);
> > > > -	mhi_chan->ccs = MHI_TRE_GET_EV_CODE(tre);
> > > > -	complete(&mhi_chan->completion);
> > > > -	write_unlock_bh(&mhi_chan->lock);
> > > > +	WARN_ON(chan >= mhi_cntrl->max_chan);
> > > 
> > > What can ever trigger this WARN_ON()?  Do you mean to reboot a machine
> > > if panic-on-warn is set?
> > > 
> > > If this can actually happen, then check for it and recover properly,
> > > don't just blindly warn and then keep on going.
> > > 
> > 
> > We can't do much here other than warning the user and dropping the
> > command.
> 
> But you didn't warn anyone.  Well, you rebooted the machine, is that ok?
> If this can be triggered by a user, this should never happen.
> 
> Do not use WARN_ON() ever please.
> 
> > There is no recovery possible because, the device has sent the command
> > completion event on a wrong channel. It can't happen usually unless a
> > malcious device sits on the other end.
> 
> Then just eat the message and move on, please do not crash the box.
> 

Okay. We'll spit an error message and drop the event.

Thanks,
Mani

> thanks,
> 
> gre k-h
