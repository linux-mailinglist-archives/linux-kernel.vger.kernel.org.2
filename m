Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A7F320D7B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 21:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhBUULh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 15:11:37 -0500
Received: from mga01.intel.com ([192.55.52.88]:36289 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230296AbhBUUL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 15:11:29 -0500
IronPort-SDR: UUnD0qBygHVs0evIPv8R4JsqWwbKyhZE4YQW7lQzE6HjOY9VTovXrqxTTdPb71ZaBlvDOH6K84
 dZIRf1h/IGuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9902"; a="203650032"
X-IronPort-AV: E=Sophos;i="5.81,195,1610438400"; 
   d="scan'208";a="203650032"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2021 12:10:47 -0800
IronPort-SDR: H7c7ASgMlfeNA6jgRBCJTvrpAzWAvn+rX//5JwJuGCFgynCt7tORnKEWjaQ+dK0xZK++JqoaMF
 zo8JhtA2c0ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,195,1610438400"; 
   d="scan'208";a="389406093"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 21 Feb 2021 12:10:47 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 21 Feb 2021 12:10:46 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 21 Feb 2021 12:10:46 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Sun, 21 Feb 2021 12:10:46 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Sun, 21 Feb 2021 12:10:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JninqtzPYnERi6kzgMHgQ7J4mfioveS0ek+2Wjv8h2jpA5bByVaQgrHHSwSC9ZSUdgmhDoxhR2EtI1zLnabvQVk4aMj0vfO1NnpTlVDtLutsU2YbCbqq1145mBQorzQhIZFN8RngWZ04A63OmKPNCJAl6KQ5i4RVgvkZOC1XURmMgI7KY6t2FGdkRMeDpmD73Cf/MErs3tm9jJ3L9fbDS/b35kY1UlxpYToVpETJH5+o4MGznOUlCDPTiSNrlBh4eJugcwX/0SBXJSyETND2e7hMXNWflhmeQ537corLAVhVZ2bmwSNhTKcLKZgS565EFF5NhruvVq46OtAzXjpMwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJ4k7SMhHbtCxP7XrR92LgJ6nEvXLF+f5QgkbDF57uY=;
 b=F8yY4PdPHVjCT0xvtw/eDXdfzi0xkrkuLDVj0vFkNjoLjsb2ZX5TPJVZdVsEB3AZREPv+HRq2spAbjqZqAY9sAhZal07ougTmvzUijgu9WWEvqwfR+uMH+hFnpbnhfaZPOH7O2V0Ejv/Zi6vxeKQrJC9kU2De4MVf8SLAoNsYzyGdi6ZYhZcvtOE2Ffn59uvWZFSzJ29IY+7IRg/73WTSXLx7mFxhWEzjoZ63nbE3H7scF75mZ84fajygrH8z7kgzj4sEfWMSe4l00otiiYlFom7pHuGqZCfwNjxo3MnPZfTdZiPz6TQsxCLSu3jnaS6FkAB/VevIAm98C6xx38a3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJ4k7SMhHbtCxP7XrR92LgJ6nEvXLF+f5QgkbDF57uY=;
 b=DxBIzLWh2ZA/daqYQXVdGXYw39e1CRA/NpYFfgde7vSOGs6FT+UkFpF4Hz8IwHnb+t0Qe5hTZSH0idFDc36Rlh3v89q5741ngPSaTxaG2zL8RU/aw9w0VDC2IrBiILxV6rnNb6TU3WL6PQRpKZRX6NJrE7854ufUooNVIrkC1K0=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4838.namprd11.prod.outlook.com (2603:10b6:510:40::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Sun, 21 Feb
 2021 20:10:42 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0%6]) with mapi id 15.20.3868.029; Sun, 21 Feb 2021
 20:10:42 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     Borislav Petkov <bp@suse.de>, "luto@kernel.org" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v4 22/22] x86/fpu/xstate: Introduce boot-parameters to
 control state component support
Thread-Topic: [PATCH v4 22/22] x86/fpu/xstate: Introduce boot-parameters to
 control state component support
Thread-Index: AQHXCIQDF1tCJs9EdEy5ci27evx3Pqpi/uaAgAALU4A=
Date:   Sun, 21 Feb 2021 20:10:42 +0000
Message-ID: <4862AEE9-1819-43A7-BF95-C02DB6E2D06D@intel.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-23-chang.seok.bae@intel.com>
 <cb6151cf-8f71-2275-c757-098d163f87ff@infradead.org>
