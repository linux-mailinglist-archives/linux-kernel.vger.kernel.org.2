Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70077401801
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 10:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241170AbhIFI1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 04:27:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41760 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240682AbhIFI1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 04:27:12 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1863Qvej018156;
        Mon, 6 Sep 2021 08:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=mkOtm/n3JrPguTV09fb3ggLfiBd0rkNrAzBW38rVWnk=;
 b=wVFYnsReHXf92205TLOLJJhsjP9AT6fhAUNUPtB946ScPWLt9ttAYMGKPmIHeYsfhtl+
 1M2u2oNNS9js3KrvF5ayA1A7ly5vIizO4/77OjKnOx+a6fUO4AVwtpEZW8qARF0dKjj5
 VHpwHZpcZg0tz1yYOfeZaDjjttGj1f7012llYYHfuIaOfg+LBd8D+2xZ7M7u0cbPHjLc
 lQTaXe/AanroH9SDRMwoEEbgs06a/m+Zv7U0sUK6y7lhAifrgwIc1NGCOS/Bc+BowE0+
 J7/BT2J+J6QqGjfljilekbZDcvOwDMPRXxWPHdh/ycIcE0dV2zw3zBAwLYhcGzVjP4Bk nw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=mkOtm/n3JrPguTV09fb3ggLfiBd0rkNrAzBW38rVWnk=;
 b=pYC4RZt8kO0tEsbFejnmRK+e5YWo/n6owC5elSKunStvneoBqSK2x5FrtV+xGBVwkjcm
 0KoiPQJGSTTA2TJoyuVrCX3Ya5Gn/OMSzee4hKWjm6QGsTPtMtBTK50TC067GxaAeccN
 zTiQf2JAOsBk7zmyc/ska+YwzpSvnw02Mca9+lOkpoIOtqtgi+9ZQvGLFXdZbCjOL9zz
 zzC9WZACm+MKwbTUbCGWMSq5dlfAw3rGP8diJsBCiUiCFgjK5J3OU/lPM5lJRai5p+9n
 2FckO+I/u3S90I1fgXMoze33H8tphHGm1qFA32J7qJdSPF7bUZgaQipcNLE6DuVNQI2v ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3avwcf9pd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Sep 2021 08:25:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1868G8I8048143;
        Mon, 6 Sep 2021 08:25:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by userp3020.oracle.com with ESMTP id 3avqtc1c6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Sep 2021 08:25:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrT1P+4ZUzzI1yzIgPldDhLBzEb6pMhjj38QCr1Uv7F7I6apTNN5fOS2RvanCoftjKkTycxrjISo4WbfASxJRZ9xyBv6oDLBnkdmD97Jm9+Dg/3UxkN/xXeiXelTm645IpV/NRVBzvDOKsV4VvVKXKJWFVsPyT+UtQnzdNgITWiOgFj6gQceStErqbMyFYmXZaAksVcFq15eTUxtsKnsd+s5VtXVizbrfvi+sYxn7BzEjfRZ/jTa4l5ijKVv+xSI5b2Fde9/ctuIp/rNwfx4k0VURvo241fgCwZ9jHBJsj3HwwjrWDYkLXvkD1Pju+uqoYj/1GJzJUDb/Zs91dvp2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=mkOtm/n3JrPguTV09fb3ggLfiBd0rkNrAzBW38rVWnk=;
 b=mwRECEg/BjTT5gK5OuoLWjAzhrMSFNNx0yRLLOv5vmpzyXBAyj0XTfU1q/U38OJB2IwqZffJTuQDoP9eIwiPa5dErLg+4ahuU6+hU1v+i9yxpmh02UVYfW8fTvqt2yELY5f6A3LPpX6QWKnSp5T6w6Wq+G2fK8UX0wiroER9OqHgeUWdFJZs+p4H5nhfR3MEKmfQr9+8utj4S392xBWM4NVGPXn8pf9nn23GQ6ZbcV1lYtmQbJOr7G3aFhCqvhP/hVqRPk4IUulZBR3+CIPqWinFSPPQwM+8+fUCuBttKjbgYdlX3Bn3YTFI3grFvZD+3JHHySxmZGu1qXKTQ5+8Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkOtm/n3JrPguTV09fb3ggLfiBd0rkNrAzBW38rVWnk=;
 b=L2tBen/dObcFY0CwA8TYBC+NowBhHpruGjh27UvHeucSGFGQZY8Y3SFRjQQ/dyGMh3IA4lLP/DWMfV2w62l+pdklzTTDXzzt4Avv2/OVgNRPeoUHofs3p3IatNrlxs4/av79bgpo82hooO+SGRcIMW+g/ZAPs0zdH08viy49WCg=
