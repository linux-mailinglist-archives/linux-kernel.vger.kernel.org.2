Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6793FE328
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 21:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244663AbhIATij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 15:38:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:34457 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230458AbhIATii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 15:38:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="216996600"
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="216996600"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 12:37:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="542057913"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga002.fm.intel.com with ESMTP; 01 Sep 2021 12:37:40 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 1 Sep 2021 12:37:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 1 Sep 2021 12:37:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 1 Sep 2021 12:37:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m66+UVzYXQMqjY742zsZnSOqMCLC4XzRiZmPc+0RI8JP075pGl/yQx6vndLgJk0YI9lvUgYuFNvgqCCK+jVn32Kc4frwuTFyzAPOYdSblkCsTFIQEuXG+OfTK5IQ01tg7x7CstHXeaC7gzWJKoiV8f8TwdURsujTZkS3jnPr2myRWphJiPMVpWQ33Gbp4U1rjypMB41GwyVID8WaJiOBEgLeaGH6Y0VXslrTnO7TETWcGKherXHne/zI5OVKvqSAdhzZOIhR+h7Nk6G2gxla6Vsd2rZ0W4JFJj9AVOORBVY7q4+LlVzDEHrd0WnxW6eNKp8B6RWbeKx5kmEgSRii3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqFsyyhiwJmnrVdZFX0MEMl95dMq6c031NsCtJQOaGU=;
 b=bJdUI4BZpg0174SBh7U+8HOJ9AOcqMNG2xIsEC2tqUaCGuDvis6HbOAicaTKpxbBRiSTxhtWynGUb2holxiDSgAMKw1CkvjjH0+Mrvx4owRgZVyG3z50fSojRMhVwWCbgYD7XE5GvylMf19eXOkQGlavV8w0A8TRhXifzuxVXstaDi+uDxB/v3srbBc90IQozGwwvpkZ0Tz860oyBujY2BuGvB7ulx5Pauo8Y/5bE7hsHdjZJw3a2Rz/rMvx9xbHPbrXCX7isiRe4pIKPLI18llWirChdtRLJPvsFOdMw71XW3ksOZl8V4PcRwl89Vq6zWBBjHZ8UhHrfpHJl2dcgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqFsyyhiwJmnrVdZFX0MEMl95dMq6c031NsCtJQOaGU=;
 b=P08J9YAaZ6NbdwK0OTrxeoUtGHfFfujMzVoG88xbLT7n1+rGt294nQr9z6JeBDzjR8ea/PwgVclA+dQlXoV423JT5iRI5gPVDqt0fU+9DLebDzABA7LRoeWqpHCPWLm3RJW1V6w+QU0xu5Swuh2pwmYrWhiBDU5g+AfBbWhELys=
