Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900084220FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 10:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhJEImB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 04:42:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47038 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231816AbhJEIl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 04:41:58 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19585APf029448;
        Tue, 5 Oct 2021 08:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=QOS2UfD5+Xnte1lsH6cUptsfuYmZjzy4Pt0RetUIgT8=;
 b=cyunpQDJAn1CSWqaQIlDiAnv3UERcmATerTQCvcwaZtI2r7jsmSpka7Bx6ZA7wm02XvR
 F4/atgVW79S18reuxCrDvShr4Fk+SWmq6bochrudx4EDxXm7T8KzTxlwsSBjEKY5+Kpz
 /SXOdhLVLyWPLb0/R9kERTp9s+JckTf1eBId4N365/chWw8LyNCIpHjdSfwjPazhian0
 CNNvuWDFYQ/stRwdrEwv91My4P5Xw2DajrtyVIF+zzlUN094A6oUklG+Q67Yo23Oy11X
 UfmDYrdvMcC7qiNkbUtlBSpVaURQXFHg45I63HYMRIjUyFekoU54W432f8iErdnbgxzj QA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg42knrc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 08:39:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1958YdVZ099471;
        Tue, 5 Oct 2021 08:39:57 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by userp3030.oracle.com with ESMTP id 3bf0s64g7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 08:39:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOo1KpBSlXfla0vYemAvgY3auhHtyNYD392OVWaDPcYZoL9ZElM+8c4pJDxdvWtQ5kl/O/Pf3WgOl4eKkux/B8rZYvpjGCYu4gOx8rfLC0RBqbUSycvGJk1Rt7CnP0g7XQZxpcQeBTk76uaUByhBDL0KL4lBfB9vWIgjyk4qBFOdHtwWwMa7owJ7mYirXbwqsw6L1qEMbJ+Nc509eccfOK1VL84KmaxqAJkh8XgL3s6CJsH8RYd2/5IH9W0bw8B8uIE9EzmVRci2o1hmc7r9Umq+eCJ6HF9uOvXZ/WKH5APjFKvcwcWXbQmSAlxsEnSJq+iqGtsjVl8fHX43Ld2DZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOS2UfD5+Xnte1lsH6cUptsfuYmZjzy4Pt0RetUIgT8=;
 b=II5wKpSAe6i0xc6VkIal9FfU4qm6ciRmIcU+h+vkGQ/KBEx37DqW72K7hC52FAecMkoOnaPgt4ulAROPXQcm/xE7bV0Vm2bQaIKJ4/cykeroSmRD/2oyAbUsolnv45PCeL1TDzTrO6clzrTYnSra/YGAkQYNVQPCaktQ4jRR/imhJlDi193gdvGe0qxHL81RMf80Rcwzm8oHjTTbwEuA+vlx1vtXkgO927wrfjb4fEjFVp/DynJaxVaMUM1k6Q9kbvN16N2/AiGMhDy10Tp5OBtkOky2WZMizhh8Tcs5HrClyx344BpkGXjaTTG8MTMCATTZBi7n8pQMsOIADj+HNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOS2UfD5+Xnte1lsH6cUptsfuYmZjzy4Pt0RetUIgT8=;
 b=F0xTBkiq5hHKDxWyexIMzdYgPjfSbp1YzVI5xyOSf5OXMs3DuCUfvba3pJLTho9o8+ymSTH+2gvenBTDSS02q3IdS8Tr+kOZZj5SAOSx8C0i8G/FvlmSS7RBK/qv+ShrVHUBc67Jy8Nv0xB2JbbwRkXPjPc2CHFQqyl3aW1U47A=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4513.namprd10.prod.outlook.com
 (2603:10b6:303:93::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 08:39:55 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 08:39:55 +0000
Date:   Tue, 5 Oct 2021 11:39:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Yujia Qiao <rapiz@foxmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] staging: vt6655: fix camelcase in ldBmThreshold
Message-ID: <20211005083936.GW2048@kadam>
References: <20211004223200.70524-1-tomm.merciai@gmail.com>
 <20211004223200.70524-3-tomm.merciai@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004223200.70524-3-tomm.merciai@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0046.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::34)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JN2P275CA0046.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 08:39:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faaad7fa-8ac1-4c90-81c3-08d987dbb4ca
