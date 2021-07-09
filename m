Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD8F3C288C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 19:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhGIRnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 13:43:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:10659 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhGIRnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 13:43:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="209783469"
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="209783469"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2021 10:40:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="628918829"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 09 Jul 2021 10:40:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 9 Jul 2021 10:40:19 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 9 Jul 2021 10:40:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Fri, 9 Jul 2021 10:40:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Fri, 9 Jul 2021 10:40:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMDF4Ccs5iIsdx+RqP4wnAWM39soh/YDq3avgC4GbKswiW9cDayP3RMcNy4jMVfRs2ai8C1MZhWZlclB1KiE77KtBh6QJx+UYoF9xsYEZ1vuIcBFJyeTGDwlK+tDhg00sVl98gVPJopNMdv3gLZgChlyqpNsXkPoUnHfny9svi2r/er/PUuygJDu2v8Qte7h0wGhHVberX2vvTY0K0HyimGcv4JLj0VnE4dVOgAC53gH0sx0tD1rjVy17pCTd2Z4meqU6wftJAKPqBjSSNRc9LDkmwLhXUng6ScX1LYs4n8jr0fOzDfuW7LB2mIZj5tsM+UYG95LCbgh1Fj65Qu20g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iylrENm7kJPHKFvPzV+VHJiwJS4b5nbL1nCQuJ8hEuk=;
 b=OK3liabR3OLubr8pnMgldXICllTni4yk+ZAyR0pUXObt0hJsSWE4/BUH/FP9t8yS/SY6vGWa5y+KbzPljvCJ/SCPxGgDiVKZNaxnbZWIbONzixQp5zDaSJ84q2/Vm5ANW6yBeNY10Iq5bhfxKS4tTwcUsJXRwthMfT4VPjdy368IigwQGRK79nuM3eThD6V/Rk71x6o5XtZWSzghVQsOTdAb0M6ECcEVZU49hoYp/torNm+Q9anGr+PIizXkvoFHa0ZLIpxrCnMONIejLylujYaX2+4P2c1l+6xINiEUs6vXT4b7HJ9cgFkWaFA6pb1pGCMRJ/cLnfzkpZOnKJXsfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iylrENm7kJPHKFvPzV+VHJiwJS4b5nbL1nCQuJ8hEuk=;
 b=ScROZ1RGwgOo1p+f28VykMr8pMV+BXai7IDmu00AYYHVyoOKOwoRJCDM8FwlYjFaMasBh1wC6G9+r8LmERX5UFcnNsrFoVwY/xPbvQD8V2gY+uhgsj3iqRbakkNASq7p1DmNKrctWw0RWF5v1R2lZobGfZxDqkZKrla019r7VkY=
