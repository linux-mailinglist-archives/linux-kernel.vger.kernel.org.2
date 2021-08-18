Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D153F0D2E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 23:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbhHRVMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 17:12:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:27267 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhHRVMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 17:12:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="238538591"
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; 
   d="scan'208";a="238538591"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 14:12:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; 
   d="scan'208";a="424376064"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga003.jf.intel.com with ESMTP; 18 Aug 2021 14:12:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 18 Aug 2021 14:12:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 18 Aug 2021 14:12:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 18 Aug 2021 14:12:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhAAOrdzzSx/7oPaxPiPXOY7LJGNLJyLzGYL6e8wiPvj/OUIKr+iN2zAOHQUDB9L3xA1vlxFhtISTpNCeKbeynTKydy9tvLeSw5Vkp4aTXX+ODEZBHREhEuBJMlfr99mni7LtJL7GyC2YdqOCRk8u1N8EOKPcXfdPQVLqCpmFHwZRBQKcKmvAZLeiJQuo6iPNHfhRnAUsULoC+zDRo9MoZEtUttGXiAZYipvXs60j4/3ySDMbMMfSxWaHo/sLCgljD+s9Nhw4xhjkpmpzGZ0y4jO7+Qp5HZ1+nj4ZkVp3F7mLbkdoTnEZjv17QADzpuszpEHVrV9uhr+Xi6EDnA0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXNVgZL/c8Wt8oDn15xGeZ4uFQZ/rqEijB1fI9PxNOg=;
 b=ZvRFsH0jlYwm+T7R1ITEVuEgIsZ1r8xbfm8bmIa5SJS/C9DdT8Lg6gvCwJXljnULSnlh1rAIf4s7wm1MBPbKf4CKLV/7/R+UNK7J7PJetxOozIgtqVheh3N08pgOJauisWBRcPLOFdpGmbSg1zDm7Xvx9yndneVqKinuzjkteRAMaU0WaqELSxYIYns44foJlWbr/JXa/zOZHUlqBvS686DkR/wDeaqRqPY3e7v1rlZlsdjf+kL3h60vtF0mQJ2ul9Tgjoz9Z+ougi5DFtXMt/2iYVgf5fIBrh9mYndzPrQSvNU6tuhBEpnYYS7xsjI4H4LlbGHfmIh4+2PUif+N1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXNVgZL/c8Wt8oDn15xGeZ4uFQZ/rqEijB1fI9PxNOg=;
 b=frtH+PPAuxnkMy4vLJQDWJOiMytvSduPPx5fxUtOaWpggpWT8EZeYj3XYOegBfkRMeDN19Z+3jnCTCgIxhbrOZKfSQh1P0r9dboEJaZNv3DZ2J01sr+H/TWh6OI0/iEP3C7Lfo6mWh5kWkhvw6QFm0XFp7fmr/aQYLAonBMI6S0=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5030.namprd11.prod.outlook.com (2603:10b6:510:41::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Wed, 18 Aug
 2021 21:12:06 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8%5]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 21:12:06 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "Macieira, Thiago" <thiago.macieira@intel.com>
CC:     Borislav Petkov <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
Thread-Topic: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
Thread-Index: AQHXhVRyjpE4OXS+e0aKA8ZshCCgeqt5kHqAgAAPrgCAAAcJgIAAMaSAgAAF1ICAAAISgA==
Date:   Wed, 18 Aug 2021 21:12:06 +0000
Message-ID: <C3EBA85C-8708-4BAD-BB78-C975250BEFFF@intel.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <YR1HYRRN0HMTxXrw@zn.tnic> <BCC327C2-CF9F-4910-B626-315E515E9A3A@intel.com>
 <3399412.qF98CnctbS@tjmaciei-mobl5>
