Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57AE3CECE9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382358AbhGSRjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:39:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:8650 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351205AbhGSQNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 12:13:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="272206590"
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="272206590"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 09:49:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="414404574"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga006.jf.intel.com with ESMTP; 19 Jul 2021 09:49:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 19 Jul 2021 09:49:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 19 Jul 2021 09:49:42 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 19 Jul 2021 09:49:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDWEEZMiLj0O1TpScX0bKndMaLidegMpu4MXTUO7tnC7LzfQ+kMfNMx0xaslm9hEkmnLCQLqXVZtP32RJ4KW1hJ18X/k6pgZiBpkxY3rxrsfHofIMS+RVWf6t7d/JwTwQle0+IJN+cIoyDisDK/Naxzl1q8zRJ2W7Cgu9755LJVpbkm9wbXQS2Vh5O/Bsn04+WIUDnWk8grPzFctvnyybI144zv6gZf8D+ZH1Ij0lcyVWitS2xFpnCLrjmHjeurTZum5bhlw0pwi2/SiCs2Lq19SCiYW8DIgzhJZHYV68ntsZjxsPR6PVHoigghJCcLgIesTRLHZ8fwydXuIjyJnNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bmtIhKyDyOZrKoND5Nwrk5GQldp4AzCeRge5fJz9L0=;
 b=IrrnXJvK+d/WxtPxfqTLguztWnzG0jI5J10b/AA+042654K9+FiAPG8Ssr4HNSClh05PbvahapFqyiClDbviuc8SiR50Z+42ckzYEU1x4FykUxd8EWVJnJ8sMPpSc7/rkvuR7giwx3KUI7JA9EVwHy9X4Eq8TngU6IHm3X9VHSu2pxHKE/fqBLMhI48SrWdO6eb+b1hSU83T6xk6qfq/9Xh9T2T8uJdBBy1YjL2lTmrVlTJHXEf1Fzs1GkANebXsWvUG7/LXkOl8EnHaNTkvA0JfmEdGNsT6gxNN9TvBHPX8za7ABqdZf9khN+VJy/eBIqU+v/OTPbNTUjzj/LDdcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bmtIhKyDyOZrKoND5Nwrk5GQldp4AzCeRge5fJz9L0=;
 b=XYHNTwRqZX3I0SwA7hxRfc0NhwXRy3ukrv3oV0kaA10N+ILRySvBhZeV8Wx3nqV27wH6QbA1FBvSJrG7vwdJlG9ZRpeKB7yEZuIz+w//5F1fyU0+tO6RLzSwzXO3A3C7g9pas7fJ15tu4qzw14iqXHQAbsodEWpG1jODkCKFksI=
