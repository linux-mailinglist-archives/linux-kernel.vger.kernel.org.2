Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A4B378B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 14:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244476AbhEJL7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 07:59:10 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:25289 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235907AbhEJLG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 07:06:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620644754; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=vzp/BdIxiUuRKSV3zwAgC8rx5gUETWRirAk6r1N26V8=; b=Xz723RuDErYqYk4yWHx1gl3TsS12QkZ837r/bJUP4uDs7AB7R510Y+I0MIi1aCjLbpSHWR6b
 Y9aEZdNWFDmD6QGunasoLu8TQ3iBRtf3dTui6EVzYcbLp0X9CwFfeckYxy5PjDGdRKc08j/O
 i06n3QHmUfxd+tMQmiZ+LxSz8IA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 6099138a8166b7eff7662062 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 10 May 2021 11:05:46
 GMT
Sender: taozha=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E2802C75617; Mon, 10 May 2021 11:05:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from taozha-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: taozha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 720BEC4338A;
        Mon, 10 May 2021 11:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 720BEC4338A
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
Subject: [PATCH v1 0/3] coresight: Support for building more coresight paths
Date:   Mon, 10 May 2021 19:05:24 +0800
Message-Id: <1620644727-29279-1-git-send-email-taozha@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are trying to achieve more types of Coresight source devices.
For example, we have a type of coresight source devic named TPDM.
In the process of using, sometimes mulitiple TPDMs need to be
connected to the different input ports on the same funnel.
Meanwhile, these TPDMs also need to output from different
ports on the funnel.
But, at present the Coresight driver assumes
a) Only support Coresight source type ETM, ETR and ETF
b) Funnels only support mulitiple inputs and one output
Which doesn't help to add the above feature for our new Coresight
source device TPDM. So, in order to accommodate the new device,
we develop the following patches.
a) Add support more types of Coresight source devices.
b) Add support for multiple output ports on funnel and the output
ports could be selected by Corsight source.

Applies on coresight/next.
http://git.linaro.org/kernel/coresight.git/log/?h=next

Tao Zhang (3):
  coresight: add support to enable more coresight paths
  coresight: funnel: add support for multiple output ports
  dt-bindings: arm: add property for selecting funnel output port

 .../devicetree/bindings/arm/coresight.txt          |   5 +
 drivers/hwtracing/coresight/coresight-core.c       | 169 ++++++++++++++-------
 drivers/hwtracing/coresight/coresight-platform.c   |   9 ++
 include/linux/coresight.h                          |   2 +
 4 files changed, 127 insertions(+), 58 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

