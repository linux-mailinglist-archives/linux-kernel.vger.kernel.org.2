Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86918445377
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 14:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhKDNDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 09:03:17 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:37958 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229960AbhKDNDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 09:03:16 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A4C3HUT008370;
        Thu, 4 Nov 2021 13:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Z77u1v6R9oaxGjJlZRNLwy8ANNhtKmh93Z4DYc68CaE=;
 b=wV2nbbuBn83r+st+OOMzMmAMAHuSpdU0IWbaX2UiiMFes6QIK8VPll3POjzgiA6xFfEu
 45J9xoDEkxqVzJRDX3QZaAz28b8dddxtEP0eYEOFZCo+KY3LYFRGvps4QUVLvYzwdgE/
 L+AUoGYGgYZeNAPvQdNl1K2JRPz+U4uypWdqkkPDcV71Fn4aCQ+K5MC+JeYm1onsGrI6
 11ecLR/uTv5i1n5nQlF149O+WkzM9u9KggnP/E6ZeVOuf+jSmJbn2llAwWi41cTWiKIo
 RyH/KNcPBXu+yVcywxMOFCl0unCYQaFcDcSd2DsvR91dTmgrBH883BeyE+5OZFVuKQZp LQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c3n9xr6b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Nov 2021 13:00:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A4Cj5Vo001452;
        Thu, 4 Nov 2021 13:00:24 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2042.outbound.protection.outlook.com [104.47.56.42])
        by userp3030.oracle.com with ESMTP id 3c27k8mt24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Nov 2021 13:00:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMxWosjX7OWsLPa14eWjhyl5RMPIhmQkWVNgsmEu6qCzmJa6a0bIFYCF1X0eIOG8e0nKN9gaEZ4bQAlIjVxJqcPODS2yfNb3wRNMTFRQe+UoeYdvO8oqBiKufkIMQ5rHHsrOLTr9HXWnl3k7mgGWwfdfn43l2dqHChLa3/AWCODNRWrxh3VUTZR0aKeB89yxeGY2BiSjRuczbvBWdImNTHHYskW1kd0lHsWrM8aUjembPqKaAyCBp/tVCQYt8maPQ1uzSsAsjsyJZiPXTkQ9QKyxgZMFu1k7Yl4nJIEhG48hY5u5kaC7s6odx1JKjlYEnKIrVON1QGYWVumgpCOtrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z77u1v6R9oaxGjJlZRNLwy8ANNhtKmh93Z4DYc68CaE=;
 b=j+CRNw8DoSuhyPFmvnyJZGpd4OEWFsDllGmldk8Shp3ZuLl0FgkDWrZkfKnlc0hCmQLl2vm0w9EJjo9lrUdGmOK4zqMzsIHKiRdiWwA7ULe58D2aeUyj5Xf1fL7rngauyCf37LXU1RzPjxacunDbF9sOeQQdtbD59HYu/4CLm86R6Z8xHkEgSEHtojuZK+98NRWiaaqi0enfxlKDVOw9YsF1j6S13J1VPuNYmxGmRj9yV4Y9Yz40O7GGLyjy2hz8fKhsEtrBBemZ/r5MnfCg882yIWNcnQsujIgsnLVENHPhl4j52JzxTZHo7pW+dEfLFwzicbHbJWMx5Ho4YLWdhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z77u1v6R9oaxGjJlZRNLwy8ANNhtKmh93Z4DYc68CaE=;
 b=CSItWMGlMRElbAchKe/qrT+wmcN2HQQG1ngpezW4PYXMksStYPjcaYt2v78JA45ZEhVOv0Vso1RugTBF1+A/6mahxnkRgC90Uq7K9Uh9rVrMFAxo1fJKD6w+lsHVTryYYaeW3727Ay9X8n4U+PwsutQwoF3FNVmrrTa3NBBRMyw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4692.namprd10.prod.outlook.com
 (2603:10b6:303:99::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Thu, 4 Nov
 2021 13:00:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 13:00:22 +0000
Date:   Thu, 4 Nov 2021 16:00:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] staging: vt6655: Use incrementation in `idx`
Message-ID: <20211104130002.GB2794@kadam>
References: <cover.1635773679.git.karolinadrobnik@gmail.com>
 <c569952d92ba51f32679c2fd87fd48ad8e49e3fc.1635773680.git.karolinadrobnik@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c569952d92ba51f32679c2fd87fd48ad8e49e3fc.1635773680.git.karolinadrobnik@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0045.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0045.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23 via Frontend Transport; Thu, 4 Nov 2021 13:00:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91105953-7c39-4bfd-16bc-08d99f930f7d
