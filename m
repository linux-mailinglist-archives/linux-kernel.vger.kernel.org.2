Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A0743405D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 23:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhJSVUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 17:20:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229695AbhJSVUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 17:20:13 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19JIgun9020441;
        Tue, 19 Oct 2021 17:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=j1hvYj7KE9IRg6bqppLU1gJgTfvBwoIaidT1KJoQ7dw=;
 b=a3SWETpOmw2eruKuu1esTd1wAT1vWHPDdaHswKnr581bgfnBVlVbYtTeNNJozN69up4E
 YCsBWCO1+aWW3ie0E6o+EicPFj+c0cvjNHKsLb56kj2+KQ6f+fUNp6kE7t99olKfWL9w
 tlorfgnNZNkR8mjeiGVNTFqKgF59rL8g8TXFhP6fQZCO20acXWuhj7N0FF5lWKLUDfFc
 u98UIIi4YNbb2Y4gFMmTq5Cu7CLOnRQzf43D6EJ/bVFa9XD8J2yrfEiwGYfgRj0ZU2tr
 Lfri2YCraq1+IOizkCM1nu5sWuT0antyAoR1ArIM6ysqtWf6Y632sEK7ZWEBr6KiT4J6 lA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bt3amupb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 17:17:52 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19JLDFo0011256;
        Tue, 19 Oct 2021 21:17:52 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02dal.us.ibm.com with ESMTP id 3bqpcbq81h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 21:17:52 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19JLHoaS35914162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 21:17:50 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A27026A05A;
        Tue, 19 Oct 2021 21:17:50 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BC686A05F;
        Tue, 19 Oct 2021 21:17:50 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.36.93])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 19 Oct 2021 21:17:50 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jk@ozlabs.org, joel@jms.id.au,
        alistair@popple.id.au, eajames@linux.ibm.com
Subject: [PATCH v2 0/2] fsi: sbefifo: Add sysfs file indicating a timeout error
Date:   Tue, 19 Oct 2021 16:17:47 -0500
Message-Id: <20211019211749.38059-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MO48Xx1RitcFtdUiu_LXZN91ZJlXFMJ9
X-Proofpoint-ORIG-GUID: MO48Xx1RitcFtdUiu_LXZN91ZJlXFMJ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-19_02,2021-10-19_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 mlxlogscore=819 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110190122
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a sysfs file in the SBEFIFO device driver to indicate a timeout error, and
notify pollers when a timeout occurs. Document the file in the testing
directory.

Changes since v1:
 - Add the documentation

Eddie James (2):
  docs: ABI: testing: Document the SBEFIFO timeout interface
  fsi: sbefifo: Add sysfs file indicating a timeout error

 .../ABI/testing/sysfs-bus-fsi-devices-sbefifo    | 10 ++++++++++
 drivers/fsi/fsi-sbefifo.c                        | 16 ++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-fsi-devices-sbefifo

-- 
2.27.0

