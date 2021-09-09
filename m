Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696954059C2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbhIIO4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:56:34 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:56714 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232359AbhIIO4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:56:33 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 189D2xEW008460;
        Thu, 9 Sep 2021 16:55:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=6VSAWmEbCA5S7HOgjWSLJ/kPpl3J+ONHFObQga3sbMs=;
 b=DxjvpDNhQbI+8ALBOVh6BQr8y7I3ERUA/vovpMt5r1xyDkfeZMa3V2qHNM9orOKROz0p
 uXPHOZTOI1Xz5W2UsNrtzPsFCyOezEPwFPiXY8YFk6dRFjz5gx6r9BomV1O4jmrP8xik
 ArvtNeIIFzYASTDyY5/CU64kPmrzL6CiH65aRsXwDXKKfcyC5kMyhCDdlThciOef1YbY
 Br8MztS/PEpIdQc2FmTCJfmo8kHeI3CnNahH7/M25jld49XXeLt9LMwqJBYkSVD8hp2y
 KuX7woaezFAmYrwRIDsupPU5vMR5wqv8ssZsE/uWjeLfJPEqVlDzjZ7v/ae2zrRrPVJ4 Mg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3ayej6t7x1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 16:55:13 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 729BC10002A;
        Thu,  9 Sep 2021 16:55:13 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag1node2.st.com [10.75.127.2])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4D8FC21FA84;
        Thu,  9 Sep 2021 16:55:13 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG1NODE2.st.com (10.75.127.2)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Sep 2021 16:55:12
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] MAINTAINERS: fix update references to stm32 audio bindings
Date:   Thu, 9 Sep 2021 16:54:49 +0200
Message-ID: <20210909145449.24388-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG1NODE2.st.com
 (10.75.127.2)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-09_05,2021-09-09_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 00d38fd8d2524 ("MAINTAINERS: update references to stm32 audio bindings")
commit update the bindings reference, by
removing bindings/sound/st,stm32-adfsdm.txt, to set the
new reference to bindings/iio/adc/st,stm32-*.yaml.

This leads to "get_maintainer finds" the match for the
Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml,
but also to the IIO bindings
Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml

And The commit fixes only a part of the problem:
Documentation/devicetree/bindings/sound/st,stm32-*.txt file have been
also moved to yaml.

Update references to include all stm32 audio bindings file and
exclude the st,stm32-adc.yaml bindings file.

cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Fixes: 0d38fd8d2524 ("MAINTAINERS: update references to stm32 audio bindings")
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a9a7cbf9456..3f6dc482660e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17886,7 +17886,8 @@ M:	Olivier Moysan <olivier.moysan@foss.st.com>
 M:	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/iio/adc/st,stm32-*.yaml
+F:	Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
+F:	Documentation/devicetree/bindings/sound/st,stm32-*.yaml
 F:	sound/soc/stm/
 
 STM32 TIMER/LPTIMER DRIVERS
-- 
2.17.1

