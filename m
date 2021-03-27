Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BC634B80A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 16:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhC0Pmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 11:42:51 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35920 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhC0Pmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 11:42:37 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12RFP79x086671;
        Sat, 27 Mar 2021 15:42:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=kQUjcBGLtmcDfIc9TPGbNUGfbjMPx1Gb4eGSVThKPw0=;
 b=CVTSGQfWP+vT92Qc6sUvvXV+02HK+MWJT2FngLVJfSpsuwRMSY2yO8CFZTiapG5Ozclk
 05UpjBeF3pYcoSc7eP94atl9/tmHE/fZdtx4t4O+3WxxKi+C78dzzuLTGg3vJbv2F6Cv
 5yWuCQzYcst0Y1SHvDXegvgdmeUwDRoT1yjgw7qq8eIhfM/W6H0s3gIxQVHREbnxVFfb
 fPTcLkg7w/hUTo8aSYR5ycF54MfzZ0BXO+DtJrxmplta1eW9LA6nf3qzGFpfopP8w3/9
 P2AH3tkLiwAoJxWA0ItJ5dNNT6ThM4Cm4JeREhrQbSDo3DxSNdojSK6LGIRcTx5nKIUV Cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37ht7b8qa7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Mar 2021 15:42:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12RFPHFX039458;
        Sat, 27 Mar 2021 15:42:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3030.oracle.com with ESMTP id 37hstshe77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Mar 2021 15:42:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WW6ZSEdXtJq9wqaYgDNculgEORkd0d6t43N5aCD1bjR0gX0P94P9vnjV5nUdsjYSflyB2xp+yqKuQcoQlqYh91Bz0O1UajPh4WidEPgmEJW6lupGysl97WLdjdiyWJebERMH7z2Szm/20i05f3h1Xn5vsHwWh5aG82x+gXvB3rBJjSWOX3eyxD4ndFcCN8fOWeaGm+ONqrHUhWil1Cng9b3ozoRXvT5pSsUKXR+HePFnUAVL661/W4WfWTpA5ct4olXUxyjZb1kXXaGjUbpoLHenq0qM0b84c7A9wqLh2gJSiXw3k3VTegPmPseXDFFhrkwTCerxCIwTGY9Ott0cOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQUjcBGLtmcDfIc9TPGbNUGfbjMPx1Gb4eGSVThKPw0=;
 b=X4PwHzR1iAYwlyzNLVJQ3Npz7EC2hpKO9xxbEPWjp0K1+7xbQjLLlrM9dxKN0dn4c2f8YCyEzzEZy0ZcpYvEkuxh3CE50Qv9ZzbGi0YlYsQI2s7jYw5MAi5eukmw/SUiYn348jHr3eW8ERK0JEyF+NBzWo4s7m30qmovB6J0Ht43ah/aVwC0JkH7ks8zGoAFirQi6tvJQarvRfkF19Yh2+0cFc8v/68vuf67Q7mhRxc3L2bT2J+WR6EPp5K3GqP/GB+gvVK3aXbzF0RrLwqFpwl63eyhykePUhdHxvqfYr1KOmawG8HaQI1V1bHj8MHixyvFlWTDfzNEciSfUNjoWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQUjcBGLtmcDfIc9TPGbNUGfbjMPx1Gb4eGSVThKPw0=;
 b=vQ/qWoLJtcx/2rq3KHwWJs9Wxmb1AvWL7hz3sW9S374+V3sDPJ+YN88Pzj1e0VZBxpX7nKdEQBjK0yE+1mb9mT5RbC+Dh25XTwTQ+REAjc5vLpXeQMDkx5Puf/9vXcmO7tgrWL2w5j1Ho1W7genaWLK+QMQon/M0IdDKk3YcDyo=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by SJ0PR10MB4414.namprd10.prod.outlook.com (2603:10b6:a03:2d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Sat, 27 Mar
 2021 15:42:26 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902%7]) with mapi id 15.20.3955.033; Sat, 27 Mar 2021
 15:42:26 +0000
Date:   Sat, 27 Mar 2021 10:42:23 -0500
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/1] scripts/spelling.txt: add entries for recent
 discoveries
