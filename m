Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83C7458FBF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 14:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239604AbhKVNy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 08:54:28 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52680 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229984AbhKVNy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 08:54:27 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMDhRB9024892;
        Mon, 22 Nov 2021 13:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ODi8wmnRWLHXAvJgDBgRGdkcGI+rtpoV+/xdkYmnZ7I=;
 b=ColXMnzMXGtc0yzH2x3iO8HIU9qMkY70bqcgZDz7HAqYp3eYyBZil62dBwocOTRiD9Et
 ZQjaQPiQmPy/tR4mrpcKOuLUXZFTOPK/8T9tHCYn4b6938uJKPdggTu0csCeCGAlKNND
 SdOy6KSAMe+8tKhDA5n+4aCq+m6gkCpQjC0qgcOgf06xM83X1DnGqTcOHvRhCjFif4tr
 59KVgrfGj80C9g8g+wBYTeByPdUhcDhzNvUp3wMImQVuFB6z+79ZbHbidG6j74cP39Tc
 6JLY6Tio5pLuWCrjHyfn4MVcwZ5XNDzH3i4xMo5/5lajKU3rV10nfViTMq4pkwWa57sN +Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg69m9uh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 13:51:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AMDowYG148042;
        Mon, 22 Nov 2021 13:50:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by aserp3020.oracle.com with ESMTP id 3ceru3guw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 13:50:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vkoj5S39RNJmGhWjEqlebZXSTMmywtxkwN08V84NTYoNxhxLju9AfRTp3mBG1PODaKFNb6qzSthuMQhXmC9F6afbUTwxzc7jlzcxrSnPXXgMUxjPO993/ugxRkaLSBcBCXpvwbwnvQdUZusGcn0l3MGrVRs5LFCmWLvdtTpApykRcwpVT1RRg5IpRhs+htZZNnyw+en6EakcBm9/Mr9ehk+YiPNxW4izrW23PfYAUmcoZTKLJvhskS0d6m8IFBN5xXWiER1i9QQdjtAwtUv7U+AruPuNCoJiDVO85CSI3/runUV5XwL322giCBZnRYtUO5eT8eIz8WP42alkOoBsLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODi8wmnRWLHXAvJgDBgRGdkcGI+rtpoV+/xdkYmnZ7I=;
 b=fbPJD2uhtuyYBORQ2XjDnQ8EHC92wuKrX9Z9BSBGFwkNyZ88yYBiYxk4Xq35E/at0jTsOLUWJfnhsOgkmm4BckmJzoJxNzvTLBDLHpuH1nAQ8IGNwJykMjGlQY5HWICGvVnz4FIo9/C2HPzTWlZx6DZNe6jBGqQn450nBQ0Vt4AtiGeEBsMBaE0K8rgnBPEacG+MRddPEWWFFCmrR7IUNzBM26wsTjq2btNajueA+frNDVB40Uvwm6tUgf6W/dXgPjjXINgHuYWDQtcytBsWOdcB6m3KwUJxoeb4063FhLHWgtElE88uwgl1aeE3f2l5+9um+6K89gBvKGwZ1x3mSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODi8wmnRWLHXAvJgDBgRGdkcGI+rtpoV+/xdkYmnZ7I=;
 b=Rzhcqsvq+NM5/5oRndfeom42NHEOsR9FVIvFQrDzb1e9Ea0iPMCT2Thkbjtb0JE6KnFCn7tk0RotYdTUHGf8FXmMyNk2gsZyMNVjbWarjFui3LPm7T6bUE+nmTDnZeMmfNgChkJh4z+wRUNN4Cyse85WeREpqRHsk1r3yLYgpqo=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5725.namprd10.prod.outlook.com
 (2603:10b6:303:18b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.15; Mon, 22 Nov
 2021 13:50:55 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::495f:a05d:ba7a:682]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::495f:a05d:ba7a:682%6]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 13:50:54 +0000
