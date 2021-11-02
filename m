Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78B0442F1A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 14:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhKBNeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 09:34:31 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26524 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230124AbhKBNe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 09:34:29 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2DKfsB026634;
        Tue, 2 Nov 2021 13:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=nz+oJ5JJlbqlvuFTsLu8o5+6v+wBaDCkQsY753b5fJM=;
 b=BKjsOHoPA9lNmyQizKpANcw4LdGja/26krUatMTwzZMHHmsF8zqJBtowA8DBqtdX8RJ7
 eCL3p3hSh1MokPEkt7bCWLKSXEUHlDqzQMglLTc1Kr9Z7h9Ypwqk554wtfVhkPCqsbus
 JmpIgiCMuJOYI6k+D38lOYTQu/jLYxfqebUXLJVb1wE9xGB+y1+ENU8QFFiVNJj4s5hC
 uJqa07yGJNBpXoWjlP09sv63xkIJxIalJMRj1prn+LwVlKXoc2bYgIf8qgoEnTTUkYj8
 2WwosXTvJX59KhDLBEX0PKKPIIySAoWUi8Z7BQGQ93vnRPQ925y9HSVynEw/RVKw3OAq 4Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c26e8fm8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 13:31:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A2DGHVC106740;
        Tue, 2 Nov 2021 13:31:45 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2045.outbound.protection.outlook.com [104.47.74.45])
        by userp3020.oracle.com with ESMTP id 3c1khtg49g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 13:31:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=du2P4p+k8ermuVrrY+5NuhgDPVFsWzr0RM21kRDCfwTOUgz/8KwP8iQ9xPRYXP92jyz81KXSbJycN/DpUOZoynLFS7gDDb3nZDi3MjYUJkAD/Hjb105Y0RvYoSG3KLAutXeIFyTCHQu88FXaItEAlaQbIwI20sla/ex2asn8LOhp0XpkOF0ndxHT9D3RXBYdX2zpP/TkIFFhF7NWZxm8YypgxOau3KG7KAX2CaXZi5I1xQEEzILzE/+Tlcu7C+cq9TKjIRBU75NRtLjf2LXkU2eVBDpMfDJD3QAc6OXORG7DuXYPMInCdlED2s4PO/sf/6QF0Tzo8fnkVDjip825GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nz+oJ5JJlbqlvuFTsLu8o5+6v+wBaDCkQsY753b5fJM=;
 b=FixP3Yr6Sxct+wdWSSZpRHCpdt2gDXIlNVjI6GvgcmTXrIT5W3crCy0fpr/A5H1F5Y5/W/TRa4vkTUlQcGlFk8pumz+QuqDekAZiIJFI/5VacORv9i9PjkM/q71xelopgJHpwu48ln3qM0rpSvJm2xYNHCZrFREGuCoXb2vnFiGgE99FwcI0mHtNlqGk0fT642d39wasxZSX/doj1Z6uj3gys+d+JoTDyYhqEdKIlOblyAXPWqRSoduXd3ehH0pfwrmEzBmz6DWsusx2wmY1CDdm7MtZh1gvx3A/kVU2vSrWV/aJZ4fsWCopJ8lQAN/yzs8EXoVbjh3El5bPQvXeVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nz+oJ5JJlbqlvuFTsLu8o5+6v+wBaDCkQsY753b5fJM=;
 b=ZAlGI8DhVkyrLwlmUu2dPOhsrCyX5LzznDpYfOlxZ8InJJxpQkANV3a7ARGoW2oO3txi5iEan2EBBVeJ1QeOjzH7L3B/4iCq2DrxVa6cInAwQchhijUAX+0BHsiOcZobruae9UfpOAMbxpoHW7z5DJFyrQ4cbYDDHhlHrFzjttg=
