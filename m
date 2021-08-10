Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCD63E5076
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 02:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbhHJA57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 20:57:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:39371 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231794AbhHJA5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 20:57:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="194404474"
X-IronPort-AV: E=Sophos;i="5.84,308,1620716400"; 
   d="scan'208";a="194404474"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 17:57:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,308,1620716400"; 
   d="scan'208";a="589091532"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 09 Aug 2021 17:57:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 9 Aug 2021 17:57:33 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 9 Aug 2021 17:57:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Mon, 9 Aug 2021 17:57:32 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 9 Aug 2021 17:57:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0Ykog1uQt/ZM10LorKW6xp/I1yvbmCSiFqJ0LGa/WxTXBySB50myLtvzZhSJzgxdb4EMeX5y5OzKhiAtFYJF9nhvpQu0/i/7bjWhGChsva12oQiYYZZX1gVjtX5croEOAul5rnTH5wkjx823GP+tknStHYW+htHHgyjX/Fo+jqPiakNT1IQ9fWeOuWk+bjr/bC/Z8mm/tW67HUTNmnLFqYcQd7mfntDk3e8JQwa2n/vVh/d6FG+xL0yNzoRKmItqCVNQ+lTVsT+jZAeQC4mGL/A5B7saTIHBJBxwJzzhs8P/8mdQe+nHcVeez0UJLbxPiBgt+zKN+P5xgz39mWeqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0PW1EdvynMBmM0UnHgiR4N3O98qMJktOm2hZDApgJc=;
 b=HR0rs/kJ2T2mcbjfH9naAwwE9PtEGezRahcAmFErnYw3egohS6zG2pgi4w7cL1vh3vc9yOYxBN50xaMLntBJRE3djXXPeZYWEbjQvzsu81oZU5wNJejQQK13LB+JceORh0+NEiYTkT6EQc57c1qxGeDjHJr4QxNmaE45s83AoTbVK5uDP8TiBicQJr7AmDk7VvtRnifM44HYutdzqLw+khAtdi9khxinR7uFd4drJhArH6XVIKm1+5TvJz9Tiqm7ddIAfdw/P3i1RbFOVXeEOBjNupwGqMM9iQFMwJ/HTOQTyxYQjYmdWTkrs9Hv2cYnjJU+tbHU4kKWaKjuCInHoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0PW1EdvynMBmM0UnHgiR4N3O98qMJktOm2hZDApgJc=;
 b=tYfbN6b/AN3cuTBvcndqNPqG+/CvxvN6H9aVcLt/LuHnvyWBaKzuqSg3+g5GPdQ6RNa+tm6YNuRlb3REt7EDcTNnWBOYYINSaQUsqLalf4lZU+xgEkWKVZa7AeUwz0Ffaj9iquf8qUcGrfFvqJir7inRwo+eTPDnwy2/0BMqNI4=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4837.namprd11.prod.outlook.com (2603:10b6:510:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Tue, 10 Aug
 2021 00:57:29 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8%4]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 00:57:29 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "Macieira, Thiago" <thiago.macieira@intel.com>
CC:     "bp@suse.de" <bp@suse.de>, "Lutomirski, Andy" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 14/26] x86/arch_prctl: Create
 ARCH_SET_STATE_ENABLE/ARCH_GET_STATE_ENABLE
Thread-Topic: [PATCH v9 14/26] x86/arch_prctl: Create
 ARCH_SET_STATE_ENABLE/ARCH_GET_STATE_ENABLE
Thread-Index: AQHXhVR0BYy4P9XafESfiMTncJD6GatmuoMAgAUQ8ICAABpTAIAAFPAA
Date:   Tue, 10 Aug 2021 00:57:29 +0000
Message-ID: <78846028-6D6F-4E68-AA96-1273334CDF93@intel.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <3718618.i2J648eyUT@tjmaciei-mobl5>
 <E9C8AF5E-E229-4BA2-AEC8-4289EF7428CA@intel.com>
 <3144206.qcAzhSVzjS@tjmaciei-mobl5>
