Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B7533DCEB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240186AbhCPSvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:51:46 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33544 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhCPSvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:51:24 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GIXu9N100659;
        Tue, 16 Mar 2021 18:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=O8D8yQA9dDMzosQMIz9nNNKSMfbH+KXnCIfgp1QI6uU=;
 b=cUOozaPJN5nULGtEgt71YXzLsYGHDFGfBQsAAuxZwFdNuViu3/v63utcgKDetHSC9Avy
 ek3Y4QvxL2RlPwoRQx8qmRI2gyZqmF8m57TM2uwgka+dWTb9im6Xc9kIjGfnrU3RmCNG
 JVsnH1muMTXck3kIrF1GVzBhuRTia8EktP+wtxM5PeZK32zDpRaBL1KXOVYKSjbciXXC
 tzGkjcHQNu2cX0z8YkkOKFucs9OXD/jTCNnTKiO2ECdks+5adqnAvyO6tyYTISkRXZu9
 8pToe/ps3N4/Tn4XzPN09UQawhgR3V43UQTCJeeedN1Aoxzhdg1bWt+fEh+fSd2Aya5h zg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 378jwbhprh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 18:51:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GIZjRB026597;
        Tue, 16 Mar 2021 18:51:04 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by aserp3020.oracle.com with ESMTP id 3797a1khnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 18:51:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afvRm4oZW1d58axUCcBP4JiP8IYtWz+6D4hmhUsH6c5BBthNAO6/zbHroo9BykgMz8QjDlrcnjKU5ADHSr/W7VK3xRXzHbmeX9b2ZrbdMCECa4+SdfvB7Wwd+lJLwF9FVn2nggpzmagr4y7+dNjlnk5uFAVW8uSgXDY0AvyTmKbfXQAuTmAwOkNO14Kqv48Y/JxaZaIK3ASploJBWqGbDbgo3SWvEYqBV5Y+/LJoWB/m6vMPir/uDJgHP+eUXTuH9mIdzaFAL2VN+8j+eYmEiuP7XsvdCgIdy04JGIX3wMsuoUizCEYYY3+Rttw/Ro9oiJh4PgxsiUMG6Rej9qdmHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8D8yQA9dDMzosQMIz9nNNKSMfbH+KXnCIfgp1QI6uU=;
 b=D3BYbQEGUjDnunJCP6zXGDB7HVhlSYAIRR1+RwcllBswydO6u8lpYIlG/IHPYmJFm4cnm3MYDx2tme71HTXkjvDUMmYSfmOX++gOK9W6thW08ENpUTi3o4pdJiFuVBRrZsNRMblBEzpKs5Ay50LA8sva4F4/V9wVKNgi1rE3dydVqtA4gRNYuIzuIGqZKLqO/97heo4xwy+XDACAKOj4lgxFVf/Z+8gn/t+XsNd5PKFAy8fb089PoSQA8Jh393/RdA0vD8lsBR9OKjRRPCEJj1r/1MxIyJ0UgKAkyRnX5ox2xEfry+3TB3GoX7kKIlnq8Q7F6eDztj8XP1q5sjPfRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8D8yQA9dDMzosQMIz9nNNKSMfbH+KXnCIfgp1QI6uU=;
 b=e+ANHiQCHdsn2/HjGVHdTGBk6NrDrtZ36+/vfcqYE5B//D3xmFvYtrehw1GVv1bbGHusgtwHnOOvWgnJ6z8CaX2U1JK8QdBX+z9IUfQDjNQYEGOigALMR1pURyDU76FiofGsWTvr5ZrmBJ6ymfKUWmYqEeZqwsGb9Dx1srquYbk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BYAPR10MB3319.namprd10.prod.outlook.com (2603:10b6:a03:150::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 18:51:02 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902%7]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 18:51:02 +0000
