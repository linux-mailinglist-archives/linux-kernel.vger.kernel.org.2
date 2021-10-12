Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4209442A1B6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 12:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbhJLKOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 06:14:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:52530 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232699AbhJLKOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 06:14:36 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19C90K22010547;
        Tue, 12 Oct 2021 10:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Go+fxs9bdsCcV/awPks9rxxlyVqAdP96IECVigtY1RQ=;
 b=skry/NnIuEefoyDIdi2iT8+OoWIb2KGhGK9XtdW9aB0XVZlBuYE1w9Wn58ojruX1ZdMg
 ibXjnFYScol0qeqMuly6g2+NUazgVOUH0T1mAHkhZgmxy/qb+51ZRamLH8QCl6qqIDqI
 0S1tk9Ns3DYBYorF4tDr1O0DnyzkFrK/puEVA2OvYFnFMiqic/twE4ZQxYQFNG5hqNZT
 /lQ7CE2b9NaVB5Rxy0Hh+ZiE1UMr8c2qJLlK7TfJ659CZ60GzShFoAC7mxHLC2mPN5f7
 Ar1CYOneCAa4XD3swf1UlArJS9g/D4IUgLY+A0xTA/gTFHu1qURGQRXF4ehq9xWtgEtd 6g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bmq29ppvw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 10:12:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19C9F6eh151805;
        Tue, 12 Oct 2021 09:34:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by userp3020.oracle.com with ESMTP id 3bkyv9u2x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 09:34:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6Nse0W0/qUzKzvMItoUaqROCWUAtU9lTwqrDJskzHVIe+MQ//f1LF1l4KCX+jsTuvtpW314CB7X1/W1m2z0Ir2i0GxqLRC9RXF2ixVOVtobAg003OWNqbXPrDLhTErZYttJpFwz2uXwPzAlTGV0K9uLCG5VSm5MSMR8A5Vy9RDno+LbBL77kfux8/xHpVdvXYJrBQ0npoBYTkE0eNSm8bHlbl1acy/bXWPJKmVEssFnW1o6wwk00Uq4EGF51C3Vkaa+T8EvtQiPDRxkHs6C7QpfBRC3Iw4q/DWlzwElLPZQOZjIYIslNEFuHDtLUpMl96Tq/pqk5p59HDjNV7UPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Go+fxs9bdsCcV/awPks9rxxlyVqAdP96IECVigtY1RQ=;
 b=Cv5xufmabe4nqvTQ0UrJoXU7XqadN4Fa32T8S94YCUM4shtzxsxRczGdFYvWCHBrtVpwy0nRF+9edGz3r7+Q6BibhS3Ebhp8goMSNkJu/SWlHOllKF5Nylv32/FDZBJyk8OrtqW4vhYY/aG1wEg84DyF1T1PQuEW1gN+OVLypJ/7YevhUEY0QNff43d2kFS5vsw+xEQ9U0elbrpTTkFGr6jP9Bf2hTHljUd3BZ1qbUC4mRE5bapPkrz5MRoKYnONsj46ybUhGLyrVaf5iznC7qNdGytnvg8XWnvnRXJLV3JtsgzTb8OCMWlx2SA6h4OjXrmb6OAuSjnntA2sWmhDDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Go+fxs9bdsCcV/awPks9rxxlyVqAdP96IECVigtY1RQ=;
 b=J1pSh/tZli88p0AcdnlG935RfISSg3vVhgdv3hBpJ5/mGw4WBcH3JxpQnTR0oc+bVCiHBSkNgGzBJEPC6ZQ0WIqbNbhhO8QFzrTYkwDbCe7UNbI/jIQdu4b6c9w9uEgQWtnLjlOVHpcRDw+GCSvYsZx8eadC95roq+W7GUvFWfM=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1424.namprd10.prod.outlook.com
 (2603:10b6:300:21::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Tue, 12 Oct
 2021 09:34:06 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 09:34:06 +0000
Date:   Tue, 12 Oct 2021 12:33:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] soc: imx: imx8m-blk-ctrl: off by one in
 imx8m_blk_ctrl_xlate()