Received: from MW3PR11MB4523.namprd11.prod.outlook.com (2603:10b6:303:5b::16)
 by MWHPR1101MB2207.namprd11.prod.outlook.com (2603:10b6:301:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Mon, 19 Jul
 2021 16:49:35 +0000
Received: from MW3PR11MB4523.namprd11.prod.outlook.com
 ([fe80::a87d:ca62:f143:7464]) by MW3PR11MB4523.namprd11.prod.outlook.com
 ([fe80::a87d:ca62:f143:7464%8]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 16:49:35 +0000
From:   "Kammela, Gayatri" <gayatri.kammela@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
CC:     "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "irenic.rajneesh@gmail.com" <irenic.rajneesh@gmail.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "vicamo.yang@canonical.com" <vicamo.yang@canonical.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Box, David E" <david.e.box@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mashiah, Tamar" <tamar.mashiah@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rajatja@google.com" <rajatja@google.com>,
        "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        "mlimonci@amd.com" <mlimonci@amd.com>
Subject: RE: [PATCH v5 0/5] Add Alder Lake PCH-S support to PMC core driver
Thread-Topic: [PATCH v5 0/5] Add Alder Lake PCH-S support to PMC core driver
Thread-Index: AQHXenI5QzYaWuGwDEOspqlzZ7QGNKtHTRaAgAM5/iA=
Date:   Mon, 19 Jul 2021 16:49:35 +0000
Message-ID: <MW3PR11MB4523FB4A089B18450FD94C49F2E19@MW3PR11MB4523.namprd11.prod.outlook.com>
References: <cover.1626459866.git.gayatri.kammela@intel.com>
 <2a5ef70e-7194-1dcf-6653-9901c7470ace@redhat.com>
In-Reply-To: <2a5ef70e-7194-1dcf-6653-9901c7470ace@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.100.41
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c1c9234-3a15-4843-adfc-08d94ad530da
x-ms-traffictypediagnostic: MWHPR1101MB2207:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB22074AE7AFFCF10BF10C1CD2F2E19@MWHPR1101MB2207.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: irWFMak22pFVOHGD0lh9erA5lp8Xj4vS2KzpAk+ewsKzX+MhDrlEG7FZqOslHPrFT3QYenctYMZRx95zCi9EhnbmkVTUi2y8+8KkS8xkLb+7Sygl3uuG6CKB3MMGmkr6V1CQPLCYH3f/GDSkzBGcGMXGNEihK5RKhqfLis+bHbDeA/xDeJPVUQ2gBAjrcrQIZZ2hU5m0ffQALpsyxezQ+X5sZHgWoSk9k/Twgkyd0O2Bh13jdeheiKvBNrNO4ndlye8RTpcvj++LBej3vMNBYpXzCBIA40TFOoEDD0vdZ9kxIx0izkKPrLuXhfcpDwib13wNNuOQHPdO+7+Zx1RzNr86H83QMOnd/M9UadH5J6yRNKJACLj/TQ1FekPqD7O1GPFqdj3HSrnnk7xXIwxykS+Q1hiKHW/qXNcjYy6XcUAMpKp7vtrkaY5Oc9/O94Mhk13WwsnXCxyrB8/IR5qKmA9g+no5pitPGFSHAD5iU436vmXXlrCBqimOm6ogwt8qdU0SdTN5u/aYHod/AuZpcru2YAa2Uzp0Pj73SxRtywOiPFqDV24BBJi1ZvvTvO3Axf+9dfXpFjZc+gA9WJ1rWAERGN8J24xSmaSFwcO5Yq/xOfEiZ6C96rWuUQ55xf06cpI6LTffyLfrUqzFQ9mFl8+A2/MhNppTTXQVeNHScwPXaIM8iT9MFDhYccB/PnZYVQ0p/XaQWFsU8bDpWIHKBsjyqATG/f4jJCX5KNwMaLfplT8UhXvvSdLfL9VAReNndx0eMGKeHuAGiZzICDFdPa5Fvyjb+lky0BUuyV3XH5FXyDIsCRN6ZrkhbYIIpgsdA0uVB8z02imfKXkcqcrGTz77FRT42WM0Bt61Jr15Vlg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4523.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(76116006)(966005)(8676002)(26005)(66946007)(66446008)(64756008)(66556008)(66476007)(54906003)(86362001)(316002)(6506007)(53546011)(110136005)(478600001)(7416002)(8936002)(2906002)(7696005)(83380400001)(5660300002)(186003)(38100700002)(122000001)(52536014)(4326008)(71200400001)(55016002)(33656002)(9686003)(88260200001)(226253002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnB5SDVHbVdHZEpyamhWK1d6WU5PNzZRYng1UDlvalpES1JlQms1TTJCWTlk?=
 =?utf-8?B?elRNUXRtQzU2dGVvNHF3RnlLRkQ0aW5YSDViMEpOeFppREtaTVRHYkdGajBx?=
 =?utf-8?B?MnhXTVNpZnVtaDRYcVNWUUV2SG85Q2N3cVpLQm5JbE9ONzlaR1JXdW5rUFRF?=
 =?utf-8?B?TDlKMGU4WldBZVBtdmZWMGNVc3dhV2lVNUtGOFlkdFczQjBxRnliWCt6V0Ex?=
 =?utf-8?B?cWU3TkVCRDBYVENpUGlGR0k3dnU4K2NrcVNTekRQNFVFbkJrRk54UnFLQTlK?=
 =?utf-8?B?STFxbk1YeXlWUHhSSHhONnhBWitNN0FrVGVhME13RlBRK3BBNUQzT0JZUzA3?=
 =?utf-8?B?czNOOTUvaDlWdEhPMkVGVlgrcnc1QTduZW1Pd2h5OFZtdTVOcFlDVG1MMS8y?=
 =?utf-8?B?SkowdEJVNzJTbk5CeXR5TWlkc0V0NTZlbElRYXpobzNVd0Vub0E4QlNpR0Qv?=
 =?utf-8?B?enBtckZuaGkybWdwNVVTV1k1Q05BNEhGay9tTXpZbnRWRGxDZEpIV0wxWTV3?=
 =?utf-8?B?bUxuUW1MY2lhR0pyYnFURUdwWFdUUk5FMlBKN1lBYVVTM3J4bU9TQ1dLNVVL?=
 =?utf-8?B?RDM4c1ZKMWtYQW12cTYzRWRrdm5EcXcxc3dmTE8yUWkzc0hTSXp5TTBhZ09o?=
 =?utf-8?B?VC9mNjhScUtKbzRXWlN1WUphWitNaC9MclRMckdJN3BSVC91c2ttdlZoTm1P?=
 =?utf-8?B?RnZnYlB5ek45QmxFZ3lDR3VsTlFNSTV2VEtLSXJzSWlSV1o5aEZWTnorcVdV?=
 =?utf-8?B?MkdOdlhpc1p1bHpaTlpYenJIbm5UWGRKUGZrRlo1di9MVC9ydGRWNVl4cUdC?=
 =?utf-8?B?NE9xcUNxNjFJZUp6ajQ4TFBLTmNNNCtuSVgvUFQzY1hJWHZTaUM4Y3dsR3lH?=
 =?utf-8?B?cWtXVkg0MnFpZ0NKWGU1bllpbnZuNEo4ejJlTTIzcnR6QjB4Y2pYeDFudGNQ?=
 =?utf-8?B?UEp4ajFyeW5jTzM5V0dmckMwMmM2ZXJoWXFKaXM4S2NLZjdhVWk2d0VBekVx?=
 =?utf-8?B?bnpzbUJTRUNaZEs5NG9jQmR2dEh1QlpaTHRib2RFdGlmN0wxM28zWHVNbHlj?=
 =?utf-8?B?dzFDa1g3VHFNMHFQSUdYT3hVbmt1b29xN2RBeVpoODBtSHd5S0E1YVFwN2F2?=
 =?utf-8?B?cTZNb2JTMFgwYXdOemxEbVhaTThkMkxJZmxWdGVNcmtQK3d4R3dRUHl6Nnhw?=
 =?utf-8?B?T3JBR2pHYmNqZWJ6VWhyWG1WbG42SHpPU01sczQ3eWdsNGs5NVQ1elh0VTFs?=
 =?utf-8?B?dmZYbGdZUEs3dWFNWkJ4ak00UW5TUmRoekdHRVZVRGhDUHprdkFDOE02bkVk?=
 =?utf-8?B?cFU3MVp4dzJIUklKUzdJZU8vNzBrcTl1UWJZZktBYk9CWFNuREN0Y3Y5SlVF?=
 =?utf-8?B?bzdRZzVlblVyRVpLU0JROFBWMVdXQkE4dldRNHc2cEs4K0M1dis4WUFaWTZl?=
 =?utf-8?B?Qzhqb0loRUFwQzNBN3JyU0JoY2k3Tkg2QXdwOU9QbE9Bcmp1dzhPaWJDQ2tJ?=
 =?utf-8?B?SW42bUZkQW1sZW10b05ySUF6emJpdkpYVmdsQ2NJV3lBdWE5eTB3bGxiMkUv?=
 =?utf-8?B?dXNyeGpKT1NPcTNFNUx4Z1pNajN0L1BYV3hUem9tRTNLV1d4ZlhCLzFOQWFV?=
 =?utf-8?B?aXNHTkJ3aW5aWFdmZmpOQ2htUXBrNmphd0hoMEVCc2xQUGdkME5rb1NJdzdq?=
 =?utf-8?B?eGhYa2d6VEcxOEhpa0lBOUNGZ0xnQitzUFh2UmpQUlRBRGVjenUraVg0Rm56?=
 =?utf-8?Q?o7Y4F5QudZw3KOjJYU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4523.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1c9234-3a15-4843-adfc-08d94ad530da
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2021 16:49:35.6657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w5bpYY3RFVFX4+r6AOAq8tzSDi2d2LizNtOcFXgeHTb1PRqQ1aOBWsZUExPUJ/ASvLA3lOWoVmaFft5joukYB+GcTuLljP3bkzyXDHEGF4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2207
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVn
b2VkZUByZWRoYXQuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgSnVseSAxNywgMjAyMSA4OjMzIEFN
DQo+IFRvOiBLYW1tZWxhLCBHYXlhdHJpIDxnYXlhdHJpLmthbW1lbGFAaW50ZWwuY29tPjsgcGxh
dGZvcm0tZHJpdmVyLQ0KPiB4ODZAdmdlci5rZXJuZWwub3JnDQo+IENjOiBtZ3Jvc3NAbGludXgu
aW50ZWwuY29tOyBpcmVuaWMucmFqbmVlc2hAZ21haWwuY29tOw0KPiBhbmRyaXkuc2hldmNoZW5r
b0BsaW51eC5pbnRlbC5jb207IHZpY2Ftby55YW5nQGNhbm9uaWNhbC5jb207DQo+IFBhbmRydXZh
ZGEsIFNyaW5pdmFzIDxzcmluaXZhcy5wYW5kcnV2YWRhQGludGVsLmNvbT47IEJveCwgRGF2aWQg
RQ0KPiA8ZGF2aWQuZS5ib3hAaW50ZWwuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgTWFzaGlhaCwgVGFtYXINCj4gPHRhbWFyLm1hc2hpYWhAaW50ZWwuY29tPjsgZ3JlZ2toQGxp
bnV4Zm91bmRhdGlvbi5vcmc7DQo+IHJhamF0amFAZ29vZ2xlLmNvbTsgU2h5YW0tc3VuZGFyLlMt
a0BhbWQuY29tOw0KPiBBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tOyBtbGltb25jaUBhbWQuY29t
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMC81XSBBZGQgQWxkZXIgTGFrZSBQQ0gtUyBzdXBw
b3J0IHRvIFBNQyBjb3JlIGRyaXZlcg0KPiANCj4gSGksDQo+IA0KPiBPbiA3LzE2LzIxIDg6Mzgg
UE0sIEdheWF0cmkgS2FtbWVsYSB3cm90ZToNCj4gPiBIaSwNCj4gPiBUaGUgcGF0Y2ggc2VyaWVz
IG1vdmUgaW50ZWxfcG1jX2NvcmUqIGZpbGVzIHRvIHBtYyBzdWJmb2xkZXIgYXMgd2VsbA0KPiA+
IGFzIGFkZCBBbGRlciBMYWtlIFBDSC1TIHN1cHBvcnQgdG8gUE1DIGNvcmUgZHJpdmVyLg0KPiA+
DQo+ID4gUGF0Y2ggMTogTW92ZSBpbnRlbF9wbWNfY29yZSogZmlsZXMgdG8gcG1jIHN1YmZvbGRl
ciBQYXRjaCAyOiBBZGQNCj4gPiBBbGRlcmxha2Ugc3VwcG9ydCB0byBwbWMgY29yZSBkcml2ZXIg
UGF0Y2ggMzogQWRkIExhdGVuY3kgVG9sZXJhbmNlDQo+ID4gUmVwb3J0aW5nIChMVFIpIHN1cHBv
cnQgdG8gQWxkZXIgTGFrZSBQYXRjaCA0OiBBZGQgQWxkZXIgTGFrZSBsb3cNCj4gPiBwb3dlciBt
b2RlIHN1cHBvcnQgZm9yIHBtYyBjb3JlIFBhdGNoIDU6IEFkZCBHQkUgUGFja2FnZSBDMTAgZml4
IGZvcg0KPiA+IEFsZGVyIExha2UNCj4gPg0KPiA+IENoYW5nZXMgc2luY2UgdjE6DQo+ID4gMSkg
QWRkIHBhdGNoIDEgdG8gdjIgaS5lLiwgTW92ZSBpbnRlbF9wbWNfY29yZSogZmlsZXMgdG8gcG1j
IHN1YmZvbGRlci4NCj4gPiAyKSBNb2RpZnkgY29tbWl0IG1lc3NhZ2UgZm9yIHBhdGNoIDIuDQo+
ID4NCj4gPiBDaGFuZ2VzIHNpbmNlIHYyOg0KPiA+IDEpIERyb3BwZWQgaW50ZWxfcG1jXyBwcmVm
aXggZnJvbSB0aGUgZmlsZSBuYW1lcy4NCj4gPg0KPiA+IENoYW5nZXMgc2luY2UgdjM6DQo+ID4g
MSkgRml4ZWQgYW4gZXJyb3IgcmVwb3J0ZWQgYnkgbGtwLg0KPiA+DQo+ID4gQ2hhbmdlcyBzaW5j
ZSB2NDoNCj4gPiAxKSBVcGRhdGVkIE1BSU5UQUlORVJTDQo+ID4NCj4gPg0KPiA+IERhdmlkIEUu
IEJveCAoMSk6DQo+ID4gICBwbGF0Zm9ybS94ODYvaW50ZWw6IHBtYy9jb3JlOiBBZGQgR0JFIFBh
Y2thZ2UgQzEwIGZpeCBmb3IgQWxkZXIgTGFrZQ0KPiA+ICAgICBQQ0gNCj4gPg0KPiA+IEdheWF0
cmkgS2FtbWVsYSAoNCk6DQo+ID4gICBwbGF0Zm9ybS94ODYvaW50ZWw6IGludGVsX3BtY19jb3Jl
OiBNb3ZlIGludGVsX3BtY19jb3JlKiBmaWxlcyB0byBwbWMNCj4gPiAgICAgc3ViZm9sZGVyDQo+
ID4gICBwbGF0Zm9ybS94ODYvaW50ZWw6IHBtYy9jb3JlOiBBZGQgQWxkZXJsYWtlIHN1cHBvcnQg
dG8gcG1jIGNvcmUgZHJpdmVyDQo+ID4gICBwbGF0Zm9ybS94ODYvaW50ZWw6IHBtYy9jb3JlOiBB
ZGQgTGF0ZW5jeSBUb2xlcmFuY2UgUmVwb3J0aW5nIChMVFIpDQo+ID4gICAgIHN1cHBvcnQgdG8g
QWxkZXIgTGFrZQ0KPiA+ICAgcGxhdGZvcm0veDg2L2ludGVsOiBwbWMvY29yZTogQWRkIEFsZGVy
IExha2UgbG93IHBvd2VyIG1vZGUgc3VwcG9ydA0KPiA+ICAgICBmb3IgcG1jIGNvcmUNCj4gPg0K
PiA+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIg
Ky0NCj4gPiAgZHJpdmVycy9wbGF0Zm9ybS94ODYvS2NvbmZpZyAgICAgICAgICAgICAgICAgIHwg
IDIxIC0tDQo+ID4gIGRyaXZlcnMvcGxhdGZvcm0veDg2L01ha2VmaWxlICAgICAgICAgICAgICAg
ICB8ICAgMSAtDQo+ID4gIGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL0tjb25maWcgICAgICAg
ICAgICB8ICAgMSArDQo+ID4gIGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL01ha2VmaWxlICAg
ICAgICAgICB8ICAgMSArDQo+ID4gIGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3BtYy9LY29u
ZmlnICAgICAgICB8ICAyMiArKw0KPiA+ICBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9wbWMv
TWFrZWZpbGUgICAgICAgfCAgIDUgKw0KPiA+ICAuLi4ve2ludGVsX3BtY19jb3JlLmMgPT4gaW50
ZWwvcG1jL2NvcmUuY30gICAgfCAzMDkgKysrKysrKysrKysrKysrKystDQo+ID4gIC4uLi97aW50
ZWxfcG1jX2NvcmUuaCA9PiBpbnRlbC9wbWMvY29yZS5ofSAgICB8ICAxNyArDQo+ID4gIC4uLi9w
bWMvcGx0ZHJ2LmN9ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMA0KPiA+ICAxMCBm
aWxlcyBjaGFuZ2VkLCAzNTIgaW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25zKC0pICBjcmVhdGUg
bW9kZQ0KPiA+IDEwMDY0NCBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9wbWMvS2NvbmZpZw0K
PiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvcG1jL01h
a2VmaWxlDQo+ID4gIHJlbmFtZSBkcml2ZXJzL3BsYXRmb3JtL3g4Ni97aW50ZWxfcG1jX2NvcmUu
YyA9PiBpbnRlbC9wbWMvY29yZS5jfQ0KPiA+ICg4NSUpICByZW5hbWUgZHJpdmVycy9wbGF0Zm9y
bS94ODYve2ludGVsX3BtY19jb3JlLmggPT4NCj4gPiBpbnRlbC9wbWMvY29yZS5ofSAoOTUlKSAg
cmVuYW1lDQo+ID4gZHJpdmVycy9wbGF0Zm9ybS94ODYve2ludGVsX3BtY19jb3JlX3BsdGRydi5j
ID0+IGludGVsL3BtYy9wbHRkcnYuY30NCj4gPiAoMTAwJSkNCj4gPg0KPiA+IENjOiBTcmluaXZh
cyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGludGVsLmNvbT4NCj4gPiBDYzogQW5k
eSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQo+ID4gQ2M6
IERhdmlkIEJveCA8ZGF2aWQuZS5ib3hAaW50ZWwuY29tPg0KPiA+IENjOiBZb3UtU2hlbmcgWWFu
ZyA8dmljYW1vLnlhbmdAY2Fub25pY2FsLmNvbT4NCj4gPiBDYzogSGFucyBkZSBHb2VkZSA8aGRl
Z29lZGVAcmVkaGF0LmNvbT4NCj4gPiBDYzogUmFqbmVlc2ggQmhhcmR3YWogPGlyZW5pYy5yYWpu
ZWVzaEBnbWFpbC5jb20+DQo+ID4NCj4gPiBiYXNlLWNvbW1pdDogZDkzNmViMjM4NzQ0MzNjYWEz
ZTNkODQxY2ZhMTZmNTQzNGI4NWRjZg0KPiANCj4gVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLXNl
cmllcywgSSd2ZSBhcHBsaWVkIHRoZSBzZXJpZXMgdG8gbXkgcmV2aWV3LWhhbnMNCj4gYnJhbmNo
Og0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9wZHg4
Ni9wbGF0Zm9ybS1kcml2ZXJzLQ0KPiB4ODYuZ2l0L2xvZy8/aD1yZXZpZXctaGFucw0KPiANCj4g
Tm90ZSBpdCB3aWxsIHNob3cgdXAgaW4gbXkgcmV2aWV3LWhhbnMgYnJhbmNoIG9uY2UgSSd2ZSBw
dXNoZWQgbXkgbG9jYWwNCj4gYnJhbmNoIHRoZXJlLCB3aGljaCBtaWdodCB0YWtlIGEgd2hpbGUu
DQo+IA0KPiBPbmNlIEkndmUgcnVuIHNvbWUgdGVzdHMgb24gdGhpcyBicmFuY2ggdGhlIHBhdGNo
ZXMgdGhlcmUgd2lsbCBiZSBhZGRlZCB0bw0KPiB0aGUgcGxhdGZvcm0tZHJpdmVycy14ODYvZm9y
LW5leHQgYnJhbmNoIGFuZCBldmVudHVhbGx5IHdpbGwgYmUgaW5jbHVkZWQgaW4NCj4gdGhlIHBk
eDg2IHB1bGwtcmVxdWVzdCB0byBMaW51cyBmb3IgdGhlIG5leHQgbWVyZ2Utd2luZG93Lg0KDQpU
aGFuayB5b3UgSGFucyENCj4gDQo+IFJlZ2FyZHMsDQo+IA0KPiBIYW5zDQoNCg==
