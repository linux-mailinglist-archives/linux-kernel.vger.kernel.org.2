Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161043B3305
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 17:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhFXP6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 11:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbhFXP62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 11:58:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FC8C061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 08:56:08 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id bb20so3734549pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 08:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uIiql1BdK0KN1vEcz6LaOBJV1Hbz8F0F5x5kSRn1/hQ=;
        b=myi4BcePr2SxyvO6FD/KI7+94QoXAUpid+fsm3JZMGUD7H+UqppJ0hbcrhs00aA5ZL
         MRF1IXoaQEFarG+k4XjIg+znZlEYeE5hLVYh6wZFUcRwnaFju0+kSwnGyU3u0XxU1fZ0
         eaxPIfBKD/OiiJ2U4keU8e2zvMJHxEArcfnr/RPbY0lotE2VdU1fu0Kn7LutxGntKft5
         wRyb5NxdYjJTSPQuut65YO7SFNgwDDlP3e3FACfEK/I0MZ3H5VsytNUvfT6YI3hmCnHA
         e57+/bXttqwWizqxEvxbXTeTOZqVIjCa2/I7BoJE3AkTOFPq4STse8RCBkwyny3l97yp
         WBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uIiql1BdK0KN1vEcz6LaOBJV1Hbz8F0F5x5kSRn1/hQ=;
        b=qZF6LnwRk9bSpz/fwr9D4eyKnAlan+mLyCPFU1ewR7+N95HZW4Yc7aoI8cuFmBDlOo
         jlXb9jfNQ9aaf1Yk4PimkmfvvCCCd3XAZBPoToj3X2eKdNJ9zk2f9RjEzWwQnNlS4F/k
         oHxVqAfbIxd2emaQpmA/8x+DVviLVBfoIepel6D6rd5X4UCG6fkzzAEZfIKSXVYfFVxm
         QbYsRqZEcskB/L77zvtoTBC3x24PYYvDucQMy6MmJIfVTc80A9hY74rxuHx0GekYD1a/
         RTlNW/fbfoFRMF1CC03FKUppVFIrBIaa1sWNMSzTOmHIcEUz4D8YfOX6MfxYFM+M0BwN
         nGpA==
X-Gm-Message-State: AOAM533vLhCPkQ0ZPdGzoe+LOuxbd/SIJTWxuXy/H2aPlid2cZ175rvh
        nEdmxRN2FH9pmB5lSmT/eKN1IEL7Lib7
X-Google-Smtp-Source: ABdhPJxK8+gLbRAwn8nUuwGDGWzpweVrlt/7Sd2UCgvVr2knMTD4eGISuidKKzripm40ueO627udIA==
X-Received: by 2002:a17:90a:5312:: with SMTP id x18mr15699217pjh.25.1624550168335;
        Thu, 24 Jun 2021 08:56:08 -0700 (PDT)
Received: from thinkpad ([120.138.12.173])
        by smtp.gmail.com with ESMTPSA id b5sm2880023pgh.41.2021.06.24.08.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 08:56:07 -0700 (PDT)
Date:   Thu, 24 Jun 2021 21:26:02 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, stable@vger.kernel.org,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: Re: [PATCH 1/8] bus: mhi: core: Validate channel ID when processing
 command completions
Message-ID: <20210624155602.GA28535@thinkpad>
References: <20210621161616.77524-1-manivannan.sadhasivam@linaro.org>
 <20210621161616.77524-2-manivannan.sadhasivam@linaro.org>
 <YNSNtQxVaegArG2f@kroah.com>
 <20210624143248.GC6108@workstation>
 <YNSZNxMjX/vNvae+@kroah.com>
 <20210624144752.GD6108@workstation>
 <YNSkVZ4PzkDqX/g+@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNSkVZ4PzkDqX/g+@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 05:27:17PM +0200, Greg KH wrote:
> On Thu, Jun 24, 2021 at 08:17:52PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Jun 24, 2021 at 04:39:51PM +0200, Greg KH wrote:
> > > On Thu, Jun 24, 2021 at 08:02:48PM +0530, Manivannan Sadhasivam wrote:
> > > > On Thu, Jun 24, 2021 at 03:50:45PM +0200, Greg KH wrote:
> > > > > On Mon, Jun 21, 2021 at 09:46:09PM +0530, Manivannan Sadhasivam wrote:
> > > > > > From: Bhaumik Bhatt <bbhatt@codeaurora.org>
> > > > > > 
> > > > > > MHI reads the channel ID from the event ring element sent by the
> > > > > > device which can be any value between 0 and 255. In order to
> > > > > > prevent any out of bound accesses, add a check against the maximum
> > > > > > number of channels supported by the controller and those channels
> > > > > > not configured yet so as to skip processing of that event ring
> > > > > > element.
> > > > > > 
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Fixes: 1d3173a3bae7 ("bus: mhi: core: Add support for processing events from client device")
> > > > > > Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> > > > > > Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
> > > > > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > > Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > > > > > Link: https://lore.kernel.org/r/1619481538-4435-1-git-send-email-bbhatt@codeaurora.org
> > > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > > ---
> > > > > >  drivers/bus/mhi/core/main.c | 15 ++++++++++-----
> > > > > >  1 file changed, 10 insertions(+), 5 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> > > > > > index 22acde118bc3..ed07421c4870 100644
> > > > > > --- a/drivers/bus/mhi/core/main.c
> > > > > > +++ b/drivers/bus/mhi/core/main.c
> > > > > > @@ -773,11 +773,16 @@ static void mhi_process_cmd_completion(struct mhi_controller *mhi_cntrl,
> > > > > >  	cmd_pkt = mhi_to_virtual(mhi_ring, ptr);
> > > > > >  
> > > > > >  	chan = MHI_TRE_GET_CMD_CHID(cmd_pkt);
> > > > > > -	mhi_chan = &mhi_cntrl->mhi_chan[chan];
> > > > > > -	write_lock_bh(&mhi_chan->lock);
> > > > > > -	mhi_chan->ccs = MHI_TRE_GET_EV_CODE(tre);
> > > > > > -	complete(&mhi_chan->completion);
> > > > > > -	write_unlock_bh(&mhi_chan->lock);
> > > > > > +	WARN_ON(chan >= mhi_cntrl->max_chan);
> > > > > 
> > > > > What can ever trigger this WARN_ON()?  Do you mean to reboot a machine
> > > > > if panic-on-warn is set?
> > > > > 
> > > > > If this can actually happen, then check for it and recover properly,
> > > > > don't just blindly warn and then keep on going.
> > > > > 
> > > > 
> > > > We can't do much here other than warning the user and dropping the
> > > > command.
> > > 
> > > But you didn't warn anyone.  Well, you rebooted the machine, is that ok?
> > > If this can be triggered by a user, this should never happen.
> > > 
> > > Do not use WARN_ON() ever please.
> > > 
> > > > There is no recovery possible because, the device has sent the command
> > > > completion event on a wrong channel. It can't happen usually unless a
> > > > malcious device sits on the other end.
> > > 
> > > Then just eat the message and move on, please do not crash the box.
> > > 
> > 
> > Okay. We'll spit an error message and drop the event.
> 
> If this can be triggered by a user, don't provide a way to DoS the
> kernel error log.
> 

The term "user" is a bit vague here. Only a malcious device sits on the PCIe
bus that claims a defined VID/PID can trigger this error. And we do need to tell
the user of the host machine that the device tried to do something wrong.

So I guess the error log is fine here?

Thanks,
Mani

> thanks,
> 
> greg k-h