Message-ID: <20211012093346.GR2083@kadam>
References: <20211011123638.GB15188@kili>
 <c71c6680e0930fd84f10e4fa13bd59e1f30c2db6.camel@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c71c6680e0930fd84f10e4fa13bd59e1f30c2db6.camel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0067.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0067.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend Transport; Tue, 12 Oct 2021 09:34:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f793f97d-7b69-4ae5-93be-08d98d636f70
X-MS-TrafficTypeDiagnostic: MWHPR10MB1424:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB14247690C7F4ACF4C105715D8EB69@MWHPR10MB1424.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BR5xzm35sJ3ADTv3bsLzy0VafaaG+fpY270vZCQpRcR560SHp5S2orSjGru4E3hfPvAkvEXND7/gg17XpXE1gJzK8A2IWZIeafBqBv7jBXoUrH3x+Ak0ge1RHn2bWb+fvXKxhVr60LVF7lDz/cCki25S//cco1WoI1CBSU7m0Z4iI0XJMWVFysCa8njfB6Q7rdBbI/GJxeNz0fGaYabKkJluNiLeDPkUWQczOotSBODkkugTIwNZDEYLp3oChG9KV3+K7LJk5a/xNZEEwZbtqycdPrwr7uC1Qe/Memv1F9DYBaMMci/nPCaQTo/2WbOWJVebIovxaQgZA+GiewtTqwes7R/syyID23whTNgwjNSSLJl9TIzmFUN3fFYwuvj9kyNGVPsLWAiNJZwm2voyL+HuxsrDxxwAoNvDIV9TK7E9iqKd0Rm6ePRicu7Y8w787BgMRl2yct/a04LUgu1VAKYEy+ftdFn2wqe5AI+/miNDVbFtYWVQEgbvFbBxc5kkd2cQoxPpE6gsW7X04cC6QtaxcdvyrUuRYy7D4m22DsBp4wC6W8NWQdL9qwNyWnx5xIVIejx2xYiKTeoAElQ6gszcaCSozfo0pCVFS0D/OK4ryQbMhk8Z/AtQlB7TCrefNMi7p+ZCGRql3651Wah1wpTlAiqQwOPEqcYjj17qVAAIQw53/5RR++bYhTBVBqUb31qh7ILVqIehgUGVjZoL6QM3mWA+Vwu1EjKjUi5zI3k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(4744005)(4326008)(186003)(8676002)(9576002)(316002)(33716001)(9686003)(26005)(6916009)(54906003)(1076003)(66556008)(7416002)(8936002)(38100700002)(38350700002)(956004)(508600001)(2906002)(55016002)(33656002)(6666004)(6496006)(86362001)(44832011)(52116002)(66946007)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fpvaRUR6Gac3O+8/TtUOljGElCeskr4f2+15J5vSok1KATgaiFy7x8YZEBxG?=
 =?us-ascii?Q?QXqXxn6fn82Hnj1eEJ74JVy1ZALp5pG0TmqDlQsKKHOGlljzFrKgWKMlsdXC?=
 =?us-ascii?Q?PUXCwGdbaJqdxhKTwdb55Xma1GMr+zdJ4AzJNJbRZigLtnvU4COPtCTmUUrw?=
 =?us-ascii?Q?U0y6z1f/D5imDVZCIYUZ7A/tKw9RPMwQeKi3zVjzOpBWyubHWcfAHaxYdAHR?=
 =?us-ascii?Q?dKFKMMMVZskGACeuyTh5sazKyKdBoRPn+fD6EdKLOj1WbLNePqOaAOuilEAc?=
 =?us-ascii?Q?yaN+t1Btyxk3irrzMEaDVROB/1sgIoHOOwNDUCLz2c5Jkf3A319BW4PLOEWh?=
 =?us-ascii?Q?sjiyM6hAHpFVNvfGomqxY+xbfGMVGw6J/FilUowIr1kAeAEl1qbrJobfRPqy?=
 =?us-ascii?Q?dJai6crJAWyke9HSBg2D1IQhmkRHSVIsveSRdyVlgIm8vNhOBbwyFg30t4+n?=
 =?us-ascii?Q?eJI0+4BnjQfSbgNCYRY1tPv7mE1u05/5jA/bWwGWEFkYWa0fXmz0u9Q001k2?=
 =?us-ascii?Q?3trnFZSu7RoFouyPo6GAFA1+BAdyQ1GK8h6nQcj0OgIbwQ1n9a6GuirVsfky?=
 =?us-ascii?Q?y9DBC+YU27GvpoCO19yfGjOoX1ysbtXzowxjoITiLJOVRfGbWb7mBzWilIgU?=
 =?us-ascii?Q?gPw1bLuZU9ub22DXWVRofKgpRZVN36nx8qHgnrVj9ZH4wUTr/pF8cfuzp7FM?=
 =?us-ascii?Q?o/tq8LKz0cSy+sWlEOmGkB9B/HWcTgDvUuRSMpGZZ2K7FrOxUdxs6RUBw0Gd?=
 =?us-ascii?Q?2KHrIuhPmKfgQvRN+5BP8rFpmwUF2MXwydwhwpUA7iB8I2jn6SrcDsxFp5u4?=
 =?us-ascii?Q?dzRpEzsS6ndximbefxm9/nxGXSu8aFONd4iORZ5NnX2lg98Z+9Jhgf5iZ+LC?=
 =?us-ascii?Q?qPpZai437TJiBPwWHoqbJIJb6DRbrjWxrLSdHUJ7NYYn/t1Fl5o2zdp+ggm2?=
 =?us-ascii?Q?6Qp3mHyRVMK1CA66YV9FFsoaB1/IoF64YNFwGqNX6oUHGALzg8r7qxHfIoA2?=
 =?us-ascii?Q?28mqWdRAKmKUoeGih9KbYKllZWF7Fes6rUCgvtP4gg7X6vumiA2XMDcH6jP8?=
 =?us-ascii?Q?42WqoS6y8fUug2SON1+lSBzflHOvmlHxR6mKhHE8Dpm8c+Pz7PUrwczYDPmW?=
 =?us-ascii?Q?+AMZuCGYlAj55GPUhle2hPteHbS3R1MB2J7oJcVth3QiQGd1eV7gigOtpBAI?=
 =?us-ascii?Q?KiSXhgfe+OaB/hp+u+YpFeWo8+nLUEfmOpgtetcSG9v/tEgnA/yxp7dXnHUP?=
 =?us-ascii?Q?jAmGef5W6w7iTQ0TUqZf8YgOLtImsMpQvpemQrTpdPD5RFON9wvFwUHv1uLw?=
 =?us-ascii?Q?o/fBBZO7W73MYlPbp1kAOqGI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f793f97d-7b69-4ae5-93be-08d98d636f70
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 09:34:06.6230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASsVYhXr03DvmwczCPU0wJNblHAb/zGdsYQK2OJRNqxAaz8xGvbXQ8fZfEDwoAm2PlCvKlVtC40jazydNvI/k/VAiRDU/ev9+d4D6qgh6PY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1424
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10134 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=933
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120053
X-Proofpoint-ORIG-GUID: s3eCgU67oX8AfVn4ytXdruhuct_pXUG6
X-Proofpoint-GUID: s3eCgU67oX8AfVn4ytXdruhuct_pXUG6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 10:29:27AM +0200, Lucas Stach wrote:
> Hi Dan,
> 
> Am Montag, dem 11.10.2021 um 15:36 +0300 schrieb Dan Carpenter:
> > The > comparison should be >= to prevent reading one element beyond the
> > end of the array.  The onecell_data->domains[] array is allocated in
> > imx8m_blk_ctrl_probe() and it has "onecell_data->num_domains" elements.
> 
> Thanks for the patch! I guess this was found via smatch? I should
> really make it a habit to use smatch on my submissions...

Yeah, but not a from a published check.  I have a private check for
off by one errors that warns about any > vs >= comparisons that cannot
be proved as correct.

regards,
dan carpenter

