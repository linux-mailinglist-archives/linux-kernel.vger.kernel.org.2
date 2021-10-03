Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D4D420459
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 00:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhJCWhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 18:37:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:10527 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231935AbhJCWhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 18:37:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10126"; a="224000521"
X-IronPort-AV: E=Sophos;i="5.85,344,1624345200"; 
   d="scan'208";a="224000521"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2021 15:35:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,344,1624345200"; 
   d="scan'208";a="621223764"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 03 Oct 2021 15:35:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 3 Oct 2021 15:35:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sun, 3 Oct 2021 15:35:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sun, 3 Oct 2021 15:35:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dn58oqlkqfApOQabxWcKBG9rSYDM9AoPBiZiYZ0m4k7U5M6ywB6uCTh2GQ3oJMncv0Is2duaqY/wy+w7Cmhw15InT3yIZn143v+KKQGDBt0ZM+NbvLjCRlsfq8+eVyAcnT8VVNxJEW73dDrAxCw9/2nWC2fKtBGIAGuydr78ibmKVLEDSFRUo/Q0tdwLs9VtExLztGsWmVtEqyXxa+gToBeRdemXNFhXs9z1JTzAwEfFqEk1bNSrzihjJ6uuIOhKkM/6vpD5vl8xT7t5/hfXhIYlHZ33qT813pUvn8ZlzNxxqnMGpNgCsWGzlhMgIpTty/+OF1+Hp5skiMdyUH8Mwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2QBXsF5eaEOSRao34/iwzRCIJm3JkWhzwNCjYan0b4=;
 b=kCpHhLa4/KJgb/ktzO7goKJrE9gKehr8p9gou2LcRfhmi3Kj6aq6WQ4+lSdUkt3PDtA/m2FceDMJa6InbruqlMxwIJjSuNPXTsCsd69HB37xZ6qehFmChnBCT7KiFqU0VZTjt93jU8tWo6PAzxQ5oM9rrvdtswhixD8a/hNOMjCOp+U03Y1Fa7f6Un7Z1snlMO7V6kCiXkpJqWdvghVybmAhO19V6rg4FS0+Y4KC+Y4fqy7TRc24m2YbLMvJH6YuNgX2cp6GM4JME1UINLaxnYACjoCVgziYcnNjHCNS8Uh9wZIo7EwmzegShlZZ1jM8zMQf7BFaYU3Dfi8iSjrHnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2QBXsF5eaEOSRao34/iwzRCIJm3JkWhzwNCjYan0b4=;
 b=DjnqMaTmP93/tYkRG0Ytb413RuzFAXgUfSaVGtzJIwaf357rXN16Lo4YmG0mATonTAwk11wEhb0Pmp5XHy53WD2JDbSDg2g5b+w1t6YlbFb2fuKpEb0dbNrGpmxH5GHgytPl+BObTgWXGcMVwjXGwg+Icp4Zk37PvTduZBKkMes=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5159.namprd11.prod.outlook.com (2603:10b6:510:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Sun, 3 Oct
 2021 22:35:51 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983%3]) with mapi id 15.20.4566.022; Sun, 3 Oct 2021
 22:35:51 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "bp@suse.de" <bp@suse.de>, "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 05/28] x86/fpu/xstate: Add a new variable to indicate
 dynamic user states
Thread-Topic: [PATCH v10 05/28] x86/fpu/xstate: Add a new variable to indicate
 dynamic user states
Thread-Index: AQHXmcpyDgSn+PMdakuOT8LrEK8anqu+WZCAgAPA4oA=
Date:   Sun, 3 Oct 2021 22:35:51 +0000
Message-ID: <DC2E88A6-4CE8-4F10-B527-081EE147927A@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
 <20210825155413.19673-6-chang.seok.bae@intel.com> <87bl486g1y.ffs@tglx>
