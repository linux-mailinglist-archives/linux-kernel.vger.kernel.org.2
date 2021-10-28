Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D4343E328
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhJ1OL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:11:59 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:9360 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231184AbhJ1OLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:11:47 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19S8422t008357;
        Thu, 28 Oct 2021 09:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=X0O6MWyGZX3E7kGT3bHAMBl+YQRTxjhLQ/rRDFPMcio=;
 b=OGH4QM1coMENDOiOzPkOPncxVz8Ow37pOKueTq0haopFZZDpTA9Juas8X4/jj55lGaHv
 I0ce2Ox9x/foToNr4I5LPJ1r5W0rdoVoolzsNZL6+EIhocHNwtgcnZzmLzOb3si0KNmA
 kIeRwcpkJhBB24tH2kU+pEhSz90ZWvLpg5tBIA9y1NueEa8XCJTHHfsYkMsvRp4yFdUD
 D0d8rhee4rIRg6qR5nb8fDjQ7QN6QawLbZbeJ2+Xh/yTZJcS1SBZUsuNlIee+V6yvUnR
 W7USLuHl11R8RGoBDfc/SVkZxoZqGnR/3pIUePMyYZcHwgq4L/DlsVbrmeFt3cMvb/qr Dg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3bya1wh98x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 Oct 2021 09:09:09 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 28 Oct
 2021 15:09:07 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Thu, 28 Oct 2021 15:09:07 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.32])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 45C5211AF;
        Thu, 28 Oct 2021 14:09:06 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/3] ASoC: cs42l42: Fix definition and handling of jack switch invert
Date:   Thu, 28 Oct 2021 15:08:59 +0100
Message-ID: <20211028140902.11786-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: j12Yjou9t0SDfd7rHLrc4Vc2ZOvGrId8
X-Proofpoint-ORIG-GUID: j12Yjou9t0SDfd7rHLrc4Vc2ZOvGrId8
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: The driver applied the opposite of the DT setting to the
wrong register bit.

The jack plug detect hardware in cs42l42 is somewhat confusing,
compounded by an unclear description in the datasheet. This is most
likely the reason that the driver implemented a DT property for the
wrong register bit, that had the opposite effect of what was
described in the binding.

Changing the meaning of the property values isn't feasible; the
driver dates from 2016 and the risk of breaking out-of-tree configs
is too high (the property is also available to ACPI systems).

So the fix is to make the binding doc match the actual behaviour and
then fix the driver to apply it to the correct register bit.

As a bonus, patch #3 converts the binding to yaml.

Richard Fitzgerald (3):
  ASoC: dt-bindings: cs42l42: Correct description of ts-inv
  ASoC: cs42l42: Correct configuring of switch inversion from ts-inv
  ASoC: dt-bindings: cs42l42: Convert binding to yaml

 .../devicetree/bindings/sound/cirrus,cs42l42.yaml  | 225 +++++++++++++++++++++
 .../devicetree/bindings/sound/cs42l42.txt          | 114 -----------
 MAINTAINERS                                        |   1 +
 sound/soc/codecs/cs42l42.c                         |   9 +-
 4 files changed, 230 insertions(+), 119 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs42l42.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/cs42l42.txt

-- 
2.11.0

