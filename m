Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5AF433C2F7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbhCOQ7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:59:05 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:40372 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234140AbhCOQ60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:58:26 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12FGmgbS030888;
        Mon, 15 Mar 2021 11:57:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=yycNajMb9KBArmrCIEcoP3FnCQm9g+NrqG3He0nquug=;
 b=b6r+Mu0B8/L7k4dlLzzIUKOqCSMdbrb3uxtX0XLLWlriF/qnqcUzJPKYBpOFwufNNDpT
 WssiqG18hFmwwe2j0agZ0ITzxwjatN6paS6052JfElIcEAEg+iTQ7tIHfNFJFvKxiJ30
 eE6DDJytEhqQmpYcthPrK8U3QARm0UGdTLZkgfUAVOlTxMStvQi/8yKNzTkWTaXmW2t5
 aV8B8lKBW+hXK5iZ2iEkCGXOX+tj8DZOSTmgrE9mK+1b3HAUZG0uLR87GuWqZzubqw6e
 hb6pM0fEJPFW/VjbngVWulUKzWXUTfM9kN30xxNC5g2Pxse7Do9w2tTz76hGPTfkjdfr fA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3790bs2bks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 15 Mar 2021 11:57:36 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 15 Mar
 2021 16:57:06 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Mon, 15 Mar 2021 16:57:06 +0000
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8F92211D6;
        Mon, 15 Mar 2021 16:57:06 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] ALSA: hda/cirrus: Make CS8409 driver more generic by using fixups
Date:   Mon, 15 Mar 2021 16:57:02 +0000
Message-ID: <20210315165706.3629-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=501 adultscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150114
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