Message-ID: <20210327154223.somjphorfdxhvhye@dhcp-10-154-138-142.vpn.oracle.com>
References: <14c54ee47bf0e9aebfe71e97cefd11b2b8f0332f.1616784384.git.tom.saeger@oracle.com>
 <49bafdef-b300-bd4a-c3b2-c672470e8922@kernel.dk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49bafdef-b300-bd4a-c3b2-c672470e8922@kernel.dk>
X-Originating-IP: [70.114.130.219]
X-ClientProxiedBy: BY3PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:217::16) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-138-142.vpn.oracle.com (70.114.130.219) by BY3PR04CA0011.namprd04.prod.outlook.com (2603:10b6:a03:217::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Sat, 27 Mar 2021 15:42:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edf0d54a-32b7-4282-dd1e-08d8f136ebd1
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4414:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4414427BF0585E9F6C5C71B3FC609@SJ0PR10MB4414.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z92cpu4A348s92WklZSdLMAOdEtrcsJ+97IF0loNUngtrhlv6KCm3zkPVESANSZfLBUk2RnGSxZyCeFb/HPk7U9PH24gGlVYZZQIMFT0/TznaCiAMbLuIfNRomW8r+Ogo4KdxYXarXUwR6mQXHkIBlBS27k4a7C2aPeHuyvy2LDuehZ1HDulmtYmekTC0HaPpc2z5Dct/d+PhUlyIGtOf6vbQ3vzIJPp/7/WAuKm1mvOkQgdGg7U92E+lGmCq8Vm5Qt7WV8cAyMAG2GY1D4kVT4dFy2mGPDD1iCmusB47NcZA1bgu9k7Q2Pkhd6FXI4JIkjIK86webJ4gJjqFkjRj3i7BKseTvnsPZ4UfHu6EjjN3sLI1vAPd4/NS7AKOYJwY+1lfgixDDNRxaKYtWs3bVrbVCI9BPJJfjfKXjD/1mpv6jQvZz/KJyLJ9GXqO3HefsGLRUS3yu9Wk0JiDR2Ct5wvsiokv6VA6pWHaJemIayh9KurIGbfC9+JrYB6Q8grxADYVmuRgq7obVzq18T869Co49nezG1soI4Fq7hjPNtIdxM1UbYmxnt5OAh+TCJ0A0foGSgUK9ZiXSwrcCYx63SRXvz5XgADL2MGXeHEuBiLLAi825mz3AmCGKl+IWUIfeygMFvscgj3zzAJaQEqhtzPYsCtlY+hYPLtc4M7+pQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(376002)(366004)(39860400002)(66476007)(5660300002)(6916009)(86362001)(52116002)(66946007)(4326008)(16526019)(66556008)(478600001)(1076003)(186003)(4744005)(7696005)(55016002)(8936002)(316002)(26005)(2906002)(54906003)(956004)(3716004)(44832011)(38100700001)(53546011)(8676002)(102196002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?19IjEn9jh/PCCW+9Smo/G6NKOz22MkCnYrmmvMmxfoh4l7SSSPbFBFfVHEJn?=
 =?us-ascii?Q?15ZTsRW/EBOtEf5vtFWFIBl614BSpP5BYyEcJlknEpvoa/XhCQl/2lpVE2na?=
 =?us-ascii?Q?0eZegp6X3Uj2ph6iKNVbFJbUowVMNsisqBmguB40n+DBX8TpMiCC9mVdD7B2?=
 =?us-ascii?Q?lIpwnYyIeBcNxFUn0ID0GaZyvr9+hPJrlMHrxJ6Men1q2PN/njYeaWWhL/K6?=
 =?us-ascii?Q?VgocxkQhxtMA4jDVeH2gZVbANvmbUR7uIsYzk+04gG7l8ksrHePANArzxgJG?=
 =?us-ascii?Q?XVLa8KGLM6cMgy0QNrrP71hJwLo6JnfoPl2YccIw1uCE9iEon6BxY8Yudos3?=
 =?us-ascii?Q?vCo2F+2gp5QP5UgIUXJJbqWVpuhy2Ce/3akfLBDwuzrOQvFxTLpglWcmOHa9?=
 =?us-ascii?Q?YDtWD8xOe6O96JtuwyShCUK25vrpMNEL4v7Ui4eTVHk50c5Zb5Vown4S8A5x?=
 =?us-ascii?Q?/IXnEWn1verc4lt0qYqMxvsYI7IQD8u+PU23xgeeAtsOwfAc+zxVlPlIUMNe?=
 =?us-ascii?Q?xNAgywDqrfH484Up72JVGbo+oTUeC7A91ISaK4E28H1H3FPN+nR/L84eTtIM?=
 =?us-ascii?Q?uXXvR4NgPMCYcIUyowtRVleHKhID3TN6upa4ECVAqE9a9QjUGfsFhd9GKmc+?=
 =?us-ascii?Q?mmC9m3tghahdjC3wjkw5a2J6NCZZHobPQQi0EuWCx+G+48HZaoKGVwfo+8aS?=
 =?us-ascii?Q?YPuB8NMbQvCwsv2tP7UvzmmW3q1541+8PhgR3wC74oKnqEG+5cdoMJgr3KWS?=
 =?us-ascii?Q?9F5RgvQv6XFZTDGWlu4gfkVrzhWL9M37TYgD2znbGMDBN60JekM5NAasdZMi?=
 =?us-ascii?Q?0ck4m2sG6tHDIMnkrWZBR4or7RV5mecNc2WqXLZUp1X6bCLNRB1z1OmX4Qb5?=
 =?us-ascii?Q?zVKrFTu3HrsUVoVP+cFXz+N8B5SvmfVdVR5BVYlHjUM6mnV8fnNMVf1evMPZ?=
 =?us-ascii?Q?h36iZy/M4aEb6Ytscwr7FlwXoLGbf/bzL8gA1vhppq7wx2OWBN9ayXA8GfxY?=
 =?us-ascii?Q?VoWSmySr4qtlzG8mF+r0tGNUHStwi9IdTn79ToDvY4iKfgQhvxjb8eaCCMaP?=
 =?us-ascii?Q?dlvbJB79eccRjRQhNatBGslW6/Y0jPTAtLVUbqPazbPelbgsCQyVEypUVkTb?=
 =?us-ascii?Q?QjEQE4T1Q+MJIVfW4OiIxNpM/ki37ZAWJWtvW3sALcA/kTGJZVK9xGDffJYc?=
 =?us-ascii?Q?yhNHkpjmxIwGQCrwWYyIJwjvoPpnniatxrFWfQ9fsTBGU/vPVfztLSJ3PlbN?=
 =?us-ascii?Q?hiBQzNHkZg+9c/14rV1zYYUnViYnM/UtEy7VRSKTcMq2Bp+CE1uN24JMTIkz?=
 =?us-ascii?Q?e50flQ91eoEXGzaW7j45+ryu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf0d54a-32b7-4282-dd1e-08d8f136ebd1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2021 15:42:26.3600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfV9yD+txOr2gzvLkma/i5l8luZhf/T+pZLNcQrGU9Q8W6L5XkbWAaPMWDbeQ9ld1GkPd/CZFhTDmE9AAEJdow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4414
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9935 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103270125
X-Proofpoint-GUID: EKiZnbOOh8R1Pgz0D8NNDnLrbAN82dUN
X-Proofpoint-ORIG-GUID: EKiZnbOOh8R1Pgz0D8NNDnLrbAN82dUN
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9935 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103270125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 04:36:01PM -0600, Jens Axboe wrote:
> On 3/26/21 1:22 PM, Tom Saeger wrote:
> > @@ -1153,6 +1170,7 @@ quering||querying
> >  queus||queues
> >  randomally||randomly
> >  raoming||roaming
> > +readded||read
> >  reasearcher||researcher
> >  reasearchers||researchers
> >  reasearch||research
> 
> davej brought up a good point that this one was actually re-added, which
> does make sense. So don't think that one should be added to the list.

Ah! Good catch.  I'll drop that entry and send V2.

Thanks

> 
> -- 
> Jens Axboe
> 
