Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79213EDD1E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 20:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhHPSeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 14:34:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:49149 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230102AbhHPSeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 14:34:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="301497711"
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="301497711"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 11:33:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="487601315"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 16 Aug 2021 11:33:40 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 16 Aug 2021 11:33:40 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 16 Aug 2021 11:33:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 16 Aug 2021 11:33:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 16 Aug 2021 11:33:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTiCoY6OJSjDXl1pzOVnZQ/uSVvQEYHli9+YoboQ37tBDXdiEoTs/zqSqatyEEEKg87Z1g3sfIk/d6vtZiKSLR418e309HHqLip6/iv9r37Dap2W3ZkMIgERrFBMIR0aBzv4TF2KPG4xP5cFO9FI7nI57mQYUgiucFwakFrCwAwxQe+cTSWfyLeJFBWgbPE3gDHln3bNQt+SA58ZtVbqP/HTjfAny0IQE9+9IJr7iaav0SF9mRrbQuwVYjt6zE8segwaXcddxLfMbNNiMz2rpJjBTka18miwNnRXkG52AeRorWlZ3iXzldVzPxUnIz6mhbXM2G6/VIh3qfHD39fnmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFsg8kpAPNpDNc5mlW7Zh3g3lL79TZhCcldPijxyoyQ=;
 b=N5nf4InkhQM6AgLtoIAdhobp0qqBFsR90YHJ2+EAz8Pi5NbkFv8KKQ3psVCC8B3EMk0l6ap0Y3/pHMmi1xmSTACq7/yiTMaFR0bsR+8dJ382TUq3qeym5NmPEHHh8bmuuaLEbUtXi/iFmi59gerFixMCJxN8VSWQO0nODD0abZMYllZ/s0CCkHOpPYda2oF39zzpE5ihkss/AMGMoudXNRKUMbvThM8+GkY3+XvGBEiYDOiSAxxmmwpHkmFvj1TcZ+FAexM+YXkkgCtm0kv/Ya6sHZpGeWJbnRBszN8jZHlzy+/hz1jnsepWPRfdx0S8yvwizqRy25ZDo9QI9vzLfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFsg8kpAPNpDNc5mlW7Zh3g3lL79TZhCcldPijxyoyQ=;
 b=T/UsnmTYd6/GjR+MPxOiBKAmFyBVygKyCexUntSoKyfFqEVzapicvRW/KpgeALFXbWaf2ooZSD3oWzkZaCjb/tFgBPXuKLLFzm8PF5R9lpUQexJ6Dqc9wFSl+o0L4ui8bZVz224QprvTY8sAVVro+vVGgmXg0SJQcpV9hktNfp4=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4840.namprd11.prod.outlook.com (2603:10b6:510:43::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Mon, 16 Aug
 2021 18:33:37 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8%5]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 18:33:37 +0000
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
Subject: Re: [PATCH v9 08/26] x86/fpu/xstate: Introduce helpers to manage the
 XSTATE buffer dynamically
Thread-Topic: [PATCH v9 08/26] x86/fpu/xstate: Introduce helpers to manage the
 XSTATE buffer dynamically
