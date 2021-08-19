Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BAD3F1C9F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 17:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240295AbhHSPY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 11:24:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:58072 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240213AbhHSPY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 11:24:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="203726065"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="203726065"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 08:24:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="594753187"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 19 Aug 2021 08:24:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 19 Aug 2021 08:24:20 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 19 Aug 2021 08:24:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Thu, 19 Aug 2021 08:24:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 19 Aug 2021 08:24:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvGMF2KmdB1Cmm4/cCkfug5Me/xsGwgGkwiXLCOl9/9hIFho3sVT9PSoBsh0J5VeKu7flKIe6iWbXLt1OJz8XG6KXgxwGBoMxfBP04tyZn/J1yscb13dG1yEx8dstRMFR8rmSRaA68o/0pB6cN/2SBbFXZlTxyCCjZ9YJ03FohIKee6ruxSrxxN/UuHzu/1a46E3l368V5Zg2+myvoa6+nBD34TDGURTBbNhKnhLwOQ8SxXPIB+T0c+jMpptKOc809jHoeomW85LdP8mvlCNar2QrLPOTI0579NSyLY+qwFW9+qYdXiD/iqoxdiDBrdgk1Xgh2FT6goBqPrbtUtf1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq1+cHMQWoOTr3Sg/ZX3qeMncQjATGBPEUx4H9J/diA=;
 b=dDm1G3USxqSea8/m5M/nWRX0J2LZF70aYsSxYAUe4z+L4e71EnO870MTQ5bONuRAC/If2eIyYLu0852AECd/5GLO98GyCv0vVD8U7NfWHW/DmSxIuNZ5mApBOqZnOjLgQsAVcIbC/BwL+PTf1lj9MSPpH45hpHiQdNwiIhHqzouGI/qlt6s+cezCBis0Bl2FKW/NUAILXhYILoaH+4PRRr3x1GyDdsV0CALZV6X1VlF+gckq69PCldjBDs9Enj7BV3ZUh/3oQPC24wJTKfN0lz7xKHz5zykJ37sE2mmTXWv6QSqCu0ZSwzIALZGnkVKZRW18l8TJ2McJRJF4+65hRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq1+cHMQWoOTr3Sg/ZX3qeMncQjATGBPEUx4H9J/diA=;
 b=xfHtGR5RMosBEOMi6vAE7XPGGIY5bBhtbCSdlkgZgPcJlLK90zgo4odtYQkAWYVYoFsXIbkcfrP9E4ddipMxCMzqi6mjREEd1WidaubRGSaLZDvoIpG3JxpZ8IhfhZJhZK/Z5NYB45x9uhI62R6Sj8vD6mUrv1GhdagShwjvL9c=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4775.namprd11.prod.outlook.com (2603:10b6:510:34::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 15:24:16 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8%5]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 15:24:16 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Macieira, Thiago" <thiago.macieira@intel.com>,
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
Thread-Index: AQHXhVRyjpE4OXS+e0aKA8ZshCCgeqt5kHqAgAAPrgCAAAcJgIAAMaSAgAAJSACAAAXXAIAArf6AgAB77QA=
Date:   Thu, 19 Aug 2021 15:24:16 +0000
Message-ID: <56F4B6AF-C659-4468-AF91-AE3A685ACD81@intel.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-13-chang.seok.bae@intel.com> <YR00U19168BGoRB9@zn.tnic>
 <3181031.RqgVF4sTRC@tjmaciei-mobl5> <YR1HYRRN0HMTxXrw@zn.tnic>
 <BCC327C2-CF9F-4910-B626-315E515E9A3A@intel.com> <YR14zq2LaExjhFR+@zn.tnic>
 <FC0176FB-32CD-4E7D-8AC7-17452E40FDFE@intel.com> <YR4PqVytqEwFV7X9@zn.tnic>
