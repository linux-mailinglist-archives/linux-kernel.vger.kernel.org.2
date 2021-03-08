Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65AC331806
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 21:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhCHUAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 15:00:23 -0500
Received: from mga05.intel.com ([192.55.52.43]:51547 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231296AbhCHUAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 15:00:05 -0500
IronPort-SDR: t0zdg3mNRUUYYbwdIy9+y9c5MMGa1pAPzHNlZhjLrgW9gdrVFL4Y5JfJYk+lWpVJMAnlZs7HXf
 0w97AiJtXIxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="273124149"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="273124149"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 12:00:04 -0800
IronPort-SDR: mW/1vPq8Meg1Bsw7seM9PQ+M6eVdN2z1n7MgR9HPINkLn4dxwpZjv6qhty2dC/wLaFkok3dSRR
 yJ0110jndgPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="447244102"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 08 Mar 2021 12:00:03 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 12:00:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 8 Mar 2021 12:00:03 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 8 Mar 2021 12:00:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYZ6JvGHgOzB9qgeX/4sjgQ5OG2q+W6KHRUU3f4SYurz0Tm3d5HC23NRKwZiU/q86hyRSB1kP3eTcUAO7mf0pkjk6OQkPpKJbKcaDi7Xe5uB2CjifGYm8C6vxttEglYZmLf99OGE/b6h+RagEaM5ZOp5WgaqIv6o5g7BfbINdmAFVpkFDYdsFQMjgxZ2OenxOPO1m2d5aOo0KMnMS5D3XzEamBSFMjOhU4Jy3SoyEEyC3M7HZlCBbl9dreEefiGVpErmAoqZwM6RyLwcRqNy+EG5kN6mroakhMKwzUnoNy7Eq6HZGHQa096UM3jI0jL8QdzB7pAkeIjrKfxsJYHViQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doGEZ8sOk6bR4zOOB2LRDw6hqTWcU4ruzVPK1PZw8nU=;
 b=OzaZpHWcphKUHo/isrFf2iE23uB+JDrlS7aKKopkQNZUZ+tFNiM9H8u44oNB6Fv0H8pLiZaH619f7Up5ZeC9y5P5uX2Cwa8xmXbFVDxuf3HsqEHOeAKcWy1Yn0PQtqkCBW7kgPfeEbxvmTSOKF1LQs4SfFWk2wiiBWkBQu92VQVnE0M8YfZnE4YkOdwA9yegYzSHDjQa+cl44aIiEohKIWv01N9lb+2lwKC1y0QMAywtiysgzob/k8nGXyspcRJOyJbv+I67a7Zmz41OlvDUdMOUmxMTBQYRnctK0Bmi5p5/Bam3McaQjoBEsda5znRvkzVmRkxdcki6vPaKZ4Awsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doGEZ8sOk6bR4zOOB2LRDw6hqTWcU4ruzVPK1PZw8nU=;
 b=S1F1wyuT5zdEu2wOFlTiyWlHQCzvxLfAJPZhImHi005Vh6J2wIbSl6+23U5ZDkBmoOTMtHPlelPU5NJxLOo5m+ZicPg26/aQR1HtuvaMwo/LlGTUgOS0Hoy4ma9blKbSe04JhELLetwTO8bR+MB8UGKRT4y05t9c9nrIpO14RT8=
Received: from BYAPR11MB3095.namprd11.prod.outlook.com (2603:10b6:a03:91::26)
 by SJ0PR11MB4927.namprd11.prod.outlook.com (2603:10b6:a03:2d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Mon, 8 Mar
 2021 20:00:01 +0000
Received: from BYAPR11MB3095.namprd11.prod.outlook.com
 ([fe80::e47d:c2cb:fe53:e0e6]) by BYAPR11MB3095.namprd11.prod.outlook.com
 ([fe80::e47d:c2cb:fe53:e0e6%4]) with mapi id 15.20.3890.035; Mon, 8 Mar 2021
 20:00:01 +0000
From:   "Chen, Mike Ximing" <mike.ximing.chen@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Subject: RE: [PATCH v10 01/20] dlb: add skeleton for DLB driver
Thread-Topic: [PATCH v10 01/20] dlb: add skeleton for DLB driver
Thread-Index: AQHW9P+hri3YEhHn10KqfTIlfsDxHqpP5y6AgAAwW4CAKqelsA==
Date:   Mon, 8 Mar 2021 20:00:00 +0000
Message-ID: <BYAPR11MB3095C54BA878D8A5502CA891D9939@BYAPR11MB3095.namprd11.prod.outlook.com>
References: <20210127225641.1342-1-mike.ximing.chen@intel.com>
 <20210127225641.1342-2-mike.ximing.chen@intel.com>
 <YCKP5ZUL1/wMzmf4@kroah.com>
 <CAPcyv4hC2dJGAXbG2ogO=2THuDUHjgYekkNy4K_zwEmQcXLcjA@mail.gmail.com>
In-Reply-To: <CAPcyv4hC2dJGAXbG2ogO=2THuDUHjgYekkNy4K_zwEmQcXLcjA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [69.141.163.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8adde338-be18-4c62-b333-08d8e26cc1f1
x-ms-traffictypediagnostic: SJ0PR11MB4927:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB49270EC78BD947007AB3547DD9939@SJ0PR11MB4927.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mP4/rjahaK4YPqw3lgJSkC0xHiXitDZo1vcIHBQE3CqtRfABHDOAEgsKcqz3M97MzmXcqvCsPtmOTM78vMbDoQCtmuunZO8g3WLSJzAQm94wzF716fzSCAkLjbNJhl0L3K/6wKDUkmkaM4D5oeLO9H1HWfXz69iWUxRvyu1vMeWxKjJXCFVHIccv+vCD6Fl7/r2JdeHj9QMWtsLkEemV3l3wL6PXaYFHNLy+8dBofTxljL5sqQnyskjdyWb+aLATZ9+NxWMEwZqFbcILH+yHKLGYraIDDquFNTlGViDBetW9kLauLtmSqAJK/hB3QbipTFJ9f+//5/LY2seCmDdmgaLfubulkE+/Rmdsdymw9LTBgJflLwD5OcCdPknBGN99sT/BAii8R2FupINnPgCYWYFlvUtQFoQXMviAPZXAMnvO3t7Xh5S0Ytkxx0yXjvQcWpZmrNqWfxpMb5brM3Vl+owNLrSLgz8R7IWIpfXAVxnQ3iMqDRkoxTydHb8unvQwPNEvXpt7jhLUHCT9iia+RQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(376002)(366004)(396003)(76116006)(5660300002)(4326008)(316002)(86362001)(2906002)(186003)(83380400001)(71200400001)(8936002)(53546011)(9686003)(55016002)(26005)(8676002)(7696005)(110136005)(52536014)(33656002)(64756008)(478600001)(54906003)(66446008)(66476007)(66556008)(66946007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NHdOclozcWo5ZEFhM3BGcmd0VUh2dEJnc0xoSUYzSUhjTU5sclg5OVl0bE1G?=
 =?utf-8?B?V3dONU1yMXRpY3BNU2RheUJjMzVVbUl4aWx4STdFblRHdmhZaHRkWStyQ3hG?=
 =?utf-8?B?NmhxM2M5NGRSRHBNNjBOdGNvZFBuMmFnWnplMzZidzY3eEx3VExUdUphU2tB?=
 =?utf-8?B?NFJhaHhRT2JwanpQQjRtT0k2a0pSQjgrNHorNE4vV08yVlQyZ0pkWHhuazF0?=
 =?utf-8?B?T1ZkT1REemxGaFlFU2pMZER4SGNyU2htcWVydno0eG9yd01ITzQ2YnllMEt4?=
 =?utf-8?B?Zk5teXFMekF1eW4zQlVsMisrMGNlRzE5K2IycS9hWEFYU3UwSXNkeDE5dlNx?=
 =?utf-8?B?MStRNnk3cERyUkU5dTFaYUhIVHQvRW1jQ1hOK2s2cjl5cUdOdVRuMTVOQmtw?=
 =?utf-8?B?Um02U0FLZVVvak03L1czUjkrdm1ERHhVcGhzTlpBdzdJYkZvYUR2L1VlZlZQ?=
 =?utf-8?B?ajRaY0hvWW04TTc5aHdFMWY4MVpHNUgvSTRDc3lxaUtwYWxRaS8vODZjK0xa?=
 =?utf-8?B?dlhOcGoxR1A2RWFDSjdhNWpKZXplSVEyalVvU2dRM2N6MjV1cWpXRUdoZFVZ?=
 =?utf-8?B?Q3RiYnVxVVJNcDFYdjU5Z21Cd1FaTm9pN1N3NUJneldWTHJSZlFMbWliUk9p?=
 =?utf-8?B?dVlHZ0wwZTh2SlRxNTl2MTA5S0xWVU54YngzTjRmdGRhVFVoTXJWSHRxdDdn?=
 =?utf-8?B?QjJ6MURra1dXTDdRem9ISUhtdlBucGU3ZzhJRnNVTVNJRUY4Z1Z3anU4ZFU5?=
 =?utf-8?B?Zjl1aGdqbDF1MlBsdE91MkwyVUJ6bE1iZEl6MGJ2cVpWcnhUTjQ2cDltdHFO?=
 =?utf-8?B?REJha1AvaEU4eTgwV1NQbVFWR3NENHgraDNKcEtUQW1jZ3FQZi9pV1NBNUk0?=
 =?utf-8?B?MkVDazdmYldqYVkwKzZTMndDQzA2ZTZLMGNlSzk1aDN6K0RwVExJN0VDSHRn?=
 =?utf-8?B?WER0eW9UYVFqQkJuNzUwMEZYQTRRZWIxVnd4MmJFVTV0bG9NSlhNSk4wWVEy?=
 =?utf-8?B?dC8yRTdlMEVRM0dMdlJHUUVGcDR5WXFQNkhSVXc5aTRmemNRbVhWY1NYTEVw?=
 =?utf-8?B?TGhVU1BZU2tQcDFKV1NBTXUwTFc4UUFnNk41Sm0zdzlySk5FaGdqeU1SMDFI?=
 =?utf-8?B?MnJCclFvK2pkL1lpVkRBWlhDdzVGQ2RCL2lObUloVC9qa3dVaG9QZjJIclVB?=
 =?utf-8?B?eHJVYVpBTmtPWEZkRlFQRDlnemJhWEYvNDdFdnFGSXV1Z2VFTVBNQ3BMTTht?=
 =?utf-8?B?d0owOWJBK3RIOEprTGVZd2xlRWxsdTFLZVJtc0l6b3hDOURKZWVzK0RrVFht?=
 =?utf-8?B?NHc5bU9ZeEZTeVRiRStzaW1xOGdDZ1BFaEk4cUxGYkNVVnlPdndqYnorNlEw?=
 =?utf-8?B?VzdSTnpMSmpmOVRYc1hvLzBBeDJFMjZvY2FJUkgxcXc2T21qSi95YkJZNDJy?=
 =?utf-8?B?YndkMkVEVHFMakFMS1R6dmN0TWtNdWhtSnFOOWthRFdrRTFwUVl3UEk1TVlt?=
 =?utf-8?B?bjZmTWJFYTdJUUFENGJ0aVRHQWFkMndZbXRHYXB1QXREUWIyckZSSmg1azRO?=
 =?utf-8?B?amJmc0tzci9YcmtJSVdyTUFuMlBhZUl1MXBYT1cxTXZRQlFkU0JUMHVyRi8w?=
 =?utf-8?B?NStDY1daZlRVTTg5MHcza3QzMnNvRlQ1UWVocU5BOGlYMnZVL1FVenY3dXNh?=
 =?utf-8?B?SGN5ZGlkSmFJblZKQnY4TXl5YXpPU3NFWWN5QVNOZ2NMZ1prTE1NZW1ManJs?=
 =?utf-8?Q?pPN1/Qf2dyH5UMkAAQP01VDouqccBPMrllbAi5D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adde338-be18-4c62-b333-08d8e26cc1f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 20:00:01.0003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3x4ViAPgok+/U3BFXhJJKsR1zy9IJfZlWUZdT1myUD1SSmzZud1bpcEg1KgWl7o6d+1/S7gOTe9yNCyYe1tAOM6zFiekJZdAs9FENq/UpLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4927
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuIFdpbGxpYW1zIDxk
YW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDksIDIw
MjEgMTE6MzAgQU0NCj4gVG86IEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0K
PiBDYzogQ2hlbiwgTWlrZSBYaW1pbmcgPG1pa2UueGltaW5nLmNoZW5AaW50ZWwuY29tPjsgTGlu
dXggS2VybmVsIE1haWxpbmcgTGlzdA0KPiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47
IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+OyBQaWVycmUtTG91aXMNCj4gQm9zc2FydCA8
cGllcnJlLWxvdWlzLmJvc3NhcnRAbGludXguaW50ZWwuY29tPjsgR2FnZSBFYWRzIDxnYWdlLmVh
ZHNAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxMCAwMS8yMF0gZGxiOiBhZGQg
c2tlbGV0b24gZm9yIERMQiBkcml2ZXINCj4gDQo+IE9uIFR1ZSwgRmViIDksIDIwMjEgYXQgNToz
NiBBTSBHcmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+ID4NCj4g
PiBPbiBXZWQsIEphbiAyNywgMjAyMSBhdCAwNDo1NjoyMlBNIC0wNjAwLCBNaWtlIFhpbWluZyBD
aGVuIHdyb3RlOg0KPiA+ID4gQWRkIGJhc2ljIGRyaXZlciBmdW5jdGlvbmFsaXR5IChsb2FkLCB1
bmxvYWQsIHByb2JlLCBhbmQgcmVtb3ZlIGNhbGxiYWNrcykNCj4gPiA+IGZvciB0aGUgRExCIGRy
aXZlci4NCj4gPiA+DQo+ID4gPiBBZGQgZG9jdW1lbnRhdGlvbiB3aGljaCBkZXNjcmliZXMgaW4g
ZGV0YWlsIHRoZSBoYXJkd2FyZSwgdGhlIHVzZXINCj4gPiA+IGludGVyZmFjZSwgZGV2aWNlIGlu
dGVycnVwdHMsIGFuZCB0aGUgZHJpdmVyJ3MgcG93ZXItbWFuYWdlbWVudCBzdHJhdGVneS4NCj4g
PiA+IEZvciBtb3JlIGRldGFpbHMgYWJvdXQgdGhlIGRyaXZlciBzZWUgdGhlIGRvY3VtZW50YXRp
b24gaW4gdGhlIHBhdGNoLg0KPiA+ID4NCj4gPiA+IEFkZCBhIERMQiBlbnRyeSB0byB0aGUgTUFJ
TlRBSU5FUlMgZmlsZS4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBHYWdlIEVhZHMgPGdh
Z2UuZWFkc0BpbnRlbC5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNaWtlIFhpbWluZyBDaGVu
IDxtaWtlLnhpbWluZy5jaGVuQGludGVsLmNvbT4NCj4gPiA+IFJldmlld2VkLWJ5OiBNYWdudXMg
S2FybHNzb24gPG1hZ251cy5rYXJsc3NvbkBpbnRlbC5jb20+DQo+ID4gPiBSZXZpZXdlZC1ieTog
RGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+
ICBEb2N1bWVudGF0aW9uL21pc2MtZGV2aWNlcy9kbGIucnN0ICAgfCAyNTkgKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ID4gPiAgRG9jdW1lbnRhdGlvbi9taXNjLWRldmljZXMvaW5kZXgu
cnN0IHwgICAxICsNCj4gPiA+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgIDggKw0KPiA+ID4gIGRyaXZlcnMvbWlzYy9LY29uZmlnICAgICAgICAgICAgICAgICB8ICAg
MSArDQo+ID4gPiAgZHJpdmVycy9taXNjL01ha2VmaWxlICAgICAgICAgICAgICAgIHwgICAxICsN
Cj4gPiA+ICBkcml2ZXJzL21pc2MvZGxiL0tjb25maWcgICAgICAgICAgICAgfCAgMTggKysNCj4g
PiA+ICBkcml2ZXJzL21pc2MvZGxiL01ha2VmaWxlICAgICAgICAgICAgfCAgIDkgKw0KPiA+ID4g
IGRyaXZlcnMvbWlzYy9kbGIvZGxiX2h3X3R5cGVzLmggICAgICB8ICAzMiArKysrDQo+ID4gPiAg
ZHJpdmVycy9taXNjL2RsYi9kbGJfbWFpbi5jICAgICAgICAgIHwgMTU2ICsrKysrKysrKysrKysr
KysNCj4gPiA+ICBkcml2ZXJzL21pc2MvZGxiL2RsYl9tYWluLmggICAgICAgICAgfCAgMzcgKysr
Kw0KPiA+ID4gIDEwIGZpbGVzIGNoYW5nZWQsIDUyMiBpbnNlcnRpb25zKCspDQo+ID4gPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vbWlzYy1kZXZpY2VzL2RsYi5yc3QNCj4gPiA+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9taXNjL2RsYi9LY29uZmlnDQo+ID4gPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbWlzYy9kbGIvTWFrZWZpbGUNCj4gPiA+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9taXNjL2RsYi9kbGJfaHdfdHlwZXMuaA0KPiA+ID4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL21pc2MvZGxiL2RsYl9tYWluLmMNCj4gPiA+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9taXNjL2RsYi9kbGJfbWFpbi5oDQo+ID4gPg0KPiA+ID4gZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vbWlzYy1kZXZpY2VzL2RsYi5yc3QgYi9Eb2N1bWVudGF0
aW9uL21pc2MtDQo+IGRldmljZXMvZGxiLnJzdA0KPiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4gPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uYWE3OWJlMDdlZTQ5DQo+ID4gPiAtLS0gL2Rldi9u
dWxsDQo+ID4gPiArKysgYi9Eb2N1bWVudGF0aW9uL21pc2MtZGV2aWNlcy9kbGIucnN0DQo+ID4g
PiBAQCAtMCwwICsxLDI1OSBAQA0KPiA+ID4gKy4uIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wLW9ubHkNCj4gPiA+ICsNCj4gPiA+ICs9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09DQo+ID4gPiArSW50ZWwoUikgRHluYW1pYyBMb2FkIEJhbGFuY2VyIE92
ZXJ2aWV3DQo+ID4gPiArPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0KPiA+ID4gKw0KPiA+ID4gKzpBdXRob3JzOiBHYWdlIEVhZHMgYW5kIE1pa2UgWGltaW5nIENo
ZW4NCj4gPiA+ICsNCj4gPiA+ICtDb250ZW50cw0KPiA+ID4gKz09PT09PT09DQo+ID4gPiArDQo+
ID4gPiArLSBJbnRyb2R1Y3Rpb24NCj4gPiA+ICstIFNjaGVkdWxpbmcNCj4gPiA+ICstIFF1ZXVl
IEVudHJ5DQo+ID4gPiArLSBQb3J0DQo+ID4gPiArLSBRdWV1ZQ0KPiA+ID4gKy0gQ3JlZGl0cw0K
PiA+ID4gKy0gU2NoZWR1bGluZyBEb21haW4NCj4gPiA+ICstIEludGVycnVwdHMNCj4gPiA+ICst
IFBvd2VyIE1hbmFnZW1lbnQNCj4gPiA+ICstIFVzZXIgSW50ZXJmYWNlDQo+ID4gPiArLSBSZXNl
dA0KPiA+ID4gKw0KPiA+ID4gK0ludHJvZHVjdGlvbg0KPiA+ID4gKz09PT09PT09PT09PQ0KPiA+
ID4gKw0KPiA+ID4gK1RoZSBJbnRlbChyKSBEeW5hbWljIExvYWQgQmFsYW5jZXIgKEludGVsKHIp
IERMQikgaXMgYSBQQ0llIGRldmljZSB0aGF0DQo+ID4gPiArcHJvdmlkZXMgbG9hZC1iYWxhbmNl
ZCwgcHJpb3JpdGl6ZWQgc2NoZWR1bGluZyBvZiBjb3JlLXRvLWNvcmUNCj4gY29tbXVuaWNhdGlv
bi4NCj4gPiA+ICsNCj4gPiA+ICtJbnRlbCBETEIgaXMgYW4gYWNjZWxlcmF0b3IgZm9yIHRoZSBl
dmVudC1kcml2ZW4gcHJvZ3JhbW1pbmcgbW9kZWwgb2YNCj4gPiA+ICtEUERLJ3MgRXZlbnQgRGV2
aWNlIExpYnJhcnlbMl0uIFRoZSBsaWJyYXJ5IGlzIHVzZWQgaW4gcGFja2V0IHByb2Nlc3NpbmcN
Cj4gPiA+ICtwaXBlbGluZXMgdGhhdCBhcnJhbmdlIGZvciBtdWx0aS1jb3JlIHNjYWxhYmlsaXR5
LCBkeW5hbWljIGxvYWQtYmFsYW5jaW5nLA0KPiBhbmQNCj4gPiA+ICt2YXJpZXR5IG9mIHBhY2tl
dCBkaXN0cmlidXRpb24gYW5kIHN5bmNocm9uaXphdGlvbiBzY2hlbWVzLg0KPiA+DQo+ID4gQXMg
dGhpcyBpcyBhIG5ldHdvcmtpbmcgcmVsYXRlZCB0aGluZywgSSB3b3VsZCBsaWtlIHlvdSB0byBn
ZXQgdGhlDQo+ID4gcHJvcGVyIHJldmlld3MvYWNrcyBmcm9tIHRoZSBuZXR3b3JraW5nIG1haW50
YWluZXJzIGJlZm9yZSBJIGNhbiB0YWtlDQo+ID4gdGhpcy4NCj4gPg0KPiA+IE9yLCBpZiB0aGV5
IHRoaW5rIGl0IGhhcyBub3RoaW5nIHRvIGRvIHdpdGggbmV0d29ya2luZywgdGhhdCdzIGZpbmUg
dG9vLA0KPiA+IGJ1dCBwbGVhc2UgZG8gbm90IHRyeSB0byByb3V0ZSBhcm91bmQgdGhlbS4NCj4g
DQo+IFRvIGJlIGNsZWFyLCBJIGRpZCBub3Qgc2Vuc2UgYW55IGF0dGVtcHQgdG8gcm91dGUgYXJv
dW5kIG5ldHdvcmtpbmcNCj4gcmV2aWV3IGFzIGl0IGFwcGVhcmVkIGdlbmVyaWNhbGx5IGNlbnRl
cmVkIGFyb3VuZCBoYXJkd2FyZSBhY2NlbGVyYXRlZA0KPiBJUEMuIEF0IHRoZSBzYW1lIHRpbWUg
SSBkb24ndCBrbm93IHdoYXQgSSBkb24ndCBrbm93IGFib3V0IGhvdyB0aGlzDQo+IG1pZ2h0IGlu
dGVyYWN0IHdpdGggbmV0d29ya2luZyBpbml0aWF0aXZlcyBzbyB0aGUgcmV2aWV3IHRyaXAgc2Vl
bXMNCj4gcmVhc29uYWJsZSB0byBtZS4NCg0KSGkgR3JlZywNCg0KV2hpbGUgd2FpdGluZyBmb3Ig
dGhlIGZlZWRiYWNrIGZyb20gdGhlIG5ldHdvcmtpbmcgbWFpbnRhaW5lcnMsIEkgYW0NCndvbmRl
cmluZyBpZiB5b3UgaGF2ZSBhbnkgb3RoZXIgY29tbWVudHMvc3VnZ2VzdGlvbnMgdGhhdCBJICBz
aG91bGQgYWRkcmVzcw0KaW4gcGFyYWxsZWwuDQoNClRoYW5rcw0KTWlrZQ0K
