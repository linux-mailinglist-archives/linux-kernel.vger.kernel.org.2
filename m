Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581F33C215F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 11:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhGIJXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 05:23:10 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:5537 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhGIJXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 05:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1625822425; x=1657358425;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KSQt7jxIDFHK/YrrWEl7zS6TgiAF6f6SSi5UHqVd43o=;
  b=oOK1+yClVU0CWh5MadL43pS8W5ZDYOuqu1K42vjUJhHUkemwgG0nmSzL
   QoxX+FLt9Nd+PP/1YtCldgdVPy87LJRtWem2LA7rih4MxU9TAD39zr7iE
   JJRmSZKhT0ftJl22oxBG7+TmG3x82Azeaf1TrdaAiM59tWarWn0c5mynG
   bAeM/6fnCIw20hKBX2wyI5ROD6uv9QwTHfstOBt37/rn/Stquc32aMbaf
   gvXd7f3s979PkNUzoHN4hUc2E6BSF7CT8ngGJwQTSagW8+fh0PJln5Nwc
   Q+4GTZjwxRU3eLt9CArdkJI6w/s8aRhmc8e5GaFMoMV/qCDFYCTcqrtBs
   A==;
IronPort-SDR: aBrAGdyevAllBOBWX5KigmaUROmb36gsGWQB6E+kZOswg1VCK0EhgALVrfgVYWGAWRB0C0UgBK
 aM5hMsiB4U7tz39mh7U/zDWQhV9b1gK9opYMPifguDvGN4GFOFaQEUGTWm/7fskXXFsLPi/3OL
 03uS7A85znPrSMk7WA9BjKOiDTFgvvp7EvmzyIBMLpR29CD4xYCAn+yTf+7rUBTxjNW0t65Job
 QAB4iUa1/xb/uKXjPF5lHZHkQeYAfPgV1MfqRl83BeAXWxd7CcevbvjtdcBC370pqye3PGXbbm
 Iqs=
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="121491786"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2021 02:20:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Jul 2021 02:20:08 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Fri, 9 Jul 2021 02:20:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bz+Yg4b8dM7QA/JD/EU27wX9RuiwMcA5cKLinXrxvKVPwxVWJ00thWyWTrTzYXZWddPd+g2PwTj7EBseb1lKbTOyTFtbN3Ghi3dyw8xauEAI2FhaCofCnU1fpB1JHowtkrgFmVN7LXqacDDVrZEZ0nRHsrLrJ6Q97tkAZke3LzGKtJadlOmzj1xHtqLmoOhT48cOHSInZYjITIG0jGVeTbrk7yd5am5RWJ4dZMnagn3m6/jXdqD7O3Fvt9fsQBjHQA8l7bfn3XTpYEfxmw4WakwQLWj1VgI8KtPxBZn1imh9E4vhDZ/OQQrXiLC4uiaxPn1OZ9obthdaHs85PO74Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSQt7jxIDFHK/YrrWEl7zS6TgiAF6f6SSi5UHqVd43o=;
 b=cIon0EexS78RK2Mi3VrGFSss/TXZyKvH6CiXuAroyuQpI/1xHFpFkJcojAV+p4+h5nNaqKt/zjhwstG+m5PMwPHFenSEuWCszWws8HKsyFOCeWyoWRJOIPrk9MPp7hqyA2nTSBUw6OZJvMc/s87TN2jKC26QLBwsVo2v5Y7pvCxxn1AlKURLelzM38/Ga2xMXdENOvrT1A+kHFax01jgL5QfLs1fB9PUAJmjhkPYEbNk9NwcTjI0laQD6+IQjfrxecNvKnlURChWhGucICWZAAjJprBbIuv1dDGRFnXcMGOgOiS8yi+r3f9pn1k+ZQ5eqt/cgKDrt6SOAasS3r29sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSQt7jxIDFHK/YrrWEl7zS6TgiAF6f6SSi5UHqVd43o=;
 b=YLX8VDKw4nZbynekmIx1lVAy3QrYPKH88YQgE1/mrMPhN1uP25o6IxnZrWvlAXqrrFxVcWYq1smJFd633ntRqZBOSn3Eq4q2gacbgLhywubuhg9iVLAlNCgRwm5PLMBYkNQ8uYqAk76lEs2cbnDj+TK7tf5PEJ/YtXBASO4eRyg=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by CO1PR11MB4882.namprd11.prod.outlook.com (2603:10b6:303:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Fri, 9 Jul
 2021 09:20:06 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::7476:4bab:7cdb:8957]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::7476:4bab:7cdb:8957%5]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 09:20:05 +0000