X-MS-TrafficTypeDiagnostic: CO1PR10MB4513:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4513482505701B9C39E28CA48EAF9@CO1PR10MB4513.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:586;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D340Gz6360FeIG9IflmE4fjDO75tCl2aCjKNndMPvhglyXTQsBXOqHoWWAMzp4VthEPyCBwWP5CaUUheM/3v0CCAwpekP5Yl0XeJQ68Xz1wk3/K5fW/9LOi6K0vZkulymYm+OZtOBo+D/M31pmhicrhuy6LMZGCvwo3C+zZoHAr1d1mMONbo4sp8HDxH1/nCJGlG2xQ9xvfYMGKbNBiBZesOFzFHZgrrLW8uyGae76pCMR9w3e3GiJkYgDz3S383//K5xhNRU5dln0O1atSpUJssZIzQzLUFdLTcve7BEwpCkAk+VXFd55MKVAiea1vvGjT2CkW1kC4bxceH49HyocZNcyPhrjgHZwy+FF19RlBp1O44E9mXAZY8Ga1WtWKPSQfQpB1ooD96hfL7BpsYF4MxzB7Cx/HVnpmg2dJC/l2fuK4Mrhb8MvWOhW2rhHoVHj00LCwgHXtIpG5ZnGXp5+QWo5I3aVhH60mFOSVpuOVXmUOBeY3nwL39sAvkYhwdtbVm/CPbJf+/ZtIfh9uqwmVB2ESjLcaiZdqw+71yT9usAwKL8rols4aJXQTNkE7QAkBIEXRTQCDFY/SqEFcoBo40edITjVzqePO5dhQ1TN/e8/eV5Z7QcCMhNj/yTv7ZRUvbZhx3e/QLzw490ZcDxUplMd9bkB7pWIl6fOUtJrawZYU7G9T123UCdrzVeeSA1jT44YOEdMAMfMAWH40Y2lxlxyisOnZpDa+WoCr4Z3OqwUnKxiMqRh88XDQ3iDSoNxtcrvIIOkIoqqB8h5Qkm+AY6cHPB3Fr/G4lKLce4PTWTOIwAzY8eGllUEm+5QfA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(366004)(33656002)(38100700002)(55016002)(38350700002)(9686003)(508600001)(966005)(86362001)(316002)(4326008)(8936002)(8676002)(6916009)(52116002)(186003)(5660300002)(7416002)(26005)(6496006)(956004)(9576002)(54906003)(44832011)(2906002)(6666004)(4744005)(66476007)(66946007)(33716001)(66556008)(1076003)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bEGjdx+9QFFtC6R1c8vBijNdvf9pVwvTp2mMI/g+cGeT5PyxtwJ1ijVI7Brg?=
 =?us-ascii?Q?49l7EHnsBqUlDpV5xZX5u07YutNsshlMpE7dBkrjLugRNkY45vFh3a1n79rK?=
 =?us-ascii?Q?jctzq421HGqU+SRdXZwavyUHy2qhE9r6KU7x+uqLlvHcT4Yucyex5HCO3rfs?=
 =?us-ascii?Q?owqlXyujZL6rfivRjSAesfpUv2l37mSKz0QjCrP0NVUYZ+3Hi2LI0N8t+fWq?=
 =?us-ascii?Q?Xj7r9oNIeJBEX+6ngF8G80zQ83eTdJlWWKo87tdgZJDyt1cKyvZmyzT6BOSP?=
 =?us-ascii?Q?xCYMEtsAEW5hFjjgaQbPF1YgHYAXI5kX6wuOuUkydctwjCSwBT07NQ0e832m?=
 =?us-ascii?Q?z1ydUx+85U746vkpXTYLihZK644CJpCUIaLfN9qc6TGYH70FpxqHQhGAa5yu?=
 =?us-ascii?Q?A0EmJVmfYQtADCtKDK5MClnEUPqTgJR0cg70PZPF1slRX+tYnccv+rdTIj8+?=
 =?us-ascii?Q?wvgTZmwUiHBO2ZoQZ/unKDmSkwPAKR53sbq6a3KXaP7qgIXzLIGVm7b1gl+w?=
 =?us-ascii?Q?YIyZEIfHnHcH3zaVB9zgIFhXRE0ssV9V4KY4wNeNlZ6rYtzJhhtmdDSdO1hW?=
 =?us-ascii?Q?Dbq0v5JRB+YI8xJPcejyZ036qRFbneSvj3SXmGRlg8qRMZMh6PsWKKs2FO+m?=
 =?us-ascii?Q?COrtdYzHujK3y83RcUuIrH5FfHclS7o9JQv+glcyY3Cjc5GWnggUKFxAWtIf?=
 =?us-ascii?Q?Jaj3/bQzKywBf0NtwIICdRoCV5hL4koh2otcj7K9F2edA2Hqsxg7pHJhJ64o?=
 =?us-ascii?Q?q6ZrebO8sqfcCNCJFF3LvehrwYK96WzO9D+CjVUbJ9wiUfdnr28RQoNvkXKg?=
 =?us-ascii?Q?SF1XStIVeZSnTqGXrwhG0BLQ7vk44LT3z9lKOHiIVlWki8nGoXQ67DBfHoIJ?=
 =?us-ascii?Q?sEP8SP3FTP73ZlHMdb1dgYKoovNsMOymF3f4dIqYB6anDhy/gqNu68ojrwFE?=
 =?us-ascii?Q?mCiuk4JxyO74j531ubpnRd2/b7zRolFIkxn6dFoM3osm0/IhKQiqlph7HWgv?=
 =?us-ascii?Q?aYFF9GzyqtgjMOFjVFDthyNfbF295v1+2hZRqKdklVviWvCPDWHOz0u/FyZX?=
 =?us-ascii?Q?xBapQB0VXtdjv8rRhrJ6xdYDo6s7o1Ti8tg6z5BjFl23neigChcsyJLmh/l5?=
 =?us-ascii?Q?u/pa9WBgB8TRYw2pzd4SgOAGcZBSjH7fB/hDvuSUqpECzdE6hNd3KiDD4/Fn?=
 =?us-ascii?Q?7KVr6tR/Fz3ZCIS4osffdNF6t7dHncL/HbD5jLsD2DRLCs4b080jv0KEYWZU?=
 =?us-ascii?Q?CZ/HuYp2KoJRQDT22hGKs0cb/ZkcHKKmo3OH4rWmT/LBVXtK+qYO5t0d4QxC?=
 =?us-ascii?Q?0cNVll2RUXVzWhyURsLoaE3s?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faaad7fa-8ac1-4c90-81c3-08d987dbb4ca
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 08:39:55.6450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UaZ5b2Xe90XqVKX953eVk4qHXQIvlCkngqPqzOB65mJjAdZUpTlDrrNGTRt/w5u5qr8QVTdQvoVP5lKG+xEh78m1ojS/UhVi+UKOgnyCXNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4513
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050049
X-Proofpoint-GUID: d5N4sMJiFKF0WWyg8cSmRpxAFHjhWWCB
X-Proofpoint-ORIG-GUID: d5N4sMJiFKF0WWyg8cSmRpxAFHjhWWCB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 12:31:57AM +0200, Tommaso Merciai wrote:
> diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
> index 49e3d09480f2..e74372263e14 100644
> --- a/drivers/staging/vt6655/device.h
> +++ b/drivers/staging/vt6655/device.h
> @@ -215,7 +215,7 @@ struct vnt_private {
>  
>  	bool bEncryptionEnable;
>  	bool bLongHeader;
> -	bool short_slot_time;
> +	bool bShortSlotTime;

Trolololol....

https://www.youtube.com/watch?v=2Z4m4lnjxkY

regards,
dan carpenter

