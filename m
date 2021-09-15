Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFCA40C324
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbhIOJ7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:59:13 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:3440 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbhIOJ7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:59:06 -0400
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 15 Sep 2021 02:57:46 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Sep 2021 02:57:44 -0700
X-QCInternal: smtphost
Received: from mdalam-linux.qualcomm.com ([10.201.2.71])
  by ironmsg02-blr.qualcomm.com with ESMTP; 15 Sep 2021 15:27:35 +0530
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id 703CD22353; Wed, 15 Sep 2021 15:27:33 +0530 (IST)
From:   Md Sadre Alam <mdalam@codeaurora.org>
To:     miquel.raynal@bootlin.com, mani@kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mdalam@codeaurora.org, sricharan@codeaurora.org
Subject: [PATCH 0/3] Add support for page scope read
Date:   Wed, 15 Sep 2021 15:27:28 +0530
Message-Id: <1631699851-12172-1-git-send-email-mdalam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These series of patches to support page scope read.

In QPIC v1, SW is needed to write EXEC_CMD register
for each Code word and collect any Status related to
that CW before issueing EXEC_CMD for next CW.

Page scope command, currently supported only for read
commands in bam mode, is truly a page mode command where
SW is required to issue EXEC_CMD only once for a page.
Controller HW takes care of Codeword specific details
and automatically returns status associated with each
CW to BAM pipe, dedicated for status deposition.

Md Sadre Alam (3):
  mtd: rawnand: qcom: Add support for status pipe
  mtd: rawnand: qcom: Add sg list to handle status pipe request
  mtd: rawnand: qcom: Add support for page scope read

 drivers/mtd/nand/raw/qcom_nandc.c | 125 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 119 insertions(+), 6 deletions(-)

-- 
2.7.4

