Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0215B40AABD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhINJZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:25:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:64320 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229551AbhINJZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:25:53 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18E8h8g6018222;
        Tue, 14 Sep 2021 09:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=9TByCfGHOxM5JPqAeVJX3fG7RM7BIJKHdbJGuEQahjA=;
 b=1MPMuv5/hboFK30UOrQpv/T8D1SHRc0JHHbV3jy0vNd5Gr8QCC+uFhVsDFrNFLe80q0j
 TowaxoDxTsGsVrskWTeU/q9mxujA8heAzuCTEkXAKZX1iQsi981QGfK5N5Nk/4xddHU3
 3P7te5qjwqciftfe80dav84MYa30E2gE4bNznyV5Z9bGRuGIZp6jOFPWZoJHstuoj26B
 YhkwUyGjhKlWaOC6BP3VMNL0zA81oj03aspDMdJFyFdiZ5JFz6XTm13vZ2BMX1mwJxFH
 6vz946zDgGhPo1COj2ppPZzexNxHJpO+9Qvf8rwJGEmCerLOVKTvl20pG+/aEGik2LcA bQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=9TByCfGHOxM5JPqAeVJX3fG7RM7BIJKHdbJGuEQahjA=;
 b=A6+elLkWOtLPoAnZz4Wk3p2yng4cK50o3hMbuVIi8SBseNeaPJkEhpJtN+klJaT2RiQc
 fQjrn3juccOLuJzAkOS7eo7dbPH5C+YHUZFdZTNwzb1pqTqLaydykSHR56t1c//8uINP
 CAmOYE+GIfuBwPgZ8S1gsgCw/cD41on7phsdbJkPXSHJVjC9dk+DaA7hNNSlosLm2pWi
 4omdCkbA+RTGjWtUReULwdBSe8qiq0yCh9o/RV9+gBpvJ5sAgSnjojqbqn9s4Yw7IlMa
 ++I8oh/48FtWvlcgSIhWGyKwCoA7GbqFt28533hzWcqZfDpwzmrZzodFQ/i1cEDYAH5/ +w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2kj5s387-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 09:24:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18E9AXjS029589;
        Tue, 14 Sep 2021 09:24:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by aserp3030.oracle.com with ESMTP id 3b0jgctv35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 09:24:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9G4WFtlLGewTpITx3EKKawczmE9fFy02JTPsLb08KVjq40834iuvgX6C6lJfsotq3lZm2SMIeIkAPxUcv/F3TYxLvsTUSFL2CPoJYME+uUY9ELFiUJJW6YkzYcDN7Kpx2AuVukixfV7jDGGYsW21Mvk61p6RN66tBPGVmzmWmwBiqFGGl2j3t7wlb3df9RL3edwjXe5mugF7dN4/Z0olPA4SYOJLQOr/uV3F8XzNj+1ISAalWzAHIsqFVEjCaNY9r0GnbBZqyQo6Sy/w3bz+HWc4NUPxZj8+cZzy3lsvKhDUOYI2FZf9HYJ2C/gR6Q5J5JmRJtmCmEWGW1sPAkmRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9TByCfGHOxM5JPqAeVJX3fG7RM7BIJKHdbJGuEQahjA=;
 b=b+M9env8G0+PzuHM7CjLFlfkbfjlcPxMvWCuRT5HzoiMpwq2coA3Kmfeb49f6sIKEwfFvGDcNgmpNIgcwDYcObtBuqp5OOwYTIC58aHX0Rs+iRDuATuCdjyr7NAtUfOy6mLThOsER2QRw3vd3812pwxO9QidLjuVLd6Ie40Ihn1MIZHdlK+Rc7Up+yAeOEgEykZRQj1VKasrtxw0cwdiDGt1iSM2jN7JjjJtYN5KtjGAbIvElHx1o4KzLrL7jXv96ubJrF9AHbEetTw6vPlCAbGrPamFA55LW3JTQIgX0GEEu4ly3+CGCXW64SOzWEibtPNCSpEQ7+zevqI2ktEjJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TByCfGHOxM5JPqAeVJX3fG7RM7BIJKHdbJGuEQahjA=;
 b=YqGLUWcdycv2L5UupIXTVOfYcJADC7nc7NLxGntnB0z47UULgsPIUTDIgyE9MqhQU3itzQmXVOw5k9T8ET1coXmD9iqJmJT6DnHAfblAzbwcMY0AgqPN8a601RUQ0BrdHhq971kFy71mYdQPcC+TB83P/dOaRdLHjo0DnBmrkZs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2320.namprd10.prod.outlook.com
 (2603:10b6:301:2e::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Tue, 14 Sep
 2021 09:24:19 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 09:24:19 +0000
Date:   Tue, 14 Sep 2021 12:24:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v4 15/18] staging: r8188eu: hal: Clean up
 usbctrl_vendorreq()
