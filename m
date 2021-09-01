Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E7D3FD74C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 11:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhIAJ6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 05:58:52 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6298 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229662AbhIAJ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 05:58:51 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1819imPn026419;
        Wed, 1 Sep 2021 09:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=hcAp5DsaKp3pEDFNJ5Ybq/YcO6tojZ8DFDcniS3mtP8=;
 b=cN+tvcdi70tJ8IdTjsMfWOMwqfLQxG9nJg21bhtTDMhijjXKn+bDF+45M5jfWJXYuyMQ
 77wCdI6s1i2fUe/gCCGhDvV+EQozeeUQ1WF08uwJ2ljCBCW9PcJVmhEW/C8R/Uc8bu1B
 7WcDagUfAdUcbiDgvcoAg1ObBj9LPP5ZqVpI60urTUwMwHpH33qpxhLWEl9ocmEBIpg1
 9XgZ/rufrUSXkkdWO/l3QcWIayMvnJbt50Y/2zgE5dQosywJZTIYDLeow+snXVa27jdT
 rYAe+mwv00EnDhEPGAhCkWZzZJ7JINlDQlDAYDzc5Ro/tKFHW2TD1ILMW7kh1ygKX5t+ yA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=hcAp5DsaKp3pEDFNJ5Ybq/YcO6tojZ8DFDcniS3mtP8=;
 b=AQRsvu1CWsAUjE3i6NF9jPXGDxgxmQznVtWso8OfjEqa+YkF+NHIyYp9YBLS+0Oxf9XL
 aiRBHHJbjPtwYPNRKEAJ7FcIvYh1/j70JkrTGnCG0J28xZ1+5uJMkGuEFWifojUkkPyz
 U4kZoc/vCHs1SeQ9c5qluVmmu9113wpJkzktr8K3e/iGkG0WEcvrEIhAdFu/kWDhfq12
 BEhbFh1KiGp7LD8o0QjuNlQ13xc439XFxVbMZpL+hDIGZxnEwX/Eua5IOHtnGwdWlGAx
 rtNhE+j4RF2mjdicO4Xmp9utJK2yDc9j1Ncoqls7EVa/pZjo+FRqH6cUWrsydBt6sx1P 4g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3asf66m1st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 09:57:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1819nrga003022;
        Wed, 1 Sep 2021 09:57:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by userp3020.oracle.com with ESMTP id 3aqxwva7bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 09:57:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V90NuARQmRfar08+CLiDX3zdhwURpFOjYDf1H96UNGxWDRhgIlh/wvaE5XWEfcAlqm9JHqjmTXYVHwF1T+nh/LyhrWAd6jleWzEp1Rs8RE57Vo/XT2ERjPfmk4fhjpqBZUcrI9qHjvENOXFc5h9f1Qtq+a4BGQhhe04cHLA4QKCReiaKeuFivi6hid6QYYXxHehVtTqTMiS7dRQx3ov2S7jJ1gr0b4rwl46sNxyWBtyu8a+B/DNYEnLaY0FV0EfQSs9gbrJcBClMr2o5r4JvBZkqJSh4l5JL6DpFHaY3wCTCRSLWtUxtLtmWyOB55Ksi52ey4vCkRCwPai6NIY6TQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcAp5DsaKp3pEDFNJ5Ybq/YcO6tojZ8DFDcniS3mtP8=;
 b=hJNycVeA+khxVWizT7XlSk6ngbQp8AkVBD4elDOSovhc9Lh1OgRjmF/AtGKqdeWyG9E2UEUHxjASAJtAqqrqtQwVUo5UA11WVAZ89I+1kHPoavixC9SrKWpIoOlxcBjRNLFzm1f3PGJ895ISiDZTPHHFRPkUH2NczO4MJ8BUBB2Pu0+uT/lWTrlYSAzM4rEOEVaqy2AvQ2xMUC86xi46ZFsw0IibQ4n4x8bdpLzltsuL2AS+UtrZ5LUmg6hiauO3lZd7dD8Msorrt9dH+UVXgk/dKApwZ/c26pTqS4DgCU/+Re+kXQhTG6qEELb1EH2tM04OVFrqBYadDuT7uxDAXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcAp5DsaKp3pEDFNJ5Ybq/YcO6tojZ8DFDcniS3mtP8=;
 b=i1QAz7D38opfmu37siufB9dBsj3fSPcqKsGXHE6uJwfRsUNz/FpwHdtYwKj+MThT1v8Je7ORXqcE2/Wyvkx6MBXCFGggl3QjvSS7GzafExMUhR07lIRURW4Mpzx3erljrZMKYIpm8HB7D6lu9VIFDuKzod0axlUOzVLxhKu3+vU=
