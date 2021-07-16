Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE733CB00D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 02:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhGPAbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 20:31:10 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:57080 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhGPAbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 20:31:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626395295; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=YC4/6KosOAxOajar6Wf4KVQdiR1MRqHpQup/On0uDtM=; b=NeHK1BzorgGBaMfWZYQJcQea7OoXxz81CEHG5BJzyuDn9Z80FiuvSXHoYu5nzsU4upgtZdLT
 ghfw4GmN/A0a3h6VYd5hJRxXgLAQVpaqv1uOH4IQ/GCJI0JSh9M4wD1birDLZi+uCiNftF9+
 F7hRgVFAW5L1qcitxS0pAM+ldfU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60f0d299e81205dd0a0071d5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 16 Jul 2021 00:28:09
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ADAFDC43217; Fri, 16 Jul 2021 00:28:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A9FA3C433F1;
        Fri, 16 Jul 2021 00:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A9FA3C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        quic_jhugo@quicinc.com, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v1 0/2] Fix serial number usage in MHI bus
Date:   Thu, 15 Jul 2021 17:27:54 -0700
Message-Id: <1626395276-24171-1-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, device may boot straight to the mission mode. The serial number
and OEM PK hash values would remain unpopulated in those cases. Hence, move the
reads for those to the power up preparation phase such that controllers always
have them populated. Also, in order to maintain consistency with the way OEM PK
hash is displayed and improve the current way, depict serial number in upper
case hexadecimals.

Note: This patch series needs to be picked up after patch:
878789cad00d ("bus: mhi: core: Set BHI/BHIe offsets on power up preparation")

Bhaumik Bhatt (2):
  bus: mhi: core: Read serial number during pre-powerup phase
  bus: mhi: core: Depict serial number in hexadecimals

 drivers/bus/mhi/core/boot.c | 17 +----------------
 drivers/bus/mhi/core/init.c | 19 +++++++++++++++++--
 2 files changed, 18 insertions(+), 18 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

