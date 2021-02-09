Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991B53154CE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 18:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhBIROR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 12:14:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232963AbhBIRN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:13:57 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 119HAZbI129481;
        Tue, 9 Feb 2021 12:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=7IwLg9VTGTZoMODXIJEjmtthSyCVG2rwALKkhzMCJzA=;
 b=Zz11wA9qXG2x9KNUAEg41hbG2TUpd9XQI2uBTtAhRspxVfqLRVNQ2Ey7MsYVoWQevF0O
 0bMgWDrTT0U7E9/VvyBHUT5Wr0Y9WRVPWKjLlQ7rvd7LZmfLbSomse0+JBpBVDWqMf9Z
 5FqNiDnZoXqT3iAKh6HAbJalFM68LqduS5pYNyyADX/EUAoFl94R2FhTxLX/zwErZVph
 2ZtMk0H2WjrTHN1yEdHl3IM0I7Vb22t+yG2/zn4D5kvSpVHRPhZGE87Cc1/wbt1sWNYU
 ndrLaiPayAZlpUbHGlpTfi/u0WwtfSC1thtH+vKleBgNO9/uBpPsF1T5gC2mQ3L/AQ9S fQ== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36kx5hh39u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 12:12:48 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 119GwFMV001418;
        Tue, 9 Feb 2021 17:12:47 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02dal.us.ibm.com with ESMTP id 36hjr9x31v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 17:12:47 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 119HCktS9700124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Feb 2021 17:12:46 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40AA7AE05F;
        Tue,  9 Feb 2021 17:12:46 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18771AE060;
        Tue,  9 Feb 2021 17:12:45 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.163.58.95])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  9 Feb 2021 17:12:44 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        jdelvare@suse.com, linux@roeck-us.net,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 0/4] occ: fsi and hwmon: Fixes for polling un-initialized OCC
Date:   Tue,  9 Feb 2021 11:12:31 -0600
Message-Id: <20210209171235.20624-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_05:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 clxscore=1011 spamscore=0 suspectscore=0
 mlxlogscore=783 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the event that the OCC is not initialized when the driver sends a poll
command, the driver may receive an invalid response. This isn't an error
condition unless there is no valid response before the timeout expires. So
change the starting sequence number and check for the un-initialized OCC
state before returning the response in order to detect this condition and
continue waiting if necessary.

Eddie James (4):
  fsi: occ: Don't accept response from un-initialized OCC
  fsi: occ: Log error for checksum failure
  hwmon: (occ) Start sequence number at one
  hwmon: (occ) Print response status in first poll error message

 drivers/fsi/fsi-occ.c      | 11 ++++++++---
 drivers/hwmon/occ/common.c |  7 +++++--
 2 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.27.0