In-Reply-To: <3144206.qcAzhSVzjS@tjmaciei-mobl5>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9365b541-0a15-4d15-2bfe-08d95b99d3e6
x-ms-traffictypediagnostic: PH0PR11MB4837:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB48375BD85550FF0612D7184FD8F79@PH0PR11MB4837.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZRCuGar5rnqtfSLcbsibQdcKwbUg7vXM8xWQDTy5r/XDKy6MIl4R3ftuA0I3odpMWpZbYL81gdxm5lSqRiGITeu8Pz6xh09BlXF04vgDZHsmLDDKYQwchTusj+EmD5ci1YY6GgefVJ+6Yt7qeFrOzfyzGHwFo3VI2H9x4FhrObTJfckHil68dfnkwxKOw5aI6hTh2YbKYMSZJeMuzr9cbWui9EO4V4RVeagQvZCgZX25NRGBl/B4MwX+CbBeOOsvJ3dO3Pk6lIa0aNqiyxTMyW19V5nJND1pSjKVQchZT1FGgkunUmPLLg8z3jsexJEJhaM8TLML2wj7YDBraMZNYldwF9P0YeVy4edvOp9XgqThqitMpK1KBUQ6XlsxB4sYUkrRT0RFgQiZJj7prxAqXHFM06lxMjiVyfjItr0ayoO73288hOfOFNo57CMXZCD9yeJFLVsFVtcIQHJygmg3HDYkezpx5St0omebWTgB+dsATENYe1zEthvvXIQlWbwqva9oz/m9J2MhwpQHm0EB/xX9/jhT6C1WGnLI1NMfLxe3lXjsPufOiK/J1jQYvevXSq7biosd7WnuY7rvnFcUqProgSKSkEd/sR7H5TTKwOXFGTGdxwr5UWMu+KS8otSolRKAEVmfY8Hco/mvNdvRhkpcBIGp/HgnYTdaGb+yVOmT3Zidv/3zF5OEmHkJ/D5+OGYsYpHGG6MStckjFTy5FgfiKzuUf4nIcULpqbXuTYPVGet/ix1frve1IxawNrGG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(83380400001)(8936002)(316002)(54906003)(26005)(6506007)(53546011)(6636002)(186003)(2906002)(5660300002)(8676002)(37006003)(86362001)(36756003)(2616005)(6486002)(66556008)(66476007)(38070700005)(64756008)(76116006)(66446008)(122000001)(38100700002)(66946007)(4326008)(71200400001)(478600001)(6512007)(6862004)(33656002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pm3ipGgQUF9ul7zr3VdxiPNFUjLvwIAGx7w8+7ZlnnWohy+iDjbIhz/I50/H?=
 =?us-ascii?Q?95JhIKw3xJ7xXNWHZ2Yqq+dUD6R1XyRHGtpmxKys+urB61gPQKoeurIjP2S2?=
 =?us-ascii?Q?1domXKfyy9iNBfBTg5wfXTm4/kKCNYWPwep8TKayv5trU2TIOGKLqXbvkCmf?=
 =?us-ascii?Q?qM0rChS0iKSbvlvna1sPdM3xufb8+AeYyGXD6lQfmo0kkBzdRqITcPzX7iy8?=
 =?us-ascii?Q?aT/tQ72nliqXdHH5qAtu5YJmX54+UX78QG4eSovr1Jas8jTF8afWAv43ajKN?=
 =?us-ascii?Q?4vWfTJ9DWaEZypoDzKy4xrZ36TRJRiVZcyScUmsvce5bm5L2x/oqOGBG+maA?=
 =?us-ascii?Q?USKLjkAubjTDE+8Eco7I1X7UnrZJvFX9rxS3TRoBVyblNA4ZPDgkXgt1PKAq?=
 =?us-ascii?Q?gqZdC/p7gr0qw+qnJ5R3EBJblhoN0nPwsfkSkKAo6WCJPSG8iTltJ//tghfs?=
 =?us-ascii?Q?Yf81/oTGpKRZeL38kvwDEwp6CaAOuqf4T5E+4JpsIPPeafGK0sHbo6dT+Q2q?=
 =?us-ascii?Q?rV3OXXka3Ydpq/virEF/H7m1Uimd45nP0EDyApxrwX9n4epvgNHqESm9zIZ3?=
 =?us-ascii?Q?MM/UW4cKUU8V2GBEsVAf/EpX4Gf2qW4MvP2NB1Wuu5qGU4Hy6BlihhP2VELG?=
 =?us-ascii?Q?V/dWXuYBa7t/PHHRgdQ95DMH4c0dQqFbACr7s/dDopSqz/oEhzEO1+soHNM/?=
 =?us-ascii?Q?8olOI/6MsazrsVbQzEPHTyQy+7z2hFul6Ut/x2waqILYMTOV9YijJ0fti2hb?=
 =?us-ascii?Q?jDpp7V3Oai56PSFYro3enaa6q07ZqnEyft9eENaj7gR5r3bFeuKLM8OU8+wS?=
 =?us-ascii?Q?hlAe79gLzWCKVoOFPP6TCNXpqcLj05BTU0Nwn6zi5wmhfGxJ4sW+D1iZHJyK?=
 =?us-ascii?Q?jyg56PbBQnyrt3rk1cANSczYj0ulRFxtoSH7drjcGCOvFGoAX8jPcv6nFfMC?=
 =?us-ascii?Q?29ex8zMNnzeV1wHSKOOItAQRaqTK/ScC9g66KeE78wwdH/qrPktJyLdCs+sq?=
 =?us-ascii?Q?Uw5mF6wxoG95zLkQWvBWc3cwmWtOdURnWGQOOLD4p903OtDlxQond3ehvjit?=
 =?us-ascii?Q?v24Q6Sb3Hug7lMuvV/NMccnnAbKhSDWhXoS8zLlV437iXn+hdmoh+pKOxr1H?=
 =?us-ascii?Q?lgAAfQ5z0cBOXKMABIThI5Ig96LFN3DUHJojfhWQwLumNTHClPFRPYmvWWsK?=
 =?us-ascii?Q?MZdeWIHCi6y5NEdifhqRy0DomupX3QDJ5WXi0Lc3aCQ3nhsKL7EH2McKi1zE?=
 =?us-ascii?Q?5lBAJc3mZCAYJyh5VI5xmJ4AlEvq50bURndmQjY3JNycJhQtSMnVi3PmOv4S?=
 =?us-ascii?Q?QPOThZd7c5ntyflRToyvfEYL?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7AA937F834C299449C1C3533ABC770B5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9365b541-0a15-4d15-2bfe-08d95b99d3e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 00:57:29.1194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +KSkAii7TUwWZrdcBnpxT3Nfn1LpT/jV/j7+6+RJdGivWCtMq8I/ko8uEKYhxyIqb7MFNI5Oe1TcOpaHI+j/AtD/v3RDSBOhft8fXTqolRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4837
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 9, 2021, at 16:42, Macieira, Thiago <thiago.macieira@intel.com> wrot=
e:
>=20
> This means the corruption can get worse since the rollback code can undo =
or=20
> partially undo the progression of the other ARCH_SET_STATE_ENABLE.

Maybe something like this can help here to ensure a valid rollback.

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 96056f49bcff..3468bc0ee654 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1353,6 +1353,8 @@ int alloc_xstate_buffer(struct fpu *fpu, u64 mask)
       return 0;
}

+static DEFINE_SPINLOCK(set_xstate_perm_lock);
+
/**
 * set_process_xstate_perm - Set a per-process permission to use dynamic
 *                          user xstates.
@@ -1383,6 +1385,8 @@ long set_process_xstate_perm(struct task_struct *tsk,=
 u64 state_perm)
       if (!req_dynstate_perm)
               return 0;

+       spin_lock(&set_xstate_perm_lock);
+
       old_dynstate_perm =3D tsk->thread.fpu.dynamic_state_perm;

       for_each_thread(tsk, t) {
@@ -1396,6 +1400,8 @@ long set_process_xstate_perm(struct task_struct *tsk,=
 u64 state_perm)
               pr_err("x86/fpu: ARCH_XSTATE_PERM failed as thread number mi=
smatched.\n");
               return -EBUSY;
       }
+
+       spin_unlock(&set_xstate_perm_lock);
       return 0;
}

Thanks,
Chang=
