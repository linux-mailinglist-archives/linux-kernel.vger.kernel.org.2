Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000DD420461
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 00:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhJCWoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 18:44:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:23334 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231778AbhJCWoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 18:44:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10126"; a="248492403"
X-IronPort-AV: E=Sophos;i="5.85,344,1624345200"; 
   d="scan'208";a="248492403"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2021 15:42:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,344,1624345200"; 
   d="scan'208";a="710623183"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga006.fm.intel.com with ESMTP; 03 Oct 2021 15:42:26 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 3 Oct 2021 15:42:25 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 3 Oct 2021 15:42:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sun, 3 Oct 2021 15:42:25 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sun, 3 Oct 2021 15:42:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOpENvp4Oiu8XBG7ZXbGyD0ObnSbd3EO0UAs2c9I47Y9UIRXITfyAlAlbbbqng2s1JmrrQzcfcJnsNiLFqQNaLQ7jgseAA5osmZZL0WDjxVa4wdLotlDQhlJ22+2+yDgpl/rXnpHn7IgmTe8cUrwzJspyuM304KNfOKHQuFzGiqa7+rsoCKgL8eQrhh5iePs6hUvvsL8TX2KLhfw+svPPWevD35HlE3viieTLZh0yYQGNAxbObkTAZHhQoFeLWWGI+2qioELpz7ZQufH1xyQ+Bfgr7hei6DMr8BY7UJ3XgiGg3hchVU2KEbplnm3hgh2lgMT1si6XC7HB7ughU6ROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XR422/KMaH9wufqP7wfg/pqU77XtLOGEROqH6CcOL/w=;
 b=e7sjFkCqb7CiiLlVnFrmHoZyL4BLZuMIAtCdbSfCohg/2TktGqR0AsMrmbqB22/IucRc6j2gRRD3TyVVoWY38Ohm5Ho9tk84+6MTZ3TEHFLedTd4lf71z6/1kll87CKRY+Gj6yo1Mtlfi/WFQ/SoGqLX1kbOkNiBwCPqOQdfHgbfDIE39Ic4XfhpGMaa98wozyLOq7YqOv9H9YkWR4GIXYaUrSXG9el432rhTpZ2BIN+7pZfxgYPOpMnMGO+zhDPUP4+ub1eoMrC+CQ/1H07gr6E9zx2o7Y1u6CcErfDRxRUf7ip/yLh0o8yRTCABhCn4753k/SuYySwIGn8h5XCSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XR422/KMaH9wufqP7wfg/pqU77XtLOGEROqH6CcOL/w=;
 b=vVU5H97UmIDCq8uV2e5dOfdTl5WujM3va9dWJxH4ll9Buj9LXIF+cyCmY5Z9M6/K1uIBWO2N+zKTn3Oj58waFwGCJmT6lTgHze0sOVRU9DhsZxIh+BhL28qEpMYn5/rD4jwCiEcdrfqmPyX5nymgPimXUuCrgHKKQToGHTxuZy4=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4774.namprd11.prod.outlook.com (2603:10b6:510:40::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Sun, 3 Oct
 2021 22:42:22 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983%3]) with mapi id 15.20.4566.022; Sun, 3 Oct 2021
 22:42:22 +0000
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
Subject: Re: [PATCH v10 03/28] x86/fpu/xstate: Modify state copy helpers to
 handle both static and dynamic buffers
Thread-Topic: [PATCH v10 03/28] x86/fpu/xstate: Modify state copy helpers to
 handle both static and dynamic buffers
Thread-Index: AQHXmcpxePEN2sjUrEeDQH7R3sL+R6u+UXiAgAPKy4A=
Date:   Sun, 3 Oct 2021 22:42:22 +0000
Message-ID: <D6BE7E70-896D-4192-86CD-F075705B2DBB@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
 <20210825155413.19673-4-chang.seok.bae@intel.com> <87h7e06he8.ffs@tglx>
