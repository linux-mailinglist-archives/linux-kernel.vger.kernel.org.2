Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3000372CA7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 17:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhEDPB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 11:01:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34658 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhEDPBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 11:01:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 144F0TYb189808;
        Tue, 4 May 2021 15:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=piOE8ykAd4dADZh3Uq+y4uQbrrhGhgXgs6R9gMQ3j5U=;
 b=csLM0tDfJl3J3UuM1pYWNAv5k71OODZdKVgzuyDpYFJMViE3e1NNTriUtG7a6vFaR6uy
 CxzcF15ymZcCyO7yO77UJVS2aGw4Mk12Hky6W2hkMt9sBjgg/yXmn9Tb3f2IbXRLjZZw
 fXDJrviCEbw2AwlI25QEZbYqtq0bLvRq/Q9Nq8tMWq7QlTUMsAIPYAsQUDQ7Xlvo8UL+
 CGz6dcnkl3z7edJTITCw/SBbazsN1kuan2yD62bKNMmWAyhPiEkeSe01lavLq4mGGPBV
 vDkCn/ZufGZLgIENcpsZeUzNPTN7fkM4ZPIV+7d7r5L4/1QfkqPFrBAOQ/YIyC9N9Fte lQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 388xxmy8uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 May 2021 15:00:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 144EpfNh126649;
        Tue, 4 May 2021 15:00:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by aserp3030.oracle.com with ESMTP id 388w1e58hx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 May 2021 15:00:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tf3W4ZhKWHZCmwj5CE8ZYmXIlptnvO1XyzJbKGYu/tl+M9WWB31oivedk38kxtO/hFsGyqS9lr+c5fVu8eMnseTzSELnhI95z25Bwjc8VnuCUIJmEgUMQrL8AlU8R/5ER9AGHUhRxCOcATtdC8u7exubiepkNQ48rYbpw4PPutpWcv6T6GyUPp+Vh/emvhg3kSljfSxV/gAXhsyAhtgXrxyOlKh2X9oqATNoNZbJRrtgivweGjfDiJEWJ0QgJbjCAtRv54crj3fEghSKYeIyWsPXo8xA8JCMmYSxN9FqglFA7Wt1wvEM98KiM5Nu70JYYcGwimb4zXbeILqZAi7Z9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piOE8ykAd4dADZh3Uq+y4uQbrrhGhgXgs6R9gMQ3j5U=;
 b=csdVsRoPn2LCRXcsEJutBES/+N4Q9SDx77uYqcNMwXUXI6O6Zal9jWJ58dFodeaFQdZu0Ty4QVxX+ICTDTeD4K73RuOUEHpj7t4RirBa42I6bRiWP6hj5ehgk34CAxBN+2OxQedm/j345i2UXaaLKdoiCaU8m9syjkMJVE44VUc9LaPkFrG1Q5XhFaExx5mh7u/6rolk7Cp4mEvNExD+i+P4kYJBKrsTGVRgrRGB3SUkXYWqqIDWyoWX81zxYZb+Fp79y7ZJ+BvomQvkiIDZmyiSq6DZXfrm3/iB10nk4RGRsgB2/ALeF081IhaAL5xFYShusiXqSgcZlX4pZKSvVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piOE8ykAd4dADZh3Uq+y4uQbrrhGhgXgs6R9gMQ3j5U=;
 b=jnVOVcR2e9b404OI35R5izWZdxLrMvTQp4d3b3gxUd3d9gkyMzuwBj8USgb9BDw3dUozUlrziUPGOx2JMKh5fS0RWXGUlboRW+3M3OsZ4N8VqrTMv+wWQs0IgGKWaq9MWgqpGS+3Kv8FAWhh4w9NqQhhwrQ+8b9PxiBEFbSl3vw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by SJ0PR10MB5405.namprd10.prod.outlook.com (2603:10b6:a03:3bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.39; Tue, 4 May
 2021 15:00:56 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::50f2:e203:1cc5:d4f7]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::50f2:e203:1cc5:d4f7%7]) with mapi id 15.20.4087.043; Tue, 4 May 2021
 15:00:56 +0000
