Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5947C33C66D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 20:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbhCOTIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 15:08:14 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:15702 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233076AbhCOTIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 15:08:04 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12FJ65Y7021197;
        Mon, 15 Mar 2021 14:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=yycNajMb9KBArmrCIEcoP3FnCQm9g+NrqG3He0nquug=;
 b=o1kcUADKMkBLGqC8pABE/1jaYqPuH+F/gHAmp0doMNjcU4zBuX18/YcFL0bMeG6bI+3A
 gm49zFogMJfXWmm5Ev7ugkxyyQ8Q/8FdAqZafzT1yo0y7u0NmfXN3aIB0BHBtlAWUBlf
 uk8GkMwtXfxQzoHsgN3XhGEUtqmbKB4jqZdZZRFt/DEl2Pd5jA8o6TliXp85tSzkTk2W
 iGtBx24g3LlqqsCCnZzbWQbUOIZZIp3qQVf+geLSVuGu7kRpL/qV6u2rWVNETnCnZX0K
 x0/ES62nDfi8a+aUOQEKA8xJCfLIaSIuyuouNdHy6rUdfdSjvgFNGpRARdNnWCXT9MIr /w== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 378tpv2t0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 15 Mar 2021 14:07:18 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 15 Mar
 2021 19:07:16 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Mon, 15 Mar 2021 19:07:16 +0000
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7EED311D6;
        Mon, 15 Mar 2021 19:07:16 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/4] ALSA: hda/cirrus: Make CS8409 driver more generic by using fixups
Date:   Mon, 15 Mar 2021 19:07:12 +0000
Message-ID: <20210315190716.47686-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 mlxlogscore=506 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103150128
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches will address comments by Pierre-Louis Bossart,
cleans up patch_cirrus.c source, reducing checkpatch.pl warnings from 19 to 0,
fixing an issue reported by Canonical: BugLink: https://bugs.launchpad.net/bugs/1918378,
and makes the CS8409 patch more generic by using fixups.

Stefan Binding (4):
  ALSA: hda/cirrus: Add error handling into CS8409 I2C functions
  ALSA: hda/cirrus: Cleanup patch_cirrus.c code.
  ALSA: hda/cirrus: Fix CS42L42 Headset Mic volume control name
  ALSA: hda/cirrus: Make CS8409 driver more generic by using fixups.

 sound/pci/hda/patch_cirrus.c | 525 ++++++++++++++++-------------------
 1 file changed, 242 insertions(+), 283 deletions(-)

-- 
2.25.1

