Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9917D3D14CC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 19:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhGUQYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 12:24:41 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:23709 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhGUQY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 12:24:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626887103; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=nB2p2NTeR79nuMtOtOgm6ajzTwXzSQzw8laJhE1thq8=;
 b=f3Zta5WWr7DCQCqTEukzgq5OTE+7Mv4ztdH0bpSNsjl/tDz7p9gZQGo87SkmngxHNIyOrypz
 6IG6k/6qkYHa/Oo886WL/vxJ+6HrVdJ5tyPEv5DlTYcymYxpO3pTUwaJDJhRwk1SUNi4aJNq
 xDuepRqP7HStzdRnM6Yu9mQ8GQI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60f8539a4815712f3aaba800 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 17:04:26
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 37B23C43143; Wed, 21 Jul 2021 17:04:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5CC7DC433D3;
        Wed, 21 Jul 2021 17:04:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 21 Jul 2021 22:34:24 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     bjorn.andersson@linaro.org, mka@chromium.org, robh+dt@kernel.org,
        saiprakash.ranjan@codeaurora.org, will@kernel.org, ohad@wizery.com,
        agross@kernel.org, mathieu.poirier@linaro.org,
        robin.murphy@arm.com, joro@8bytes.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, evgreen@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH v2 03/10] dt-bindings: remoteproc: qcom: Update Q6V5 Modem
 PIL binding
In-Reply-To: <CAE-0n51ujsHp+S9v2yTWVdFcWJswFyVyme8Bqp5i4w9Qv6GB6g@mail.gmail.com>
References: <1626775980-28637-1-git-send-email-sibis@codeaurora.org>
 <1626775980-28637-4-git-send-email-sibis@codeaurora.org>
 <CAE-0n51ujsHp+S9v2yTWVdFcWJswFyVyme8Bqp5i4w9Qv6GB6g@mail.gmail.com>
Message-ID: <a5e7af00a468166f3cff790f76c41fd7@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Stephen,

Thanks for taking time to review
the series.

On 2021-07-21 11:09, Stephen Boyd wrote:
> Quoting Sibi Sankar (2021-07-20 03:12:53)
>> diff --git 
>> a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt 
>> b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> index 494257010629..bc1394f5d677 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> @@ -198,6 +205,9 @@ For the compatible string below the following 
>> supplies are required:
>>         Definition: a phandle reference to a syscon representing TCSR 
>> followed
>>                     by the three offsets within syscon for q6, modem 
>> and nc
>>                     halt registers.
>> +                   a phandle reference to a syscon representing TCSR 
>> followed
>> +                   by the four offsets within syscon for q6, modem, 
>> nc and vq6
>> +                   halt registers on SC7280 SoCs.
> 
> This seems to be duplicated? Maybe it should be combined with the
> previous sentence and sc7280 called out?

yeah noticed ^^ but that's the style
we've maintained till now. This
would get cleanup up when I do the
yaml conversion after the series
lands.

> 
>> 
>>  For the compatible strings below the following phandle references are 
>> required:
>>    "qcom,sc7180-mss-pil"

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
