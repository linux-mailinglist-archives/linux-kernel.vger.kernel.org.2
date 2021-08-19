Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9737E3F1D56
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 17:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240347AbhHSPyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 11:54:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40634 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240315AbhHSPyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 11:54:50 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 17JFq18v007897;
        Thu, 19 Aug 2021 08:53:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=m1SXu+0kg9hvB2Ts/oYZjakY1HFbExNIf6R0neCMpFI=;
 b=fFCsasIf57QJVtsWqUtcZXDSEMCsMjFYp7iiRUnSNsskRvzkG0GRC7X+D69/MvPiR1TT
 AHD2npyeg2Pfs4NEoz6JxtquzOAKvXirm0so98C7etR+kT1nNGCoCl4trNL0z1bwXLrS
 3BXAqXiFRnK/h2Wc73CXstUxAQGJ/K06PN0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3ahq08hdg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 19 Aug 2021 08:53:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 08:53:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZebGKNIBZxHc2iGWWa9q7EgI3P70h9yjeNAbaxyIObDuszP6bNEa4or0TEJHsxS/BmeKGl6WlX0IzJDK6kBz5SG7jBDYn5IGRGF8oEA8Gy90dybtulWA8OkIZ99hh+Dev1DGFkB9uf8WjqSN+DsxVxA/t7s155On+pgVT6l6B4vdRHHiavOBbMQLcFOy3owEehXvYQTtT3Y/9j3u/HKzyZzkOxUxoSDMKcsprmxsgXpSF9AuorHmuaHyCohCyilOqvHVXYHshg5J4jikQTlowXLie8ygicg/SJ4HuRH8BMfCeEzFPEtc0+oNhTaN8brL14dXu35ujVKpODiX3d3wGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1SXu+0kg9hvB2Ts/oYZjakY1HFbExNIf6R0neCMpFI=;
 b=P3/cjoeY42uD9AmfWPJQhD2xZI4fS/4PctJoz9e0coePovLkz7nkv+GqW2lfxVuC1QrR5EXt0MNthe5C+JN6yCvdXohYCmRfi1UWt8koupD4Ppvbxn9fj6dzV/50FoyDAn7tyN+H2ZNbNwf4Y6Eh5eOrWvfleAvZw7cTCjuaK5dJMJ596vUbUQff0fE75NgOkWFOhkWTvs0eE4TclsGh4cPWUja5wGo01QAF/b/1aiB2U9f2Wqe/Pj4mVHPEXPku56D3Jjvdq4a+vzCZHzLB+BJCnVPbb4k+n1bVCdeUK0XVWEJOw+d6dAE6Ss7bGuTkQfVipEqvRGkrjR9K+6XTsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3285.namprd15.prod.outlook.com (2603:10b6:a03:103::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Thu, 19 Aug
 2021 15:53:48 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::75be:c42b:c0d2:2565]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::75be:c42b:c0d2:2565%5]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 15:53:48 +0000
Date:   Thu, 19 Aug 2021 08:53:44 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm: introduce PAGEFLAGS_MASK to replace ((1UL <<
 NR_PAGEFLAGS) - 1)
