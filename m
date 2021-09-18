Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B1E41044A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 08:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbhIRGYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 02:24:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:5220 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229476AbhIRGYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 02:24:08 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18I3TQqI018506;
        Sat, 18 Sep 2021 06:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=RCR1OQ4OusKpD526dekK2ctOPw3g9M3KNuFGFLAA6BQ=;
 b=uywpT2fk5dRlUu5nVjO5pw+lIj7WiMkPLxTHFcuOdkSULGTQXLpNAzRi3BR28Islxzo9
 J9YkXFXlHIEFc2fHHlWNbjx3rzgktchsph4oUsIQ26HK+usNaKqAez3/+5z6QdoKZaIF
 1AsqrVdS3n618XcWX1Y7DE8GO1z6WWVWe9ZYnNgXVu+v5rh3mxAVb2HOYAds5E2nPZQj
 sd/yd1qH8YgOiMPcRDDE0jS2KUwn4LIV43bzhgy6WHNKG9ws+hhRDwND2yP8YNFPIZd1
 rxc1qSY6nrXda+MSO5nMy+H8UOU41rDPwNyjOKqC5rogDwdOfHlNGNdN+G6xE9By1o1G Qw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=RCR1OQ4OusKpD526dekK2ctOPw3g9M3KNuFGFLAA6BQ=;
 b=RBDieF5bB/JDRA2Y+fym0agpLQPRBt3jd/ORgLILEWkYfS656ANeGsZCMIgu425P9DJp
 uRTqQM+kMmyuSaQGIzw/ruVWfB6bkspd+oe4v52QBD1UKO7hPiTWk2UK0JSUbZRKQka9
 Otj57vFVZm0J63dVzBEgw2VZevzhmkI2g2ecSJaTQTSsfaS8UXcWNf8L1RVSC3xtZVAb
 41IG+EORNmrBBhRioiiaD4F1gxM3ZWqGO6tNbIgwN8WgTcvZL3hrRm0BPM/K1VWuHWdw
 0RU62x4YikIpegF+gcixB7155+QZqkmhLBT2Z86VFEgtze03c9qqOmkpuITQQrmBc2fN kQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b5809r7p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Sep 2021 06:22:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18I6LJ7l007362;
        Sat, 18 Sep 2021 06:22:30 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by userp3030.oracle.com with ESMTP id 3b557tg4jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Sep 2021 06:22:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZ5EWPqor8xhySc9n9KKzmZQvbRnJoOqmw9FtyHJSlTtuBp3xG817hawhOMQLmry6gah65OH3KNtISKdVsQjHPEhldFlJBHBZqj0ZS4nY1DmUzYge3oQwR/hKvqwa428Vot+TaNv3BT1pyn+3Yk6YBrJb7m9CcfHn7whS/ieFZPKJaZ6MbhwneF1A6zeqtgRbztICajnADlFknJhlBelX8SUD6wTSkD+b2Okqfrns9LkDzhO3QvcRax8I5zeylDGXQgAA/JIT0Ip34xWTKgUURKmPqqDV30PXblMLS7+j3SfW/hm0/gY71Iov2VCuEvHeJTeGPxZfUkC3Xq8BQ8f/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RCR1OQ4OusKpD526dekK2ctOPw3g9M3KNuFGFLAA6BQ=;
 b=C/AccoWNITTgl4BYaHEWP+lF2H1SWA07UYppQMIzaM7gTwlrdqtL1EYpWdLxfJ77YcoXn34wcUa3Q3ZW+5N/b7AVkolR0IvDWeieePPnPRomAgw5EtsHhDnU8hTiW0NunNFfoZC9jJQGKuQ1dvSHDs2RFnB8Pc6Nf59UO6qRq7muQIH0uAdMnuAXLPufzg2y6u0io/CR11U0ABjqoV7Wbu7PuUSSTwYWaocho1OLAIOy/gXqQgcHoVNb08H407f1oN8muX90Ob8bB6GX4CRbmb4ZwzxeHrsuIwgI1ShwVT5HAq7j180Bp/QjCfLGo56qNxeATEpBCzFs6sgW6jJT7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCR1OQ4OusKpD526dekK2ctOPw3g9M3KNuFGFLAA6BQ=;
 b=NpuVBkiJ+fogMdwp2Bi9LkrRfOoYlNF34Oa+4/AxQqiz8/khybxQIWa9ewSPM0Yc5uBe9Hy7ALuAX6JwIHn53n/nVRV+urlYQnh4MqfBUbdNO7AXjlWzz+hs1NGcIcvnsPQAIUmKJDHvOIs3M+BwknbzpUrl8r9MIkLWuRUZaek=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1664.namprd10.prod.outlook.com
 (2603:10b6:301:9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Sat, 18 Sep
 2021 06:22:26 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4523.016; Sat, 18 Sep 2021
 06:22:26 +0000
Date:   Sat, 18 Sep 2021 09:22:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     cgel.zte@gmail.com
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        martin@kaiser.cx, paskripkin@gmail.com, nathan@kernel.org,
        saurav.girepunje@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH V2] staging: r8188eu: use ARRAY_SIZE
