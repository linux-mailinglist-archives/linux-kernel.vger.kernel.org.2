Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C29D339DD2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 12:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbhCMLfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 06:35:25 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:10952 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231938AbhCMLfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 06:35:05 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12DBXKDj024838;
        Sat, 13 Mar 2021 05:34:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=7hx+MtkVI3AK3n86Hd9S0sFsoKCZzlL3dcqAqyanKP0=;
 b=hidrVS7Fvc8F+f66gYNO0JDozGgi6XlBzv+8YnfnCEfYifSGaEd9v6HZERbkeRkHN17x
 iRMah7GZogcnv0ftFq+bEG1Aw80LgIM9EJFKeR4Wtf0KQVCzLTqngAu/iiAa7POuzzkf
 FgaQXrA00YkzrEnP8Yuoqhw56UowM+9OsQfhdArZ4dA9Y+CuIS1yL3IZAV0poNNLSzDL
 tXJUJme5eix+oIpWiZNl2fkE62D5VDE3LwrwDITl5gPCzNoxJts4q9F6oI2nJV5yPUKf
 EMNZCGZvBv9soM9a/0UNS+zUoPzfXnyAty9Y/JbiTcyNAU5QmztbYrqGWQyuu7aRD3sa rA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 378up782ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 13 Mar 2021 05:34:12 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 13 Mar
 2021 11:34:10 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Sat, 13 Mar 2021 11:34:10 +0000
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3ABDB11D6;
        Sat, 13 Mar 2021 11:34:10 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/4] ALSA: hda/cirrus: Make CS8409 driver more generic by using fixups
Date:   Sat, 13 Mar 2021 11:34:06 +0000
Message-ID: <20210313113410.90088-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxlogscore=498 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103130084
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

 sound/pci/hda/patch_cirrus.c | 506 ++++++++++++++++-------------------
 1 file changed, 228 insertions(+), 278 deletions(-)

-- 
2.25.1