From:   <Conor.Dooley@microchip.com>
To:     <bmeng.cn@gmail.com>, <palmer@dabbelt.com>,
        <Lewis.Hanly@microchip.com>, <atish.patra@wdc.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     <bin.meng@windriver.com>
Subject: Re: [PATCH 1/2] riscv: dts: microchip: Use 'local-mac-address' for
 emac1
Thread-Topic: [PATCH 1/2] riscv: dts: microchip: Use 'local-mac-address' for
 emac1
Thread-Index: AQHXbuOou780QH8br0WdjeZ4URi1M6s5H96AgAFJj4A=
Date:   Fri, 9 Jul 2021 09:20:05 +0000
Message-ID: <cfdd388e-1cc6-04f2-6df1-de14281afab5@microchip.com>
References: <20210702014319.1265766-1-bmeng.cn@gmail.com>
 <CAEUhbmW2p22t=bFHJeNee2WpHEA6-smUzg6ffgqrfWcXx=iqfA@mail.gmail.com>
In-Reply-To: <CAEUhbmW2p22t=bFHJeNee2WpHEA6-smUzg6ffgqrfWcXx=iqfA@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd365a58-9258-4e54-12d1-08d942babd76
x-ms-traffictypediagnostic: CO1PR11MB4882:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB4882F6C4E3EAE89957B7BB7C98189@CO1PR11MB4882.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8gbHzxhAj9CGvpDomDqG8ziC5eOPK9yAlsvCmUwDwDXx2SVzW99yQvM5oV/rSn7nNO/QvoLtzTzDiSsmkdJYNxiX31nbsbk0SPQX2v4mPNRZZ0jr7ATSbvMPDGVAJyWmlKVGAW8e6FgB1iKvNrQdeKgb7T6Gtk6r5xlsSNdTLeblMPpJNlIEHxJiQ+gVfZC4NxI4rM9Z6Lpxy96wqUJTvGr/m4A30KYnn8xaIthR0hNrx3ld6nGj1xdQhWjYxhVuLPduN628WHgzcINhYaXEtePaHSDatkC2vwWW9+ANWB13BHi4nGODXLpSRhVu47rWMZ1r1cyy65t18fIrGYwFiY+cxe255gww0Wm4qZLjvG/U2FjEfmSpivc5TTuWYkT4PvqgAK5oPDkVFReGMVJfA6Qqld+STxMnJfTkxzq55qfyE3EI8y9E34WQRnPncwCLu8fLyZzk6FzfeBhWsbuG0pnpe0tkJo/wUYkQsaqE/FeYxrx+4cmzjmjLPPxOfYErGX2UQWDMcBo/Nm5a/FU6TBJC857L9cOVS1EiOtQBpTXGma9DvHZKyqkzf8lNHOG4GdUuGL8fuVp7Y4M8IA8GmxQx3Q+jIPeYPV6sSslVNO5sBn2QrnqqSpYmXTThvbMhyJh5KNVU8m+RzdowR/AmpK4lHipgWp/T1KzcyZ6obBB96ToxZvCAkxjdlz3rwTZ/x58yZG+lq9kzynaR9S4vw/+7thbUMgTGHdM1J/uxgoTaJd65S3OWxYqiyAU75DyFbz1m7rCQo6/Wwe2cXoNEiPNg9xBq5J3JD2gm4/+fbqdLH8VpXlwvHOCrW9mtamhr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(110136005)(31696002)(5660300002)(8676002)(4744005)(66476007)(66946007)(64756008)(186003)(38100700002)(76116006)(498600001)(66446008)(71200400001)(26005)(6506007)(966005)(8936002)(122000001)(6512007)(66556008)(2616005)(31686004)(83380400001)(2906002)(91956017)(36756003)(6486002)(53546011)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmNhTWZwV29vaXZrcUZtZTZGcU8wTmVPK0c4SE02MmErM2VBMGlZc3ZnbkMw?=
 =?utf-8?B?bUc4Q0ZNckZ6NXFUNTRTdGtNT2lNdy9RV3lZR3I5ZlpvaWhiK0tCR09Yck94?=
 =?utf-8?B?TXIwLzFibk4yUlI5NkNmQVoyYUE1eGVmNGhEWXVLenFqWFRPUXNRTDNtRDZ4?=
 =?utf-8?B?NWp5djUxMGhrb2I0eFFzeENHajgzbzRLS1BhSnJGTW9MczZ6RzhER0lyOVlT?=
 =?utf-8?B?V2lZaFd3Z0NQckFvLzIveDcwQ3VCdGl3NG9Da3RNNU1tSG9KSzlaUFNZa2wx?=
 =?utf-8?B?WWtwS0ZXNUpCZEliR3pDMkpyZzB2M0Nwcm9FSGtZN2pjUHZRVkpkZVNwd3Vx?=
 =?utf-8?B?OWRSUFpzYTdheC93MDZ2N21yS3M3T2xyMlRxdW11dlYwTEdFZnZFVTVUMENV?=
 =?utf-8?B?RHhSQ3BncmdEQVU5TWxWcUt0bGg4MDZiWnd1Uklac0t4ajB5Yktvc1hxYWZQ?=
 =?utf-8?B?U1N4MU9NN2tSVlFCRjJKK1M0RTdadU5JbWFDQm5Cc3Q5d21sQ2RKdnpERnhq?=
 =?utf-8?B?bjBMWWY2U0M1SXp5a09aUytQT0pZUFZkRk9QOHV1RHZYNGJURTFGUllpc3Zh?=
 =?utf-8?B?L2FsMTJmOWg1VUIvYURheDQ0eFVLOG1zS0lrcU5Qc29tOVVNYUt4cXN3RGt3?=
 =?utf-8?B?VlBMOFZTUlcwS0RwNmYwN05wWFhYWTZ2T1FOSWpHUlV0ektvUm1WNmpTZ1Fq?=
 =?utf-8?B?MGFINi9aeEpCbXRSbkgvSy8za1lXYXlHSitnZERqSlZqRWE5Q05NM0d3NU92?=
 =?utf-8?B?L3Jmc1hOWjZxNk82YTdBR1pmSjVGSm1HcGpzQmNHNFhuV0puZlpEV0hZVG5N?=
 =?utf-8?B?SE1HckNhLzhVNmhsQXZJcDFxaEJ4Tzd4aTM2ZVphWTV3UkRUdnZvQkg4WE1y?=
 =?utf-8?B?NDlyQi85cHp4eGZoTVdKY2paV1U2bmlrZzdwRGtFTHdic0U4UERveS9kNnF6?=
 =?utf-8?B?VnU5QTZ4Q3hjYUxWdS9najdDSWRUNit4Rml5ZUFCRENxRzlZSkh6VlhyZmFq?=
 =?utf-8?B?S0NaT3NaUHpvdVFkbUlxQkRHU012Q000aWRXTTRTQXhvY0FNS2VqWEMwWmVV?=
 =?utf-8?B?dGpaZFc3bkV6NW9IMlE2YjlNV2VGS0haS0tMZi8yZjErQmw0d21TNllmaUlo?=
 =?utf-8?B?TStVR0NvVFkwd0Z6WDNXaTErTyt3cHMvRmhTSVorNEdRWW8rODZ6S25pZENa?=
 =?utf-8?B?ZkJvQURxTTdUMm1vcEJOdU5mRHRTeGFYNGNaUVloZEdrWDhxc1BaRGp4blVq?=
 =?utf-8?B?T0lvNFc0ZGVkZDE1d2hzTVVyN0QzUjlNUUx5bkE4NHVVem95MkZmY0ZCOEl5?=
 =?utf-8?B?RHl2c3kzeExZb01UVjd0YW5zcWlVQ1ppWUhjZXl5UG1KRzVWY1hlZW8xKzZ1?=
 =?utf-8?B?NjRxTGN6NW43Y0FHTFBTeGlCRm9NeDRGMU9ZcUhCQ2RpbjJDVmlESTg4REtt?=
 =?utf-8?B?YUJpaGhuR1JDZXFlZlgvUFFqOGRiSzJwNGhDR093SWorcGRKOXVvRzdzYlk3?=
 =?utf-8?B?OTNEcnZvVTJFYTI2djFuVlhFRFFRd3dnUjFwSmdTTnBhL0lmL2RCQmxDUlR4?=
 =?utf-8?B?VVBrOHhjTndzZ3hZcm91VkJaelEzT3ZjMzRTanVLTXU2UDhyeEsxbDFOQVlD?=
 =?utf-8?B?Y2JXbXJLbkE4aUhIVGw1OXNiU2lPZHZudUdGM0tMZXllTS8xcjFqQ2p1T2Fx?=
 =?utf-8?B?eG5QWWFzOCtEb0VjZHV4ZUJrVU4zR2c5RmwzMXV5elV3RWhva0VoaWNkVlFr?=
 =?utf-8?Q?wsd3tBbIBMTvrvRXHCGmPKQpgCpSMjxGJ0xHRNp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6CAC3FA0C145240AC3677F950F8B73E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd365a58-9258-4e54-12d1-08d942babd76
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 09:20:05.8383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guBLzlBA+4SyEzL+RSnoYhr2G0s3WrPsXuet3mgyTxH1PIX5zeTWgr07tvnrHDHiM/0s0pGAYOd3Fd3wbBRKYu6I+u0IM/PFzRTVEFGQHfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4882
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDgvMDcvMjAyMSAxNDo0MCwgQmluIE1lbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPg0KPiBPbiBGcmksIEp1bCAyLCAyMDIxIGF0IDk6NDIgQU0gQmlu
IE1lbmc8Ym1lbmcuY25AZ21haWwuY29tPiAgd3JvdGU6DQo+PiBGcm9tOiBCaW4gTWVuZzxiaW4u
bWVuZ0B3aW5kcml2ZXIuY29tPg0KPj4NCj4+IFBlciB0aGUgRFQgc3BlYywgJ2xvY2FsLW1hYy1h
ZGRyZXNzJyBpcyB1c2VkIHRvIHNwZWNpZnkgTUFDIGFkZHJlc3MNCj4+IHRoYXQgd2FzIGFzc2ln
bmVkIHRvIHRoZSBuZXR3b3JrIGRldmljZSwgd2hpbGUgJ21hYy1hZGRyZXNzJyBpcyB1c2VkDQo+
PiB0byBzcGVjaWZ5IHRoZSBNQUMgYWRkcmVzcyB0aGF0IHdhcyBsYXN0IHVzZWQgYnkgdGhlIGJv
b3QgcHJvZ3JhbSwNCj4+IGFuZCBzaGFsbCBiZSB1c2VkIG9ubHkgaWYgdGhlIHZhbHVlIGRpZmZl
cnMgZnJvbSAnbG9jYWwtbWFjLWFkZHJlc3MnDQo+PiBwcm9wZXJ0eSB2YWx1ZS4NCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBCaW4gTWVuZzxiaW4ubWVuZ0B3aW5kcml2ZXIuY29tPg0KPj4gLS0tDQo+
Pg0KPj4gICBhcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9taWNyb2NoaXAtbXBmcy5kdHNp
IHwgMiArLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkNCj4+DQo+IFBpbmc/DQpZZWFoLCB0aGF0cyBmaW5lLg0KUmV2aWV3ZWQtYnk6IGNvbm9yIGRv
b2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGxpbnV4LXJpc2N2IG1haWxpbmcgbGlzdA0K
PiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcmlzY3YNCg0KDQo=