Date:   Tue, 4 May 2021 11:00:51 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] (swiotlb) stable/for-linus-5.13
Message-ID: <YJFho59usXdyDU8O@Konrads-MacBook-Pro.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h6lNsGGUmifdWUVD"
Content-Disposition: inline
X-Originating-IP: [138.3.200.16]
X-ClientProxiedBy: SA9PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:806:20::13) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (138.3.200.16) by SA9PR03CA0008.namprd03.prod.outlook.com (2603:10b6:806:20::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.39 via Frontend Transport; Tue, 4 May 2021 15:00:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a0e0751-ea5f-413b-bbd7-08d90f0d6ba4
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5405:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5405EE56C2B73290E3DE1708895A9@SJ0PR10MB5405.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcQ6k9xPaXyr7kBdkaat78NYkKgLGo67e4K7kAtQBpJD0z8yVzWZ9F9l+mlfKPrmjCAu8eRS7wyx2D7SoyDW6KMAe1/61Vy+Dqkn1dC1x92/Ov8YqLoRg6xIS/vcVHH5mDo17XPpA5owsAEWUg5ybzlcna2/yyN/Kf793Lj5KehzbC4+Fai35LM3UzOT026JAXYhdeD7jlWiyJzNb89EK9OrkfYqFoJRmoVE72FDanDlK1gHnT+ZOaKN1U4mpIBuVYwIyHR7d+D/Adfe6KiEX+LDhiLhBpA0R4fWN2O+qRG5biSRUjtkFNKgrWb/RF7We1ypprmm46bDrJaY1nRjabCNRsrfjdhfbDLXemhFjSJGGyq0LJn7jqQeKWge9Yqhs/gfWEJbjZdapvHnnSX/Ju+OF7plI2TeImXP9ad8JaFHu1kQyM7CpnUzLn+ya6f/Vy2RflRp1kTWi/XSdtqPQhmLNnk2w66k5jqhEHjdyKxF9p7gq0Ecdj+cctlupHd2lIQIEt3WhQR+Anl2Qi0hNVSvrl7QiVt8/jgobl3nKoZg7v3bQtmmTXTdp9F9h5zTemIAfDwHao3hdmmR/BsOvrhO56RK7spUD43MTfs76ThdiludG0lLXrOQULynKl7443GzpbTqdVqizoB5oUZW2WZQ4hkJJw7ZSN314+9fWlqz4YHMav/VSSYj1SpaTLua
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(396003)(346002)(39860400002)(26005)(21480400003)(5660300002)(44144004)(86362001)(38100700002)(2906002)(8676002)(6506007)(16526019)(186003)(8936002)(956004)(9686003)(7696005)(38350700002)(66556008)(66476007)(66946007)(478600001)(55016002)(83380400001)(6666004)(6916009)(52116002)(316002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?d6Mo7XvPflIHPKY0qCpzL9oP33Sq/1ESpLRa2PYdOq/L51siO8z+vqblDx2A?=
 =?us-ascii?Q?5l59vppjXYiol7T8PRXJx/igOVY/pElDEKsgMvu/Y2qhDLg8FWsNHNeohyBQ?=
 =?us-ascii?Q?eCkKMCGJye2JxUMAMXHYlT09Vh5XQbowHzUiRFXkqRdGdz2FaylSfJg+fgP0?=
 =?us-ascii?Q?TrL4kfc8XhDqK0BVNJWz9Ow1hWAwSnFr1HFOOByPZ4HA5VGMhq4CYNOFSVyn?=
 =?us-ascii?Q?H2AuQIQHA3tbKQR7IfkgATCMcItlZoFTBRxKeScBkbSg8+n8iGq/Qarz1uLX?=
 =?us-ascii?Q?QuGpFdUBvmhBxoziTGtyW1ZYcG17i3xGs3nDrFGYY2xlFhI87w2vlgz2O9tk?=
 =?us-ascii?Q?47455wX32WIAGs/pPLpEIchQroPLit49r6T/RfU0Bc4TYhTlkW2chOIBDkHZ?=
 =?us-ascii?Q?UA2tjy0a/98Xr/TM6OOvJs/FXZNyMK6Gi8WQZaDdSt5AeDxJxVsvQICxVc9S?=
 =?us-ascii?Q?3kOuXOZzRTli6bprfPFCKop85F2kFmeraCKroOQFasspyTbURQ1Z4fpQuWzd?=
 =?us-ascii?Q?qOtmAfTks4nTSlTCAlQ1ir0Lgr8aElOSlHUnbdPMcU/4FjfPgqfb7wAf3GAs?=
 =?us-ascii?Q?8leExREuE3uDTEJjtNhBwz9PMbRsihS7+kThJKMiBCrCEEUpp7TeYOXlWDq6?=
 =?us-ascii?Q?SwlDr/RzeZLOVGRXEbIqrLXE58lm6+5W0Ji4e3ZNQXHRvzwCTXdFyklAcjU6?=
 =?us-ascii?Q?dBHl2Ywo2/26YQvcTcdRlpaDD6bMawkjq44QDwn1mjcIzFYKSAWyseKjtw9r?=
 =?us-ascii?Q?/UsxDwR6KpKig0DMxBeSzZ66QM2IRt6H8KQeXnk230OhLS92qSBx8oDqZdhP?=
 =?us-ascii?Q?C6c/4DPToJTSQu0gVUIxaD5Fu1wKT+FChBS14+dUxLv/M9ZrJ6KLek9sHSPp?=
 =?us-ascii?Q?3jMV+rHXiKXcdgtUzPYrzib+m3YjxEnwTL5Eq365KqTIjM37fUBj5b2n1o7A?=
 =?us-ascii?Q?iph1gZD7VesbiCqt+0rFaEuOYz3JdhkuV8bEQsP0H3SXCG36ya0IkVNAH6Mj?=
 =?us-ascii?Q?nZK3HjFP6uHGxwKzDn0LFsJExwu13a5nUcPqWs6ULydPh0pb4wdI2PRUKthb?=
 =?us-ascii?Q?Gu97u1odInycGwU5ahA8rYah17MxDem7KR8AY7hfvnLlrY4DGqUXh0iNtboE?=
 =?us-ascii?Q?RIaUKOgECe6dGN0YuY+WhLw4Y3ICfcUUpjVKQXUc5SuG/Z+fId3Olh1so/gj?=
 =?us-ascii?Q?tcs08iUHPZn57Nu1IuNVoyThFUuP/pgR8qxLm9kjoGvBMn/gNuRtI5qfGAXT?=
 =?us-ascii?Q?OA0Ei/T+mf9aGmLnWL4XGPZ/tbLfBr1A7v4xDxPNtzx4VzZLVg7cCDjvMrfb?=
 =?us-ascii?Q?LPL3srXm96UIa0SYsCkKlyMb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0e0751-ea5f-413b-bbd7-08d90f0d6ba4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 15:00:56.8363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTRAbo08glLIJPng/CGFMiqLUZmLzbAiliBBqX/7JjtGMNonAbrLO4DLhzqOxdIWvIQo4HyonQuxiBu1ieemCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5405
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9974 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040111
X-Proofpoint-GUID: vbpL4qOfhJguJtEzw-ehu6GNq8kD4S3c
X-Proofpoint-ORIG-GUID: vbpL4qOfhJguJtEzw-ehu6GNq8kD4S3c
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9974 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--h6lNsGGUmifdWUVD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Linus,

Please git pull the following branch:

git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git stable/for-linus-5.13

where Christoph Hellwig has taken a cleaver and trimmed off the not-needed code
and nicely folded duplicate code in the generic framework.

This lays the groundwork for more work to add extra DMA-backend-ish in the
future. Along with that some bug-fixes to make this a nice working package.

Please pull!

 arch/arm/mm/init.c                           |   6 +-
 arch/arm/xen/mm.c                            |   2 +-
 arch/powerpc/platforms/pseries/svm.c         |   6 +-
 arch/x86/xen/pci-swiotlb-xen.c               |   4 +-
 drivers/gpu/drm/i915/gem/i915_gem_internal.c |   2 +-
 drivers/gpu/drm/nouveau/nouveau_ttm.c        |   2 +-
 drivers/iommu/dma-iommu.c                    |  23 +-
 drivers/pci/xen-pcifront.c                   |   2 +-
 drivers/xen/swiotlb-xen.c                    | 182 +++++-----
 include/linux/swiotlb.h                      |  68 +++-
 include/xen/swiotlb-xen.h                    |   3 +-
 kernel/dma/direct.c                          |   8 +-
 kernel/dma/direct.h                          |   6 +-
 kernel/dma/swiotlb.c                         | 520 ++++++++++-----------------
 14 files changed, 356 insertions(+), 478 deletions(-)


Christoph Hellwig (14):
      powerpc/svm: stop using io_tlb_start
      swiotlb: remove the alloc_size parameter to swiotlb_tbl_unmap_single
      swiotlb: move orig addr and size validation into swiotlb_bounce
      swiotlb: split swiotlb_tbl_sync_single
      xen-swiotlb: use is_swiotlb_buffer in is_xen_swiotlb_buffer
      xen-swiotlb: use io_tlb_end in xen_swiotlb_dma_supported
      xen-swiotlb: remove xen_set_nslabs
      xen-swiotlb: remove xen_io_tlb_start and xen_io_tlb_nslabs
      swiotlb: lift the double initialization protection from xen-swiotlb
      xen-swiotlb: split xen_swiotlb_init
      xen-swiotlb: remove the unused size argument from xen_swiotlb_fixup
      swiotlb: dynamically allocate io_tlb_default_mem
      swiotlb: remove swiotlb_nr_tbl
      swiotlb: don't override user specified size in swiotlb_adjust_size

Claire Chang (2):
      swiotlb: move global variables into a new io_tlb_mem structure
      swiotlb: Fix the type of index

Florian Fainelli (2):
      ARM: Qualify enabling of swiotlb_init()
      swiotlb: Make SWIOTLB_NO_FORCE perform no allocation


--h6lNsGGUmifdWUVD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEQ66yPI/CGXuxfLixUqUOhPHbCb8FAmCRYaMACgkQUqUOhPHb
Cb/dZxAAjq8s07zUFwBBCabS6n1qqKnqGZJG1lWSb6bVS7D1I8Cn767P1MUQFChQ
3hjHg9h11KpMn7wdQp19wijtqNfb2JjJlBdVDytUSqPUDItD6sfL0b8Ohk7UBRq0
A9Mgnyl7Oap/DeBUESBbGHo4fO2B1ZwFOjn5xGoKbBz+P/MVAi0/5yZl40763YXN
M8S/1NNEEz9HnefgTqVq1jXnTwLdpfYEKoNDCnHchldddBKljTZLMEDzV80WF5sl
b8JukdYaiMe2Kh9lKGC+SJGZ/p9X03/jAGdVNyiVH440LvNYp8AU1guvywh0h5XN
83GGf1l5/+96/QrLfudKhRCJkMnSDObvDec4YlUydrFAw13IyYJEvAy3YD3Qx6PQ
28FirvFhNXhRwm3K8XxEKSsMY1f4uBT+lKKpE2JdZAL5VCY0zLxFJCV3ysG/XeAB
mIRMcgU2WxGs0sfogDAUo+Xo6pjGgyOLCvCJkfNbgW5Occ7uNbS7bnr+jZLnyPMf
v6ZJOH+tmalFeHvCr9CSlReDoJ6Xz+Jah6XUODzRvC5JrPAuFvT79FiafRchVXal
6NOlTpHO/9JllsJjRw6OBCbJTdepnwiWsIOxtNSbbFxdJeRvx0I42uoGsNmgiLbJ
1ByZuR/xujuWfFlG74pBN9GyVu8bh+M5tB3U07rz8i5XYkSL94I=
=i/ap
-----END PGP SIGNATURE-----

--h6lNsGGUmifdWUVD--