Authentication-Results: kaiser.cx; dkim=none (message not signed)
 header.d=none;kaiser.cx; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1997.namprd10.prod.outlook.com
 (2603:10b6:300:110::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.18; Tue, 2 Nov
 2021 13:31:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 13:31:43 +0000
Date:   Tue, 2 Nov 2021 16:31:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: fix memleak in rtw_wx_set_enc_ext
Message-ID: <20211102133122.GH2794@kadam>
References: <20211019202356.12572-1-martin@kaiser.cx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019202356.12572-1-martin@kaiser.cx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.22) by JNAP275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.18 via Frontend Transport; Tue, 2 Nov 2021 13:31:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acff7c93-79f3-49d4-acb1-08d99e051bc0
X-MS-TrafficTypeDiagnostic: MWHPR10MB1997:
X-Microsoft-Antispam-PRVS: <MWHPR10MB199702DB51E4013C982EE3D98E8B9@MWHPR10MB1997.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uG5bjqfVFKbw2WXFv5kwD327WyD3TRoFM9Pzp5cYk4H3vz9Vc3BTnkg9ahYu6tMD7AMEE3FSGX0T/jNsScY6UQuV1O/8a5ylSFcHnXfHT/1qfmusLN3s2P9h8E/p6NUAHgLREA1WSKUUVDH0esWgZuzbXso9TlJ7p+8xvvvpiSvL0K25kaL5WjUy+FXrUZdh4bUsC9vAS6hfUAoJwxp7Hxm5T8rGF+Gk+ZpPPaYAd+1B0/Dgl4tK12EZ6HsLwCuW4WLBxmS3aEoNayDffHDcZrvGsMw8ZxC5F3q6jKku0fV3/BEp/D6IpNDVTYIBq7an/vrw/rzOY9GheZSZI/kAWU7NQMH6pN/CwZCHqZeFwB55GaVMO83yLaesY5lsd9iV7ywIuBkub8pLg9VcvRPRPcHQQXIcn9Ccx0k5E/JM+40mO3gYfpg2tCHzFUyizgS1b4Yppr8E6Fqpavs+XrgnFgrRxlOmv1I2/Q7detaI6Bhnjm3sILIAzkrHGKkv+d5TwdfZYDfI28G/nzUXtUA9102p/v/tcoRgUS9QxalAutejgqKXL706OJRKgNf8AYISlrAaT7eq2eGIxJs5zQyth38eZxRGmtZapJ7mWgOCgbsrg8dzedBVRJlHRJ7Mbe5MMHinKOe0hRUExvZn7fIBgMYiAOFFb3/3ASG1P9+h57KdRJvCHaqbOyo2YehGKP2+0anXo2Z8P6dtZnrKrD+T7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(4326008)(1076003)(2906002)(38100700002)(55016002)(316002)(54906003)(38350700002)(86362001)(52116002)(9576002)(6496006)(9686003)(5660300002)(33656002)(8936002)(508600001)(83380400001)(26005)(8676002)(33716001)(44832011)(6916009)(956004)(66946007)(66556008)(66476007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?REyIi8fVq0DgT1yQwQCZO96Tk6NIO7xYboR8TXoCERNzd0waR9hf3dM5eLdP?=
 =?us-ascii?Q?5eilKlACVEGoWfHJlq7vlRb3iZl/FChtmn0JFtn3B7lGd0wcJyTNIxyYT/Jj?=
 =?us-ascii?Q?lEz8PzRncdRnb+ZSagncAUc5uZ5170MEF0WA2bRbAWFAfVDDq+XJSu0VaTlC?=
 =?us-ascii?Q?aLe1K5HFyAdtAoXlc0voNLGBujMjVgSuIWEq28bW/xJjHo3Yxb/K6+58AuQo?=
 =?us-ascii?Q?l4J09knqL0o500FwOV9cY/zPkd8TcrUKpdvb2rSX9XYGPur0r14dmZ+OVh/q?=
 =?us-ascii?Q?xeUYdjX+Qwqt2Yie7DWlWoJyRAo72vY1LCpay/hKd/HJTdrcx2tIKBjYz8A8?=
 =?us-ascii?Q?f8TelaO0M43ekRJfeMIG5bDGeY/qALLMYaEKieGl8O4luv/GDKDBXNICJZ/C?=
 =?us-ascii?Q?sDCx2R2WaRcVErQG0QUnd0VU14+XE6rt1AIrmutDCKAU77qCgVFtKzOsLpB2?=
 =?us-ascii?Q?nlwIe71/AO1toEXY1oCNBbXGRNluKvkpjICBNeYKauSDlAHLkDtofFC7y0uA?=
 =?us-ascii?Q?zH3QmizGyEhG8Vhx5dKA7m1VhE9/sDpOWnGa3UzupYbYT6J2UBWyo3x4dokf?=
 =?us-ascii?Q?b/AwSeGRhHiROi6mynjanzHEvKrx7yfZVwkD7AMyn5N61L/gjfbFW6KMod6j?=
 =?us-ascii?Q?jlxH0gKrCIFZbuRsEJER1IkV5NLc23FJTRKu/nU+wUNYbd4qZHgVDkFOsoe8?=
 =?us-ascii?Q?FxaZLIQdpwfEjdXTYYw8ev6HmDHIuzud0D/ep2rTfu4KrGrqRfFT9xC0GEAF?=
 =?us-ascii?Q?V3MA9DtGN92zvYtlumLQFK8mpT9crU0XdJJ+dsHWroTJmFNmomc1Cg1rZW3g?=
 =?us-ascii?Q?Sx6im9wJuJ6693tIJvha/HMYFVSGwXEvdN4Ge17VqZOMccY/4YV/2wrNQstf?=
 =?us-ascii?Q?lTLcduv3E/22gXOQd+oKErLv7pQurZX9i7ICSJqWh0upzgax2X6J9D7W/Mom?=
 =?us-ascii?Q?nKBS3G1lasvPt9vqoVlgmhRAm9On+DF4iRRBU/Vx3lACYdsEiuU1WhL1Yc6r?=
 =?us-ascii?Q?7wnVf1i04f1fiUvscdQbxT8yrFNNFI3TnLI+Ti7BIeMiUVghUEM1hY8CAYGB?=
 =?us-ascii?Q?gxOXFUpGd0eUllV5aYAQlr9g8FvyAjfSwOwyg3rsfSIysxyScl12swzt+RgK?=
 =?us-ascii?Q?KkrVVvZuBEYtGz3sUD833ChTMLzgCfYjU/v591k3YbNI9lXlK1KXta/Ve4/Z?=
 =?us-ascii?Q?O4CMn2iG06E32AB87pkGUzDzjiJn1y3qSdhlnLmVcEZNd6SqrlR6JetjQNtH?=
 =?us-ascii?Q?kiVc0EXOOvW3BXGOWmVFtSv1/D017Al/0uUZ3mkNdxlAICuTUQQ03+VW/En4?=
 =?us-ascii?Q?Eh6zGsrtvxK2l4Fynb/B6BMkvl7O+XgSETzRnp8jlzDWaXad5wRu5N0Z4iCs?=
 =?us-ascii?Q?ipweVB2KoSIPnl+r3gMGTpTGMaNmgfcAq66NrPSsCYMbgRSZKAeCaQ4IZQAE?=
 =?us-ascii?Q?ycXnFzGU0qdzZSQn7liPnewydwOvHyrEYNZj75TgvmejwubDZ8RIH8arv1fr?=
 =?us-ascii?Q?0LGQJmedGiBt5kvsqu83bAFVrW8Dt8Q1zz6mti0+ctKZvx2krSHEX+2jxoSv?=
 =?us-ascii?Q?GFfJhTD1Xeeu12yrBis0Kc/UpAeJmoy8NIQBUELV8vilTDvHj6kL8LyNTOoR?=
 =?us-ascii?Q?B5F+LIMHD3cOqRdwuGlCUYhDsIDG5Bc2YMi3XQpGw1Cpv7RJHAfLodm5wHt9?=
 =?us-ascii?Q?YyBgVA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acff7c93-79f3-49d4-acb1-08d99e051bc0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 13:31:43.3499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCdhaRYYzuaK4VhjYSad9RF8mNrWlgewQwhZizyt679rSC4JeFMWrujjDRLba+OAsNVLe8fX5yDGOL+AzwMZLd/mxD5ipFp/URF5RgCW/Dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1997
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10155 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111020079
X-Proofpoint-GUID: um6SlWuNUoRk_bBceAuj7_mY3jYs6OQX
X-Proofpoint-ORIG-GUID: um6SlWuNUoRk_bBceAuj7_mY3jYs6OQX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 10:23:56PM +0200, Martin Kaiser wrote:
> Free the param struct if the caller sets an unsupported algorithm
> and we return an error.
> 
> Fixes: 2b42bd58b321 ("staging: r8188eu: introduce new os_dep dir for RTL8188eu driver")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 4f0ae821d193..4e51d5a55985 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -1897,7 +1897,7 @@ static int rtw_wx_set_enc_ext(struct net_device *dev,
>  	struct ieee_param *param = NULL;
>  	struct iw_point *pencoding = &wrqu->encoding;
>  	struct iw_encode_ext *pext = (struct iw_encode_ext *)extra;
> -	int ret = 0;
> +	int ret = -1;
>  

This was in the original code, so it's fine to leave it as -1, but in
future patches could you change it to -EINVAL instead.  (Or don't.  I'm
not your boss.  I appretiate all the clean up you have done to this
driver).

regards,
dan carpenter

