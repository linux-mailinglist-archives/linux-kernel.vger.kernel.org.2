Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C76D38E08C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 06:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhEXE77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 00:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhEXE76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 00:59:58 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF515C061756
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 21:58:29 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d78so18979202pfd.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 21:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1ZYaJzg8EfGTG1YeFB1KyajqSUT6MB2q2X9Re4Ft+nw=;
        b=QpGnnJc2Tb1UEE7G3EnRIds1WFTSQS/3IYFhN5NB1mCThWYLnzHZRMsvpQS8FOV1iP
         oQBCNXR/jLpzVqr6JKVKe+R8B9fa5zy4t2pQQId55UfuG04FlZAKIgjy4dDvJXkmyU2N
         dirg1foJ3iYCVhR0yU2o7NIb+9wViqBNjdUPyU2VxRe1LFE/lfkmRZ3lU/bN9rDs/dwL
         2FkJVaDfL2wMisoaA5zBIfTuNLreUtmP/UVBVU56l83eg9albvBN816TBp3sukmjPISM
         K4V5tLlpVYfBa4hXez4xPDwTfABLoK2kdSQ4U9vOAhtr8Nur+q0PyEy3WGb5Uh/nbyRN
         eKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1ZYaJzg8EfGTG1YeFB1KyajqSUT6MB2q2X9Re4Ft+nw=;
        b=Z2IuzJh5hglUejPA/8riBILiPjah0Wc4GuimYjPdKtZfvqE3Ybg/4lV7DviD6OAnZC
         XfvRRDxkRZIsOlqT0BwxaAyMhsWJuncbTCrUarL8C7iwERHs9NebzoNtIyAvOL/TOnIW
         cAM/bn2mg6A3r54vkTmmOlKsHBQTdAKB79cW79mQDiUrgi47ORmWfCCfwiKhyZk9bqNV
         Mo/xFZ8+lyS0qLCGfluYV4CoO2NThJ8gDt9pkSSX1AZNs2F34fjQRdnifazU9R9HYxAg
         J70/FxlpHcjGlov65nG3dOFHRK9xLm6yF3WSvyyNU98stxpj8nj7L1yOBTTbIQcS9IvH
         Cdzg==
X-Gm-Message-State: AOAM531ct68SWlGpHzXWs7EN98hi8ScyI1ZcGzyDX5y6/DDJm2VNKR3+
        v4MTse32+bDzb6jOeMNpTV03Vm/FIw0C
X-Google-Smtp-Source: ABdhPJzbYXJg0d7860GaWT42y4HEWTc3wQrKrsk/TEnPoqjFti276Sc54G9ltl/uRfd3wgq5m8vZ5A==
X-Received: by 2002:a62:384c:0:b029:2dd:423b:6e49 with SMTP id f73-20020a62384c0000b02902dd423b6e49mr23220503pfa.9.1621832309175;
        Sun, 23 May 2021 21:58:29 -0700 (PDT)
Received: from work ([120.138.12.48])
        by smtp.gmail.com with ESMTPSA id w2sm9341621pjq.5.2021.05.23.21.58.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 May 2021 21:58:28 -0700 (PDT)
Date:   Mon, 24 May 2021 10:28:25 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Subject: Re: [PATCH] bus: mhi: core: Validate channel ID when processing
 command completions
Message-ID: <20210524045825.GE8823@work>
References: <1619481538-4435-1-git-send-email-bbhatt@codeaurora.org>
 <20210524044228.GD8823@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524044228.GD8823@work>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 10:12:28AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Apr 26, 2021 at 04:58:58PM -0700, Bhaumik Bhatt wrote:
> > MHI reads the channel ID from the event ring element sent by the
> > device which can be any value between 0 and 255. In order to
> > prevent any out of bound accesses, add a check against the maximum
> > number of channels supported by the controller and those channels
> > not configured yet so as to skip processing of that event ring
> > element.
> > 
> > Fixes: 1d3173a3bae7 ("bus: mhi: core: Add support for processing events from client device")
> > Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> 
> Applied to mhi-next!
> 

Sorry this has been applied to mhi-next!

Thanks,
Mani

> Thanks,
> Mani
> 
> > ---
> >  drivers/bus/mhi/core/main.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> > index 22acde1..ed07421 100644
> > --- a/drivers/bus/mhi/core/main.c
> > +++ b/drivers/bus/mhi/core/main.c
> > @@ -773,11 +773,16 @@ static void mhi_process_cmd_completion(struct mhi_controller *mhi_cntrl,
> >  	cmd_pkt = mhi_to_virtual(mhi_ring, ptr);
> >  
> >  	chan = MHI_TRE_GET_CMD_CHID(cmd_pkt);
> > -	mhi_chan = &mhi_cntrl->mhi_chan[chan];
> > -	write_lock_bh(&mhi_chan->lock);
> > -	mhi_chan->ccs = MHI_TRE_GET_EV_CODE(tre);
> > -	complete(&mhi_chan->completion);
> > -	write_unlock_bh(&mhi_chan->lock);
> > +	WARN_ON(chan >= mhi_cntrl->max_chan);
> > +
> > +	if (chan < mhi_cntrl->max_chan &&
> > +	    mhi_cntrl->mhi_chan[chan].configured) {
> > +		mhi_chan = &mhi_cntrl->mhi_chan[chan];
> > +		write_lock_bh(&mhi_chan->lock);
> > +		mhi_chan->ccs = MHI_TRE_GET_EV_CODE(tre);
> > +		complete(&mhi_chan->completion);
> > +		write_unlock_bh(&mhi_chan->lock);
> > +	}
> >  
> >  	mhi_del_ring_element(mhi_cntrl, mhi_ring);
> >  }
> > -- 
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> > a Linux Foundation Collaborative Project
> > 
