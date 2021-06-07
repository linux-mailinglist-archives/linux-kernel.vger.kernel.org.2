Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07CE39E5DE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhFGRuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:50:07 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:34541 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhFGRuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:50:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623088095; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=MFuDFvHXYlR2gGa8jeKkSiXVOoZvWtSWsoYMxROMkaU=;
 b=K9f/JtNQhMSIQ1BpJ/G6hjQjAW0pejW79q8QDBmyDeT8cN3a06J+0CPAO0XUIGXiCwRg1H/i
 UfM4Tx6iBDROQW1bYJ7a0rMVJXNEMcG9fJXOS3Ptmqyrg/yKMpOqTjhJOKzV1EtYExUk8hSM
 ixgXNsiRQgSfvbsBhji2Z3kCUMg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60be5bd4f726fa41885a6c4a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 07 Jun 2021 17:48:04
 GMT
Sender: khsieh=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D122EC43460; Mon,  7 Jun 2021 17:48:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: khsieh)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5EB0FC4338A;
        Mon,  7 Jun 2021 17:48:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 07 Jun 2021 10:48:02 -0700
From:   khsieh@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        vkoul@kernel.org, agross@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/dts/qcom/sc7180: Add Display Port dt node
In-Reply-To: <YLxX/YtegtbLmkri@builder.lan>
References: <1622736555-15775-1-git-send-email-khsieh@codeaurora.org>
 <YLkI/6ItCz+SbbuJ@yoga> <ac326ec8689c0babb08b2311e19d52cc@codeaurora.org>
 <YLxX/YtegtbLmkri@builder.lan>
Message-ID: <ef1879fa7ecfefaf0c70c7a4782240a9@codeaurora.org>
X-Sender: khsieh@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-05 22:07, Bjorn Andersson wrote:
> On Thu 03 Jun 16:56 CDT 2021, khsieh@codeaurora.org wrote:
> 
>> On 2021-06-03 09:53, Bjorn Andersson wrote:
>> > On Thu 03 Jun 11:09 CDT 2021, Kuogee Hsieh wrote:
> [..]
>> > > diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> [..]
>> > > +				power-domains = <&rpmhpd SC7180_CX>;
>> >
>> > Just curious, but isn't the DP block in the MDSS_GDCS? Or do we need to
>> > mention CX here in order for the opp framework to apply required-opps
>> > of CX?
>> 
>> yes,
> 
> If you want me, or other maintainers, to spend any time reviewing or
> applying your patches going forward then you need to actually bother
> replying properly to the questions asked.
> 
> Thanks,
> Bjorn

Sorry about the confusion. What I meant is that even though DP 
controller is in the MDSS_GDSC
power domain, DP PHY/PLL sources out of CX. The DP link clocks have a 
direct impact
on the CX voltage corners. Therefore, we need to mention the CX power 
domain here. And, since
we can associate only one OPP table with one device, we picked the DP 
link clock over other
clocks.
