Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44AE239C5E0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 06:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhFEE2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 00:28:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:34613 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229864AbhFEE2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 00:28:11 -0400
IronPort-SDR: A3bdl+0Ln6Xaxwd0nd1vsg44ZiHJJN+Obk/3JAC/Z1vpLajHozU6x+UQ3sFZzftloYWrDTu4WT
 geb2V2RJLmtg==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="204384827"
X-IronPort-AV: E=Sophos;i="5.83,250,1616482800"; 
   d="scan'208";a="204384827"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 21:26:23 -0700
IronPort-SDR: Js+W7zZFI9lfqx20aMYjhm3Vx23y/aXouEykuV9NkuN4XZ0ZOimS5FZqqF9G5FEjVHaLbb4Zak
 9Muwv+VWOmlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,250,1616482800"; 
   d="scan'208";a="634208961"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jun 2021 21:26:22 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 4 Jun 2021 21:26:22 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 4 Jun 2021 21:26:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Fri, 4 Jun 2021 21:26:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Fri, 4 Jun 2021 21:26:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOFBMz2zWx5IiaCm0LClbCM9J7zEA5h0mw1RfTx9EwcLSEfVnpQ9zUmzSTZlbPNb2a6K0TqgIFltaIT0rlTGppZSnSxFZNB04iu/GDtEupVqzjarpPN8X4yYfgRG1gXVCUlvh+3GA7xA9NUSlgbWGqvzvasRv3tUDOeNsRL4VXS5oAvJ+vn/1d6psE4mxhqQUk043+hKDVQQInwz5cMpvZPyMVwvQTL/ITRd3xNIQsEcuTzv8puXxzqCqfEdcSmAgeGWiSG6TyKT6zDJrOkgaA+z7ibx8Vo7JE5PionOncf9NB0b9ritGF7uhSLBhDDId8oHPJGFLUeK8R6PnaMAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Rgz+kfHU8HIeCdbDNVs6JIoAM6fIOfGsaWX0psiXNo=;
 b=EaRAxQNK+UnVziDCwsQ1OE3dpjtVHKu2gXvRJaFBUsEPFl3aIvfecrwNtwfT/zzyhjghoaprTHlLElw6NViUB+L4ZA7Lin7w+f3cRZFKZ2z79ZxXrFn0i/9qFkqM7HukcTj/W9ax4h1W4qnwUutlz4EvjQbHku2eIlHIVh/k/J3GBQ0adyEywMHkhPD8QDrRS+9yWj4mQf8/rS6vvkTtzg8Ph6CY3giUEwyTQErKaF95zybNR2JpXIXZS+k/zm/0joJrGyUkw5aW5wceFwlXYk7JzkX0JH8RCeocQMra+w68yUiGJ42X8YLM0kmC3JKU0rdGnBwLDkJbcg3gvqnUFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Rgz+kfHU8HIeCdbDNVs6JIoAM6fIOfGsaWX0psiXNo=;
 b=fMI4F+tKLcT9dafIVv93mURYHZDMNocHJ27pQH1l+p+QUYkSqJwuR85bgd74WxF1g6hTW8JbcI0PY9ywQH4dKTc0+4Yi1plgUWeRQ5boFdmTLOy1yC4EFiTNo6EWm57zX4Nh22hvYiaqGrHWkIy4+wEpzxIWvEZaJqW3YlM/cK4=
Received: from SJ0PR11MB5150.namprd11.prod.outlook.com (2603:10b6:a03:2d4::18)
 by SJ0PR11MB4957.namprd11.prod.outlook.com (2603:10b6:a03:2df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Sat, 5 Jun
 2021 04:26:18 +0000
Received: from SJ0PR11MB5150.namprd11.prod.outlook.com
 ([fe80::153d:3860:6b4a:d839]) by SJ0PR11MB5150.namprd11.prod.outlook.com
 ([fe80::153d:3860:6b4a:d839%4]) with mapi id 15.20.4195.024; Sat, 5 Jun 2021
 04:26:18 +0000
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "luto@kernel.org" <luto@kernel.org>
CC:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "knsathya@kernel.org" <knsathya@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v2-fix-v1 2/3] x86/tdx: Handle early IO operations
Thread-Topic: [RFC v2-fix-v1 2/3] x86/tdx: Handle early IO operations
Thread-Index: AQHXUrApgh72OAof1kiP2rCYJ6jii6sE4HqA
Date:   Sat, 5 Jun 2021 04:26:18 +0000
Message-ID: <99c025a17fbf8212c5472eb47e72e1917d812997.camel@intel.com>
References: <CAPcyv4gBNqDFQEYjWqYTckPg-yy=LrvMw_FNY+tUuEwD35CfyA@mail.gmail.com>
         <20210527042356.3983284-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20210527042356.3983284-3-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20210527042356.3983284-3-sathyanarayanan.kuppuswamy@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.1 (3.40.1-1.fc34) 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2662530-a748-483f-8c98-08d927da10a6
