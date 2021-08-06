Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C97C3E291B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243263AbhHFLIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:08:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:9542 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238306AbhHFLIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:08:35 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 176B6OBM014820;
        Fri, 6 Aug 2021 11:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=cROaploWjhUngZY1sYXeEA1H1T5ULbtu0IHEmuxulMo=;
 b=a7wkpK4yFqJ3CX9ljA1pR6/wwy/3R75FntRobAcGh1L0y/dBdvs7y/hNeCGCIGWeylnb
 H/Zh8Hxg2DJbQpWaTMWPMX6mitzx4mbCNEV3TylH6IPT8ucced94dxxu0eLP4ePDOabC
 CQkQOt+ZBe1ilCBWrLsWWfcPB8sgS1S5Qch4i/4VIYLaEGT8wQ7M4HroFId50d25aZCH
 xVjtcRtkfY1FZh5U0aLquU+Fupc9Lbzl/xGMDWlf7GzSIL7G0AqqJXHbM3DrmORTAsQE
 GTH/efGkAaauWkueiHoSOJ3s55Wan1lzfKfgYfrNrGfy6Cy2g8Z6RrthvaSmTzi7OK2T xw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=cROaploWjhUngZY1sYXeEA1H1T5ULbtu0IHEmuxulMo=;
 b=pZMr3cNBVTlKq0O6TrPeiREJvLZQ1kMtvFismmBtDr28i8ti8Lv7QIzZu0W9MXt9WzYZ
 I6zT7eKv7a1am8j7N5DsKz9Vb32cjYnMtONzDZeEjb6ObNHjdkm3E8+C6+23wnUBqb1f
 QTN7L7fOnyoSljkR33T72iatZ/feVGrKGZCBdfhlSEvEIBgR6lS8oG8H0vKDqtURyRy2
 g1FrHH9KbkL+dSBro/wJh/O5xGB902D0YoQZ+EJAb49k91yxtxRNuPp2w/xCaaBCnG/u
 fuB4dq+z/GW88qtUXFtD+GiDNDDrm/mXVRAb7FVvpa6t3TbI2EFuuUh7uG0UvngDJet/ Hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a843pbrxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 11:08:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 176B0C9m058015;
        Fri, 6 Aug 2021 11:08:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3020.oracle.com with ESMTP id 3a7r4bfdwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 11:08:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQeWQg9STpn8CuI2zYt4Xmq+pOVu50nZmLjsawHAFJBsKA0JS3Ls6II0kjsvF2CZEG5C1lo+d5HLK+bI1Z4lo07u0NDZJii5F8zFJEuJpy2AzHvhH+qbnnzydMIuHHeklpmx6IqGD/2Tk3jh5a8gnX3WZ4vnh0ARHwXxTUk+1E+4ptyGLhIjXfROB1hUaTKO6Dsx1tqca0cGrm3RtuAaNpP0DeEcCZRs0p3etRzDUraWj+pxaubD5Az3PGbHnw1rAO8yQa1dTg1AYKUDnvy4PqyFrbCZJ/lvN6jBRn/58kyPl7+lFuqL3eHFmMq8xbt2iMQ05MPCO19B22CLonFvxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cROaploWjhUngZY1sYXeEA1H1T5ULbtu0IHEmuxulMo=;
 b=eCXRi5muyQmcNNJ+TbiauPE+4bk5ZO7dMy0ZzkGWNrZ8rfJ90Qd6S+EE6FQqZvM1UpXXuVx35jBP1kX62Jedt15hCUg6DR3yfywJfS5tyAoyvfGnOTYbfqQt16mySZ9KzDt/QFqBIcPucakD+36gILbPoLcpGZqNV2fGaF+j8RfKbLEJ5DsqxdXLAJTjjrZqII0PzSj6aUy6NeYBphY1mqx44tF1YBAnyPcA+IVavR7R0Le9actDX8sMA2WAkgxEnQlUkzF68AXpdQhv+04uwMKSsYFpkq5W0zrqYku1Gdq/MHj9k9FI1IMUZm+hy0DQTq0BbQbDFEc4Kfpddl2xcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cROaploWjhUngZY1sYXeEA1H1T5ULbtu0IHEmuxulMo=;
 b=BZMhFoCkJASx9S4+nkUINU8S2J6q0dwOX4GYizU8nvvfMa+vCBm3m+8+uKmgV3g1RM5NISAKQQmvLoFXU3MsUpta8kfQJk6BNKtxCxiY4l/HcB/ZWqUrseHhBUPNI2h5obI9gKlmaVkC/XnZmBsnsTSiP9uLLNBu8L+ulrwotX0=