Authentication-Results: wanadoo.fr; dkim=none (message not signed)
 header.d=none;wanadoo.fr; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1999.namprd10.prod.outlook.com
 (2603:10b6:300:10a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Wed, 1 Sep
 2021 09:57:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 09:57:42 +0000
Date:   Wed, 1 Sep 2021 12:57:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, lee.jones@linaro.org,
        Julia.Lawall@inria.fr, gregory.clement@bootlin.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] clk: mvebu: ap-cpu-clk: Fix a memory leak in error
 handling paths
Message-ID: <20210901095722.GA2151@kadam>
References: <545df946044fc1fc05a4217cdf0054be7a79e49e.1619161112.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <545df946044fc1fc05a4217cdf0054be7a79e49e.1619161112.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::6)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21 via Frontend Transport; Wed, 1 Sep 2021 09:57:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 899d24a1-a726-42b4-2def-08d96d2ef051
X-MS-TrafficTypeDiagnostic: MWHPR10MB1999:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB19994B8771255700ECA5C0478ECD9@MWHPR10MB1999.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wGLIA+IDgCQHXj6yO0eGYF0cxcNO/Vei5/JTK61VngJJmmGc5FPJ4iF8xFMS+o0qkp7W1Y6sF4SKuXpgFoNkieFiUcpTHSnd4zOwyA3gDvL/UXKCyKvxYLczhcCHuZB6FJsKszYSFXkQgp9mAl+dCLAZ8sRImA7wxNzTZrgpdOjAHAyhKCvxUumJKz9GaIDR4rbHoCOdMEWkWsn8Okw6yeP47mQFFN9treEjO0Lrz3BxKFmJvSr9eVzOGYgVLcSNIBiE0UdR1x5fgBTAWiF48Oab/LyBUnlFpaq5WKO/pChkIPTQMWHEfw6kJmhsErtxurYvHMcCfHpH2TnYGFK4bkt+9vrDccFRdSrnV96OfFzH57gxfbnHJ/MdH617dr7JRsPv1lV9EC336+P1PtGoL4/tyQ6U5spHMaqaaqvKRv2fX9kWoQm6E9pI/HmMFDH1OHcEyrUk2EcID0Yv1n90SOsHmpp3YJSChfB2N7PE1GD76zDsF3TRnU7ipx5g4t05LN65Ux9Dq8LHRtdYfILlYBXK3umJvwtlDwvWVBgMsggDf1pH+sJt81gIqDCQpEQ8C3rCzrbgnT676BwU+ddbV8NQnTY7CaUUpCPsrygzyR1whwdH4n3F+3AcyW0btz09kasl5grtlt2vJplDTeoFDKoyWd6xTwDcLLGunAfDEgK1nqjdydR5pGCszgsliqZC2+Z6qAOQr5cXpnmLLlVY3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(346002)(39860400002)(136003)(83380400001)(66476007)(66556008)(6916009)(5660300002)(1076003)(8936002)(55016002)(8676002)(52116002)(316002)(2906002)(9686003)(478600001)(6666004)(4744005)(956004)(9576002)(186003)(86362001)(33656002)(6496006)(38100700002)(38350700002)(26005)(33716001)(4326008)(44832011)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pwg7NsPc/gTolOM797COFSH35hl+mp6i5cMVLoMcgddcZRl9djBAV76prwcb?=
 =?us-ascii?Q?x0Wd/ocHKTKDYJ78GtTs+uvYpS30vSmCssmK/7my0J5SUzkonV+CmkJuSpD7?=
 =?us-ascii?Q?PmTIqQmmORsKgfysVeLsr047JDNnS7SXXg7SwMWtm9AE9KrlCzxACk5zB32U?=
 =?us-ascii?Q?8iMXfe4E2htx81C07U7UQk0CzRlcSUvfELwGeoJ/0ceL81PNICkO7/FRx8bI?=
 =?us-ascii?Q?FkjDJ0UP+lKtqspSu4R5UVbZ5MPHesXOmum4gNoNIkVWt3jiZNuzcCAgy62e?=
 =?us-ascii?Q?s9optv7w2vzoPYbgo6cDD5vAo1iE+h/YLoQhH6mF+4+XjkOEjFdZrgAh2IIW?=
 =?us-ascii?Q?qqUiTo2MP2w/BhkqH6SuujIl0evsUwpDJygRatolXFl5x/EfMTekUtQlVWN9?=
 =?us-ascii?Q?8IfHGt7iDrrNyWxR5BIDHOR/FwTf3sRn8GSq/0Z9ZUNvdWuT6I8flu/a9raC?=
 =?us-ascii?Q?IcHucS32CE3XI5lGmpGi+NkALQx+Z3SLnCra4XkTP4VSToXffaYDODxnkEW7?=
 =?us-ascii?Q?7nwxwjYFjphzD1YLnPhUIQKDkDbD1O9+tXbH/s9CJBea9xs9ZUa335ftB/8z?=
 =?us-ascii?Q?Nh2aq2fehBh1MC9TjQEePagE1WJkeysiFmZD49h+E/Sa4nMg0ByRL3j9bzE3?=
 =?us-ascii?Q?x2rVq0oBQI2OKIDEKc6/2IyIA71z1m9dIIPkJlPeUkES0VFAjFvpyAWSz113?=
 =?us-ascii?Q?tks92c6tVx0nXHzLiqu++jOX8gZKTeSwOdSRNqnCZNtMMF32djAmlIszRH+v?=
 =?us-ascii?Q?pkLz9xxf3hc8+ihIFzrQu9uArhJCMYZpZoWuBK72EKELTyr5flhylLQ494iH?=
 =?us-ascii?Q?XVuu9tFS0FeecLgNOVONmD+D139sRBPC6LgR8NB2vNuaA2qaetkZJdgHo9K6?=
 =?us-ascii?Q?GoIlTxug7Wuqi142lsbMzCphcwBVoLFsOHuuNxv2Q7+A345AvPw5wcgeqFKs?=
 =?us-ascii?Q?8CHeZFxjtTRfT7Bh8ci59194h7gUtlLProopgaoy/NAOSd3jIr7kdHFot7zu?=
 =?us-ascii?Q?Sz9iwbXn1IUOhRkLOcKYbY7sNX2nGV9dRtPiefYBzQ56a/9zMsKGOlO9Hv4p?=
 =?us-ascii?Q?z4vtbj52mb98lQPVmVuLaPgSJcCpYSsi70ytat5XSlAd47ePx71cX4dBVaFp?=
 =?us-ascii?Q?0U2NX+ty3lTRGodKu23yxg4bVHQFtQv2lkC4js75vCNzm/AWFCEMz2clzhWB?=
 =?us-ascii?Q?KP/uzQoMMBnKIpgA1Ghc0LdQK1xN+EqkduNowGnT6DmtjPhpL37pLDJAsWMO?=
 =?us-ascii?Q?Q8y0OA1UkKzXFCbDgk6NWURCORNIR4Vh6mC/5Tx9J0Whev82J9vfQ77ZecTN?=
 =?us-ascii?Q?RSy6NwxmeTWGMYmYavxws9l4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899d24a1-a726-42b4-2def-08d96d2ef051
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 09:57:42.5356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WULn5OepioDBRqMzTePQkh10xKoiGW8HkeCDu5WALNbT0J5eN1wAlZZzVME0wJw7U0L0xpBQ80XXRcVAuxbZjOeLmse0Q35qfsEWc8DaUrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1999
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2109010057
X-Proofpoint-GUID: kup4EaSeFjTBuzo9wOPMp0OzbVjvtv6P
X-Proofpoint-ORIG-GUID: kup4EaSeFjTBuzo9wOPMp0OzbVjvtv6P
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 09:02:26AM +0200, Christophe JAILLET wrote:
> If we exit the for_each_of_cpu_node loop early, the reference on the
> current node must be decremented, otherwise there is a leak.
> 
> Fixes: f756e362d938 ("clk: mvebu: add CPU clock driver for Armada 7K/8K")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

