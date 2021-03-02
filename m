Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DAE32A07B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381148AbhCBEVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:21:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36310 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238577AbhCBAO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 19:14:57 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1220AZf1081995;
        Tue, 2 Mar 2021 00:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=Vzt4uZUsxQD8GaUMWgumBmK1a+OVBsZEphcm2SVmY78=;
 b=zP3Va/SYdwor8gDNw0BQGU20Ubn43329JLBSjwz3qaGUJPTCFEZtDMoJuZg56EYV+Jln
 qVAzYuhfclGB5M+inAXTedrL7lg4enqhDU8sCTHx47BeOnSwYsCiMQgyH7qz4DG7LK7D
 gJJbp80IgE8p/i7Z7U86iPYCnbiExzw7m7lTp6XRaer6MrIpGwK4jAPsOqZ5IauBvozL
 60EAT6fL4Ex1BVcCzGqTJ3BMiMuDW3QmPJeSQn9xJkrJO/h9fAYgGL4udYhmpPEhnWO1
 DoxIwNJQ5IRa1CIfKHtEiZ5a5stjwEF9Sq0HWrbQgCSE3gRe+u5tpFaCliiz60vh0UL1 bQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36ye1m5r37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 00:14:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1220AwOL084599;
        Tue, 2 Mar 2021 00:14:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by aserp3020.oracle.com with ESMTP id 36yyyy5j21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 00:14:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oepcxgAOyASnH18m28+IfoND2v5yKtKEd8h04GHQhLgUIuMrBkrVb7Pnm7meViAEyu8IJ5kZHcOl38lo/ZvHOFX1bgxQktsUEBgIr3TZ4KbdU5nq7+kdRhbd6/eYjVCw00v2tNzwJRAVoVsjm+zin8H7xa3fEQ1N4ZFv1ncTXW3hY7whUC9y2Ll2yVxDGiVelBnHe/ccCqmFP1QlhptRboErqmY4HPiKaZnLZQw5oAt0tqb4cdT/+R8/akW6QzKGVTdDaaxMr45TBXeehQkqzygr6rbjhDCUEbv0MR8ymVTUTvggu5kBe+F52JFUZ4uWm16dENMbwyt8tN+SzwTmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vzt4uZUsxQD8GaUMWgumBmK1a+OVBsZEphcm2SVmY78=;
 b=SBmKBnJ7KKmmSLDTHiJv9CvqFjeLUqN3Iqa0hTthSXr0kbNv0fxAx4WCXSe4/BgaBAp4FeNzfgwRquEmyss8BnmTQGWroYVci7msJQKZTwlAwU14gBMoD7bLcUws+Hl4w2gcBw0bTC5fptlNCp2MsvaaXz5lJMHBLXcnnJwZi87EJWA5b0l3ZD7yxcA7wmBMSK5MVuH69oGouVjs6kI80Ka/FFUwFiz4u6rsi9x8eo643VJKiACtZaFu6QjqXN0e2av2Smd6JM8yhvri0BV+uNQ8Am0FcqTVuKDFb10av9iwu7lfm2OloSl5ApFzFdkX6fsbM87mJI1fIC1rbu8SZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vzt4uZUsxQD8GaUMWgumBmK1a+OVBsZEphcm2SVmY78=;
 b=PkbBH903qecD8aMfQ3tTzQD1lMoidQFpfa1Q6UJi5FLWdksVllbzJSfXGJDoJL9vAJtbKXrN5eV8nox7hbCLzoccJvbCwU2UOcT1k/89lM6DG6rZjkmAPQSIArO77Jy+3RRqKFKdNK2fFQisXj1rvKAZuR6dExbe4YggXZoxbaU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4477.namprd10.prod.outlook.com (2603:10b6:a03:2df::10)
 by BYAPR10MB3176.namprd10.prod.outlook.com (2603:10b6:a03:158::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.26; Tue, 2 Mar
 2021 00:14:01 +0000
Received: from SJ0PR10MB4477.namprd10.prod.outlook.com
 ([fe80::2091:7e5c:8042:d942]) by SJ0PR10MB4477.namprd10.prod.outlook.com
 ([fe80::2091:7e5c:8042:d942%4]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 00:14:01 +0000
From:   Victor Erminpour <victor.erminpour@oracle.com>
To:     robh+dt@kernel.org
Cc:     frowand.list@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] c6x: Remove stale symlink 'scripts/dtc/include-prefixes/c6x'
Date:   Mon,  1 Mar 2021 16:14:34 -0800
Message-Id: <1614644074-12476-1-git-send-email-victor.erminpour@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [138.3.200.39]
X-ClientProxiedBy: SA0PR11CA0145.namprd11.prod.outlook.com
 (2603:10b6:806:131::30) To SJ0PR10MB4477.namprd10.prod.outlook.com
 (2603:10b6:a03:2df::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from toshiba-tecra.hsd1.ca.comcast.net (138.3.200.39) by SA0PR11CA0145.namprd11.prod.outlook.com (2603:10b6:806:131::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 00:14:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77a7f12c-f0f6-475f-90c2-08d8dd101483
X-MS-TrafficTypeDiagnostic: BYAPR10MB3176:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3176B935350E69F3B1ADB8B5FD999@BYAPR10MB3176.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:494;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7CfgLGUAAmiFTISRqeB3exmcFG5r+kR5YwIFqtJoPENPUzii1+nrOnHAHwF/HGqTFELtXqT3Zn/FtUproqNQA0tD4fRMuB1Nazzzw6JcmNtFv1XtqO/iX0BT4I8QSAnL9GOwdLVfbmd3IXoSQSuR7Yp+7xo+FXTO80ghwgClwcAJeC0OSBjry9wOVrZ7cEdYzqb2XPI7EUqeXRdAFrzxrT/2FGyU87YufJaUM4fUmX/7IMleoo3ALpfi/8B02RM3tAU0n0nbWJxpnyOxdi+35RE6hMmexYDPmOTRJ+eYPSC3vzfmctEziCVs/JfwSLWCdhlg6+yt813IA/72UPe7F5UYZDWrSIOYm5AUAkpRihJq6o+ie7doQ3bXY8V677ZoUk1n/goD55Rck/sIvUCSd7HsuAqJIKaN51XFBGOTECHmzXINbImRJW7AQIvQMEU4GzPtSEBmtyNZRqnUyHGdp47aWGdxBOl8Y6FKPh+53uh+2R+3wdtoBRwVKDcjKGiKUGALT8sXXcsrxmaVcRoTpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4477.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(136003)(376002)(396003)(16526019)(8936002)(52116002)(86362001)(26005)(6486002)(2906002)(8676002)(36756003)(186003)(316002)(44832011)(66946007)(956004)(6666004)(66476007)(6512007)(6506007)(4744005)(2616005)(83380400001)(4326008)(478600001)(5660300002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9/FKxG85J+esWzTYKyKGro1Wa6MADL3NeJH1HF/1rXcXyst5EHM/sZDxvJP8?=
 =?us-ascii?Q?D6Pl3ecF+iUlWSsfneJrcni4G4qEXzq+lrsBFYnoND8UFXLBw+FHYX6RYtYW?=
 =?us-ascii?Q?aMKQxXmuMXnh/U0cg6hA0UYHzkE2V7SMgWhwfVbVWSiZIh5vexqr2wjlTIzW?=
 =?us-ascii?Q?JahVPYowO1PV7j5+QpyI6mE6XSsHyYAcvnH3FmDKc9tzJVnEaUfWrK11Y7mC?=
 =?us-ascii?Q?TQ/hVHDGBETjVgFkNYU1omCBTMYIzG0CibSDJv3os2mzvMTR2sfmhlHipqpp?=
 =?us-ascii?Q?100FPSZgZzNlMBwkKor8GV5AGoYO+L1m5kbxTerH9bG1iKn+RoL2qHf4WjNa?=
 =?us-ascii?Q?16qz4R1KKi9zDVhaLlloSEjJwIpPinwalbdXzeO+vi460kOgLi0Z44rNCGbH?=
 =?us-ascii?Q?C2uRmZZ35rAyKnmuFESQvKEuOORum5SNHBv2ywhtB8rlY6Y6TV+9UVjkmv+F?=
 =?us-ascii?Q?uX08fWPWK/4/W4kebF5T2A6gq0TXZ8T7t6KBA/6tuyui1UvRIp6uDLlgI6xz?=
 =?us-ascii?Q?aqNcRcQ9+J4MJXPzsJWomkgGuN3BdDC5F4lZ5c+CeVrNxCIin8h0BT4SgU1u?=
 =?us-ascii?Q?ASfxUt20kSnCuTwWaB54bNfTwBTNAmCe2tlwvgJQVt6ouSJt5Mbu2dT2xrov?=
 =?us-ascii?Q?nJQ2fMKYZvEAJTBxTAEUmm/wGnUBXKUDeBwTgSCvLQuRqyHhsU3b3N8s8a2O?=
 =?us-ascii?Q?GDXXB+coFjQv8fVDdTwpLhbjzBmSvyxGoZcdWhae5WsPx5Z2NkOX985pra2H?=
 =?us-ascii?Q?2XWS9VWmS6qZjzG4PzAsqdQOU1WrtzWMmVRoOjgSiYBYC3EzufWOUsv2ptQU?=
 =?us-ascii?Q?f/yymftn1gtcqw14EFJ05LxkmHj3Yn22E4NSDZca7wBoqvlmDVBlC2q760yM?=
 =?us-ascii?Q?AZ6u4Hl5XJ+DsrHCDZLBBdnT3nYV+c5G1RoEAwnpB3W7vm2ouj3S8MRS7RDL?=
 =?us-ascii?Q?YderNOkoLNQRZy7gNyHMKTyO4G12XWS6UcPnEX8SSgnLqCZCT6TQchkFnm6d?=
 =?us-ascii?Q?0wpZHCmu1N0+JPFDVD42qIYtj8LIj4dkrzTF9BBz8lL3iCD1HviVAPRoowex?=
 =?us-ascii?Q?1K/nCjGwOjusH0/gGHIpevclPhpD/dvd5CAX6OebaPnpGnUtVs0jlllQRhmd?=
 =?us-ascii?Q?R2ZqdFrJPwEfqvXehWbRxfzWYtMaf+gdk1M0Gs5swiY5t9G4oK1y0YgoxDaW?=
 =?us-ascii?Q?HF1MjZ5ErVE8NFIE6bpVLLwjR9+fJJlg84OQ4d0Tk97beCZiO0ZMNa/9o4sC?=
 =?us-ascii?Q?ctWvsjOJxes5r6icvqUTK3wbVFf46/hBmrhwAcLkLpQL8zFdqS8NNpXkuT5s?=
 =?us-ascii?Q?+kzUIYavwbhh6n2GW3zwxGnZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a7f12c-f0f6-475f-90c2-08d8dd101483
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4477.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 00:14:01.0030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9i/gBUmjoIBFvMBgpyVOwy40OwNRJbrsSRWZtPt3IkNhP50o35f9a298krm9Hi5vXQgoZ3Lrs1S9sa3ipzy9GJ06T+VrfoSk3CAmmCyjeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3176
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9910 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=871
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020000
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9910 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxlogscore=992 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 mlxscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove stale symlink 'scripts/dtc/include-prefixes/c6x'

Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>
---
 scripts/dtc/include-prefixes/c6x | 1 -
 1 file changed, 1 deletion(-)
 delete mode 120000 scripts/dtc/include-prefixes/c6x

diff --git a/scripts/dtc/include-prefixes/c6x b/scripts/dtc/include-prefixes/c6x
deleted file mode 120000
index 49ded4cae2be..000000000000
--- a/scripts/dtc/include-prefixes/c6x
+++ /dev/null
@@ -1 +0,0 @@
-../../../arch/c6x/boot/dts
\ No newline at end of file
