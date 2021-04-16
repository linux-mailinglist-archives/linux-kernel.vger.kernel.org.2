Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A550D361A51
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 09:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbhDPHGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 03:06:02 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:57230 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229555AbhDPHF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 03:05:59 -0400
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 300A2C06A8;
        Fri, 16 Apr 2021 07:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618556735; bh=jwUgrR8qyn5df/TWdimEx4B9AAcWZrcnnoLoKBkiSKE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=YKTXdNgiWgrLG6Q+mSLfG0ta6oF5USpIIKCjza7tjdHNAorzynohgetNjQr2SWoCl
         98ffeAg0BwaouCCfW+Eu6rSmsXbhFVPre+46odCs8LTufe2mkA2JhHP8DBR1KGasWW
         2uNvH6nGrkSzGpwGOV/vRM3rjX4HAvvE5qvUgnZ1UGDlNKLut3ybpQ2PLj2EWDf942
         qtAoO2QVhN8i25Hfp4Wt9W3TiWCTM2Ktn89mHw/0La3GLaxrl4JKBukvNwriezTJJU
         6AY+MAxz1S9fp2soA2rvW2fzHIi6unB4pVpsZsx5fzVp3xEY3Xgodh77GMmhzVCvXZ
         iUw4S7elunweg==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id E1821A00B8;
        Fri, 16 Apr 2021 07:05:34 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2175.outbound.protection.outlook.com [104.47.73.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 199BE80091;
        Fri, 16 Apr 2021 07:05:34 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=arturp@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="JbgtoWiN";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1+WdTFiPeQCufwJYFX/uFosP1aqseCCywynHdbQhpm6Yzf8Y2ClhDSkAblW8q+OMUJ8XrnUNAEeZKFWD7qMJAKPIc/CgjN+daDv3LsowOftJ+ZonQnq7ifJIoVCBc+i0oJOLsbiBa6gbfUFd1iDHNfuLJ7M8tZ3aAnfGhWiA3IsxFcilvJXHBFayBx5KsLPp2DCk1Msv55j+dU+J4wZ587EJFFFqyBS5PjCtFEA8RYQTwcVYEAE8ycRQx+g0iBkglSh2LpRzRFE6SYbzptnCRTHQ11wycEol2i6bFwXSJmICKhccFdKPbvKbadkJJR3JXsGDnz68epgdqwKhOXGvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwUgrR8qyn5df/TWdimEx4B9AAcWZrcnnoLoKBkiSKE=;
 b=lflk7gQgKATeVUU2C7DDqshWe8uADjQ00zzZ1arq4xqgGF0rfi/n35nMNNW2+8j29mHYTBLpgWpciYnE2lZgMWvrsDFN50mmoNY+dKa+hbbrDD3iKHrIUKiT4atAD2LsL6fzlFEQa1rTPUHbimq0GNO7SxBKBcwtgfFQ6JJ/Qu7vQNfMZlFx7UMbcGz6Wif6fx5aRb0LazwdjhjUaZiA+I8ERaOq4+OPQKEdw7jGwzhvregGKYtPuOCM+/xYle6LkQs3Mn3z+V2jpqNevKc/WQYN95sYB7+oa/nyjdKJWWviBSQo0fburJOGT9VinquFe3JvO4Pwo7Rj3iCO4YziVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwUgrR8qyn5df/TWdimEx4B9AAcWZrcnnoLoKBkiSKE=;
 b=JbgtoWiN1minYYqsEGMQOLv8TZWntDRvgPSs9ct36iofRsZCIN6KQwiHhgRwfCL38rzLdj8RCfdhRlOMmh6j7mPd3QQL0NmkIttFPp1tcPxDnqvFqHkBmV2dWaIk7hdtLhnZFV0HKIYOiVXh5CR1CgzqTRGD4y5XXP+HXlAZ78k=
Received: from CH0PR12MB5265.namprd12.prod.outlook.com (2603:10b6:610:d0::22)
 by CH0PR12MB5105.namprd12.prod.outlook.com (2603:10b6:610:bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Fri, 16 Apr
 2021 07:05:32 +0000
Received: from CH0PR12MB5265.namprd12.prod.outlook.com
 ([fe80::b1a0:f306:3b5a:7f0c]) by CH0PR12MB5265.namprd12.prod.outlook.com
 ([fe80::b1a0:f306:3b5a:7f0c%7]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 07:05:32 +0000
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Youn <John.Youn@synopsys.com>
Subject: Re: [PATCH 10/15] usb: dwc2: Allow exit hibernation in urb enqueue
Thread-Topic: [PATCH 10/15] usb: dwc2: Allow exit hibernation in urb enqueue
Thread-Index: AQHXMbniubPxts+cBE6E3sPvdZnhn6q1S2SAgAFX/ICAABbxAA==
Date:   Fri, 16 Apr 2021 07:05:31 +0000
Message-ID: <54b8ce81-f308-d3dc-c1b5-357b62594c6c@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
 <65daa916b29e0009083702cb4584c8274e58ddac.1618464534.git.Arthur.Petrosyan@synopsys.com>
 <8b16e1ea-b8bb-b3fd-29ce-a997579f92eb@gmail.com>
 <d0bf6d03-8ef6-9eca-9736-eb7bac823a7b@synopsys.com>
In-Reply-To: <d0bf6d03-8ef6-9eca-9736-eb7bac823a7b@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [46.162.196.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a8d4af1-21a6-410f-91d1-08d900a60656
x-ms-traffictypediagnostic: CH0PR12MB5105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5105F22BF45F3DE442CEA3B0A74C9@CH0PR12MB5105.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F7Wypnnj08OIQ8Unann6InSdKaogv2WCCX4bBFl+5PJH4UBT8plunF5fzB/0ylum2QYw1Ih6uSNcJAb3mCl8vQCHcYJb4L9QWGqJFHINKgO40v9CemGAMX3b/bb3iEjDBDt4I7bCygRi/OcHd1piXkPhXL0zIWz2xJk/KjU03DN2f14hqsqX0CSseM+nI3gFjBsx9muNr9VCzgrUXoEJspbrlhfx1yR0ZKfjINjm8yPkMBmUvcW3Gfs+0GqB1QZB60X+kLRUloy2FmE849sNrc0C/83h10b/8ICsvG00Ob5LRB2+I/z1SkxqsQK7fGSnfLcLJfAdaqCg5zXvn6P5pu/NEf6nF/tVmoa9kFrIAhFT2uYmlH2jnhISccKj1g/+g+Ko5XUUoR3MexVAus/E+VFOnRBndTWAeqHVaeryCLXHQ3TjITbTLIqg9azAgP+g9uUMXbAJ/TmMRaMyuzZ9zoUwh0Tqwq4aKdtCTdD+iEWCuAt86lNtHhW1o/hMXAhaGGhcXHrprY429AQ12+oXoyWQHM/XiFAC1BgrTbG0Jps8pnhs4WhbIko037MRI/tdqmxBXXOAsA0SOG6O/v/6ftFTifVz5r1fRaLkKO/cdlYLKQBDiQTFkVUYe15qAsD0PPWYjf59w9b12r3mawiLQtGuMvq/Gr4gB2xqy1h9dms=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(136003)(376002)(396003)(186003)(26005)(316002)(6506007)(53546011)(107886003)(110136005)(2616005)(31696002)(36756003)(66556008)(91956017)(76116006)(38100700002)(66446008)(83380400001)(2906002)(4326008)(71200400001)(66946007)(64756008)(5660300002)(86362001)(478600001)(66476007)(122000001)(31686004)(8936002)(6486002)(6512007)(8676002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YS9PSTl4Si85dDh4RkZYOFJJZEFQWGF3VCtXMGQvSVovWkZyS1B1Z0EvYUEw?=
 =?utf-8?B?TGQwVDFEZE1OT0JkcXRtU2tnem0wKyt4VC9MOEUzbjBPR2pLWVAzSHp0WmdH?=
 =?utf-8?B?aVhReFBuZjMwQ3I3TTRqQm53NFJsSGRwU3lPNlNEajhWYkdkVk5QWk0wSVlh?=
 =?utf-8?B?TTFNc3hwWDZWakxUUHN3OTlOTldHMUpYcTFoc2ZwNWhaSS82cTBGUDFqcGw5?=
 =?utf-8?B?TDMrRkdPU2NtS1FHTjZtSXQ0TFlKSURhTW5kU1BHcndPM2hrbVJtVEwvN3ZH?=
 =?utf-8?B?NkVrYTBYVUtNdC81TEs2MWlNdk54SUF6Z2xwSlJmU3hicXJuUG1FWWpVd3M3?=
 =?utf-8?B?TWU2ZVhZZmgrY3BmaGRBSUtlZ1ZhR29acHJuU3Q4aUNhN08vREkxZ09EYXlj?=
 =?utf-8?B?dUFrUFpYVXdtLzlWK3NQRjRSWk5nTmRGcEJjV2VyZTB2QmgrZjhCZW8rNnE0?=
 =?utf-8?B?NUswcjBTNkxCQ0VRQkpDMi96SkRkUUJQcmV3S3Q1NnMrUEk1NC9yNEFYM2tX?=
 =?utf-8?B?QjRwVmpsN3RGRVVYNFFQQ2s5SS84WFk3bWI0Z2VKZ200Y0UxS2w3L3N4TFRv?=
 =?utf-8?B?VVJLK3dYVTRCQmdhbDdESjZ0NlZtWTVkOVRDMW9JVDZqV2tkY21uNExqRGdp?=
 =?utf-8?B?MUh4MThQZ2ttQzlocGc1VDJsQXBCTGRqWkZ1VGdacDdKMkc2MGNUOXJoUlkx?=
 =?utf-8?B?ajUyclNUVk5sdmtGUGtRK1BwT1BzSWFGWU81RDVmZmRmQklRQ2J6S0kwU0Rt?=
 =?utf-8?B?Mm41dk9RQ08weUREY3BZa3lBVzRSRmhFeDZNMkx0RDMrK0tVNmdhcm1NVEJu?=
 =?utf-8?B?bzJyQjdldkVxNVpDbzhnUjVNN3RSZjFDYXRqWTFmc1pwZ0JvTzNMSDJkQVhH?=
 =?utf-8?B?Rm5haWRBTzdhUzNNSGpFVEhyUnVmWHhnVlN2c2xHRU42OU5ubkFKZW40K3dV?=
 =?utf-8?B?emc4TGMwR3prRlNGekYvOTVnM0Joenk1U0gxc0R0akZIdHFndERibkNTSEYw?=
 =?utf-8?B?eEZPaXlwZGtkMWhUU3RJMEhBN0grZG1RSG11cjdwZnFmcVdWQTlNT2NVVUxE?=
 =?utf-8?B?RUs0bFFhaFVwRkhtS2tPSzN0UC9ad2Myd3FqbTdHYmczUDRTZlZpbW1MZnJC?=
 =?utf-8?B?REhmZ2NDUUZsd3FkRTQ4YXAzZWs1QWcwK0N1ZTJhbGFuSmxLdkFwNWdPT291?=
 =?utf-8?B?aXVtTHNLY2ZXbHp1UkROUFpKU0JCdDA5SDJCR0poY1ZUdmw5UGx0blIrbFNC?=
 =?utf-8?B?S1k0V05DSmkxSEwwOUZpNHl0YXJzLzA2Vm10TU9vQklYZU1yNlpjWDFjSVln?=
 =?utf-8?B?VDZPaU9NZkVTNUxLaW9QbjZMRVRDWTJpckMyUER6aFE3bzNMM29oQWszY1dP?=
 =?utf-8?B?SEY0TzViSjAveFNKejFnS2ZLVU9lSnBYSk5CbjdkdTdhMWRJZXVZSTZSaE1G?=
 =?utf-8?B?eHB1cnlOeXIyS3Q2TjJHWjdTcDUyYUNBeXpkRlhYWnRnSGpSQzBiaHNpeUVS?=
 =?utf-8?B?Qm5LZEhTeVNlYkg2SG91RURlR1l6RUJhdEdxSE1Pa3RpbTBEMldZVFo4aHh4?=
 =?utf-8?B?eTNkN2lueXJwTDlZZVZwRlBLcU15RjIrbG01T1l4emNPYyt4N2FvY21jQXAy?=
 =?utf-8?B?ZDQ1b3dUQ01YMFVZVDdPbGhyc0s0QkpPTkVjMlVYZFl0QkRidHVBNnBQcVMy?=
 =?utf-8?B?N0pIOWRPQkR4VkZRVUxxMkcxYnJxb01FdDlIWHhHL2NxR1lWcENieWJvM1JO?=
 =?utf-8?Q?NpQikRqX/Vq/AXMEvQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E84F7B5F031714086A610D1A30FA03A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8d4af1-21a6-410f-91d1-08d900a60656
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 07:05:31.9597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YIJeJEHEBVx4JT2S5bRZ4yaU97Zg9mw4bcJ54ZvfXmfM1jZNJhM2FQ+bV8qEwhsvVowOwtwHG6dHOARsISN6qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2VyZ2VpLA0KDQpPbiA0LzE2LzIwMjEgMDk6NDMsIEFydHVyIFBldHJvc3lhbiB3cm90ZToN
Cj4gSGkgU2VyZ2VpLA0KPiANCj4gT24gNC8xNS8yMDIxIDEzOjEyLCBTZXJnZWkgU2h0eWx5b3Yg
d3JvdGU6DQo+PiBPbiAxNS4wNC4yMDIxIDg6NDAsIEFydHVyIFBldHJvc3lhbiB3cm90ZToNCj4+
DQo+Pj4gV2hlbiBjb3JlIGlzIGluIGhpYmVybmF0aW9uIHN0YXRlIGFuZCBhbiBleHRlcm5hbA0K
Pj4+IGh1YiBpcyBjb25uZWN0ZWQsIHVwcGVyIGxheWVyIHNlbmRzIFVSQiBlbnF1ZXVlIHJlcXVl
c3QsDQo+Pj4gd2hpY2ggcmVzdWx0cyBpbiBwb3J0IHJlc2V0IGlzc3VlLg0KPj4+DQo+Pj4gLSBB
ZGRlZCBleGl0IGZyb20gaGliZXJuYXRpb24gc3RhdGUgdG8gYXZvaWQgcG9ydA0KPj4+IHJlc2V0
IGlzc3VlIGFuZCBwcm9jZXNzIHVwcGVyIGxheWVyIHJlcXVlc3QgcHJvcGVybHkuDQo+Pj4NCj4+
PiBTaWduZWQtb2ZmLWJ5OiBBcnR1ciBQZXRyb3N5YW4gPEFydGh1ci5QZXRyb3N5YW5Ac3lub3Bz
eXMuY29tPg0KPj4+IC0tLQ0KPj4+ICAgICBkcml2ZXJzL3VzYi9kd2MyL2hjZC5jIHwgMTcgKysr
KysrKysrKysrKysrKysNCj4+PiAgICAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykN
Cj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MyL2hjZC5jIGIvZHJpdmVycy91
c2IvZHdjMi9oY2QuYw0KPj4+IGluZGV4IGNjOWFkNmNmMDJkOS4uM2IwM2IyZDczYWFhIDEwMDY0
NA0KPj4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzIvaGNkLmMNCj4+PiArKysgYi9kcml2ZXJzL3Vz
Yi9kd2MyL2hjZC5jDQo+Pj4gQEAgLTQ2MzEsMTIgKzQ2MzEsMjkgQEAgc3RhdGljIGludCBfZHdj
Ml9oY2RfdXJiX2VucXVldWUoc3RydWN0IHVzYl9oY2QgKmhjZCwgc3RydWN0IHVyYiAqdXJiLA0K
Pj4+ICAgICAJc3RydWN0IGR3YzJfcWggKnFoOw0KPj4+ICAgICAJYm9vbCBxaF9hbGxvY2F0ZWQg
PSBmYWxzZTsNCj4+PiAgICAgCXN0cnVjdCBkd2MyX3F0ZCAqcXRkOw0KPj4+ICsJc3RydWN0IGR3
YzJfZ3JlZ3NfYmFja3VwICpncjsNCj4+PiArDQo+Pj4gKwlnciA9ICZoc290Zy0+Z3JfYmFja3Vw
Ow0KPj4+ICAgICANCj4+PiAgICAgCWlmIChkYmdfdXJiKHVyYikpIHsNCj4+PiAgICAgCQlkZXZf
dmRiZyhoc290Zy0+ZGV2LCAiRFdDIE9URyBIQ0QgVVJCIEVucXVldWVcbiIpOw0KPj4+ICAgICAJ
CWR3YzJfZHVtcF91cmJfaW5mbyhoY2QsIHVyYiwgInVyYl9lbnF1ZXVlIik7DQo+Pj4gICAgIAl9
DQo+Pj4gICAgIA0KPj4+ICsJaWYgKGhzb3RnLT5oaWJlcm5hdGVkKSB7DQo+Pj4gKwkJaWYgKGdy
LT5nb3RnY3RsICYgR09UR0NUTF9DVVJNT0RFX0hPU1QpIHsNCj4+PiArCQkJcmV0dmFsID0gZHdj
Ml9leGl0X2hpYmVybmF0aW9uKGhzb3RnLCAwLCAwLCAxKTsNCj4+PiArCQkJaWYgKHJldHZhbCkN
Cj4+PiArCQkJCWRldl9lcnIoaHNvdGctPmRldiwNCj4+PiArCQkJCQkiZXhpdCBoaWJlcm5hdGlv
biBmYWlsZWQuXG4iKTsNCj4+PiArCQl9IGVsc2Ugew0KPj4+ICsJCQlyZXR2YWwgPSBkd2MyX2V4
aXRfaGliZXJuYXRpb24oaHNvdGcsIDAsIDAsIDApOw0KPj4+ICsJCQlpZiAocmV0dmFsKQ0KPj4+
ICsJCQkJZGV2X2Vycihoc290Zy0+ZGV2LA0KPj4+ICsJCQkJCSJleGl0IGhpYmVybmF0aW9uIGZh
aWxlZC5cbiIpOw0KPj4NCj4+ICAgICAgIFdoeSBub3QgcHV0IHRoZXNlIGlkZW50aWNhbCAqaWYq
cyBvdXRzaWRlIHRoZSB0aGUgb3V0ZXIgKmlmKj8NCj4+DQo+IFdlbGwgdGhlIHJlYXNvbiB0aGF0
IHRoZSBjb25kaXRpb25zIGFyZSBpbXBsZW1lbnRlZCBsaWtlIHRoZXkgYXJlLCBpcw0KPiB0aGF0
IHRoZSBpbm5lciBpZiBjaGVja3Mgd2hldGhlciBjb3JlIG9wZXJhdGVzIGluIGhvc3QgbW9kZSBv
ciBkZXZpY2UNCj4gbW9kZSBhbmQgdGhlIG91dHNpZGUgaWYgY2hlY2tzIGlmIHRoZSBjb3JlIGlz
IGhpYmVybmF0ZWQgb3Igbm90Lg0KPiANCj4gU28gbm93IGltYWdpbmUgdGhhdCB0aGUgaWZzIGFy
ZSBjb21iaW5lZCBhbmQgY29yZSBpcyBub3QgaGliZXJuYXRlZCBidXQNCj4gdGhlIG9wZXJhdGlv
bmFsIG1vZGUgb2YgdGhlIGRyaXZlciBpcyBsZXQncyBzYXkgZ2FkZ2V0LiBJZiB0aGUgY2FzZSBp
cw0KPiBzdWNoIHRoZW4gdGhlIGRyaXZlciB3aWxsIHRyeSB0byBleGl0IGZyb20gZ2FkZ2V0IGhp
YmVybmF0aW9uIGJlY2F1c2Ugb2YNCj4gdGhlIGVsc2UgY29uZGl0aW9uIGFzIHRoZSBpZiBjb25k
aXRpb24gd2lsbCBiZSBmYWxzZSBhZ2FpbiBiZWNhdXNlIGNvcmUNCj4gaXMgbm90IGhpYmVybmF0
ZWQuIEFzIGEgcmVzdWx0IGlmIHdlIGNvbWJpbmUgdGhlIG91dHNpZGUgYW5kIGlubmVyIGlmcw0K
PiB0aGVuIGl0IHdpbGwgdHJ5IHRvIGV4aXQgZnJvbSBnYWRnZXQgaGliZXJuYXRpb24gYnV0IGNv
cmUgaXMgbm90DQo+IGhpYmVybmF0ZWQgYW5kIHRoYXQgd291bGQgYmUgYW4gaXNzdWUuDQo+IA0K
DQpTb3JyeSBJIGdvdCB5b3VyIHBvaW50IHdyb25nIHRoZXJlLiBZb3UgbWVhbnQgdGhlIGlmcyBm
b3IgZGV2X2VycigpLg0KVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3IEkgd2lsbCB1cGRhdGUgdGhl
bS4NCg0KPiANCj4+DQo+Pj4gKwkJfQ0KPj4+ICsJfQ0KPj4+ICsNCj4+PiAgICAgCWlmIChoc290
Zy0+aW5fcHBkKSB7DQo+Pj4gICAgIAkJcmV0dmFsID0gZHdjMl9leGl0X3BhcnRpYWxfcG93ZXJf
ZG93bihoc290ZywgMCwgdHJ1ZSk7DQo+Pj4gICAgIAkJaWYgKHJldHZhbCkNCj4+DQo+PiBNQlIs
IFNlcmdlaQ0KPj4NCj4gDQo+IFJlZ2FyZHMsDQo+IEFydHVyDQo+IA0K
