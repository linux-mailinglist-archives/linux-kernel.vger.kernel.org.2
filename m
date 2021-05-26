Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB0B391B42
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 17:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbhEZPM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 11:12:26 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:49186 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235241AbhEZPMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 11:12:18 -0400
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 598874069E;
        Wed, 26 May 2021 15:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1622041845; bh=/Dd3lmvw65A6lUvb/8H+MDDLkj5tKq0LZ//mgkvUWQk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=NpkXLTijmSeOJGi1BJo55RYT1rRjc5HpOXEML7IqY+PVFCFA+G8XF7AioK+Uv2sZe
         iRjytIp2hFAVJfWEU2cvhsKgfMuNU1omdfKL1HkvbsLX0o7Dmkbln4O4lubYg8zVKS
         X0GIzjrn7yDfY9AIoTYAv5dBcAYy0jCpOPHemlOEbkZa/eKuPssJ3MdsNGL7tpeF7U
         r/uO44KCMCdkgqJsy5+xF7uO2yVsYjTtq3JazHoZzjykRgRWvW3pmsij+afLa9/Urt
         S2perxwKMTDGdhLtkGuradnNOv9hRS8Ak6Aq7KaOT+HT74ehdzuU19ZsmT6+ttyMtf
         R/n0FhJqAV16g==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 96677A0062;
        Wed, 26 May 2021 15:10:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 16AC2403C1;
        Wed, 26 May 2021 15:10:40 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="LC+tmByE";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUo/p1/rirE/q6r+vuougDvBGELbdYuGpterJ99vj+HA1+W55DD6WSU03X6zBZxovQnzf8/5dsejnc2ghK9zG6I8MT7eIMxQkhDXbfeK0BRqttcC46v1NKR+fJ2s/w3NaYHNcDRXxgisGNpwT6dRYWIoK1pE9p5iaWg23PzJIhcdfe32XVKx9w6tMhmUyxC96okO6V8raoU7FrI9InhGEJaXzCq7kzTDVMhk6JffRzauR8SKy1q/ADWxIKoRNRUNkiVHUFvmUDJmxuQyJbomrIkdcz9udqRDlIxzC/vZknpHm7hQKJm0z6xbfu92kiR4dMHsrFUY1BCK+oRHpfUCTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Dd3lmvw65A6lUvb/8H+MDDLkj5tKq0LZ//mgkvUWQk=;
 b=HhEDLLRyGCUND7DAz7jvxE1QBASjLHcnAz18zrcnqH6FYVCiegzS6vDtlXPSoEiS2rKUmoeqghM5Zl0wBDHF+2u+HKSC/z3pnDYnYj+FE3Ih/L++vlqOW6NIaEgRfzLjLfQ81lnbJ3O/08BoIqdFQ6muYp32VhapRUhYuSFM10B6NomMALFk5p6ABENc6J2K92wwd9oL/1VCoHIW0+hhRGHoPsnvXdwSx4Fpak4KMtywDXFSjNY40HxGY/uW/7EwSWPKqVEaKd0CPNLjAvQCrzDeX4as0TTXDyTTUYltO/nXZ5U4GZbFPUz7yfDItu1O/kmobD+Qvaib02VBr1e5lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Dd3lmvw65A6lUvb/8H+MDDLkj5tKq0LZ//mgkvUWQk=;
 b=LC+tmByEcn9dFoF6Um/DJN8PdNX7uwfxS24Yd25YJZX6urOhBlyW9rAXzUiBuHlP81bu+f6fVhjwslRKhsSolyf4mGpN75IDcGQW0gP71zNl1Vpz4rdInt2Dti5mjrqV8s5a/FcJvOrW95ZMV0+h+iY6ESWiWSlEty257rL3ie0=
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:39a::12)
 by DM4PR12MB5230.namprd12.prod.outlook.com (2603:10b6:5:399::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Wed, 26 May
 2021 15:10:39 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::bd1a:d4df:7c02:e458]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::bd1a:d4df:7c02:e458%6]) with mapi id 15.20.4129.036; Wed, 26 May 2021
 15:10:39 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthijs Kooijman <matthijs@stdin.nl>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 02/24] usb: dwc2: platform: Provide function name for
 'dwc2_check_core_version()'
