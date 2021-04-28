Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0968C36D1FD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 08:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbhD1GFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 02:05:03 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:11733 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236106AbhD1GFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 02:05:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619589858; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=bx8J2U/YCTnNf7agVEpn/+hCnhROmQM6fBoT0Bn6L04=;
 b=oTtSfw+nQnaMrNqdq/Y5zhABgRfy/i6X9cecITi2CSVitcTnDsuqm1Qf9UqnRASLMe+/vCSn
 z1T3gArvY4Rsg/AU7gczU9Ps2de9HtJ3iuQdpCGXPhZ/BsPibsoATkfic6o6UtJNw7FMEzUA
 pWC39/JAtYEAZ9j/WoAie2ZoOB8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6088fae02cc44d3aeae56823 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 28 Apr 2021 06:04:16
 GMT
Sender: skakit=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C5B95C43460; Wed, 28 Apr 2021 06:04:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: skakit)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 79399C4338A;
        Wed, 28 Apr 2021 06:04:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 28 Apr 2021 11:34:16 +0530
From:   skakit@codeaurora.org
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org
Subject: Re: [RESEND PATCH V3 5/5] arm64: dts: qcom: sc7280: Include PMIC DT
 files for sc7280
In-Reply-To: <YH8XIyp/l4C0JPvc@google.com>
References: <1618398783-7834-1-git-send-email-skakit@codeaurora.org>
 <1618398783-7834-6-git-send-email-skakit@codeaurora.org>
 <YH8XIyp/l4C0JPvc@google.com>
Message-ID: <62b11bc7706d4d9e335f9f1cc09c98bc@codeaurora.org>
X-Sender: skakit@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-20 23:32, Matthias Kaehlcke wrote:
> On Wed, Apr 14, 2021 at 04:43:03PM +0530, satya priya wrote:
> 
>> Subject: arm64: dts: qcom: sc7280: Include PMIC DT files for sc7280
> 
> Please make sure to distinguish between the SoC (sc7280) and the
> board (sc7280-idp), this patch primarily adds stuff to the board not
> the SoC, this should be clear from the subject.
> 

Sure, will mention sc7280-idp in the subject.

>> Include pm7325, pm8350c, pmk8350 and pmr735a DT files.
> 
> How about something like 'The sc7280-idp has four PMICs, include their
> .dtsi files'?
> 

Okay.

>> Add channel nodes for pmk8350_vadc.
> 
> It's not super important, but I don't like it when things like this get
> sneaked in with a commit message saying 'Include PMIC DT files for
> sc7280'. I would suggest a separate patch. And please mention that
> the channels are for the on die temperatures of the PMICs.
> 

Okay, will make a separate patch for adding channel nodes.

>> Also, add the thermal_zones node in dtsi.
> 
> This is not the right patch to add it. This patch is about the 
> sc7280-board
> and doesn't do anything (directly) with thermal zones. However other
> patches further down in the stack of in this series require the
> 'thermal-zones' to exist, hence the node should exist before these 
> patches
> reference it. A dedicated patch adding the node seems like the best 
> option
> to me.

Okay, I will add a separate patch for adding thermal-zones node and 
place it in the beginning of the series.

Thanks,
Satya Priya
