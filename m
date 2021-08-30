Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691B33FB45D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 13:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbhH3LJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 07:09:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:43221 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236490AbhH3LI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 07:08:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630321686; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=VTpVB88JoWhs6rcQHMuqx5z/FcLJ56Q+UXtM0n9ltKk=; b=rYD0rpUhdgg7DGWtNVEXLKYuVe/f7IxzccUoU19E1H/w8j8aRFIfUtJSo+V7Fr8aJ6QbNGhD
 NNhVFGchQ73FzdH400VBqBMrGVgs52jlHVbUJbU5OPezEOLXdwkEhxhWTbYxab6NWsI4D0xy
 QraYlcnZxwauwIQlKiDtcOymJH8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 612cbc036fc2cf7ad9cac63b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 30 Aug 2021 11:07:47
 GMT
Sender: luoj=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6D1D5C4338F; Mon, 30 Aug 2021 11:07:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from akronite-sh-dev02.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: luoj)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C6F15C4338F;
        Mon, 30 Aug 2021 11:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C6F15C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Luo Jie <luoj@codeaurora.org>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sricharan@codeaurora.org, Luo Jie <luoj@codeaurora.org>
Subject: [PATCH v1 0/3] net: phy: Add qca8081 ethernet phy driver
Date:   Mon, 30 Aug 2021 19:07:30 +0800
Message-Id: <20210830110733.8964-1-luoj@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add the qca8081 ethernet phy driver support, which
improve the wol feature, leverage at803x phy driver and add the cdt
feature.

Changes in v1:
	* merge qca8081 phy driver into at803x.
	* add cdt feature.
	* leverage at803x phy driver helpers.

Luo Jie (3):
  net: phy: improve the wol feature of at803x
  net: phy: add qca8081 ethernet phy driver
  net: phy: add cdt feature of qca8081 phy

 drivers/net/phy/at803x.c | 632 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 557 insertions(+), 75 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