Message-ID: <YR5+iC8KDQP4+6ms@carbon.dhcp.thefacebook.com>
References: <20210819150712.59948-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210819150712.59948-1-songmuchun@bytedance.com>
X-ClientProxiedBy: SJ0PR03CA0285.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::20) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:c373) by SJ0PR03CA0285.namprd03.prod.outlook.com (2603:10b6:a03:39e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend Transport; Thu, 19 Aug 2021 15:53:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae4533bc-b0bc-4d83-b16d-08d963298837
X-MS-TrafficTypeDiagnostic: BYAPR15MB3285:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3285CB771C825A0088919173BEC09@BYAPR15MB3285.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FRQsw7YZQbfoKrtpUyKkSPUsVut4KBq10OmfjPg+E5C0szqtPuHmsAgBlAoCxnVV9hW6nO6u4z2La4q3vTzoMwgb91nIdhp7msjU0z/V0J0wR1hDmILtZbVkuqgBUfWkLE4GZZQu57aPZW1IbAK6eoCuj/aETUfRuhg6DTioGoKhFyR4KmZ6HSoYtvt8W8KZNhAZBf4aQTEiXxdPhgbGpTo7wnGfuihGAyQ2ndbThF0YN6ExYWD4njD6a/gIeEQHPqy+s/h3V9AXIu1tanUtpqweH48JkF8D39oeyraY6+lKr3FWlBj5fuqCU2KJ5t63NymflRus7xyfK1k268J1cyF+oCbvQv5keID45X8x8uN4cL356brIz8J+BkDTte+MpBPpDJSsCaZaEH5AnrugkTnU2aqbugk5lzxAOWobUwBFiKVNmim1ZrEy3D5Se5UC2gXIKbyn53+hc5dBqxQJHZq6hPqGlPG1X3OnYCNgG+JwFLwEVNo77PrOTeGdGaY6TxSCV9Vp0zg3xcJZwil7RatrKLFmjuO22WesQ5BcFIxKHkTKPGSOrFXp5SKT4uxy3tO3JzoRzklzD+m5LWg0svsDw1VwD2A/dmgH7yxW+5mAKK76b7zq0Johid2xcEZptwpxT76PypYyRoMMUyrqQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(66556008)(66476007)(7696005)(52116002)(66946007)(8936002)(186003)(6666004)(478600001)(6506007)(8676002)(5660300002)(9686003)(316002)(55016002)(2906002)(4744005)(86362001)(38100700002)(4326008)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Wo8p7fmz64OvLm2DPlQO9MKUnaaIU12vFAtMM1qHG1tYD/GX0ir5VVL9C5W?=
 =?us-ascii?Q?i98gyDNXZ1uGqiJqHMDZzQC+7iE/NgXlBdPPZjYlVtMB80HBianrYOzvXfot?=
 =?us-ascii?Q?g+uZ+BKO49P9ydZnF/kMT5vFTTQNsgtER5P01QmY4p5Lsr3LfqyJs0+ZkwFx?=
 =?us-ascii?Q?rUFg20z57W6iCZi5I8t+m0Dw/F6Z4xnIR8SkhiHWiealCwknCwXLZOpZW1sh?=
 =?us-ascii?Q?Eyvlh3dhQ6YoRW1xG5F79ZLvpR4tsmDCm8KDxSNrt7esvWJxoQST9+uLCJe3?=
 =?us-ascii?Q?07u3KCKikf5c9wdSrlXC6wVt8vq3wb+osXtWmtsOvUxv84CFMYhmNvT+cufd?=
 =?us-ascii?Q?HoBvCat+IkgZp3ec0L0k8Ivz6mIUzoqU3R5MU2SbZQ6QlU7kKNrQ16b9+qIr?=
 =?us-ascii?Q?ctoT/5cFlDMw45QnEapFjz1UvDWGZzAf3UxgQkAHdYWoFilctoJdjF3t4jY8?=
 =?us-ascii?Q?s4xnbzm5fubUimG/AvnwSKiJs4omyaYQL2/m7O4FIIApBT17iO2WiX0XhuaV?=
 =?us-ascii?Q?6DNhvqSR9ncN4FbxIse1+DAwf1MueGIuzxuNmUXLP2grd6iG0j8pjSGT3dep?=
 =?us-ascii?Q?XhfFEpuSHzoG4QoeBgRP6GQ8tR/Bf5EnSUU+eNeARfjOBrBYxnjjTg+RWyhv?=
 =?us-ascii?Q?TS+zog4XZizkCcdqanIAGgrZaIQkCT25ku64RlqXKs9GwlNkChjjXW2kIyqd?=
 =?us-ascii?Q?C+6pQok+CU2R6nCNFaxw1wLygT+LdQ4zaxeojGgGZL6UP99U6lseZ2TKhwD6?=
 =?us-ascii?Q?GjGd/3epoSneoJUHX1XP6x3jWZZBtZ8spYtIGzRBowOR7EnB8DsGM5tisxkR?=
 =?us-ascii?Q?dD8XCyGCAHcl383+tIatJ3isJUn49HgFZEtnidefhmta8oRd1fwiDNKvZ7Vj?=
 =?us-ascii?Q?PJeooPJfAySj7zQE5hFgrwTAvNf1aCSV9bNZCYGP5uIH4CcIyUkLSn76jI8e?=
 =?us-ascii?Q?lmHuiPsP1Nev/qb0dK+Dj/Se25qusDqwKFzhvR8FicbA/cRCKNR5OaYz/sgr?=
 =?us-ascii?Q?vKINGmUAd7AxyjeGGePuD+wJWMtVlJU7IfTeHBL6wCxeUKZ7oGx3hO/siM+l?=
 =?us-ascii?Q?pE2C/L/SJ8D4lmINXQWg59eyOhtjpGa4w5lhMxvQisHyFQsxzffEmWefzKcx?=
 =?us-ascii?Q?cVCC/X64FB0tZn3F3HmGyoo9JraFAvM1j4N/C8OqZOiYqYgRXpzKfAdoHVhO?=
 =?us-ascii?Q?4tzvrE6UqygR1wCvzR/D4dL6QxsRIhEvWhUvBzOapEOwI61jJJDFvI+AzVNJ?=
 =?us-ascii?Q?9crps6dDLZv5YMLQqPrc5erPucxoftkEtjwYJcQB4kLaUa8YE3NLXtb75PWJ?=
 =?us-ascii?Q?M0ez1zSXbZ/Dp1C0ab07FaoB4bjeRTbzJl57gHH9u9ROJg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4533bc-b0bc-4d83-b16d-08d963298837
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 15:53:48.2494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GuAVUAFZn+9IkSxlKG53AoMoaMt0sANjapp8hIzV60/sesgiyg+xFvFuqa8y51L+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3285
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: yWeyHELTkyzgk8sehP9uzSzSnu1Ie31p
X-Proofpoint-GUID: yWeyHELTkyzgk8sehP9uzSzSnu1Ie31p
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-19_05:2021-08-17,2021-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=592 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108190093
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 11:07:12PM +0800, Muchun Song wrote:
> Instead of hard-coding ((1UL << NR_PAGEFLAGS) - 1) everywhere, introducing
> PAGEFLAGS_MASK to make the code clear to get the page flags.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!

