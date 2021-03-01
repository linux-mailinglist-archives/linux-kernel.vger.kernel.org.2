Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20D93275A1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 01:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhCAAjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 19:39:45 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13312 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230214AbhCAAjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 19:39:42 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1210QKUA012953;
        Sun, 28 Feb 2021 16:38:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=iLpJOry1vIUt8sXmH632Y+8d/yX9+fnDB7wMOIOyPwY=;
 b=YJ4hYLrj7qm17IdrYdvoAXFLmgzAhHeiY67RqZyncxbJkO3EwJqbR0K/HRuT8UQ+E/0P
 OfcUwuKJKpufwjVIaPCIgRnAcTgWIYKL0hYf+nsp83N9rvbJzcSzF2IXLqU7GwkXY232
 mYWukw0O8ohAMwgLoCUOcf6F/FZDJBeIjrw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3706nn2efk-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 28 Feb 2021 16:38:52 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 28 Feb 2021 16:38:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fU/MwBQ8sl18+VVljsLnHoMp02a7GYYcxAvGo7INyh9xRHvsODq4FIZ10PutKTpKM09b5B5LTmt6tWbDpNBIqqqV2KWoMvz11i34zY/VQ6I7plPdNTsDMnnjw2+jiNb3vkTEqfnsw47bK5H/wfOlIR0Pz1PRUm9JZrRUMETuNrJWxbsIoIWounJ8iUrjtBl/suyvNncyiJmZ3r5SQh2ltOBx4x0EuVWxJMZmvNLu8QD1pgzcp4dxsBHb8U03hlk1fweH6TVtbdjdZCju0UcWS0Fv8d4/mFP51ymGCC+DBmGLDurgis0uVsF6AsvJcHGRf4zNJT1kp7zHCmXFCc2n3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLpJOry1vIUt8sXmH632Y+8d/yX9+fnDB7wMOIOyPwY=;
 b=HxUFXyFD7y7lUnmlVvdVRpY/ZVDq5clcG7W9qm6QC+o7l5Aa8Gu95gBtoaTcs2Qpi3VWDEObMDCDE9dn1mwZLFbWyjI2CB8ORBy1d81RIqlN1DkzFtplzFOC0s1i871WjjFTX+VJivAK7UNbAgoC3QTGE/ea4lB5zPVZiTcL3YzYZxyOcZGanb5gW6uPjMPb61CptP811fRS/Nnci0uXGv85lkABi/M+2/cClXX+/8RIGUoEn14aOxjnSOZ7zEsf6M7u02oTC34whocwQLWrGx7Y+RN5A2oeUBCXDvfLF2qZvnYMc8zkfGeNvjqpJeL9hRNKmDcP5FSs33eM6Nt9Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3556.namprd15.prod.outlook.com (2603:10b6:a03:1ff::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.22; Mon, 1 Mar
 2021 00:38:50 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 00:38:50 +0000
Date:   Sun, 28 Feb 2021 16:38:46 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] mm: no more EINVAL from /proc/sys/vm/stat_refresh
Message-ID: <YDw3lsR1wkaFLhhX@carbon.dhcp.thefacebook.com>
References: <alpine.LSU.2.11.2102251502240.13363@eggly.anvils>
 <alpine.LSU.2.11.2102251510410.13363@eggly.anvils>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2102251510410.13363@eggly.anvils>
