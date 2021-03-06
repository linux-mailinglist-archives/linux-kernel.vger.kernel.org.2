Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EFA32F910
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 10:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhCFJAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 04:00:39 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:53894 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhCFJAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 04:00:11 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615021211; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=4O+BDcUsTwAJ0Q/tMdqZtFjth14qHp7/WTpizzlIIxU=; b=RiQHP6ymk944i3OyZgFVZyf9u2rr6GtLBOcGKJkx4Q+fxnior1OlHLEwj3RVcY+2pniH0SfC
 xwrYtd40s2gtyeHFgMV37AhHaQLAGZvLK8wXDEJA+QD6WNqYSzZLNN8AlscfA8Jf5QXwC2Dq
 lXXXaU8H5j+QgoWoOVDCHANRhLk=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 604344967b648e2436c80f78 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 06 Mar 2021 09:00:06
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C0A79C43464; Sat,  6 Mar 2021 09:00:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.110.25.174] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7E5CBC433C6;
        Sat,  6 Mar 2021 09:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7E5CBC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH v3 2/2] usb: dwc3: Fix DRD mode change sequence following
 programming guide
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Yang Fei <fei.yang@intel.com>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
References: <20210108015115.27920-1-john.stultz@linaro.org>
 <20210108015115.27920-2-john.stultz@linaro.org>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <eb4b8540-a57c-53cc-a371-cf68178bec15@codeaurora.org>
Date:   Sat, 6 Mar 2021 01:00:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210108015115.27920-2-john.stultz@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/7/2021 5:51 PM, John Stultz wrote:
> In reviewing the previous patch, Thinh Nguyen pointed out that
> the DRD mode change sequence should be like the following when
> switching from host -> device according to the programming guide
> (for all DRD IPs):
> 1. Reset controller with GCTL.CoreSoftReset
> 2. Set GCTL.PrtCapDir(device)
> 3. Soft reset with DCTL.CSftRst
> 4. Then follow up with the initializing registers sequence
> 
> The current code does:
> a. Soft reset with DCTL.CSftRst on driver probe
> b. Reset controller with GCTL.CoreSoftReset (added in previous
>    patch)
> c. Set GCTL.PrtCapDir(device)
> d. < missing DCTL.CSftRst >
> e. Then follow up with initializing registers sequence
> 
> So this patch adds the DCTL.CSftRst soft reset that was currently
> missing from the dwc3 mode switching.
> 
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Tejas Joglekar <tejas.joglekar@synopsys.com>
> Cc: Yang Fei <fei.yang@intel.com>
> Cc: YongQin Liu <yongqin.liu@linaro.org>
> Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> Cc: Thinh Nguyen <thinhn@synopsys.com>
> Cc: Jun Li <lijun.kernel@gmail.com>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> Feedback would be appreciated. I'm a little worried I should be
> conditionalizing the DCTL.CSftRst on DRD mode controllers, but
> I'm really not sure what the right thing to do is for non-DRD
> mode controllers.
> ---
>  drivers/usb/dwc3/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index b6a6b90eb2d5..71f8b07ecb99 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -40,6 +40,8 @@
>  
>  #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
>  
> +static int dwc3_core_soft_reset(struct dwc3 *dwc);
> +
>  /**
>   * dwc3_get_dr_mode - Validates and sets dr_mode
>   * @dwc: pointer to our context structure
> @@ -177,6 +179,7 @@ static void __dwc3_set_mode(struct work_struct *work)
>  
>  	dwc3_set_prtcap(dwc, dwc->desired_dr_role);
>  
> +	dwc3_core_soft_reset(dwc);

Hi John/Thinh/Felipe,

I actually added this change into my local branch, because we were
seeing an issue when switching from host mode --> peripheral mode.  What
was happening was that the RXFIFO register did not update back to the
expected value for peripheral mode by the time
dwc3_gadget_init_out_endpoint() was executed.  With the logic to
calculate the EP max packet limit based on RXFIFO reg, this caused all
EPs to be set with an EP max limit of 0.

With this change, it seemed to help with the above issue.  However, can
we consider moving the core soft reset outside the spinlock?  At least
with our PHY init routines, we have some msleep() calls for waiting for
the PHYs to be ready, which will end up as a sleeping while atomic bug.
(not sure if PHY init is required to be called in atomic context)

Thanks
Wesley Cheng

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