From:   Tom Saeger <tom.saeger@oracle.com>
To:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Tai <thomas.tai@oracle.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Al Stone <al.stone@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Saeger <tom.saeger@oracle.com>
Subject: [PATCH] Documentation: arm64/acpi : clarify arm64 support of IBFT
Date:   Tue, 16 Mar 2021 12:50:41 -0600
Message-Id: <9efc652df2b8d6b53d9acb170eb7c9ca3938dfef.1615920441.git.tom.saeger@oracle.com>
X-Mailer: git-send-email 2.31.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2606:b400:8301:1010::172a]
X-ClientProxiedBy: SJ0PR13CA0101.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::16) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2606:b400:8301:1010::172a) by SJ0PR13CA0101.namprd13.prod.outlook.com (2603:10b6:a03:2c5::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.11 via Frontend Transport; Tue, 16 Mar 2021 18:51:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2537b9b3-2bd3-4b97-6e90-08d8e8ac7223
X-MS-TrafficTypeDiagnostic: BYAPR10MB3319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB33198505E43EC4554175AF8DFC6B9@BYAPR10MB3319.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:568;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L28ONLmycW9An9F9jdjzx32mBX+BaDlMpEG5luy5r/VqmU+Ba/Hy84FdYPTM?=
 =?us-ascii?Q?zTwcLynf8e0NCgBbYGsZEb0sB2BxIoWy/h+TuhDH7uVtM5RI+yHaw4TEQZK4?=
 =?us-ascii?Q?6m6Gs23RjQ0/T1kIyvezP4SjkslC63YTdBU4vRTC/kM3fKNHL0d32UIOMHtJ?=
 =?us-ascii?Q?+pmqGTgG875fLq9JoFzExpJNC6H9fN0CVXg4ZA4wlyld9SmbXjGKpZNnCaU6?=
 =?us-ascii?Q?wvXBQrdNwolIR1g7HdGCteydLt0r+UgP+Y28T9BTJLRytkZ0WBzwGVjB+S+U?=
 =?us-ascii?Q?3G+PUDoRqXRI3j0e94M8Tm5z7XOXPqpndLcmRyU5s7j5BMNoNC7auvJC9TqC?=
 =?us-ascii?Q?3g3Vk/qn6rBVQd5+sJUVd2PHOVuuKkgtaThlbrIwaqFtdaRDqFnVZfVQ1LQ4?=
 =?us-ascii?Q?YsumARk1jDF51B7QsEv43fxSP3kbh00cap6L1p+2ahSvqxVQffqT1JWhmmBO?=
 =?us-ascii?Q?t68pBIhOCR2TdsGut0UIDL1mMjDcfNw32sD2CCZxIpQwp5nEn4VRUxUkWB5p?=
 =?us-ascii?Q?ullmfuLlZe5Twdi6JlUxS4myAgmqLr6Qw2iEF0L3Sf5qtGo88h7G2Kain/qj?=
 =?us-ascii?Q?qqf1GL+jCZvbThg88Nw8oxQsaBOmZVkYqKzAj7t4miSFSWKnZFudyw/obvcB?=
 =?us-ascii?Q?/lGc3+9rL4+8cdKmwPdLKCS1JAW1yfa17j1pb2u4E/OUMDloVPizHfYyba4J?=
 =?us-ascii?Q?bUVq5zY5iovn3K6/GR8eeltmu1gq+Q9V1Do46RPsp9aRh5uSAN9Gp0E+lsTK?=
 =?us-ascii?Q?RDQPhDSxGlLMuH2HwheMYEvbAq7XfV0LR4VXv9qIHNKryq6b+TLHkntHsa8o?=
 =?us-ascii?Q?eA0FCqcpzGMbvFQtx3QYlPQCAHV9jCuX+HDLzxifO9tYdO/t0sTW6SUnMuls?=
 =?us-ascii?Q?/xI8S6/EyABuQpVczXVi5qAiDmIzwtoflHJupO+lt3SW8SCGmpvPersqevKS?=
 =?us-ascii?Q?uHdsPbOibnv/gNuDHnlXhUURcs0W6lM7592WxsB3Yf5C1HV3991bxxKrHQsA?=
 =?us-ascii?Q?ZLbh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(376002)(136003)(366004)(39860400002)(396003)(346002)(110136005)(66556008)(6666004)(478600001)(107886003)(4326008)(36756003)(86362001)(186003)(16526019)(52116002)(2906002)(5660300002)(8676002)(44832011)(54906003)(316002)(2616005)(8936002)(966005)(66946007)(83380400001)(6496006)(66476007)(6486002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?INKbMyg6HFMyYlZOeNUaafebsdetai+a8vIwXas0VDe4AQHEa4idMLPPY4CK?=
 =?us-ascii?Q?+uqMCvJCmbZ3m0VHUTxZk1+Ksuh2iCfiRttxch0ytXsqiG3C01arm+QBT16C?=
 =?us-ascii?Q?gjmmIlJklBbaTmRVvQmEjKBm5hyhDDZyiE9meeE2/J8NPqpOeIXLr+ntrYAy?=
 =?us-ascii?Q?9K17pOULhbcTtSjr64DoqKlKU9H3DdM+hgC7sKOm3/Dxr/ro8Jyy3Jotx7ZO?=
 =?us-ascii?Q?B7VF7BIhFw3aJ0lGhuXKt03K3On6BiqqoINO8jWtHh4X8W4+BNoj4ImFAAOt?=
 =?us-ascii?Q?/zvhI2NP4yyeu1srEvrZiDAQVCOB9yZx4mTorNYtIkWhwehOya6GuchyqLmh?=
 =?us-ascii?Q?+HgYu7ZaCupc4fAlHHFDXN8HJu7NyRDUNHWPrCJde8Jjn/vUGZgCIlnA8VIB?=
 =?us-ascii?Q?06GA0IBnm2pnSMRy5rkcP4/BYrNyoLfs/bGc922mM3InW4UHD+gQNO6iuz3A?=
 =?us-ascii?Q?H+Q8lTine0ExvTSdMDCO2brrXUWHY+9FV6AUpIXr40j8zTyZ6g/rVfDOPcLu?=
 =?us-ascii?Q?UshsHIgOmsBKl1IDgr1X574juFkdRG4MxtRILap1q6tFyONuGEuKd8FUOqg/?=
 =?us-ascii?Q?fDwjR/gMmFqSEnCghn2YMKE26jQbmY9zLZlUr2Tm0mt0lLLnhQzCG7M0LyCz?=
 =?us-ascii?Q?ITOe7jb8w1Jg3h2Ub0XL76xYrhn+PSraQRbTPzRzqPnDsCyMB71oBqAL6Ukm?=
 =?us-ascii?Q?H1BkByfWyieNVU7XNHFuk+x3/If/Bt2S7qJkmyhDLjtjWLv0ELfhYMH4I7pT?=
 =?us-ascii?Q?FYxsr3HegBq9Mgy0CI9FrLpMdlJFnVNPmbKgf/BkCYkPOuTwRSunQ1NA2yLg?=
 =?us-ascii?Q?Q0q0TFSGfDbz0UAZ2FARW1WCwXKc16B36l6x5Q7oJRGEIWcYwCm5AJMBq/2H?=
 =?us-ascii?Q?8C5tmgLEXiDnk6xd+p5waJe9HjaxBtxCQqY5Q7cTAHFpYo0cWsFMSewkhnfk?=
 =?us-ascii?Q?1yQLXE0vxEoeoI244eifpRlbe5lBa5rLuMFFEh6q6MLY7jQffHdoy3dIDYdN?=
 =?us-ascii?Q?NYe1ta7mKXlkZCKL6If3yze4kurEsFGgmy49+6RY+I9kea6fZk1Q67Rx2HyS?=
 =?us-ascii?Q?AjsGYZRy3s0+VJL//winsPLd5do51WkK+lVigNWdfooSk/AQRGvW+MccaDSJ?=
 =?us-ascii?Q?/tvXf47Ldvzp8VDYubIm10dPTlvv13h1MKTO6uzBEsqp/Nx5s2+lrbgPMX4a?=
 =?us-ascii?Q?58uUviJVbUSXb0OUiIDbUcR/MuI7XTz277N4pHn02227I1RNozA4vy6DnR8t?=
 =?us-ascii?Q?3pW7BVfoJAV3viEoqvrl2hDpoiIF/XRaR2+Sx6dXlfeX1lCIGh0LyvYMdNOF?=
 =?us-ascii?Q?wg7PhKGfISbUra3PHXGWaGnHOKOij/h9LxacVlTtQ8lveQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2537b9b3-2bd3-4b97-6e90-08d8e8ac7223
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 18:51:02.1817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwWncuJdCairYHncbCpwYQxsZwcrX9NB7FQ2VRbAe5NWoMc/d6CbGUN5i3ZUEt1d0MMiyOKYoMGHcAoxnUWpiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3319
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9925 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160116
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9925 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 adultscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 94bccc340710 ("iscsi_ibft: make ISCSI_IBFT dependson ACPI instead
of ISCSI_IBFT_FIND") Kconfig was disentangled to make ISCSI_IBFT selection
not depend on x86.

Update arm64 acpi documentation, changing IBFT support status from
"Not Supported" to "Optional".
Opportunistically re-flow paragraph for changed lines.

Link: https://lore.kernel.org/lkml/1563475054-10680-1-git-send-email-thomas.tai@oracle.com/

Signed-off-by: Tom Saeger <tom.saeger@oracle.com>
---
 Documentation/arm64/acpi_object_usage.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/arm64/acpi_object_usage.rst b/Documentation/arm64/acpi_object_usage.rst
index 377e9d224db0..0609da73970b 100644
--- a/Documentation/arm64/acpi_object_usage.rst
+++ b/Documentation/arm64/acpi_object_usage.rst
@@ -17,12 +17,12 @@ For ACPI on arm64, tables also fall into the following categories:
 
        -  Recommended: BERT, EINJ, ERST, HEST, PCCT, SSDT
 
-       -  Optional: BGRT, CPEP, CSRT, DBG2, DRTM, ECDT, FACS, FPDT, IORT,
-          MCHI, MPST, MSCT, NFIT, PMTT, RASF, SBST, SLIT, SPMI, SRAT, STAO,
-	  TCPA, TPM2, UEFI, XENV
+       -  Optional: BGRT, CPEP, CSRT, DBG2, DRTM, ECDT, FACS, FPDT, IBFT,
+          IORT, MCHI, MPST, MSCT, NFIT, PMTT, RASF, SBST, SLIT, SPMI, SRAT,
+          STAO, TCPA, TPM2, UEFI, XENV
 
-       -  Not supported: BOOT, DBGP, DMAR, ETDT, HPET, IBFT, IVRS, LPIT,
-          MSDM, OEMx, PSDT, RSDT, SLIC, WAET, WDAT, WDRT, WPBT
+       -  Not supported: BOOT, DBGP, DMAR, ETDT, HPET, IVRS, LPIT, MSDM, OEMx,
+          PSDT, RSDT, SLIC, WAET, WDAT, WDRT, WPBT
 
 ====== ========================================================================
 Table  Usage for ARMv8 Linux
-- 
2.31.0

