Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB5F3F9C69
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 18:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhH0Q3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 12:29:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44938 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232649AbhH0Q3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:29:16 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17RGAUvC018764;
        Fri, 27 Aug 2021 09:28:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=nyIlUltwwWDrVS4f8s+i86AV9bRvw5d87TviSNXl40o=;
 b=JFIE1mrcyI16vR6rmp6Y1nEsJIZsF+SBAZKERYr7RIimPcF3Ft5f7KJn3CwmdJcPkDAN
 jLkUmeA2fXbcaUbeOAI3bNOtTniHIRTT1jW27F8hOjOyjJTfjW8VEYMi0bmNAKgSM6+n
 jvBcDjiYamTvAmKNHsWbQqTlyYc5aoklPC4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3aq2fh0gp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 27 Aug 2021 09:28:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 27 Aug 2021 09:28:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEXUbVEweQW753H+13y8GYNKN46PoNHS95UMxVeqRGOVymy7AnLX8qtxwOQ9eblxohN1BSs+V1LcW6aaUCmF0dJtHfyOmxgYlvc8hA3Rl0eSvdnqyfY/BT6h3Ijk9XjtmB5Vgw8d0AXhEVcihjxMeQFjZ1qoaeIHg2p+xUBu6fAKFMhGfPrs7TUL8YvOqP/0IZMqZVUoCnNBvlBwdddLfvVpnIp/ZVHH4JT2/nZ2sHpvLMXHuIlhmUp+XEQSsLTwy0QJl2Mf3PPYYMrowKfMwdS9PR9XrZfGvwkRA6jEHq/rxXmDTC6KAvwYd/aPbewhlUF+tYLCvz7lLPfP7WqEhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyIlUltwwWDrVS4f8s+i86AV9bRvw5d87TviSNXl40o=;
 b=jndTsjjYzIgImeOT1SI7cpzpN0HEpEpwkUntw6cJaOVEN2FPKVoTmDEQ7ZMxtDsnztv9KekXXnRnsB2s+wQiB3tZ0ud057wqAyBRaoV7ks8IsM+MImwNOyEpyiabaFT5D3V1L2tyoZpCiV2QX1LQa0A+rB5JxbAnBw4UaEGccXh3EhL3xGFsl7lh0rjx7Ot6WIr8Vw/sqXlT9lHWo4o/dj+q5W3hyNcrYK9W9qKSep3DSC3gdCP7xsopBeis035VmdPoOp+jijSXJj1WDWJt1OcK7ObPPo82R5GtWL6Wdl34t3LkElLtU4afwe4bbfGd+Zq6ezBwinaV1HNDKCgvKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: surriel.com; dkim=none (message not signed)
 header.d=none;surriel.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2439.namprd15.prod.outlook.com (2603:10b6:a02:8e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Fri, 27 Aug
 2021 16:28:15 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1144:84e8:6ae1:833c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1144:84e8:6ae1:833c%7]) with mapi id 15.20.4436.024; Fri, 27 Aug 2021
 16:28:15 +0000