In-Reply-To: <YR4PqVytqEwFV7X9@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38d49c00-4734-4f09-014d-08d96325688d
x-ms-traffictypediagnostic: PH0PR11MB4775:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB4775B7C58D30DFA715738507D8C09@PH0PR11MB4775.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FIyK8t7vGEOKOHpVNx7NppzJZkdVL5MqxdGskropwD3j8IzPrbv1ZQ66P9FuoEu4ls8P8zq0sSUI8j0KJ+R2KHtGqHAEQUj9qOCj9z4lZlqDJ3ySOfmA4OvssI3zIrSh5b0Ukr7b8QdpCK2m2oiBf8YjOYQ6GwlLZNGb/2fciofre8jv0SrtOJzq5FHw14pnkxn2SagmZK8hXBghk8CWBZARHIqTrB/5R4lRgq7fJTIdmk9HkLNyAF+T5QvWw9lu50Phf6e/pgRyaV6MBJVWgI3qYcpNClBFwLCSPeuXx2Py+rYobSRioVU1Qrh9nM8S2cVTnqV3PE1q2EGVnYDhx7sUg9rHcM10duF6lcJ2sbUFSxDyfeZzsewYmqtOiVBoh3uJ3Uq3MT4R4R58Heh/1/nso/n8+rlxMSGVOlbNZpvyPCDMxdQooVsZbtjPaB7eDKeNaR/8IPtzXYbGWm00tZlxv2wjzLxJTqyKuJQ7z8L7HIo8cHBNAsa1ZOzY2jmuJ9QBqEv8kCShCYzedkIRb28dht2uvZfWk61WjDaFrhXp3o4AuX28dKTIsxkwR78b5P2Ookdutf56zyyeifRdqLi07oyCKrI/RdVUqPZk+7T5mzW0bewEZ+/IwCgmRrQy9SdxkmKPHDYAL8y8eEe2GS8qjpoZLL86CQT2BCgDc035oiPjb1WDKO7CHETct7owf4d8Wx+UbNGsN1KEGPoyyi1aTBVZ0xXp5pTPunJGekqGdtyCx2Zfz3/oVgScBISg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(36756003)(5660300002)(558084003)(2906002)(64756008)(66556008)(66476007)(8936002)(66946007)(76116006)(66446008)(6486002)(71200400001)(6512007)(26005)(186003)(86362001)(8676002)(53546011)(6506007)(4326008)(478600001)(54906003)(33656002)(2616005)(122000001)(38100700002)(38070700005)(6916009)(316002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEVoN29pQ3VRdTNLQkF0UzBuKzU1VWo2NlFBa3BHQ0xGM2VQeDRkeHEzaVpL?=
 =?utf-8?B?UzI3VXpETC81dkQvNjZLeUNlald4Uk9TWGg0eWxMMGFnNjB5eGZWbVFBNkc5?=
 =?utf-8?B?Z3Y3Y1BlNHZVZzMra3VQWFdKMGo3V0lXc3lqc0M5MTdSaE5lMmpXY09obWxT?=
 =?utf-8?B?K2tIWXh3NUpCZ0JCUzZOejRlVkhNOU54ZGxVVFFQWS9pV2ErUzl0U1FQNFdz?=
 =?utf-8?B?WWQ1SFk3MTBiSmxUU25XcE02V2hXQ095T3RVaG15cG1HemFiMUZaSXdyYThx?=
 =?utf-8?B?NWQzbzJBM01iU0JqU0gvOGFmb3JrUHNqZ2ZTZFQvRjEyMHVUc24yYjV5OTdy?=
 =?utf-8?B?VDFHQjhOU0krbVh3S3FYRGlNekdBekwrRk9HYVJiVFBFU2J0ZWRyWTdNTUFI?=
 =?utf-8?B?WXc3bUJJRkZUbVUwVHlaOFY0YUtsSzl3MkJwRUNvbDRiQ1Y2NzFDVGw5UE11?=
 =?utf-8?B?NllKelYvUGQwOWt3UXZWekZMRmFTaDBWOTFRdVpuY29QSGVvVm8zbFZSNGxU?=
 =?utf-8?B?WkdFTFQzWmU2Tjl2Q0ZpaUozakZLVTRFVVZVNWx6eTNGQWx5bVN3VTI5blVO?=
 =?utf-8?B?TFhLMENTdnFuQmdQTEplQSs2eDBPa2E3NkIzNyswKzJVekt2bFgybWpvYU94?=
 =?utf-8?B?N2szWDVuSk83VjJJYVdSUWo2bVlHNkE2UTFzdHpwM2xHOGVEeFFUMUc1eTdr?=
 =?utf-8?B?SDg2REhoMXpQYklsNXAzd1NqR3FlSjQxV2FFZUlEa0FzcXpuTWo0MGt1WG54?=
 =?utf-8?B?U2JBTUhGZTcwanhHZUdrTW0vc2xwd1B2NkxQanVtN29UenRkcEh5dm9UUGFD?=
 =?utf-8?B?dzFMREZyMnByMDN5TURiZkhwWEZuSnBlZXo1TzJ5VW03a0xzQUVLTzc4bkRO?=
 =?utf-8?B?b0NDbjAzMUV2UzY2aW9CRUpGWWlZbC9yUWRvRGpJOGttVVR2NW1taTNvczBV?=
 =?utf-8?B?UklFRE1SRSsveDNUYUFmWE5iSUJFSTJIQkwyK0NqcjZWanh6RDJrSkRob0RV?=
 =?utf-8?B?MFV4bXdJNE1lenl6Zk8zTHJDVUEzUG1yOTg3d2RkMUtvZ2ZvckNKSkpjR1hQ?=
 =?utf-8?B?OXJ2NStzUENuTTJyVDlPeFJNT0s1MmFEYUVIazV4RWRnNkgvaXlTZy9EdmV1?=
 =?utf-8?B?RDVSdk1WRVM0OTl3ZTVQRm11cWZQUlRQTmZsbWVrY1B4V0tqMTBra2czWmNI?=
 =?utf-8?B?RkFBalhDeVlRdmUrUGFTaXl6cHFGNXBST0V0VDFhQU5YVXM1RTR1bEppZURl?=
 =?utf-8?B?ckpzR2tXV1FjWHd2MzhNS2pVaUlRNEZabTVYdU1uaDB6YzQrVFM3MkhaVDBl?=
 =?utf-8?B?ZUsrMmRCR25POTd5azlmN2tObmRsdkxpZ2NxMHFjeFpkRlhxaU5saG1LaGlZ?=
 =?utf-8?B?NThVMzdTRE9IMjhuWU44c0Q5TmpTWHRxR2RaOHAzV1NkQ29xM2ppRm5URTI1?=
 =?utf-8?B?akFyZHU5QXV4azJCdE1tZGNXckMvcGpJQ05Pby9YNWttTDVlNXpMdmRYT1U3?=
 =?utf-8?B?SDg0ZERDQk5YTnM2Y2ZZSnlnYldKdm9SUy9JK0VQY2RpQjlNU1dha2RsSHBk?=
 =?utf-8?B?Wlc3VWFwOGhvRU90QlpYRFpRQ1VBVTd5YnNsdy8reGxPRjR0ZnZPVEtUOHE2?=
 =?utf-8?B?Um02aDN2dzJPVkQ5UGFsVTZMdmlDZ1ZJN0J6ZDdyK256OTQ5bzNaMk9rVG5Z?=
 =?utf-8?B?S2g2TUNCTkRrcytWcnhaMDhIMGRxQ3RjUytoYlF2eDh6VWtwZ0lXREtvckdx?=
 =?utf-8?Q?jv9LwK1MsmoFheDaHhnfADsJvSqjmTvJwvdEGYn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <631813D2A78BBE44A0C121A74A52F34B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d49c00-4734-4f09-014d-08d96325688d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 15:24:16.7148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RxVmhIurYcShqp+9omWQ//+vVhMMqDjHzAcxeW6TC4qTuiXP43moe56kBRufateCl0mlCS+qNpyZdSu6xBRdbke4IrIqAhzu2cjowGTkvco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4775
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gQXVnIDE5LCAyMDIxLCBhdCAwMTowMCwgQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+
IHdyb3RlOg0KPiBJZiB5b3UgZG9uJ3Qgd2FubmEgZG8gaXQganVzdCBzYXkgc28gLSBzb21lb25l
IGVsc2Ugd2lsbC4NCg0KT2theSwgbG9va3MgbGlrZSB5b3XigJlyZSBzbyBzdXJlIGFib3V0IGl0
Lg0KDQpUaGFua3MsDQpDaGFuZw==
