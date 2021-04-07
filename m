Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87673561BD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 05:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348245AbhDGDGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 23:06:17 -0400
Received: from mail-dm6nam12on2082.outbound.protection.outlook.com ([40.107.243.82]:60289
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229637AbhDGDGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 23:06:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sa6w43gZ2ebG/3DevtyCmE7gggm1SswEg6zSzeniG5W8HkYM7vZDCBWi9cpx2kexg/Gozw8en9qH3LqLI5c+c3Tt+DEnqKjBI9O2nCj0y9bk4zbI6525yCs9NZZMa1xiYZzLCMwerAtm/IF7C4cVMHRux92gOoJuBonS78U4D87Rr6GyODYYH8Oiucj8DNxyNjqH4doNo6EpzAX+F6aXGODV5apYisERAqD208UDytZQHIHxqVg+zdjTwMJ2pvm9RG4070qEHF9Hd1w4KMLRx7H7XtVHmfyNVPB7Cj/yQkPUTYcgym+Pb/fVXccG1O1nyPC+ypsdQI5i5l3UXBE8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrp0HCkptN9ckHfv1bxO2iJrVNyKh/ARO50aHWtAq0c=;
 b=kWh8S75qHAlXzmHadUjiWY59GQ6wAMUhh122nPeQQHopYRAsFyhM5xH3/tJ3BaTbTrx+7VdvNPnCAD1FjgCgOuKJAc7BT279AYHIY4LPOf2DPXCjiSwMNFjedPfsULA5GEQs7ov3s1wEg9WeqlDGnl4vjOLFwgAva18/usiGcYutwfs1wkiMYAkKCR3J7UHw/GVVMY1RWGiAq/qeVeg9/5fkZQTlVDvBYfKPeYazdTlM2BPx7hcGYA6GpmUoNmUFcJrTECrIFMJyr1eCe4e35N1qhbmu1CxNFYEz3j9l7bveIcNbvsHV0In1dRPMDWzNzJMQqzBrVZLH77BjLMVgjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrp0HCkptN9ckHfv1bxO2iJrVNyKh/ARO50aHWtAq0c=;
 b=YaQ5cU4txZMInirAx+ywf5f1/H8K2ACjdhkGFsh5uSKB9SofimPPRUikUtSiTrpXt04hx0+P6qPXj8+btGNhoFNHGlavDXXpqWhfOin0EbtzbA1rDEW9w0agFRo1l1vdOW0Hzk0nKb2cBH7b2SeTwMmBCx+OkKo5mnehNzs6xo8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by SJ0PR11MB4864.namprd11.prod.outlook.com (2603:10b6:a03:2d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Wed, 7 Apr
 2021 03:06:04 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 03:06:04 +0000
From:   yanfei.xu@windriver.com
To:     shy828301@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mm: khugepaged: cleanup and a minor tuning in THP
Date:   Wed,  7 Apr 2021 11:05:46 +0800
Message-Id: <20210407030548.189104-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR03CA0104.apcprd03.prod.outlook.com
 (2603:1096:203:b0::20) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK0PR03CA0104.apcprd03.prod.outlook.com (2603:1096:203:b0::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Wed, 7 Apr 2021 03:06:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21ab1600-ebee-4f16-32b0-08d8f9721481
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4864:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB48642AE55F60817F46B90F4DE4759@SJ0PR11MB4864.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eer4V6NC29zD/xIdNy3nwnEXnm73H7VYlpg2ZyLL7PfrXN57JaNXG39jU2omWMS9A8/Byyi12xaNOSBEzACL16osZTpVLmsdmZ1Acw+YJOJzSJuJ7MmQJFAo5rW5Z/+iizWkxmx11/VJOJALwOb5BDKyRgRCGBfLFp7xDq8FcvpaZRdAX0sf/ZU/J1NUC/xoNaowTblswj8A4pqhypPH1CHYxn1yWJ3T8i90Zf8fQ1nf6e+XYo0GUBIDvFHhjEgQQd3+dU0OPmAgQ08M7R1JesWtxYVL7fN+yFjjS/C7j5fwbQhd47qYvNyimt3H5KsMKazdDC337hO63bDexaTGiKsQxcEvdcBtDDRcgI8p6twkNlOlFonoQ6fzMpNEfUm9AWcqI7D2qULLW8eu3/pmBgyF1mi3pgGdMVLEWzs7eUKiMR/I4xlVNUe6CcC+sfjcdK5hI3NMsdYQB24efUGpK7R9vIVx6utIOr6xGw2HT2IfvDO58K1zNJlweLv/GTt9D8itxNvh8vp6agy7wxI2FDojiCpbd0Nlhz/h2WHRDQ1vk+wU3vOT2x7I5r4CUvxykVWHOsUVZIZkwtow9PTmg+xX4zd0F5F9D1/v7+GZX5hjIWmrYd/+1H0KbRiOX0Q8JXJkwZEgh/FrMpPcFQKagXiC6yPGIQr/G4q96X7JXOYxU7twI0iw33vfw33I+Nz4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39850400004)(136003)(396003)(4326008)(26005)(6916009)(52116002)(38350700001)(66476007)(38100700001)(83380400001)(2616005)(8936002)(316002)(9686003)(6506007)(16526019)(86362001)(66946007)(6512007)(5660300002)(36756003)(6666004)(2906002)(478600001)(6486002)(1076003)(956004)(8676002)(66556008)(186003)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RKE688FxLqQxGFNcwqQCzCKDqxLM07LMeFP2q16AdlBIcg/5/RxkpPZy1UFK?=
 =?us-ascii?Q?0+O0wdqRiHIlsyI/981Bw9KsDy1KO1hckplOF9Y2ERjo4Rbu5jkQVpjIlvvz?=
 =?us-ascii?Q?VlUDaYJg91oNQGfKNdp5XvMXD5bXbCdkqflpO/ZrBsj0QpolKyrjOdt7BbqK?=
 =?us-ascii?Q?RSp9HdORg4IjAIkJ+gWMv2FtOuvwhRVm4RvRqQENspv0n4hVFBxeL/2vuYk5?=
 =?us-ascii?Q?3krCKxzz5+3Uwo1qrdJPK48wxl3IcXNgFt/UnmYrA/uzPWHHQ8QJQmqFhquS?=
 =?us-ascii?Q?r/CKKTIGdYIz4Yg/9uFK+DZbtKcX7DgYQZ/0xVnOQCcCmxgA/SEMwC58fPGk?=
 =?us-ascii?Q?D8nxgCz2Cjl2MvbItEvLw8UlKUIu+V+JPQWKsIZmPQpckSwe6wHCRQQ91i7z?=
 =?us-ascii?Q?Qw+LxRaWr10BQULcndWP7P86yO58QOrkBe0ewcMnVNLUX68REwmCDSNjng+O?=
 =?us-ascii?Q?K5jwCvhD/c9cMH2j0d9xvmd3eVxzV6GTvKTOzN5bxJoEc7Ko3fvvd4TtWiC3?=
 =?us-ascii?Q?t3szHyy8MQXF91PZ1yGznt4Lad5+KlDE8J49UKm5eNfP0rwgTxn3JyjsvQzZ?=
 =?us-ascii?Q?63Jbom8fx9zpOX++y+x0qnusJfJM+0dy0xQjGaH925XMglEtChwZpi1d4Zvi?=
 =?us-ascii?Q?GnaPviG6IikFzYyreLyIx8DejvfcsPtvz2OWqLHYOJiqJbBq6FCTfM6Nu9Gf?=
 =?us-ascii?Q?ZeFcgtST1HDJKlhMSXGxtGts4d10lieKWk5IbBJoPs+MhtDO037qs8afGlXG?=
 =?us-ascii?Q?3pwl7/euppFduV1lSeSajxapUk1/zDpTWMUoJhJlna3fEFz3BxKF/L1wz6nD?=
 =?us-ascii?Q?+ThwxYfku114DStUvy6KHx39UPecgRkmEYav9HTrKQJPpbinQJKHlOv00ANZ?=
 =?us-ascii?Q?cBQ7wUJ/GRQ9soiAMi7fCPYq3hB9TU3D3tIGWKggIMol0VGADnmmkzSPHLey?=
 =?us-ascii?Q?alDKwjyhd1y3IlvVMyKonBdfTlxP8Foso9rR3WtVBV3yAV+vU303tV4JLUQk?=
 =?us-ascii?Q?2Gh1erW3yzh4wSXRSHv/d0Ws0aZ7rKiklHUI7UB2/HyBjlTvrIJzv+xG4Tg7?=
 =?us-ascii?Q?/OF41GbmPtPQRKEM6OOBqR5cNKpRE18gsLiqSdGK5sV9E8VmViIHMls0HSr2?=
 =?us-ascii?Q?RAhWmF2YRTwXTutqb6e5c7e+6eLnAsf6aEfH77nDcgqEedz+y8qi7hV0tVO/?=
 =?us-ascii?Q?rFa+4G6uoo61fh4qQT7A/Rn4mSqy3u3USDJv55ZjqQCaGQkvgtOQ9Ls7x0qI?=
 =?us-ascii?Q?x+xsN3BMc8BCluysvpeY+nnvAVVeDF5vaTpMvnYtd7VYZrSA4QAO28KPCfy8?=
 =?us-ascii?Q?I6JPw66Co94nQmApOHDvDW25?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ab1600-ebee-4f16-32b0-08d8f9721481
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 03:06:04.3431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DdRVs5DpoUVFu8SYT/ekoOdirZyvR5B4n9iU6/SA6CuQG0s/4KiMRbNPC+hO7OPL+sZ4ef4m6qFZOxWew2zbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4864
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

v1-->v2:
1.correct the wrong location where the goto jump to.
2.keep the cond_resched() dropped in v1 still there.

Thanks for Yang's review.

Yanfei Xu (2):
  mm: khugepaged: use macro to align addresses
  mm: khugepaged: check MMF_DISABLE_THP ahead of iterating over vmas

 mm/khugepaged.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

-- 
2.27.0

