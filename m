Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBD63FED7E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344191AbhIBMIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:08:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:23276 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234239AbhIBMIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:08:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="241366980"
X-IronPort-AV: E=Sophos;i="5.84,372,1620716400"; 
   d="scan'208";a="241366980"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 05:07:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,372,1620716400"; 
   d="scan'208";a="476702759"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga008.jf.intel.com with ESMTP; 02 Sep 2021 05:07:05 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 2 Sep 2021 05:07:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 2 Sep 2021 05:07:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 2 Sep 2021 05:07:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMiBnDwZtrnuFpB2l7UzmgLPGld803batsnXm1nCsFJd0ioH+MyRJkSU3mVlSgjf61FLX5HZeYt117RAH5iHaoDMK1SLWE+/rJSj16bw/Skd4U5SR6AHl45V3wDy+GZRGOpCl6LcSsBR+p4o3//U8kELBfJ+omH55wWC0v1CfBOvtsV1ClcKzMAGoG2ay3mEU19DaXA/pD84CYPrlu97uu5GylQFOVu/NwrYNwnBmpNSsqG+M9raaPhWRWC0KkiD9gGZ9bqo5Up/oWZn9gpEvC1rsy0IMg/kz78S9rHv5E4BuYXZouGalZ4r60AjcC+vEzNLPN0ECtCXUckFIqsE6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=cZdBYSLLXRmMDcGFJ6ZxYm1B2o2A+XtS4npwBGhoQPs=;
 b=QcT3RXCu4JzQ84s2eAQG+X2J8d6fAwd41RIWMHSFR3qgiGJ8XBRLpU5UbC1dTvhd36TnO1UXaxem+2ZKKYosVaItqGxv5qX6SZ9gehwaC5JFhlB0Yc2Kb2sRwroCdBMpjJGNnQkwT2SGm+qi3fW3qycTXI8hgVWsmPSqrwUYbXR7nBCh+A06OtLV6IAOZ1mCN3Q4GVQzmeA9al6hoXcMfWHBQ/s8KavWi9Wpy38fqLnAyDYWdiCoSWAvw1opcWVyuZpP50AmEgPpPaoqZjwT+pCHglN83BxaIO2E5WmYMT2SASL4d5CY/eV7mMQQ/oD1DAq+oC8agitPsXrNL3jdQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZdBYSLLXRmMDcGFJ6ZxYm1B2o2A+XtS4npwBGhoQPs=;
 b=TwkjssmahcFi75xuD9eS/pJROaPmqaCbPSvR+S52i+Iq5owimuoACeeQA90mJepoVQY+mP3QIxJ+VUF4bQsbWNryvQCkzmAv26+TVHGS/UeX6wyzZrXxVv83wdlx+eXEfQRPr2w2s1ExIjSzQSdGrUPYMX/IvXbpDaVp3pXpzPg=
