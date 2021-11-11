Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CE444D294
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 08:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhKKHnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 02:43:09 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:25646 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229564AbhKKHnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 02:43:08 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AB5O5Yi010764;
        Thu, 11 Nov 2021 07:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Mw0gu86+f3QknTxIo+j/9CoawGJukcxjdbeDryJ2im4=;
 b=uyDO392XhUZbXhUdC6/9+l21D7xejLz4wB3KY9f8fdKd97c6jcSpGKox8UhOJXurz/Si
 T2DMv+3HEfP6qxNDmhhGDRPmPGHHIFp96zbyOk0/F9jjUtf4SGa1ZAK9MW0KHwmQ7krg
 /5r2DT53/nMIvNjgBOR+wpIL6Vr0DLdeXL8y9rXUVRynAX69nWzW4pnCiVZjMzNcKFJy
 eCoPdzPDlVIEJ4iWl5sR0YnNAWjcFQBuF6s3bgvXf87kjV9+coG5gt8dKFzXoh2yvXA8
 8Rbm/t1427LaGLqBZn3OCSdqDO4Dajv7ihIG7ojJgCDfAimXCVnMowGfezxSfnDDVjvF GA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c7yq7j3sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Nov 2021 07:40:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AB7UMm7015347;
        Thu, 11 Nov 2021 07:40:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by aserp3020.oracle.com with ESMTP id 3c5hh6fgyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Nov 2021 07:40:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kzy9UpqPXp13MBLgKrGD/KW7ugIR+2unGhVLbKo90jEixb+u1FY0tuULSGOwE8pDONyDYGfJauB7Ke3Y3cGlBczSsQdTjeigPvc+98UQ+y8g96C9kYLF4+TB374lpeUL3n2CzWNsTzRaPoTA7JY+tgD/e95jv8nUfsAtNBDPJyRUCIVkgyPiC9rJseJof3wMDMtSwA2fu1WD2sfgcFtwXG9tVkNbsP03nrtbD5olWxtngGaxHUKQUs7gJLlB66tqJAhazCeb2liuHOgLUjJOzMBst2VlgNc+GUL1x+tkxaTDkbdscSbzfLp691BD/TzY43y1u1rlgQXaZ2zXCkExmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mw0gu86+f3QknTxIo+j/9CoawGJukcxjdbeDryJ2im4=;
 b=K1wusxYAfc/FcFcRCQGlrWLRWrZYpEfkwYS8Bns4sSqdqaEDlsyYbVL1Q6usCMRfU8Vc8QBbvjA69/PkXymD945a/iDCCeeaHlIvdwTASbOyHP715QYhSZyZUKsqN1mCmEtuHp4r1pHDCE7k4M4kVw8q/7dJxkfSKtO72g9eSRjKFoHMZl8L+xNOR3B0Ug9+pdiqzkDySVZZkMteznpV6bZhFjBOswWnNwchmM+C8eDNdHkOYwXT6qYZQ2purjf6co2zudU1t1ykZIHBCsh7G2eb5PbNLaO7xx1BiAurchvFMfZ5cWJ6MpYk0+MWJbe1fvW9U7M1zB3oU0U2FJlzEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mw0gu86+f3QknTxIo+j/9CoawGJukcxjdbeDryJ2im4=;
 b=ufujGrFlRxyH4I6eTl/bN55KPMOP2T82vWDYHFn+R2jlaCk8r8SE775MR+wxmWJmunmvn8JHwhg9VuO529cTBf4NU0LvZ/dGaRE+rZVnLPJoskYHNXt4+tsCZvIgUHj0AMGQbV3x0ebS4E/Njjz2DPw9rM0O7y6mjB5D8GwRU3g=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4610.namprd10.prod.outlook.com
 (2603:10b6:303:93::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Thu, 11 Nov
 2021 07:40:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Thu, 11 Nov 2021
 07:40:09 +0000
Date:   Thu, 11 Nov 2021 10:39:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mark Gross <markgross@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Michael Shych <michaelsh@nvidia.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] platform/mellanox: mlxreg-lc: fix error code in
 mlxreg_lc_create_static_devices()
Message-ID: <20211111073949.GO2026@kadam>
References: <20211110074346.GB5176@kili>
 <20211110223147.GA16388@T470>
 <20211111073341.GN2001@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111073341.GN2001@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::10)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Thu, 11 Nov 2021 07:40:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b84fe80a-ca32-4d86-3b81-08d9a4e67c7b