In-Reply-To: <87h7e06he8.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60ed41a3-1338-440b-244e-08d986bf10c4
x-ms-traffictypediagnostic: PH0PR11MB4774:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB47748C8B82ACD9E74B912B7BD8AD9@PH0PR11MB4774.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gkbkRFmK/fAegI7Sr9b0IzHXgPf0U0iqhmmtmSZR8oaiCC7yGOXAptXS2nODKDiRrhczd15mO3eVe09U2I1F2L0N6dR8doVqqpZ0WKXo3oOkCZq7/aQjoFCgiVn07CP17ckfftwTSem/tKKEiYwLTwp0SGAnAVVI1PDgK+8qZ21xc72IU0DHKDwbOHdKuZatI5IWcSchm4/2SD3NY0Cgr9lPw8uDOSYW8P3qvH8GIG6KPl6+beHWv7mX7oWo/WmfbleiaY+pXdwatDQajBQbLMb6SXg0YFd5FdZOE6mMDhOlw6+U/CWEtnvb76YJu0YOPMMYmvn7QOJOeUMpcaT4MEjUgEjUu2mWk4rcPF3x3yHk4HzpH6Bsy6UR140grdjA4wtDWGeWCpjPvkcRgvgWjmeeMdXWwLt8y33cXSU7BF+Wb+ieXinF22vv7j08EyCPwXkTAvwK09ovFTSzCc3jAAuLfmPhM1CYFEdjzPLORKqBm28I1mRvTGNhf51uigVRQAOok17zNg9+laVU8IC45HkW8c+KvJzFbwIDQ7UG7Jxyiw533+LVnhgyULK/+wEQUbhdWsKUrI9E0BBNES6HbWvXZyKcvTh0T5j1QEzrR9cdta8XO76yWohx3a8rwDH3tYF02WfrXiauQDKhD79/1cjLCDE0hTZjf6x1kW4nNe38DBJDNGm1Rb332Tu+ecJvftoWSz1LNvjUFoAOh2Gj1+lmg7fzzfRE1sZO//bfkXcEh0CWgnpp2qcG6N95fQm6qlicUoipItRkiYUUk1GWfDS/C28sx6fWiywEVst7RK36P92wqXSNml+oklH0HDny4PLImgb2bLR8fv6Sb5irKw3TkkEAE0mQhkTGZY9vm14=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(36756003)(66476007)(2906002)(66446008)(8936002)(54906003)(966005)(33656002)(6506007)(53546011)(508600001)(66556008)(6916009)(38100700002)(6486002)(66946007)(76116006)(122000001)(86362001)(8676002)(83380400001)(2616005)(186003)(6512007)(5660300002)(4326008)(64756008)(26005)(316002)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUpmcU5xOWZKVktnZmFLOFdkQ2NZakVlejloTGlHNzJrczVCOW1JbkFZekEz?=
 =?utf-8?B?UUU3eUEvbHNwaEdROHJscjBEbndXTDVQbGM1dm1XbVVGWWFmWDE1MTk5eld5?=
 =?utf-8?B?SW1VUk91ZTM0bVA2QzNmc1NRYkdWWDJIYU9mQmsyZngza1ZWdDdIakcxSXgw?=
 =?utf-8?B?UU9YZHlBbmVrYWhobmt5NmJNdWs4aXZLNGdya1VjN3BjR2V6RmZoOS9RVjVB?=
 =?utf-8?B?ZkNzd2QzYjZ3QWRpOUllOTgxMlBaZUVHa1FNMGtFNHlGcm1scTlkWlp3STdo?=
 =?utf-8?B?NXV2RHF6d1lib09RSWhTbys3NmpNdXU2OS9VN1NsK0JmK00wUzdXRDBYQUlB?=
 =?utf-8?B?WjhkVnIyTDE3aUpWcDhxRXhsd2lhWXI0QU1WMUtaMjRXQmRKQXhJdHpiTjJX?=
 =?utf-8?B?RzB0Y3BJdGhNOWVKamtXdUp2WERxck1Qb1puZUhPdXRtOUV4YlJEbExXY0Qz?=
 =?utf-8?B?Ti9OVzl3cG51d1FuNFZDZ2RZeTJReGw4Y2JoZ0xhM1gvZ0dFY2NpcTl1NFRI?=
 =?utf-8?B?MUZ0UlVmNUUydXdlb1daNUZKRXNDYUxkdTkyeDVGMnRnd2F5NG5XenJURUpn?=
 =?utf-8?B?QWZXcGZzeGtRVDJrWjNGRjk4RTBWVWViaENlRGQvdlVXcFlZYlY4OUVyeDNi?=
 =?utf-8?B?VC9iMHRpWGxJZU54OC9jTmhFWnBvVHhSd0tZdjBlVkF0aWlJTnl6TitNTkln?=
 =?utf-8?B?SjBqanNHekUvNkZpdTFNTWZGVzN5YkgrZ1N2MDBtenpTUG9yYmwyMTV0ck1N?=
 =?utf-8?B?NGcvZzgrVFV0WEJZeitTVmJhakNtTlBXdHFFSm9wMVRkdGVYVWx4MXBxa1M0?=
 =?utf-8?B?Y2ZISUtGU2N3ajNNZmxHcHhPaWdNUmhxTGZRSVZ3WUNkM0NFLzJoQ0Mxb25r?=
 =?utf-8?B?c0tock91N0tTaFBVU0Y3QUJuMFErT040cXVpbTR3RlI5VjNtcFVEOStFQkh6?=
 =?utf-8?B?dDZjZm1WNml1K2x0Sk5KOHY3NFBaUlYyMyt6SDFLUTRIdnEzSVcySWY4UzBk?=
 =?utf-8?B?QzlBRytjWGxjUVdjV0xrYUtqQmFDTmNMTUlGS0l0WVQzaHlZdFBHRjlMdW5H?=
 =?utf-8?B?c1FTSHpVMFZvRHF3VWZ1QkNCamtEOEtPbUxabmxXSG9XMzI1SnVYVk1UcTF4?=
 =?utf-8?B?aVlBV2taUnZBSmlhL0lwK3FSN0NuVUJidXJrQTJZeDJXOVBVNG1Zc3Z4QWtQ?=
 =?utf-8?B?TUpZck8yMVRaZnZiaXZTMGxTTDlCT1llWHZ1RmF5Rm9hZ0hIcXoyQ0plem9S?=
 =?utf-8?B?cmZ3S1FxbXp6ZUpSY202YjBjVjRHQkpKRmVHWjFOV0s5S1ozT2hURFE2YXdx?=
 =?utf-8?B?ODlrT2h3STBCV1NvdzNKYVFlWkpoYkZxd2p0UE56dVB4VmFBcEkwSWlPUytr?=
 =?utf-8?B?UVZ5ampyZTNUTWVBR1p6d1lpcnhVNTJwQ3YybDk1UnN0SXFkL2E0bzlNeFdU?=
 =?utf-8?B?M3JTUjVndmhFUkgvdTBSaGY1VFRnQVQvSklOS3RzUi9NeHkyVjdWbE5idCt2?=
 =?utf-8?B?US9veksxUHBpQUdYUG10VHpWbTlZb1doR3JhL3pCQ21oS29TK005OHlTOUx6?=
 =?utf-8?B?SGR5RWQ5cTJDbUtPcDF3L3N0SE1lcTdXeXZjRGZxaUZ3Z24rQ2lXSlU0MHp0?=
 =?utf-8?B?dFFLT0RGZHpuUjBaMzFBbnJYUUhQSEcxdUxkcC9Cbktia0ZGYWdZejM3UEhY?=
 =?utf-8?B?YnVLcklnZWxEQzZibmNBRVJIbnZtYWdkQzNXREdnUEFVS3dUcUY3TDJYMVNY?=
 =?utf-8?Q?+vaQaPSTtgBXMZTZEE9wJ5rUrdPtb9/hLV0U9z6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1276ECAFEBD49844B914622B8C216479@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ed41a3-1338-440b-244e-08d986bf10c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2021 22:42:22.6457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uNpuxl/w5LaLCGctwygh76USLuIKiXkmdppfU7xXeZBslMSS4K3eoXskDjAE3i1UyxdiXYP6T62ypPfBCtZZRWqK3JGR1fgipTRr9/47YBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4774
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gT2N0IDEsIDIwMjEsIGF0IDA1OjQ3LCBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25p
eC5kZT4gd3JvdGU6DQo+IE9uIFdlZCwgQXVnIDI1IDIwMjEgYXQgMDg6NTMsIENoYW5nIFMuIEJh
ZSB3cm90ZToNCj4+IEhhdmUgYWxsIHRoZSBmdW5jdGlvbnMgY29weWluZyBYU1RBVEUgdGFrZSBh
IHN0cnVjdCBmcHUgKiBwb2ludGVyIGluDQo+PiBwcmVwYXJhdGlvbiBmb3IgZHluYW1pYyBzdGF0
ZSBidWZmZXIgc3VwcG9ydC4NCj4gDQo+IFdoaWNoIGlzIHNvbWV0aGluZyBkaWZmZXJlbnQgdGhh
biB0aGUgc3ViamVjdCBsaW5lIGNsYWltcyB0byBkbyBhbmQNCj4gc3RpbGwgZG9lcyBub3QgZXhw
bGFpbiB3aHkgdGhpcyBjb2RlIG5lZWRzIGFjY2VzcyB0byBzdHJ1Y3QgZnB1IGxhdGVyDQo+IG9u
Lg0KDQpUaGlzIHdhcyBsaWtlZCBieSBCb3JpcyBbMV06DQoNCiAgICBXaGF0IEkgd291bGQndmUg
d3JpdHRlbiBpczoNCg0KICAgICJIYXZlIGFsbCBmdW5jdGlvbnMgaGFuZGxpbmcgRlBVIHN0YXRl
IHRha2UgYSBzdHJ1Y3QgZnB1ICogcG9pbnRlciBpbg0KICAgICBwcmVwYXJhdGlvbiBmb3IgZHlu
YW1pYyBzdGF0ZSBidWZmZXIgc3VwcG9ydC4iDQoNCiAgICBQbGFpbiBhbmQgc2ltcGxlLg0KDQpI
b3cgYWJvdXQgdGhpcyAoYXMgc2ltaWxhciB0byBbMl0pOg0KDQogICAg4oCcVG8gcHJlcGFyZSBk
eW5hbWljIGZlYXR1cmVzLCBjaGFuZ2UgWFNUQVRFIGNvcHkgZnVuY3Rpb25zJyBhcmd1bWVudHMg
dG8gYQ0KICAgICBzdHJ1Y3QgZnB1ICogcG9pbnRlciBpbnN0ZWFkIG9mIGEgc3RydWN0IGZwcmVn
c19zdGF0ZSAqIHBvaW50ZXIuICBJdCB3aWxsDQogICAgIGhhdmUgbmV3IGZpZWxkcyBmb3IgZHlu
YW1pYyBmZWF0dXJlcy7igJ0NCg0KQWxvbmcgd2l0aCB0aGlzIHRpdGxlOg0KDQogICAg4oCcUHJl
cGFyZSBYU1RBVEUgY29weSBmdW5jdGlvbnMgdG8gaGFuZGxlIGR5bmFtaWMgZmVhdHVyZXPigJ0N
Cg0KVGhhbmtzLA0KQ2hhbmcNCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAy
MTAxMTUxMzE4MDIuR0QxMTMzN0B6bi50bmljLw0KWzJdaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC81NzY3OTExQS02RjFGLTRFREUtOTJBNC1ENEMzRTVBM0FBQkZAaW50ZWwuY29tLw==