Thread-Index: AQHXhVRxstI5EaBny0+yAHwtQ/jrKKtwWl6AgAY1aoA=
Date:   Mon, 16 Aug 2021 18:33:37 +0000
Message-ID: <4FD76EDB-A5E6-4F32-8C6C-B47D7456C206@intel.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-9-chang.seok.bae@intel.com> <YRV6M1I/GMXwuJqW@zn.tnic>
In-Reply-To: <YRV6M1I/GMXwuJqW@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3aaf547f-e740-4f49-d7a3-08d960e45c98
x-ms-traffictypediagnostic: PH0PR11MB4840:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB4840FE7A48069B160496098FD8FD9@PH0PR11MB4840.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cq4FgSnOhosljr5o11Mt6hfR4xQcBnqraCt3T3Vb1lt/0LQjP3uhh8p7U6M5Gyn57hkLo/fdC9QF6xo0newIhk2NiYPko4HJte+u2RwlY7pEdSTK6DkA5vLEq5lIvdkxT8Ruinu4EPicY8GFiQYHVqFrHXdwnIBgFsc1OvU19782MUXMLWXhU1/gk2Udd9Hi6fxCpVFurXPY7atolj8iVQ+U3nA21pOS+vrftNKckGejA/gzNqx3nYMbNynyFl1sY5ADCdLLp3/ikW4KI/Ffd6DItE/zMl0WKO2Uk/AXsn+nX/EmStiasUSVO+ypwCz0ExZT+gJgwQ6IlREFAdht81PamaCdtlcCBszwuxYtBRxs8O7bsX4cpzihYAW5cOepHy5AkBnto16mqZCAl7ZyiOC5tAXJqCMCiv3v8y9Fd14Ghs1MXhs4csWQIHoBhoJ5jhnjFJmnZPrW9E7FOgBoN17/dWcMvbMIMCKi897q0yw6dy+lwNtqRTNl4KJp81v42VOuSUKSQ45sNE44sZJ7M/czo/yvNVsv6dpn3BDMZNvjgS2A0CChDlFYSugyk4mVe06m3Z4MTT8X6DcNifbLJlsVXta1uJRzQbpySwGIn/9zsg1ZAJ8JnXjzbAHVyuiCx+LpHSOrC/YPXsoIv5tJBjU/iuGva7uhG/g0moQWcHdfTSx6huhWMl+8JxYYkcJnod5PBrqVSFoi0AioyHqFIOor9R35htteSrR+lCTlsiM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(64756008)(66476007)(66946007)(2906002)(38100700002)(66446008)(36756003)(8676002)(66556008)(5660300002)(508600001)(4744005)(8936002)(6512007)(6486002)(38070700005)(71200400001)(53546011)(316002)(6916009)(54906003)(26005)(186003)(2616005)(86362001)(76116006)(4326008)(122000001)(6506007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVVtclFsM0FvQ2ZZMmRrVngzWDk1QWFQRjFWU2ZKTU9UTkplVSsybHBRcXA4?=
 =?utf-8?B?N2NBOW9yU2t4UmZLclFCVis1Qy82MlRtUHNtMlplSnNuOXVOOUhJc3pJdzNT?=
 =?utf-8?B?Qmt3MTFFNkpldnRnaTVvcmFGU0ZDSndqMVppY1ZybzBPdHFlV2ZVRWNXcG9x?=
 =?utf-8?B?VTRYckVoSTI0LzZqNFdsRFV2eTd6NnhUQ0hxcHovdkVDUGtwMkk3SzBRRDdK?=
 =?utf-8?B?Nm5WNDJncHc1eDBNNTIxdGhtWjRwdnAxR3JhVW1IUVVIVWpScitaMncxenNz?=
 =?utf-8?B?R0dEdGx4dzVVSHdXeGU4ZDZXWFo5Vml0dnd5RHczNCs4OGNhb3hCNWFtbE9W?=
 =?utf-8?B?QnRldElyYmlvUmFGL0UwVFNqOGZ3cUN6LzBPcHl3eDdBcWpwSnArS1EweUp0?=
 =?utf-8?B?b2RGWTJvVHJNZm1Ra1FuVHBSUzBIRzYwdHpuWitxWnZlS21ZQU9PRW9rMVRM?=
 =?utf-8?B?ZDZSREo5Wm9wQUU0aE9GOFdwb0swMGdnL0hRcUpoNzFuOVNGcDZlTEhseVJl?=
 =?utf-8?B?UkUzWHhHdklyMEdrVmUwWHFFYnk1M1ZJMjh2Q0wzT2hUSnlURTA5a05pYWp5?=
 =?utf-8?B?TEVydE5ib2RmNTQyK01RVzZrQk1vY0dkNXdxUFlJNUZnSS8zclRjZUNMZDJH?=
 =?utf-8?B?SVp3TVhzU0lxL3U4NSt0RUwzN2FjR0RXbUJuL0pER3Z4N1FKeW9xZHNVeUFT?=
 =?utf-8?B?K0JZVElEWkVPdlBWUUowTEhvUEp2aFQ1MTdDa3RCa1d5SmdVOHR3UDVkSDlW?=
 =?utf-8?B?S3VwZUpUaXFsOTEwcm5EQnRFTHg4Mm8rR0cvN2hYeVRxR0cwM0gyRzNsOXp4?=
 =?utf-8?B?cG1VS2I5K01mVG5ZR0crbW9RaUc3NUJ5OGo4bHVIdzlRblk2S21HaEF6MUZW?=
 =?utf-8?B?aFM5bDcyNFNsY1NDWmNJUFVKd2ZhcVk2UEM0dEgydjUwWS9aYkRWRjZGSzBY?=
 =?utf-8?B?bkkxbVVVVlJTWEZzblR3N3hkSE5aNmdrUnEzSWtYQ3dnR1ZzK3FxZ3U5cmt4?=
 =?utf-8?B?NDN1T28ya3ZvYWhuN1hyNm90Mnc1dlJhWG4rc0YzejdPTFQ4Z0ZESThka0pV?=
 =?utf-8?B?TDlQOFJXRXBEYVVRY1NjcFIyYTFLL09qWFlwdGxzM1d5M2M5ZGl4ZUMzc1BZ?=
 =?utf-8?B?ZDlhT3M0MExjTVE5Qm9kM1VlUkhkcTg0LzBwTUVNMmhIZHVJWm9odi8xVFJR?=
 =?utf-8?B?RW9lUWVaWHZWaE9pM0djcEdOUXVkL3VhTHZNTEliOU45YW9SLzJWdjFkeFlU?=
 =?utf-8?B?b2VLYTNYdWRLSVBaZzZVbFZDcWZJeDFVbVQwb3pURzl5MHJRamhrYzVUU1h2?=
 =?utf-8?B?Z1lPSy8vQm9nMTRIQVEwNWRrdFVyVEx0UkpNNkJsSkJrZm9UU1RDYjF1YTBz?=
 =?utf-8?B?aVRNY0F3WmlFL2dkTnhpU09QbThmNDhHNGVZdGtIL2V6QW5wZkhjQ2l3dGV2?=
 =?utf-8?B?OU5xdUh0QjRnd3BOcXAyR085STZDajUrU2huYlV0NFhJWUFnbE9sTkRmK0VI?=
 =?utf-8?B?V0tKaVJJd1JEUXFuZ3pKSjJOVlM0NW5pZjNibUxYQS9QdW1EZ0hETFNtU2pI?=
 =?utf-8?B?RW11MkFneXBaUGd5ZzJFaGxaR0F1MEEzcFFZWDFpMy96TDZTTnRPR0NmbVM2?=
 =?utf-8?B?QjBMbExuNnhpL1BFakw5NzQxd25MMnNMeWZkR2pvc2ZCd2s4QmxkQlNlVnJo?=
 =?utf-8?B?RDlvUXRmbG9xMlN5Mzg3UzcvcEtrZ0NSbW5MeTl3Wk5UM3FtTlJvNWdINEhU?=
 =?utf-8?Q?af5jUeZLPzy8X7H/+9nEdpx8qxmpV3pUzu8zLzY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8360FCEF7C31B742B507210576149165@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aaf547f-e740-4f49-d7a3-08d960e45c98
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 18:33:37.0224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jr8tXeiPIT0hNzI5Y7PrW7vxe17DmbQO9jOauQPkZyq8Cg08OCUzH8WlwhvqV0e/tpXHsT+lt1RCNxEjQLDfJUkIKVOLybyJ0xbGQV/ZTDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4840
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gQXVnIDEyLCAyMDIxLCBhdCAxMjo0NCwgQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+
IHdyb3RlOg0KPiBPbiBGcmksIEp1bCAzMCwgMjAyMSBhdCAwNzo1OTozOUFNIC0wNzAwLCBDaGFu
ZyBTLiBCYWUgd3JvdGU6DQo+PiANCj4+ICsJaWYgKGJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9Y
U0FWRVMpKQ0KPiANCj4gY3B1X2ZlYXR1cmVfZW5hYmxlZA0KDQpXaXRob3V0IERJU0FCTEVfWFNB
VkVTIG9yIHNvbWV0aGluZyB1bmRlciBpZmRlZiBDT05GSUdfWDg2X1hYIGluDQokYXJjaC94ODYv
aW5jbHVkZS9hc20vZGlzYWJsZS1mZWF0dXJlcy5oLCBJIGRvbuKAmXQgc2VlIHRoZSBkaWZmZXJl
bmNlIHdpdGggdGhpcw0KbWFjcm8uIEFtIEkgbWlzc2luZyBhbnl0aGluZyBoZXJlPyBPciwgYm9v
dF9jcHVfaGFzKCkgaXMgZ29pbmcgdG8gYmUNCmRlcHJlY2F0ZWQgZXZlcnl3aGVyZT8NCg0KVGhh
bmtzLA0KQ2hhbmcNCg0K
