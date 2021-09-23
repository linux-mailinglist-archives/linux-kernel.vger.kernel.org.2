Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3930A415BD2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 12:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240363AbhIWKPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 06:15:20 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:48622 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240331AbhIWKPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 06:15:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632392027; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=AOhxSdZwfyMsdUznn5MrHD1bvqUT9drqSO1Hx/Gl3ro=;
 b=HHzVX1ccm5e/DqiasymPDill4UuXg8OgS1gaPPAuaPdKf/DgRZHd/fqoTrCR52zdsQkAvHKw
 FlG0GZbhXb+I5/ych4W51NQ6Ukmppb9Yy/FzMv4zuWpLfW6JbcJ+WXDOKsiWSgo+2KFKH1oo
 NO47JIR3LC+y9+qNdTHo87eCZdw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 614c53438b04ef85893b08b5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 23 Sep 2021 10:13:23
 GMT
Sender: rajpat=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E8374C43618; Thu, 23 Sep 2021 10:13:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rajpat)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B1D4C4338F;
        Thu, 23 Sep 2021 10:13:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 23 Sep 2021 15:43:22 +0530
From:   rajpat@codeaurora.org
To:     Doug Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        msavaliy@qti.qualcomm.com, satya priya <skakit@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>
Subject: Re: [PATCH V9 4/8] arm64: dts: sc7280: Add QUPv3 wrapper_0 nodes
In-Reply-To: <CAD=FV=X=PUeahdf_bbTyCAZSeZ-ahRwZVvH-Oh=3wQmRxbt2CQ@mail.gmail.com>
References: <21d14dd0bfa945ee617ed4b86b4495ee@codeaurora.org>
 <CAD=FV=X=PUeahdf_bbTyCAZSeZ-ahRwZVvH-Oh=3wQmRxbt2CQ@mail.gmail.com>
Message-ID: <4ac4e619e5269efc04c9160710d506de@codeaurora.org>
X-Sender: rajpat@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-22 20:24, Doug Anderson wrote:
> Hi,
> 
> On Wed, Sep 22, 2021 at 5:31 AM <rajpat@codeaurora.org> wrote:
>> 
>> >> +                       spi0: spi@980000 {
>> >> +                               compatible = "qcom,geni-spi";
>> >> +                               reg = <0 0x00980000 0 0x4000>;
>> >> +                               clocks = <&gcc
>> >> GCC_QUPV3_WRAP0_S0_CLK>;
>> >> +                               clock-names = "se";
>> >> +                               pinctrl-names = "default";
>> >> +                               pinctrl-0 = <&qup_spi0_data_clk>,
>> >> <&qup_spi0_cs>, <&qup_spi0_cs_gpio>;
>> >
>> > This should only have qup_spi0_data_clk and qup_spi0_cs, not
>> > qup_spi0_cs_gpio. Both qup controlled and gpio controlled options are
>> > provided in case a board wants to use the qup version of chipselect,
>> > but
>> > having them both used by default leads to conflicts and confusion. This
>> > same comment applies to all spi pinctrl properties in this file. Please
>> > keep the cs_gpio variants though so that boards can use them if they
>> > want. They will be unused, but that's OK.
>> 
>> Okay. Shall we remove only "<&qup_spiN_cs_gpio>" in each SPI node?
> 
> Right. So for this one:
> 
> pinctrl-0 = <&qup_spi0_data_clk>, <&qup_spi0_cs>;
> 
> -Doug

Okay.
