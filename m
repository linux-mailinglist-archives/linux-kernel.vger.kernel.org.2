Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D57936A19A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 16:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbhDXOdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 10:33:52 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:30592 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231892AbhDXOdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 10:33:42 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13OERRe5030110;
        Sat, 24 Apr 2021 09:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=y9JGCthEI6eOsolpJE66FNolo0/WjCj1PhSLiW2R02c=;
 b=OmqLGAWxAoOGO/KC3MHV1Cjx1EJhTUmmuOaijPxyIzlLv+87MSvYSUhNK2oMVn83Krpp
 kcslg8ZaRihGvru5GYduK4bpouDngwZIcu6ltyulNYBW4WUS9XPk3Ayow2hsXLBVjuoU
 LyyltHiFDepyIZBtlxx1EOpAiQyrcK1gdY7m70ii89MerjknlCv2o+c+C6aUqXLv+F3A
 1eS0d0Q9m+gKE0HUKT7gN769mTNTI3jGk2BjC8nyM82wmfTlsIs2SXBtt/xObAT/Fur9
 WaWvlgyP4UKhGDwaByDBoKD5diBOct4LPAKu047KGos8nnI7SOqaMjQ3BwoQqNjdZwHS pA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 384frs094u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 24 Apr 2021 09:32:46 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 24 Apr
 2021 15:32:44 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Sat, 24 Apr 2021 15:32:44 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.200])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6CB2E11CB;
        Sat, 24 Apr 2021 14:32:44 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/2] Fix couple of bugs reported by Canonical
Date:   Sat, 24 Apr 2021 15:32:42 +0100
Message-ID: <20210424143244.639125-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UtVqZk6ls8Qs_KNVinoOBqeoUbazUQFj
X-Proofpoint-GUID: UtVqZk6ls8Qs_KNVinoOBqeoUbazUQFj
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 spamscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=825 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104240107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CirrusLogic: Cracking noises appears in built-in speaker when output 
volume is set >80%
BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1923557i

CirrusLogic: The default input volume is "0%" 
BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1924997

Stefan Binding (2):
  ALSA: hda/cirrus: Set Initial DMIC volume for Bullseye to 16%
  ALSA: hda/cirrus: Use CS8409 Equalizer to fix abnormal sounds on
    Bullseye

 sound/pci/hda/patch_cirrus.c | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

-- 
2.25.1

