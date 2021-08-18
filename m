Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F97E3F0C0D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbhHRTrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:47:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:64369 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233314AbhHRTrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:47:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="195992298"
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; 
   d="scan'208";a="195992298"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 12:47:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; 
   d="scan'208";a="471648109"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2021 12:47:16 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 18 Aug 2021 12:47:15 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 18 Aug 2021 12:47:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 18 Aug 2021 12:47:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 18 Aug 2021 12:47:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tr3fxldW3xOOu7dOggdrqkfzQpCk8YqHuSGC5Sw57VzIBxLV90bm1qwdnLt9gaacQ1gnIbJbHSjmgfM6Pz5mcwfSD/EfpkNv0KVNJENzTgRBh2aM7OFXkL5ajmSwEnGwGsVxdOqr9coov7tmiADnjsellGIDuyjhtjgmOJK+bGb3kxGaXO1t9KKd7T5Lyps2dEj3JyTGf4aVXTrHWpBkd9RnSskangnSTMqNEp8i20R/vCfmd/WOHmHrNEm0qJmcbZgZL5khRoh0hojtAn/oYPVkOFTVpmsLHqDk+kVbsCjVZAxfq/5WAD56AovAgDpfp/8ceB6/YnEXbk50Hbq8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJ+rm6nZY4s6Z5Pm+xKVB1LHo801jDnBlHNbPGwxQX0=;
 b=jCXzld7WSs0abnIq/g4Xyeq6FQ9Zq7Ao0Txp2I618qiSFAvDC7fhmedOG/Z8km1nOYzpQ6YAUTwDI2DqNZlRi9YfLVgYCaaP8iNBewcIlut5TIBZznSsyPQdsAL2SJ5WIiOWhwWRRFiNo1MlTigH0oqdhG/afCEXf2jow6w2+j07JvxGNUuevCvjqRLDEQx4rJB6McWvcrPiIAI3MtocoZQeG43n5jabPle7HAiAFJDKUiGHOGD3M0VTgTGPhpDZCCR5Se8tzTT39TVAEfSqK6cO90JqAfr1rO+6ol9FQtXS6zHdIVVhUmGAXMDpyKC+ihtJr+FvRYNzOAeNGmaP/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJ+rm6nZY4s6Z5Pm+xKVB1LHo801jDnBlHNbPGwxQX0=;
 b=JzFumrGk+idlOlefajqK9a7Ng3CuV5uCpssbBsd/INH6JZJlBN/nRE11XWtKdkDZOGAId+wO/tZfbmps+N/OFkqPYSGVeFYrq2Jk/k7BlFtK2fiWEBOcSiSg+YSQi0Lo1xDYIrJprDp0ALlTVyIOYSBxcdDNDRkVsi4i8q0fvSo=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5208.namprd11.prod.outlook.com (2603:10b6:510:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Wed, 18 Aug
 2021 19:47:11 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8%5]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 19:47:11 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Lutomirski, Andy" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 11/26] x86/fpu/xstate: Update the XSTATE context copy
 function to support dynamic states
Thread-Topic: [PATCH v9 11/26] x86/fpu/xstate: Update the XSTATE context copy
 function to support dynamic states