In-Reply-To: <87bl486g1y.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49dc9448-fc1d-43f5-f1bf-08d986be2797
x-ms-traffictypediagnostic: PH0PR11MB5159:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5159FC4CD95046AB420A1847D8AD9@PH0PR11MB5159.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WPQQUyHXSrtos3zgpWXJnkXxvsgtzYWGhni2Koej89dlAZUwi5kv3VDqBwfpW8eyjVztZtqjITAxGu1j0rR992GP1kjMalzHNiYpGPOs6FAfjMWPmTYjsQe2MbN4bT9YLCF6LSuebHGLqn0W3csIVZzQ1cK4yTuS6GFxMRotNglPwsmziS/+WxqV6E/bNVm1nbU4OqXXYzb2FVdwi4SbPMGIikJLD0V5AXxjitlDAQeM2S3Xu4sPVcLOL8MwmdtktiziJBAu1wFQS9ZQCLH45/d8rDMEGETbnbtuPueCKJv+xnMDZnnEp5BB+4S6/nxLmXLwY1x+CBVo1r93trqYRdMCZTaXXUHypz1GubEWqaWc5Xt2Ow7U2KQy83ekk2jJJ+2uSO3OY+hBhn+U0ZS47hkk/NUcfcOomOpL1IN6mdhv9YeGcqKCGOJ14OOaNFYhvlYywlLLTrCypAxsObqd0VfF/GV+79OWltgGV6Li1ivkJPEjIrfFxaDG9MJFwiYuPD9LBfPVQbeLw4sfFAy81I0YBl/dRz0EILLkp4dILV23U5drFePsri2D3HIJ1r0q//UTSC/vO8lCKG+9iAdc1f+f3H42FNSjmXOi+SRRs+JBUDy+JC0Wyy/54wv3YcLxPLVipW3GxOpFprL/Jym3JaKyHARTr+qLxpQrpNemQZ54B3Aac+jYMpizhHg6YZL62LjCx2iFcJJNlhbrTzsnwCvqTya7fI8lrDHkRhs2HT6duSH9suD9N+DSUw/VtQVOJsfzesSFVGG3fkcCa73KOZx8p8RfxDSkEEerl3e59x/SopX6oCQL5l+4OhCYJbn/UNDUai82l+hjhErfgRcT2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(186003)(76116006)(86362001)(4326008)(6916009)(71200400001)(26005)(6486002)(2616005)(38070700005)(2906002)(508600001)(966005)(4744005)(5660300002)(6512007)(316002)(8936002)(66476007)(66556008)(64756008)(54906003)(38100700002)(8676002)(36756003)(66946007)(53546011)(6506007)(122000001)(33656002)(66446008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ltBbRSXmGn1IQ5NxmKGmZ76qwXOPqYnqZJ0Z44HM3bZpqT1p3/ysxrZAEk6J?=
 =?us-ascii?Q?P8sBTxs42/X6cy2AExcaBUmd59cABF9iVo70pVvVknQWjDb7Kg+4v2FyyKxv?=
 =?us-ascii?Q?ExUyJGNhl1IwkJ9q83KEZiqXNRUFwtQLzvtcNsq4VU903NRuBrebNrTVKT5R?=
 =?us-ascii?Q?xdH/vIflupekq6nZIgVM8+OFb/BLLxGSBrsGoVJME5MlDAgB3YOnydZoftEX?=
 =?us-ascii?Q?UWdh+lRuZ0m+CNWcQerxyZ0++tZpTwh5at9GBmbsu9JAd++PPA1vBQedPFut?=
 =?us-ascii?Q?De643geh63tA8lsF1o+jTECTryt3TrDO7FwO0B8iRqlrwE4w7WGpXjKOTib/?=
 =?us-ascii?Q?06m+wRrQUS+YND/yj0sVEi3rIA/IeE67iiGUz6b4dIlBWtxaE2YGbWorLEbJ?=
 =?us-ascii?Q?fQT2Lcll9j9lCFUQjE3UXbldwAKSYljPEq5ZydleJs+isX6hqQTW3Wlo1FaF?=
 =?us-ascii?Q?sWYA2qcVZmgRwyGpbOhVAp7EwOHvakS8wM6lcHvCZl42dXAVRMNiPXDwVFs0?=
 =?us-ascii?Q?JKwGVg1ydEMH61r/D+a0K6EzvAok0PYc83Ixk4PkaxSRt+XrqTqGoeRJdHcf?=
 =?us-ascii?Q?xrMVVuqLDEZ6Xi1YHl2w83lDIj3KAqpjLgvi/h6ZgzE/bbmj2bEVmy17hIpn?=
 =?us-ascii?Q?MmGxfZQ2rEBGevYSQ5Wr4Tj/fTHskK9iakne4GiMAdxU9tkL6qgrhKtg32wW?=
 =?us-ascii?Q?nluUlRiBQ8+RkB6A/glWyN04Rd7kATNbvyQaHuyjRGqpoj4I/RR/hudKci5q?=
 =?us-ascii?Q?ktIvtNdRi80U+FrmdHHM7nhh6DuTGtxdnTiB1RPUe7ILay+l4KcSLkkdclC9?=
 =?us-ascii?Q?oTMxOEW6TDoPcuuS9xdUA8nZpieEIKnF/uC3/52mqKBkko0p5lqU0SZi8Vm3?=
 =?us-ascii?Q?Ev5q0Zf0pIoNd2w3tCwdAT3bKPLI/WFkE0MZJMuPMZL3eM79FNMeXhmJR0qy?=
 =?us-ascii?Q?6Y0oDZEzVpgxhA80BLa1H/YqAD5xobC9iQG8akWyRDqq7oRV/BLs3T8BKbgS?=
 =?us-ascii?Q?mhi19ND1+t1TbAazkcjy9wgycMWnxt9u76KnoIizKOcd3zugSWoBzKNZjWsK?=
 =?us-ascii?Q?kdmqxlFM3K8q3x8KvGN3OxyBkPwELTJ4o7sFivepCVWBe1tJMPOhUcojkwNn?=
 =?us-ascii?Q?6UtOIUn+9uUXv6gue7XC09d8/p1+/qbfXYXpWlAdVHspAnaVi+Ki02c/ytqx?=
 =?us-ascii?Q?G0MEAeuHyS/fhYkarBeXEH0RQYTPevSxkKDFI8Bvv52egm8Y0+S01/TNQu/P?=
 =?us-ascii?Q?nJ7hBdiCcbJgxbtoeXbMGs5iUASFTwn3YAiTQzgq3f7Z/xs7zWqxD9ISUa8c?=
 =?us-ascii?Q?QF3EAffPUDccX07na/GsD0XH?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <69911DFC7F0339449B5349AA37D3FF20@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49dc9448-fc1d-43f5-f1bf-08d986be2797
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2021 22:35:51.4688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vPSlZrBvzOlcMFsVxi8ObfJ/U37kAnQfeM9f8cUFz8U3CdUVAAOhaPdUsq2gKjGgXIqUvTgX3t/w46aWWrGhfMZ+W25hYCq8CEpbHYUo6f8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5159
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 1, 2021, at 06:16, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, Aug 25 2021 at 08:53, Chang S. Bae wrote:
>> +/*
>> + * This represents user xstates, a subset of xfeatures_mask_all, saved =
in a
>> + * dynamic kernel XSAVE buffer.
>> + */
>> +u64 xfeatures_mask_user_dynamic __ro_after_init;
>> +
>> static unsigned int xstate_offsets[XFEATURE_MAX] __ro_after_init =3D
>> 	{ [ 0 ... XFEATURE_MAX - 1] =3D -1};
>> static unsigned int xstate_sizes[XFEATURE_MAX] __ro_after_init =3D
>> @@ -709,6 +715,7 @@ static int __init init_xstate_size(void)
>> static void fpu__init_disable_system_xstate(void)
>> {
>> 	xfeatures_mask_all =3D 0;
>> +	xfeatures_mask_user_dynamic =3D 0;
>=20
> It's zero at boot already, isn't it?

I thought of this as a safety net here when it was introduced.

But let me move it to patch13 [1] where the variable is updated.

Thanks,
Chang

[1] https://lore.kernel.org/lkml/20210825155413.19673-14-chang.seok.bae@int=
el.com/

