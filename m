Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2DB36B6FD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbhDZQjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:39:37 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:52002 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234108AbhDZQjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:39:35 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13QGbpT6021529;
        Mon, 26 Apr 2021 11:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=eqJUMbnkhTrwDLjuT64AjqedgEqwqlStWMiEMC13D7U=;
 b=fDIWsjClttMG+6rv/+e7Kz7CdqWlY/8kWmedbcqXAJnFvaLQWVuafJJtBCiUA9YT9ugf
 WZSKGPvnPJdWODonXyVMg5ba2etb5FANP+zd973FnH1VKprDm8ZyqwQAXaSs1YyHK3+m
 n/jbEJouGB1dBJDxKYuYycUKdw1HYibwuSkxSfob6Oxyoa9rFmpHiPdWZg8Am70Qlpv3
 lnzsAfpDQmGTEkMXrslAA3Xqs1jnVTLC/XNmvawAeZyU6xBr4DtAao1Ub3yoj4LBZPqV
 DHMyDplyaeLi+QmVepcOxaOpATQjVEKFGVVGpfEyEAdUrY911NVW4tDZ3VbMzpkvRcu1 TA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 385wdbrayb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 26 Apr 2021 11:37:51 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 26 Apr
 2021 17:37:49 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 26 Apr 2021 17:37:49 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.203])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B219411D1;
        Mon, 26 Apr 2021 16:37:49 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2]  Fix couple of bugs reported by Canonical
Date:   Mon, 26 Apr 2021 17:37:47 +0100
Message-ID: <20210426163749.196153-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: u_eH0bjPAC3fqQA8uy1G7KrSZYbLPP6u
X-Proofpoint-GUID: u_eH0bjPAC3fqQA8uy1G7KrSZYbLPP6u
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=911
 clxscore=1015 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260127
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CirrusLogic: Cracking noises appears in built-in speaker when output 
volume is set >80%
BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1923557i

CirrusLogic: The default input volume is "0%" 
BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1924997

In v2:
- Add additional information in commit messages.

Stefan Binding (2):
  ALSA: hda/cirrus: Set Initial DMIC volume for Bullseye to -26 dB
  ALSA: hda/cirrus: Use CS8409 filter to fix abnormal sounds on Bullseye

 sound/pci/hda/patch_cirrus.c | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

-- 
2.25.1

