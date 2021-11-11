Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F2244D28B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 08:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhKKHhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 02:37:00 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:59922 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230300AbhKKHg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 02:36:58 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AB7KKZG026260;
        Thu, 11 Nov 2021 07:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=XQ6aSig7u30E10wUdsbRnKOuMxVFvB/tOnHXovZTlbo=;
 b=1Lh5a0yeuynhyCThH1MUNbwM4cY2JpmHHXnjKKcf7xgK93xQ52iYtN87unv2hLb59fdD
 NdYmwNGtPxB8BrujoMakfLQ5VSnQZBgKGY2+UJfwD0p9c1eY76z9e2SrnES8rWVI9yhZ
 UqmfSto5j2uPYjlkHd3TZ/e1WISR/yJsNCV4gdIiMVhmUHd1dMz6un72BZ8A6RPqB9Iu
 gmZZV0GwkXllXac8yPVvUoFwR9G8nhrqaY7Oscvf+1VknpzPMdMC7VYeg5B8bC2aeqyR
 mPyi9xpwOlSEb8lIH+Abl7g/o73NeyNbQvanRCA+3u+6dCwSHhsrTgf/mQnJiS7ZONX0 OA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c85nsgyum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Nov 2021 07:34:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AB7VZXT073376;
        Thu, 11 Nov 2021 07:34:04 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2175.outbound.protection.outlook.com [104.47.73.175])
        by userp3030.oracle.com with ESMTP id 3c842df21r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Nov 2021 07:34:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STeN2Ha/yfmNr/vm7Kxm/upmlW27kSAD7/wDJOI1rzqxq69iykrmbwXW/1XlmBHfJCIwJFhn6lNXKyIKRPS38kbE1sQ0iWHwhuDzXkPN79iCP7cNEZ/T/kuT/70H9E02BrkXV5Ris55CLf9pb3ra0LEQr7M7y12nwXl4cDgOXBgyBUPpKoHzCQSiHWiJ9+RCp5JB6hDEdiYGFFDlqNju3V1JLOK3+jpTs1DeW+mk8O3atN6XC3LDBJle5+KLTuTDtQs6CtNikQitVzbFhUDWY3knhTG7JxwDh0IywG4lAaUxz5ugnjdEyNPWbM4zgmdwGto5gWaqZra9UUsQBb7yEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQ6aSig7u30E10wUdsbRnKOuMxVFvB/tOnHXovZTlbo=;
 b=bncMecq6cOS8hLJ06J0IWZv9Na+486gCUs/Iv1OvQT2CJJNKb+AuXwbv/lR1sIt06f3QjJX61ZfkQZ18TKmS6xp/vJ1sRCWPw1l3f6Vmiyh7ZaFR71Q53cxmRXqvSCcDXeMxThNZdWQSDnsVTJpPBRf+6Tr70jMmZ6iSxLPUY9Qb3FNXYnrUlH26kNbW4iLAc6GNg0jLpr8O1wxfHy+Vj1Dbqv4/wjhQO+yjCeMTjuZLSSDSO5LHjGp0z2uTy/AHdPjgrnqDB2pAfYNXLf8itvJ802jHLQqzsTw8xWZPjEeWqAXEspZamyQJbgxNDexvmkiYoJ3rmnMCjW7V6d9HJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQ6aSig7u30E10wUdsbRnKOuMxVFvB/tOnHXovZTlbo=;
 b=nu0Q+zu0zaVnBprDs/spXwKM6xEnpm+6lTnH98TwlcIWEd3q2+pKwHfFH9eBaDsWd8iGFG/vP8LWS4jM751WQvdzGqbGfEEnmwk7K8m+du3pCQw+4CJqidhmfrGwzNoOVfy146CNODDxNlxpKNQVHCmjuCeUCHzPjWsnunjpfLE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 11 Nov
 2021 07:34:02 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Thu, 11 Nov 2021
 07:34:02 +0000
Date:   Thu, 11 Nov 2021 10:33:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mark Gross <markgross@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Michael Shych <michaelsh@nvidia.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] platform/mellanox: mlxreg-lc: fix error code in
 mlxreg_lc_create_static_devices()
