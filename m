Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C995444055
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 12:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhKCLGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 07:06:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:7774 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231993AbhKCLGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 07:06:33 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A39iCMC001851;
        Wed, 3 Nov 2021 11:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=CDRPOiF9ciZcoh8clCm3J0bJbAjK9YwXcDIh9cwBmY8=;
 b=wsArd5XsmWRymbPLEYJFHTlX6xo+35q722+tgVqoIFC1exFn2c+yY510HyOzHS/9jG9H
 FdVovvYGT7aqXdR3aZchnpeeRETvjNYXKBhzfGhgC8jiJfrqiIORm78YHrowai4S6K42
 cJPOadgiF9U6qBgkyRW28VX1yjIOVdqd69DOtND72aEUxlp33ijIqUAh7UvirdOJ2iEi
 e0o8atZvVN7sVll9MhTpxnHM/h/mUnOInpLVhjwcDjKwq2oCo889hrf7eNgXczRzdvHl
 quYnIaUDUEaXwsqgB8CXgygj/L0Y8eoQIckt76kOHHUQ9KQ1UKp8w73wcuvhY9A898CZ mw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c3mt59a6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Nov 2021 11:03:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A3B1u2Z149120;
        Wed, 3 Nov 2021 11:03:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3020.oracle.com with ESMTP id 3c0wv62w15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Nov 2021 11:03:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFPNMIx6Iw/wzHBVSt7uhItU8cRDa/yO5qBhkJRvbKlUfzvthc1f+Yi1ye+qbZawFmuonLD0P3F70rZTBQWvgh40MsBdrHmXm895luUaa6zoMZ70rpXQObju26+qun8PO0DLiKGihRyOr3DB1SplA1q5qflC7GWe9KcN3+YzLmhKNlpVNjBnAZ4VAufLOAyrsvyicuL9eaLzS23cerLpzoR5ZT1okIlzJh/Sx6vxwX7g/yKKg6rKBQNf//xeIpMfFPZUcwT2GbilfTRKtovuD2mIWFCZyG5Mu2O4oJg/ONuK9UXLi39OiqULuI3DrGiTa2KecckxUVAaoUfTvzis+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDRPOiF9ciZcoh8clCm3J0bJbAjK9YwXcDIh9cwBmY8=;
 b=GB7qw1gu4dr4I7IT1d/0BYXDHQrBV/aDonKTWiE2isDyJUoIhLAtv4qkrFeGCCWQqu6PPqbuc+gpyQGHH/k8G4+1zxs77O3u2AK2BNQHq4OFug/a3aGTHJWCaEGeieIdb8o+wmp6qryvyFOqUGISX06EiBuKpfDyJFZYl6cvHHjpbzTTKXsIot5YbrWi5erLJuTIxoWDYY4JoM9x1OKqi5vx9X5fdWH0flAhfq4YetGbHi+rXn6P+DtxzRyqKt6hlm8ucGX4WN6idqOj0vUDbN3BOFySlp51AXOTo85NAaikJxuKdZ45I9G1zzgUTNJd6LnQobnKUtizEM4pSnTA/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDRPOiF9ciZcoh8clCm3J0bJbAjK9YwXcDIh9cwBmY8=;
 b=WDP51v9d+Px9Ix3zUzuX+DWNCK0HJcKuUMw/Z7ou1uKqXYeuXho7dV0VAkcC7MbhXwIuODGZY7kmqIgd0pdryavSjT+fV+7OZlIodCvENujKMdFERUPht4LYx2fCpWTi7QH0HEuKu8vbqjJBgYhnZizW9nsbk3gUDCSVqP0x7JQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1775.namprd10.prod.outlook.com
 (2603:10b6:301:a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.18; Wed, 3 Nov
 2021 11:03:39 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 11:03:39 +0000
Date:   Wed, 3 Nov 2021 14:03:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: fix a gcc warning
Message-ID: <20211103110322.GP2794@kadam>
References: <20211018221231.7837-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018221231.7837-1-straube.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0045.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::33)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.22) by JN2P275CA0045.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Wed, 3 Nov 2021 11:03:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d8effa0-cad9-4619-7c2e-08d99eb9974a
X-MS-TrafficTypeDiagnostic: MWHPR10MB1775:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1775F3AB568CF966B59F9C528E8C9@MWHPR10MB1775.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1H6P9ztdKR155kp7g3peGY1fjU3j1jPhUL0w+FrfTwjWSkAVFtxKqTBsnawNLrt3yfLsOeFHkshv4cnnF6H9JxYTzNTSVBpk/3gpBvUaDrzs7+8YWEIyfji3cTssLTe5VkSLthMm67agx/bESGxPnmc9kl6EX2rEko1cAyrNtmGD+q4joPvM6cyQ0F9z/M6a81lOoWJKV8LUiDYUrGQs4SrkH54RIxkhJAdzEBhbpJobryXdi/CyWKDU+n+0ufCSiPRALqV3zpGx88M5NTpjodnxWNDp8hCEWhkqi8pqMNlC5kI+Wl4a3RVtZ5WNyu3TQGDnjGd8b3iWj8nk8Y2TjVYlvvcmLSV6X261YIASLW1lRhx8x7dpdOi6bNUHMvpbBKnffrh1ocDFtGpROVoiLTMBm9sDzcV3coMpGRYueGV3+mBMOI+sJmGeqqyoecGF/Ctu4VoX+cmmjnPBxh0ncxYFfuYLpv1aelUrCwtVDL050cMmQsXKt/3xE6ub6afBjPxteiZcNNmCL0siFSUhCVweVlASZcVfvbzuufeklUlN6k0JJKQpKLg78F7Qmp+BoJaBTZsgyU9HBCe26qOyCoisPVuJ2T0/ssjlyVFFn8RXkN6B+K9TNOnqFlHHbwUKV/mLsum0byEeRQfB8VZB27T9m9PwBu40DuQDYK4Lfrf6L49g4eMHsSI/ZUuuGJDMIOuuWEFbZpznSVBMQW76jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(9576002)(508600001)(33716001)(6496006)(86362001)(1076003)(33656002)(44832011)(5660300002)(4326008)(6916009)(52116002)(2906002)(26005)(956004)(186003)(8676002)(9686003)(66476007)(6666004)(66946007)(66556008)(316002)(38350700002)(38100700002)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EG35dfbfVxOr9eKdAnj3PjztjrU07aUbXmxSDjAVOO5BCFILttjmNywAhCQ+?=
 =?us-ascii?Q?rSs0GlVqsbckVp2UQkHkn2wB1RoxBedaQ05WwjiLABzOIXQh0jCELjCva72L?=
 =?us-ascii?Q?wNLJ3s47J/9hou+ttXf5nvWj46PTe6bZtBUS1gbDgtTsStgm0cbkWZL9qg9Y?=
 =?us-ascii?Q?ll53RsNag/3PxG5Mv8jkrlNoNmh6gMkqQiJg2LNl0IdJBlzdShZHQwmRZx0i?=
 =?us-ascii?Q?1cBu6Dd0HTsqljg9oWEg5lA9JaewT7Pgp3Hb3gaZt5b2R8afYYtKhbI6ZkWq?=
 =?us-ascii?Q?RGXgHif56+ERmhE0xcrO92YS5m+jPOorRYkF37g2aXhe5jXKlxU3vHfYQQAp?=
 =?us-ascii?Q?AJAIPexij5l2iMjNRWhan9AtaeMDTZvBYePJv8nvGoW2+W9pSqvmcPo04vav?=
 =?us-ascii?Q?lIj7Fxl0KydKMLKwaxoyfDcbtZf+0h9bKQZH1wfwpgCyS8X1o/+pblU5m2ia?=
 =?us-ascii?Q?hQMlt2KUEd7Xu3g98hT5C4meTgzXANA93nF5YCiDYoa0Cv7hBb26/I5r0vtr?=
 =?us-ascii?Q?vbnmmo1D6ych31Mv2+b/podjdGT3Ue5GKalqZxy4rh+i/wgb4zRXlHTNKiXZ?=
 =?us-ascii?Q?W0iMoajgSJQ/Rg/wuN+fdYR1RB6oR7BU2kAEmMsJIp/ZfpdpQX/U9yjlweMf?=
 =?us-ascii?Q?YPpGRGGuNdJ//9fkvCazk/cw9oxCaEfSKK8F5BDZ2Ys1cHEsZTfYHKPE1HYW?=
 =?us-ascii?Q?XBK0SAiRhmY5sB17S4fJa0amXhIbXw9NrTP5PRSCKbYrw+vRdmq69hBmQ0Yr?=
 =?us-ascii?Q?Oa1LOKuuMujhuQ7ffb7NeRtqzXTuScTlFIgdqcSUWsboz8+vxjZcBH9L8JH8?=
 =?us-ascii?Q?D5EbnmmqGoWGWmE+WcmN0UV5dxBVjMxk5YwbsWyV0Vd/rXlU4cUbHEcabhHe?=
 =?us-ascii?Q?KImNzY/lD9nEA/sBmRAqtu3lPnosoOEgz6tSenTmkrJNEBaK0B7tm6+Er+Iq?=
 =?us-ascii?Q?gymF7dcWEWiJAjl5gE1qEXpWHq5IIPsmjus4x9rVinM8+jIPsbJXqZIeeTN4?=
 =?us-ascii?Q?7YvzEapnFA6806obbvMGq4kaELaXhknWYkLGag//ryC/DAvUKsS1z4hMdsLn?=
 =?us-ascii?Q?heoEyILJw2RqwJ0LB+9D9TDkRkiut2sm5Vmx41nJF9eppobUu5fDhEpN1LGX?=
 =?us-ascii?Q?wt27+hBgQ8XHw5PRA3qqkDskf44++fGNtQFP7C6h5OYJTRG3XK06GgAhY0fO?=
 =?us-ascii?Q?tliyn/ZQwdQbZ+w2xooDs361pnUiq6N2JFjH+ncCRIzqBvW5StpVUSdo9BdV?=
 =?us-ascii?Q?uycJ5AIPll/kS5OI7dpwfG422DKMk/8HvSeimE31623CTyH3cyPpRZYCNG5E?=
 =?us-ascii?Q?DuvUVeBBve1BH9Qxulnm7+704xKXB5CKkULWE9h7T593kTE+X7shoIp6Rb56?=
 =?us-ascii?Q?2xcxBvGMVh/XYVUKG4H2i1I3ATtNbuPK87bAeKYpwtY++B+ZNnHW5GRCn7Fg?=
 =?us-ascii?Q?4jzQTpuippyoc+KYcGie52RKEpqqJ1fNTwolCdLzE2QtF0RdB1wg8xJ06M5v?=
 =?us-ascii?Q?dxBTB92rGQyomQGILb+eCq4YUG+8a5ywDZA1XWilOv3QyFbd3gGJQK0eNDZ0?=
 =?us-ascii?Q?mlWLu4sI3zBIQYwkD8ydeL4p635bXfezSw37xcs4UF/wa1HXgSSd7krGmagk?=
 =?us-ascii?Q?+u/gyel9kPHtqrSQCjCLG3AWqYu+Vnp7VNmc/Or4cCYxO/rzMuvFwyGOAsWm?=
 =?us-ascii?Q?0jHrjg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8effa0-cad9-4619-7c2e-08d99eb9974a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 11:03:39.5534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ox29kLwf66hxn3wLCkkeJ3kjo0gNDAcw1WNqSHf9UWkUUrtC3XtuRAGu/PAkafMYoWV7h801wJJBBtCrqqwyr1s++cDXL1TC1DMsGn/2pI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1775
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10156 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111030063
X-Proofpoint-ORIG-GUID: hm0qOsDdHXg1B6b-_4-qkMIo3IQQoqzP
X-Proofpoint-GUID: hm0qOsDdHXg1B6b-_4-qkMIo3IQQoqzP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 12:12:31AM +0200, Michael Straube wrote:
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 51f46696a593..4f0ae821d193 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -1926,7 +1926,7 @@ static int rtw_wx_set_enc_ext(struct net_device *dev,
>  		return -1;
>  	}
>  
> -	strncpy((char *)param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME_LEN);
> +	strlcpy((char *)param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME_LEN);

Greg has already taken this, and it's not a big deal, but generally
avoid using strlcpy().  It should be strscpy().  The difference is that
strlcpy() does strlen(alg_name) so it can be a read overflow if the
alg_name is not NUL terminated.

In this case, we know that alg_name is valid so it's fine.

I think that strlcpy() could all be converted to strscpy() without
breaking anything?  So eventually someone will probably use sed or
coccinelle to do that.

Changing strncpy() to strscpy() is more complicated because maybe people
test afterwards to see if the last character is NUL and also because
some need to be converted to strscpy_pad().

regards,
dan carpenter