Received: from BYAPR11MB3752.namprd11.prod.outlook.com (2603:10b6:a03:fc::17)
 by BYAPR11MB2551.namprd11.prod.outlook.com (2603:10b6:a02:c5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Thu, 2 Sep
 2021 12:07:01 +0000
Received: from BYAPR11MB3752.namprd11.prod.outlook.com
 ([fe80::5ea:d57d:f0d:f89]) by BYAPR11MB3752.namprd11.prod.outlook.com
 ([fe80::5ea:d57d:f0d:f89%4]) with mapi id 15.20.4457.024; Thu, 2 Sep 2021
 12:07:01 +0000
From:   "K Naduvalath, Sumesh" <sumesh.k.naduvalath@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>
CC:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chinnu, Ganapathi" <ganapathi.chinnu@intel.com>,
        "Kumar, Nachiketa" <nachiketa.kumar@intel.com>
Subject: RE: [PATCH v3 1/1] ishtp: Add support for Intel ishtp eclite driver
Thread-Topic: [PATCH v3 1/1] ishtp: Add support for Intel ishtp eclite driver
Thread-Index: AQHXny7oRPI8ICt+IkyHqHHjn0+DTauPkawAgAESePA=
Date:   Thu, 2 Sep 2021 12:07:01 +0000
Message-ID: <BYAPR11MB3752899FD7FE512F9682E807A9CE9@BYAPR11MB3752.namprd11.prod.outlook.com>
References: <20210901124307.16886-1-sumesh.k.naduvalath@intel.com>
 <2e82bbb6-59c1-e713-f153-57ddd1e68163@infradead.org>
In-Reply-To: <2e82bbb6-59c1-e713-f153-57ddd1e68163@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1f0f7d6-7214-4b6e-c1b2-08d96e0a2c0f
x-ms-traffictypediagnostic: BYAPR11MB2551:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2551220591D4691EC3E91C64A9CE9@BYAPR11MB2551.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WayUJiKuPrmd/IRR98tWxREWvEREUS8ly1sj92B2PXQM76r9XUjpaoQx4Y0wx2fwmkh8tVWZcWDpeZNKnhiTJUdHx8bBblzws4VFkHVXy2L65tncAD+rHsN3vIA7bsp4oCqZfBp6HKJZYdCJiOxeXTmMpwC/k4R2zybVx/H9HF7H8oaGElInY6lPj7Ebrvd5i/+SvFHKIpxMU8d9heECcKnmknGfpkNXjlx/841o9x/yqhtOkc/bCjDidUGX2HBI5jZPLwqGO1gs4mtzPy1/pX09h9OYt/zxoLZ7g+n6T0KWVOPuKe5Da36ha5QiUs05qoBmDOLt/0124I7Mr87rh92IJCRainzILMj5kM99Pwyx5feYUmAc0norTRuF8Q8psVGiv13n/BbsAdzOtc3Oxc0si+G1EUgz0xSpd7cFzoK7sWErDyBxnU7uMJxmaYDlP+GLS643Li1kAbG2j7mgoqNRD9PcVE4krabDO4ThDeqeE8UxavNUHfJWdJfKiixfrBN/VjXBCV1elhO8R+bUNVQ/ftRxPiYRHSQQ/R3OFr+FKdAMc73eSoHUMP7LgixID+fqjkelXIgTeOqtxzU0JplRRfnwi7Y0DjP0gmgGQCZK8StCpZzTe/kOKF+A75k45gsAqfUSbe3O+gsAMpVC6KT8BdV64bSFQvmChJWLf8FzrAF52d1hoVnRCnVsCKOOP/QuNFZ+x7nELellArCEDbpXntaykYP8NVZn7jftfI0QdXyPDI7VNxY1f+Jf7PYDZ02AkOWNT2PISoTG/osQKoMdBBmPLmSyY/hfEF6qiQc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3752.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(71200400001)(66476007)(66946007)(66446008)(38100700002)(8936002)(110136005)(316002)(66556008)(8676002)(76116006)(54906003)(64756008)(7696005)(478600001)(5660300002)(55016002)(9686003)(86362001)(2906002)(53546011)(6506007)(55236004)(38070700005)(186003)(26005)(33656002)(122000001)(966005)(52536014)(83380400001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0tJUU9UM0JnNnFMUVRGZi9xWDBkbjZNWS9sdThRQ0dOcGIvaW1wZitVRGlz?=
 =?utf-8?B?OWkweXYwS01udnFwTlRjSlRCMi8wUk51bFJCb1k2WW50YTVBUHVEZCtEQkdl?=
 =?utf-8?B?ZjI2SWVYczVGbTZIQUFaVTNqSi92SUY4c0lEZWpTRTMvSUFsdmpRaVN3Qndp?=
 =?utf-8?B?aUtoUkJzS015K2NRN3YvNlpZSUNTcldxaytHZUxMNnBuOGpybTdObXB3amsy?=
 =?utf-8?B?UkdsVVY2dzdpQzhtN05qRlFGdVdrU2NGQ09LRENCMC9nTS96eUlaVkpzSkhq?=
 =?utf-8?B?NEhPbDh1L01RVHlJb0dUVDRaTnhHV1JIVGZGTzNMVWhNN3NmTEFLVUtIQ0dG?=
 =?utf-8?B?d1JYZ3JXaUVPOGJNeVRxaVlyWG50Q2pDeVcrR1ZrMDIyd2JtT1ZxaDZCcnVu?=
 =?utf-8?B?WXNCWVREYWRxVUpjQUhCbitUSVIxUjk3WUlyTzdPaktzQ2R1eUNmQklaUElC?=
 =?utf-8?B?VnNVMlVVTEpLc2RpN0I2d0lYZ3hUYnVqWGRDM3BmbDV2UWlxWkpxNnlRcUxR?=
 =?utf-8?B?dmRYa3pSdkptc0pnMjZZVXZrR2FldWpzWHNPZVlCK1p0K3BscGgxS0w3Z3Jz?=
 =?utf-8?B?K09obWJoblRaUC95U3JlU3ZoODI5ZFFCU3ZvWUtCbTBlQVAvU2FyN2FQV0RY?=
 =?utf-8?B?ZXNvck4xRVZWMkJzWGdpdmRWNnN4RHVZaXVqMjlQb1diR0w4Y1ZkNlc1MFV3?=
 =?utf-8?B?YnEvRXVQR2tGYjY5d2N2ZnlISEszVC9VTkZFYmFaWUJCOGcreDhoMlc4dnNZ?=
 =?utf-8?B?eGlscmUyVzI2N0Qxd1lmdml0ZXByRmNKQlBEamJPcUxacitsU01kNVFFeUpi?=
 =?utf-8?B?a2Q4R3BpV2FodERiYlJZdlNQSFZ4T3JwWVAxQTIxRlRTcVlJK3JnNWdpTVI3?=
 =?utf-8?B?OFpCNm9ISFd6WVpyemdCdGV4dzMzU3lKR2pLcy9oZmdWYnBBSU5sMUJoOFQx?=
 =?utf-8?B?OWl5dHpQd21IeXllSnRsQ3pITG9rT2ErZ3luVUUveHNZN2Q3eEIrTldCaXp3?=
 =?utf-8?B?YURXZTFTa0FaZ1QxdDQwR1YyOEc4UEd4ZjdzYW1KR0NxV2lKTXBBcytSUWFh?=
 =?utf-8?B?Y1N2aUxIMHg3N3hxOE8vMGZyYkVSQlJ2L0d1Y3JuYm85b1Z3RDdKYjVodkxE?=
 =?utf-8?B?NldGdW5VVjA5TThjemFTS1F6T0Y0eEhram5oTkxnV1BnVEFWNFN3Z0tnRVJL?=
 =?utf-8?B?ZnVWWFhTUVp2UTRVK0llSWo0UlErVnRueXNQdFA5ZUhyMXhPdGlXMFFZODEv?=
 =?utf-8?B?S2RKU2xOWUo4ZkhyVVpSRklaS0syR2dBcEdXdmVCNG1UMXpXMm9BVWYxSVcx?=
 =?utf-8?B?cERwRWtBTkNYWFMvWEI2NzhqakMrVnBHYnkyUzRyR3krQnh4b3FYNXFodE8y?=
 =?utf-8?B?SlpKTTFZd0YvZnBUanBhaXNnZi9CZHNRVXNLd0lJWHNjdlFRd2p5ckVFdDZI?=
 =?utf-8?B?Yk83cy9JRFY4Y3ZCZVkzN3hhc3NmRFBHQzMwWUE0Zi8wV1FNTnhKNmYvdzEr?=
 =?utf-8?B?R0dldzNFSktIdnludDdFTnBXY0dlQ21CY08ybW4xeGt1ei9XcXY2eFY0OCtG?=
 =?utf-8?B?cFEwckFiaDY2d1lPRUxVbFJjTUU0Qk5WZU9nbzJ6OGJnWk5yVlcrTmowRlNa?=
 =?utf-8?B?emdoZWZFMnl3RENpTXBUNHJGY293dkxwa0JoSzFwTW5BVDVkcWhubHNDUHRq?=
 =?utf-8?B?UU9WclhwbCtVNGtxYnZLVm51bVRoYUhyYm85ZjNHU3F3ZlpBckR6bElkeUpB?=
 =?utf-8?Q?VwSUbmoD+WWJp74jwCORaXoOMZA/iWuSRnpdbp/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f0f7d6-7214-4b6e-c1b2-08d96e0a2c0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2021 12:07:01.5365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ctPQlt1q5rMP3QbzC8dVAfxQASU35Hh46QoNvodytyEmG52K1LBMkW1bJBhUf8KQKPdRee5e0XieAn/FH1hOKQ/CE6adY/voP1M2rnROWGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2551
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91IFJhbmR5IGZvciB0aGUgcmV2aWV3LiBQbGVhc2UgZmluZCBteSBjb21tZW50cyBp
bmxpbmUgLQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJhbmR5IER1
bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVy
IDIsIDIwMjEgMTowMiBBTQ0KPiBUbzogSyBOYWR1dmFsYXRoLCBTdW1lc2ggPHN1bWVzaC5rLm5h
ZHV2YWxhdGhAaW50ZWwuY29tPjsNCj4gaGRlZ29lZGVAcmVkaGF0LmNvbTsgbWdyb3NzQGxpbnV4
LmludGVsLmNvbTsNCj4gc3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20NCj4gQ2M6
IFBhbmRydXZhZGEsIFNyaW5pdmFzIDxzcmluaXZhcy5wYW5kcnV2YWRhQGludGVsLmNvbT47IHBs
YXRmb3JtLWRyaXZlci0NCj4geDg2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgQ2hpbm51LCBHYW5hcGF0aGkNCj4gPGdhbmFwYXRoaS5jaGlubnVAaW50ZWwu
Y29tPjsgS3VtYXIsIE5hY2hpa2V0YQ0KPiA8bmFjaGlrZXRhLmt1bWFyQGludGVsLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzFdIGlzaHRwOiBBZGQgc3VwcG9ydCBmb3IgSW50ZWwg
aXNodHAgZWNsaXRlIGRyaXZlcg0KPiANCj4gT24gOS8xLzIxIDU6NDMgQU0sIHN1bWVzaC5rLm5h
ZHV2YWxhdGhAaW50ZWwuY29tIHdyb3RlOg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRm
b3JtL3g4Ni9LY29uZmlnDQo+ID4gYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9LY29uZmlnIGluZGV4
IGQxMmRiNmMzMTZlYS4uOGEwOTQ1ZWQxMTgyDQo+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
cGxhdGZvcm0veDg2L0tjb25maWcNCj4gPiArKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9LY29u
ZmlnDQo+ID4gQEAgLTExNzYsNiArMTE3NiwyMiBAQCBjb25maWcgSU5URUxfQ0hURENfVElfUFdS
QlRODQo+ID4gICAJICBUbyBjb21waWxlIHRoaXMgZHJpdmVyIGFzIGEgbW9kdWxlLCBjaG9vc2Ug
TSBoZXJlOiB0aGUgbW9kdWxlDQo+ID4gICAJICB3aWxsIGJlIGNhbGxlZCBpbnRlbF9jaHRkY190
aV9wd3JidG4uDQo+ID4NCj4gPiArY29uZmlnIElOVEVMX0lTSFRQX0VDTElURQ0KPiA+ICsJdHJp
c3RhdGUgIkludGVsIElTSFRQIGVjbGl0ZSBjb250cm9sbGVyIg0KPiA+ICsJZGVwZW5kcyBvbiBJ
TlRFTF9JU0hfSElEDQo+ID4gKwlkZXBlbmRzIG9uIEFDUEkNCj4gPiArCWhlbHANCj4gPiArCSAg
VGhpcyBkcml2ZXIgaXMgZm9yIGFjY2Vzc2luZyB0aGUgUFNFIChQcm9ncmFtbWFibGUgU2Vydmlj
ZSBFbmdpbmUpLA0KPiA+ICsJICBhbiBFbWJlZGRlZCBDb250cm9sbGVyIGxpa2UgSVAsIHVzaW5n
IElTSFRQIChJbnRlZ3JhdGVkIFNlbnNvciBIdWINCj4gDQo+IFdoaWNoICJJUCIgaXMgdGhhdD8g
ICJhbiBFbWJlZGRlZCBDb250cm9sbGVyIGxpa2UgSVAiIGRvZXNuJ3QgbWFrZSBzZW5zZQ0KPiBJ
TU8uDQoNClRoaXMgaXMgSW50ZWwgRWxraGFydGxha2UncyBQU0UgSVAuIFRoaXMgSVAgaXMgYSBk
ZWRpY2F0ZWQgbG93IHBvd2VyIHJlYWwtdGltZSBBUk0NCmJhc2VkIG1pY3JvY29udHJvbGxlciB3
aXRoaW4gdGhlIFNvQy4gTW9yZSBpbmZvcm1hdGlvbiBoZXJlOg0KaHR0cHM6Ly93d3cuaW50ZWwu
aW4vY29udGVudC93d3cvaW4vZW4vcHJvZHVjdHMvcGxhdGZvcm1zL2RldGFpbHMvZWxraGFydC1s
YWtlLmh0bWwNCg0KRG8geW91IHN1Z2dlc3QgdG8gcmV3b3JkIGxpa2UgYmVsb3c/DQoNClRoaXMg
ZHJpdmVyIGlzIGZvciBhY2Nlc3NpbmcgdGhlIFBTRSAoUHJvZ3JhbW1hYmxlIFNlcnZpY2UgRW5n
aW5lKSAtIGFuIEVtYmVkZGVkIA0KQ29udHJvbGxlciBsaWtlIElQIC0gdXNpbmcgSVNIVFAuLi4N
Cg0KT3IgcmV3b3JkIGl0IHdpdGggbW9yZSBkZXRhaWxzPw0KDQo+IA0KPiANCj4gPiArCSAgVHJh
bnNwb3J0IFByb3RvY29sKSB0byBnZXQgYmF0dGVyeSwgdGhlcm1hbCBhbmQgVUNTSSAoVVNCIFR5
cGUtQw0KPiA+ICsgICAgICAgICAgQ29ubmVjdG9yIFN5c3RlbSBTb2Z0d2FyZSBJbnRlcmZhY2Up
IHJlbGF0ZWQgZGF0YSBmcm9tIHRoZQ0KPiBwbGF0Zm9ybS4NCj4gDQo+IEluZGVudCBhYm92ZSBs
aW5lIHdpdGggdGFiICsgMiBzcGFjZXMgaW5zdGVhZCBvZiBtYW55IHNwYWNlcy4NCj4gDQpTdXJl
LiBXaWxsIGZpeCBpbiBWNC4NCg0KPiA+ICsJICBVc2VycyB3aG8gZG9uJ3Qgd2FudCB0byB1c2Ug
ZGlzY3JldGUgRW1iZWRkZWQgQ29udHJvbGxlciBvbg0KPiBJbnRlbCdzDQo+ID4gKwkgIEVsa2hh
cnRsYWtlIHBsYXRmb3JtLCBjYW4gbGV2ZXJhZ2UgdGhpcyBpbnRlZ3JhdGVkIHNvbHV0aW9uIG9m
DQo+IA0KPiAJRHJvcCB0aGlzIGNvbW1hICAgICAgIF4NCj4gDQpTdXJlLiBJJ2xsIGZpeCBpdC4N
Cg0KPiA+ICsJICBFQ0xpdGUgd2hpY2ggaXMgcGFydCBvZiBQU0Ugc3Vic3lzdGVtLg0KPiA+ICsN
Cj4gPiArCSAgVG8gY29tcGlsZSB0aGlzIGRyaXZlciBhcyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVy
ZTogdGhlIG1vZHVsZQ0KPiA+ICsJICB3aWxsIGJlIGNhbGxlZCBpbnRlbF9pc2h0cF9lY2xpdGUN
Cj4gDQo+IEVuZCB0aGUgbGFzdCBzZW50ZW5jZSB3aXRoIGEgcGVyaW9kICgnLicpLg0KPiANCj4N
ClN1cmUuIEknbGwgZml4IGl0LCB0aGFua3MuDQogDQo+IHRoYW5rcy4NCj4gLS0NCj4gflJhbmR5
DQoNCg==
