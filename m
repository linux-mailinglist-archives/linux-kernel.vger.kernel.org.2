Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1D8347201
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbhCXHFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:05:38 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:39280 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhCXHFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:05:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1616569517; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=GSuzv68z73zXdYYHmOBg3yhM/DxDs3uPEYGKUNXQJI8=;
 b=pJmv855yAgQct8TmsiY2tWS0UNoy+EHGrVfqBZWGKnDadUfWKz1Pyrv/yi86yL0COw6TDNE/
 MhmTrJaOKg7KC4rYYFvVRHgDl8BuGygAxyXx2thkj8gSIVFV8volOYOOtRXd9fFNgaFTHKe0
 jVFChxvMvo7AZc/I8uLvd65Pixs=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 605ae4a14db3bb68017c7d09 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Mar 2021 07:05:05
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1A89AC43464; Wed, 24 Mar 2021 07:05:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3108EC433CA;
        Wed, 24 Mar 2021 07:05:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 24 Mar 2021 12:35:04 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        devicetree@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 8/9] arm64: dts: qcom: sc7280: Add AOSS QMP node
In-Reply-To: <161647068330.3012082.2910442813045392403@swboyd.mtv.corp.google.com>
References: <cover.1614244789.git.saiprakash.ranjan@codeaurora.org>
 <463a45f2c3e4a91430c006fa1637c7f4f124185e.1614244789.git.saiprakash.ranjan@codeaurora.org>
 <161428210272.1254594.16034240343090747878@swboyd.mtv.corp.google.com>
 <dc3be32a3f8197d3138fe1ef6c24316a@codeaurora.org>
 <161436520297.1254594.4348845199981053890@swboyd.mtv.corp.google.com>
 <5cf5692ef7d348ec361081d0341f1254@codeaurora.org>
 <d19fbcc91b4ef045014b225e7fdf9780@codeaurora.org>
 <161647068330.3012082.2910442813045392403@swboyd.mtv.corp.google.com>
Message-ID: <0a8540993e6f59c3b03e44e6aee4f81b@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-23 09:08, Stephen Boyd wrote:
> Quoting Sibi Sankar (2021-03-08 21:58:21)
>> On 2021-02-27 19:26, Sai Prakash Ranjan wrote:
>> > On 2021-02-27 00:16, Stephen Boyd wrote:
>> >> Quoting Sai Prakash Ranjan (2021-02-25 23:51:00)
>> >>> On 2021-02-26 01:11, Stephen Boyd wrote:
>> >>> > Quoting Sai Prakash Ranjan (2021-02-25 01:30:24)
>> >>> >> Add a DT node for the AOSS QMP on SC7280 SoC.
>> >>> >>
>> >>> >> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> >>> >> ---
>> >>> >>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 14 ++++++++++++++
>> >>> >>  1 file changed, 14 insertions(+)
>> >>> >>
>> >>> >> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> >>> >> b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> >>> >> index 65c1e0f2fb56..cbd567ccc04e 100644
>> >>> >> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> >>> >> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> >>> >> @@ -9,6 +9,7 @@
>> >>> >>  #include <dt-bindings/clock/qcom,rpmh.h>
>> >>> >>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>> >>> >>  #include <dt-bindings/mailbox/qcom-ipcc.h>
>> >>> >> +#include <dt-bindings/power/qcom-aoss-qmp.h>
>> >>> >>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> >>> >>
>> >>> >>  / {
>> >>> >> @@ -368,6 +369,19 @@ pdc: interrupt-controller@b220000 {
>> >>> >>                         interrupt-controller;
>> >>> >>                 };
>> >>> >>
>> >>> >> +               aoss_qmp: qmp@c300000 {
>> >>> >
>> >>> > power-domain-controller@c300000? power-controller@c300000?
>> >>> >
>> >>>
>> >>> Its an AOSS message RAM and all other SM* SoCs have as qmp@
>> >>> and the dt binding as well, I see only SM8150 with power-controller,
>> >>> that should probably be fixed?
>> >>
>> >> Node name should be generic while still being meaningful. Nobody knows
>> >> what qmp is, but power-controller makes sense. Can you fix this and
>> >> the
>> >> others to be power-controller?
>> >>
>> 
>> we probably would be changing them back
>> to qmp or something more generic soon
>> since the consensus was qmp wasn't a
>> power-controller. So not sure if its
>> worth the effort here.
>> 
> 
> Hmm alright. Maybe mailbox? qmp is not generic. What does it stand for?
> qualcomm messaging protocol?

It's documented as ^^ in the git log
but I guess it should be called qualcomm
mailbox protocol instead. I don't think
it can be called mailbox since it doesn't
have mbox cells in its bindings.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
