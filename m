Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CED4449950
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 17:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbhKHQRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 11:17:06 -0500
Received: from mga14.intel.com ([192.55.52.115]:15503 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236038AbhKHQRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 11:17:05 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="232501627"
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="232501627"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 08:14:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="731547558"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga005.fm.intel.com with ESMTP; 08 Nov 2021 08:14:00 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 8 Nov 2021 08:14:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 8 Nov 2021 08:14:00 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 8 Nov 2021 08:14:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abmhqMKGcqGeNucZ0Qb7X5WCLp7d8nG2b70812GqOpfOGNsJcKtjTjtCM9ppBDFkNQMZuhzCAN/lTsJRWweaOlA8gYWuq7B8zAFhJmSaqFw2j9tFnC/vhXamyCak9kDc2oDfI86aTT4qxT+jz93SIx2uaCktDhnioFUvXDPt2xmzWjUZxFrWxTYNG/lIt29Nx263n3QUDgjsTNuBkUk8ZvqahLllLDZ14062+wad71LKedyIQC8buc28Ltn0D40x236fCsFt+QBGYAoNrP7fs/MhMaDPUkkTS6R9tLQlxk9qu4gn8V8wZbB7IWRUtDTvx+A8a6emTtVbwzoyqmqMxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJ9rXxpMnyLMTODsx0ASGte+Gch5AlyUFPN1pAsZZnM=;
 b=IMydYB/98a7oQTPXlP/Ah+Hbe69sYBlVVVu6lmTkBodnvnTPESK8dciauqW+qA9UT89C/8tzuPZNmzgEFPPe4VG49X3FvQiIqqoxRGHVsqBWm4pePeib4nXI9aBjM6+muSXlof8YmbjZL6bgGrD8kioRVc9gJbomPHVgIti+QioSKlK7uJ4Q+nAzJoikKrYcvF9Bw3OMfQWG+ZKJxZdscXISeKIfpAeeFGVh+hP5URERsHOsjmdNMPZOu8aE1wLYq+n2vf4/mp3XTAQCBgVF3eiujyddyb9XqNynUhzVzgphD07jc9NM1dJsEUS39JvcN/yoJMS/Re3TEYRouoNEFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJ9rXxpMnyLMTODsx0ASGte+Gch5AlyUFPN1pAsZZnM=;
 b=QsYZbpzmDr3bBC34jUQS9gXHdgxXqs3ahLQJ0mgAL9xvZAGdvVblCBk7t6X8bPzwlpE2nfkuizx1OZm6Sq8XuZLBkKUCiz8Gmv84FlA3OIITemHgvnaXbZTQfrRbxttLsYYgWPDu/4yrtzIRjxsDL4vNSQDVfhZefzEG0rnv6aQ=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Mon, 8 Nov
 2021 16:13:58 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::11ef:b2be:5019:6749]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::11ef:b2be:5019:6749%5]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 16:13:58 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "Zhong, Yang" <yang.zhong@intel.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@suse.de" <bp@suse.de>, "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>
Subject: Re: [PATCH] x86/fpu: Set the corret permission value for
 perm.__state_perm
Thread-Topic: [PATCH] x86/fpu: Set the corret permission value for
 perm.__state_perm
