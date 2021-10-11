Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B098428CFD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 14:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbhJKM3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 08:29:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:35898 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234635AbhJKM3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 08:29:02 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19BCLEoI004161;
        Mon, 11 Oct 2021 12:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=G23xYey2Jzaq9HiHhDhcaUJUhlJ+P52JrhvFEF9MIfc=;
 b=nQ9Nj+GGYAtwTjPMOttDiWDtsVp/qsJwHCl/ybNUmKrSV+SulWi03AmeoerA9qqaG8Hg
 DHQmeuIwyVeJqnhzGFnRAzlFmDKv/x+byi9HF7mjeWG7xe3p8bq48s0z5Os6prbgxbzm
 X2PYuEJxhf70BeBw96YZpjM5FbJi0wTYQi83ZNdWdNSH5a4AQ4s0sBRI8unF2n/etquF
 F/27u9FyqEiL1ZwvcaohHMdlh2Ef+OsGQBJg524s7nsa/WQRz5tcgU50N67CB6QnYXhq
 wimF5E2UiwkzCajWjQt6jmwjTKp+iUgYbauIz59kQJKjBYaeqraSt0g6dsYFIqFjbIog aw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bkxxabkqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 12:26:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19BCF2lb083920;
        Mon, 11 Oct 2021 12:26:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3030.oracle.com with ESMTP id 3bkyv6xe93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 12:26:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbaiTu09kxRJuWQtcYOL2Lqfyusdi3g4iMYdgqmSFvim2rekQXmcIHUAq01Rit8/a6kAeoudsNririC6TX/d2NohBQVMI6XmQtVlP+41zz7z2sw5aTDZSx9MMZBJ46hlUM8U8+2EG1Tvutaj02bi0Wk1107aTUbvC0fIAHyzX66O3RH599Qz+vVOgJiQ6PHJjDXsiO+nPAdJ/XPh3x5kXFriAgHm44IYZpiDdPqPpSsHoc7kZHyVJoiiRpi9pDqnAfOOZTbqeTWuPj8o4WYTdO+Lo/qndrAdKpnNHPvCUPuhU8y8CAH4zUik7/FTvSI7yVTHnnyWiNnqItDKgHq/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G23xYey2Jzaq9HiHhDhcaUJUhlJ+P52JrhvFEF9MIfc=;
 b=NHql7+h1yZZbZpktRwNURR3nf1EF8/cr0r2j+vemK9A63s1WAQDT05hcBojUBGfpDW0UszdzL74BDVlOdJJOlKhw5+x6N0Vx46cy3fcI8+Eu3oSmOW+62A+vtJqjbm1rV6/fDXraEMjg56saSyEWRexNeuYUwpkn6/k/Yt8BO6RuqEYe1Y97qtjVfen54WjIIuOKOU7VGIGH0hV7FQCTUvRl5MX1/PFhY9t0O3F/KNybv+r2YJqBB5ZzzAmJr3ozoVtIOAN/vQwnRwTiiy6x7ax+9cDYHk3RUVuAHcOUk8SzhWzMgi4XtgQe1c5qdY4wvBEWdCRIOeol96K80DXjOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G23xYey2Jzaq9HiHhDhcaUJUhlJ+P52JrhvFEF9MIfc=;
 b=t6F2Iedwc9v5gbgTqGReiayGECtmvGE2/l7YR6kZfd4bkGiCO8xuPQdypASN6fNqpaI5ySxme4PbOGk8z4StBuhulB0SHMuFHay8ssPtM0eR4MsphgMxjc+F6Ok7t7XXh1JdMSrRjDifnGtQAAHZBoXmFlx3FxnrMV9Zpwj7mEs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4449.namprd10.prod.outlook.com
 (2603:10b6:303:9d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Mon, 11 Oct
 2021 12:26:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 12:26:49 +0000
Date:   Mon, 11 Oct 2021 15:26:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, marcocesati@gmail.com,
        insafonov@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: rtl8723bs: os_dep: simplify the return
 statement.
Message-ID: <20211011122631.GA8429@kadam>
References: <YWG3oIchovDZnPl8@user>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWG3oIchovDZnPl8@user>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0028.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0028.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 12:26:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8beb5af6-8078-4454-7490-08d98cb26619
X-MS-TrafficTypeDiagnostic: CO1PR10MB4449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4449D6F17ABC43CE49963E138EB59@CO1PR10MB4449.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ipXWfry9odAMYmsznVH0vCZHrdrBkonF0g1DnDx2Tm/OkqUvr/zp40bp5akTd3SUT69ev8xiq4ffVaGTHKKmZqtNtUML3kJmfFEW4WEzqHDHYY3rpAKRTv0rafLqRvkfGoYR2e63P3/6ak1tF/IHeiPYQ6Tb3YTPkwbFPhhFntqCUPhz0CltIAOwuluedgci80qMbnLvXMUuBgMFj9pt6p4m12gYbnRz0Hr9cjH3UjEOxnz2dnRIe6rhDa0OuCVTlQ/PdMCrRbU4YKHZs7laxGt9Mq/BrHuyh6oS2XuItUEjjlQXLPbfBV5FhGtEPkeHjPyqmp4DjE7VsAWyiJ2e81Uhr5wb9t+Fw8qlX2jkb6xlr6YMEcRpb6bA2Uv1KA8n0CyFcqVqhEP+JGDyGsChPc4gn3pM21xGss2THshEqbO6/dFIc3VxGGJpJrTdoeEbAdEg+gUHeLMLkiHXCZGRHZfg9p3Ni8pB/s1JAZ3dKYG0Zjpg3xHX6IJpgaoF9eUHALimDO6U8ghAxxzSty2MBi3vclVjTIvSK2GqDEWDIbXRGdVROapMmKJjPe64FaBqvZzhBeObXzIxoEgNyxqKrOG4y7c/8H9V63Xar9fcqi2lAOumDM/Hb5nRXRTF5ZmXSmPUSkAzghg1di1vUjLzujObYWeDFt91jPuH/X0QgHreeCvIzGL1Y87Dj4tCkU3gNgifFu3Ut42MYHQ4HGDxtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(33716001)(33656002)(38350700002)(6496006)(1076003)(83380400001)(38100700002)(9576002)(6916009)(4326008)(86362001)(6666004)(508600001)(52116002)(44832011)(8936002)(66476007)(66556008)(26005)(66946007)(9686003)(186003)(55016002)(5660300002)(956004)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lT2yRZGk5pLLayprZ+ylYdtJF90m9teUuTw2jKXULkarEpvzm1YWZs/ktf9E?=
 =?us-ascii?Q?OE59ADeoOCHosMElPwVoBIxYYtm37PyoCchPS+M33MY+MwxOeKSK21eOD3oJ?=
 =?us-ascii?Q?lIZpbzcYyPFOg0AOsC+7199BmwtaEjpHF2XNJ2WcxRMtNMCpuSd/YwLRk3fx?=
 =?us-ascii?Q?uw8j2PjbkeovW8umYVO1jzGNsRHBoh5j8zlGYHz6pxlBVC8b5b86qwS1Vfbk?=
 =?us-ascii?Q?J0vUtMQoB4KsRj8+5UDj5NPtG2YvvhkJ53eNKziMK9+yAhrpG/4tMVhF/6ZA?=
 =?us-ascii?Q?bhLPVLjhd2c7M5riZCu6fF3KCwvqC8UvXVnlNQL2dnmHmeECozb7ZLruQv+g?=
 =?us-ascii?Q?ykwxsj8t8SQzcWBrYPsC2FqtWc7SiH7Cevi4LtynuXG8nAGcMpNGhEECiVLk?=
 =?us-ascii?Q?42jb5JD11KdoD4/1dIovWd7jC3tbV/Hslf4y6uZcKur3UWHJdSAwsHFvjryw?=
 =?us-ascii?Q?81fexRAqPJLQfSyE0UXcI3M7H+7EhWe4ctssBKJXGgJRjFHGE+axahruCJl4?=
 =?us-ascii?Q?HKuxS96twI1UvJZr/PA3cq0x1zTe+FXO64Z7RWCkGRNlglvKR2FtRIrPbQyP?=
 =?us-ascii?Q?gAKwvvuOKkqJmVG7Kydg6gbldWWpkqYJEVGXWarv0k0FXPqPUOqFQv5i7JZj?=
 =?us-ascii?Q?EE9qreKGWW6HgGS8s+GrRRd7hcz4tTqZuRZhoun62/VUHmjrpHEElj8dkSND?=
 =?us-ascii?Q?tw7QtIxyYW4YgHBhESZnCG5B1r9Ndz1Hyodk3/zugvq6VIbdND0DUUyiig+j?=
 =?us-ascii?Q?rdWKsU9HH1AaUDVvMzF/Mfo4vpn7pJKzJNQN3EDLikc6wsZh3Uxl5k6+4sxZ?=
 =?us-ascii?Q?YrkxvK8gM5jBoxWUpVYtsEybqgYJVRqfTqR1S+Am5l/kq6w5vGKXIABnakNT?=
 =?us-ascii?Q?NeWBExtTsroVM+yNwyDOE5Ictcbs977qMTtyIWTlFmp8V5H+ePMmsuS6EW5f?=
 =?us-ascii?Q?ju9FtqoH6VmcjjEsoCmb6aMO1+8+2FUniLV/18PFeqcvlssKkQwS+KO8GAJ3?=
 =?us-ascii?Q?nGZouIE2qnYJntqGsv+5R0dlbZLTOysPQvVHq2C+xZz+NarmGKDEVS3/hHLw?=
 =?us-ascii?Q?PjtZ5pSPfRGztp0Q5bovL1pWM0ydU8DA3P5LOIJxChy/a5cA+v0brfESFuRu?=
 =?us-ascii?Q?hZ77X08uL3QG+m+iqcxRpFgw/5X+3SvXsJ2636RTFCzT3kaiYdxaA3iR1TyK?=
 =?us-ascii?Q?A7NdetsyHUgdmh4KV9Y0PWbCDz5tG83MFX2IUPr950uFlPSR4VQyVufLMSwc?=
 =?us-ascii?Q?nIFc2yc/LqgMBV84Y9VXPoQ0KOfNjVzIE3mtp2zNYmyfzLkS/iFaySIGpqes?=
 =?us-ascii?Q?AjbXXeNwzmMck9pHXh9qXUts?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8beb5af6-8078-4454-7490-08d98cb26619
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 12:26:49.8055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvFNet3mRvjMC1TFhLVfbuVf3Rl30hVJtuURyG4tbgaQxLkY0kGlqQECFdedeYCKmnStbtAJsk4A/wZnAsbbxVU27tv9aUt/TRgGguiSzRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4449
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10133 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110110071
X-Proofpoint-GUID: 34qKHicR6crK8jSIZ9_AyfwqUIKZvtv9
X-Proofpoint-ORIG-GUID: 34qKHicR6crK8jSIZ9_AyfwqUIKZvtv9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces a use after free on the sucess path.  You need to be a
lot more careful.

On Sat, Oct 09, 2021 at 09:09:12PM +0530, Saurav Girepunje wrote:
> Remove the unneeded and redundant check of variable on goto out.
> Simplify the return using multiple goto label to avoid
> unneeded check.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 29 ++++++++++---------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> index 0868f56e2979..574fdb6adce7 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> @@ -2282,18 +2282,18 @@ static int rtw_cfg80211_add_monitor_if(struct adapter *padapter, char *name, str
> 
>  	if (!name) {
>  		ret = -EINVAL;
> -		goto out;
> +		goto err_out;

Just return directly.  "return -EINVAL;" but what does "goto err_out;"
do?  No one knows without scrolling down to the very bottom of the
function, then scrolling all the way up again.  At this point you have
lost your place in the code and your train of thought is de-railed.

Plus it introduces "forgot to set the error code" bugs.

> @@ -2312,7 +2312,7 @@ static int rtw_cfg80211_add_monitor_if(struct adapter *padapter, char *name, str
>  	mon_wdev = rtw_zmalloc(sizeof(struct wireless_dev));
>  	if (!mon_wdev) {
>  		ret = -ENOMEM;
> -		goto out;
> +		goto err_zmalloc;


This is a Come From style naming.  Imagine if instead of naming functions
after what they do we instead named them after the first caller which
was introduced.  kmalloc() would be named called_from_boot_510().  It's
a usless naming scheme.  We have to scroll down to the bottom to see
what it does.

>  	}
> 
>  	mon_wdev->wiphy = padapter->rtw_wdev->wiphy;
> @@ -2322,22 +2322,23 @@ static int rtw_cfg80211_add_monitor_if(struct adapter *padapter, char *name, str
> 
>  	ret = cfg80211_register_netdevice(mon_ndev);
>  	if (ret) {
> -		goto out;
> +		goto err_register;
>  	}
> 
>  	*ndev = pwdev_priv->pmon_ndev = mon_ndev;
>  	memcpy(pwdev_priv->ifname_mon, name, IFNAMSIZ+1);
> 
> -out:
> -	if (ret && mon_wdev) {
> -		kfree(mon_wdev);
> -		mon_wdev = NULL;
> -	}
> +err_register:
> 
> -	if (ret && mon_ndev) {
> -		free_netdev(mon_ndev);
> -		*ndev = mon_ndev = NULL;
> -	}
> +	kfree(mon_wdev);
> +	mon_wdev = NULL;

This is an on stack variable.  Think about what you are doing.  You're
not writing carefully at all.

> +
> +err_zmalloc:
> +
> +	free_netdev(mon_ndev);
> +	*ndev = mon_ndev = NULL;

mon_ndev is local too.

regards,
dan carpenter