Date:   Fri, 27 Aug 2021 09:28:12 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Rik van Riel <riel@surriel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <stable@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Chris Down <chris@chrisdown.name>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm,vmscan: fix divide by zero in get_scan_count
Message-ID: <YSkSnEYfrWMMgJgQ@carbon.dhcp.thefacebook.com>
References: <20210826220149.058089c6@imladris.surriel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210826220149.058089c6@imladris.surriel.com>
X-ClientProxiedBy: BYAPR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::43) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:f86e) by BYAPR06CA0030.namprd06.prod.outlook.com (2603:10b6:a03:d4::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 16:28:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67928ee2-3bde-40d9-3866-08d96977ab5c
X-MS-TrafficTypeDiagnostic: BYAPR15MB2439:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB243935A121220D8150C4D98CBEC89@BYAPR15MB2439.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jwuyygDFqpmzsXzatIE4HYsdRcNezNpz4+dZ1P8OaBx7c8A1CzmuCQ0FHu2h+qk1tbISPWXsmLbJWClP0BDQdLuGWdsNcAj7swRIQu925FCJqqVJGkvXQvox4qbHXbzlzhxjr8VoCRixxumVSllp2xguebjBxl2OmRaYUfKAvtikaY5mA3KkGaG+wM0Eii0lKTTqE8i0oLtGD+nFhfhtf6uWjyLP2sj6vWnUlLsU/K3KRtIlXiptAh8C5DVCEneZj8l4UlD4kwGiTUb/vodFUo7bTQLvSn+UHzy9lBGR//OxYM99apRwBFJVzZ7jlh4sHnpusbhbJe5rYyWA3fjnztGGFAiTZpFi0v1bLrZAI1UbqjR/YafcohpBQH4ni5IQ5rUSlkMSp7HL7dQt0TB5+CYq3nQdmD++Mcq17PqOyyopfMH1ECmKi4TRXemSqKlYsntjrVBMpmD7m3fZjc4+Wr6cbJrW6YNwuRsoj0wBaXZrXbgLtYnosJ41PLzUBw8+uH0YXx4ITHc+ZPykwhp0OwM9+ehEnwMOfk6Z93nKmnw+Lqru7TKkQ3r7G/RRfgY2FufUzu+BsIPIbs/jcEwHsTKQRsgxO30J3UtuuG12d9cESJre2syl4DKCCjzuV+SAadtHklYM1UDNeY7jt5EqyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(38100700002)(2906002)(4326008)(6506007)(5660300002)(83380400001)(6916009)(478600001)(9686003)(86362001)(8676002)(54906003)(55016002)(66946007)(8936002)(316002)(66476007)(52116002)(186003)(7696005)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hzUVXlfzbbTACIww8rJFc8nqcJCXxzFlvjV7fmEwKvkPuz/V/T8B+xH3BKIP?=
 =?us-ascii?Q?FFUfg8MScbr6ffg67JfOWzQ/M8fmeUiUKiAfx4299Ezlyr1jpkTFFoYJrCKS?=
 =?us-ascii?Q?9pkeim8MybRRpEKqdlnAhPOodIOTRztSSLZATX2qX/gVR87X1gShdq17SrsW?=
 =?us-ascii?Q?QtQTkR/QVrG3wxvRr1AsnKnKweCVtyNpI3SG1gOObGc2O3IdVj7900Dsyw3D?=
 =?us-ascii?Q?nB/B25YOILOvXyeLAAvuQVbRPkMQ2EjbRiXI/Tk7uQNtXiCo5mdA+rSZpN2v?=
 =?us-ascii?Q?7qCf+aS44wiMZyf7JznC5K3hWjqfFT7B8J9MFcgKjHC/RxF71NUSTyRhozSX?=
 =?us-ascii?Q?atZjGBP1TkxA/ohtsDSU+BAAqW4v2voglsBTKz7XlJYOVHdUhPCyXSMxnTWH?=
 =?us-ascii?Q?dyWyKvPyGHMEm3uHvsyYDZb/TlRJfBvfBIhLcLC6ojcublFkiwXwI2/2waDr?=
 =?us-ascii?Q?v7Vx7iZqUrM4IVX3CR+hXO9QdUxdrVZS2ekT+IOmvetx+142zU4cvPy8P1ID?=
 =?us-ascii?Q?7Qal5Kd8LipKSontymTkgrw5Is6XI6SHk61pzxbMedH618uatx9xqNpyT3lS?=
 =?us-ascii?Q?FJXZnC0539seA6OeyT7DLORqKrQSI+8hrZpJxq9GCXpH39JWMSxLA1YgFtNa?=
 =?us-ascii?Q?J4J3Li5strHtQms/Mf/BmLnsmltLAHefZ9mxXWbNJyAvlcZxy2Kfg+FR7vLe?=
 =?us-ascii?Q?fxGeQ8QfJ/UyZhwliij/n7XEGdm7kx+oECF636g9lBAdiAmEH1o2vS+OpQc0?=
 =?us-ascii?Q?kejmOXkoxDm2xQzbwjWXva1VVBjDWfQff3Z7KU2+3YiqvJWDS1694ivSVV+N?=
 =?us-ascii?Q?pPz+orFWBY0R4tvoTL1M1FNhWLz/ZZXnrmPAgCIz1AfHD9evthwjyay0snGV?=
 =?us-ascii?Q?q/ylagAZJ63pPVR3GL1Ra95++8EbxB4zUPL3uUusl2g2dN83rqyyD469Rz1X?=
 =?us-ascii?Q?HKxRmLjzEltezVDYG9vQt5jbFlQRi1gMUE975KujKE7ETBldlg2RIu169hX4?=
 =?us-ascii?Q?6JhEw7HXaGKGj9EBrY4XtrNyKvy7fRED9pBbpuWmwLXCzXxORIYS6j6a8/7n?=
 =?us-ascii?Q?m/r/YNkTeSglrVFDTKJn2SjmnUQWPHlCXPJEZayz3I1CwUPjKCwbaU8BN9E+?=
 =?us-ascii?Q?uhTHUapCdYfAt4ONIdPA29A+bhMiT44P3/f7T0QkwVdtwxZZvP5DOdu4Hyr4?=
 =?us-ascii?Q?BMccFXVbsUrjkYnYpdLIq7qRMemBAiwsG03mpen9oSe6cRWUh79fQWQtP1nO?=
 =?us-ascii?Q?LcwwL0ooXuBQU1TnbklPldDprsEpEpwgOMsoTInJXbuKb0YDQxJ//CuhPxVJ?=
 =?us-ascii?Q?gvPQTuyzh5+LC0JPngEomB21zzkfnJqXEHUabGX/CwgOdQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67928ee2-3bde-40d9-3866-08d96977ab5c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 16:28:14.9946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: foNmeZez/96k3icAwjbLThoz00+EL2oS3rVltfw2zUVZiV6MhldtpYIYZ7IGBztK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2439
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: RUUaRVUYH599XoQWuTT6XrbwScITRwMZ
X-Proofpoint-ORIG-GUID: RUUaRVUYH599XoQWuTT6XrbwScITRwMZ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-27_05:2021-08-26,2021-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=542 impostorscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108270097
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 10:01:49PM -0400, Rik van Riel wrote:
> Changeset f56ce412a59d ("mm: memcontrol: fix occasional OOMs due to
> proportional memory.low reclaim") introduced a divide by zero corner
> case when oomd is being used in combination with cgroup memory.low
> protection.
> 
> When oomd decides to kill a cgroup, it will force the cgroup memory
> to be reclaimed after killing the tasks, by writing to the memory.max
> file for that cgroup, forcing the remaining page cache and reclaimable
> slab to be reclaimed down to zero.
> 
> Previously, on cgroups with some memory.low protection that would result
> in the memory being reclaimed down to the memory.low limit, or likely not
> at all, having the page cache reclaimed asynchronously later.
> 
> With f56ce412a59d the oomd write to memory.max tries to reclaim all the
> way down to zero, which may race with another reclaimer, to the point of
> ending up with the divide by zero below.
> 
> This patch implements the obvious fix.
> 
> Fixes: f56ce412a59d ("mm: memcontrol: fix occasional OOMs due to proportional memory.low reclaim")
> Signed-off-by: Rik van Riel <riel@surriel.com>

It looks like we discover a new divide-by-zero corner case after every
functional change to the memory protection code :)

Acked-by: Roman Gushchin <guro@fb.com>

Thanks, Rik!
