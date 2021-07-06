Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDFD73BC7C9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 10:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhGFI1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 04:27:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47304 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230426AbhGFI1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 04:27:07 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1668ENxI149563;
        Tue, 6 Jul 2021 04:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=AwsERaTRxjQmoeKPAsWodLLOWJyX2tGAN2F2fumdq4w=;
 b=rLW5Jp8gVVhuAz0ftNbH1asH7WIrp+srW2Wk/PDx1sXIrCmJ9764isrnEN7Y9Z6qcDAe
 8JyLIA28qDnfrhvCK8ZgCUWHaq8+dziamSFyTX/oe5AQ/NnIsONCXiYAHylHD6PyCumf
 IFFDMrxdnYTKOR1KU2UIdvvJ0S4Q96AZ9rW1ka7UC0gQ2xSUJYMML4mS46HmyYtswo5b
 HDWB5mEHbtK0fhWIkaAMZuRR4F8eoCM4TiM9qPiDVwmPo3lSckRH+j24Y0Jj/6BOVoRl
 xaDOVoKd8llYjrr6DxxcWa5F94N/u2YwyRdLvyetJxMkx1l2I6uA1lMJTDu+VNLzmJNr cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39mkg008dh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jul 2021 04:24:08 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1668EUk1149700;
        Tue, 6 Jul 2021 04:24:07 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39mkg008cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jul 2021 04:24:07 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1668GmFI018976;
        Tue, 6 Jul 2021 08:24:05 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 39jfh8s4vr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jul 2021 08:24:05 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1668O22D5767628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Jul 2021 08:24:02 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC6DF11C069;
        Tue,  6 Jul 2021 08:24:02 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD0D111C05C;
        Tue,  6 Jul 2021 08:24:00 +0000 (GMT)
Received: from pratiks-thinkpad.ibmuc.com (unknown [9.85.94.236])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  6 Jul 2021 08:24:00 +0000 (GMT)
From:   "Pratik R. Sampat" <psampat@linux.ibm.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
        linux-kernel@vger.kernel.org, psampat@linux.ibm.com,
        pratik.r.sampat@gmail.com
Subject: [PATCH v2 0/1] Interface to represent PAPR firmware attributes
Date:   Tue,  6 Jul 2021 13:53:59 +0530
Message-Id: <20210706082400.36996-1-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FpVTxjBd_ApVS67fG2KE8fEf3OHqDF-Z
X-Proofpoint-ORIG-GUID: VoeuzEC_mmFBwqNs1uz_U5bw5GyR6EeR
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-06_02:2021-07-02,2021-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107060040
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RFC: https://lkml.org/lkml/2021/6/4/791
PATCH v1: https://lkml.org/lkml/2021/6/16/805

Changelog v1 --> v2
Based on comments from Fabiano and Gautham, the following changes
were made:
1. Added flag attributes to fetch either single or all attributes from
   the H_GET_ENERGY_SCALE_INFO HCALL
2. Seperated the header and the attribute structs, therfore allocating
   for them through a single abstract buffer and later parsing them
   into their own structures based on the offset
3. Renamed Energy Management(em) prefixed variables to energy scale
   attributes(esi) prefixed variables to maintain consistency.
4. Removed bailing on version checks as to avoid faliure in future
   versions which can be backwards compatible
5. Moved check for FW_FEATURE_LPAR before the HCALL is made to save
   cycles and allocations on an event of faliure
6. Updated descriptions and comments

Also, have implemented a POC using this interface for the powerpc-utils'
ppc64_cpu --frequency command-line tool to utilize this information
in userspace.
The POC for the new interface has been hosted here:
https://github.com/pratiksampat/powerpc-utils/tree/H_GET_ENERGY_SCALE_INFO_v2

Sample output from the powerpc-utils tool is as follows:

# ppc64_cpu --frequency
Power and Performance Mode: XXXX
Idle Power Saver Status   : XXXX
Processor Folding Status  : XXXX --> Printed if Idle power save status is supported

Platform reported frequencies --> Frequencies reported from the platform's H_CALL i.e PAPR interface
min        :    NNNN GHz
max        :    NNNN GHz
static     :    NNNN GHz

Tool Computed frequencies
min        :    NNNN GHz (cpu XX)
max        :    NNNN GHz (cpu XX)
avg        :    NNNN GHz

Pratik R. Sampat (1):
  powerpc/pseries: Interface to represent PAPR firmware attributes

 .../sysfs-firmware-papr-energy-scale-info     |  26 ++
 arch/powerpc/include/asm/hvcall.h             |  23 +-
 arch/powerpc/kvm/trace_hv.h                   |   1 +
 arch/powerpc/platforms/pseries/Makefile       |   3 +-
 .../pseries/papr_platform_attributes.c        | 320 ++++++++++++++++++
 5 files changed, 371 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info
 create mode 100644 arch/powerpc/platforms/pseries/papr_platform_attributes.c

-- 
2.31.1