Message-ID: <20210914092405.GB2088@kadam>
References: <20210913181002.16651-1-fmdefrancesco@gmail.com>
 <20210913181002.16651-16-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913181002.16651-16-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend Transport; Tue, 14 Sep 2021 09:24:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 082fe8e3-3bd2-4cf4-1bec-08d977616e22
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2320:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2320D5F649CC1D00EF15E19B8EDA9@MWHPR1001MB2320.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GRZWohBtC+QkoOIQKrMu91rN3cawEL3mI8rYjP0NxuX3aCaX7fpeB0i0RRkr9WsuL+8fst27JRBfivi4JfdfVa1+dGuUk4OwIaUMtrw24RXcvIkxgCR0eD2WEy6NJPlkfUlbIREI9YKwcpSE/vF+ZgyVXGu3TVH4kXshjHHp1zmsrQhF7eEz8foTOaZ1K12FF7Ty2W0cO5SweWDsqcmQfVW/faZmt6J0lI6RhgPCVdRhsUHx9/eqwnzUNfJs55mRVQ83qf3XLmsdfP07HwFzoVL9KEIdMErjjW1ALe6sqrbN4wDZaUIO5kMH5naFZU6asmQuwC+cSb+jxt2Tr9IuQizkzLtdVC2/vgfI/5nf0UmFQyAHItzal+eOxl2+7/RLRYBfkQ7wcmDWQcjci1xVTcARoDI1Zi7yFpIdYule311jXfnLQDzl3iEBf42VsGAKFZ4myPSRcxcELfg8KAlonhGqtYnL5exlLoHkGWYEzySQN1lrzjy8IUT2B9fbXmMBFItLlZZ6qI7ABh3DJFrWRjrBTSI1K7kVKrMp+ND+4CMwTNxNK9nBw0gTOILFiYQNWoshCaTOqz0c1ChGu3Mo8/TteFdbwHGqMlnW2+KQ9uhWlbIroWtNbFoxeIPawB8kqUXNrd2akVUYg9vVtUS+JrypzwnBDvdGzMEmVCgV+EdN9Cj4eHWRvw5yFuSg7EMvjToNnBvOTy1eA8MZZbwlqo+A/lt/CEhJPa9rLDKoDLWYdWVcZ4WVVNkGv6OpDoIt9laHlXIV8a3TfmqE/Zb3NUAFnwAgoegUUarCyW37jrY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(346002)(366004)(39860400002)(33656002)(66476007)(66556008)(2906002)(1076003)(86362001)(956004)(38350700002)(55016002)(54906003)(83380400001)(26005)(6916009)(66946007)(316002)(52116002)(186003)(5660300002)(6496006)(33716001)(38100700002)(8936002)(478600001)(4326008)(966005)(9576002)(9686003)(44832011)(6666004)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oRlUAwnp05EEnuS0VThfXHyL/33EdBjamEGNXiiGa7qPIWGhRGMlOLmjsiIU?=
 =?us-ascii?Q?Kna2wJ4ckr+XkV5MWl7lIsCj4RyRetbvE3rwFBvtZ6XqnHz+SpQwCOB6dRjV?=
 =?us-ascii?Q?zR2uYUhKuKaL67IhZEc8SlICy8eiilJ0GJ2qXIU78WiX0q93mr2OR1ZArvW5?=
 =?us-ascii?Q?PVIEDskVqll2HqHDNzy0w2PYMveaDq1cwd+qRQsz55FqHiX7Lu7zB5tVhxWl?=
 =?us-ascii?Q?6S+W7oCwz3ac16z2jxf9udzQ6UoFfQm/MKdpFClx7/LT0dlwW9u0tIp3Tz3P?=
 =?us-ascii?Q?OtM82FJkd97I+m1uCSj2m4Vfvt6qYiXyUgKSUB2qQofWC3b8cBn3OF+EPygm?=
 =?us-ascii?Q?qAPV2ZxmYNpK8BfMfdc4BolL4F2wRljQarNIe/O/iloBxLBDwKaI6U9PkbVe?=
 =?us-ascii?Q?ne+sj0S9EV6f2sHWapRev8/ntoo39SIXPJfvl2wQRIba2xiWY35B4fsPX5Yo?=
 =?us-ascii?Q?mFKkm+0crxpqesfFjfz3JeEImLjxeXhGjwFBsVl+MFC7f8i6X1dpn/pfs0vb?=
 =?us-ascii?Q?lLLV/PvHtTs3k2dIbzoUyDWyn/x4In5cEmsa9yAnM5ieLLsVns62NiYkXiWP?=
 =?us-ascii?Q?CCGX0fSslI6xdNN9IA61tzw58skST+KkxXZ28WiJvXnIY9UMa6wDh+Ctog35?=
 =?us-ascii?Q?5xKCdRcqzhQAelTNuzQLJgR7lqv/OdrKf2ps4LM8u4ZhRDzgjnsz7TVdMv7a?=
 =?us-ascii?Q?VBZgEIX0qgq1pSt4H3FYudhRDwmw1aKmwGKSfngXEWWDElNPlXNGghCeUjl/?=
 =?us-ascii?Q?XRSKjXmhVa1HntI2HIU5z40RAhJxCFwKSTrRnPUtYx/WgxOagiPtd9E+N6OQ?=
 =?us-ascii?Q?k/SEysS4giOO7Rx3vg9nKlMt/xwMDZhwcXSA5glxN1BaJLj1Xam/qBnAVofp?=
 =?us-ascii?Q?ZNGWEcIy9Ykk474MQOzy9OVzVjvNGqXejp2Gr5R09tVhlDJuXBTA0rGhA2ew?=
 =?us-ascii?Q?OiRbZqbTr09d34Xso+m1U997Hvz3IS8mJy8lYdJeMycUzTELClO7GAIUJpFH?=
 =?us-ascii?Q?aY/G/kzZnNzusDCwXx97CbKy3dxgwjuJnTxQIrYQOf3hIczA+yp+LGL17YTl?=
 =?us-ascii?Q?iJyBRzSMis48ZE18ZtKb0xLu6QkO2pJaUHJqbNj1h5XC1UDLdNcZTZNPR491?=
 =?us-ascii?Q?7sROhlRXL38YvHVzZnIyBzXoszmveKKJcl735LFpm/UobYhQqj94l9iqlPV1?=
 =?us-ascii?Q?w3oQMwhIvCX7sDSIwoFnN6jUL/5QouSUUZqTB6XWXBnZ/qA30Wl6PKD7Ip3n?=
 =?us-ascii?Q?phVJGWfKulBzSA4wMS9TEp++tRO7RN+MWaNMW44ebSNkRKlGJQZuVPv77bZ1?=
 =?us-ascii?Q?GV2x97mxkiiVMeedGcXfcz1B?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082fe8e3-3bd2-4cf4-1bec-08d977616e22
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 09:24:19.5326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApujOzKGMDf24+IJPQZXOv84Z/3B962OUmgv1UzME4w40qd8AyFm7nMwo64hn+iCrpT8DvWJnr3qqxSSPz2KvRIqegQFzAnz0p5SqiIKS6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2320
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10106 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140056
X-Proofpoint-ORIG-GUID: NNLhd1LCiWd4-d-GwkBVbDLhNAByq9v9
X-Proofpoint-GUID: NNLhd1LCiWd4-d-GwkBVbDLhNAByq9v9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 08:09:59PM +0200, Fabio M. De Francesco wrote:
> Clean up usbctrl_vendorreq () in usb_ops_linux.c because some
> of its code will be reused in this series. This cleanup is in
> preparation for shortening the call chains of rtw_read{8,16,32}()
> and rtw_write{8,16,32,N}(). More insights about the reasons why at
> https://lore.kernel.org/lkml/5319192.FrU0QrjFp7@localhost.localdomain/
> 

