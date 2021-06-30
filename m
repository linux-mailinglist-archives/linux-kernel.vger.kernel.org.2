Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5383A3B8953
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 21:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbhF3Tz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 15:55:26 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:23592 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhF3TzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 15:55:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1625082776; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=BDH47LnbNO0F93FfoHdE5Bubd6iBcrqQV6q+KlYVurc=;
 b=EuqozrRkgOEXoEPssA43SOU+/R9BhaMwh3XxP3oc+sl1+tgu1Ysp3KWcH6YALUP88j5Y25v/
 iEQN9R7Qn1DbBMAPOK/UdMioAkC91fPGB3AkciqzBgIxYFbqvD74Nw77gbt04oGN7PSKtZvD
 NX6hxBOUIQQ0IVP+pSVMMSm37dM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60dccb8f5e3e57240b2f0e46 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 30 Jun 2021 19:52:47
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 09C61C43460; Wed, 30 Jun 2021 19:52:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C631DC433F1;
        Wed, 30 Jun 2021 19:52:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 01 Jul 2021 01:22:44 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        swboyd@chromium.org, ulf.hansson@linaro.org, rjw@rjwysocki.net,
        agross@kernel.org, ohad@wizery.com, mathieu.poirier@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, rishabhb@codeaurora.org,
        sidgup@codeaurora.org
Subject: Re: [PATCH v3 05/13] arm64: dts: qcom: sc7180: Use QMP binding to
 control load state
In-Reply-To: <YNZMHGYTXV5oJLI7@google.com>
References: <1624560727-6870-1-git-send-email-sibis@codeaurora.org>
 <1624560727-6870-6-git-send-email-sibis@codeaurora.org>
 <YNZMHGYTXV5oJLI7@google.com>
Message-ID: <af868e8d28019ffd37b6f2949a75c7c1@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-26 03:05, Matthias Kaehlcke wrote:
> On Fri, Jun 25, 2021 at 12:21:59AM +0530, Sibi Sankar wrote:
>> Subject: arm64: dts: qcom: sc7180: Use QMP binding to control load 
>> state
> 
> nit: s/binding //
> 
>> Use the Qualcomm Mailbox Protocol (QMP) binding to control the load
> 
> ditto
> 
> same for other DT patches if you re-spin

sure, I fix this up in the re-spin
that I base on top of Bjorn's aoss-qmp
yaml conversion series.

> 
>> state resources on SC7180 SoCs and drop deprecated power-domains 
>> exposed
>> by AOSS QMP node.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