Message-ID: <20210918062206.GN2088@kadam>
References: <20210918033910.237216-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918033910.237216-1-deng.changcheng@zte.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Sat, 18 Sep 2021 06:22:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bd6d8ba-a85f-4729-2f02-08d97a6caeeb
X-MS-TrafficTypeDiagnostic: MWHPR10MB1664:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1664BAF67DDFDFAEF52881F48EDE9@MWHPR10MB1664.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2n4APF8ZWoZjphJzPRj9XGXN/C9RGX58dYg2aOCnQzkL/+5OLv+DNxk3EcGY/wYnD9YXxRjW6vaoJj7P/NPMonDObrGPhB2xzN3arlHcIDZVbSQytIrChHejr336xoh169Mp03S1M3OQs0u0kMuS+W6uECW20xX5m8VzKv+mIO2BUrTNSEDgUS39i31eKCYM0P+Pw01JTVOk+5gQqaSF3NgJNDAmNSBLlIJstuBUt8wrKXPIsCd3DRYo4welS2mBYnf7vV5qYSY6If6he8xNrV90gAtIuZBFaBOZ98q88X6GkB44t5Yg15TWbMGgMorXh8R0UjHzrSbitc7ZnhywVdnat3PmIwW+BxpV63Hld7hWdAYbHBmQu9aRrc1QhFbXESVJPjJ1hYlIUEPtadQApfMxWgpcLDuqzmf4baF0T1fs17NRO8dkbc7SeT+p2jS6oMeS6T4/SHR9+Qxj9o3d4RAKKYYF+4+iDTU8cz0gtcd+PyAVtLBLd/CkEkPHIFepFJOJsoW6wGfD3nAUmbaE3w/qOWXeUkyr2fMlEFTOVtzhiC1L+5MWeKkA+3LZlAud6f+pR42PIr+CJebEjlfnKMTZ01+cCWk2lCPN6Q93ZoIYaBV6Xbctpl9TbKHxrkmvc41fOVN5t7+AvwuTTDPySXbm25AMTL+76E+cp+8KKHyJPwJRx6dHoKkvF8YdZHeFzI9c0EELPJ+BS702kkFIvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(86362001)(6916009)(2906002)(316002)(508600001)(8936002)(83380400001)(9576002)(66946007)(66556008)(8676002)(6496006)(4326008)(55016002)(9686003)(1076003)(26005)(66476007)(52116002)(956004)(44832011)(6666004)(38100700002)(38350700002)(186003)(5660300002)(7416002)(33716001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3DOSQcmLw1GUk83kzIZ2BsKEoC4m1ICWT8+b+zOMEkrn5ahfgOKEUqxnzdVa?=
 =?us-ascii?Q?5qABmaGe/KEx3pVsnQUdzT/mxZLj0GZbsxBRQF1DXRWWMh2FfLl2RK2o4aWG?=
 =?us-ascii?Q?nXiqn1elNDy27pD3/mjxUuRblwHnPwonrfQtgxBOXImrqaaVqZDNUCZeoWZW?=
 =?us-ascii?Q?9tZ19b4u3rjLui3panV8tOtPnjo9NzGFmHIsVG550Sb/RwNUo4RQ13qcBo1Y?=
 =?us-ascii?Q?Tysm24QrB2/sOSGFskDbdS3NeZUEcmOySVAi7iHCLtQ72MTRqP27bkDuxm+t?=
 =?us-ascii?Q?rgIuJ3+pzcuWKxA17CA3MgSJD7z81yNbsnZ0siwez7OYlvbJtEhytxJlWcGe?=
 =?us-ascii?Q?/jVByrA5yYVhh5iZvDk4ZO5+h09d7gSthpBGDcWiHGek3z0tXYJaYMjFNe/g?=
 =?us-ascii?Q?4482KORTqMDfnbAWJHVFz4C57wpTP2zTwVYQ7ryeog+fXCvnx3tEu1TBP5TJ?=
 =?us-ascii?Q?Tz6yr0ZQnTSjx6FIAfgD9K8VN/rE4nl6Ocs8gnwPAwOujsVtbPNpMNEcex1I?=
 =?us-ascii?Q?6ZdD1VfPkFvT6l9NsZ3vUJmzstHtHT3r3SiaZLE7dwAFuZvlUqUkEt5HYC22?=
 =?us-ascii?Q?y/wTgbYHl0fqWyp+fqTfMo+ydUBP29MftQ5NGUeKzCkrFJYH9DKBdVmIBt+H?=
 =?us-ascii?Q?yqsqxwaXmqbf+vJW6k8r2L74C6rzF4lQTpJbjwofGbmL18IA34Gj53VLX/Pi?=
 =?us-ascii?Q?D3Lpy04D8a9MdOoW2D6/HyE/404CDwKFGYIMRhX/isbtfSy0zCUUMOk3Iauv?=
 =?us-ascii?Q?sgBj/DfsRqHeFCvDPIlo82ETY3BKLvmqJQJAUJDGP8WUUE6o1aHa0y5krliA?=
 =?us-ascii?Q?F2Lp4qSU5EMfOdqpuntFqpz7GRnHbjfdunD36QYYntrS9p2lZyfOzD1IB9oR?=
 =?us-ascii?Q?AzoxTiiOPxd+1HC3cXmuWTM5mb7MSVGT9e+n6SlS7sZeFEJ2aAtki0ZNWCUy?=
 =?us-ascii?Q?ZxKNNZ9awiXNJ+wcp4d1sSbwJHVZFTlLllJuiHuSe1PmN31DELxu+jUCq8J3?=
 =?us-ascii?Q?HdBo1up0jDtbCRNJf9gGyXAZDT+8/F2HYiMVsqX1F8jUUloCrzDMchHLS52v?=
 =?us-ascii?Q?2gWpg0xVLZ3XjKAdahs0FGNcpi8ClV90C7fCYQkICMcvypw4vt6NU6AvZkHO?=
 =?us-ascii?Q?OzAuMtYh0ebYIqRQ9xdjz/ITkXGFy0XbJY5mrMrRuKhDiO3nCcWxkrpMJzWP?=
 =?us-ascii?Q?rX7PGmKuFSU2zonDXv4Vcn9dPfqe7NV5J7dqCFI7E9f43EgwJQM5xLrFlOEz?=
 =?us-ascii?Q?ZL/gsNKKZn+ePD6kPecMAh8fIi0Lwl44LjEMzPCYfXtHfFsiRXehtTEr225e?=
 =?us-ascii?Q?lJ3JgdFFy1+jOWDarsCOFD8l?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd6d8ba-a85f-4729-2f02-08d97a6caeeb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2021 06:22:26.1130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jsj37+jzmMcUBYKBN4iHuWmw18DgoumxHRmcMRxHhbxNAHskr7ZDlH9/L0Iyu+HKoj8ZS98G0gFOWqo0c8OkTU8qLUYuhSbUamH6Hj9QAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1664
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10110 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109180042
X-Proofpoint-GUID: gvcKzwzKj33KmW0cc5XYO3mwq5YNXwlm
X-Proofpoint-ORIG-GUID: gvcKzwzKj33KmW0cc5XYO3mwq5YNXwlm
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 03:39:10AM +0000, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>  drivers/staging/r8188eu/os_dep/usb_intf.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> index d04d2f658ce0..44bee3b2d0ce 100644
> --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> @@ -261,10 +261,8 @@ static void process_spec_devid(const struct usb_device_id *pdid)
>  	u16 vid, pid;
>  	u32 flags;
>  	int i;
> -	int num = sizeof(specific_device_id_tbl) /
> -		  sizeof(struct specific_device_id);
>  
> -	for (i = 0; i < num; i++) {
> +	for (i = 0; i < ARRAY_SIZE(specific_device_id_tbl); i++) {

I'm sorry that I didn't review this carefully the first time, but the
specific_device_id_tbl[] array is empty.  This whole function should
just be deleted.

regards,
dan carpenter


