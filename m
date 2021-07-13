Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75EE3C7954
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 00:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbhGMWDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 18:03:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:18806 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234947AbhGMWDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 18:03:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="274079159"
X-IronPort-AV: E=Sophos;i="5.84,237,1620716400"; 
   d="scan'208";a="274079159"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 15:00:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,237,1620716400"; 
   d="scan'208";a="427417024"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jul 2021 15:00:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 13 Jul 2021 15:00:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 13 Jul 2021 15:00:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 13 Jul 2021 15:00:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZpMy5cjex+hrB2qH6Bry82+20PQP5POacL1mBMBWO3i8haRboZM788CUAVGCIkVNbd7fHT0l+AZlyEkKVzRpfoHy3ePylQEcK8U6aZJOY+2KFq2wE9Cos6EaZ7bBzojTf0ELmZzCKhOU83LZD1DDcOofNPjeoY1BfVrhTd7hXL8ZtfbJeBNPtVC1knCjpRQgndc4fiRpM6VfDhWhQbu1n4r0faeiBrX/+JBP5Z0gD66tNrFFkC0kiszUrURbGXU6VUj4cBoVu6+lKoATuzhgwCcFNkgenSh1ixtIK5lZaQ4BoFGPuSZjeYXpKjcZzvkL3wUCUZxrLBEbTfeUGmEWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9ttWTpVavdq7XBXMhfADP0r0nA1dIm9eMezpWyKMCI=;
 b=iSGC2zEKAMVCLk8Q4czIgrbM61kTF8uxkdqDKOd1n3H7nOwJk/SKZtJdsnX5kpUulSzPR0QoKQuVly/tcRGydUfzD2RKrK64qpdSC1dVCg523J7UcuQGwmvo3fvjPohEeLBlAsAkGyvz2jDWgnQjXftod0EIMU8M8yQKBBsKjQ4x3ZqmLRgMk61ZOhO/WygBcfi6rbJDsojrlDfNT4J/7+WYtjjDi5hvgvKBTQcYJA6lR4AIP6ZsR7JpTPWvndNvhg1Hxnd+BIcrei9kizJYu10UL1UoEWKPo4EPPIwZKgjj7kkVmtr8fTPa8QiKx7l8j0uHWTDfoGXyj84+5Ecsqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9ttWTpVavdq7XBXMhfADP0r0nA1dIm9eMezpWyKMCI=;
 b=p8lQwS7Nv/oZWpiQOoqNU5587EMZ5OEHImFbZ10f/AxDgBVVYZMLJdZkYB/Ebxe2HhBv49ffpt6ld7rsvn2PR82RtUud/qpfFOagsqeNemY8sFr3P1QO4y0QRjSiKQG5X3t5F6zY5VwLhlX5yKhNMcofT2Jq5VGiJwt5DTZAs6c=
Received: from DM6PR11MB3963.namprd11.prod.outlook.com (2603:10b6:5:19b::16)
 by DM6PR11MB3451.namprd11.prod.outlook.com (2603:10b6:5:5b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.25; Tue, 13 Jul
 2021 22:00:45 +0000
Received: from DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::d461:9c2:3f30:92d2]) by DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::d461:9c2:3f30:92d2%5]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 22:00:45 +0000
From:   "Mani, Rajmohan" <rajmohan.mani@intel.com>
To:     Evan Green <evgreen@chromium.org>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Fine, Gil" <gil.fine@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Prashant Malani <pmalani@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: thunderbolt: Warning and 20 second delay in S4
Thread-Topic: thunderbolt: Warning and 20 second delay in S4
Thread-Index: AQHXdQnwQF82AvtSx0ad+NNohaNbaas7wTOAgARE8QCAAAaEwIABWsaAgAAPoFA=
Date:   Tue, 13 Jul 2021 22:00:45 +0000
Message-ID: <DM6PR11MB3963600521EF82346CB7F5D5F6149@DM6PR11MB3963.namprd11.prod.outlook.com>
References: <CAE=gft50j2D_UmNNVOj-h6Hyi5ctMztAVDBP442SPinmCwcnpw@mail.gmail.com>
 <YOk/dzmF9sRg4uBn@kroah.com>
 <CAE=gft6pax+OB-TDDUEUabmc8p3x-p7CC-9ihNbjRKq0MgdisA@mail.gmail.com>
 <DM6PR11MB39639EB194DF47AE6D7F77ECF6149@DM6PR11MB3963.namprd11.prod.outlook.com>
 <CAE=gft4prWe-oD-042GT2F4zHiGBsNRH9pH040O9hipF9D5EfA@mail.gmail.com>