Received: from MW3PR11MB4523.namprd11.prod.outlook.com (2603:10b6:303:5b::16)
 by CO1PR11MB5105.namprd11.prod.outlook.com (2603:10b6:303:9f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Fri, 9 Jul
 2021 17:40:17 +0000
Received: from MW3PR11MB4523.namprd11.prod.outlook.com
 ([fe80::a87d:ca62:f143:7464]) by MW3PR11MB4523.namprd11.prod.outlook.com
 ([fe80::a87d:ca62:f143:7464%9]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 17:40:17 +0000
From:   "Kammela, Gayatri" <gayatri.kammela@intel.com>
To:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
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
Subject: RE: [PATCH v2 0/5] Add Alder Lake PCH-S support to PMC core driver
Thread-Topic: [PATCH v2 0/5] Add Alder Lake PCH-S support to PMC core driver
Thread-Index: AQHXc55r2hq0Skd3g0W+4r05nIJPbas5V1CAgAGUS+A=
Date:   Fri, 9 Jul 2021 17:40:17 +0000
Message-ID: <MW3PR11MB4523BCD490ABA17CE3B5FD94F2189@MW3PR11MB4523.namprd11.prod.outlook.com>
References: <cover.1625709047.git.gayatri.kammela@intel.com>
 <CAE2upjQK80HF+hADt+q9PQKpX6MntqQFQ+mcXRKkus1FvxvvRQ@mail.gmail.com>
In-Reply-To: <CAE2upjQK80HF+hADt+q9PQKpX6MntqQFQ+mcXRKkus1FvxvvRQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.100.41
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edbd9d3b-16ca-44ca-ebf3-08d943009d9e
x-ms-traffictypediagnostic: CO1PR11MB5105:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB510532DF7C237A57DC80F7F3F2189@CO1PR11MB5105.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:265;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ye8bEFbtwX4PH0nJUy/+nJPsG3yxFhEw/q98DZePDrWpa7fzEo9g5lfYLyuu+gnJI+PRMWo85HKNlzErDhn9mszSMFoFZ7Kw7xmULW/7x+KZTH4I2IjYglm2MkxQWCMRpBkzqiiq4Mr1sVj4cSYKD3ScT5tU9U/r5mqvnDvhPg1wnVKWCHj3GoJglwXyV1Tqho/Zx7xUVTuWPhwaNA2dmJbGSzkfoMgLYCbl4rAIpwxq7EpYXwW61RMFaIJGjSC7sa1TsNwK39l2dlDqrwf6xBoT07KClFU9hR//14Gaviz58nuKEVLG2lNSr6J/13K9go8wJObHWbAgD2tTPIu/3Xol8atpLuq4c39BBex7jT2xofqBwk9aGg0d1gq40R8Yp4/dLkQtw2H9b8V0xwCZzbqicHkGWT/xaDBINpPuajwN3yIRkKg+DuE0zeZfGOHwlbo724M1kwNhrVhXTftQyheHEgT869CcxK3ZMM9fUbQvr8oParznokO8JaYo9VqaKaSy75EOt1X6R+KEhJtTKHE+nBQsBaWGA3W4TPm7f56OVzqCgHfYSGieQ9bAcBW7Zl9/UE4CwmOqfUf+srdM6hZ+gDIKqkFc6mYzW75AeRRU3WZcYkBj/XRZhLEUicbDLbR8cVYblLiN1LBdQ3Q4qs+7RQIFqesWcDyH4E32zv053nndZGy/w3IHnISUelvwXq70mhCVB+D2Lmi/GHl3Jg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4523.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(366004)(396003)(376002)(52536014)(316002)(186003)(64756008)(8936002)(66476007)(66446008)(66556008)(5660300002)(4326008)(6916009)(2906002)(76116006)(66946007)(478600001)(54906003)(33656002)(55016002)(83380400001)(122000001)(38100700002)(26005)(53546011)(8676002)(6506007)(7696005)(9686003)(71200400001)(7416002)(86362001)(226253002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGdmR0pZR0E4UUh5bk5UMzNZcEF0UVRSLzJIb0kvcGkrd1JTRm82NDR6U2Mr?=
 =?utf-8?B?eFZCd3VnbFZhaXhLMEJKZHZBald1eHkvV2I2TWc2MldpdmdTSlZKc2NuSGVX?=
 =?utf-8?B?aE1CSStmS1A2YW1lSDFRZ0RDeDh3UXd4bmRDTTVrdHhHeXhFUE10Wi9Yd3lE?=
 =?utf-8?B?VTg2VHZhblF1N0hFbHlVdW5tcmNRSjl6czhvM2FQYnpLQWl6blRGZVpaZnEy?=
 =?utf-8?B?Ky9jaDRxMFVHa0N5ZzZnckRmUU9PbDJTQWN4cmk1d0pYME80VmlVY21jeEw0?=
 =?utf-8?B?U0FKMklSaUdJV3FGWnM0dFNTaUErYUFNU0JkRTFwQ2lTbkd6UEJxcjVNSUZh?=
 =?utf-8?B?R0Y0TzlxdTEzWWFXS1lMUFlCa3lGV2FXam5sZWN2cE5yWU95Njl4U1hIbG5S?=
 =?utf-8?B?TEppeW45UDBOemVta1dyeXVWeVJsYTdtSlNWS3c2QUE5eStJMDdRSGdybWxG?=
 =?utf-8?B?amxOeWQzWXdWV1pCZXJWek9JeUJHaUJqUnZYd0ZxSUMxN2ZnVDlPVFpRb09r?=
 =?utf-8?B?aGFaK3A0YTZtSGllZnlTSkRYK3ZrN3hqbzRKdEU3WGozYUR1UThQVzYwMHdz?=
 =?utf-8?B?a29rMXRJNkQyV1FnTi9OSFNhZHNrS09kbVcxSC9UYkFHaTlPOFUxcm9OeUMx?=
 =?utf-8?B?VXFRcWRXVmNuMEtwZHc1dGFFN1IyMGJWY0IvRTVnSUpWcUo0dytWRDFFOHp0?=
 =?utf-8?B?Q1N3U0h6eVlPNEhkNTVWUTArMlg0TlBvSllid2w0bXBMYTdBaHpMRzUrc0Q1?=
 =?utf-8?B?ZHF3ejFYNlBGdmdCK1VCbFdmUTFPMmxqRUFhNG8zZHY4akNObnFvUUJGZ2hH?=
 =?utf-8?B?Mm9SeG5wSDl0UExHNGdNV00wV1NadFRtR1JPUmI0d2dmV0Nwd251NkpYelVT?=
 =?utf-8?B?aDBVVEQ1eVNXeTFUc2NNTkVXZ1VwcDRwUlk4Y2U2SkJFYkIwR0ZIdm9waE82?=
 =?utf-8?B?RmVvRi8zN3F0bFVhVVFaQTVVb04yd0crOVFINDlFTzNoZHJORU1ZV3RrSE5D?=
 =?utf-8?B?aVkwMlE2VitWM3d6amdyOTVkMmU2Zmlob1lTNXBzeS8xUGpaTy9FbTBnZVkz?=
 =?utf-8?B?TGpVZDd4RWUweGE0bHBoUzh1ZDJ5dDhycHVqMk9EUDdrdW1qYU1CaE5NWFZU?=
 =?utf-8?B?ZklWMlM1WjFOOUl3bXgxZzBJeTZxU1YzYkNwWkdyNnZVQUxPVkw3QW5uTWcx?=
 =?utf-8?B?VDhSK1pCT0twR1BLMW1MMjNsNGdWMnd5RVcxZEFFbVVOaWJlRExWd2Znemh1?=
 =?utf-8?B?S21sN0MrOVRoMS80QmpKNmZwcTM3RC9EZEV5VlFxV2N3eGpEZVBwNEJHN1I5?=
 =?utf-8?B?L1lZMkpBbU9ONWxGSDJOM2gzbEpBenpvWkZpemRBY3hKTWYrY3R5TDNTNWt1?=
 =?utf-8?B?SVMzeWgvUlgwU2xQeHYrZjNZbHl3VTQxUUk2RGtqOXF2YUdPTDUxMndxNjRh?=
 =?utf-8?B?TnFaekRRN09TUkhZSUZPTWdVRXJZdytXQmhBU1l6WXpnbjFBZzN4eisyblFG?=
 =?utf-8?B?UlFBTjg2LzZFSVJobDJPeC92RDBzN085c1hiN0J0UU1OZ29OR2YwbWtpSUpm?=
 =?utf-8?B?Z2pYUDdvZDlnYVFpNHJZSU1Bby9jL2RuK0pNTFk2aHB4bmRNL09Td3BHOXJi?=
 =?utf-8?B?RzgxeVRqeXA4cVdGREsycmdHM0hnNS8yUGZQc2doalNWYlZtSzBmVmU2TkFx?=
 =?utf-8?B?MktwWkZtTGkzL2hWUXVEaXJ0Rmc1ZVNydHVRRnUrMldJcjBSV1NoK0FIbTQr?=
 =?utf-8?Q?YF4PeNcl48oNVdkvxE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4523.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edbd9d3b-16ca-44ca-ebf3-08d943009d9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 17:40:17.1452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /G8z+D9IouodE41otczh03WJKPoBybCP7kJj5BqNsYA7l/PkWm5tIlvOpnoAeG/yaZYQF2/DhNmlNP5FJtCT7t1TjZl0dMasDCYjAy+d/0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5105
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWpuZWVzaCBCaGFyZHdhaiA8
aXJlbmljLnJham5lZXNoQGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEp1bHkgOCwgMjAy
MSAxMDozMyBBTQ0KPiBUbzogS2FtbWVsYSwgR2F5YXRyaSA8Z2F5YXRyaS5rYW1tZWxhQGludGVs
LmNvbT4NCj4gQ2M6IHBsYXRmb3JtLWRyaXZlci14ODZAdmdlci5rZXJuZWwub3JnOyBtZ3Jvc3NA
bGludXguaW50ZWwuY29tOw0KPiBoZGVnb2VkZUByZWRoYXQuY29tOyBBbmR5IFNoZXZjaGVua28N
Cj4gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT47IHZpY2Ftby55YW5nQGNhbm9u
aWNhbC5jb207DQo+IFBhbmRydXZhZGEsIFNyaW5pdmFzIDxzcmluaXZhcy5wYW5kcnV2YWRhQGlu
dGVsLmNvbT47IEJveCwgRGF2aWQgRQ0KPiA8ZGF2aWQuZS5ib3hAaW50ZWwuY29tPjsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgTWFzaGlhaCwgVGFtYXINCj4gPHRhbWFyLm1hc2hpYWhA
aW50ZWwuY29tPjsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7DQo+IHJhamF0amFAZ29vZ2xl
LmNvbTsgU2h5YW0tc3VuZGFyLlMta0BhbWQuY29tOw0KPiBBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tOyBtbGltb25jaUBhbWQuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMC81XSBBZGQg
QWxkZXIgTGFrZSBQQ0gtUyBzdXBwb3J0IHRvIFBNQyBjb3JlIGRyaXZlcg0KPiANCj4gU2VyaWVz
IGxvb2tzIGdvb2QgdG8gbWUuDQo+IA0KPiBBY2tlZC1ieTogUmFqbmVlc2ggQmhhcmR3YWogPGly
ZW5pYy5yYWpuZWVzaEBnbWFpbC5jb20+DQpUaGFua3MgUmFqbmVlc2ghDQo+IA0KPiArIEFNRCBm
b2xrcw0KPiANCj4gSGkgQWxleCwgTWFyaW8gYW5kIFNoYXltIC0gUGVyaGFwcyBBTUQgUE1DIGZp
bGVzIHNob3VsZCBhbHNvIGZvbGxvdyB0aGUNCj4gc2ltaWxhciBjb252ZW50aW9uIGFuZCBpdCBj
b3VsZCBwcm9iYWJseSBldm9sdmUgaW4gZnV0dXJlIHdoZXJlIGJvdGggeDg2DQo+IGJhc2VkIFBN
QyBkcml2ZXJzIG1pZ2h0IHVzZSBzb21lIGNvbW1vbiBsaWJyYXJ5IGhlbHBlciBmdW5jdGlvbnMu
IFdoYXQNCj4gZG8geW91IHRoaW5rPw0KPiANCj4gDQo+IE9uIFdlZCwgSnVsIDcsIDIwMjEgYXQg
MTA6MTAgUE0gR2F5YXRyaSBLYW1tZWxhDQo+IDxnYXlhdHJpLmthbW1lbGFAaW50ZWwuY29tPiB3
cm90ZToNCj4gPg0KPiA+IEhpLA0KPiA+IFRoZSBwYXRjaCBzZXJpZXMgbW92ZSBpbnRlbF9wbWNf
Y29yZSogZmlsZXMgdG8gcG1jIHN1YmZvbGRlciBhcyB3ZWxsDQo+ID4gYXMgYWRkIEFsZGVyIExh
a2UgUENILVMgc3VwcG9ydCB0byBQTUMgY29yZSBkcml2ZXIuDQo+ID4NCj4gPiBQYXRjaCAxOiBN
b3ZlIGludGVsX3BtY19jb3JlKiBmaWxlcyB0byBwbWMgc3ViZm9sZGVyIFBhdGNoIDI6IEFkZA0K
PiA+IEFsZGVybGFrZSBzdXBwb3J0IHRvIHBtY19jb3JlIGRyaXZlciBQYXRjaCAzOiBBZGQgTGF0
ZW5jeSBUb2xlcmFuY2UNCj4gPiBSZXBvcnRpbmcgKExUUikgc3VwcG9ydCB0byBBbGRlciBMYWtl
IFBhdGNoIDQ6IEFkZCBBbGRlciBMYWtlIGxvdw0KPiA+IHBvd2VyIG1vZGUgc3VwcG9ydCBmb3Ig
cG1jX2NvcmUgUGF0Y2ggNTogQWRkIEdCRSBQYWNrYWdlIEMxMCBmaXggZm9yDQo+ID4gQWxkZXIg
TGFrZQ0KPiA+DQo+ID4gQ2hhbmdlcyBzaW5jZSB2MToNCj4gPiAxKSBBZGQgcGF0Y2ggMSB0byB2
MiBpLmUuLCBNb3ZlIGludGVsX3BtY19jb3JlKiBmaWxlcyB0byBwbWMgc3ViZm9sZGVyDQo+ID4g
MikgTW9kaWZ5IGNvbW1pdCBtZXNzYWdlIGZvciBwYXRjaCAyLg0KPiA+DQo+ID4gRGF2aWQgRS4g
Qm94ICgxKToNCj4gPiAgIHBsYXRmb3JtL3g4NjogaW50ZWxfcG1jX2NvcmU6IEFkZCBHQkUgUGFj
a2FnZSBDMTAgZml4IGZvciBBbGRlciBMYWtlDQo+ID4gICAgIFBDSA0KPiA+DQo+ID4gR2F5YXRy
aSBLYW1tZWxhICg0KToNCj4gPiAgIHBsYXRmb3JtL3g4NjogaW50ZWxfcG1jX2NvcmU6IE1vdmUg
aW50ZWxfcG1jX2NvcmUqIGZpbGVzIHRvIHBtYw0KPiA+ICAgICBzdWJmb2xkZXINCj4gPiAgIHBs
YXRmb3JtL3g4Ni9pbnRlbDogaW50ZWxfcG1jX2NvcmU6IEFkZCBBbGRlcmxha2Ugc3VwcG9ydCB0
byBwbWNfY29yZQ0KPiA+ICAgICBkcml2ZXINCj4gPiAgIHBsYXRmb3JtL3g4Ni9pbnRlbDogaW50
ZWxfcG1jX2NvcmU6IEFkZCBMYXRlbmN5IFRvbGVyYW5jZSBSZXBvcnRpbmcNCj4gPiAgICAgKExU
Uikgc3VwcG9ydCB0byBBbGRlciBMYWtlDQo+ID4gICBwbGF0Zm9ybS94ODYvaW50ZWw6IGludGVs
X3BtY19jb3JlOiBBZGQgQWxkZXIgTGFrZSBsb3cgcG93ZXIgbW9kZQ0KPiA+ICAgICBzdXBwb3J0
IGZvciBwbWNfY29yZQ0KPiA+DQo+ID4gIGRyaXZlcnMvcGxhdGZvcm0veDg2L0tjb25maWcgICAg
ICAgICAgICAgICAgICB8ICAyMSAtLQ0KPiA+ICBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9NYWtlZmls
ZSAgICAgICAgICAgICAgICAgfCAgIDEgLQ0KPiA+ICBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRl
bC9LY29uZmlnICAgICAgICAgICAgfCAgIDEgKw0KPiA+ICBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9p
bnRlbC9NYWtlZmlsZSAgICAgICAgICAgfCAgIDEgKw0KPiA+ICBkcml2ZXJzL3BsYXRmb3JtL3g4
Ni9pbnRlbC9wbWMvS2NvbmZpZyAgICAgICAgfCAgMjIgKysNCj4gPiAgZHJpdmVycy9wbGF0Zm9y
bS94ODYvaW50ZWwvcG1jL01ha2VmaWxlICAgICAgIHwgICA1ICsNCj4gPiAgLi4uL3g4Ni97ID0+
IGludGVsL3BtY30vaW50ZWxfcG1jX2NvcmUuYyAgICAgIHwgMzA3ICsrKysrKysrKysrKysrKysr
LQ0KPiA+ICAuLi4veDg2L3sgPT4gaW50ZWwvcG1jfS9pbnRlbF9wbWNfY29yZS5oICAgICAgfCAg
MTcgKw0KPiA+ICAuLi4veyA9PiBpbnRlbC9wbWN9L2ludGVsX3BtY19jb3JlX3BsdGRydi5jICAg
fCAgIDANCj4gPiAgOSBmaWxlcyBjaGFuZ2VkLCAzNTAgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRp
b25zKC0pICBjcmVhdGUgbW9kZQ0KPiA+IDEwMDY0NCBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRl
bC9wbWMvS2NvbmZpZw0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wbGF0Zm9ybS94
ODYvaW50ZWwvcG1jL01ha2VmaWxlDQo+ID4gIHJlbmFtZSBkcml2ZXJzL3BsYXRmb3JtL3g4Ni97
ID0+IGludGVsL3BtY30vaW50ZWxfcG1jX2NvcmUuYyAoODUlKQ0KPiA+IHJlbmFtZSBkcml2ZXJz
L3BsYXRmb3JtL3g4Ni97ID0+IGludGVsL3BtY30vaW50ZWxfcG1jX2NvcmUuaCAoOTUlKQ0KPiA+
IHJlbmFtZSBkcml2ZXJzL3BsYXRmb3JtL3g4Ni97ID0+IGludGVsL3BtY30vaW50ZWxfcG1jX2Nv
cmVfcGx0ZHJ2LmMNCj4gPiAoMTAwJSkNCj4gPg0KPiA+IENjOiBTcmluaXZhcyBQYW5kcnV2YWRh
IDxzcmluaXZhcy5wYW5kcnV2YWRhQGludGVsLmNvbT4NCj4gPiBDYzogQW5keSBTaGV2Y2hlbmtv
IDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQo+ID4gQ2M6IERhdmlkIEJveCA8
ZGF2aWQuZS5ib3hAaW50ZWwuY29tPg0KPiA+IENjOiBZb3UtU2hlbmcgWWFuZyA8dmljYW1vLnlh
bmdAY2Fub25pY2FsLmNvbT4NCj4gPiBDYzogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0
LmNvbT4NCj4gPg0KPiA+IGJhc2UtY29tbWl0OiBhOTMxZGQzM2QzNzA4OTZhNjgzMjM2YmJhNjdj
MGQ2ZjNkMDExNDRkDQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0KPiANCj4gDQo+IC0tDQo+IFRo
YW5rcywNCj4gUmFqbmVlc2gNCg==
