Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C464325449
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhBYRDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:03:44 -0500
Received: from esa10.hc324-48.eu.iphmx.com ([207.54.69.29]:25022 "EHLO
        esa10.hc324-48.eu.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233582AbhBYRC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:02:27 -0500
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Feb 2021 12:02:24 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1614272546; x=1645808546;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MXCCQrw3i6l/fhaydWPCvg2GzjEqYKlqPkf23yvI6Pk=;
  b=lYuv53djyABPh2vMx2iqb0p3smmzXzk6ewYYaOKMlLDDyJ88CFN+HXuO
   KEZEKYW6jmBXuhADCZHmUMQ8K+A4POGgnszFE1mJhoceh1aXs0m6hNDk8
   /rOY75ckRE9WPLeaFih5Pk9DQXGqj2sISYcVfOQ74VaGyUshz7P+phoZk
   Q=;
Received: from esagw1.bmwgroup.com (HELO esagw1.muc) ([160.46.252.34]) by
 esa10.hc324-48.eu.iphmx.com with ESMTP/TLS; 25 Feb 2021 17:53:35 +0100
Received: from esabb6.muc ([160.50.100.50])  by esagw1.muc with ESMTP/TLS;
 25 Feb 2021 17:53:35 +0100
Received: from smucm10m.bmwgroup.net (HELO smucm10m.europe.bmw.corp) ([160.48.96.49])
 by esabb6.muc with ESMTP/TLS; 25 Feb 2021 17:53:34 +0100
Received: from greenhouse.bmw-carit.intra (192.168.221.35) by smucm10m.europe.bmw.corp
 (160.48.96.49) with Microsoft SMTP Server (TLS;
 Thu, 25 Feb 2021 17:53:34 +0100
From:   Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <linux-kernel@vger.kernel.org>, <Viktor.Rosendahl@bmw.de>
Subject: [PATCH 0/1] Fix for the latency-collector
Date:   Thu, 25 Feb 2021 17:52:47 +0100
Message-ID: <20210225165248.22050-1-Viktor.Rosendahl@bmw.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucm31l.europe.bmw.corp (160.46.167.60) To
 smucm10m.europe.bmw.corp (160.48.96.49)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

I am not sure what is the correct approach to handle this latency-collector
fix. Can you take it into your queue?

best regards,

Viktor

Colin Ian King (1):
  tracing/tools: fix a couple of spelling mistakes

 tools/tracing/latency/latency-collector.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.25.1

