Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD72460A52
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 22:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241368AbhK1V2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 16:28:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45926 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235923AbhK1V0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 16:26:00 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ASLLFSv001107;
        Sun, 28 Nov 2021 21:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Ys4l5tbNah9gp9ZA/2/6hD3QjZjXlQL+H7Yg1QZPkEI=;
 b=D5S3MM1ZWxgxVzwqqH+iptvBFtTAx49u3ivMoewyPiShWXt+Zgf8BV/KhbMlGpC0Rmxd
 KeR62Js8ovfTmfrMY0O6c5yHf9z2p/Q7g0KZYw+/lC+Yzruy/P7ur1Cmuj7BaAZSMzM7
 7C9l4O23AddGN9rMbfo68CYwjd3SIWWMEejuH+CqerCBqmpMOulsAYbrVR1fN47TCFcX
 ZqYUgaiNdKX0I/W7/6fdM6uatnXzPDhxu/SE41kdhSIlG1CIeUTLVqrMj8iWmEfG+BWT
 +9UVW0MR8JJswhKBqwN15jkjiSs1Z2DvaqgpaAlo33xkBATUW9/eXM4vcfQXAv4nUP91 nQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cmhky80f9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Nov 2021 21:22:27 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ASLLjpY003905;
        Sun, 28 Nov 2021 21:22:27 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cmhky80f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Nov 2021 21:22:27 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ASLICPF026667;
        Sun, 28 Nov 2021 21:22:25 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3ckca8xdmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Nov 2021 21:22:25 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ASLMMTG63373700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Nov 2021 21:22:22 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 686895204E;
        Sun, 28 Nov 2021 21:22:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 185445204F;
        Sun, 28 Nov 2021 21:22:22 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Len Brown <len.brown@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 0/3] topology/sysfs: only export used sysfs attributes
Date:   Sun, 28 Nov 2021 22:22:18 +0100
Message-Id: <20211128212221.1069726-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: o3sCDf_94fvlZY3Cu5QuRW9PeAPvXZVH
X-Proofpoint-GUID: CIESnp1ALJNU1bZLxFcny7otJfALwDpt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-28_07,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=802 suspectscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111280119
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create die and cluster cpu topology sysfs attributes only if an
architecture makes uses of it, instead of creating them always for all
architectures with bogus default values.
Also change the book and drawer cpu topology macros so they match all
all other topology macros.

Heiko Carstens (3):
  topology/sysfs: export die attributes only if an architectures has support
  topology/sysfs: export cluster attributes only if an architectures has support
  topology/sysfs: rework book and drawer topology ifdefery

 Documentation/admin-guide/cputopology.rst | 33 +++++++++++------------
 drivers/base/topology.c                   | 28 ++++++++++++++-----
 include/linux/topology.h                  | 20 ++++++++++++++
 3 files changed, 57 insertions(+), 24 deletions(-)

-- 
2.32.0