Thread-Index: AQHX1KUTL54IMov/cU+7hOB6p2r7Qqv5zf0A
Date:   Mon, 8 Nov 2021 16:13:58 +0000
Message-ID: <045FEB79-B7AE-421F-A7F1-1ABC86E0E19F@intel.com>
References: <20211108222815.4078-1-yang.zhong@intel.com>
In-Reply-To: <20211108222815.4078-1-yang.zhong@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03307fea-24b7-420c-7233-08d9a2d2c534
x-ms-traffictypediagnostic: PH0PR11MB5782:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR11MB57827784AC90247DF94FA33AD8919@PH0PR11MB5782.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8sS6BcbaxqCudkpS+7v7MSCrA2uzDQ/S8Myi/da4khOq50blzM/KUiX6zGtXvsZiOhHHkPd4686IScOVewWiq87fZX8ppYIfRXS8vgaE3jUmButN6zUgzOqWIfel/NFTYJu0WDKivK7CFy9NYRL3oVLn5DHgszc1v4iO9RmFvheBPxN6togMkGA/ZjWzW65zafGtkXZ+XQq25L+Qmd77lu56/hrLTx2HNEFjLWQLwHTXWcpzIr9qXgIXBasGow2BVAQufVP0nP54GOnodIN/IEEdRqEqBIeK9f99XQg3N6bpCAYTwYLaCcPhNy4TjGDUb/A8xTMBL7/ngOY9Kjc9qdHhz1KPSmPFYLFBYFNBCzDYH3a7aJq/qhCkLtfXTaaJp+9w9pRwHUE5psOPVThHsJOeglrbtt/R+30ZLbkhWA5uL8zrbhG+G7qPMDNX4hPYxPQ4nf+2ibpWBkKz4UP6NPN7vXS2Z6MnfDWs30mJufc0u2zg/uniM/Guq85whYf7PGQdCXRg3cg+oCluVP2EEbO5gzjivOYCYB9/19LYbJsQijlOAWjB2bnbFTmXWIc5mM9Hvsmltl94No/0ggwr+6n87I7TjiM/z2uB26YCYFDQZV/F8wsdD5baHH5ZkLZE+KwUHRQo/p66jxxGqaghpZO8QVVsBXHexT+n8+YbLGlJazTFxMLeDWKbEZzr+uyd/teIy7F/FFJG5C/55/1sBpLlcL4GlMqpg8ljw9ln+N0X8zmqjEvbdtWZPsnqPXHq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(76116006)(54906003)(66476007)(6862004)(33656002)(36756003)(186003)(122000001)(83380400001)(6512007)(26005)(508600001)(2616005)(86362001)(6636002)(66556008)(66446008)(6506007)(64756008)(53546011)(107886003)(38100700002)(5660300002)(6486002)(4326008)(8676002)(82960400001)(71200400001)(66946007)(316002)(37006003)(38070700005)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkR1QTVVeVMzdDdlTTlCV3VkVjF2T2p2bytrQWFRUjdoNXd3RVFqUUdSYWo1?=
 =?utf-8?B?RmZNVHplZkdxOFNhZlRyTVQ4Ukl2U2l4SVNCS2t3UHQzeGtPRVNPZDZUK2c5?=
 =?utf-8?B?a0RpL1ZiVjZoREFVNVgrQW80MmNielp1YWptUTR4NzFXTy84YlJjb1BKWktT?=
 =?utf-8?B?bWZtS0pzUGlnTTFGRERkQk15NU9XTGVyUnoxMEQwdVA0ck92dUZaaDNIRjFN?=
 =?utf-8?B?MnBsT2JxNFo0QmFRR29XazFhb2o3Ulo4S3Z6Q1ZIajM3QVQ1ZFdockR5K1RG?=
 =?utf-8?B?SS8xMG1XNnlYZXBQOTlYcTY2VzlHUUZlZnNXZmtZUEFxejFjNHN3K1J4VEwy?=
 =?utf-8?B?RVhYcWllNXBzQ2U5ajZ5ZGpzY0xFYkRpV05YYnZhWjBldEUyVlFIa0xlTmg1?=
 =?utf-8?B?eUxyZXRFamd0SE4wT0NvcnVlVXBDUml3RW9lMExUTXZiVExWVVo2R3RERkc3?=
 =?utf-8?B?TzBDK1FDdjErTStMdDZ0a21xd3UyRk9MRnJBRUxQdER4N1EyWUhqUlRzTUJm?=
 =?utf-8?B?MkdPSzVpaEU1MFIrSFY1azlkMU5zOVQwYk9Ib1dDMnd5SVBTWjVFS2JrVWxM?=
 =?utf-8?B?ZDZxTFBDV1hlQ1pZVm5vOWpFcHlTNUpsUEtQRjJPN3pXUURyQ3IrNUJxOGkr?=
 =?utf-8?B?cW92TWhOMnJMd2MxSGkrc3l2RkdTMjJ5T1pYUTJROUZtdEEwcWJwS2tvMEsz?=
 =?utf-8?B?dCs3UEV6ZEY0ZVplTjZJU25DN2RKUHFZZkp4SjRvNlQydjFhNmhlZndGSXlx?=
 =?utf-8?B?OWpEMllZRmlvZWwxaGxSNGtGVkFpYUkwV1lBUURBQ1JDK1JPdEdCdkRjNjNt?=
 =?utf-8?B?QkU2QkNldkpEWmo1d2RqNlF3aHkrSWxmVlNPZnhYWm9ITWp6L1krRVlRN2tv?=
 =?utf-8?B?Y21OVTlZQ3R3YW5ZbkF1U1hnNEJtNGlvV2gwTXpibGEwSkEyR3Jvd09KVmQ2?=
 =?utf-8?B?Y2QzL0xSb3J0TG5GYmdLRW5vTmwxL1VqVUZsd0RPSEdCbk4vWXRIWGNMV0xn?=
 =?utf-8?B?aUVGM1BvK3ZsZk5hdWJHelhVWmQ0RmhHSFpGOE5OZlFUaFhPYnBocVVzYVh0?=
 =?utf-8?B?LzRtY3dHS2RXckpIYkFmOEpYN01oYlhYZVhnZ3M3YXM5RGl3NUpFWkZSOFNw?=
 =?utf-8?B?di9pQlVzOFV1R28yTmV6blFxbFZDVFVUOUlHMXFRMThDZEs2aGRrTEpkL0NO?=
 =?utf-8?B?US9DcGhvY1FPOEtEbytQN0MvNTdVL0wyRW11UnRBOWJ4YWk0VjQveElJbkhG?=
 =?utf-8?B?YUw0VFFQVERSZEhHNzZ1OXRzWlFiQTlWSG5PdEVBcTZRR0NzQkk2eW55WXg5?=
 =?utf-8?B?ckRSVTFpN1VsUE4yQlROajIvcHBmQUlveDNubmswRGpPeEI4b0R2UFVoWkRP?=
 =?utf-8?B?b0s1NDJrT3FpOTBVaGRGeStkNzdIbjZlM2NNTXJDdHFqMTJ1UDd6cnRpWW9a?=
 =?utf-8?B?WWVnZDRYdjdybC9KUlBQZGFzaGkzckRjUjlxajl2WWNjMHV2VDhLR09zblMz?=
 =?utf-8?B?bHJjR2hiQXVFazh5ZUowa1l5cEl0b2JMWVIrMXBVZ3FJL0RxVjJ0UkR6MVdr?=
 =?utf-8?B?dSs0THlRSi9qNHc0SkxhaG1TTEw0cGJoRWIzZDFaU2o4enBER2p3SGN0YWlQ?=
 =?utf-8?B?UG5sc2VMMHU1ajJkdStTYlZDQktGWlpwZEtwejk0SXVJSmNpYThkN3lLMloz?=
 =?utf-8?B?RTlJbWRMTHZ4ekVoK1dSOTFpTU5yQ3p5NmRzQXZmZlllZGdEczlpSTlHanB5?=
 =?utf-8?B?VnpiKzRib3NmNDZmUlgvZ0MxQUI1QS9pdFREY2VWeXpxV25OMW5SWlJIVGNh?=
 =?utf-8?B?N3ZFdFF1Y2RRQ0lJaHo4b3JRVFVZei91VXpyeDJ5b21qTVpzQlFiVnYrRkNF?=
 =?utf-8?B?Z1kxSUMzNmF2MUV3ekF5RHJyaG43ZjM0NG5aekJNMW9hYW80SDBBR3JKbXZQ?=
 =?utf-8?B?OWJaU2lCYzlvZ1QxNjNzSWh0azlYcFpwTzdta0tZU3NCNDdpVHpLVGJOVTJL?=
 =?utf-8?B?ZFRIVkFLb2lzenk4d3BzSkh0b2o4cDRUcFlHZ3piQkRWV1R3djRFZUV3SHNP?=
 =?utf-8?B?aEJZQ2FsMjk2ekNGODQ5TjlLQnNlUTY5dkJLUTE4b01BbWZZMlNuaUxEQ3NR?=
 =?utf-8?B?bzdQWGR3bGw1ZWlENEhibUdvZVJCV2p3bGcwN1dUWG92bksxUmF4TW9BRGdF?=
 =?utf-8?B?dnJCR1lJalV3NzgyaVl2TDk4REpvVkovMHlyRDY3QXFnOCttdEdocEtGQW0w?=
 =?utf-8?Q?z5hp347cGmy+WqS+scE5c/Gf0/aj/h82CRMV54BnAs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFFCA64563759746B13C19DC2A1D4020@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03307fea-24b7-420c-7233-08d9a2d2c534
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2021 16:13:58.3801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZXx25MhMBvSCfYDfdhsmt/n1x321nT8kRlV69DSSS/vcNEllp91Uual7PB4MbJjzpB0GwL86TDRLQkbwKljs++HmZp+QrfBC6X9QR1yETs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5782
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTm92IDgsIDIwMjEsIGF0IDE0OjI4LCBaaG9uZywgWWFuZyA8eWFuZy56aG9uZ0BpbnRlbC5j
b20+IHdyb3RlOg0KPiANCj4gVGhlIHBlcm0uX19zdGF0ZV9wZXJtIGlzIGRlZmF1bHQgeHNhdmUg
c2V0IGZlYXR1cmVzLCB3aGVuIHdlIHJlcXVlc3QNCj4gQU1YIHBlcm1pc3Npb24gZnJvbSBhcHBs
aWNhdGlvbiwgdGhlIHJlcXVlc3RlZCB2YWx1ZShiaXQxOCkgc2hvdWxkIGJlDQo+IHJlcGxhY2Vk
IHdpdGggbWFzayB2YWx1ZShyZXF1ZXN0ZWQgfCBwZXJtaXR0ZWQpLCB3aGljaCBjYW4ga2VlcCBk
ZWZhdWx0DQo+IGZlYXR1cmVzIHRoZXJlLg0KPiANCj4gV2l0aG91dCB0aGlzIGNoYW5nZSwgdGhl
IGJlbG93IHByY3RsIHN5c2NhbGw6DQo+ICgxKS4gQVJDSF9HRVRfWENPTVBfUEVSTSwgdGhlIGJp
dG1hc2s9MHgyMDJlNw0KPiAoMikuIHNldCBBUkNIX1JFUV9YQ09NUF9QRVJNIHdpdGggWEZFQVRV
UkVfWFRJTEVEQVRBDQo+ICgzKS4gQVJDSF9HRVRfWENPTVBfUEVSTSwgdGhlIGJpdG1hc2s9MHg0
MDAwMCwgdGhlIGNvcnJlY3QgdmFsdWUNCj4gICAgIHNob3VsZCBiZSAweDYwMmU3IGhlcmUuDQoN
Ck9oLCBiYWQuIA0KDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvZnB1L3hzdGF0ZS5j
IGIvYXJjaC94ODYva2VybmVsL2ZwdS94c3RhdGUuYw0KPiBpbmRleCBkMjg4Mjk0MDNlZDAuLmZj
MWFiMDExNmY0ZSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2ZwdS94c3RhdGUuYw0K
PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvZnB1L3hzdGF0ZS5jDQo+IEBAIC0xNjI2LDcgKzE2MjYs
NyBAQCBzdGF0aWMgaW50IF9feHN0YXRlX3JlcXVlc3RfcGVybSh1NjQgcGVybWl0dGVkLCB1NjQg
cmVxdWVzdGVkKQ0KPiAJCXJldHVybiByZXQ7DQo+IA0KPiAJLyogUGFpcnMgd2l0aCB0aGUgUkVB
RF9PTkNFKCkgaW4geHN0YXRlX2dldF9ncm91cF9wZXJtKCkgKi8NCj4gLQlXUklURV9PTkNFKGZw
dS0+cGVybS5fX3N0YXRlX3Blcm0sIHJlcXVlc3RlZCk7DQo+ICsJV1JJVEVfT05DRShmcHUtPnBl
cm0uX19zdGF0ZV9wZXJtLCBtYXNrKTsNCg0KSSB0aGluayB0aGlzIGhhcyB0byB1cGRhdGUgdGhl
IGdyb3VwIGxlYWRlcuKAmXMgbGlrZToNCiAgICBXUklURV9PTkNFKGN1cnJlbnQtPmdyb3VwX2xl
YWRlci0+dGhyZWFkLmZwdS5wZXJtLl9fc3RhdGVfcGVybSwgbWFzayk7DQoNClRoYW5rcywNCkNo
YW5nDQoNCg0KDQo=
