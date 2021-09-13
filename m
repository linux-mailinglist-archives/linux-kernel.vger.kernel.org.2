Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08790409C65
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 20:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347342AbhIMSjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:39:35 -0400
Received: from mail-bn8nam12on2077.outbound.protection.outlook.com ([40.107.237.77]:2016
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347318AbhIMSjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:39:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WywtbSrBEloD/MfTcIf/so9h9zbinRwkeQWaQzSOdE2V1YhbJqE6znJ2V3XjkjFvWegBb6udTjqLR/+oLUtidltcS7t4QSGvMRud2HU8n693rPYtVGGTqO1VUTQqdq1ERW+EA3iLO4jer6tRCyH8qQXuvkYXIesgNs5odNZLX7jRuO1eO2hVFyUs0ZXpSibVLeA+6hqK30TbMhbSRRQSnJKGcR3h4kVTjmhGATWtjdZ1lo5Uqt8wceRyQKicuDDHQbkYpJZzeLPmvfMZ9PW7QrQZtxLmXupdnTvH2e5duXAHqcOu2mT0ZYNHHHxV8UNlqzUxCWQTeMhpMa6gc1ixFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nblRSiDjixCKY2YMy9adS5Ijgq3+bkacNZLzSpLAqCU=;
 b=SU5oeLVDuDcaciGCRZkkYIa8cjVtKJqgA4XC6xMQ8goo6X1i53kjUr8A/yqCJuBvfWQXujOIZaBmSqSxcwATsaMTLJ4KwLxb7n0swFM2liZYIntpRVMJO6Ud1yVvzxvUadqOagtZAOaBLvL/2j4c1vMcPcrHBiejZTOMWc7+g0DF4vt3vQCLoRgUZiAJYIWMhsHMBVxVm8tj5etgmyQIGWA82HUb5hvl4ORiuWqLeIMXsKHId0Wp+DfkBH3aLNTuCAPfrZTY+bfE4HI6TFx+d3Kx0y0I3CoykaqTaB1ZEeRBDtqQXEGv0tdqHqGcSWYyGeUcDuOHVnU3K0mOQFEZvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nblRSiDjixCKY2YMy9adS5Ijgq3+bkacNZLzSpLAqCU=;
 b=tGgn55a1Lq0iSJg70OO9lrGMFQoH3p2AQzqsero8GINHWJ8pMKx1/h/Xanwx8i0bAPz/SYTyEBxr01LUyTdePsxMC4vCvP66DzO/sSVafbCs4tsi8u4Ge5EjdOSvg/uxYt6kLVLumy+aRCQXjytpYtWqZTCnhPZ7YIfbRms0yis7KXgA3gDUWYsLn5bmouIZ49wa6AL2hH+Y0rEqqdUt36SmtrZ0K/lytGZpsce/pkWdbpB0S1rcy4Q44nkJqVGdoBieDLf/kNxa9+aUnm8TD4iqAAn0vOYZtDtwS2osHEwdkfFscZdc78gFcuTbd0jWAjfiiTV2ACXrcDQMtKy1dw==
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5285.namprd12.prod.outlook.com (2603:10b6:208:31f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Mon, 13 Sep
 2021 18:38:15 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4500.019; Mon, 13 Sep 2021
 18:38:15 +0000
Date:   Mon, 13 Sep 2021 15:38:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: drivers/infiniband/hw/qib/qib_sysfs.c:413:1: error:
 static_assert expression is not an integral constant expression
Message-ID: <20210913183813.GY2505917@nvidia.com>
References: <202109112002.NZceUwiC-lkp@intel.com>
 <20210913165317.GX2505917@nvidia.com>
 <CAKwvOdnGaVb1XGwYpNK_3zAEyZ0JC1SDjC1UzzFEH=d_Mdi7Fw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnGaVb1XGwYpNK_3zAEyZ0JC1SDjC1UzzFEH=d_Mdi7Fw@mail.gmail.com>
X-ClientProxiedBy: BL1P223CA0026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::31) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 18:38:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mPqqL-00Gjg0-Rr; Mon, 13 Sep 2021 15:38:13 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 840e3896-4081-4372-1831-08d976e5a59c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5285:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5285B30CA921319A82BD429BC2D99@BL1PR12MB5285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HxrkLHHphZ7snV9sB2wTQwuhMQyZX0+6oHCBMGpKhBnEQRQHUDnzR8/bFb483FIt1eMXRDMfPMDz+tLesf9kKDXjhcZC8rDtzeL5qNbze7/bmBeCnlISkcEN/jEh+ff5/p0imFW7vKSB78s5MOJNMKORSDY0VfhQg/2BJZfxuv88OAsahpW9mlsUhI744rJ9hddlquoYplqjQqgnlKKww0u8xQjAOFGHEetd1fY3ghq7cUh0BT7UpMCl2Gw5ISVDSo8TNOX0VCIzV7vgIveFp04NBF9iL1iUJtJCWWBAIEDxpLCMOTdWV3PSPJafzw5YY+fPTQ0iVhkv6aOQdmT9ixr4LgYRzPEAld9kwjwzmX7wnKqBMtGCTx4urdUACJnINLqGeUpyEFWmvu9x97JWdnea2/X+JjVocJ9j9fvLaNuQADey+3T/UvyPcdM5gajKLsgFrK8abuJJ93GJbstKGUEdhVB0yDRdbsbhJMHk7JAZ6g6N+NCuD0bJJr/xsQwtMcYG5ZUgr5c4WvTLmFXARCVRPxFn+GeXAbG1qCRoZMw/MV8r0Af/0iDd+dn6kPyoqAiqI22Tar2wNUQcwUMuwLyop43oqrQDT5g6PStiwff9XhPJEmQHUStp9WuEY/r1gWiiSdtAznsc4OAawUS17Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(4326008)(9786002)(9746002)(478600001)(8676002)(5660300002)(38100700002)(8936002)(2906002)(1076003)(36756003)(2616005)(26005)(66476007)(66556008)(33656002)(426003)(6916009)(66946007)(316002)(86362001)(186003)(54906003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PmMTLZcHnkhHqkQLH+xbe+JjXVdtXIrVM4F8ci+c4i2pkRqZAF7ktCwH7qTm?=
 =?us-ascii?Q?TEHy9CEn0grMTCwK4ZkOTvfnvxoIK1juwkzzbEzso/bp29FiVYSsrBve1oD2?=
 =?us-ascii?Q?TMwX3URxrb7LCLad3tEbPk7ebkIkMRnR88EqVAEJoJoipa1zJnUKs5PaZ0vD?=
 =?us-ascii?Q?vvdqoJTx/QMdvAAHDmQOChLbVPFWXhRC2kpsEKaVvNpFmUy7v3dvrvVBU3Z2?=
 =?us-ascii?Q?Tg/6TzYiZd/lvHutWZRDw8Y32hDYC+zqACQjs4dbeiwDsjJ0sGJ/wW+HLXpj?=
 =?us-ascii?Q?sTl0AuZ9scZdrl0okWOafYw5EFcpZU+BCwr0IJm7Ql/VG6249sazZWM/Sj/b?=
 =?us-ascii?Q?LwroeTtx+VOlTsMtDQ4CaNgrJ0UKuTz3kmpsBFdiAY8K81i+benDySK07SEF?=
 =?us-ascii?Q?81rJCyA6V+9fpWob0SiEUSJxgH59KD+CAnkTyCrx0C9r/Mf0l0GSd9hNaXmB?=
 =?us-ascii?Q?9nNIUN8lfqHkdGdwODBDIF/b8LfSP36bbDnnPFOEu11fTW87NOP6ON4+i/r6?=
 =?us-ascii?Q?xIoHqLT3E5rJBblEtUJRdEf0+Q4xTF58sFon6xtpX2R2qxtXzhn+3m06BPAN?=
 =?us-ascii?Q?RPyEWZjMGovtyCfEYnU5B56EgUBWWb8OQTMRWQ0/gOaCMijdu4zFVCGrEOCB?=
 =?us-ascii?Q?fJCO+rVzUjwRhJABt6ihQT2b0tNjVdi9QIo0B/xG8kPe07nCwfMBLQbICLrJ?=
 =?us-ascii?Q?2JNujok+dDPWIgkRJcYH3+A7dh9InpBS9+BtvVzH2YOs4LJRunQldNUaUFsX?=
 =?us-ascii?Q?SyuldbFBH/kRR3Etg/VJFPnk8oA7UgGPebMPMf5mVxlFAP7x16Dm/lamBqJo?=
 =?us-ascii?Q?iVrQy/Y/UUPElxfIum2cs0C57vsvr8DeYLosLEPctZe6QVkxaiz1XH+THUio?=
 =?us-ascii?Q?3ft3kIpCv+EZFmKv4huwJwvF5REATfZbuWDJFgi+AWITdZoNLZ86sgGpSjWf?=
 =?us-ascii?Q?2wvcmFYMZn781oJPZo5JOFMtpxul6wKwkdoc8XWnN4xxGW751cQSddntHUJe?=
 =?us-ascii?Q?FRro/VYkv1vxMcuZxLuMjDzJlhKrwqGWIlLquM7HNGRCGz6XxKNeqC2X32qB?=
 =?us-ascii?Q?ScVzC5LvcVmOa3fk0cPemx6jIonf+JRreghxFZhK9C/xhgxApSusoMRuq80m?=
 =?us-ascii?Q?cECWEYZ/t05M3gULP+MDB0D64FpxfN1lvjqbe/kSwm+eUaQ06CotTTN0QEku?=
 =?us-ascii?Q?LhjjZ2hkMjKe61g9SGhJK9+xAP9aj48tQd84iaNy1cZp2FLQ0tWMJg9WjAZl?=
 =?us-ascii?Q?Uo49I3T5iSHEh9iXZnLKXry2NMpv0p1IyiakQtfzFWo4UoeN0W+M+y1FHuYd?=
 =?us-ascii?Q?PTSweYtr37xs1T6R02xW2loP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840e3896-4081-4372-1831-08d976e5a59c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 18:38:14.9227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETNpjFFk/2XphbDdRrtc17PgknBa/f6lhFzL0anarUJenBozcUy99vbvL/cm9P1r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5285
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 10:00:02AM -0700, Nick Desaulniers wrote:

> > This macro would like to know that the passed in member name has a u64
> > type, all the things I've come up with fail on clang - but many work
> > fine on gcc. Frankly I think this case is a clang bug myself..
> 
> Perhaps, though this assertion looks a bit like offsetof() to me. I
> wonder if that can help here?

The assertion would logically like to be this:

         static_assert(typecheck(((struct qib_port *)0)->N, u64))

Which doesn't compile because typecheck is not a constexpr :\

typecheck also can't be used as a build bug on zero in the initializer
for the same reason.

My original attempt was

                .counter = &((struct qib_ibport *)0)->rvp.n_##N - (u64 *)0,    \

Which is fairly simple opencoding of offsetof_end but clang whines
overly pedantically that NULL subtraction is undefined behavior.

The current version is this:

       static_assert(&((struct qib_ibport *)0)->rvp.n_##N != (u64 *)NULL);

Which *should* be perfectly fine, but clang explodes for some reason
complaining about -> on NULL. I think it is broken and doesn't
understand that this -> is not an actual deref but pointer/type logic,
much like this:

#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))

Which does work.

So to my mind clang is being buggy, and I'm probably going to just
delete the line and a give up on type checking here unless someone has
a better idea.

Jason