Thread-Topic: [PATCH 02/24] usb: dwc2: platform: Provide function name for
 'dwc2_check_core_version()'
Thread-Index: AQHXUi8oGwYO18t1sU6WW0prH+k0uKr13jMA
Date:   Wed, 26 May 2021 15:10:39 +0000
Message-ID: <4ef3e120-5085-f7d0-d6c5-510c09393b18@synopsys.com>
References: <20210526130037.856068-1-lee.jones@linaro.org>
 <20210526130037.856068-3-lee.jones@linaro.org>
In-Reply-To: <20210526130037.856068-3-lee.jones@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [37.252.93.215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef0c968f-2fca-4352-c1b3-08d920586c41
x-ms-traffictypediagnostic: DM4PR12MB5230:
x-microsoft-antispam-prvs: <DM4PR12MB523091080599326451E3FEDFA7249@DM4PR12MB5230.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r/clXOMvySUoCgGZ6gqWLASkTUaI+WyM/QeZFmDeHsPjCTODk+zpD1u4qAun3mXqxYb7VQWtHvKLZMn6BA2mqphw90b/Oc5Medmu3AGKJRVWQznh8CPF6YmUi49Ge6QOP/msd2+uIE87S3yOGlWN+DuM/G9KmLu3nBQjRPiyBR7hJ5v86V9BAeRUn4ZfRQ6kOnyXqZkImFFDo6Qvz4miBUS0RNpMnjoj+d+R1hzx6ESBld+HHDMrNoW7dQWDsLrepU7yNX+AQw48VkNPkCEd1Nd9pKc9xnIizvAWkjijvJ2oWT2bC0FO0buThYn4pDMoc/fI1rdfUtxbGeoEaLrL+EPkpI+Uyl09dDgpbhGEfbnQtgkkGqPfhCblV7kJBz9gZA/9/nA7OH4U33QdXob18IodEXh2RMBAF2a+u3KgsMpu63JlVjz6QSU7LZWAVW/UzSCYFtsjEsoWiMK2pYdLdhsqZTORegzskcvV2Egq8NEsbzIqmXPpYueoIYVW8jRDisJgCuejZIiyvBHVeVamhd6eQuHcWObttEBCTZfQb+wZoLXsTeIxNm16fjIdmTU0nwguAynYZpHyfszm/0tEGmGQCtVHzDsXBga4oFaNAaG1eMygh6dQy6vQjtaMuhLCQ9y0zT867EywxvrEHhtD55HeOsEsF2EXW3opKLREJw7xKZniWS8ksivANQ8W0YmN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(39860400002)(376002)(396003)(478600001)(83380400001)(2906002)(86362001)(186003)(66476007)(6486002)(316002)(2616005)(66946007)(64756008)(76116006)(5660300002)(91956017)(31696002)(31686004)(6512007)(66446008)(66556008)(8676002)(6916009)(53546011)(71200400001)(54906003)(4326008)(38100700002)(8936002)(36756003)(4744005)(122000001)(6506007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Y0FPejlTSzdHaG81d0ZSK0NUbDVubnE1STVnc1BYUGZ5VTZOb2dCcDBTWjIz?=
 =?utf-8?B?OHJzWnRKeFhORGVpM0t6QmIvYjBvR2dwK2N5SHNzUUJxSXNEVDB6QXNMTFFY?=
 =?utf-8?B?dU5uMk5EdkhJR2Y0YnRlRmtONDl3c2xXbDcrV3NLemdvMTEzS1JWMzdIa1J5?=
 =?utf-8?B?VjgxSjIrNTh6MnpCSHc5TWdRQnJtZHdxbHpaU1pQNkJmUTdYcldRVlhYV3pw?=
 =?utf-8?B?NDBMeHgySkpRUkN5bVd1ZWtPdGo4aDlUYVRIZHR6azBOQWQ3aTBRcUM1NGYz?=
 =?utf-8?B?TnAzeHg3WVlVd3RNNUtEdVpPSUdEMTZXaTBJR1N5b0NFdXV4c3VJcmxrVVBv?=
 =?utf-8?B?eHhGMUdVSk1jRDVTcjNOZnNlVzRyc2twQ1lOYXBycFBBOEdQbWpWV2p0d1cw?=
 =?utf-8?B?bDFTKzJmVUVHZGJ4eHhqelFwV25VZGIzT0tqdUFWWUN1RU4zWXM1enB6SnRW?=
 =?utf-8?B?WXV0WVRBbEJvSTV6cDZvK05Ga0R5L1IzZ2pkQm9WaWZGNXZ4RUJUL0M2dTFn?=
 =?utf-8?B?eHFocFA4YThiZUVpazFQSWY5WW9xNWFJcU9UYVFTNWRiT20zdEFCNEhSalgy?=
 =?utf-8?B?d2pWdURQeWNwNWQ2OUU4NXNyQmQxVUJCV1BiTUVEenE1SGxLOGY3b0g1N3BN?=
 =?utf-8?B?OE85d1FySDFqNC9jRVF0YTRrQVN0TkQySGRFZGkvOU9hNlpwMGordG44VTBj?=
 =?utf-8?B?MitPcGcxVmZpaVFrWTFzZUhMY3I5Qm1HYkUxU1kybmttMlVJbGgyN2J6RTBx?=
 =?utf-8?B?bExxVFBNaVRMeXBucGV2OVhPeFJuZnBlUE1FSUE4Tll6eHRTVlVITE1kMWJz?=
 =?utf-8?B?TUpWdHozbzNtc0RxUjg3bnBTUmh0STBpVUdFemV3OEZOSWdiR0JadmpSMGhE?=
 =?utf-8?B?UHoydkJEanpjaHFhWFF2SVN0VTY5aUxhZFFvSVE4SkpvN2UxdmZLUS9MN2R1?=
 =?utf-8?B?RHpaVDBkMWR5eXgvQWE4ajYydFVKSm40SXlPSk1yalJGNjRCRXlEbXAyN1pJ?=
 =?utf-8?B?VnRWSWhva1hiSkJQcDdnd3JCeE1ibzlJc1NXZ1ZLY3lseEl6dWpQclo2NnYr?=
 =?utf-8?B?VVUzRXUxNjlJWGtPdmtnVFhoYmdSQVV3ZUdQM3UydmhweDB3TDlGVEYzc1Iw?=
 =?utf-8?B?anozTWU4Z3FVUnVGY095LzdWSGhNVVcxblZ5b0FMR0hwK0NjUjhMN1BnOGIr?=
 =?utf-8?B?V1NPbUM2WDVBQTd3SkxzM1czTU9DN3AvbGQ0OUlWbk52UDZBazRMelBxc3Rj?=
 =?utf-8?B?bVZRSmJGWk93ejNUQmJMWVJBRGtBWTlSK256QndHNDBUbEpXL3h2clgxNmVU?=
 =?utf-8?B?QkpWS3BVZDA3UWZhMkRQQ3VvdXUwK1g5MDZMRDcrVDJkcUFQNmZXVjllUDBS?=
 =?utf-8?B?NTl1bVlGc2hKVU5JOWpKTEJjb2hYR3M2aXZKNDNTUzg3cGpjQ1ArZGs3d05x?=
 =?utf-8?B?VzlJcmZoUVpKaVVMb0doS0MyWFdPUm4zOHBwOHNmSUJ6TFBPZDRUeG5KazFI?=
 =?utf-8?B?ZzVmWVIrN3U5bU4zMG9VNSt5aytTcmxIUHp1ckJUOEZTWFUxNE1JUm92YWdm?=
 =?utf-8?B?S2JRK01aVi96UTN3RHN5MDZyMEE2amE5QkVHNUd1eGtYUHBBU2FuT2FUc3lm?=
 =?utf-8?B?S0NYZTl6VHhrRmRWVklIdGNib09jUlZWYlFGWHVWWVlpajRoT2tDSDN2ZnRx?=
 =?utf-8?B?eHUzQTFWVUg0TEdtbTgwd1c3YURqZ3NUZlp1aVVsbnZXWVVWYlBuTjhGWkdZ?=
 =?utf-8?Q?osyQNyi2L6j8quaDGA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <91EFD88010172A43B5A869C0972816C1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0c968f-2fca-4352-c1b3-08d920586c41
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 15:10:39.4557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DKI4IBJW/dDBv2RqxMH7Kmy809e+BYiDlpq1OanCIVmcaW6tjbX3adYN8Rr62BldIBU7C4BIrnxbcele82iKVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5230
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yNi8yMDIxIDU6MDAgUE0sIExlZSBKb25lcyB3cm90ZToNCj4gRml4ZXMgdGhlIGZvbGxv
d2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6DQo+IA0KPiAgIGRyaXZlcnMvdXNiL2R3
YzIvcGxhdGZvcm0uYzo0MTE6IHdhcm5pbmc6IFRoaXMgY29tbWVudCBzdGFydHMgd2l0aCAnLyoq
JywgYnV0IGlzbid0IGEga2VybmVsLWRvYyBjb21tZW50LiBSZWZlciBEb2N1bWVudGF0aW9uL2Rv
Yy1ndWlkZS9rZXJuZWwtZG9jLnJzdA0KPiANCj4gQ2M6IE1pbmFzIEhhcnV0eXVueWFuIDxobWlu
YXNAc3lub3BzeXMuY29tPg0KPiBDYzogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZz4NCj4gQ2M6IFBoaWxpcHAgWmFiZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXgu
ZGU+DQo+IENjOiBMaWFtIEdpcmR3b29kIDxsZ2lyZHdvb2RAZ21haWwuY29tPg0KPiBDYzogTWFy
ayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPg0KPiBDYzogTWF0dGhpanMgS29vaWptYW4gPG1h
dHRoaWpzQHN0ZGluLm5sPg0KPiBDYzogbGludXgtdXNiQHZnZXIua2VybmVsLm9yZw0KPiBTaWdu
ZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPg0KDQoNCkFja2VkLWJ5
OiBNaW5hcyBIYXJ1dHl1bnlhbiA8TWluYXMuSGFydXR5dW55YW5Ac3lub3BzeXMuY29tPg0KDQoN
Cj4gLS0tDQo+ICAgZHJpdmVycy91c2IvZHdjMi9wbGF0Zm9ybS5jIHwgMiArLQ0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdXNiL2R3YzIvcGxhdGZvcm0uYyBiL2RyaXZlcnMvdXNiL2R3YzIvcGxhdGZv
cm0uYw0KPiBpbmRleCA1MjBhMGJlZWY3N2NhLi5jOGYxOGYzYmE5ZTM1IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3VzYi9kd2MyL3BsYXRmb3JtLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9w
bGF0Zm9ybS5jDQo+IEBAIC00MDgsNyArNDA4LDcgQEAgc3RhdGljIGJvb2wgZHdjMl9jaGVja19j
b3JlX2VuZGlhbm5lc3Moc3RydWN0IGR3YzJfaHNvdGcgKmhzb3RnKQ0KPiAgIH0NCj4gICANCj4g
ICAvKioNCj4gLSAqIENoZWNrIGNvcmUgdmVyc2lvbg0KPiArICogZHdjMl9jaGVja19jb3JlX3Zl
cnNpb24oKSAtIENoZWNrIGNvcmUgdmVyc2lvbg0KPiAgICAqDQo+ICAgICogQGhzb3RnOiBQcm9n
cmFtbWluZyB2aWV3IG9mIHRoZSBEV0Nfb3RnIGNvbnRyb2xsZXINCj4gICAgKg0KPiANCg0K
