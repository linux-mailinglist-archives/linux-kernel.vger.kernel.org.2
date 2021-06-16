Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519C23AA469
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 21:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhFPTkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 15:40:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:42132 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229951AbhFPTkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 15:40:01 -0400
IronPort-SDR: QnLpxw+vlSqMDGh12r2Di5UP4bvRFngHDQH36Sq8JibNjPHXnJXaph7EJvU1zzoluOVv3kaBLj
 47I0pyEzs57A==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="206282191"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="206282191"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 12:37:54 -0700
IronPort-SDR: Empb73u7oEDuS3sVLPGPMg+TxOY/nwDr7WQNes7hbKQbTyyRP4llV2nn//lS78dnQQWnqvASQ4
 c4OvfaQ9mKxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="452473821"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jun 2021 12:37:54 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 16 Jun 2021 12:37:54 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 16 Jun 2021 12:37:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Wed, 16 Jun 2021 12:37:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Wed, 16 Jun 2021 12:37:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Si/2f9l5XzYgBPMkK+baQXSgsG2BKljI2gh0i5B5D3qywCVp1M6wW26HgUS+wPI6fBdQNliNwiM0/7tewpvctYwHxGDn3ZOU8n0Bcj9JgxypdrNyMRQ/uj+xlAj8IxboSbG8j16Br5uLwMFuFkG7yzpFrYn5OPMdcmMsqFgXAtUnLtrV9Z22Bxdw5WyaPTiqaV+WX82e4+fHilwx9ysLqIgXanUAHXHAYFGGLYuZt7vP7Ix+lX3p4vOMO7lWBgXZfByBGaiJiu5zaXynMYZ+D4ts0+mi/8YCUaK3y264bHEIfvCh5Bi5oVdD0Pj/kngRsSDT/gohF5VaDZwBMZBLLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DX6WZW32180TeCGWMQ0jOHCY1gFm4Bkxw2i0yRnUeeA=;
 b=JfgIg6SwPborhErgXkKzJYLRjB0NgL/RKo/Pr+bZIDXfhOhTWFRHyvzb1k7UTiY1LnuWjNdmBv/S47R5TsswuqVxQ0mHOuMrYaP+f0n8OxuGx9q5JUxCWFUbt7iUVWO4pgP/gHWb1GlSD57bai6txX9NcEANrOM0i5iHET2caJTvbhPP3esfIM2dvpKjusqVEHEQKmDS86fowPi8V6dDgNQATdBeOvlwLTVcdVGUpo4J4HYc4FQCeY35hu6kIEMjoOl6ILEy/iWQUN8dyZ9SaXfcu8xk7B6I5QeqtATjS44ZidYJsnKmV40BuCZ3dPUM16V8X6o0DFi7SyoJyYnM9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DX6WZW32180TeCGWMQ0jOHCY1gFm4Bkxw2i0yRnUeeA=;
 b=Fzw6fHbyiiLgzgX3QEoiQLOhencC0kzyUh/yUDudAHSjxbvTkPJvmHiv2e9Pv4Jxjnslk+oOMpCSIHL+C8yBTTmSyg1+U1wV39LJZIH85zOAaYIDNjQ4yEtI03367cBdCLgBcQ9vkGj8VqlmsnPXDvvF0HlbJInlR8VLiZEgdc8=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5014.namprd11.prod.outlook.com (2603:10b6:510:31::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Wed, 16 Jun
 2021 19:37:50 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::713b:33e5:9d50:194]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::713b:33e5:9d50:194%6]) with mapi id 15.20.4219.026; Wed, 16 Jun 2021
 19:37:50 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>
CC:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 14/28] x86/fpu/xstate: Prevent unauthorised use of
 dynamic user state
Thread-Topic: [PATCH v5 14/28] x86/fpu/xstate: Prevent unauthorised use of
 dynamic user state