X-Originating-IP: [2620:10d:c090:400::5:7c58]
X-ClientProxiedBy: MW4PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:303:dc::10) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:7c58) by MW4PR03CA0335.namprd03.prod.outlook.com (2603:10b6:303:dc::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Mon, 1 Mar 2021 00:38:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 769a6192-3c26-46c4-3608-08d8dc4a61b7
X-MS-TrafficTypeDiagnostic: BY5PR15MB3556:
X-Microsoft-Antispam-PRVS: <BY5PR15MB35563BB311FE6F41D4F3871DBE9A9@BY5PR15MB3556.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:439;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S7YnY/pw6YtFo9ixFdrbp2oxk1r6VnBHBX1mPiAHYMeHZTG3Hti+vX2OucGxcCXFdCtj/+c6uSc1MxV6PFIoPh2FTwPEU//pW/bRo0FS4pwBH4E5QupHQTce6eU6ufyg/6zchHoCGUsSfdQqAb2khCSufFYUfU4xL6ki5R3KH33WIGIjlKC0lEil6IhS2Kg4f9kP6/uz5xA42s/o5mtHzMv/TRc3BrrfmiLRbeiXDMoIkV5NdlbRXxchHvO5piCGHZWpkKMAZbqaV2iVl2QF3i6bv7Us2aDpQMJsm3wBcfXurjm3qQvBztC7q6kZz0YBk6DWm+9GjNIqz1p+9kRUU1PO3XR3jNb6t+Q9kN600COMK0ootsmo5e3TSUtxE/eedI3/UuoVMAh1tYq83AvgVmK59AryGXr7qZgxT4sSJEfRDFdT87qp0NOiZwckTODzQuyjtXw3nnBd6dTLCzsHDj+O2/0b3C5dbz+Z8LmrOhTBb9IYdidHnseL3yZDq0AqIIf41cNjUf0ya88lNxB0a4rtThosan8QwurL/hQ+3zzmEjnol8sxoA5KW7Ezq3RM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(396003)(346002)(376002)(55016002)(9686003)(54906003)(6666004)(478600001)(8936002)(86362001)(16526019)(83380400001)(8676002)(2906002)(6916009)(186003)(316002)(5660300002)(4326008)(6506007)(66946007)(66556008)(52116002)(7696005)(66476007)(29513003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?W3dlqlGO+l+ADrCdkHUd0PCHV9Cf7hg1NnMcCDMQn0wT0Nvh8PcH2gAn8Du9?=
 =?us-ascii?Q?6KppazRzlzTWRa9OltF8YXH2X8smzqgoTtiSR8bp+Q+7x1rVho7bNjlSa/Bk?=
 =?us-ascii?Q?jOmPdR4SgxRbIJxoU4wFxVTqFk9swxA+Py/o7ou1MWlFWv/OSW0iGGexHfab?=
 =?us-ascii?Q?La+6F+tecLZRxaLdfsn79d7i+ere7lWKgz5+4fHGiwZWZj6JnG2+TP+BbLkh?=
 =?us-ascii?Q?oepVqajngARXUIvC+vq8jNgDTHHWzjUrmnRLkCSxJGeubK1Z0+TmdSqgNyfH?=
 =?us-ascii?Q?5AF9nYyN3obfoN2y8RZyJG0ZtK0dJi+n10uZskQfj955euf1fO/yiipyyIRk?=
 =?us-ascii?Q?FRwdzTzzn5qCQAogdKFs1KQR57zW3GNvFyrHP2u+haQpMUHSwMRY8c1E9kB8?=
 =?us-ascii?Q?TO8OCuxrDSn3Z4bJOW2Tra3tqV15z/bEtIffDXmGYP7fv+DuwacAHdxcpDcX?=
 =?us-ascii?Q?fmv6IQeOiONVCTj7aS2Tagus7SJtWjNjHWGd9bcQR8MJx/acj9xjPX5is3Mz?=
 =?us-ascii?Q?EKKoZuNRk6Jzh6Zus/quPfdl0QRVAwx9XF8uXK5grhGbabVbkxr7jW97oQsM?=
 =?us-ascii?Q?rJXXuMu284pdrH0Z5f8cybpdo5lFDUDh6f0kAhS7w8JAqoVzzz+6KtYWrtV+?=
 =?us-ascii?Q?fTZjw0OsGprMvg576rQH0a6Nfp12D3JRgRCpnEjV+KrFZ24E4UW5pk19/q8j?=
 =?us-ascii?Q?RstFQ0Rgwoj/LP/IFV0KKu3Bjk+hCcWixPzf5R7hPudOT1jn0vG6mX9i5pWZ?=
 =?us-ascii?Q?F5Hlm2ikMDe9U7qXwLlDpfksf0swk3uwY7TdvJiUaFOrnKtZMvqEMF4upAq+?=
 =?us-ascii?Q?0kTrEElkKwxiAMQo5vmOki1de2Tvf5XqHJGnp6cp0AQDFcENFXVtpgHDLohI?=
 =?us-ascii?Q?cRflFtHPQXePTf4dscdACNgdgxcagSw6LsjyQpeyw2HIqO9UDdYrHlP5y362?=
 =?us-ascii?Q?v8YmnPVKQRKyr6bqtx7GeTswAXcOhf0hSQJGrBH5+bnscHZ3ADY5QE3cEuer?=
 =?us-ascii?Q?12KlxgJKWUDtZe2dLngg0bEvApsG+tYCA5rrsT+Ko2fqVDw4n7EmRnF5jL7U?=
 =?us-ascii?Q?ehg79spiUQVRYBrjbreTKAmEpmjFwszynOIoZZ5V/l4liKkQT5sJp3iuE500?=
 =?us-ascii?Q?gPkKlHSQAar5KpBEmmyUMgeAzQ1P3jB0uXgrhD5kwTNhrxL2qanLlfsNaXtJ?=
 =?us-ascii?Q?2zyFXFbPsVkeg4lXeIyLKIYef+HVsXECgZEjQixzndM4HTJydwdX2dCAdqtK?=
 =?us-ascii?Q?k2YSSu9olPGxsU+REf623KEj7XNcvni4iQSgUfRB2vtr7KaPV+Cnm4Vk9Z6l?=
 =?us-ascii?Q?fb9vDrC0oqmfbDVijXXJl3ACyRHJwliSI7KmWm/H8UsFbg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 769a6192-3c26-46c4-3608-08d8dc4a61b7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 00:38:49.9771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNVsqN0IX38i5xBPYkYeCjw4/P9xeJMm2UZcJbU/vJyP+BbQvLS1CHac5h5pjC92
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3556
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-28_12:2021-02-26,2021-02-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 suspectscore=0 mlxlogscore=589 malwarescore=0 priorityscore=1501
 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 03:12:10PM -0800, Hugh Dickins wrote:
> EINVAL was good for drawing the refresher's attention to a warning in
> dmesg, but became very tiresome when running test suites scripted with
> "set -e": an underflow from a bug in one feature would cause unrelated
> tests much later to fail, just because their /proc/sys/vm/stat_refresh
> touch failed with that error. Stop doing that.

Totally agree!

> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Roman Gushchin <guro@fb.com>

> ---
> 
>  mm/vmstat.c |    5 -----
>  1 file changed, 5 deletions(-)
> 
> --- vmstat1/mm/vmstat.c	2021-02-25 11:50:36.000000000 -0800
> +++ vmstat2/mm/vmstat.c	2021-02-25 11:56:18.000000000 -0800
> @@ -1844,7 +1844,6 @@ int vmstat_refresh(struct ctl_table *tab
>  		if (val < 0) {
>  			pr_warn("%s: %s %ld\n",
>  				__func__, zone_stat_name(i), val);
> -			err = -EINVAL;
>  		}
>  	}
>  #ifdef CONFIG_NUMA
> @@ -1853,7 +1852,6 @@ int vmstat_refresh(struct ctl_table *tab
>  		if (val < 0) {
>  			pr_warn("%s: %s %ld\n",
>  				__func__, numa_stat_name(i), val);
> -			err = -EINVAL;
>  		}
>  	}
>  #endif
> @@ -1862,11 +1860,8 @@ int vmstat_refresh(struct ctl_table *tab
>  		if (val < 0) {
>  			pr_warn("%s: %s %ld\n",
>  				__func__, node_stat_name(i), val);
> -			err = -EINVAL;
>  		}
>  	}
> -	if (err)
> -		return err;
>  	if (write)
>  		*ppos += *lenp;
>  	else
