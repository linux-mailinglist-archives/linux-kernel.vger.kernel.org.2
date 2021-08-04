Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F483DFFBE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 12:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbhHDK7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 06:59:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:28934 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237385AbhHDK7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 06:59:21 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 174AvZTH014568;
        Wed, 4 Aug 2021 10:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=bM/khEqB/XzOpVYPsnIy4HvCZz+VBuObV5C+4Tb9TDM=;
 b=yJigW2jcXNW3rfZVQoRW9Td8w9BUOwOtG3JHCHQcgMV01pmEn3/p8yExTnAvnKbRWnt2
 a6wSMWrgbWzyhR3k2krfPDeS/QlRMiwGIj4gOfaprGrQ+zmj7BftHYaMy8IJBp368sCT
 3UiQ0V2r2ykm2Ve4D6BHZtwdE/fS89n+d8+bbs3FmL1a/B7KXuCLa65D/rKncOpN1rPS
 ZVRBhFAv9aUZnPAbYqAG+X0zXNGwt/Gge7jORWciM7k6cdCVAs33I4E3CzAKvyDSf6Pm
 XTzOYgjZnymDyXpkBGT20CssMsjtOZHpSBS/X75v5jBtFP1Ti+btSvEITcVl2Z3BioAN 7Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=bM/khEqB/XzOpVYPsnIy4HvCZz+VBuObV5C+4Tb9TDM=;
 b=gI/l2K7Z74CmeNYOISW80Zk71K7O/fcl5lPEnv+hJGvoN+sYBuXuvi9AgNBDi1BYEnTo
 nmTehViHx0DSYpHfL0S0ROTn2SjylBCmtrJrhSO2DtWvfJsgvTeJtGA+Dz9fyWq5/LPv
 DAMs3CFLEfh1Z3Mz3hLxGpt0b+qQQfR8AbjWW7tT9LOAq5/tHBJ/kH5tUgmKTCoX6It8
 JpMtkrW6WXCgoVKfxWHhBcLLpb/tA/Gvf/MQMxjWgI+UvaVRPJvKs0uY/0nqbIcSBhGm
 mMRrH6lpruKeZwk1af0edzTAVrPIj6lKpFvpZB7redBbe1ENe9ZeqoybveFoIVXYXST9 +A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7aq09nud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 10:59:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 174AtvVc182022;
        Wed, 4 Aug 2021 10:59:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by aserp3020.oracle.com with ESMTP id 3a7r47m8ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 10:59:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnO2T/ODgAZVdC/wGIEEoYCOqo6lSyPBtmTzU8LhVhctlAA9mmIeD+vco6g0SY8Yr1LziTROQaZgkxAec6Q2cmcnG8/0WQss8YMOby8EHfLBZJ/xUezv+70WD5N/gLT0N7F5Gwu7u+0PA2QBX5pH4BATJA7guWCnDV0wImgOaCvaPmrmSGjwFGDwbkpHeFl7pPJ8VOjaXo2h7PcTVtqRXbEhAG0pKRFObPAOptEHwbz00tY/VEv7dg3gfRxz+ffeZZF+A4cXjBNHTc4w5j9f99w9loofFGViJsyLzBcL8s+BhSxWpIaLhqjHOQz8Gif9uQ2W9rRYZUFjt0WcAYAM4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bM/khEqB/XzOpVYPsnIy4HvCZz+VBuObV5C+4Tb9TDM=;
 b=OAJGFlBM7JWufFB9uaxYhkFmNwe0Rl0zDzF5Yap90xy37JOhmSeScRAZ7cB1/9TG0bBtkyeYh0eyd/MY/hOVT0ZNX9vhlvk8OaSi3wLuW4SyNxqF01IDaUxdpHZEY848eAxX5vxIUy5+l8/uUNIJ4E5hBx5jt5bYQ/z5re+61TecGPEA2M0ad88cjldW6zXtFHrn6wvVKdKI5lfswfeNvPDudt3iOAZI18kIN3OaL52GatSdd+4kAiJtTB35tvwaRC4a5thnVnwnkWtknf0IinUFlmLadJDxfkD57QbCetCXYNkuA0FQlGv8d0shbYrhdWEEV3E4wOYmhAYCau6QiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bM/khEqB/XzOpVYPsnIy4HvCZz+VBuObV5C+4Tb9TDM=;
 b=yBvylEeMDPoI248fgdH5aSRrbLDtbCTDl4VADuay30FnAdW5a9pqTThIXLg/dVDg2qfZPrl8/bXldabbTejTX4EXk/P5MDt5HWTPFDNIGqq8AXfm/11RrMHX8JAfPcQOjAbUN2dbvJzlwluGcGdwQSUwiHMc/DNKHAHmHNni9pc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4547.namprd10.prod.outlook.com
 (2603:10b6:303:96::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Wed, 4 Aug
 2021 10:59:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 10:59:00 +0000
Date:   Wed, 4 Aug 2021 13:58:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Salah Triki <salah.triki@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        Marco Cesati <marcocesati@gmail.com>,
        Brother Matthew De Angelis <matthew.v.deangelis@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ivan Safonov <insafonov@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tablet: acecad: update the reference count of the usb
 interface structure
Message-ID: <20210804105838.GE1931@kadam>
References: <20210731160938.GA909566@pc>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210731160938.GA909566@pc>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0048.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::36)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNXP275CA0048.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 10:58:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b9289ee-b679-484f-3628-08d95736dcf4
X-MS-TrafficTypeDiagnostic: CO1PR10MB4547:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4547C95E5755AA2BE59FDDD08EF19@CO1PR10MB4547.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ENmWllKt5eFlHwwdr64WtCqiiiWYzipb04npqtbI0zhXjiaOlExMO+TiTeLpBr5Kt0O04NgBx7VbGGXhBwp4unDKE42M5Wdx64dzgMo0FRpGk8Js5VpTuPACzhrXurt6kieJ9EdwX6yEX/ZyrrHujMQreHFCDv7vAoElPTkkluJhQZ2IeNQiE6MkkydgVgCcwNVczP4olVdbkgPvA/ie/OeYFlHJUKZt7l+ZBOVVwqcpn5ZoiprGqz9L05dH5RGi1xdNX3xr1d/dLK/cdJIewbUDq0ANOQ8kI04lef3f3hBk4SPbKoHnvbTQkWx9Gvz8+kIItvUt9I38FV1rTQ4HCa1GXkBt39l4gqE9w95KvUN0t46ZSa/MlsHXDNjWuKvSTJuORgeiAwO83j5cSCSQTLpOROR1AGI2J9k+TEyDdQSHi9A/pmm7dhNvoNCmuinivTt7/MA+unKiLe80S2dLald0zI0NcbvOrW1s1uM/6Nr+7BzBdaEgrjlcDaDhbRXUQWV20cQDkxtnPFEZF4W0oZBK2/PhsjLg3hPNDMHVSsNKFUSBp4YnGRdYkCny5kostLcH7UiStB2Ms8h9iJIWL9ysZIXwbsiPxozjS1l9B2TGG+nOwzeGrVOvEfyexCy0c2Vh76aOZRDzRKXrBqSFotG9CMSgJphhr6MA0RymOpZBImy7wqmfANGpcLVL7CQYe3dcewjhVN+J70Ub5c6CAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(396003)(376002)(136003)(8676002)(956004)(4326008)(8936002)(6666004)(478600001)(316002)(9576002)(54906003)(33656002)(38100700002)(6916009)(38350700002)(83380400001)(4744005)(33716001)(6496006)(2906002)(55016002)(44832011)(26005)(186003)(86362001)(9686003)(52116002)(5660300002)(1076003)(66946007)(66476007)(66556008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jJmTbn/+tX6DJKULD3l+lPdoUzSn0tIr3NhI2dM58t/JU06X83s92t6M4d26?=
 =?us-ascii?Q?Nqq36qljXemQ8hKW7Ls5KCV694L42gGo7xxS665yab9ygB6r9Vr9kdVnx1Jz?=
 =?us-ascii?Q?goiu6QsrMX29tVtjVRYjKtO2Alc4AKYEGTZ4aKpqsQ6rA222ax3+L671H5cW?=
 =?us-ascii?Q?X6QcmAyBlBx1i9ERkYI+ScFgIBdcUIp0l6Mpbc+puO2YHQeyiCOpaHZR8yjP?=
 =?us-ascii?Q?JUqGuibq3QhmFxRWUDbj8veu/IbFNicDF83hilMoIb7n9phujSSB8J419W3u?=
 =?us-ascii?Q?oOY5wRHU59+MyBZue2tObH7Xaqrjg0zvy3HPlUAUUNceM+DJf14znL3rd56H?=
 =?us-ascii?Q?aeBDGq0RmbcwBKzCFVZFjVIOQsKZ/lszICPT2o4xCSVootZIJN7qaL1XyEVR?=
 =?us-ascii?Q?ocXFj5wtbhNzf8oG8Ok66OGT9Cek51PAB1ASPbYEF04mNAw0GGkVcrqc/adc?=
 =?us-ascii?Q?p/+J2a8ynrQZ5WlSz/RA2f5XPJ02czAZo8IfnCK2YcYtYmI1wE6vTS5deklE?=
 =?us-ascii?Q?ZFK3qTnPru4ltG3jmcB/5AZJY5grmk1qOozAWEx4bV7n3qs6LLA/ijpSNWLy?=
 =?us-ascii?Q?+frtM4SylkXxUXurvuYRBKq7TZqqR82Ys8ApZ75HvfDs7IG8s4jYD2GPhrdI?=
 =?us-ascii?Q?OFz4cY1X3NGNejWRrodU4WLxyP1r68ammU8AQ0HPSlVqFvtp4MY7cglN74HW?=
 =?us-ascii?Q?yVNokTzZjztIoXUbh8IkO/WkY4yfOzEHjwZSrxV71dAZGCk61N+kHO0FgpYj?=
 =?us-ascii?Q?/+mQZOiBRHIXCB8XNtUzFNsKrxZyYcpQ2H8ivXRPESiqj8ZlWLBX79Li9gog?=
 =?us-ascii?Q?ljVqD7ETPipKecr6D8UmdHnp8EPXxz21OV2R/qsqQF4Q1LUXYVIXAVyXL0Hb?=
 =?us-ascii?Q?G6e4SKU6gsjfBeC+9fgGIM2XHNyxUIWOpb9Zq0M4biKVpaOXnXZ5UNB9d770?=
 =?us-ascii?Q?bs/443vamT457PSLAgD/yFNP1GV7y3hSW96EggGFG91SjkakziBzwr8FnA8v?=
 =?us-ascii?Q?k9cotClMJfqbzBcXgeOfsyTGvf84pJsKmwnLa0HCx2Qtc/K3fMkB57Frfo3+?=
 =?us-ascii?Q?2Rm/d3+bzODugaVkc8eGAEnxoe3GhENrQHDmwliRAalUdfhaSk/ULAe/2doY?=
 =?us-ascii?Q?9Gx1AWWWpUL4NvTY0rSX1i9gqgA+r4N2yBN5N/9xz6llDN0Q5hoVHJSNQWfD?=
 =?us-ascii?Q?GtfOtqBqj7O0uQS3n5POEwLAc4s74WCy+Sx9Jk5VGSQOtl++khlSaEV1xVMM?=
 =?us-ascii?Q?GYnbFc2/wRCOscIIF92rnhm3+IEDfTtZ79r7I0AL05MkOvhyCLMZnuxfX++o?=
 =?us-ascii?Q?OGeN2r7kE3DzMs0XG9ZhG8M7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9289ee-b679-484f-3628-08d95736dcf4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 10:59:00.0935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qKVaM7TBE6xz+SyevNdP8WVPEAZ5PE8BwI8xesYEVtnH/q1hFzzHXlUjh47Yt72pxf4Lx7RdEnYethM+yAA0WiJ0c2HDY8SQAbA5VaJ2bU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4547
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108040056
X-Proofpoint-ORIG-GUID: EXEF5CHbQH8Wm9z6OsO9-EF10JRKmvrY
X-Proofpoint-GUID: EXEF5CHbQH8Wm9z6OsO9-EF10JRKmvrY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2021 at 05:09:38PM +0100, Salah Triki wrote:
>  drivers/input/tablet/acecad.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/tablet/acecad.c b/drivers/input/tablet/acecad.c
> index a38d1fe97334..85fe134a30ee 100644
> --- a/drivers/input/tablet/acecad.c
> +++ b/drivers/input/tablet/acecad.c
> @@ -151,7 +151,7 @@ static int usb_acecad_probe(struct usb_interface *intf, const struct usb_device_
>  		goto fail2;
>  	}
>  
> -	acecad->intf = intf;
> +	acecad->intf = usb_get_intf(intf);
>  	acecad->input = input_dev;
>  
>  	if (dev->manufacturer)

As I mentioned earlier, you need to drop the reference if
input_register_device() fails.

regards,
dan carpenter