X-MS-TrafficTypeDiagnostic: CO1PR10MB4692:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4692F2E38A5A61F4207CA1C38E8D9@CO1PR10MB4692.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +L0etTHrSrvmf89G+9g89UXjFS6c2UL9QzF3mMY2oK3nHW+j6+FTV1Xmd74dHejAfsL3cRgm5p5aygmJqhKX8fSpq8OasdRDPAOhMxZY1yw+EnG/hazEHPvNErU0mLX6S6b2IOLvmPFCf9K09C4Kd3xWN9wwklU4MNUid3KzxigfyGlcX3iy7BlrBryEXHlz3mjBvk2QsW8x4f3FhY7Lg+wx/rm0v319JKidHx4tFq6MZ0KgAdY4ljjYXa2H1nxAlp0xc2WJbwKOctL6/ePcbNqBBhAChubmfZnjJlYim9PtbTsCJKKPsHgnrlskZOvXh0JIPhF3GZicrv67Qyv+KghXCANl4eJAzLuAxtNGMi0PVJj0PhWR/O/fiGFWzQJyX8epZaYXS6UAvQcwhQJAqUM1XDaDqcBpe9Ur24u5h6IgL3IuLROdN/h606Xo/ael1Bm4xHP5BVKdS3LBuKQU6aqmkjL7+4j7gcGjqAwNbaNDDLvf3hD0J/cbPaLg+A/JqV6XgdLsRdMzjSqVl095ZUfKL99OinUW2jcIhuBsOKEslA834h1IkD6NzDbMCT02gH6W9xY0O097QvzHcDWBCdQn0O4xA2xbjCL6F0w/Q5+Sx1Gsj0aXwPDip8g0bv1mxSZICmxiliiqOrLd5HJOx+Fi/jVwIqmAGSXvA1eTmwElfqhCnqUTu2IcFLtlse4rkvipcpBYjhXNx8CtHUJ6fBU+ConhqwQl4+4LYEOt+gU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(9576002)(8676002)(8936002)(4326008)(956004)(508600001)(2906002)(316002)(33716001)(26005)(6916009)(186003)(1076003)(38100700002)(38350700002)(33656002)(66946007)(66476007)(66556008)(9686003)(5660300002)(55016002)(86362001)(6666004)(52116002)(6496006)(83380400001)(81973001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f8Q07JEUcgXNlYPXk3gfmlvGgwshMucL8BdDiEmIVCgDa10sRdu2sqEjIQO7?=
 =?us-ascii?Q?x4m7eJVIeZEjGdCNPbhDtE9Gg6OQT/MUooYE9mSygw6jjxiFVyqyBoFp5xM2?=
 =?us-ascii?Q?KHrpyq8DwpfLyANm/pcErPIIdOI5CYBYQ0g0HBYOFUdjAn5tXSbmxRk6LwOu?=
 =?us-ascii?Q?9P1CyQhMeXfZqEu99u9Vhy1VMiXrDIO44crhzSIMIp0cJQ5djAo1IHhP2Ry4?=
 =?us-ascii?Q?EJRDyz5OSo159es4N08eJuVH7tV189sBkwpjxIi+uZD30xWWMJcgJlUEZXmr?=
 =?us-ascii?Q?Pp4YmPOtBlrtgXTTlzZTwM2EqBqt5yI49gNR8JE+IQgu0zeAkCu0v8NKmJE5?=
 =?us-ascii?Q?KtM0w/tOydeC9Z9oOaCR35Q1sip7SEA/hOltQVYt1wCFbDo+7s/sKhwbHcTj?=
 =?us-ascii?Q?feVjTceIahN/8VwnpEZQZ5Ex+0lVwpjTVC+2ZtmHWThKR7Hhu/l3Xg9JVSbB?=
 =?us-ascii?Q?39UzToXE1bpvRW+mqXffV+0K+NdrTXtP9FvqH8d5O1J+dT5HKKlAmEy4wOCa?=
 =?us-ascii?Q?VmAfFf4TDesOJqVml2lr0LnbF8BHqM49cKmtRJ2IkR90aawyiISc5NpvfhQT?=
 =?us-ascii?Q?051igqA5sO087PLZBPi+OqMTBWS+bdvaKEJ80IlrDR0Nmxid6pIXbIbSeHxg?=
 =?us-ascii?Q?8leA42CiGcuooVM4iT2WAJ9HMuFRNiPDQCh5wf6pDBktDOQ7yVWy0egJoPWz?=
 =?us-ascii?Q?hVzsKhSRzJB1edUcYq6cfSXwGTX0FRGg8VVA7ZQKWz8gt3uBvjDQs6nPlArP?=
 =?us-ascii?Q?dbNZUU1uKxpHOGxJItQcKoscHzzExgWzG/okHQ10C4RrJX3rWXo1hWSLyQMb?=
 =?us-ascii?Q?IQ1UYGbY/H1CKW9GfkM0md+lAiZUdy0OkjSOpGgC7E54ADEwwrl5eky4y7vc?=
 =?us-ascii?Q?bG6x6in7zMyg0Nth/9fiFx0GgUJ/pZWHU0Vq7Q0t/mclzUseUyk8ZBv5Mmvd?=
 =?us-ascii?Q?pK45RyIl3FahwMvNaidwlcYFMNKVxdG0ICjTqe/9J4C9niM4rFVosq7O7pu7?=
 =?us-ascii?Q?h6kl/5ZCeV724C8CHu9vNYdxIAK37i4XKM4tIeaWHPaik7qUx/BD1DJtFHO/?=
 =?us-ascii?Q?pKiDMK72zszzs2a7lA7T+M0/OVcCv0GSRhf5kcupbRsNSBxqWgxUWEP7Ii6T?=
 =?us-ascii?Q?YxKBPJ15ficfmMELt9t1kwGoRiF7v81cPDaUb8RiVb6/WkiyVItX/hUC0sVT?=
 =?us-ascii?Q?Q5wZIgbTjUuCfBmVFfGxVUIpZZSwwwQcq1aQuGKMrIzza+waz13jGRWp1kUk?=
 =?us-ascii?Q?1LUmHOLa6f6LFMhqWQBiLw2Er7Q+hstpltyhVq+5p27vwHN9rm607kuGVE1O?=
 =?us-ascii?Q?HzvFB324B0xf7gfXy6jFdeV66Na4XkxIfw2d2xn1aE3GS2K60g5PvVWoJWnZ?=
 =?us-ascii?Q?j2NgvKoFQXuRcTxPDcfTGeU7sNPuS0IDD5iquT3oFbB9KtzUu64wRx3EQJ4F?=
 =?us-ascii?Q?KCyXNL7zBu4w+YOkuS+s57DB94+X7Dx0aZBAIshAwFyL0Knbz01yWgbqpk/k?=
 =?us-ascii?Q?iAcC0j+aFfRws+Fr2f/T+Ljf615jOGwXKJpbl14xXP1RR505j63y6IC6KX0K?=
 =?us-ascii?Q?VDgi4DYoxqFaI/T90lLFz8Ev6ZZoOjV1JvCfb5MHMu6pjUma7Lxc+Q0E4yys?=
 =?us-ascii?Q?HmHcCG2IkxD9gXx5k8J7TPpn1F2QN9+HKndptQ5SNPUQ1EN1sennhK0cyIUA?=
 =?us-ascii?Q?9XzP8hnfqyG3Ow1C116JPpgMaeU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91105953-7c39-4bfd-16bc-08d99f930f7d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 13:00:22.3556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mV05gL5j+/0lsNhmwVI/YxCx0picP8Z+o1rwssp4VmKeG+LOYHoApmkEJ/JmK2hiQ1EhfFpvvHgBiIosxMJjTfQ1AhGC9LkadP++UZ9L7k8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4692
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10157 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111040055
X-Proofpoint-ORIG-GUID: us9C-p3iZibCjdpf4GanbU8if0UMrQzI
X-Proofpoint-GUID: us9C-p3iZibCjdpf4GanbU8if0UMrQzI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 02:32:00PM +0000, Karolina Drobnik wrote:
> Increment `idx` in a loop instead of adding the loop counter
> `i` to do so. Thanks to this change, the cast to unsigned short
> can be removed.
> 
> Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
> ---
>  drivers/staging/vt6655/rf.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
> index f195dafb6e63..c07653566d17 100644
> --- a/drivers/staging/vt6655/rf.c
> +++ b/drivers/staging/vt6655/rf.c
> @@ -700,11 +700,11 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
>  			return false;
>  
>  		for (i = 0; i < CB_AL2230_INIT_SEQ; i++)
> -			MACvSetMISCFifo(priv, (unsigned short)(idx + i), al2230_init_table[i]);
> +			MACvSetMISCFifo(priv, idx++, al2230_init_table[i]);

Of course, idx is no longer a constant so declaring it as a variable
makes sense here.  But maybe just do it in the same patch because the
patch 1/1 doesn't make sense as a stand alone patch.

Also don't declare idx as an unsigned short.  It's better to declare it
as a int so it just works like a normal number and you don't have to
think about signedness bugs and wrapping and edge cases.

regards,
dan carpenter