X-MS-TrafficTypeDiagnostic: CO1PR10MB4610:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4610349E32C64C1C446D8C5D8E949@CO1PR10MB4610.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wv2KznVsj44R+0B59Ez9ADL+wv3tXasbZb3GZnAVyifBtwZQbpZZYW33R3ft8tPnXjISI3CgYHeUo4KHJVqV8KsXLoXZrH9LeugWww12p7kQP8WSc6kMa0IB20Q1GhClif1PuGmBGg2CqEWW7x7to9J4HCugRgpMA6RwzU8XRRy3pKeDBNYa1dbJWZhppBXH+Vpx81Ql56Z6pgXUjvk8+0niybrzWKYbqVqgVUsslK8Rh7ocO0l14JXfpCQ86vvCaCyCyGxOzfGJcXvTErmONl2PszBX9z4bj61lFxn+gU6r/pb7jfh1IMveLeXe59HdCXOXdFBiEDbiVRVAjveENz7+BY4NnsrGXrQNB82CDetCmm+N9PR9bpdXKM2W+okSD/yfFYQkhSAukSAhGC4IfcnI8zGYLVHdXAovy4V39TcnWd+7oF/dQQ1iFVZQymnpaQdIg+bsSY/VdfMknT/nxasrvRE5niY4lfRmVAgQbIEVltDwY0cla1aoYXN+GRJFnKKNtSpfBttvKK9v9nXDq6f9sVS2Xgt81xPV0dj5lTNuvDqcLw/4uS4d+GSQDVqcQmlxdc4UEbXj2BP84bL8lah7rxVnSJSlH8qeW0WbAlITZuT8LdhkXq0xZNVs9SNgCzvfwO2oGD0VoGd5a6ESWPo4zAanmUFFXbtNSpwptnFkX9ln29NUsKnH5mIbuNPeBf5ir4mdYSqK4zSH5L9kvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33656002)(44832011)(33716001)(2906002)(5660300002)(316002)(6916009)(54906003)(9576002)(38350700002)(38100700002)(86362001)(6666004)(186003)(9686003)(83380400001)(4326008)(66476007)(8676002)(6496006)(66556008)(52116002)(1076003)(55016002)(66946007)(8936002)(508600001)(956004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3sOGNKYCfyvYwSpHLz+t5j6HXoAkxcECeqH11y8sGG/kRUTpwCZ7KwKakhBN?=
 =?us-ascii?Q?1zqJQRra7db/X2Bf8UkygZEuhO99PlZnqI8JtD7jP3S29Ep6oKplT4VlvtLD?=
 =?us-ascii?Q?bh518sHTh0qgsgn7HuP3DbsDruhoXo+btoWO8kaeTxgL3BXk4FSTDIDcYXKf?=
 =?us-ascii?Q?JU21sLku+1VZHmzNHTNJj61VljKFOuay3O3pzOtxSYrC+n/2Hs6uPejQlYEr?=
 =?us-ascii?Q?NyN7OMDystrl3B2Vphf0xUNrI/rQJkzppLfmVon5apEFtPncb1Zn4j8OB6ns?=
 =?us-ascii?Q?1w6torLHS7FP+bDFJyzdeeJRX49/zXgmS7IsTodymrbdNUPN6H2uKRVQRX75?=
 =?us-ascii?Q?rNEx9B925C2n1aRzEzFCdqCWvEns9EEbbtHuf+94qK0giyLmDewu3PNf2Mqw?=
 =?us-ascii?Q?36ajDf1zZn0V8PvzUBTWWRgSCDrjSO48+mUk1/xAmTzFnw+6ispFmJpkoPj1?=
 =?us-ascii?Q?5ztPXSjBSNnQUpt+P0LgDn4Fl6DpFHn+0l2gYNwpIt8c9/g9m3O3qcWutZH4?=
 =?us-ascii?Q?l3fSPQJ3YfOnzqgLxwBQXooh6dXRoN/m9stkepzN2pKYytVLq3H8GFbvNJ8N?=
 =?us-ascii?Q?IzYy5LjSQR48dabL2wtmxUfZWOS3SY7z+Bac01L3vPSMjWpcms9d6cMM6Xhz?=
 =?us-ascii?Q?bhe/x3R72zIx1nLIjZVRFufNTc37U7rA1fxqtDsXq40z5Ie/q90Y7RsPxDj2?=
 =?us-ascii?Q?itYtIL3Vxa+OlzAB4Nd/KYkiWZrOhgKRtN6nbM7oWKwaa1J1Wo9m//KNc2vc?=
 =?us-ascii?Q?XdEBzVsYIVI/th53mMhkOIjJuA7mKxuhEiyZv6MqNniTvJjzgwj52pnpfvUU?=
 =?us-ascii?Q?RqIz2ieZkprxvwF18saXmDFHSsc+6kNytOO0mcsDDU3eV1VaKpTAOYk98H2z?=
 =?us-ascii?Q?xgk6ugCaMrAm/rDUHLQXVkZLMUDC6tyGPFpqoeQODntiz2AWxPfdrHRJGeH3?=
 =?us-ascii?Q?17cDWjG5303F1mFZX9Bn0FTZQIhxZnFVV2r0/jw1Zp3mUkECDLM2ADLYF4Ew?=
 =?us-ascii?Q?iq4Qg038PXKIBZlyx83ABfiPbJ7ZoQpaFF7Q5ZMhPI5uJhtmbxvr/H/DgAS1?=
 =?us-ascii?Q?Jhp6siqn63jSQ+1hn5pqGvJa6qzcZ3c0HOunRYIjyG4RMCkFovqktDb1leJ7?=
 =?us-ascii?Q?L0KIeYVv9ZefT1OjPk+x1r9r0RIZ0pQF4rxCelfzbW2OoTTGHAdcW5NTbIuZ?=
 =?us-ascii?Q?9558NyFZhDGu/cw1nWGWG6B7gOcgfAN/tJRW8DLUJNJ8SGQN2E5qwJKbvfsM?=
 =?us-ascii?Q?SConjTGqcrgjRFUBZyQvMZSnu01jtTBWE36YMHU5ufnC5Ss3qbKPbvnWt041?=
 =?us-ascii?Q?PjbrzOE9lRgH6w9hA9zbvZlpNWf0SVuOJIYLspJYJl+fAaWUKtgSZ+Lzwizt?=
 =?us-ascii?Q?16knWMb+WA9K4bQhM6/qzAt7u+5uMcjI+N+aRxlifvTSx0F4yFfgzvIn8Son?=
 =?us-ascii?Q?VsYkx8sQA+M5IJp4rHWLNA2h535sRwfCyOsmZcyUcsuO8erbx3NOC5EIl5Gx?=
 =?us-ascii?Q?mae2oBr3N5C0bCfSTcAZSQcshgvK5WnObvFhrvVPmMedTCJC3VTSTokkGPep?=
 =?us-ascii?Q?UYeyTKZ5YrwihLF8gAR6+Tf2Q7BWw9FYc/VwRqVKQW5QtHAi5HL8gXfQGEHQ?=
 =?us-ascii?Q?1/rjLqIUeuw3sGeJdacdyPl4MXjdIwlGZ6A/Hh9UUe9JMJBD+mjTCvZsuh5+?=
 =?us-ascii?Q?uzdCwzwcdsR1/YI+Udm5dic6Iu4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b84fe80a-ca32-4d86-3b81-08d9a4e67c7b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 07:40:09.0628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IulZMYOh5Xp607Tutw2pKfQaOsTRGUqdmaFTmlnqL2QSBRbECbVFLOejR4c7kxUUVgFZHnxiFpBY0R3p6VWCQjRo6R9SP1Vpqoj0ttFt3WU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4610
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10164 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111110044
X-Proofpoint-GUID: WfiayfbySW9SXGDLpuenMm1vzqk6d2mj
X-Proofpoint-ORIG-GUID: WfiayfbySW9SXGDLpuenMm1vzqk6d2mj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 10:33:41AM +0300, Dan Carpenter wrote:
> On Wed, Nov 10, 2021 at 02:31:47PM -0800, Mark Gross wrote:
> > On Wed, Nov 10, 2021 at 10:43:46AM +0300, Dan Carpenter wrote:
> > > This code should be using PTR_ERR() instead of IS_ERR().  And because
> > > it's using the wrong "dev->client" pointer, the IS_ERR() check will be
> > > false, meaning the function returns success.
> > > 
> > > Fixes: 62f9529b8d5c ("platform/mellanox: mlxreg-lc: Add initial support for Nvidia line card devices")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > ---
> > >  drivers/platform/mellanox/mlxreg-lc.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/platform/mellanox/mlxreg-lc.c b/drivers/platform/mellanox/mlxreg-lc.c
> > > index 0b7f58feb701..c897a2f15840 100644
> > > --- a/drivers/platform/mellanox/mlxreg-lc.c
> > > +++ b/drivers/platform/mellanox/mlxreg-lc.c
> > > @@ -413,7 +413,7 @@ mlxreg_lc_create_static_devices(struct mlxreg_lc *mlxreg_lc, struct mlxreg_hotpl
> > >  				int size)
> > >  {
> > >  	struct mlxreg_hotplug_device *dev = devs;
> > > -	int i;
> > > +	int i, ret;
> > >  
> > >  	/* Create static I2C device feeding by auxiliary or main power. */
> > >  	for (i = 0; i < size; i++, dev++) {
> > > @@ -423,6 +423,7 @@ mlxreg_lc_create_static_devices(struct mlxreg_lc *mlxreg_lc, struct mlxreg_hotpl
> > >  				dev->brdinfo->type, dev->nr, dev->brdinfo->addr);
> > >  
> > >  			dev->adapter = NULL;
> > > +			ret = PTR_ERR(dev->client);
> > ret is only set on this error path.
> > can we get to the return without setting ret?
> > 
> 
> No.
> 
> :P
> 
> There two ways to read that question is if the patch introduces an
> uninitialized variable bug and I would be super embarrassed if I did
> something like that with all the QC scripts that I have to prevent it.
> The other way to read that question is if it's possible to not introduce
> the "ret" variable but instead figure it out at the end.  But the error
> code needs to be preserved at this point because we change change the
> "dev" pointer and set "dev->adapter" to NULL.
                         ^^^^^^^^^^^^
I meant "dev->client" not "dev->adapter".

regards,
dan carpenter