Authentication-Results: philpotter.co.uk; dkim=none (message not signed)
 header.d=none;philpotter.co.uk; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2160.namprd10.prod.outlook.com
 (2603:10b6:301:36::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Mon, 6 Sep
 2021 08:25:54 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4478.025; Mon, 6 Sep 2021
 08:25:54 +0000
Date:   Mon, 6 Sep 2021 11:25:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 02/14] staging: r8188eu: remove hal_reset_security_engine
 from struct hal_ops
Message-ID: <20210906082535.GK1957@kadam>
References: <20210906010106.898-1-phil@philpotter.co.uk>
 <20210906010106.898-3-phil@philpotter.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210906010106.898-3-phil@philpotter.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0055.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::11)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (41.210.143.41) by JNAP275CA0055.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Mon, 6 Sep 2021 08:25:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93abded3-4bfa-4fe8-88e1-08d9710ff1a2
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2160:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2160E89737F68AF6FD08E5CE8ED29@MWHPR1001MB2160.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UB6YU/npleXWLWzd1GJV+2Ku92kgXM+zAsykBZQiUdy5TuFIrIbgXcdY9nOFdCtg1Xbf1PB9ysPUrpr58/ZoLsU5mJuK85+Q/Q6zHYPMignbaMViaUBu4GoPW5ojsrd7BtZT796OGEJmmhNWJYhZoQq1Gev05VksxJBsUVi5645GgdPowjOb6EY+JEHr4g4tQ30npGEZgTRuqHwIgDL+PEv5oHpUPLKNM7lsn8c6FvIyXVEh/7bjYPgoWir2Sv8Tc7AA+k4XkDjgFk1cM01fryt439E+jDt+6ax9IkmzoG8xZQBEnX6lBmQiLuW+EpeD1z21CBcWeL63AKQIdkMgyjlb/SLUG0OyPbx22HVflnqbCQeH4zlI8hJlBTUIm/t5M1DSFphhSCymbT2biHGlFqncDCT98QQfsbngwB8e+xkdkISyVc4QKNdoACoIDeAj0D1vd8OqiroUPYFhwckinTQPz5JwO15kdaBh/K8+yQQQXlniMkudXPqdcKKV7GGKxSEKCPNp6gj6KKLcYKxtB3Jl1fFj8Jh49YHKzA+fuP4wIbMW9iPjl9Zgz7z7Bb9KtMF2mBcP1FlUm117FXI7vmuFYM4OLy6kVBj6YPzS3dKCD4OA0xAv7yv0xmHLqjFe3sGyzyzb4LTFrVcs5tsy4CkKCCgDtOsjpZH7+QT1YsTa81Ij2cQ7OjmMKTGZCrHKFhmSi1f3GzVFbFvI8g42CFM37516O2mxsfEY+NODjmI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(8936002)(86362001)(66946007)(1076003)(478600001)(5001810100001)(33656002)(8676002)(4326008)(316002)(55016002)(9686003)(956004)(26005)(186003)(5660300002)(66556008)(66476007)(52116002)(83380400001)(6916009)(6666004)(38100700002)(9576002)(44832011)(38350700002)(33716001)(2906002)(6496006)(5716013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p9d5oKMP8PsTbyYEW2TCmdoR8rN0L7JCWmogx6mknOJo/9iWRWt4oykG/URr?=
 =?us-ascii?Q?eNSrN5G/+CGwSeRXiFNk8K+cVDSAm+zBCm0ZmKf6CAFeWIYKFdB9YL9RdVe1?=
 =?us-ascii?Q?C49mVgKVNe548X56Ri8cLKN0LsAr9McEHvzsm9E0u/c2w/KRxyEdFgE6Ifze?=
 =?us-ascii?Q?j43cf9yk7no1AgJ8ZKCkvoAAPbmmAOq2xDcVvdKsT4SLeB4zol+SGA1tcgU6?=
 =?us-ascii?Q?Ve7ntxYVatSeQabL8fWXIyPegYmyBAwCkP+RqSmxPncPWZo/DOQ00gpjJj5u?=
 =?us-ascii?Q?X8H1N3RRMCc4hQ0Ts9c0MskZg8Smk2ZMHue/gr/XGC+ugqUBDCKgmjImgJXo?=
 =?us-ascii?Q?8hNhk8r/w3f+yogUgpNaWn7QNqbFgkM7/MOpSIVZoWKKSeTYuZAfC7PmFOvX?=
 =?us-ascii?Q?CO0g4XhGGrEAjpcYQq9LCUW2FECpMmSpR8a74pAxQnhA1D9pZCBaXP73jT5S?=
 =?us-ascii?Q?Qf3G5apMyzpCjbPIi2kKgcI51BHyhx7qWis2/0pv1twgA4FV3pjQuxlTn+L+?=
 =?us-ascii?Q?HBbe5rVipPxX9lTokjw2IL52kkOTRuWnIsG/ugS5xV6WfvUTGqEtGDGO1qeo?=
 =?us-ascii?Q?jh7+dLvlWx3LAfb8V2Id7rODxFKxD4zmDSCCYOz1zJZ+GiF/YBbnnwKcHW3v?=
 =?us-ascii?Q?2q40AV93grskDi1Yms4zQvM41iEyvQ6tmIG0kO4oVspRuvIm46og5Ta6dPFj?=
 =?us-ascii?Q?tbszOSxGPjMpScfhgcGC7rqWGQR/edszKNWK+fy/5vVTl0TcHLz31vi4c3+f?=
 =?us-ascii?Q?envjKBenvTa9nv9a9vj7Dg2HM2TNgLs1VF34CSWWc2HEDxHOms79rGi5JM27?=
 =?us-ascii?Q?eMFkNLk3hrOVPgWYOttEprxetzZaHtowe+EuXwNfC8NNzTvz9bDzi3ZBhs4F?=
 =?us-ascii?Q?M1xiSNXGqCgAMpu2RY0gfkRzJ+6+Z9JtXf3B4JPumVoHAgd+aCR1xHCetT/V?=
 =?us-ascii?Q?Tsof+Vm0y0Kd7JVJVgvqYVK2JmoaN8okRM5eYmNHEe5s1zpA2DsL1/8KgJNL?=
 =?us-ascii?Q?IUmz5CGTbjOsjKWu6pCMBVoLt3q7NbULTr+/MiwYCMTA7emTSqOrq4FjFiLV?=
 =?us-ascii?Q?QeIhTpKtGnuGZC4JIUSumYP2ZkhTPRklUQ4WtDZCDZXYxgmPsY4f7ogDZrib?=
 =?us-ascii?Q?jMseSZSOGMZ/uDFRJiMJmoO32pQvFFTEiKUe1/HL5YNmUKYeR6j4iUTcCGBQ?=
 =?us-ascii?Q?/zC960YtRJqqpkS7eUOUJKOnHHzhmM3cPZmht6N47BE6agcfk7KyD3mde8g/?=
 =?us-ascii?Q?7FvONiO98/IEFnvqAGWE+5dRYncZnkp6AyKz1Z1uFG9+EYi+IY1bREmJv+au?=
 =?us-ascii?Q?VptrC+9fhWuM2ku9D0I85MnG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93abded3-4bfa-4fe8-88e1-08d9710ff1a2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2021 08:25:54.3853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2fTNiBsN3AK9KONp019kvWeyyUjf8Xh4t5OsWcPYxG01teJW3vyZ9SNOMXgYls24qPVEIGAd7kUTbDRqxgJXIlfp2n8Fnr7FBdq44wMhw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2160
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10098 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109060053
X-Proofpoint-GUID: A9p-79O5UV2pMPHN3NxjBZRsIHjCqB_z
X-Proofpoint-ORIG-GUID: A9p-79O5UV2pMPHN3NxjBZRsIHjCqB_z
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2021 at 02:00:54AM +0100, Phillip Potter wrote:
> Remove hal_reset_security_engine function pointer from struct hal_ops,
> as it is unused.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>  drivers/staging/r8188eu/include/hal_intf.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
> index 5612274dea4d..3cbe6c277677 100644
> --- a/drivers/staging/r8188eu/include/hal_intf.h
> +++ b/drivers/staging/r8188eu/include/hal_intf.h
> @@ -250,7 +250,6 @@ struct hal_ops {
>  				  u32 bndy_cnt);
>  
>  	void (*hal_notch_filter)(struct adapter *adapter, bool enable);
> -	void (*hal_reset_security_engine)(struct adapter *adapter);
>  	c2h_id_filter c2h_id_filter_ccx;
>  };

I love these patchsets which are removing the HAL layer, but it would
be better if you folded patches 1 and 2 together because it would be
easier to review.  That way we can just say "Well, if this patch isn't
correct it will cause a compile error so let's assume it's correct
unless the kbuild-bot complains."

There are other pairs in this patchset which are the same way where they
would be easier to review if they were merged. 3 & 4.  5 & 6.  Etc.

The patcheset is fine but for future reference please fold them together.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