Authentication-Results: lwfinger.net; dkim=none (message not signed)
 header.d=none;lwfinger.net; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1725.namprd10.prod.outlook.com
 (2603:10b6:301:7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Fri, 6 Aug
 2021 11:08:12 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4394.020; Fri, 6 Aug 2021
 11:08:12 +0000
Date:   Fri, 6 Aug 2021 14:07:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     gregkh@linuxfoundation.org, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] staging: r8188eu: Remove wrappers for kalloc() and
 kzalloc()
Message-ID: <20210806110752.GP1931@kadam>
References: <20210805183717.23007-1-Larry.Finger@lwfinger.net>
 <20210805183717.23007-2-Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805183717.23007-2-Larry.Finger@lwfinger.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNXP275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Fri, 6 Aug 2021 11:08:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cee9be47-d30d-479c-893e-08d958ca7aa4
X-MS-TrafficTypeDiagnostic: MWHPR10MB1725:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB17259CEAE3F0B1EAC9A8705B8EF39@MWHPR10MB1725.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRivQjdO4KoXectv3HSPyihT3psxYg21mx58zeXgoah0lsrCA/5pdZ6nm6QtREsvgEjxbIXvEsFglpl4+ZsFPBc+clQYAuAHGiyPy17UYp5MKxqZXi/l1NeLMg/1U7DtF5zBvD9yqzlnStk+mKxFKqUBRCQ0R5o40ZVi0aqbSyTJzrOO620rD7Gb4NK7KUAD+6w6Yg7UqQ8Ep7ZX1IbD4XQ79X+dtVqNFl23BXgygkfFQpKNy1uGLRsdm4jvxQUvQRWjOfIweWKnX5q0mktCv9LKzuC5AqwdMoSQbc391Z6bw3XCDO3+kCzKbr9uFr2cP2iTj95TM0ZavLeBq+iai7XlSFarVp6b0v/37JZgJ9kB/KAvUc2Q/8CjbWELHzBm0Cn2iLS7zWf87vALgTjKwP5bsaDuOObu8WMEavcXBQY8o5yRZ5DrC5FIO3OlReoeKLJoveu/mNcOqv65//aOKT4rcQitAER4QQnsH9h/IzQrm3M9xFNWWYHSwfK3P/TvzF10DoiGvoIm4+l2C1mieWRu3GbxO0Ovsykk81xRbXLN8ml+TMWd1PYqk5HfAA9dbdY2INOCVg6tSDuud3UcHs1jhd0f7cuTYx27MXCi/mgfkMQEAfQN42dmPyFfFJjBOqny5vI/IaOrClzW/Fs5E5bi8f1E8MVlyZIE9f56dk3SRTdq7qxzlD4RNMt0BTCLwazUuncKmPWTKJvWHYloeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(346002)(376002)(136003)(55016002)(33716001)(6666004)(5660300002)(33656002)(9686003)(478600001)(4326008)(2906002)(66556008)(66476007)(86362001)(9576002)(6496006)(38100700002)(38350700002)(316002)(6916009)(956004)(8936002)(52116002)(66946007)(26005)(1076003)(44832011)(186003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tuetKMHgtcfddJ/k6kVESRUE5VmlBmMHfx4NSPMowzA9OUWeEo/LwgrK/Yse?=
 =?us-ascii?Q?4/mt1mzH0jiPw8gtccj0GBDTyG55WAz1eP27MpesyMzEjclflrIySzEzAIEm?=
 =?us-ascii?Q?N+Q4DXus2OFUjgTPOUHuIYz/G7BWWlzH89dFDhi39eRKBqcEvY3RvJA6xyuD?=
 =?us-ascii?Q?7W9Nj5Qkb0orHisuHdC0njHPzzu7GN6w0RrAGkQa0oP35UxGkIhgUJiFZSsJ?=
 =?us-ascii?Q?QwA/NAKlhIhX+459nr6Xb1b3QbWlTmFw7h5gNq3Df2YEo8HWOwAK1NWte0RS?=
 =?us-ascii?Q?DPgNqOnDPxq16Kc+Zb3pTolLzQ9h8WblB21rcZtXtMRqSaS0248VnsqPYMhF?=
 =?us-ascii?Q?fVB1E4iMAs8di4GplTesMvkkTyu/QwIMvJ18FhekfNUuEbAb0yBiBKoeU/dC?=
 =?us-ascii?Q?sVCk7H2Uto/sXVNxUvYl2EdDainYp6UUxQZdqM0tBWon1+TMgQvHBsVihAgD?=
 =?us-ascii?Q?Au7HXIE1W1qE3OY8iFjtNCugnZ0RzkaHL2qrfo8ZI7UqvK4RoYPM/COZxVp4?=
 =?us-ascii?Q?YHHz/QOwwmd9AcmlqrUVS8brw5CSbvBRHxkv7+8l0NUuD4ZxsWZxkWlcG75/?=
 =?us-ascii?Q?nx7Ripoia6fJd0EiX5zhY6TBvedeFghEp/tDL/lIrfVNGTKvMka8AXefXf+t?=
 =?us-ascii?Q?td4YfeePlyznLHirDzLRezu8szFJJ5ENRspTT/kJ45HUQvczwcmEfQlNUDxW?=
 =?us-ascii?Q?qUDfsRgkb7c4fzIsoeWwqKjkoBrl6ZAwKlx6/XtR3iSZRe81x6SLgo3KM72o?=
 =?us-ascii?Q?Aom2j8m57xJO3gCI8h3H4mClgnHIyCfbebnIPoTvZEdue600aiQDCUxwvJ1x?=
 =?us-ascii?Q?dlOKJWRsy+FeQjBwDAYWFiQEABCT4b+rAhgKFSIiKDbrgeOsCMQTBeeb9tlq?=
 =?us-ascii?Q?plUEorqGmZz5esWqaE9QSTPvc/7dqwdtyLQaikr0lUt36aR9LctY6+RYVcXX?=
 =?us-ascii?Q?/kUvQW6+a4B26/wmYUCpQo0PIldSFB3DwW0C1CTf7Lyt0GNmjjzb6xi1dwn1?=
 =?us-ascii?Q?k17+LFu2P72D4SFX90miWGpNz01RdWIlttdGjoWZHEcg596tOooPoexwLIFx?=
 =?us-ascii?Q?KX3L3lqNtIBGiyniyOVXFxe3XbTZwpFZXy+AYIZ+OK1RKH24CvhhqS6FXt3X?=
 =?us-ascii?Q?FTeXIghJnthrCtcC6pDrH5juPVX1jo/TE87fcaPsaYHeqkAPu6c9ePb/RibZ?=
 =?us-ascii?Q?HhP9gCRBEKvY+ghUwEuUBxnaBmKnD5/l8EUd0vAcCwp4Aa4aTTYb1x0uFI50?=
 =?us-ascii?Q?g9xesZyc2imMh1BS5V643Z9sRxqYHiw0zTnv5jPYIJhCTZHR2Oe2NPBOYQqJ?=
 =?us-ascii?Q?4E7RbW1vTm2vILDn2yrmzBk5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee9be47-d30d-479c-893e-08d958ca7aa4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 11:08:12.0923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMaCK1OuL2CqDV2UKRXt/IgcrBXbf9aCAZh75gz6UAbIb9hCeaoZ84JQLUUqPm82N7ID9Wc8WK5hlw0jqlMBI/v/jL3A0CfRQg6rImD6Z3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1725
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10067 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108060079
X-Proofpoint-ORIG-GUID: HuSybSbWohIKIqnrsSPaojJDt_2uEcQQ
X-Proofpoint-GUID: HuSybSbWohIKIqnrsSPaojJDt_2uEcQQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 01:37:13PM -0500, Larry Finger wrote:
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index 4ac76ca6e383..d7d33e201f37 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -1947,10 +1947,13 @@ static void c2h_wk_callback(struct work_struct *work)
>  		if ((c2h_evt = (struct c2h_evt_hdr *)rtw_cbuf_pop(evtpriv->c2h_queue)) != NULL) {
>  			/* This C2H event is read, clear it */
>  			c2h_evt_clear(adapter);
> -		} else if ((c2h_evt = (struct c2h_evt_hdr *)rtw_malloc(16)) != NULL) {
> -			/* This C2H event is not read, read & clear now */
> -			if (c2h_evt_read(adapter, (u8 *)c2h_evt) != _SUCCESS)
> -				continue;
> +		} else {
> +			c2h_evt = kmalloc(16, GFP_KERNEL);
> +			if (c2h_evt) {
> +				/* This C2H event is not read, read & clear now */
> +				if (c2h_evt_read(adapter, (u8 *)c2h_evt) != _SUCCESS)
> +					continue;

Not related to your patch (don't resend, please fix this in a follow on
patch if you want to) but this isn't correct.  If the allocation fails,
it leads to a NULL dereference.  Or if the c2h_evt_read() call fails
there needs to be a kfree(c2h_evt) before the continue.

> +			}
>  		}
>  

regards,
dan carpenter

