Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E78444EDF0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 21:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbhKLUgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 15:36:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40438 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230235AbhKLUgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 15:36:42 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ACKILbr008637
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 20:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : cc : subject : from
 : message-id : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=fC4njs+d6RlWalJTSv5sBOoA19pkO4CblIbWtJyDIJY=;
 b=mt1j1np/0Ogi0BRVE7zmA4jFc7EEPkYQa+TTa9JIp7+vjl/PtqOmvAV3bFDMjnQvK0h3
 oJNNOGq1/mplVxxmeMAjTlrNwfiI8G4bHVFZ4kqyTvVtbUUiFDHwOvqOVSx0Fep7afuJ
 C4YuzlBuE5yOndj0RWWkSqUhJ8WKCOuKMFS709coCIElSMKCZjpYY9a6E02hIPSORzCL
 gAxD1VBIIZ/Gppha6KZ3yLIWfHJ61PHFiQAT71i1UdJfkkYidnbTjxV6awosZa2cIi+2
 IHULX7st6EmS/Hp2nDDRg2bS06ZDYRV1Yfa9PeY4fVs4p2ri+xZy/dVAU6oICkVm43xU rQ== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c9y6j07kc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 20:33:51 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ACKDMM0022601
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 20:33:50 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02dal.us.ibm.com with ESMTP id 3c5hbebhv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 20:33:50 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ACKXnbt61407526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Nov 2021 20:33:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7760EB2064;
        Fri, 12 Nov 2021 20:33:49 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A140B205F;
        Fri, 12 Nov 2021 20:33:49 +0000 (GMT)
Received: from mww0141.wdc07m.mail.ibm.com (unknown [9.208.70.161])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTPS;
        Fri, 12 Nov 2021 20:33:49 +0000 (GMT)
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     "Aniket Kulkarni" <aniket.kulkarni@us.ibm.com>,
        "Rajshekar Iyer" <iyerr@us.ibm.com>,
        "Pawan Powar" <ppowar@us.ibm.com>, ask@linux.vnet.ibm.com
Subject: Question regarding map count for compound pages
From:   "Harish Mara" <Harish.Mara@ibm.com>
Message-ID: <OFC84A937E.DCF95A5F-ON0025878A.0080F49D-8525878B.0070F4CB@ibm.com>
Date:   Fri, 12 Nov 2021 16:33:47 -0400
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KeepSent: C84A937E:DCF95A5F-0025878A:0080F49D; name=$KeepSent; type=4
X-Mailer: HCL Notes Build V1101FP3_03312021 SHF15 May 21, 2021
X-Disclaimed: 26719
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WwftxQ2cimZi_OaOFLjy1cXPqh_Yh0dr
X-Proofpoint-GUID: WwftxQ2cimZi_OaOFLjy1cXPqh_Yh0dr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-12_05,2021-11-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxlogscore=955
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111120108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Background:
On older kernel?s, we could have our device driver create char devices and =

implement file=5Foperations and vm=5Foperations for open, release, mmap, fa=
ult=20
etc. The driver allocates memory (128KB, order 5) as compound pages.
The user application would then map/mmap these device files to perform=20
read/write operations.

On recent kernels, this creates problems when the user space maps multiple =

128KB chunks that exceed 2MB. This would sometime result in bad page=20
getting mapped to the user space process. Almost always we see ?Bad page=20
map? errors during munmap because the map count is going below 0.

It looks like the culprit is zap=5Fpte=5Frange(), which calls=20
page=5Fremove=5Frmap() with the compound=5Fflag =3D false. As a result, ins=
tead of=20
decrementing the compound=5Fmapcount for the page the page->=5Fmapcount is =

decremented causing a lot of bad page errors.

Questions:
Is this the right usage of compound pages? I.e can I allocate compound=20
pages in my kernel driver to be mapped to char device file by a user=20
process?
If yes, then why does it fail on latest kernel when the mmap-ed size=20
exceeds 2MB?
If no, why was it working on the older kernels? If it worked then,=20
shouldn?t it work now?
What is special about map size being greater than 2MB to trigger this?
Should compound pages be used for Anonymous purposes only?