x-ms-traffictypediagnostic: SJ0PR11MB4957:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB49576CCF5D942DAF2F823DB2C63A9@SJ0PR11MB4957.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /VbQCYClk4Kzy1Ei7X36YoCzek9glNbBsVxmKm+oXQWAyCnc2O6w/f9ULLeW41H4Ob0muv+xJ9BHFzPf7WjAUtJAys7VouTp6XWJ6lo9KBSa/KX/RuWOayHW3RJesQAL6HhsUvRIU0LG201ml3H5MOhvRKfRR2+8p+yJ82qig0jU+m8oF/0Q8RUHQ23GOjznBjCk7k3FKXdYUlMZXvkT7SmTHx75dJ3R6OIjDx84Zr6th77HlFyj3AxfTrOF/GcY7ccZvx/Jio3sL7bcK+aPNvjaFIxh0O9Sg2BIhOmyd7Y4tskUwZGmjdcke99PobkEDndYnFeKQ2JkiWNSxBq0+3b3RC64x2Cc2rsga8G/QqSu11pMxTAxY3a6kUS2rEVFUjN39giICBd37nKlj6IjAFfB6Dv9HAFUxsppJcytOC8YY0FYXMDYswrD1DyAuWic0TQz0szz14D8G6adZ593vWo813VOKQj91jnzM9YMJcL16bwqQHxqi5ZSe8vRH/weYgFLRa/1XDoobnwdrugKubwDHUchhU7FU+396OWekbRA6hUOMMAuPeM0EGVKUHt04nf+fkv1fzempR8HP4PMK5MWHfD4HJ+PMUkyv2U0XN2MhZH6/v5R8oENgS3vE8wgXCi2iazYYOak9Tsu23hXI1awTsUdHzC+MWn/UJ9dQd86NL8vuztBoSM5iDsxLkFmURUFiVh/idwLnUflA6iiFdina7FcP2NjrEncBCjiurc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5150.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(136003)(366004)(376002)(2906002)(86362001)(38100700002)(8676002)(8936002)(122000001)(6486002)(6512007)(36756003)(966005)(71200400001)(76116006)(26005)(316002)(186003)(66446008)(66476007)(91956017)(4326008)(66556008)(66946007)(6506007)(64756008)(478600001)(54906003)(110136005)(5660300002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QXQzV044VnpXWXUvV2V4WFBHQ2ZRSnFvNXByQ0VwRFBDNzN3dXpocDNSYmpM?=
 =?utf-8?B?Q3pteWYzOExDdlhqdXRMNTVNOU9BL1YzMUx2RVNnVWtRZnNRdHBzdmFDOVox?=
 =?utf-8?B?bDhRRU1RTnV1L2plNDZ5aDFVQkFJNkFQUWtsbHNTM3Y4cThLdkViV2RKQ1hZ?=
 =?utf-8?B?Ni9kTjdsWXZpdDdMWHV6ZFQzc2hlUUE4RjM0dEFzaVJkRXd1MG5wdnlKUmdy?=
 =?utf-8?B?alZEcHVpejV3OGY1RENTbml5SnpZQ0VMUk9vcjlrYWlxL1U2WUJtK2xZbmJj?=
 =?utf-8?B?QnFCZDErYjk1NEJHVWNMMEZKS254UW8zL1J3ZklLY1pRMSt2ZmMrc1ZoM0hy?=
 =?utf-8?B?K0k0Vis5MzdwYWg4VGFreEJ2dnVDemZTWUxJSmJ3anlFVklGYjUySE9vOFY3?=
 =?utf-8?B?UkhFN25wRmxxQ2VIVzlhUDU1cFBjUjRBcnVBNHpkR3ZKcTBEQzVyL2huSjcv?=
 =?utf-8?B?ZVkxSHE3UWs0OGE4Vm1wRGdIVndGUE1BeFRTRXE4UWRrdzZpbmRtbE9YL2dh?=
 =?utf-8?B?Ny9ic1NPQzUyZFZMbWsvbGdaTDdsTGFEZVYrelR0eG9qVEVIYURQUkUvbVpL?=
 =?utf-8?B?Z3BNSlo5NGNraVNGRXNyQ2ZRTmxnYkxGWnJ6a3dPUDZSeFFRaVdrQ0JFM2hQ?=
 =?utf-8?B?R1VlMUhNRytONkNkR1licXBiaktnVXVYeXpzNGNsMXhYVTNKdFBLZS9GeGlI?=
 =?utf-8?B?WmkwRHVoOTAyMGlGQXVKdTkwZmZsNkwwYkdBd3M0OUlCaGhtand3SkIyRHFY?=
 =?utf-8?B?QXpIRmZLUkVGQ0JuWEhNeEdyUFJIZkpYaWFJN013UjErdjVWRE9zS21UNlBR?=
 =?utf-8?B?U0RMYUxiKys2cFNWdFlpMWpqUURCSVNlOTdZdmFvTm5zSWZwWUNabGtUL0o4?=
 =?utf-8?B?L1M4ajhlcXFOVDBEV0MrcnhTcWF1Y2s5NEQxd2NEWlJtS0VSWm9aYWJFbUVW?=
 =?utf-8?B?QTdRZjVrbmNxY0J4bWwzYzhrVm9YV0craEhhY25QUGVhUG1FdXNGTldyVmNa?=
 =?utf-8?B?ZEgzZDlkekRDZnZTaGphWlREMXY2cmM0U1phaStrOStJaWlacWUzbmlKbmZj?=
 =?utf-8?B?OTRFcUFmL2xaSUQyMXZKL0ZubDYzemRaK3ZwUllpbWdCSTdqZkVWbTBWa1h5?=
 =?utf-8?B?cXE3cmxoSmJNckd6NDZpK0pzM2d2Si9kVmJBWFJ3a0o3QUNOcWJTcXlQZE4v?=
 =?utf-8?B?UHhBYzB0Y1VyOWVSN0NnNFFXMnk3RHpNbEpTU1VEV2kyZGtwbnFFcU1ScGhh?=
 =?utf-8?B?b21wd25sMG5JMjc1MW1HajhiVlVvUFl2dTBOaGx4bTdVVmYyMFk3UHVwK1Vj?=
 =?utf-8?B?anQ4Zjc0WkhETWhBUkdTSDkwYkRseWtaekVyb3AyQzhCK3VxQ0oyRWNYUDBB?=
 =?utf-8?B?d2FGZDlmNkFidDFxWVJNbzNvaDdqaU91RGRHdzg3QXRlWlowb0N1VDB6U2N2?=
 =?utf-8?B?V0FRS1piQmt3RFRwUWJyVGRaT1UwMzZEajFkcTZ0MkVvMDl5cHFMc3JMbDhX?=
 =?utf-8?B?SGZ5b1Q5VGtZUFB1MGd6cFB1Yng4anZkUituWU9NcTJCRXBtdmhSaTN2UTR0?=
 =?utf-8?B?dWxVTTREWVZzYk1aVGMwaVZDd1F6ZFVwMTN6bEkwODVJTUZHTjl4M0ZMOGxx?=
 =?utf-8?B?RU1lLzJkcUxkS0o2UFo3NVpHS1h4Y0F3b1NiUjJVSlZxbXlYUEZYQ1k5SzhV?=
 =?utf-8?B?T2RoV2xUWHh4ckw5SEpNdFpaWHNFQmplSnJ1eE1RS2kyVDVPWGhlNy9CSUd1?=
 =?utf-8?Q?P3Lr0oEg21ayDACo0ZPCR13SGEa6Fbuf6ltfsyT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF4189C51609904FAA31B67DD77B8540@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5150.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2662530-a748-483f-8c98-08d927da10a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2021 04:26:18.1915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AOp+snMAZ9O3RdypfU0FY4T/kg6BwW2a3p7myskOetdWDZwuB70HOY7MDNCce6NoY1W0Ii7qNeSvaOu+f+BaiOH2wruRh3gWVU5mQpYA/v4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4957
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA1LTI2IGF0IDIxOjIzIC0wNzAwLCBLdXBwdXN3YW15IFNhdGh5YW5hcmF5
YW5hbiB3cm90ZToNCj4gRnJvbTogQW5kaSBLbGVlbiA8YWtAbGludXguaW50ZWwuY29tPg0KPiAN
Cj4gQWRkIGFuIGVhcmx5ICNWRSBoYW5kbGVyIHRvIGNvbnZlcnQgZWFybHkgcG9ydCBJT3MgaW50
byBURENBTExzLg0KPiANCj4gVERYIGNhbm5vdCBkbyBwb3J0IElPIGRpcmVjdGx5LiBUaGUgVERY
IG1vZHVsZSB0cmlnZ2VycyBhICNWRQ0KPiBleGNlcHRpb24gdG8gbGV0IHRoZSBndWVzdCBrZXJu
ZWwgdG8gZW11bGF0ZSBvcGVyYXRpb25zIGxpa2UNCj4gSU8gcG9ydHMsIGJ5IGNvbnZlcnRpbmcg
dGhlbSBpbnRvIFREQ0FMTHMgdG8gY2FsbCB0aGUgaG9zdC4NCg0KcyxrZXJuZWwgdG8gZW11bGF0
ZSBvcGVyYXRpb25zIGxpa2UgSU8gcG9ydHMsa2VybmVsIGVtdWxhdGUgcG9ydCBJL08sDQoNCj4g
DQo+IEEgZnVsbHkgZmVhdHVyZWQgI1ZFIGhhbmRsZXIgc3VwcG9ydCBmb3IgcG9ydCBJTyB3aWxs
IGJlIGFkZGVkDQo+IGxhdGVyIGluIHRoaXMgcGF0Y2ggc2V0IChpbiBwYXRjaCB0aXRsZWQgIng4
Ni90ZHg6IEhhbmRsZSBwb3J0DQo+IEkvTykuIEJ1dCBpdCBjYW4gYmUgdXNlZCBvbmx5IGF0IGxh
dGVyIHBvaW50IGluIHRoZSBib290DQo+IHByb2Nlc3MuIFNvIHRvIHN1cHBvcnQgcG9ydCBJTyBp
biBlYXJseSBib290IGNvZGUsIGFkZCBhDQo+IG1pbmltYWwgc3VwcG9ydCBpbiBlYXJseSBleGNl
cHRpb24gaGFuZGxlci4gVGhpcyBpcyBzaW1pbGFyIHRvDQo+IHdoYXQgQU1EIFNFViBkb2VzLg0K
DQpDbGFyaWZ5ICJmdWxseSBmZWF0dXJlZCIuIEkgbmFpdmVseSB0aG91Z2h0IHRoYXQgdGhlIG5v
dGVzIGJlbG93IGFib3V0DQp0cmFjZSBhbmQgcHJpbnRrIHdlcmUgaW1wbHlpbmcgdGhhdCB0aGUg
ZnVsbCBmZWF0dXJlZCAjVkUgaGFuZGxlciB3aWxsDQp1c2UgcHJpbnRrKCkgc28gaXQgY2FuJ3Qg
YWxzbyB1c2UgI1ZFIHNpbmNlIHByaW50aygpIHdvdWxkIHJlY3Vyc2UgaW50bw0KdGhlICNWRSBo
YW5kbGVyIGlmIHRoZSBzZXJpYWwgY29uc29sZSBpcyB1c2luZyBwb3J0IElPLg0KDQouLi5idXQg
dGhhdCBkb2VzIG5vdCBzZWVtIHRvIGJlIHRoZSByZWFzb24gc2luY2U6DQoNCmh0dHA6Ly9sb3Jl
Lmtlcm5lbC5vcmcvci8yMDIxMDUyNzA0MjM1Ni4zOTgzMjg0LTQtc2F0aHlhbmFyYXlhbmFuLmt1
cHB1c3dhbXlAbGludXguaW50ZWwuY29tDQoNCi4uLmlzIGFsc28gdXNpbmcgI1ZFIGZvciBwb3J0
IElPIGVtdWxhdGlvbj8NCg0KPiBUaGlzIGlzIG1haW5seSB0byBzdXBwb3J0IGVhcmx5X3ByaW50
aydzIHNlcmlhbCBkcml2ZXIsIGFzDQo+IHdlbGwgYXMgcG90ZW50aWFsbHkgdGhlIFZHQSBkcml2
ZXIgKGFsdGhvdWdoIGl0IGlzIGV4cGVjdGVkDQo+IG5vdCB0byBiZSB1c2VkKS4NCj4gDQo+IFRo
ZSBlYXJseSBoYW5kbGVyIG9ubHkgZG9lcyBJTyBjYWxscyBhbmQgbm90aGluZyBlbHNlLCBhbmQN
Cj4gYW55dGhpbmcgdGhhdCBnb2VzIHdyb25nIHJlc3VsdHMgaW4gYSBub3JtYWwgZWFybHkgZXhj
ZXB0aW9uDQo+IHBhbmljLg0KPiANCj4gSXQgY2Fubm90IHNoYXJlIHRoZSBjb2RlIHBhdGhzIHdp
dGggdGhlIG5vcm1hbCAjVkUgaGFuZGxlcg0KPiBiZWNhdXNlIGl0IG5lZWRzIHRvIGF2b2lkIHVz
aW5nIHRyYWNlIGNhbGxzIG9yIHByaW50ay4NCj4gDQo+IFRoaXMgZWFybHkgaGFuZGxlciBhbGxv
d3MgdXMgdG8gdXNlIHRoZSBub3JtYWwgaW4qL291dCoNCj4gbWFjcm9zIHdpdGhvdXQgcGF0Y2hp
bmcgdGhlbSBmb3IgZXZlcnkgZHJpdmVyLiBXZSBkb24ndA0KPiBleHBlY3QgSU8gcG9ydCBJTyB0
byBiZSBwZXJmb3JtYW5jZSBjcml0aWNhbCBhdCBhbGwsIHNvIGFuDQo+IGV4dHJhICNWRSBleGNl
cHRpb24gaXMgbm8gcHJvYmxlbS4NCg0KIlRoZXJlIGlzIG5vIGV4cGVjdGF0aW9uIHRoYXQgZWFy
bHkgcG9ydCBJTyBpcyBwZXJmb3JtYW5jZSBjcml0aWNhbCwgc28NCnRoZSAjVkUgZW11bGF0aW9u
IGNvc3QgaXMgd29ydGggdGhlIHNpbXBsaWNpdHkgYmVuZWZpdCBvZiBub3QgcGF0Y2hpbmcNCm91
dCBwb3J0IElPIHVzYWdlIGluIGVhcmx5IGNvZGUuIg0KDQo+IFRoZXJlIGFyZSBhbHNvIG5vIGNv
bmNlcm5zDQo+IHdpdGggbmVzdGluZywgc2luY2UgdGhlcmUgc2hvdWxkIGJlIG5vIE5NSXMgdGhp
cyBlYXJseS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZGkgS2xlZW4gPGFrQGxpbnV4LmludGVs
LmNvbT4NCg0KTWlzc2luZyBhIFNhdGh5YSBzaWduZWQtb2ZmLWJ5Lg0KDQo+IC0tLQ0KPiDCoGFy
Y2gveDg2L2luY2x1ZGUvYXNtL3RkeC5oIHzCoCA2ICsrKysNCj4gwqBhcmNoL3g4Ni9rZXJuZWwv
aGVhZDY0LmPCoMKgIHzCoCA0ICsrKw0KPiDCoGFyY2gveDg2L2tlcm5lbC90ZHguY8KgwqDCoMKg
wqAgfCA1OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiDCoDMgZmls
ZXMgY2hhbmdlZCwgNjkgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2luY2x1ZGUvYXNtL3RkeC5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdGR4LmgNCj4gaW5kZXgg
NTNmODQ0MjAwOTA5Li5lODgwYTlkZDQwZDMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2luY2x1
ZGUvYXNtL3RkeC5oDQo+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RkeC5oDQo+IEBAIC03
Miw2ICs3Miw3IEBAIHU2NCBfX3RkeF9oeXBlcmNhbGwodTY0IGZuLCB1NjQgcjEyLCB1NjQgcjEz
LCB1NjQgcjE0LCB1NjQgcjE1LA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzdHJ1Y3QgdGR4X2h5cGVyY2FsbF9vdXRwdXQgKm91dCk7DQo+IMKgDQo+IMKgYm9vbCB0
ZHhfcHJvdGVjdGVkX2d1ZXN0X2hhcyh1bnNpZ25lZCBsb25nIGZsYWcpOw0KPiArYm9vbCB0ZGdf
ZWFybHlfaGFuZGxlX3ZlKHN0cnVjdCBwdF9yZWdzICpyZWdzKTsNCj4gwqANCj4gwqAjZWxzZSAv
LyAhQ09ORklHX0lOVEVMX1REWF9HVUVTVA0KPiDCoA0KPiBAQCAtODcsNiArODgsMTEgQEAgc3Rh
dGljIGlubGluZSBib29sIHRkeF9wcm90ZWN0ZWRfZ3Vlc3RfaGFzKHVuc2lnbmVkIGxvbmcgZmxh
ZykNCj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiBmYWxzZTsNCj4gwqB9DQo+IMKgDQo+ICtzdGF0
aWMgaW5saW5lIGJvb2wgdGRnX2Vhcmx5X2hhbmRsZV92ZShzdHJ1Y3QgcHRfcmVncyAqcmVncykN
Cj4gK3sNCj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIGZhbHNlOw0KPiArfQ0KPiArDQo+IMKgI2Vu
ZGlmIC8qIENPTkZJR19JTlRFTF9URFhfR1VFU1QgKi8NCj4gwqANCj4gwqAjaWZkZWYgQ09ORklH
X0lOVEVMX1REWF9HVUVTVF9LVk0NCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9oZWFk
NjQuYyBiL2FyY2gveDg2L2tlcm5lbC9oZWFkNjQuYw0KPiBpbmRleCA3NWYyNDAxY2I1ZGIuLjIz
ZDFmZjQ2MjZhYSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2hlYWQ2NC5jDQo+ICsr
KyBiL2FyY2gveDg2L2tlcm5lbC9oZWFkNjQuYw0KPiBAQCAtNDEwLDYgKzQxMCwxMCBAQCB2b2lk
IF9faW5pdCBkb19lYXJseV9leGNlcHRpb24oc3RydWN0IHB0X3JlZ3MgKnJlZ3MsIGludCB0cmFw
bnIpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHJhcG5yID09IFg4Nl9UUkFQX1ZDICYmIGhh
bmRsZV92Y19ib290X2doY2IocmVncykpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuOw0KPiDCoA0KPiArwqDCoMKgwqDCoMKgwqBpZiAoSVNfRU5BQkxFRChDT05GSUdf
SU5URUxfVERYX0dVRVNUKSAmJg0KDQpUaGlzIGV4cGxpY2l0IElTX0VOQUJMRUQoKSBpcyB1bm5l
Y2Vzc2FyeSBnaXZlbiB0ZGdfZWFybHlfaGFuZGxlX3ZlKCkNCnJldHVybnMgZmFsc2UgaW4gdGhl
IENPTkZJR19JTlRFTF9URFhfR1VFU1Q9biBjYXNlIGFzIGRlZmluZWQgYWJvdmUuDQoNCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgIHRyYXBuciA9PSBYODZfVFJBUF9WRSAmJiB0ZGdfZWFybHlfaGFu
ZGxlX3ZlKHJlZ3MpKQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuOw0K
PiArDQo+IMKgwqDCoMKgwqDCoMKgwqBlYXJseV9maXh1cF9leGNlcHRpb24ocmVncywgdHJhcG5y
KTsNCj4gwqB9DQo+IMKgDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvdGR4LmMgYi9h
cmNoL3g4Ni9rZXJuZWwvdGR4LmMNCj4gaW5kZXggODU4ZTdmM2Q4ZjM2Li5jYTM0NDJiN2FjY2Yg
MTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC90ZHguYw0KPiArKysgYi9hcmNoL3g4Ni9r
ZXJuZWwvdGR4LmMNCj4gQEAgLTEzLDYgKzEzLDEwIEBADQo+IMKgI2RlZmluZSBURElORk/CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDENCj4gwqAjZGVm
aW5lIFRER0VUVkVJTkZPwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDMN
Cj4gwqANCj4gKyNkZWZpbmUgVkVfR0VUX0lPX1RZUEUoZXhpdF9xdWFsKcKgwqDCoMKgwqAgKCgo
ZXhpdF9xdWFsKSAmIDgpID8gMCA6IDEpDQoNCkhvdyBhYm91dCBWRV9JU19JT19PVVQoKT8gVG8g
bWF0Y2ggaXRzIHVzYWdlIGFzIGEgZmxhZyBiZWxvdy4uLg0KDQo+ICsjZGVmaW5lIFZFX0dFVF9J
T19TSVpFKGV4aXRfcXVhbCnCoMKgwqDCoMKgICgoKGV4aXRfcXVhbCkgJiA3KSArIDEpDQo+ICsj
ZGVmaW5lIFZFX0dFVF9QT1JUX05VTShleGl0X3F1YWwpwqDCoMKgwqAgKChleGl0X3F1YWwpID4+
IDE2KQ0KPiArDQo+IMKgc3RhdGljIHN0cnVjdCB7DQo+IMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25l
ZCBpbnQgZ3BhX3dpZHRoOw0KPiDCoMKgwqDCoMKgwqDCoMKgdW5zaWduZWQgbG9uZyBhdHRyaWJ1
dGVzOw0KPiBAQCAtMjU2LDYgKzI2MCw2MSBAQCBpbnQgdGRnX2hhbmRsZV92aXJ0dWFsaXphdGlv
bl9leGNlcHRpb24oc3RydWN0IHB0X3JlZ3MgKnJlZ3MsDQo+IMKgwqDCoMKgwqDCoMKgwqByZXR1
cm4gcmV0Ow0KPiDCoH0NCj4gwqANCj4gKy8qDQo+ICsgKiBIYW5kbGUgZWFybHkgSU8sIG1haW5s
eSBmb3IgZWFybHkgcHJpbnRrcyBzZXJpYWwgb3V0cHV0Lg0KPiArICogVGhpcyBhdm9pZHMgYW55
dGhpbmcgdGhhdCBkb2Vzbid0IHdvcmsgZWFybHkgb24sIGxpa2UgdHJhY2luZw0KPiArICogb3Ig
cHJpbnRrcywgYnkgY2FsbGluZyB0aGUgbG93IGxldmVsIGZ1bmN0aW9ucyBkaXJlY3RseS4gQW55
DQo+ICsgKiBwcm9ibGVtcyBhcmUgaGFuZGxlZCBieSBmYWxsaW5nIGJhY2sgdG8gYSBzdGFuZGFy
ZCBlYXJseSBleGNlcHRpb24uDQo+ICsgKg0KPiArICogQXNzdW1lcyB0aGUgSU8gaW5zdHJ1Y3Rp
b24gd2FzIHVzaW5nIGF4LCB3aGljaCBpcyBlbmZvcmNlZA0KPiArICogYnkgdGhlIHN0YW5kYXJk
IGlvLmggbWFjcm9zLg0KPiArICovDQo+ICtzdGF0aWMgX19pbml0IGJvb2wgdGR4X2Vhcmx5X2lv
KHN0cnVjdCB2ZV9pbmZvICp2ZSwgc3RydWN0IHB0X3JlZ3MgKnJlZ3MpDQo+ICt7DQo+ICvCoMKg
wqDCoMKgwqDCoHN0cnVjdCB0ZHhfaHlwZXJjYWxsX291dHB1dCBvdXRoOw0KPiArwqDCoMKgwqDC
oMKgwqBpbnQgb3V0ID0gVkVfR0VUX0lPX1RZUEUodmUtPmV4aXRfcXVhbCk7DQo+ICvCoMKgwqDC
oMKgwqDCoGludCBzaXplID0gVkVfR0VUX0lPX1NJWkUodmUtPmV4aXRfcXVhbCk7DQo+ICvCoMKg
wqDCoMKgwqDCoGludCBwb3J0ID0gVkVfR0VUX1BPUlRfTlVNKHZlLT5leGl0X3F1YWwpOw0KPiAr
wqDCoMKgwqDCoMKgwqBpbnQgcmV0Ow0KPiArDQoNCi4uLmFuZCBpZiBAb3V0IGlzIGEgZmxhZyB0
aGVuIHRoZSBiZWxvdyBjYW4gYmUgc2ltcGxpZmllZCB0bzoNCg0KICAgICAgICByZXQgPSBfX3Rk
eF9oeXBlcmNhbGwoRVhJVF9SRUFTT05fSU9fSU5TVFJVQ1RJT04sIHNpemUsIG91dCwgcG9ydCwN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZ3MtPmF4LCAmb3V0aCk7DQogICAgICAg
IGlmICghb3V0ICYmICFyZXQpIHsNCiAgICAgICAgICAgICAgICB1NjQgbWFzayA9IEdFTk1BU0so
OCAqIHNpemUsIDApOw0KDQogICAgICAgICAgICAgICAgcmVncy0+YXggJj0gfm1hc2s7DQogICAg
ICAgICAgICAgICAgcmVncy0+YXggfD0gb3V0aC5yMTEgJiBtYXNrOw0KICAgICAgICB9DQoNCiAg
ICAgICAgcmV0dXJuICFyZXQ7DQoNCg0KV2l0aCB0aGUgYWJvdmUgZml4dXBzIGFuZCBjbGFyaWZp
Y2F0aW9ucyB5b3UgY2FuIGFkZDoNCg0KUmV2aWV3ZWQtYnk6IERhbiBXaWxsaWFtcyA8ZGFuLmou
d2lsbGlhbXNAaW50ZWwuY29tPg0KDQouLi5idXQgdGhlIGRpc2N1c3Npb24gaGVyZSBhYm91dCBm
dWxseSBmZWF0dXJlZCBsZWF2ZXMgbWUgY29uZnVzZWQNCmFib3V0IHRoZSBhcHByb2FjaCB0YWtl
biBpbiB0aGUgbmV4dCBwYXRjaC4NCg0KPiArwqDCoMKgwqDCoMKgwqBpZiAob3V0KSB7DQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSBfX3RkeF9oeXBlcmNhbGwoRVhJVF9S
RUFTT05fSU9fSU5TVFJVQ1RJT04sDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZSwgMSwgcG9ydCwN
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZWdzLT5heCwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmb3V0aCk7
DQo+ICvCoMKgwqDCoMKgwqDCoH0gZWxzZSB7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqB1NjQgbWFzayA9IEdFTk1BU0soOCAqIHNpemUsIDApOw0KPiArDQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSBfX3RkeF9oeXBlcmNhbGwoRVhJVF9SRUFTT05fSU9f
SU5TVFJVQ1RJT04sDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZSwgMCwgcG9ydCwNCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZWdzLT5heCwgJm91dGgpOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgaWYgKCFyZXQpIHsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByZWdzLT5heCAmPSB+bWFzazsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWdzLT5heCB8PSBvdXRoLnIxMSAmIG1hc2s7DQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9DQo+ICvCoMKgwqDCoMKgwqDCoH0NCj4gKw0K
PiArwqDCoMKgwqDCoMKgwqByZXR1cm4gIXJldDsNCj4gK30NCj4gKw0KPiArLyoNCj4gKyAqIEVh
cmx5ICNWRSBleGNlcHRpb24gaGFuZGxlci4gSnVzdCB1c2VkIHRvIGhhbmRsZSBwb3J0IElPcw0K
PiArICogZm9yIGVhcmx5X3ByaW50ay4gSWYgYW55dGhpbmcgZ29lcyB3cm9uZyBoYW5kbGUgaXQg
bGlrZQ0KPiArICogYSBub3JtYWwgZWFybHkgZXhjZXB0aW9uLg0KPiArICovDQo+ICtfX2luaXQg
Ym9vbCB0ZGdfZWFybHlfaGFuZGxlX3ZlKHN0cnVjdCBwdF9yZWdzICpyZWdzKQ0KPiArew0KPiAr
wqDCoMKgwqDCoMKgwqBzdHJ1Y3QgdmVfaW5mbyB2ZTsNCj4gKw0KPiArwqDCoMKgwqDCoMKgwqBp
ZiAodGRnX2dldF92ZV9pbmZvKCZ2ZSkpDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gZmFsc2U7DQo+ICsNCj4gK8KgwqDCoMKgwqDCoMKgaWYgKHZlLmV4aXRfcmVhc29u
ID09IEVYSVRfUkVBU09OX0lPX0lOU1RSVUNUSU9OKQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmV0dXJuIHRkeF9lYXJseV9pbygmdmUsIHJlZ3MpOw0KPiArDQo+ICvCoMKgwqDC
oMKgwqDCoHJldHVybiBmYWxzZTsNCj4gK30NCj4gKw0KPiDCoHZvaWQgX19pbml0IHRkeF9lYXJs
eV9pbml0KHZvaWQpDQo+IMKgew0KPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFjcHVpZF9oYXNfdGR4
X2d1ZXN0KCkpDQoNCg==