Received: from SJ0PR11MB5150.namprd11.prod.outlook.com (2603:10b6:a03:2d4::18)
 by BY5PR11MB4085.namprd11.prod.outlook.com (2603:10b6:a03:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Wed, 1 Sep
 2021 19:37:36 +0000
Received: from SJ0PR11MB5150.namprd11.prod.outlook.com
 ([fe80::5d75:50e:dcf:6efd]) by SJ0PR11MB5150.namprd11.prod.outlook.com
 ([fe80::5d75:50e:dcf:6efd%4]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 19:37:36 +0000
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "david@redhat.com" <david@redhat.com>
Subject: Re: [PATCH v3 2/3] kernel/resource: disallow access to exclusive
 system RAM regions
Thread-Topic: [PATCH v3 2/3] kernel/resource: disallow access to exclusive
 system RAM regions
Thread-Index: AQHXn2jRsDjKYSy7h0akzVXTH7Wvpw==
Date:   Wed, 1 Sep 2021 19:37:36 +0000
Message-ID: <1f817f71cfef77d795c41f7925662a1f59e4070c.camel@intel.com>
References: <20210831202141.13846-1-david@redhat.com>
         <20210831202141.13846-3-david@redhat.com>
In-Reply-To: <20210831202141.13846-3-david@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-1.fc34) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b01a64fc-930f-483b-4ecc-08d96d7ff3c0
x-ms-traffictypediagnostic: BY5PR11MB4085:
x-microsoft-antispam-prvs: <BY5PR11MB4085665E36C7CF279C07218BC6CD9@BY5PR11MB4085.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NbdHsA90un7lYZVDmpOSVC9mQ+3W2Z6qg9LF6HAKH+3sesrIQ295ifoWZg/o9E6r4qmmo4EZGUfMTSU3v5rkj5vW1so/EwdVEdf7h1UsfleeMWvoMel2MiHh3MHE3xYs9e+74OvOZMOWf95mnzS4/XcuaMQXTrTTFIDBf3IoF1aWvJdruakjcyq1S0+ERBDx9FFFWKnOx4bDeim3+eJHd4nWsN5a0XfrJx9DT4WufW0rpEOZC53KvZEy0Q/mcxeZSeVMWYSUYbnQis2W/Pzpwd5DB+eeu9xBmL5FbhO///8ivVTB2iPR1b+6cFokTkWaRPr5lBCG34wbzStGXeVhjnk8yJmALComPFHuasPOA3ZFWM4LU+/0YaJWUHVlTw5a6t9w3dgAU2oz8a7RbyJo+nny+UBJ8wlX9M3pMGToRVH2gzDVzmZuPfbG+425XXyX9wfg1lXQNFjeYlr5kWR8cJ/xp7Dk9/PqiigOntrxS5MlTyYVlPEgQTpCce2ThEiHtbCOJO2DPdwc+XEioXIcpic5B4Esm3rN3DjM0SGqEU1sKIrnGiZBP0kvQqjchhj5WcMBCGw8hZmfIsBxWJbND85M3OfszP/i+NdKpuv9FkFWCgY2uxpTrWIcQw5Jjqz5Pn5Xj0qWS1iEfhkHi7jaEj0WwcRWzoEqUqLpxl6SIZIJHoHIu4zF8yn5h0gfaQ4FzhWSllFqnufbeul+hkG9Jg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5150.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(86362001)(6486002)(6512007)(2906002)(83380400001)(110136005)(5660300002)(316002)(36756003)(66946007)(64756008)(26005)(2616005)(66446008)(66556008)(122000001)(478600001)(91956017)(38100700002)(8936002)(71200400001)(186003)(38070700005)(76116006)(6506007)(8676002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnorbzMzMW54a2xUMlFVNjg3MFhhMDZ1cllRWm1nclBPVFl4Tk9RRTFYS2VR?=
 =?utf-8?B?a1RqZG80VmxTdGJWR2t5ZWtUbUdmQlFwdGN3V2w1K1huV2Q4aUV3eHBvNUFV?=
 =?utf-8?B?Z1FzVldoUmcrdy9xV3krYWpGRkZBZ0M2NldxeGo5Z2pkc2Y3Ui9KZzRpQkk3?=
 =?utf-8?B?T2JLQW5lSVM5aW9kc2xjaHo2K2lDZWoyMzJqZTNHWjd4Sjh5cjlaVVFCaE5C?=
 =?utf-8?B?eDFZVXdVMzcwZktLZHY1OHdxWWRwK3VGZENpdkF1N01FdE9Gb1lBb1IyZ1Nx?=
 =?utf-8?B?aFpUOHVsQmlkVnQwOW9adEFtM1A3L2YvUmIvbnRpSWRwZy90a1VlbVdwVVpu?=
 =?utf-8?B?UXl3TDdIOXRDL1QzcklJY1BCaTdkcStCRmRhZDBGZ0lzZ2FINGpScjBpd2pJ?=
 =?utf-8?B?bEI3MXFWcW9YYUNDUkUxeDlCU3BSWjRDUzlzVWcxeldXMkUydTE2RDZNKzFF?=
 =?utf-8?B?MjI1ZXBRa0wvdlBtU0lnQXR5NUVENEtCOWtHZW9XZlJaYXNRNE0yQTVuS3ZO?=
 =?utf-8?B?L2dpZzVKSWZ4VXVIbDNETFV6SlhRdjc0THRZSCtsRGRJYUFQNWs2M2NYa0ZB?=
 =?utf-8?B?YUdkYlJuS3RSaFgxaGwyZE5Bc0cyQnFVSExRaDdnbnB0TDJ3SWszbERLY0Rl?=
 =?utf-8?B?VXY0QWRGWUJHc2J1MXlHQnpQd3RoU05LMkFYeXpIdEF2UFJWZ0dDVWNmRlJm?=
 =?utf-8?B?bm9nUmxPeUwrVTRDUWdCQmJEMWhhMXRaTk96cXF1L2N4T0NqTWFLdHNoV1dY?=
 =?utf-8?B?ZkhuYjBQM0ZURVBqcTdJdDU3Q2E5eVQvMUZwYitpVkR1WCtwa1hHVmEzY2lp?=
 =?utf-8?B?TnE5a2xKMlZjS1owWWdlRzdMZERxb3ZzQ3pTOVJ2SWxVcDZ3N0VTeHNqK0h4?=
 =?utf-8?B?MHpsQVhoN1Y3akRUMFFnVmRuUUgxQjV0OU5ZUGM1bGt0eEVxamhyaFlJemY2?=
 =?utf-8?B?S2t2QmEyRVBjZVRoZmt1OHBxUGtoK29nRjFaeUZjUzBpK2VScU9iVWJSUjd4?=
 =?utf-8?B?dEtwUkNLK0lSTWtGZUp6RXN1cTNIY2o2QVQ3WFRwT3VVeW5VT1VZUm5oMC9X?=
 =?utf-8?B?N3Z0bm5NRlRDWWhXbWVmalUxUFl1THczcFRLRHIxbmxQaXoyOVhZdGNJbEhE?=
 =?utf-8?B?SXg5c1Rqb0pnZ04zWHFjWFlIazNWUU1iMjJyMjFTRkNaa0tMcTNPZ09wUytP?=
 =?utf-8?B?TVEwU2pKNzJiM3NReHdCOWk0bW9xUGZIc3BEZ3NHTkdQRThUbFppZklPRFZQ?=
 =?utf-8?B?NDdTNnFBaWlrcmxwYkRDZVNYc1M4NWZ3QzRKSmVlbDdndnRESlh3QjkwWnF0?=
 =?utf-8?B?NDhRcFVFRXdncStYMzRYVGhrQW9hakxyVHRtaVprSmZyN1d2bGVJeGxOak1H?=
 =?utf-8?B?MnY2L3A1Z2g0UHYzRm45T0xTdWtuN2pxMmZxMTRKbE1LU2llZit5eTlnQ1pj?=
 =?utf-8?B?QmtQZmNRc0ZzeGRnL0pDNHlLOFR4TnlUWVYvNlJzczFNTWx4QjdXdUxLQ2hU?=
 =?utf-8?B?R20xdkt2c0hFLzd3YUtyME9RdFk1ZVVkTmxYK0kweTJCQS8rbFZLYXRnL3Ns?=
 =?utf-8?B?K2JMZ0l5bVBXenYzUUw4b2hSb1RxRm5nZElXekwzR2wraDQwMlF5L2hyaHJV?=
 =?utf-8?B?cUkvQk1leUpMY0JKczJxclMweERwdkFIbjZjbEYxekpiT0tWeS9oK2syMzJh?=
 =?utf-8?B?eVA2aGpWeUZqSnZMSVBMU1VnYkh3YUorc3RMOS85aDkraHpuZERiYllhVU85?=
 =?utf-8?Q?bTWBvWurxzHnTZv3wUNLUxg/L/NLa6pOLZP6cdc?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD3F3C2E00D5C44E906922A6D7FC1357@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5150.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01a64fc-930f-483b-4ecc-08d96d7ff3c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 19:37:36.6271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lCcjFOu98vEk/V57f8cAW+NejcMdEp9vyA4Wjf2WTkiR+4uMgpx8Ni6DhoMdv7j9g/SB2FG03x5Erz4zNkJ4k26O7YSCRDOED1XJIHFPNfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4085
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTA4LTMxIGF0IDIyOjIxICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gdmlydGlvLW1lbSBkeW5hbWljYWxseSBleHBvc2VzIG1lbW9yeSBpbnNpZGUgYSBkZXZp
Y2UgbWVtb3J5IHJlZ2lvbiBhcw0KPiBzeXN0ZW0gUkFNIHRvIExpbnV4LCBjb29yZGluYXRpbmcg
d2l0aCB0aGUgaHlwZXJ2aXNvciB3aGljaCBwYXJ0cyBhcmUNCj4gYWN0dWFsbHkgInBsdWdnZWQi
IGFuZCBjb25zZXF1ZW50bHkgdXNhYmxlL2FjY2Vzc2libGUuIE9uIHRoZSBvbmUgaGFuZCwgdGhl
DQo+IHZpcnRpby1tZW0gZHJpdmVyIGFkZHMvcmVtb3ZlcyB3aG9sZSBtZW1vcnkgYmxvY2tzLCBj
cmVhdGluZy9yZW1vdmluZyBidXN5DQo+IElPUkVTT1VSQ0VfU1lTVEVNX1JBTSByZXNvdXJjZXMs
IG9uIHRoZSBvdGhlciBoYW5kLCBpdCBsb2dpY2FsbHkgKHVuKXBsdWdzDQo+IG1lbW9yeSBpbnNp
ZGUgYWRkZWQgbWVtb3J5IGJsb2NrcywgZHluYW1pY2FsbHkgZWl0aGVyIGV4cG9zaW5nIHRoZW0g
dG8NCj4gdGhlIGJ1ZGR5IG9yIGhpZGluZyB0aGVtIGZyb20gdGhlIGJ1ZGR5IGFuZCBtYXJraW5n
IHRoZW0gUEdfb2ZmbGluZS4NCj4gDQo+IEluIGNvbnRyYXN0IHRvIHBoeXNpY2FsIGRldmljZXMs
IGxpa2UgYSBESU1NLCB0aGUgdmlydGlvLW1lbSBkcml2ZXINCj4gaXMgcmVxdWlyZWQgdG8gYWN0
dWFsbHkgbWFrZSB1c2Ugb2YgYW55IG9mIHRoZSBkZXZpY2UtcHJvdmlkZWQgbWVtb3J5LA0KPiBi
ZWNhdXNlIGl0IHBlcmZvcm1zIHRoZSBoYW5kc2hha2Ugd2l0aCB0aGUgaHlwZXJ2aXNvci4gdmly
dGlvLW1lbSBtZW1vcnkNCj4gY2Fubm90IHNpbXBseSBiZSBhY2Nlc3MgdmlhIC9kZXYvbWVtIHdp
dGhvdXQgYSBkcml2ZXIuDQo+IA0KPiBUaGVyZSBpcyBubyBzYWZlIHdheSB0bzoNCj4gYSkgQWNj
ZXNzIHBsdWdnZWQgbWVtb3J5IGJsb2NrcyB2aWEgL2Rldi9tZW0sIGFzIHRoZXkgbWlnaHQgY29u
dGFpbg0KPiDCoMKgIHVucGx1Z2dlZCBob2xlcyBvciBtaWdodCBnZXQgc2lsZW50bHkgdW5wbHVn
Z2VkIGJ5IHRoZSB2aXJ0aW8tbWVtDQo+IMKgwqAgZHJpdmVyIGFuZCBjb25zZXF1ZW50bHkgdHVy
bmVkIGluYWNjZXNzaWJsZS4NCj4gYikgQWNjZXNzIHVucGx1Z2dlZCBtZW1vcnkgYmxvY2tzIHZp
YSAvZGV2L21lbSBiZWNhdXNlIHRoZSB2aXJ0aW8tbWVtDQo+IMKgwqAgZHJpdmVyIGlzIHJlcXVp
cmVkIHRvIG1ha2UgdGhlbSBhY3R1YWxseSBhY2Nlc3NpYmxlIGZpcnN0Lg0KPiANCj4gVGhlIHZp
cnRpby1zcGVjIHN0YXRlcyB0aGF0IHVucGx1Z2dlZCBtZW1vcnkgYmxvY2tzIE1VU1QgTk9UIGJl
DQo+IHdyaXR0ZW4sIGFuZCBvbmx5IHNlbGVjdGVkIHVucGx1Z2dlZCBtZW1vcnkgYmxvY2tzIE1B
WSBiZSByZWFkLiBXZSB3YW50DQo+IHRvIG1ha2Ugc3VyZSwgdGhpcyBpcyB0aGUgY2FzZSBpbiBz
YW5lIGVudmlyb25tZW50cyAtLSB3aGVyZSB0aGUNCj4gdmlydGlvLW1lbSBkcml2ZXIgd2FzIGxv
YWRlZC4NCj4gDQo+IFdlIHdhbnQgdG8gbWFrZSBzdXJlIHRoYXQgaW4gYSBzYW5lIGVudmlyb25t
ZW50LCBub2JvZHkgImFjY2lkZW50aWFsbHkiDQo+IGFjY2Vzc2VzIHVucGx1Z2dlZCBtZW1vcnkg
aW5zaWRlIHRoZSBkZXZpY2UgbWFuYWdlZCByZWdpb24uIEZvciBleGFtcGxlLA0KPiBhIHVzZXIg
bWlnaHQgc3BvdCBhIG1lbW9yeSByZWdpb24gaW4gL3Byb2MvaW9tZW0gYW5kIHRyeSBhY2Nlc3Np
bmcgaXQgdmlhDQo+IC9kZXYvbWVtIHZpYSBnZGIgb3IgZHVtcGluZyBpdCB2aWEgc29tZXRoaW5n
IGVsc2UuIEJ5IHRoZSB0aW1lIHRoZSBtbWFwKCkNCj4gaGFwcGVucywgdGhlIG1lbW9yeSBtaWdo
dCBhbHJlYWR5IGhhdmUgYmVlbiByZW1vdmVkIGJ5IHRoZSB2aXJ0aW8tbWVtDQo+IGRyaXZlciBz
aWxlbnRseTogdGhlIG1tYXAoKSB3b3VsZCBzdWNjZWVlZCBhbmQgdXNlciBzcGFjZSBtaWdodA0K
PiBhY2NpZGVudGlhbGx5IGFjY2VzcyB1bnBsdWdnZWQgbWVtb3J5Lg0KPiANCj4gU28gb25jZSB0
aGUgZHJpdmVyIHdhcyBsb2FkZWQgYW5kIGRldGVjdGVkIHRoZSBkZXZpY2UgYWxvbmcgdGhlDQo+
IGRldmljZS1tYW5hZ2VkIHJlZ2lvbiwgd2UganVzdCB3YW50IHRvIGRpc2FsbG93IGFueSBhY2Nl
c3MgdmlhDQo+IC9kZXYvbWVtIHRvIGl0Lg0KPiANCj4gSW4gYW4gaWRlYWwgd29ybGQsIHdlIHdv
dWxkIG1hcmsgdGhlIHdob2xlIHJlZ2lvbiBhcyBidXN5ICgib3duZWQgYnkgYQ0KPiBkcml2ZXIi
KSBhbmQgZXhjbHVkZSBpdDsgaG93ZXZlciwgdGhhdCB3b3VsZCBiZSB3cm9uZywgYXMgd2UgZG9u
J3QNCj4gcmVhbGx5IGhhdmUgYWN0dWFsIHN5c3RlbSBSQU0gYXQgdGhlc2UgcmFuZ2VzIGFkZGVk
IHRvIExpbnV4ICgiYnVzeSBzeXN0ZW0NCj4gUkFNIikuIEluc3RlYWQsIHdlIHdhbnQgdG8gbWFy
ayBzdWNoIHJhbmdlcyBhcyAibm90IGFjdHVhbCBidXN5IHN5c3RlbSBSQU0NCj4gYnV0IHN0aWxs
IHNvZnQtcmVzZXJ2ZWQgYW5kIHByZXBhcmVkIGJ5IGEgZHJpdmVyIGZvciBmdXR1cmUgdXNlLiIN
Cj4gDQo+IExldCdzIHRlYWNoIGlvbWVtX2lzX2V4Y2x1c2l2ZSgpIHRvIHJlamVjdCBhY2Nlc3Mg
dG8gYW55IHJhbmdlDQo+IHdpdGggIklPUkVTT1VSQ0VfU1lTVEVNX1JBTSB8IElPUkVTT1VSQ0Vf
RVhDTFVTSVZFIiwgZXZlbiBpZiBub3QgYnVzeQ0KPiBhbmQgZXZlbiBpZiAiaW9tZW09cmVsYXhl
ZCIgaXMgc2V0Lg0KPiANCj4gRm9yIG5vdywgdGhlcmUgYXJlIG5vIGFwcGxpY2FibGUgcmFuZ2Vz
IGFuZCB3ZSdsbCBtb2RpZnkgdmlydGlvLW1lbSBuZXh0IHRvDQo+IHByb3Blcmx5IHNldCBJT1JF
U09VUkNFX0VYQ0xVU0lWRSBvbiB0aGUgcGFyZW50IHJlc291cmNlIGNvbnRhaW5lciBpdA0KPiBj
cmVhdGVzIHRvIGNvbnRhaW4gYWxsIGFjdHVhbCBidXN5IHN5c3RlbSBSQU0gYWRkZWQgdmlhDQo+
IGFkZF9tZW1vcnlfZHJpdmVyX21hbmFnZWQoKS4NCg0KTG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQt
Ynk6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KDQo=