In-Reply-To: <CAE=gft4prWe-oD-042GT2F4zHiGBsNRH9pH040O9hipF9D5EfA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fbde01d-1fbd-4d9f-7245-08d94649aa3d
x-ms-traffictypediagnostic: DM6PR11MB3451:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB345117BED873AC97850A8E31F6149@DM6PR11MB3451.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WgzuLdICw3OJgQf7+ZTAdi6gItxxqZ26AP1+FRvyr3W8Gd930nMK9V5PIRmiz90M48vJccIwSK3Vt8ni2RZuPrstwzHiwGzjKceVGcSg7t/nVhU4R4mxF2qAhcuku8Kn+qaZulHpOz5tm+15TvOupPK3iWS3WJGBiFaWyYdWky6oy/r5E5nhgkrcc0XEtXk/a/r6DHqUIWiOSMV6i9YnzRJlEhhrDXOSYItaSQjj0Dpfkwn6a0VYc3yRkYw6zFYoHeGFWqtouLAF5n5BV3L3gFzACMfFfvA4xCACGoBAJoeDz1bD0Q5LX5Yba3HX2RpWkh0o3vyz6W2/9IxxWihL8qgucMLXK6KMExwHDNwCyfXByGLkrm2tbHf/HT/6z6YC9109nXFKIf68n/KQcA4HYQUvFF9iOrqMnq3c+mDFPFsH7asPnNDF573S1M836GfimeSO4zMBJC6/OJGT6NEuA+aR0eYGaOTpZi7+RGA3DVqSunbCE/DRUPhEW1jUDmx0qLINBf7uqGltdTUw8fSk6/xGvlheS/TzwrHWfjvD2kZX/BFtISYbObbd2Zqleii/FGUUlbT+Sl9Ql36DvxahuG7cIVsqaT9DlrSgEcrVv9PgjcLcVpF6NOn89tkp5rPmTh4hoTB9khWt3EgEqmRcKqos2+LU2AKoRJTbo0vpaS8N+L92H55I/VJZaV7W68ZtNoGeQa7/FGOyftsUeXnxgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(478600001)(33656002)(122000001)(5660300002)(38100700002)(83380400001)(52536014)(186003)(7696005)(9686003)(55016002)(8936002)(86362001)(6916009)(4326008)(8676002)(66476007)(66556008)(2906002)(66946007)(6506007)(64756008)(76116006)(53546011)(316002)(66446008)(71200400001)(54906003)(38070700003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFY4aXF2c0t5b0JhZWFHMlAzRGhKZXJkTTBSd2xzdDZpa3dCUm43MEY1VVhW?=
 =?utf-8?B?ZW1NZmpQejQxM0lueEhwSnd6bVJocGFlM0lZanJDSFZyMitMcWFLYzVVUUNr?=
 =?utf-8?B?Z2JDZ1RvQlZXTlNKOGZ0b05CNHJrbXZUOHBTTEMydUYyNG5hOSt6K1k0bWU3?=
 =?utf-8?B?THpFMVVCSHZSSkN5M2pyeU9TdlZQajQ0RHhuNXBmcGlZV3RCZEx1d2NZM01Y?=
 =?utf-8?B?K3pvZ3ptaGVYTmFyOW8ySGhCYTNZNTJMQVg1Q2d6R21kZUt5a3ZnSzJ5OXJz?=
 =?utf-8?B?RjdOZmFZY3VjbzErNHdZQnNZeG4zR3k2TnpFN2tsWjNPOTJxbnFsaDNyVlZu?=
 =?utf-8?B?YUorVk4xeVQ1UERtMVBHeTRqN250SU8yWUU3MGJUMW11Vk1kWHJrQmg3elZG?=
 =?utf-8?B?bzBkdTVXaUx2V2tGV0RTcHhqSmFaR0JrQWFwOVN1aENqdDRxU2J1UHZUZ2E4?=
 =?utf-8?B?cDRBVkRNVjQ1Qy9JMHhIOHNEdDJMY2svVlpTVHFRVEJnNjN0blh4WjZCdGVL?=
 =?utf-8?B?NTFQbW52cUt5UmVDRUltVlZrbXNFaFhSelhMUXBOQk04aFhPeDltbmJheVFk?=
 =?utf-8?B?MlBYQWxDUWhSaUNkWmszVXVlSUI5cmVpbUtzQ1cvTmZTU3dXOTNEY2xFYjJr?=
 =?utf-8?B?dlBFSGpZR3FDY1RYeFBkNXFDaFJ1TktBcEp2aTJmZzZDTk5sc2F5bkVwYXNG?=
 =?utf-8?B?Y2V2bWxEZDYrcjduR2N2M1JrMXl4T0E3QjVXV2hSVkNEaWp1bEZoT3VyZzhI?=
 =?utf-8?B?Uld6SmtrV1BsdzF1Vld2ZnIyZWFxVFp5MDRyT296WWk1WGRmRTdTMTRUZ3RM?=
 =?utf-8?B?OGcySzdmamtDVEo1TEFDWHZ1MDlZSENneTRkMkRVTy90c3ZTVlM2eFRYMGhP?=
 =?utf-8?B?T3UreW1nMElodGdVd2VLbi9lZDZUc2J0Y0Q2ZlhkQU1LSjJYRk8rZGNpUDBH?=
 =?utf-8?B?Si92Zm1kZm5tL01DWGtpdXV6VC9IeXFWemtLK2tlNGtmVHR0dDVpYUxxM3Bv?=
 =?utf-8?B?ODBzK2JRTkU0MkxnSTJVUFh6NFBRSk9CV0Y5UnRMajJabzdmZEQ2Q1Y2dVJ6?=
 =?utf-8?B?L2tHTW12NFRQM3ROOFN1TzkyWSswNjArNEh3STJGV0JPVmR5QmdVY3JOQU45?=
 =?utf-8?B?Ynhad055V3d4eUJDMFNxL3g1cTZXUjhnM3ZaZVJCQ24vRlpwVFVCRHE5c3Jp?=
 =?utf-8?B?cnRwZDJFT3NhdUU0Yi9WVVpMRXozaENockFxMGhuMTZGY1p5ZkNvOHFSMU5w?=
 =?utf-8?B?Yy9aZFN5dUtUZnl4LzI0ZW9yaXZNNEVKa0NLdWR5ek1pSU5mSUllcHB1NFpN?=
 =?utf-8?B?dlJPd3NQWlVhdDNHMTFTalNOTW1KVWYxbUlNT3l0OExmQ1ZydlArZk9SVjNi?=
 =?utf-8?B?b1haWStlR0FabzRuVW55bERtUlNpRXcxT055cEc4Y3A1VEMyU3RrcnpGKytt?=
 =?utf-8?B?MVp4aHNLR0NHUDZWc1NvOUg0dFJjSmo1RlBCUnJGZklubVplclRSN0RZT2x4?=
 =?utf-8?B?UWxTU0tGYXJFWEtrQkd4RjgxRmhla1hPalJjNUhkZytBalU0aE10N1NFZ2gz?=
 =?utf-8?B?a0NQZWt4bXlkNWI2UGY2azFIRkdva3UyRXdVUVN5OU5PN3hjSjFER2oxYk5x?=
 =?utf-8?B?a3N1aDRzVzdDZFB4Q3JjY1FGM2wvMGVMUXV4TG1RMjJ1TjhaOWFQSmJSMkNa?=
 =?utf-8?B?a1hBNTZrN0NyckVBaEwvVXFBNEgyVXQ2Rml5OUN4bldUVWJpOW5RY01qS0p3?=
 =?utf-8?B?ZXY2QjFSVGpwcmR0ckJ3SjJRSmZkdWhzR1VURk9BNTFBK0FLb1lJektQSHo5?=
 =?utf-8?B?d1JRUDdoZUJDNGpndkdqNVM2OGNuVStDbmJNWkNxdVFueDdsNXoweERmb05O?=
 =?utf-8?Q?fiH0tyK6jU5lp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbde01d-1fbd-4d9f-7245-08d94649aa3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 22:00:45.1636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dz3BkCy9RqYu0FAl66FSnhIsRxbsVRDyyy5bj6BqelpEJ/eoImKFX+bkfp1o8HR0pQfnR0Gkc0oqDiXUSBIehg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3451
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRXZhbiwNCg0KPiBTdWJqZWN0OiBSZTogdGh1bmRlcmJvbHQ6IFdhcm5pbmcgYW5kIDIwIHNl
Y29uZCBkZWxheSBpbiBTNA0KPiANCj4gSGkgUmFqLA0KPiBTdXJlLiBJJ3ZlIGdvdCBhIFRHTCBj
aHJvbWVib29rIHdpdGggbXkgb3duIGtlcm5lbC4gVGhlIGNocm9tZWJvb2sgaGFzDQo+IG5vdGhp
bmcgYnV0IGEgc2Vydm8gdjQgcGx1Z2dlZCBpbnRvIGl0IHZpYSB0eXBlLUMuDQo+IA0KPiBJIGJ1
aWx0IHRoZSBrZXJuZWwgYnkgY2hlY2tpbmcgb3V0IG5leHQtMjAyMTA3MDkgZnJvbSBsaW51eC1u
ZXh0IGluIHRoZSB2NS40DQo+IENocm9tZU9TIGNocm9vdCBkaXJlY3RvcnksIHRoZW4gZG9pbmcg
ImdpdCBjaGVja291dCBtL21haW4gLS0gY2hyb21lb3MiLCBpbg0KPiBvcmRlciB0byBnZXQgdGhl
IGNvbmZpZ3MuIE15IGNocm9tZW9zLTUuNCAod2hlcmUgSSBwdWxsZWQgdGhlIGNvbmZpZ3MgZnJv
bSkNCj4gaGFwcGVuZWQgdG8gYmUgb24gMDQ2ODZjMzI3MTYxNTggVVBTVFJFQU06DQo+IEFTb0M6
IHJ0NTY4Mi1zZHc6IHVzZSBmaXJzdF9od19pbml0IGZsYWcgb24gcmVzdW1lLCB0aG91Z2ggSSBk
b24ndCB0aGluayBpdA0KPiBtYXR0ZXJzLg0KPiANCj4gRnJvbSB0aGVyZSwgbXkgYnVpbGQgbGlu
ZSBpczoNCj4gVVNFPSJrZ2RiIHBjc2VyaWFsIHZ0Y29uc29sZSAiIGVtZXJnZS12b2x0ZWVyIGNo
cm9tZW9zLWtlcm5lbC01XzQNCj4gDQo+IE15IGNvbW1hbmRsaW5lIGhhcyAiZWFybHlwcmludGs9
dHR5UzAsMTE1MjAwbjggY29uc29sZT10dHlTMCwxMTUyMDBuOCINCj4gc28gSSBnZXQgc3BldyBv
dXQgb2YgdGhlIHNlcmlhbCBwb3J0LCBidXQgb3RoZXJ3aXNlIGl0IHNob3VsZCBiZSBzdGFuZGFy
ZC4gSSdtDQo+IGFsc28gdHJhY2tpbmcgdGhpcyBpbiBiLzE5MjU3NTcwMi4NCj4gDQoNCnRiX2Nm
Z19yZWFkX3JhdygpIGFuZCB0Yl9jZmdfd3JpdGVfcmF3KCkgaW1wbGVtZW50YXRpb24gbWFrZXMg
dXNlIG9mDQpUQl9DVExfUkVUUklFUyAoNCkgcmV0cmllcyB3aXRoIGEgdGltZW91dCBvZiBUQl9D
RkdfREVGQVVMVF9USU1FT1VUDQooNSBzZWNvbmRzKSBmb3IgdGhlIGNvbnRyb2wgcmVhZC93cml0
ZSBvcGVyYXRpb25zLg0KDQpQZXIgdGhlIGxhdGVzdCBVU0I0IHNwZWMsIGl0IGlzIHJlY29tbWVu
ZGVkIHRvIGhhdmUgMTAgKy8tIDEgbXMgdGltZW91dA0KdmFsdWUgZm9yIGNvbnRyb2wgcGFja2V0
cyB3aXRoaW4gZG9tYWluIGFuZCAxIHNlY29uZCBmb3IgaW50ZXItZG9tYWluLg0KDQpZb3UgY2Fu
IHRyeSBjaGFuZ2luZyB0aGUgVEJfQ0ZHX0RFRkFVTFRfVElNRU9VVCB2YWx1ZSB0byAxMDBtcyBh
bmQNCnNlZSBpZiA0MDBtcyBpcyBtYW5hZ2VhYmxlIGFuZCB5b3UgY2FuIGdldCBieSB3aXRoIGl0
Lg0KDQpNaWthIHdpbGwgYmUgYmFjayBieSB0aGUgZW5kIG9mIG5leHQgd2Vlay4gSSB3aWxsIGNo
ZWNrIHdpdGggTWlrYSBhbmQgcmVzdA0Kb2YgdGhlIHRlYW0sIHRvIGFycml2ZSBhdCB0aGUgaWRl
YWwgdmFsdWVzIGFuZCBwb3N0IGEgcGF0Y2guDQoNCj4gLUV2YW4NCj4gDQo+IE9uIE1vbiwgSnVs
IDEyLCAyMDIxIGF0IDU6MTYgUE0gTWFuaSwgUmFqbW9oYW4NCj4gPHJham1vaGFuLm1hbmlAaW50
ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhpIEV2YW4sDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBFdmFuIEdyZWVuIDxldmdyZWVuQGNocm9taXVt
Lm9yZz4NCj4gPiA+IFNlbnQ6IE1vbmRheSwgSnVseSAxMiwgMjAyMSA0OjQ2IFBNDQo+ID4gPiBU
bzogR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+ID4gPiBDYzogTWlrYSBX
ZXN0ZXJiZXJnIDxtaWthLndlc3RlcmJlcmdAbGludXguaW50ZWwuY29tPjsgRmluZSwgR2lsDQo+
ID4gPiA8Z2lsLmZpbmVAaW50ZWwuY29tPjsgTWFuaSwgUmFqbW9oYW4gPHJham1vaGFuLm1hbmlA
aW50ZWwuY29tPjsNCj4gPiA+IGxpbnV4LSB1c2JAdmdlci5rZXJuZWwub3JnOyBQcmFzaGFudCBN
YWxhbmkgPHBtYWxhbmlAZ29vZ2xlLmNvbT47DQo+ID4gPiBMS01MIDxsaW51eC0ga2VybmVsQHZn
ZXIua2VybmVsLm9yZz4NCj4gPiA+IFN1YmplY3Q6IFJlOiB0aHVuZGVyYm9sdDogV2FybmluZyBh
bmQgMjAgc2Vjb25kIGRlbGF5IGluIFM0DQo+ID4gPg0KPiA+ID4gT24gRnJpLCBKdWwgOSwgMjAy
MSBhdCAxMTozNCBQTSBHcmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gd3Jv
dGU6DQo+ID4gPiA+DQo+ID4gPiA+IE9uIEZyaSwgSnVsIDA5LCAyMDIxIGF0IDAyOjMxOjM1UE0g
LTA3MDAsIEV2YW4gR3JlZW4gd3JvdGU6DQo+ID4gPiA+ID4gSGkgTWlrYSBldCBhbCwNCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IEknbSBleHBlcmltZW50aW5nIHdpdGggc3VzcGVuZGluZyB0byBkaXNr
IChoaWJlcm5hdGUpIG9uIGENCj4gPiA+ID4gPiBUaWdlcmxha2UgQ2hyb21lYm9vayBydW5uaW5n
IHRoZSBjaHJvbWVvcy01LjQga2VybmVsLiBJIGRvbid0DQo+ID4gPiA+ID4gaGF2ZSBhbnkgVVNC
NCBwZXJpcGhlcmFscyBwbHVnZ2VkIGluLiBJJ20gZ2V0dGluZyB0aGlzIHdhcm5pbmcsDQo+ID4g
PiA+ID4gYWxvbmcgd2l0aCBhIDIwIHNlY29uZCBzdGFsbCwgYm90aCB3aGVuIGdvaW5nIGRvd24g
Zm9yIGhpYmVybmF0ZSBhbmQNCj4gY29taW5nIGJhY2sgdXAuDQo+ID4gPiA+DQo+ID4gPiA+IDUu
NCBpcyBwcmV0dHkgb2xkLCBlc3BlY2lhbGx5IGZvciB0aHVuZGVyYm9sdCBpc3N1ZXMsIGNhbiB5
b3UgdHJ5DQo+ID4gPiA+IDUuMTMgcGxlYXNlPw0KPiA+ID4NCj4gPiA+IEdvb2QgaWRlYS4gT24g
NS4xMy4wLW5leHQtMjAyMTA3MDksIEkgc2VlIHRoZSB3YXJuaW5nIGFuZCBkZWxheSBldmVuDQo+
ID4gPiBhdCBib290IHdoZW4gcnVudGltZSBwbSBraWNrcyBpbi4gVGhpcyBzaG91bGQgbWFrZSBm
b3IgYW4gZWFzaWVyIHJlcHJvIGF0DQo+IGxlYXN0Og0KPiA+ID4NCj4gPiA+IFsgICAxOC44MzIw
MTZdIHRodW5kZXJib2x0IDAwMDA6MDA6MGQuMjogMDogdGltZW91dCByZWFkaW5nIGNvbmZpZw0K
PiA+ID4gc3BhY2UgMiBmcm9tIDB4Ng0KPiA+ID4gWyAgIDE4Ljg0MDMwOV0gLS0tLS0tLS0tLS0t
WyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQo+ID4gPiBbICAgMTguODQ1NDY2XSB0aHVuZGVyYm9s
dCAwMDAwOjAwOjBkLjI6IGludGVycnVwdCBmb3IgUlggcmluZyAwIGlzDQo+ID4gPiBhbHJlYWR5
IGRpc2FibGVkDQo+ID4gPiBbICAgMTguODUzODM2XSBXQVJOSU5HOiBDUFU6IDAgUElEOiA1IGF0
IGRyaXZlcnMvdGh1bmRlcmJvbHQvbmhpLmM6MTAzDQo+ID4gPiByaW5nX2ludGVycnVwdF9hY3Rp
dmUrMHgxYjcvMHgxZGENCj4gPiA+IC4uLg0KPiA+ID4gWyAgIDE4Ljk3NzczNl0gQ1BVOiAwIFBJ
RDogNSBDb21tOiBrd29ya2VyLzA6MCBUYWludGVkOiBHICAgICBVDQo+ID4gPiAgICAgNS4xMy4w
LW5leHQtMjAyMTA3MDkgIzE4DQo+ID4gPiBbICAgMTguOTk2ODA0XSBXb3JrcXVldWU6IHBtIHBt
X3J1bnRpbWVfd29yaw0KPiA+ID4gWyAgIDE5LjAwMTI4NV0gUklQOiAwMDEwOnJpbmdfaW50ZXJy
dXB0X2FjdGl2ZSsweDFiNy8weDFkYQ0KPiA+ID4gLi4uDQo+ID4gPiBbICAgMTkuMTAwMzAyXSBD
YWxsIFRyYWNlOg0KPiA+ID4gWyAgIDE5LjEwMzAzMV0gIHRiX3Jpbmdfc3RvcCsweDlkLzB4MTdk
DQo+ID4gPiBbICAgMTkuMTA3MDIyXSAgdGJfY3RsX3N0b3ArMHgzMy8weGEwDQo+ID4gPiBbICAg
MTkuMTEwODIyXSAgdGJfZG9tYWluX3J1bnRpbWVfc3VzcGVuZCsweDM1LzB4M2ENCj4gPiA+IFsg
ICAxOS4xMTU5NzldICBuaGlfcnVudGltZV9zdXNwZW5kKzB4MWYvMHg0Yw0KPiA+ID4gWyAgIDE5
LjEyMDU1N10gIHBjaV9wbV9ydW50aW1lX3N1c3BlbmQrMHg1YS8weDE3Mw0KPiA+ID4gWyAgIDE5
LjEyNTUzM10gID8gcGNpX3BtX3Jlc3RvcmVfbm9pcnErMHg3My8weDczDQo+ID4gPiBbICAgMTku
MTMwNDExXSAgX19ycG1fY2FsbGJhY2srMHg4YS8weDEwZA0KPiA+ID4gWyAgIDE5LjEzNDU5NV0g
IHJwbV9jYWxsYmFjaysweDIyLzB4NzQNCj4gPiA+IFsgICAxOS4xMzg0ODldICA/IHBjaV9wbV9y
ZXN0b3JlX25vaXJxKzB4NzMvMHg3Mw0KPiA+ID4gWyAgIDE5LjE0MzM1NV0gIHJwbV9zdXNwZW5k
KzB4MjFlLzB4NTE0DQo+ID4gPiBbICAgMTkuMTQ3MzU1XSAgcG1fcnVudGltZV93b3JrKzB4OGEv
MHhhNQ0KPiA+ID4gWyAgIDE5LjE1MTU1NF0gIHByb2Nlc3Nfb25lX3dvcmsrMHgxYjcvMHgzNjgN
Cj4gPiA+IFsgICAxOS4xNTYwMjddICB3b3JrZXJfdGhyZWFkKzB4MjEzLzB4MzcyDQo+ID4gPiBb
ICAgMTkuMTYwMjE3XSAga3RocmVhZCsweDE0Ny8weDE1Zg0KPiA+ID4gWyAgIDE5LjE2MzgyN10g
ID8gcHJfY29udF93b3JrKzB4NTgvMHg1OA0KPiA+ID4gWyAgIDE5LjE2NzkyOF0gID8ga3RocmVh
ZF9ibGtjZysweDMxLzB4MzENCj4gPiA+IFsgICAxOS4xNzIxMTNdICByZXRfZnJvbV9mb3JrKzB4
MWYvMHgzMA0KPiA+ID4gWyAgIDE5LjE3NjEwNV0gLS0tWyBlbmQgdHJhY2UgNDM4YjdmMjBmNmI0
MDQ5ZCBdLS0tDQo+ID4NCj4gPiBJIHVzZWQgdG8gc2VlIHRoZXNlIHRpbWVvdXQgZXJyb3JzLCB3
aGVuIHRoZXJlIHdhcyBhIGNvbnRyb2wNCj4gPiByZWFkL3dyaXRlIGlzc3VlZCB0byB0aGUgdGh1
bmRlcmJvbHQvdXNiNCBkZXZpY2UsIGFmdGVyIHRoZQ0KPiA+IHRodW5kZXJib2x0IGRyaXZlciBp
cyBzdXNwZW5kZWQuDQo+ID4gQ2FuIHlvdSBzaGFyZSB0aGUgc3RlcHMgdG8gcmVwcm9kdWNlIHRo
aXMgUzQgaXNzdWUgaW4gYSBDaHJvbWUgZGV2aWNlPw0KPiA+DQo+ID4gVGhhbmtzDQo+ID4gUmFq
DQo=