Date:   Mon, 22 Nov 2021 16:50:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gaston Gonzalez <gascoar@gmail.com>
Cc:     linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        nsaenz@kernel.org, stefan.wahren@i2se.com, arnd@arndb.de,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] staging: vchiq_core: remove superfluous
 static_assert statement
Message-ID: <20211122135031.GB6514@kadam>
References: <20211122130926.342128-1-gascoar@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122130926.342128-1-gascoar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Mon, 22 Nov 2021 13:50:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc258970-147a-4036-c4c5-08d9adbf1a8a
X-MS-TrafficTypeDiagnostic: MW4PR10MB5725:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW4PR10MB57259831EF59FD3150F772898E9F9@MW4PR10MB5725.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:473;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z1CoAZ2aq7/ubL2wGNOPBLp5x7EXRIfheCa/iU2HvPgyQKvn1sHK2n5vkNG79yDYEj+WL50GemGbolRCbGDNL/TRB0qGqAwphOaBORfaDsQre2U3yF2ChE/ZW/E4dd2J/cPRZ9iEQOtkkW5pstyWxUsVJKbuwCE10GqT3U1dUZW20GLRMQV1AN5/V0KQNywIP7j3K+Qrf0WyLp8NyuprSG0mq/dTXiL4C7LN1o/q11bmKmTm/VMDvH9tWpKPeYx+NG8iQX4SUBzPuTSSvHMrzk5ie5y/E+gXQTMdwGXhWQK68BK7JVN2ULj5z3wkSLDGIIWvTzJpjfdJtMum5MRRym3N1/EWdX8AKajQqWgTfJUdZIeGa8mxVc3fS8jZcjEAI8bxSXGIieVV8imFwa3/nLfM2myNN+Hi5mkhaJ3aEdBYyvdd1KMPgzuEvbeG44Y9ehg1Qd+bq9uk2jggWSw0wycUTHlKBHkPox10j568LDQNEEfrMr1pspSf+i2Zk0T0HDkgkbHPF690b91D7vpv0tMi+IPonbXn11LEviu9aqH0JzZ9XOMaroWRksSmiy09ahhAio9y4eREJCfclOYQJyvbkySqDxt0FP4j1ZX9r7ObMGBUrY82kBfMC0dIZF2MsfF4NS60Y6Y+FhMJ3Z4R7VNebBXGbnT8NtuX8+RVP0YG+ogX4+i5h/aBq+1ZlkpMM+vGkoYAvh7eXOfsc7ePIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9576002)(6666004)(8676002)(26005)(86362001)(38100700002)(1076003)(52116002)(55016002)(44832011)(66556008)(66946007)(9686003)(38350700002)(33716001)(186003)(6496006)(4326008)(4744005)(2906002)(508600001)(33656002)(956004)(66476007)(6916009)(8936002)(7416002)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qon2LslK6lZJT10gGY/d03tY08/quCbpBfCrT61EM1JAXL5Hu9PTfHm/PO4e?=
 =?us-ascii?Q?y9EbsFpAB/KPqBA96htA5bzXECxgNDzcost+6bQJWLKBFJFIH/uvGp/W8QQW?=
 =?us-ascii?Q?c3nBDNDVo4MZYNh2Nw8C41Hv5ii66AB7WcQtBZ8Sp57pRRFf+oAapI1/L29Q?=
 =?us-ascii?Q?1lvMTypSHdtvER5s5eRAB+HXRX4W9tFRAU2w26y1i0v1yW8cDLh24edvn+DH?=
 =?us-ascii?Q?CdA4Si/D+ulBEBoY5c/ENvrPhVy+VyXHbsUijGG2eykjOgmPr8XnZgz77AV3?=
 =?us-ascii?Q?U6dccZUK12r9j+OYeiQbUPsDTW9rogXKI8a/lgJ3j6o5t4NcmdGVmqkuJJea?=
 =?us-ascii?Q?o2PxgL6fP5IYPEKX7nE+4UsKxMkuPIxcEwqXdRS6wmFFEsjXTX8LojKgOGeR?=
 =?us-ascii?Q?tBOUMSdEjFoj/jFrfK2BDl0btv8oCL9FNoG9lbwpdLjxy9q+Gi+tWe12V56q?=
 =?us-ascii?Q?KhU45voOk/EffJB8vyz1pL+WB3qXWarVZTeXHhLb3m8IT2AQM9tu6ztACe6O?=
 =?us-ascii?Q?wFhhQB6kd/5Sh/xuxlSrCeRtOoyeMHZQv56dT1el+VIzqGWv7w2vQRF5OvQY?=
 =?us-ascii?Q?/dGVO/9p1hAKVN9pUlbtc80xt6UJ8tcz3/73ArLCOMQo3Vtnn3umJbSYDknE?=
 =?us-ascii?Q?VoeYE3tcu+xYGyj2qfpX8vu/SmMCyk/yU0/+wrYcs6NZqpkn6fY0Flju6ccB?=
 =?us-ascii?Q?Yv1VB1hXC8rvjsk4BSNTjFEFP1Myn/iiQRUMVFosjT6G5BoQz1usl6YnZGUO?=
 =?us-ascii?Q?QliockK0M3p90/tofd7NNg2QgtGNA7J/kTAMYrs7tez2e79z8K1rVU4n3o1M?=
 =?us-ascii?Q?/cDcw8Tr1AIlmP0r9kGcvoEM0xUJ0ZqnBcGtmRO8av/jnj1ggPt/txxWTOyo?=
 =?us-ascii?Q?tL1m36VHu1mJa1hIVAHGkik6sqt5UcdOhBC30a1vVlEPSGxNfq8wP3RQU2oq?=
 =?us-ascii?Q?01oTzwyWNWOcSIeMoHUJQ9O8QeYX8RCFjiLxrsuILM+6sepUxZsqbSV9g7QW?=
 =?us-ascii?Q?VwmbnhuY83zF3tcejOenVD9YaGAsbI5dDMxLr9JancWHJwPBAGkc1yBmKmLd?=
 =?us-ascii?Q?DdxsBhXswbcRM24YNmJUhj7z3OdT9Wtjd4VJFT/wi88zeWemVwP/gK5lU0vK?=
 =?us-ascii?Q?Q9uhECVRsu+q28qPCDmRY6whmWbah0OkNE36+T1+iaGj50HdiCkD3uNpWaMQ?=
 =?us-ascii?Q?WHqRJAcDj1JoemRcdEVOUjxlw1kunAS3KDreE+BJNqITiVQiXAzwXXKN+buD?=
 =?us-ascii?Q?gT0sv0MYgb6yM4SMldocVmaS6WKOOX0s1ffJoGAfvVZVYJgroJGDvXlngsDF?=
 =?us-ascii?Q?G2yeERbomC0nT4r9M85WJ2/V?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc258970-147a-4036-c4c5-08d9adbf1a8a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 13:50:54.7585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9xhCtTOSl47Oy/GamyPWI1pa+pVTCZ114rb+2lqiGEQPlNpKddvwysaavTyItMfoYgYBRo8QmvsGR2e96mXQjGYE1Hkj1iKSGPI4edn7pE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5725
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10175 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111220073
X-Proofpoint-GUID: Zf1xbx-XS5ENE_H19ESPYJAQwHo7mxYv
X-Proofpoint-ORIG-GUID: Zf1xbx-XS5ENE_H19ESPYJAQwHo7mxYv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 10:09:26AM -0300, Gaston Gonzalez wrote:
> After removing the BITSET_T typedef in commit d8a364820e01 ("staging:
> vchiq_core: get rid of typedef") the static_assert statement becomes superfluous
> as now we are checking if the size of the u32 type is 4 bytes. Hence, just
> remove the static_assert statement.
> 
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
> ---

You sent the first version after the merge window had just started.
It's too early to be resending stuff.  Leave it for two weeks after the
end of the merge window at least.

regards,
dan carpenter

