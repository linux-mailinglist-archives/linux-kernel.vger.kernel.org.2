Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F6545356F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 16:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbhKPPPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 10:15:43 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:12992 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238158AbhKPPPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 10:15:19 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AGEG80L013942;
        Tue, 16 Nov 2021 15:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=epUb2VhTnej1alZUn7+1mPcostWw2FEQ4ptnOAQWVrg=;
 b=V4YgEkLnSWlJFohdtWI2dD+HsmV2ad9pPSaSR4B/VzcN6HkSpi7ioRvcVq5zPU+DSIwK
 I0fZJF2eBhJJQoPDO9Yv26FBJ531GpWnHfTpJSX7pxF5My+iwckFUzK/W9wHmIb1unvX
 EFqEumCsQNpQophuhoX6OkNGusx3oxsXr9M0F2FdfNUaFcn0sxrPNi/IUjgj/ElPKDKL
 l29Es1WMNVQ+6GQL9WCyw0jNhYG0poIVfH/RSivCROEV9SOgfhBqYZCH2BSLySf0L+8o
 INx4mkKcpal3ui7m39o9vjRPalpTWOQJ6eaF7WlCdmeI7r6D+dg8ZaeYA5NRrd1UJ8yR WQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhv5a3gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 15:12:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AGFAd9I161538;
        Tue, 16 Nov 2021 15:12:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3020.oracle.com with ESMTP id 3ca565jrwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 15:12:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHFN9azs3WgRuHEJfkMLKGHYcg40gUtBasjd16XUHrGjSrhEs8BU73i1EMzROTMCi+f96qY5cuHre+GU/0xAEhdTbxKffA/ZkezygMRZG07mPtLQ9fSv3u/DkIYufVVern5eZM628Kqi47XDm4c8BuPXtArd316+Pp/oAHwxQJPS9pcWHsauHdLBuA8nDmQCimEuS5fidf7bKfftXrhvYnmagksGpbd/2rlpw4WBEmPOtvjcNQdTJpvUtkXgoNZiS3Nw8SoAbj6ni/PlLkihcMWO+dCgyPk8jtbH/jUoQisYbKKGPR5+iKrZu1URVob4I/XRxYt4RUVdhfQq+QU+ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epUb2VhTnej1alZUn7+1mPcostWw2FEQ4ptnOAQWVrg=;
 b=JPJTiznXtglRws/ALXTBbIpek7XFDs8wT9IsBxcxdob4okIHuuRm/mZIybQCPYVdk6GhqPv4uUuUAyIu6Nw8HSB+KbSVkwyM8bTnEJCsn2qFfdZGWHwLyIaNLS7dkycuV6Gc9s4Dsi8FAA6Hzjb27qUOhEUInQkaow+k8W7aS5abfJW/STFveSl02tNsekZB5p9LspeJ2vSqQNNknr7Ge+c97dDINWl/EDzOImDyfjze47PtWIV4cLbG0eRsGb0jR0FPzaLqr+oS7NAxdTQBsAD/GBqvelHaVuFeFfveakwDqWvKNUUD/dhxfnqWca6JDChPfxHB0Q4GrXbQkkxhHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epUb2VhTnej1alZUn7+1mPcostWw2FEQ4ptnOAQWVrg=;
 b=JGQjQ1wYp7kMDyql7OxByQCU/t+A3qUFsnyRfvYmJR43AyFFn3qCr0O8UAwOU6E2PfK2wIu3rRHLvDVu7vTCgcOAL0CdjVxMmTBv1Ifq38dtjUydHx81ltR2ZTVA89zX0tNbkyQGr8DjHrkKoqV3TkwdW0yLf7zmZG+P40JnZ6w=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4721.namprd10.prod.outlook.com
 (2603:10b6:303:9b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Tue, 16 Nov
 2021 15:12:05 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Tue, 16 Nov 2021
 15:12:05 +0000
Date:   Tue, 16 Nov 2021 18:11:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Zameer Manji <zmanji@gmail.com>, gregkh@linuxfoundation.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove unused defines in wifi.h
Message-ID: <20211116151139.GJ26989@kadam>
References: <20211116011451.896714-1-zmanji@gmail.com>
 <6d2d9c4a-3f05-1d51-42dc-b1ebbb4aefe1@gmail.com>
 <CABtXzjSPNxe-n9QTujMB7=CmhqPFp8V2e86BXmoErWm+6c5coA@mail.gmail.com>
 <22a48290-814e-bcae-81e5-c23e6310f8f6@gmail.com>
 <20211116141838.GI26989@kadam>
 <a072c468-f9dd-25f4-70fa-535cb7196b13@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a072c468-f9dd-25f4-70fa-535cb7196b13@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25 via Frontend Transport; Tue, 16 Nov 2021 15:11:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb1ee596-55fd-4406-7d48-08d9a9137316
X-MS-TrafficTypeDiagnostic: CO1PR10MB4721:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4721B1A7688C261363C69A248E999@CO1PR10MB4721.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uOIPoi+SpnCUgw2MtE0e+RRu05QmpIjClmHXMzaq0vZuavv1pxOO809Ydnus3UmiB6UCwzf/RiXrrtr93rk5G44ny5Rp5HcHwgSWUhrgFmY5nAMAQUJbamYXMfr8TN+0IlH7gzhY4D4fsWpTtpG+41oTx+ECGHxIJbZLTxm4cVSh/AKTtTOneAi2Rbvc+HF59g+ajlOnn63D5vLJgVj46+eljiz6USXnGpjHi5LyhlndGR8/QU1id244EQQW+8c+nRKkFbLCBJ8PgMPDcYet/OmlbVEWU5NxB9ivkotRO/B+5cU0ZLER0QTOLGcg4+ngYVTYQ304EHz9ZRYVbLrdOcTX5+HnB5YZ4yoNVE4OBD5Jen6M7iGqGSGFO6lHt2tcw6gHI6RBcgMnwIiCzCu66vUL57SZQcKnFYYoJE01XLfeJVqY8Kj1XdllsBtdt4HAXOPL5hkZpIOP4U84cgqcrXUTnqbo2MoVEEbbnL+BKLdBxgnrrZwDfe8SyzK/PQxKVRwoidu4oLrB6C+znYQQF79k1edQWKO5FQDNSGg08Q5RAIPE2KNFqJz9LugWI1TQ8vBtz/6PTWHYLIql+aroirklobGd4Ip1gysY/yIHXblQEu/+xxN6qEpfLMLhWcZhQlo/yAeFQIT4sXAgtmX52yHHIJWWNZ3GTcIFzoOa02elcqkQ4pY/TCYYWkNgq+UVghGT7CRNpVRAURQlcFY44A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(53546011)(54906003)(66556008)(66946007)(186003)(6666004)(55016002)(86362001)(956004)(2906002)(9686003)(8676002)(66476007)(44832011)(508600001)(4326008)(33716001)(26005)(33656002)(5660300002)(316002)(38100700002)(38350700002)(9576002)(52116002)(8936002)(6496006)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cVk4uG7KQFD8nZda2uC5PpEQ2EDFlIOJbDD09NVGrWFXlEp4ei3+A8e5RLWX?=
 =?us-ascii?Q?KV8G1VqSea4a7zIK/gGQQkw504KDYYnSsSGWOhV/k3aPnblgRwOGuE0CjJWh?=
 =?us-ascii?Q?llg+8m2YzcLgCCV/pWRyvDgsm3MTpPBmSUdL1Ygc5Z/S1FVfpm1vI7B29o1k?=
 =?us-ascii?Q?HAlVxs/2m0QOrpzzwpeRbQaaXOIqb71HyA8eYv610KT1ODCYNmHKlTJ3sIaV?=
 =?us-ascii?Q?gcRIZAf1XznDSjfkChhEIoHaIW506FMD0rcDPbIACOaqzAMX7kkHorE/J+mU?=
 =?us-ascii?Q?koBNQFzLnrJJCAizssWPrmfj5k3QQcgubHYTAQ8b2wod4cRAmv8K17KjbGSN?=
 =?us-ascii?Q?TwEhAKj7hLaC3S8n6+Elt1Pehl+NFJV2tHgQZiEjP5qKh5wu2Qyc5CEHAXGo?=
 =?us-ascii?Q?rWfjnn6xwJgnbFfj5j9Kp7nryg6YHFDbEQDuAidQT+M6IRV1Eq+MCwntPuTJ?=
 =?us-ascii?Q?iqj/EEVnmgGuJiKAGngIkk8H5y3PHxwz9Ucebu7cuae7c6PThs/8TKx/2r2a?=
 =?us-ascii?Q?scZdai4lDg21IYQkeLqEjI99AcDpJpHWKncoQ3ErjRAYAKP0fdZh8L6C5YZF?=
 =?us-ascii?Q?jDOZqHNTkM12SyWWGGooaXvno0mjIUj26yByMmeYxxtqYiVqaF4nJ4cDEG00?=
 =?us-ascii?Q?dFwCXaUyfaK1HolAvhUlHwM5AV8ef6mXvTHCa+pxH1QHIMoCHtX1R4/jlkXH?=
 =?us-ascii?Q?RtcyuKp7rsvkgpS4CJRmjLGj13twg62tXW8KojnzyrUpxqiK/TdCNz+BfkaU?=
 =?us-ascii?Q?mEex7ka5enLydleqLcApdpXIQlMjJLPbiespw3k4Jqe/uqd9eOJrN6P5a93a?=
 =?us-ascii?Q?EAJ03TFR8loI8y5UjyJ4YHfbCM/v7KTdLdiK7I3oMEnW4D+GfgJfKI4xxwTA?=
 =?us-ascii?Q?+wkaEwU5Vjd6OOCmea7slphQSRF48SaOhpsJ5E7kzRhTmNgfFylC7TmtzzW/?=
 =?us-ascii?Q?yKhvslIVVZbGXNFKH6/c9MBFGDNWbtnrDetmfrt+ZNcr+9F/pyYO/mJ37OsP?=
 =?us-ascii?Q?9yUjlnQ8Aja+rERR1/q8j2b2dqF+hQBaQjSpHOGpb+GN1c6dvoWS+9ZcXPRz?=
 =?us-ascii?Q?WLbkKHF/b7+tnKXq+Ceg3VfAANcPXUgvpDOo5IGeU2gkR1CleNIlHuPwR/uR?=
 =?us-ascii?Q?kSMFCUdDatcov2LueqvrUzEhFPXvWOOr1LaRnQgF/PRGJQlVCSpIRCu3jKBr?=
 =?us-ascii?Q?kNXMWlsOK6kuVPSTe/IdWsl/9HLpjMvpCbNbLz4bZmxf2QGqrXARxvmLWUba?=
 =?us-ascii?Q?XxhtvX7tfCVLBgL5kEmYRIAjN1HXkxqjVjdon3antUS3cziYaw6k+eYQlhZU?=
 =?us-ascii?Q?tB94yOXyvCBxo68Akzma5HhHDTCw3fU8zpTwQ4u882YTv8lkWBrtqaQ9xbCL?=
 =?us-ascii?Q?Q5gZ+qInrAjvF/e0OYv+Yo8+c36YbJL1gxE0AzFacXO18vEROb1+Tih8o7Nh?=
 =?us-ascii?Q?uNfw15OA/efzY5tTJmIXy/0bm3vmHl2VBZg7530nbHMHpfMABQwpwCS2+7pO?=
 =?us-ascii?Q?MUn5CixDhd+mF40hH6Gi+mjFbug0eeRo6B12A4/QB1eLJob/eHrtj9+D3RTX?=
 =?us-ascii?Q?KH4gTZO/FbnIqTdAI8yFPL8r9YrUYZYHldIZjaEi8ooCdkBUaXjPJbEpp0x9?=
 =?us-ascii?Q?2cWrX3l+oKcq3ZcyFYlH2KzM59a3SCN6CefksRHJTi+l6xZ5dJo2YoSLJ4Vj?=
 =?us-ascii?Q?WxG32MxlMWHS3dYrSQ844cV5oJg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1ee596-55fd-4406-7d48-08d9a9137316
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 15:12:05.1791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OS3vz9jF9z5qmrmUk7uWIXWhcn8jFKHdLNMF1Yi6aJqRnzUtPejxKY7NC4oWE/3tm9eGoEmnhrKf0lYSkUrJ6ZGfM01/yilOaPTfW5XJoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4721
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111160075
X-Proofpoint-ORIG-GUID: sY4JLlB3Sb8VS201SAeRWHBt9GEOwHXp
X-Proofpoint-GUID: sY4JLlB3Sb8VS201SAeRWHBt9GEOwHXp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 06:01:42PM +0300, Pavel Skripkin wrote:
> On 11/16/21 17:18, Dan Carpenter wrote:
> > > I cannot ack, since I am not the maintainer (or even reviewer) of this
> > > driver :) I just saw this BIT() definition and decided to say, that it can
> > > be also removed
> > 
> > Just give a Reviewed-by tag...  No one is appointed as a maintainer, you
> > just have to start handing our reviewed-by tags until people start to
> > respect your judgement and then you're a maintainer.
> > 
> 
> Ok, I will send the R-b tag, since patch looks correct to me as is :)
> 
> I think, I misunderstood what "ack" means. I thought Zameer means Acked-by
> tag, which can sent only by maintainers (Larry and Phillip in case of
> r8188eu), but I was wrong, I guess...

To me Acked by means you approve the patch so it's like, yeah, normally
maintainers use it.  But sometimes like people ask for your opinion and
then you can Ack it.  Or maybe you just want to express joy about a
feature.  (Please feel joy very sparingly. :P).

regards,
dan carpenter

