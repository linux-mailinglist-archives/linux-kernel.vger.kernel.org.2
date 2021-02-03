Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E69730D25D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 05:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhBCELF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 23:11:05 -0500
Received: from mga03.intel.com ([134.134.136.65]:13197 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232187AbhBCELA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 23:11:00 -0500
IronPort-SDR: /bTF5BoSEGTOorqDKuMc7uHO7yBq3Y+SzLiXqs1KL2LaVHqHKAD5JUW3ZKvol02Z91Kw49JilR
 AAdLkfN+lFCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="181058732"
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="181058732"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 20:10:14 -0800
IronPort-SDR: I0tbx3K9UXaxeIBl01UvSYlGlOXGjEoUcpI6aVKe9o6n133zF5mkkev2xxlx/FLVXbMQvrVjPk
 tFqQsoUVgu8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="392237547"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 02 Feb 2021 20:10:13 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Feb 2021 20:10:13 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 2 Feb 2021 20:10:13 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 2 Feb 2021 20:10:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3TlskMQqFySbwbUujcr344IskX189Rw7dk1mxZbqmToE8tOtQv5GsKE+g3oM6Im4gZMTY84+mWk7YK2WW5etuPWMyrZg/0qpIbFSlQC7TpHqmMIcJ67DGbVadAhOIqcrFKOW1ee03s/GTQ1f4bBOCoKaXLWJXawTGzkCPbNu6qIwj5SbVBJV3f8oCJlhT9o3pxIYfABmVsfc9LO84A1decRP7sXwDSPDBZ+a2I/rf2VQFJjJFGKyb/72p96a0u0BGzsNMNqEcTqwpafGK48ZIXpmpzQDWGl+29ZudmxcCHG+dtPwr5Ffu0MpMjHuEnk8q03SWzjIsSqWuajmwXKTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SI6mlNzp7w8wuDrmGZyks/JGdPrfk6vHRWYrAPXMtTg=;
 b=NUqF0gpaEiknzK3S0k6KnxmiBTBaI+vo9cKs1ixOFIQPt3fdhIPvmo0SDabk3hxFF8T8elxU1BD6bJN1psmnxeTZkdjYpMS2Q1lzqSdNCKfQ+6Ejy1Lvwvrd+LjO1Ijs9b8pV3qmYed5qkBXrkhTyJjXnssArCmnxB0pcA8QNJryfd3OrEX4c+sdvuwqj2QuZUAvVwcHpU7eUuR+BnfdxwmoBuw5cUN8sTvLGHAi99VsXYQbKpQ4ekXKpxeJ87TTg2/ruWVQOO1sui21uQz7k8cVMSuNh0qE1s3vhLqqHIMNLUPnImsxWiZcah0GKYx1jDe0DVWTrfF6SVbn2+sjfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SI6mlNzp7w8wuDrmGZyks/JGdPrfk6vHRWYrAPXMtTg=;
 b=TYHAsIy3JKMxR7lnw3Y5Dr2KnDclbtbY9Lbs6zXDYUFiXHruACGG4eszsI7/c7D7WdPdw9tEjHu611XvsQROxFyzNJ34p13sXDXq7d2+Uv6iWTOU7u4gKqp4ZFP5zSaRwX2b33Vwflm5NGkRmZq+z636r6puA6y8Wl/n/k4nYGc=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4935.namprd11.prod.outlook.com (2603:10b6:510:35::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Wed, 3 Feb
 2021 04:10:11 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0%6]) with mapi id 15.20.3805.027; Wed, 3 Feb 2021
 04:10:11 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Borislav Petkov <bp@suse.de>
CC:     Andy Lutomirski <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 07/21] x86/fpu/xstate: Introduce helpers to manage
 dynamic xstate buffers
Thread-Topic: [PATCH v3 07/21] x86/fpu/xstate: Introduce helpers to manage
 dynamic xstate buffers
Thread-Index: AQHW2UTwl1+KjUFcn0aaCEDTiBI9I6o6jhQAgAuETwA=
Date:   Wed, 3 Feb 2021 04:10:11 +0000
Message-ID: <D7000856-4F6F-4BCB-A72E-4624A4A81C31@intel.com>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
 <20201223155717.19556-8-chang.seok.bae@intel.com>
 <20210126201746.GB9662@zn.tnic>