Message-ID: <20211111073341.GN2001@kadam>
References: <20211110074346.GB5176@kili>
 <20211110223147.GA16388@T470>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110223147.GA16388@T470>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0029.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0029.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Thu, 11 Nov 2021 07:33:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba91375c-ec8e-4dba-e393-08d9a4e5a1b6
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:
X-Microsoft-Antispam-PRVS: <CO6PR10MB5409FD1A162921F491AAD8C88E949@CO6PR10MB5409.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bVVUdxSZaTDEEbgyvyroAB20cOZ87JoJOe6Jl1ww7f/r4lFO1U3/b6nZCLdN7vTt1Q/q6t+PJwL56NQcWtvfqWEDAoVk4rgut87Sq2jX7McZ58MeT7U4zpj23arOOCReVfcCRzMRcKyEBMxM82hHNUDASJPItxtc/gjPxUpVIfG8dHvvv41rTz7PRECfctskAafBSP+S5mt1XNtRQ6BkBJ1LCM+1zYZtganuM0fAw1Lh6GG52/A9t3VCsbr8alJHh/5jekZ8YhX1HfN6E9cfdPLazs8hRr8BENbcwkyLxmMzyOx1QZ2I3+E7K9omeQaSE6oYu0JGfdLXwKGoTaxs4sAm7944/x23qlnzciLhUMdg/Mpd3EOdOB0S7GVnTkO5FT1Faxjc1BV7XK+mfJ0D0AaiA9UjDyekLypkLP5Et1qQD+5TdB3KI1PAVBIc66A7e27z5bcQDhjDXRgtaqAHtjUjMHELG97C0XS2pAizQajy2wb2KuIIEmdMTCxTPnl7IQuV/0DjZqkiUWRtAGptV0aDGHW+nT5thll9zByy6Vnwmu+FY5z1UvzoB1ulOVefU9mcbs0XL4FI48AJ/7jmD4M8P5wpsS02gAIi2G5l7a7kP/zZoRozTFOKXUxcQ1bsbNKuwqsdpj1lT775hiGSiJPbh6HrCvJEqqWk0zU3lxacWoWzFwivRuaO8ecrY0Lr0InaPhn8CxxDGYGQ2Eg+HQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(4326008)(86362001)(9576002)(6666004)(316002)(38350700002)(8936002)(38100700002)(55016002)(2906002)(6496006)(186003)(26005)(8676002)(9686003)(5660300002)(6916009)(52116002)(54906003)(956004)(508600001)(83380400001)(33716001)(66556008)(44832011)(66946007)(66476007)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y2IAkdCxRVCmPpplBlMLLlDfdLMasXW7QQ5DiBZG0bs0yRb3x2tVLI60OF2i?=
 =?us-ascii?Q?ihvzgG/KsEJRGhd+2GGjVTsftH6zKec1eKLs1E8AHOCGbNBCU+jdk6lxqhPu?=
 =?us-ascii?Q?vr8W/zTplKyHz/La7t1ouUgXh3KX0LZfmVF0iCqBf/qpht8K4OKPHTA7/k55?=
 =?us-ascii?Q?oXyAuB0cCWcvbaE/Z4fxC3IJq+qVmp1Q5uqbqBVKCbcbEQv9XcdabiK18Glf?=
 =?us-ascii?Q?AslzDAsQdFscE5VDOOsIWOzaDanmdufzZoC9zdVJ30Rhj1d8KKq9xndOHVY+?=
 =?us-ascii?Q?PJjmmq+2wqJcHWLygj/Pj2nFautxf0GMq1IfJKH2gNsR2pEc39lZu8dyWQ0I?=
 =?us-ascii?Q?0LFZE6CscjP20bvsEqmbyl4mxLWzw2ETxcmqBw13GJY1KZYhCY5m/L4h0/De?=
 =?us-ascii?Q?6hQvYtOLn/TTYuhb2ixYh8F1AbppGG6TPzG3kXgwZaKkh9qvTEwIGCSnoFaD?=
 =?us-ascii?Q?OLghfePg5GpoZbcvl+Wwr3Z8GKbOvRohzwkpZGqvBlWvZzVvfewtBkhX5bYd?=
 =?us-ascii?Q?lujX9lAU9Snh6k7GmcaJIki6966ScuEf1i0GTOMlsCrKKIzRPxQ7kEj7Msn4?=
 =?us-ascii?Q?tL8DIQiYhx1oExzuYCMFl5z9+GRwjGr/a60wSa95K52qXMPNBB8++KIcPMig?=
 =?us-ascii?Q?+SQ5LXWUTnVmsowS39bL0NxDSwW6mCw3UbKaTeOJDM1TYLgkHHEeYWhUnR14?=
 =?us-ascii?Q?Eda9rHobP8V4ZVSCbwyjXfTr68ILDh3hzZxUQrFfWhbstBsIVN7xF/8wIJyV?=
 =?us-ascii?Q?jLyhaaBRX/2oGsuzhq7VGzVasQmgZOwdFZ1EsLv7QlS2eHMxKDEGYMlmA9E6?=
 =?us-ascii?Q?xOCrvG0lrpgoX15XEWenzsVK3JI2LJ1cdFTQLQ9IcAhKksCUka8Hzq5x4zIl?=
 =?us-ascii?Q?P53fgxHPx/Zyt4sKfibbxZbKcf+hsgTdL44oU3xMz5uvSZgl/ZD1aQaf7gMK?=
 =?us-ascii?Q?0ffANTcbcvee3WEJttsbMSaVJWNTGGQZqGa0n6OeLQ9bj9tK9ZE67bfHbo6S?=
 =?us-ascii?Q?OJDpebzZqDepQrizPjYCLoyD/7E5XimnYe3aIppk1saQodB+MIO3OUCjvLnS?=
 =?us-ascii?Q?vxtSLdZOuQBqxwDCj0XNeE0T4t5sHZqIJDLJ/Tl+ZddDjTO+Q80UZtu5my+K?=
 =?us-ascii?Q?Q0BtqI3+9kEetzVo9Jik2SMzjAC4Z138D2YAQLZHMes3GHLnhPG+S/FKE2N0?=
 =?us-ascii?Q?aF3TMtdxnK2XiPzjFxcYHRSFhgdlgb0fMes8EeGeKbYaWyXipYS6xyGIS+5w?=
 =?us-ascii?Q?ycAeqY7wADrJa1e+WRbUtTyIQFkZHV0MZSqxi+LTpTaRcWsIzGiVkG6JaqRv?=
 =?us-ascii?Q?nroQwR8SbjZkjzCYWOHGZ4NFre4dyvKujNvUBREMyGJ1PjuXahzpQNkXeoQJ?=
 =?us-ascii?Q?+UUSz4w53tqwSt7MIh15BUM+rDrVWmA9BlY2JySdcrw26Ras6fUS+QxEbuE+?=
 =?us-ascii?Q?G0hA4WokFTQcV4vVm+eXpXDrNpdnxn5/A6LYu/ZqP5/7CtJS6+tv5zK1HvSw?=
 =?us-ascii?Q?nsspymzHFY+/gIvD8KtuZrvSAZTN51h5x+hBjOffFtBbVareQTHolWtQm1ni?=
 =?us-ascii?Q?A7KqY3Qp91dVXz706DcQQ5/kpXiofuCBnDN2ZLsS7z9oUVmVO7m8dSWL3Kra?=
 =?us-ascii?Q?gHRE9eYb8C8oaqXMDyTTI0gjZDMoJ7gpKQSnoPgq4RMfPQ+5unpaj6qaD3Bu?=
 =?us-ascii?Q?j7f971vN0pWt8cLhN1jKBXSRI30=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba91375c-ec8e-4dba-e393-08d9a4e5a1b6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 07:34:02.2216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0jlg/FLwAXjpi9aBE0G6dfAsEB1AFWJvxpN3Do9Vo5eZQN4TQx1LPW3IzD4gKrC9JSU1BdtuSps2aUVt9aC7X3WeJDi8LS0v4qmcb6R56M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5409
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10164 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111110044
X-Proofpoint-GUID: 1dk1ENzSvT1G6_dU0V2phdgLvhfVMGPY
X-Proofpoint-ORIG-GUID: 1dk1ENzSvT1G6_dU0V2phdgLvhfVMGPY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 02:31:47PM -0800, Mark Gross wrote:
> On Wed, Nov 10, 2021 at 10:43:46AM +0300, Dan Carpenter wrote:
> > This code should be using PTR_ERR() instead of IS_ERR().  And because
> > it's using the wrong "dev->client" pointer, the IS_ERR() check will be
> > false, meaning the function returns success.
> > 
> > Fixes: 62f9529b8d5c ("platform/mellanox: mlxreg-lc: Add initial support for Nvidia line card devices")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/platform/mellanox/mlxreg-lc.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/platform/mellanox/mlxreg-lc.c b/drivers/platform/mellanox/mlxreg-lc.c
> > index 0b7f58feb701..c897a2f15840 100644
> > --- a/drivers/platform/mellanox/mlxreg-lc.c
> > +++ b/drivers/platform/mellanox/mlxreg-lc.c
> > @@ -413,7 +413,7 @@ mlxreg_lc_create_static_devices(struct mlxreg_lc *mlxreg_lc, struct mlxreg_hotpl
> >  				int size)
> >  {
> >  	struct mlxreg_hotplug_device *dev = devs;
> > -	int i;
> > +	int i, ret;
> >  
> >  	/* Create static I2C device feeding by auxiliary or main power. */
> >  	for (i = 0; i < size; i++, dev++) {
> > @@ -423,6 +423,7 @@ mlxreg_lc_create_static_devices(struct mlxreg_lc *mlxreg_lc, struct mlxreg_hotpl
> >  				dev->brdinfo->type, dev->nr, dev->brdinfo->addr);
> >  
> >  			dev->adapter = NULL;
> > +			ret = PTR_ERR(dev->client);
> ret is only set on this error path.
> can we get to the return without setting ret?
> 

No.

:P

There two ways to read that question is if the patch introduces an
uninitialized variable bug and I would be super embarrassed if I did
something like that with all the QC scripts that I have to prevent it.
The other way to read that question is if it's possible to not introduce
the "ret" variable but instead figure it out at the end.  But the error
code needs to be preserved at this point because we change change the
"dev" pointer and set "dev->adapter" to NULL.

regards,
dan carpenter