Thread-Index: AQHXhVR1hy0/NshlikyQUh2fxjRrn6t5R3SAgACBjQA=
Date:   Wed, 18 Aug 2021 19:47:11 +0000
Message-ID: <EBB61776-1C55-4C2E-9BA8-4F5D890A589F@intel.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-12-chang.seok.bae@intel.com> <YRz3EWQl7pHEahdF@zn.tnic>
In-Reply-To: <YRz3EWQl7pHEahdF@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c89305ca-f6c6-43b5-808c-08d96280f8b2
x-ms-traffictypediagnostic: PH0PR11MB5208:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5208201BF2CBC2F7B232382CD8FF9@PH0PR11MB5208.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LJTR89jNb7+yq9AGX+SBz5OkYmBmTHNaGOuD/+NndoZztLJ1md24Jt1Z3o0EcQWtk3H3As8qdAPsHrapInv+j5871qxiWyPTniMisb83vU+c8Equt25SfokXcduDypBAblLHx9u6BzDs+6yPE7xYp7JJWkJokPWEh8MAPfrGW28FLMz7Zf9eIVqFbIq8oLGpPCzoDXtQvC6V0HQDD9OtDhmAcL1IeShdHs/mZohT1mg21GsE8axT5WAsPwdLJbRpAjLAQOIHSq5+xYrAtpXqJjI2plLQH+tR5KGec3ZQJjSPBF8KSuLYalvJlHZYK6lFHRLj3s2pl1rVaAzOV4FvgX5wPWZbicPote9MN974oMdMkvfnjovhwv6koRPBA1odXvarD4yXyNvw3jORhMskFvV0n1beq4Y56Y5eo8qOOIZLraM4f7CZnk5OAibySUV3I21yYYKYmAXlFmz9JaNrVmXrBg++HBsexKLVxS5Np7C8yeHlNZ8H1/+h6uEwEAEjodwCWiRR0Bq0+gk3Nh9Aj+vZBUU4G4LG1zJ0iXBngQvyO2AEgDq2BWN15BHIy2B590CA2X7VIm+AeuRzPQmD0GoXfJUJNyiFyfen6EIXe6ZO+EkaIKzR8FY18kBrzv7TZT0vYueufs53EKMwCRNP59ysh3C1+7r8gqOXGRbdIVo27WRhfrMXkt/H+xSk4vtkAqbhljXAsdxFYNoeK1PI/3hZXBPrTRPos6FRjbbI6KeZJjEUGS8C8a9f84NZ8mpU89OSO2WS2p07ppApf6lEDYYLmaYjw/csfrEXTL20e7wjv2cIliGC0xpzli2hjgBFaM1LGP1Lmff88PS5cbH4xg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(53546011)(38100700002)(186003)(122000001)(71200400001)(36756003)(4326008)(8676002)(8936002)(33656002)(6512007)(6486002)(76116006)(38070700005)(5660300002)(86362001)(66946007)(966005)(2906002)(66476007)(66556008)(64756008)(66446008)(6916009)(2616005)(478600001)(316002)(26005)(6506007)(54906003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fSpLOEmRcKsr6vQKRXSzmqCEYnQXzsIqHZs1gEWct3wRDBVMCDx8bDda0lIm?=
 =?us-ascii?Q?z9E3tOeY597DgASE/Cb6hmDYxnsUD4RWatFsTJBsiYmgTRw6wtN++sdhvRqG?=
 =?us-ascii?Q?B5ZuBk4zxHCjuiYZeiP5iyhZc6uuiwIhO2LNw5QFaDWJQ6PP2g7Wa2Evpxnx?=
 =?us-ascii?Q?kMEuAIofcRNzSOiOou+DPUPc48Rl0ytnz597kE+YVgW0sU8kBCms9jJYMkB/?=
 =?us-ascii?Q?ZunAzJpePnMV89T94dNYmUyoP9hCq1c5VvQwGlN48pHxydnl+hgAlGfE7zVQ?=
 =?us-ascii?Q?TJfKMdt2+gwxTQT4U+UOZRqEXhv37miRzjmr+EzjQEi3ZmA/plPLTjLftD+8?=
 =?us-ascii?Q?3p1vI+S9xll/1Eric0h6QluSYkkDWhgK2D04yyhl1orZJC2B2fGa7IFQdIXP?=
 =?us-ascii?Q?LcXckczZQrOviVIdzQAAcNjes4upK/pdivJb+jP58GgYNYkJwbNqebtJwbTe?=
 =?us-ascii?Q?B433GAq+zaNxAiKtvID5sCAdlwdvmvGvkHqQAEArQC82mWWKD0vJEb7lQuLO?=
 =?us-ascii?Q?ho6V0M5bCs9+D9FFzzWcMrDv0SOlkUbGPI7948023J72E4hxIIn2C/Pqt7Gm?=
 =?us-ascii?Q?pQWq9ARJJb39z32E/ZMypYHw/hbWDs+N9lRQSwge39ILpTPVURr3o0ip0U9X?=
 =?us-ascii?Q?x1G65MhkuJwN6WaZkxX7e3aHUDHOAnmA6bx2l71wWR7zYy8OO+sksVnRf86e?=
 =?us-ascii?Q?0o/54yC+jXTqwTueKk27kz4omDpBS/smSPpwjdcI1R9Z9QftfPrXatx/7Eiz?=
 =?us-ascii?Q?ZBSk1FvL/Enj8FyiFjQGN0CaPOE4tuSQwUr6ZXM4ytnO3pmUrZuKy5UY1VzV?=
 =?us-ascii?Q?ARc943vcTOtjTXG4t1wnCb8dr/tk8SgnnuOVutljVk1TQTXvDK3HO9nKmInq?=
 =?us-ascii?Q?5KznV8j67LkE/8qHm5nEK6UmFxh/ceZ9MVzX91DkE/uMFoURI72NShmI51Y9?=
 =?us-ascii?Q?+edI6/T4lDqQgM5XOz2Mn/QYOjiE/LCQDxxusezhLeImhsU9bPRdEHFjb5kt?=
 =?us-ascii?Q?p/8lKNB4Ruanh7Rb5A2w2idGP/fERF/ZTYqNm4Efx4VxvsCVCUGDit8tqA8L?=
 =?us-ascii?Q?uzSnIa5mM3Hlq4GBMePGmdKL6lbUgSJnzZDDU++x63tzAgx2072jttmMT0cY?=
 =?us-ascii?Q?87LKGU5P+5C7dw/ulya6olLWK78eyaldO/WM9ieq/AdKCyubAih0cJYEnFlZ?=
 =?us-ascii?Q?sDYmZTXZh4ni9AZHouHZ8HWIivBEyque6hSunlwcuAB+q8HltaRSmSItH21F?=
 =?us-ascii?Q?Q5M2ZgX3D9zq+zf0zZzIx9hDxcNZFL+Qeg7G2muXDqVeNQS5POQT+5IzQFW0?=
 =?us-ascii?Q?9wh7EaIHYjEpf2tIbbFr19RL?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A0B7E892F0334942A9293A2C3C3E6FFB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89305ca-f6c6-43b5-808c-08d96280f8b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 19:47:11.5328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: elkKKIkcCXVB+KazB0/c1f8rx+ULP229bLjgYQZpPOr733GSQfpW3WGlx3ga/If9fduA80GcFLEJbpIJD36G2gZsfZj86YS0PGc27Sb6rpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5208
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 18, 2021, at 05:03, Borislav Petkov <bp@alien8.de> wrote:
> On Fri, Jul 30, 2021 at 07:59:42AM -0700, Chang S. Bae wrote:
>>=20
>> -			copy_feature(header.xfeatures & BIT_ULL(i), &to,
>> -				     __raw_xsave_addr(&tsk->thread.fpu, i),
>> -				     __raw_xsave_addr(NULL, i),
>> -				     xstate_sizes[i]);
>> +			unsigned int size =3D xstate_sizes[i];
>> +			void *from =3D NULL;
>> +
>> +			/*
>> +			 * Copy the xstate if available. Otherwise, copy the
>> +			 * non-zero init states for legacy states (FP and
>> +			 * SSE) or fill zeros.
>> +			 */
>> +
>> +			if (header.xfeatures & mask)
>> +				from =3D __raw_xsave_addr(&tsk->thread.fpu, i);
>> +			else if (XFEATURE_MASK_FPSSE & mask)
>=20
> The i loop variable above starts from FIRST_EXTENDED_XFEATURE - why is
> this XFEATURE_MASK_FPSSE check even here?

!(header.xfeatures & mask) means init-state should be copied. Except for
these, the init value is zero (as also noted here [1]). So, check this to c=
opy
correct init data if the current iteration is for the legacy states.

At least, I may need to improve the readability here.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/arch/x86/kernel/fpu/xstate.c#n416

Thanks,
Chang