In-Reply-To: <cb6151cf-8f71-2275-c757-098d163f87ff@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2570b18c-fc4c-4904-e904-08d8d6a4c417
x-ms-traffictypediagnostic: PH0PR11MB4838:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB4838872D976CA1B14FB939E9D8829@PH0PR11MB4838.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rNpKE1EO1+e4mHbBkNhLPgouX96MARYCsstucp9sVIGM2YVywGlk4KhG3kRHdYigOB9rk1ooX5BbMS3ZJOCc8EyJDPDT3NqBiEeQGIpQje5kIiOBL6FKxtMdIdmOTvQJlQioBEwtNJs9Ca7n4hqblxxkXOC+cjHmiifVNRj+g/lKZW9Fhk7ii4oMEHJV1HeZsBr9q8P8DldobDsqJEzG9AwwUqXz2cJzcrn/3oPr9s7db1Wk8UnnuvFe0nI/iCn5Iab9Ke3P++1KDxjl5BE9VeHpl+TfiXZjrat2kB86Fe4mVdVvckH1a+ftOTSjkmUwZSHKjFGlVcT2rW7o/OGcl8GUEx6sUdZ1xzwGfqxv4VrkVh2Eit5IQgHd0tkrbqKhZ+Ulk+ToqUEKrQKZumnhboHYrSCYRl/TZVUlEjVhfRyVu9TSZmB+ZyB+M/K/TqGJx90oru3mpWpG3PrqKrb7/lhX/gwqlzKcQjNXPHzoaVCaex2iTvSwAbfhdwU+nc+6vgIjvxXbDBz1UJ6cnmqZnXV586v97UYLh5iVUhSTwchbcx8geyZI0SJ2cUlmCzl3IyECvzdONtw3DbIRXRX/hA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(396003)(366004)(136003)(376002)(2616005)(54906003)(478600001)(6486002)(71200400001)(66476007)(66556008)(26005)(8936002)(91956017)(4744005)(6916009)(66446008)(53546011)(66946007)(8676002)(6512007)(33656002)(76116006)(6506007)(186003)(64756008)(36756003)(316002)(2906002)(86362001)(5660300002)(4326008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eTliUkorNFV1UUlaaG9QdExwV0hNWUdXbXFUTVordndXWVpURlRmVWJpSUFR?=
 =?utf-8?B?WDJmUm5yTExSNzRSa3kyZnd4U1ZUK0svb21LOVkyL0svYzV2dmNidTVWaXVS?=
 =?utf-8?B?dUxQaFRkdnp4K252YWp2ejU2L2FlZWVxUktzM0xoVHl5TDlWYkpJeE9RV01H?=
 =?utf-8?B?OWpnY2tpeHYwcnh1VTh2UGhXWFhaczAyNFdmU2FyMktLbXYyd1JjTmw4VGlE?=
 =?utf-8?B?TTJvSHBScnV0UWR6UEJjRkFwRWlVSWg3WVh4UHBvNkJsU1FWb1lMSC9qRHlq?=
 =?utf-8?B?YllJcDEwckt3UEtxa1NpbnlCNGtvQWljTjJ2bDNXVGUvRzR4Z3ljQ2xwUnow?=
 =?utf-8?B?TWhleXJXUXV6ZlQxdUpSOFlESVNWUW1ncklQbnBzSkF0dnQwQnVVWGQ4TzZV?=
 =?utf-8?B?NnUxYW8zMnFqTWgwYzI0djRLQjRDRzVUeHlPTytsMEw4cE85MVdvN2VjdGVU?=
 =?utf-8?B?aEpDM25mOGowNXdJb1Zxbmd3OWhyVDA3YzBsQWord1FMOGxZYW52WVJiQ3Vy?=
 =?utf-8?B?aGVvQXEwWDVVaFhXdk1NaUNQOCtXTG44SzBVK25LR005UDdLKzJ6dm51V0dt?=
 =?utf-8?B?NHlTSG1MSHA3NjJQMGdWay9pYlNjWndPK0lYN2h6NjA0OGcvMUZ4VnVkYk5p?=
 =?utf-8?B?ZWZvazV3emFoVnA0TVhaUTJkczdCNWlIRVZkWSt5cytBSEdZTHdzZThhenR1?=
 =?utf-8?B?OUxheDIyQUVIZmdoaDBVNFFBKzlEQm4vYkNIMm9KdnlMcTBaZlZJWEl0dnBV?=
 =?utf-8?B?dTJIVExpNDJBS2ZibFJVeWZIVm9RbVV0bDJOc3NSbzJkYmdlZWNvdlhscU02?=
 =?utf-8?B?aG1LSFpDR3dyZTNoelRSU0xic2lGemU5dFRaMkFsWDdrM2RTeDZyQU1lOXRF?=
 =?utf-8?B?V2swdzhpY0wzd1JiUUs1a3poeno5QkZVdkV4WXQzNzVlcEZMcVY4cGtHajlv?=
 =?utf-8?B?UWl3dHA2TUkrNExpYko4VFhlZXB6SDVpSW1xcFBlSVhLRnlRcWkzajFWalVz?=
 =?utf-8?B?bTg4eVRxWTZjajhhZzZ1UmVtNHpOelN3TWRycW9hYytXNUtnaCtXRVovNXlS?=
 =?utf-8?B?b0RtdWdkVlFVVDZ3cG8vNHl0NWk2RHNlYjUybS9KZlNZclE4a1BzSDdZN1FZ?=
 =?utf-8?B?U01XdjVVRGJVODBRdDA2N1RpTXdZQ01EMmlldUdKaEE3dTV0Q0pGcE9UWkdZ?=
 =?utf-8?B?NDVZcFp3QlZna3haa0p5K1g2UVlTNHlUQWE1ZGl1QkdvNzc1cjJqdVVBakZZ?=
 =?utf-8?B?UGhOQUIwVlB2RkZWVEJWbmtMTmR0M091TWcrY3N0S21uQ2NpSDlpNTBOMWs4?=
 =?utf-8?B?UXMybTJvNUJXZEF1ZEdHUUQvZndodXBTcWNxQTFRTnhNYllGTXBBc2w1WG5G?=
 =?utf-8?B?aXE2NmxtL0lqNmE3cjR4YmoraEp3YnJNWG15cGJOSDcvRU14VWVacnhuRitn?=
 =?utf-8?B?VDRJZ2RPaVowTXg4ZWcrblo4UVZHR3l1UytxNWtmOUtwN05nRHVzOHM4SHRJ?=
 =?utf-8?B?VVNoRGpIMFFRdTlzaHhHN2lMUXlwa2RUd2tnRTY0amJxelQxMjhycFVHYzlW?=
 =?utf-8?B?VXUwTkZydnp2R05CL3NVZ29RN2ZoRzd6MVhmSmpqbko5RExBTVlQYmY0cUR0?=
 =?utf-8?B?Uk42OFpXVlg3bDhyeTNveitaTkk2My9sSXpFYXR4MWJDWDJuaVhhTVhIN29m?=
 =?utf-8?B?d0xIbTVpeUxScXBCd2kvdG5Ma2hld1RaMFZJa2NueGcxeXlUbExsZ21UZ2c1?=
 =?utf-8?Q?YZ0W+nw51SkB3OS6H/57242ptg739EVaK08xuqD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0DD153AB7347D4882ADAF16E383220B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2570b18c-fc4c-4904-e904-08d8d6a4c417
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2021 20:10:42.4672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c9IjmLNCJmKqPkO7dG70BENEi4FRVkXJ32IORKoaQVMPWiZ56xg2gzGCKMIYlkLlfu/et9+6KkS5ePxO8UIccO+fuUvZMWGHsNVC/U2vehY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4838
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRmViIDIxLCAyMDIxLCBhdCAxMTozMCwgUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVh
ZC5vcmc+IHdyb3RlOg0KPiBDYW4gd2UgdGVsbCBwZW9wbGUgKGluIHRoaXMgRG9jIGZpbGUpIHdo
ZXJlIHRvIGxvb2sgdXAgdGhlIHZhbHVlcyB0aGF0IGNhbiBiZQ0KPiB1c2VkIGluIHhzdGF0ZS5l
bmFibGUgYW5kIHhzdGF0ZS5kaXNhYmxlPw0KDQpQZXJoYXBzIGFkZCBzb21ldGhpbmcgbGlrZSB0
aGlzIHdpdGggdGhlIGNoYW5nZSBiZWxvdzoNCiAgICDigJxTZWUgY29tbWVudCBiZWZvcmUgZnVu
Y3Rpb24gZnB1X19pbml0X3BhcnNlX2Vhcmx5X3BhcmFtKCkgaW4NCiAgICAgYXJjaC94ODYva2Vy
bmVsL2ZwdS9pbml0LmMuIg0KDQovKg0KICogVGhlIGtlcm5lbCBwYXJhbWV0ZXIgInhzdGF0ZS5l
bmFibGU9J21hc2snIiBhbmQgInhzdGF0ZS5kaXNhYmxlPSdtYXNrJyIgaGF2ZSBhDQogKiBtYXNr
IHZhbHVlIGluIGEgc3Vic2V0IG9mIFhGRUFUVVJFX01BU0tfQ09ORklHVVJBQkxFLg0KICoNCiAq
IFRoZSBsb25nZXN0IHBhcmFtZXRlciBpcyAyMiBvY3RhbCBudW1iZXIgY2hhcmFjdGVycyB3aXRo
ICcwJyBwcmVmaXggYW5kIGFuIGV4dHJhDQogKiAnXDAnIGZvciB0ZXJtaW5hdGlvbi4NCiAqLw0K
I2RlZmluZSBNQVhfWFNUQVRFX01BU0tfQ0hBUlMgICAyNA0KDQovKioNCiAqIGZwdV9faW5pdF9w
YXJzZV9lYXJseV9wYXJhbSgpIC0gcGFyc2UgdGhlIHhzdGF0ZSBrZXJuZWwgcGFyYW1ldGVycw0K
ICoNCiAqIFBhcnNlIHRoZW0gZWFybHkgYmVjYXVzZSBmcHVfX2luaXRfc3lzdGVtKCkgaXMgZXhl
Y3V0ZWQgYmVmb3JlDQogKiBwYXJzZV9lYXJseV9wYXJhbSgpLg0KICovDQpzdGF0aWMgdm9pZCBf
X2luaXQgZnB1X19pbml0X3BhcnNlX2Vhcmx5X3BhcmFtKHZvaWQpDQoNClRoYW5rcywNCkNoYW5n
DQoNCg==