This commit message is quite bad.

This patch has nothing to do with reusing the code or shortening call
chains.

Don't use a link like that in the commit message especially when it's a
link to an email you wrote.  If it's someone else's email you can say,
somethink like "As <name> points out in <his/her> email <url>.  Blah
blah blah."  That way you give credit to the other person but all the
information is in the commit message.

A better commit message would be:

    Clean up usbctrl_vendorreq().

    1) Remove impossible NULL check.
    2) Rename variables:
        pintfhdl => intfhdl
        pdata => data
        pIo_buf => io_buf
    3) Edit the comments.

> Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> v3->v4:
>         Make this patch.
> v2->v3:
>         No changes.
> v1->v2:
>         No changes.
> 
>  drivers/staging/r8188eu/hal/usb_ops_linux.c | 62 +++++++++------------
>  1 file changed, 27 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index 117213c9f984..2c7e92085a6e 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -8,15 +8,15 @@
>  #include "../include/recv_osdep.h"
>  #include "../include/rtl8188e_hal.h"
>  
> -static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata, u16 len, u8 requesttype)
> +static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u16 len, u8 requesttype)
>  {
> -	struct adapter	*adapt = pintfhdl->padapter;
> -	struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
> -	struct usb_device *udev = dvobjpriv->pusbdev;
> -	unsigned int pipe;
>  	int status = 0;
> -	u8 *pIo_buf;
> +	u8 *io_buf;
> +	unsigned int pipe;
>  	int vendorreq_times = 0;
> +	struct adapter *adapt = intfhdl->padapter;
> +	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
> +	struct usb_device *udev = dvobjpriv->pusbdev;

I don't understand why you moved these from the top to the bottom.
But the original was better.  In networking code declarations are
normally written in Reverse Christmas Tree format, longest to shortest,
like this:

	long long long_name;
	medium name;
	u8 short;

>  
>  	if ((adapt->bSurpriseRemoved) || (adapt->pwrctrlpriv.pnp_bstop_trx)) {
>  		status = -EPERM;
> @@ -32,51 +32,44 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
>  	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
>  
>  	/*  Acquire IO memory for vendorreq */
> -	pIo_buf = dvobjpriv->usb_vendor_req_buf;
> -
> -	if (!pIo_buf) {
> -		DBG_88E("[%s] pIo_buf == NULL\n", __func__);
> -		status = -ENOMEM;
> -		goto release_mutex;
> -	}
> +	io_buf = dvobjpriv->usb_vendor_req_buf;
>  
>  	if (requesttype == REALTEK_USB_VENQT_READ)
> -		pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
> +		/* read in */
> +		pipe = usb_rcvctrlpipe(udev, 0);
>  	else
> -		pipe = usb_sndctrlpipe(udev, 0);/* write_out */
> +		/* write out */
> +		pipe = usb_sndctrlpipe(udev, 0);

Use {} curly braces around multi-line indents.  But in this case the
comments are worthless.  Just delete them.


>  
>  	while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
>  		if (requesttype == REALTEK_USB_VENQT_READ)
> -			memset(pIo_buf, 0, len);
> +			memset(io_buf, 0, len);
>  		else
> -			memcpy(pIo_buf, pdata, len);
> +			memcpy(io_buf, data, len);
>  
>  		status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
>  					 requesttype, value, REALTEK_USB_VENQT_CMD_IDX,
> -					 pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
> +					 io_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
>  
> -		if (status == len) {   /*  Success this control transfer. */
> +		if (status == len) {
> +			/*  success */

Delete this comment.

>  			rtw_reset_continual_urb_error(dvobjpriv);
>  			if (requesttype == REALTEK_USB_VENQT_READ)
> -				memcpy(pdata, pIo_buf,  len);
> -		} else { /*  error cases */
> -			DBG_88E("reg 0x%x, usb %s %u fail, status:%d value=0x%x, vendorreq_times:%d\n",
> -				value, (requesttype == REALTEK_USB_VENQT_READ) ? "read" : "write",
> -				len, status, *(u32 *)pdata, vendorreq_times);
> -
> +				memcpy(data, io_buf,  len);
> +		} else {
> +			/* errors */

Delete.


>  			if (status < 0) {
> -				if (status == (-ESHUTDOWN) || status == -ENODEV) {
> +				if (status == (-ESHUTDOWN || -ENODEV)) {
>  					adapt->bSurpriseRemoved = true;
>  				} else {
> -					struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
> +					struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
>  					haldata->srestpriv.wifi_error_status = USB_VEN_REQ_CMD_FAIL;
>  				}
> -			} else { /*  status != len && status >= 0 */
> +			} else {
> +				/*  status != len && status >= 0 */

Delete.

>  				if (status > 0) {
> -					if (requesttype == REALTEK_USB_VENQT_READ) {
> -						/*  For Control read transfer, we have to copy the read data from pIo_buf to pdata. */
> -						memcpy(pdata, pIo_buf,  len);
> -					}
> +					if (requesttype == REALTEK_USB_VENQT_READ)
> +						memcpy(data, io_buf,  len);
>  				}
>  			}
>  

regards,
dan carpenter
