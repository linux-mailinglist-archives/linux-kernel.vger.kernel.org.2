Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45B2361B82
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 10:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbhDPIYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:24:13 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31720 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235206AbhDPIYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:24:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618561420; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=6eyoow52rOt72HHJKzEVpmuy7mCQ0iL9k+Xbu6emqms=; b=qgXGj+3t/RgGUOF8Ev31BhfTfxu6Sq4c1JEjvVXIdHqH+L2XOZ1IAALBZVnoCxR5SPFy4vBK
 CtxTYSjm59N+Dtzt4eWo7AtfKBF58ohEGqclXla8Y4FVnl//naWdH576CsZxAjTy66kbAerI
 GZUOP8+ePPofoK7f0MHNO4uhfr4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60794965c39407c327af9d7d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 16 Apr 2021 08:23:01
 GMT
Sender: taozha=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1203CC433CA; Fri, 16 Apr 2021 08:23:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from taozha-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: taozha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 93FB6C433CA;
        Fri, 16 Apr 2021 08:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93FB6C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=taozha@codeaurora.org
From:   Tao Zhang <taozha@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Tao Zhang <taozha@codeaurora.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        Yuanfang Zhang <zhangyuanfang@codeaurora.org>
Subject: [PATCH v1 0/2] coresight: Add support for device names
Date:   Fri, 16 Apr 2021 16:22:40 +0800
Message-Id: <1618561362-1561-1-git-send-email-taozha@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add support for coresight device name. In this way,
nodes with specific names can be generated under sysfs, not just
names with prefixes and index numbers. The coresight device can
be quickly identified by the coresight names of sysfs nodes. This
also allows using same names for CoreSight devices across different
targets. This makes it easy to develop common scripts, which can
be run across targets. Meanwhile, the script can use the same
device name to control the same coresight device.

This series patches base on coresight-next repo
http://git.linaro.org/kernel/coresight.git/log/?h=next

Tao Zhang (2):
  coresight: Add support for device names
  dt-bindings: arm: add property for coresight component name

 Documentation/devicetree/bindings/arm/coresight.txt | 2 ++
 drivers/hwtracing/coresight/coresight-core.c        | 6 ++++++
 2 files changed, 8 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