In-Reply-To: <20210126201746.GB9662@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9f9ab0b-5152-4f48-66f5-08d8c7f999d5
x-ms-traffictypediagnostic: PH0PR11MB4935:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB4935F5A092AC81FCA7C06787D8B49@PH0PR11MB4935.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GOwyp2y9iF17ZodzMQBKPQo1VCuHrCIV5jkW9pfHZCJuB3KlDQxAmWykOQFiDFGnEaPIORYssnmR29EibT4BJwujTzZRbkWqPKd+EF7SSQd+opxbeNAVs7YlhzE5RaiqH0PjuAKi+OW78O2PvZ4d05cdAVwNWd7l3F36ia790Q0MmBrDcjusbZcvKig3H8CqSpU0byhPY2B79AtYlPeSjixWcNU2p5h3vrYBjC4BLEv732xvyB/gGYfXhWWu4OjztqcB2kWB/b6jAYNqvRUdbyPQBS2ZXMG688xcS9rYADmfsRcs0bRVVh8WjuAqOmb1+F73BsUCDzzL8QmHvJQJVeePfY5A9hSU3guXlBUVRn5CBgS6stPh23ydzAFwMeuNvXZgBB/5ASsV6COE6WaxzHCtaUSZqOh3oGXIdfUjqJsc238PieSXnRY6f3UfxrLG6cEUxOp6+dhokBUFIhGWw58CDvH0vtxHUw3cNDQutLHL42RCJzGvGXihmzpKeiaulxKn2tE+AGeppP5W4WjRzbr6lMO8zC2/ud6BkcNVvGSmh36xtED3ArBeBw1Wbv2T8ftC447a+/ZuxZHq6ZMbPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(66446008)(2616005)(66946007)(8676002)(83380400001)(53546011)(6506007)(66556008)(4326008)(478600001)(36756003)(186003)(6486002)(64756008)(2906002)(66476007)(86362001)(4744005)(26005)(8936002)(33656002)(6512007)(6916009)(316002)(5660300002)(71200400001)(76116006)(54906003)(91956017)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?d0M+vEjcK6oRRYWNEssgxe0JK0VTPTPb45dHo6qLvCb3ManGJMIdTesnp71H?=
 =?us-ascii?Q?YyM1dd6KkuaoixjqdEaCY1OlnCzYjf12RCdrxwUj3HFm2F2BY+J955SjWyid?=
 =?us-ascii?Q?KBcPVXN/BkmPW378kSHj87xDAySvMdPH/3K3SvW6bOWl/Ib1s4haQRW9UBpn?=
 =?us-ascii?Q?b6fh1Yf2wzqy58e65kLVhPFEe929HvEG/ON9CpNPJAe8lFym6BUyBauDYpT4?=
 =?us-ascii?Q?LC2/Ye6fH3e7J6SjMfZPtxy9qb2CIJ5RvTCPD4foWSJAgnp+r4wElKmdwvob?=
 =?us-ascii?Q?rTTsz3DJq2W5gd3LXVtprMr04KZh8Es06JklLmAg3LKH3VoPKHDxFqe/UJMI?=
 =?us-ascii?Q?lk7CdeM6jq7UB1jKePakcRc/gVxZkx4dZub6ICX8seqRF1Inqve89QrXzT9/?=
 =?us-ascii?Q?rO4QF7DjDV54yybTYLjjrHQOVHGiZ67jatU43UBZAFUYr/07WoZbcfGgs3gT?=
 =?us-ascii?Q?jv6j4k0oZclXwbupyOiaaYvS7/0psBY8nR3DmaNe0zVBH3SyChtFXcyc/XjX?=
 =?us-ascii?Q?i/WSn4drmxLwLledrOB5P21VcZK3Q6931aJh82UcXHC8VoqBq8cxHPFt/tZe?=
 =?us-ascii?Q?l7bKiFY7D8j0hvu5m0ptKC6zaPyCx9sSvmaR/+oDkgSDvVkgNqLXg9/PKitM?=
 =?us-ascii?Q?p3XN/cqBrTIoU6ANmZj+Q2FeEQLYWSkrhbxYq1akICDk6ImpQ5PVGNjFGhao?=
 =?us-ascii?Q?XHkwus+XKg2Gv9FJiBKPDxQ5ylUdAK/k+FEMAZzNPXH3OT7illjG0WCcqlwD?=
 =?us-ascii?Q?I8dqI+napwcyhs8P9XlNuOw6P/U6Cx4gadoKrAAvKVx+SqKLMldY4Z02WKRc?=
 =?us-ascii?Q?F/D1f12r3lLN1H9dfTmmuUStaEZkFK7m4CCoCebQv6/s+xH/Z8sVWdS2ZrF5?=
 =?us-ascii?Q?TlCtFaWV9tjj5iQbFoh0DsL97BEJ7yNhsGj3LwGFgWMjUAFQkNeAARkbMqgR?=
 =?us-ascii?Q?tjW/2tGAfAh8zl9ZP6BRzWm0RTvK7qRm67xbGfjCAmeo9mcac5t+Ui+C2rVn?=
 =?us-ascii?Q?gdK7/ZVwIYip1LlBOXcAPgPJ9dZeS4iV3dHbstzhGON8eR8h5+E58ynond9J?=
 =?us-ascii?Q?B6AmYyf+x5lTX1FcMSPwSkcW5F7GbA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <691C2621A3180042A3387B77C33463CA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f9ab0b-5152-4f48-66f5-08d8c7f999d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 04:10:11.2786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ov4JwUZm0tPNvOMXdKD4ttzKFO1xxhHS3+3Dzin6A3jQA05mt+rlo9mXgVWlj+gvkjosKDf21U+bV70vA28yB0VHsQdyCKCV17uSYFZrDC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4935
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 26, 2021, at 12:17, Borislav Petkov <bp@suse.de> wrote:
> On Wed, Dec 23, 2020 at 07:57:03AM -0800, Chang S. Bae wrote:
>>=20
>> +int alloc_xstate_buffer(struct fpu *fpu, u64 mask)

<snip>

>> +	if (newsz > fpu_kernel_xstate_max_size) {
>> +		pr_warn_once("x86/fpu: xstate buffer too large (%u > %u bytes)\n",
>> +			     newsz, fpu_kernel_xstate_max_size);
>> +		XSTATE_WARN_ON(1);
>> +		return 0;
>=20
> return 0?!? On an error?!?

With more discussions, I now think it is too much to check like this. This
function (merely) allocates the requested size. So, going to remove it.

Thanks,
Chang