Thread-Index: AQHXUAs71FpA6GLTCUWvxGMv7m3G8KsW+QQAgAAdOYCAAAnJgIAAA/+AgAAGI4CAAAFxAIAAAn6A
Date:   Wed, 16 Jun 2021 19:37:49 +0000
Message-ID: <40E436A1-8729-4D0A-9AF6-579F9999CBE8@intel.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-15-chang.seok.bae@intel.com>
 <af093744-6f68-ff51-f40b-4db234b363d8@intel.com>
 <872cb0a2-3659-2e6c-52a8-33f1a2f0a2cd@kernel.org>
 <36D0486A-D955-4C32-941A-A2A4985A450C@intel.com>
 <48e86785-838d-f5d4-c93c-3232b8ffd915@intel.com>
 <16681A30-59EA-4E35-8A51-CCD403026C92@intel.com>
 <6cdba263-889f-ce98-b7da-4a1380cedc65@intel.com>
In-Reply-To: <6cdba263-889f-ce98-b7da-4a1380cedc65@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0d7d6da-dd10-47a1-1e89-08d930fe39f5
x-ms-traffictypediagnostic: PH0PR11MB5014:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5014FB8BE34E374C8EC597E5D80F9@PH0PR11MB5014.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vddYMkC2M/5osf980+0qHK76iZrhsA+CesKL3zIQaBWFGulH/VR2iDK8LnTH3ORHTmPzGJkfKwaoNrTVE4pjb4QqtZYz2KG79LI/0zEnCYINMkRhPLZB3gqyOJDyjYPn/wejtV+m6xWDPQa7exd13gP08Wmzj4TLAApBiqY9ioDBoRGbt9pyeuLymFrbJIJN8xbjfF/L6naWxJu3C7mEqMxT7TIWI3lxpOA1u6kY2PwcoFHprP9qaPuK4OcYxIK5cxD7XrhmFQjfTRqYVd/2hfqw8y2KOnRK5KTqWzoi/RrOIY1whRXrzlfFxpLUME1fJPb4+Bu/NVivKB79RKAfkCakm/628RgStiPwkErkM57/W1J+KG1jylevKqxdLzcT6C+JHpT8zml1vg8/wn/5Tsei3ipP1c6xXxEn22YMZOjCOz5qXkEBDHKKpOTYW9guzpKWi+QvDREchlhvPGdeaFCA4UM82W6b9NwckRR/2gkdt37hjlQEjMbIXqrGOURGs1fWucMtrCjeUjSHh0ZW+8wFrg97JkBbeFWnBbPgLdnwajoBZ6RFyrSCGX6ZPl0whEIuj8n47wHE7f3JWHMnqLtXBnrvBrzoU3brtCHy1GkR/ZKdw3CpCEoHEcj0WpcG9hdXSneA2fCUoJ8KBf8PZUbo/KBFOGskZYz3KIRDYNU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(8936002)(4744005)(66476007)(186003)(478600001)(2616005)(2906002)(316002)(4326008)(6862004)(38100700002)(76116006)(86362001)(6506007)(71200400001)(66946007)(66446008)(54906003)(8676002)(5660300002)(6512007)(36756003)(26005)(66556008)(37006003)(6486002)(33656002)(6636002)(64756008)(122000001)(53546011)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?//ywtN+619Tfnq2ggZ2GDasR6wSNR/gFV29K6G8pEV9+yuevKuy+Q1rd5ORd?=
 =?us-ascii?Q?0djzFPbNxllXxDw9/6kyWNDD6FaMR2ddlXP+B8RSUB6XTBHt+WgOQ6u2w6A5?=
 =?us-ascii?Q?IFFI6/m+UbOMZuKpcS+5zqSaVqNzGMeQQyp0QKgeQpnoA3Bdgsb33UWEcHas?=
 =?us-ascii?Q?MaGpMF/+SMYL0rBiQPEfG8hSjZnnvg76wLDhCLC6UqK46bTSpm7WICmnckIN?=
 =?us-ascii?Q?cjcwUdDx8rftrOew70Rkq3yCki6hrygiol3/Y41bn3DuewxPKIfaHzsUPGma?=
 =?us-ascii?Q?beiKDRwtcIV0jvClVYHougz9n2b36uqip7uxmm667dRyRy0tik7g80H2ExA0?=
 =?us-ascii?Q?zRZXgcsafqmCfhhi87BEBwptBOmIY/hh+G4YBvqC7po+SldpiDaAId+cdmfi?=
 =?us-ascii?Q?3iRkNMSZSJD1xMalBgxxmxfm5HuYgpgt74nfmGNIM5bYUm3cRXxXPEQGCp0y?=
 =?us-ascii?Q?16pWChacKHjsEhJ9J+pgNBHXOmbs/Ob+hliiVZqEpa4h1ufwD0d6RDuwzJ3p?=
 =?us-ascii?Q?Sconl9SBlgCK81YVrBIMuAuy1t+0qgRW/IAE4Ol3CXAo2HfFgVyQngBzrDaF?=
 =?us-ascii?Q?GsIcDUD32palC0YNBNqkfX36GDr14ymlyrd6ZApBsYXCdyfoOR+w7YsNaal+?=
 =?us-ascii?Q?XpaNetyPX5msJG0lrFIepHfBcqL8tPRl9FFo4QyzkKjr9GMR9lxUlUCCDOyD?=
 =?us-ascii?Q?pnGWJc3O+BOurKIkMwxjjAn3zMMkfgyR81fATCr3DhFGNCmhXxG/FMjg9vgD?=
 =?us-ascii?Q?VobdRBpLPfH2JkqQdqoFFSKImiu7F7yc55kncLbg/gf+Hpz0qwNOfb3K0aX1?=
 =?us-ascii?Q?AQKLDVhWq80vx4ZPRIgJtK4G6uQ4JUskMaUAYWfxpsBe9WrJgnuvOd2cCdB7?=
 =?us-ascii?Q?oF1uWx7QeVHTMATHmhRX8hU9//81Yt63XjOrO2gzBpbhVIHE3gvT+fKlmHlN?=
 =?us-ascii?Q?ZgOg9IWTfr6INLBwYB1hRWKpNROJkrzQHs/YMkh9bk8BZln2O1j2ZX4saous?=
 =?us-ascii?Q?Q8/A1XieUtplq0vs50v7T/tHgH3cq5vrWExyKI+ruBFAX8FY2eyvmU3dvo2A?=
 =?us-ascii?Q?H7FQ9bIEIkGeevgZ5bQmGZvgOyF3KtWakM1TzVbwEV5Bvontdc+fMK39+H3j?=
 =?us-ascii?Q?v18jgyx9Kv32x5EICsWn9SYKWpvrSfKN2FoePjhA5XBekvnPwGrSdobaSA9h?=
 =?us-ascii?Q?jViVsCyHprae0gsep/ECtuE9zj5cBdSyq3B6JKfrJKOczy8JaNz6TnOOG+tV?=
 =?us-ascii?Q?PXJFkj6H3M6tkqkpwfxP9sXTfgPNHNK6GXbkMVn//nBj3w4QND1A55qNFqDR?=
 =?us-ascii?Q?SNXfebFCYwROW5/jBA7XIyCVDe5wLuPGdH025fWZAn+jVw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0ABCACEEE77AF940AC63931D93C8ACE9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d7d6da-dd10-47a1-1e89-08d930fe39f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 19:37:49.9796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dhaYVA3ImQiaK3lsQ9qlvVFwNzYgHVujQ9YQ1s8IgLTsh9pxtP3PSH+mSUpOsgqRZe5OJryqd3SckLv1GUARTgv7x8ZFvzT471Vg+R9jkho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5014
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 16, 2021, at 12:28, Hansen, Dave <dave.hansen@intel.com> wrote:
> That's odd.  How is it possible that the performance of XGETBV(1)
> informed the design of that patch without there being any mention of
> XGETBV in the comments or changelog?

Yes, I admit that it is wrong that the text there highlights the benefit
without fairly mentioning the cost. I will make sure v6 covers them all.

Thanks,
Chang