In-Reply-To: <3399412.qF98CnctbS@tjmaciei-mobl5>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2222eaab-37fb-47a1-79f2-08d9628cd57a
x-ms-traffictypediagnostic: PH0PR11MB5030:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB503019A071242A02955EB25DD8FF9@PH0PR11MB5030.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nwmYHrFcz8T4IFQFT3tPD1e9W4EYTePKy1zhXIdqcyLtODrU1FOMjMVva2LEUTo06oAl/gDNffzNDgjGj0TkFUwA2pAJ7Fwjfrp852Z2sHOVUqu7SvagaJ5ed9F2t6xRH2m/e7yWGawIigWWMwoagD/z1So7KC1LP6ACBaqxc8RTJM54mS1s9O0RZWP6/l0qBpj5jk50idFuyXQDVgBtTfnTtOH5s1We0/KC6EzqEZ3uKowqDNwYRihnRIyVlzhi9dWOWWSeb/xwLTAy3fgx9tidyaH/gXwtLgj6iSzOVHAUrzgeHVQ9fIu/Az++l3SToOO9bj2BnwhvOldDjKwlW21aimGljlKBZTML1iMZODi3eNemplbfUsnh2VpCR5N6nlwpgKEmxylIZZTYtBMCzq4BGyrppApGfPxSXzQsNdL0Vuu+s2MfCG1HR25BdtINzc0xnMplpFblWqZelnlKrt43gAHm2BH2OyWC8LMr23c28HhQZ4aFK3XyTvhTk6GY73vDSopPnVTHwiZ+QjwOfixbdVZAjgye7Fi4XqScCTBO7Ks2kKynlYXqCUbRV71BXY5e6vQNekGW2aokSlonDhvLfE1tA6DoSDAFA51/xlLMQbkxR/QXoWvP/eZ7ZRUVFXOMpyrYgCN3AqazOpBJuMIWzKaLp1rrXw4OtJVJLF1nmvVB6YpdJG8RtHRjw7SgfKV0AfKyLqRV6ska/c/ZK6hqjG8Fw+pggT4sjh1PAnfnzuckPR1eDwokIwg7I0hc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(6862004)(36756003)(8676002)(76116006)(26005)(38070700005)(83380400001)(71200400001)(8936002)(186003)(54906003)(4744005)(37006003)(2616005)(6636002)(6506007)(86362001)(66556008)(4326008)(2906002)(66476007)(66446008)(53546011)(64756008)(316002)(5660300002)(478600001)(122000001)(38100700002)(66946007)(6512007)(33656002)(6486002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MndNSWpGM2RnQzRwVlNpRmwrQXlaWGpkcWlaS1U1Y1N0SWo2NXFWekpabzdx?=
 =?utf-8?B?SFBhVXBpV1BuOGpUcjh2VGZ5bUkzWUlVVFJQNUJRcWNadHJGWXp1UUk3cUVl?=
 =?utf-8?B?cmZlblh2RWVoam1tZ0VJek05dS9NdWExQ0t5TElMMytxT2dzVStJMTkxUE9v?=
 =?utf-8?B?UDNtS2wwcFlkS0M2dnk4QlYwY3RWOTZpRGpwejdDeHdtM0MwdzQzS2dPRHM5?=
 =?utf-8?B?YWZrTUVZR0xIWVF0ZVZEMUhKVW50LzlKL3JGY3ZiYjcyeDJFaDVqeDJlNXQr?=
 =?utf-8?B?WldkTE5qdlVsUnhhRXpZS0phc0VmZDlBcmx0eHVKV0gyVDJoY21abzJ0OVZI?=
 =?utf-8?B?SXpRQ3paM2pZbkF0U3doY1QvU1ZoTWhlaENZWlAyRnd2dXViMXg1eDdVQVNu?=
 =?utf-8?B?dnUvck83cWsrVGo5QnU0RnNzbVpUM2loY0JaT2lJSUJPWUtnSlVqaGVmdTAy?=
 =?utf-8?B?QTU3NSsraWpVcGtkbkNSdytVMitycnFnUnlKWWtoamk4d2lBMm9wc1RLMWxi?=
 =?utf-8?B?NXZyRjE3UXFqQzJwUDlCMEN2Y1pORzh2YWVVZjlPNGxUUWZHaGRIRGdHMjRs?=
 =?utf-8?B?ampTZEh5MFlheW1aM2cxcVJYOUV4KzV4S0NkTTI2OExmUDRuRzRlNVhobE9l?=
 =?utf-8?B?WUtPSDJlaDZDS21XUHRwZGFHSXhpa0lPUkJjUXRkMU9JcnNHWEhpc1k5UmVR?=
 =?utf-8?B?Mk14dUgzUXc3ZElYd3B5UkZ5akJydGdsNVNWd3ZMQXlYaWtrbUJXUjVtK2Vq?=
 =?utf-8?B?clo5Y29Na2J3QmJhZEtaR2M1ek8zL2IxZWsyNTB6cU5pRytSc0xJV1lCUWgr?=
 =?utf-8?B?cXQ3bU8yNjZRa3Z1T3E3bkswN0NTV0hWK3ZiQklTTzQvUmtZMGRKa3BZMGhn?=
 =?utf-8?B?VnpDRjRwR0QwY1J6d3NqZUl0a0UzSXgwd0h3SUowUm1UTENrUmdxbXZOMTZv?=
 =?utf-8?B?d3VLSC9yTS95ZFJrY2YxcHdaQVZleXJNVUdYanczNlUwaFFoUEpDS0ZGZ0M4?=
 =?utf-8?B?L1F3NGNiMGl5Z2RLOCtZNG5Fa0N1Yi9EU010UmIzWGNYZWU0WDFzei9CdWlj?=
 =?utf-8?B?akxkVFRLUFVUSEJQZjlRRlVWUVJoU2NEV3ltMENJMmdBSGxyVzlOQ2lGcnZa?=
 =?utf-8?B?c2xWa3RLeXAvc0FrSnpNQzNJMHl1QXBpcnMzWUd2d3FWNEVZcnJUWWdhdVNP?=
 =?utf-8?B?eTBzWEVLejRJbFlLU2dlNHhhN0V4VEMvbEl2dHExVlh2WGZiZVVHOEwzZ0Rj?=
 =?utf-8?B?Ym1xalNKSWQydjJZaTgwN1BHdmRIYS9MMFVrd29qdWJIQis5SlpBZEhURTls?=
 =?utf-8?B?d2VwTWdPVyt4NzBUMmVHWWdNNHZicFd4OUQxZjhsbFpaVzR4dHpBSm5oQnlX?=
 =?utf-8?B?bElJUXdTclFHcVpmN1VqY3p5R1AzdzdXaUhTYkVNY1RJZGhMSVNMVVdNNFJV?=
 =?utf-8?B?V2JHbmVCRklvTUxxVUdNVmxRblhBcEZvbmkvT1Mwc3NWbzBsQ0p3cTZFUFUz?=
 =?utf-8?B?K2ZCV2pSVVV0b3duSVpKeEtEREcxcnVpRUJwUit2YStEcDVWWHhrUzA1VFgy?=
 =?utf-8?B?ZjVpSm5VTHNoYlNNSGRLTSsrWnBiZEFtR3NQdXJhNTRWMTRRZ05BaEZHcnZ0?=
 =?utf-8?B?UUZUV1ovQTJuMTliSk9xSkJUL3RLc0lmcENNSkZSZ3RCenlGckw1Ky9NUjJS?=
 =?utf-8?B?eVQwLzVET2xnSEN1UlN3NlFpS0dDWVFZbmhNeDlNcVZCRU53dVN5TmFSS3lq?=
 =?utf-8?Q?D/vg8Djiql741emICHxeS6y1uu9P+NXnMsMhRPv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59E6FC6F913D294F9DC82AC076B8DA3D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2222eaab-37fb-47a1-79f2-08d9628cd57a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 21:12:06.4624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YlcdrQ0hGJZBipktrTNmVich8n3p/d/coUfERYJfCmsFlItg0hzQLW4xPqBGUwkRgszgctwXhpO1SYuxNjKY/OA7OQ6BO8Xhv38LWRWf6JQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5030
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gQXVnIDE4LCAyMDIxLCBhdCAxNDowNCwgVGhpYWdvIE1hY2llaXJhIDx0aGlhZ28ubWFjaWVp
cmFAaW50ZWwuY29tPiB3cm90ZToNCj4gQnV0IGl0J3Mgbm90IHRoZSBvbmx5IHBvc3NpYmxlIHNv
bHV0aW9uLiBBIGZ1dHVyZSBrZXJuZWwgY291bGQgZGVjaWRlIHRvIGxlYXZlIA0KPiBzb21lIGJp
dHMgb2ZmIGFuZCBvbmx5IGVuYWJsZSB1cG9uIHJlcXVlc3QuIFRoYXQncyBob3cgbWFjT1MvRGFy
d2luIGRvZXMgaXRzIA0KPiBBVlg1MTIgc3VwcG9ydC4NCg0KRXZlbiBpZiBYQ1IwIGlzIGV2ZXIg
c3dpdGNoZWQsIGRvZXNu4oCZdCBYR0VUQlYoMCkgcmV0dXJuIGl0IGZvciB0aGUgKmN1cnJlbnQq
DQp0YXNrPw0KDQpUaGFua3MsDQpDaGFuZw==
