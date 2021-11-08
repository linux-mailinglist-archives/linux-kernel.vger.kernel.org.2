Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1C344788C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 03:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbhKHC1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 21:27:48 -0500
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38]:52779 "EHLO
        esa18.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229757AbhKHC1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 21:27:47 -0500
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Nov 2021 21:27:47 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1636338304; x=1667874304;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ggyJ3ItdgTb5FRwxJbpBroKCFmNH6ZzHKm+LJULJht0=;
  b=lSu+ZV2kvbfBDuu86jrwG/8AZ9pKnRynBGnotguSZOoo9JC49gfBXg6M
   QRK6ABvhvFla62BnZttkdtqbgu0iVasCFksSRDJedrzaPTQllDLFcnyJP
   cz3AnApEDbLSH3S0Q040g5SBoIDytXlfBCASe5gdFSYvxPdo7naaf30jP
   QV1T7B3v8JkBpZdNTaDfU41RHb62K6lozU3pb1SXmSx+lxwptQ3TmAq+2
   85ZMOUaq2ZP90caXOo2Hdk5Mfb7sT8ikJ/iyBD2j5urKtIjSRMQZGEcwz
   yact+UAI9kqf2CKybvgWlpP2aLY/2W/cpJVJQ42QWXnOBfm98ZALREYYv
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10161"; a="43799571"
X-IronPort-AV: E=Sophos;i="5.87,217,1631545200"; 
   d="scan'208";a="43799571"
Received: from mail-os2jpn01lp2056.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.56])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 11:17:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWsI22SHODCj4UwoHxlZsjL1kAyRo3fmrf0SyvOomwyLBWMeREt8YGxJ+wvowLbP8cs+fc4zNDxImrC+hoeBeHBkqUFhmTSs+pndusl1/MxByre9RIsVrvDfOpe6vyHfO1u5T2Zyc4vkPlpu7Nm9HrExT2hgyu+6bcxT57/3W3PsrmPpRi42ZSgJjlrJJFagPX5oJYXKo4jq6EUHBR1vy4r5wmW6But3cjfUvU1z+kEOB1U+yoXuRqrXauYI0k/7RZfScrG9N716ApSrVjT2kRYjogcp3UFYUu63R0cc4AuWcsKAmGsX4onQOVwUTjWphwYjuYtetFCLlOVcJvI4WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggyJ3ItdgTb5FRwxJbpBroKCFmNH6ZzHKm+LJULJht0=;
 b=MSdYXNnxyWcZMco03XKFIfgxf+unepvSiraO5lLSPibg06pB19dxDTuXglgxSwS1BQZ3Uw3ZttcOa5J+dySsmQs/y6fxShfUmpMS04HnC+yJnRVd6H/SFEnvTkX5z9l6h8CA+6rjiydc3jQ7TQOhxhd+asnYyZ3/OAF6/eTldQsnbYkxbBxn4EEj9NPKfOSi534HXXkVVoNqntkoQYdUSIzqLmFisOEuQ+0l/zHG8o31mU24p16TB2sTkmeTc1dCwG8vEqU9LLL4rGue133C3QfcFb2svnfpEMeRLNVjKnJvcIfxhlNIsgfAMJb/bAXSLa3YCfznWyC3pR8obmSCoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggyJ3ItdgTb5FRwxJbpBroKCFmNH6ZzHKm+LJULJht0=;
 b=LL6bxis9DjOa6E2JiqT6GwAWjAPRMyp+PKNUK8rsCQ8CiTGcQF6iJ0uj860rMu1qDZoB0fEBUKAj3hJGz97SA3tdEBJCW+M6UevRFRUSNNMJOQD0aMmMEWXmi9V3TgLhc4yaeBf/nT35RB8e2ucx7sWDlhtb9ptcVohS1WCrDhQ=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Mon, 8 Nov
 2021 02:17:43 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::816a:2a54:60a9:7124]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::816a:2a54:60a9:7124%7]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 02:17:43 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Borislav Petkov' <bp@alien8.de>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v2 0/5] Add hardware prefetch driver for A64FX and
 Intel processors
Thread-Topic: [RFC PATCH v2 0/5] Add hardware prefetch driver for A64FX and
 Intel processors
Thread-Index: AQHX0Tvqcmg6rBpliUSJLBUQh9tTC6vzenEAgAVvZFA=
Date:   Mon, 8 Nov 2021 02:17:43 +0000
Message-ID: <OSBPR01MB20370518F9296BA4302FF7DC80919@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20211104052122.553868-1-tarumizu.kohei@fujitsu.com>
 <YYP4fAgKSh4bVvgD@zn.tnic>
In-Reply-To: <YYP4fAgKSh4bVvgD@zn.tnic>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9OTAwMDU4ZDMtMjVlOC00Yzc3LThhYmUtMTRmMGU3NTJi?=
 =?utf-8?B?NTVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMS0xMS0wOFQwMjoxMjo1OFo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2825a568-a7ee-4576-c340-08d9a25df293
x-ms-traffictypediagnostic: OSBPR01MB2037:
x-microsoft-antispam-prvs: <OSBPR01MB20379A5E3CAC808A5AC6CA8B80919@OSBPR01MB2037.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nfTo/G6tWT++cvRPZJUeAK8pXDUxqisDbwzgcuuqtCqks6q0whPSuGZjzdmwWBZIsfPqfriuO2PiUUNuWeWmK2PL8OuZVq7/tKSvv+l/QgBHU7h/7iUQPlu4x84oErklm34R8+lqUbQazP0nhSi+aWZUoX/dHRkBufm3w2+oT4MX7JYsOk8olMEUYkIDznfer9ON/1IdXxWMuAEK8a8FIfrEm2U9/HvSDPSnbCANKCKxEceBXazEgcf32PUAw6C4ZSv+OBIzKoL9OoGRS7XWonQ920nwFrQYL/nwDCmiDEQA/WNAL4Y0P3teYcSf/x7pP0Cu/AyjxEKH1p58weNV0mkMJgcgoU1NNCLTYhgf8htEQ8eMz8O+S8HD4T8t0Cy5ivyXs7XpZ7Q3Kgv5s+uNOjMuAoeEi0LBH/EGyZqqbMpm+UD1aeFExxO6xGVZtn5+u5uNa5+KyPVKFf3XaM2DXvkW/urr4B2+a40IlgIPg//tnKEg/8YqEqTNnw7sFYnE0DJaPRrx1xgfX2cGLfytwvYupLYu4TD0NyXC2orOXYEuAHZWTlC7gvOWaSOTeuOWEFFMjz0KuEvTCEHA5tn0g/ZtT6Fg9BzdMHMSSrNHY2kVh7ZhLKtmEep9AOd1vLEjyDbN8rLlYTg1kzXJ8XJgoQ/lNRGuV88kUjOwj3MFRQbqAfFXzYfLMvT9/SciVEmH85NwKVbUbpa77JS4crk9HUmdwJcutiEu0E7mtowaHvTchMbRmHiiy2lbvSCgSfOWTKdwwJoDz/e9K90QPxAetFgznrKezNtNXtZ1Qcod6sI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(7416002)(316002)(6916009)(26005)(4326008)(76116006)(66446008)(66556008)(64756008)(66476007)(66946007)(5660300002)(508600001)(33656002)(38070700005)(85182001)(966005)(7696005)(8936002)(2906002)(122000001)(86362001)(6506007)(82960400001)(186003)(8676002)(38100700002)(55016002)(52536014)(9686003)(83380400001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RndUWTdsd1NsR0ZuZUFxOW51ZHp3dkpDU1dFUFZqRmdOZzVQN0p1WlZFNkdP?=
 =?utf-8?B?TnpUekVqdldiQlhmNDdleXBXYmwxa3ByS1pUUTZ0eldOSy9FWEYzK2dPUUJ1?=
 =?utf-8?B?VDk2RmpqRS9DdWZ6Y1FNWkRINnlmSHNrNjZVa2RabVlhWGt4STdrVFJLSjNi?=
 =?utf-8?B?Wi9DbWNFenVydG9CdDRyU0I3Q3dhWWpEWDhLTENpekVHZzFNUUtHSzlGUVBv?=
 =?utf-8?B?c28zWXFxWTJTRVdqQjcrOGphc2poUlp4WjBiNDJLOTY1WDlMVTgzTTMza1N6?=
 =?utf-8?B?NXlCeDBqcUhJWTlNWUZqZkd4ZnRFaEcwY25tWk5McUVmMnRkQ1dXVDdyTi82?=
 =?utf-8?B?UWlMa1pWYkFVeE92cHVkZ2xueldYeWp5ZnpwUTZGb29uZGFYVkg1bGlwL3Bp?=
 =?utf-8?B?WlE0V1ZVYjZUOFJqbXkwQ0tBV3NZT0l2dzdLb1IxR3FRUkxJRkVEenJmYTQ1?=
 =?utf-8?B?bWl1REJIVmhVMHFJUjZMTE1tbm5kY2RDSis3dVExajlkbEZPTkxmQ2FtQnpO?=
 =?utf-8?B?WlFzSEZYckR5cXVOWFZ4WVpvSENPZ21lbzBDY3lSWUtCTS9zbzNXbk9XVHY1?=
 =?utf-8?B?MElZR21pdHN5OXZ0T1NMTzgrNnBLKytEYUp0YjZhMjc5TjRHQTJJTDlra2Iy?=
 =?utf-8?B?Y2RIcitZeXl4aUFMcHg5VGROR1VpNUdvZGlReW1hSGNOL3Z1a2Z5aEdIRVl3?=
 =?utf-8?B?dkZmbFhPTVB1dzBvMGZkSmZ6YjhQMGtWWVZ3Z0c0QVhZUE9oTlRKSGVma1RU?=
 =?utf-8?B?K2tZK2x3Vks1WTNnVTkwNVR2S0hyVkFYRnlvTFkxVFl2UmsyVFBua2NNKzQ4?=
 =?utf-8?B?aFhJWlNtZzhmMEkyT2lMMFFBQk5IRUZqUG1rVXEwOFVKejlQemhQQzh3TTlX?=
 =?utf-8?B?dTAzV21hY0hHYjhJUTUyZW45TUtidmZmZE4rSThRdXJlOE1lUGlHY3I0VTlh?=
 =?utf-8?B?MHJpdHRMVmpPY3RNdHByZTBqbnVLT0x0U1JGNGpERjFSZ0V4YW1XTDF1ajc4?=
 =?utf-8?B?SEVlaXVTeUtEMUowVGJCOHB0QmdwYXFOVVd2ak83emJYSXFJV3NNMkVtMDA4?=
 =?utf-8?B?NWczenZza0l3QnlOcGtIem9CY2cxVW5WeXNWSHRxNU13d1k5NlpsY3p4V3Fr?=
 =?utf-8?B?TWNRN3lySzN3Nld3QkJjb0ZZR1c0a3VjcTk2MU4vQWkrdjR5VXJvU0psK3M5?=
 =?utf-8?B?alFoSzdDc1R1MUR0cXJ0T2g3N2FtdWdJbHJaZGUrSkJqTXVPcnZpSUFrMUxZ?=
 =?utf-8?B?ODF6aTVWMWFlL1FIQzZFVFJIcEdPTkNwMjNRdlV3NFpVT09iNVFuQmlKTktF?=
 =?utf-8?B?Qk4wL1ZWZStIb1RkWFVIRW1FdVE3Q09mNjdKdHVSTnhiV0VNKzVLYWVwZFBR?=
 =?utf-8?B?M2hOYTBNRjNPaXllRXV0VFMxczAvVjFzekJaVGowM05YaFVSYWpmbGdSaXZj?=
 =?utf-8?B?a29COFZGaWVNS2x4K1RqalBQNWNmdDdXSGNoNEk2U1VmK2F3dVdPeDRJMGdN?=
 =?utf-8?B?NjQ1bCtKVHR1MWg5ZU5CT3lTS0hmV05Pd21Vei9ZZjBNejFhRVlSSWF6TUQ2?=
 =?utf-8?B?MDQyUVhmUU90R09xc1RRbllkMkJSY0QrREFVbDl5bm5PMjVPWmhkdmdydkdr?=
 =?utf-8?B?bkV1NHF6bXhzV1MxNFFObVFJYXAzWjN0L1crYnc5YStYakJSSzZzOTVtWVdi?=
 =?utf-8?B?N0dlc3o4WjUrTE5LZ3F3UE9ZR1ZmZjdRdURrUXRVbWJRR09JL1c2WTY0WHFu?=
 =?utf-8?B?WjZyTlZ4UnhkUmxadHY3RWt1TjZRelVNY3phYXh4KzdkemVmbFZscEpQdGhl?=
 =?utf-8?B?SVRNaHpQMmQ5R25uV1VtRzR3VTh3ZlZFWFllOEhXVUxGam1PSEw2eHBrMmU5?=
 =?utf-8?B?ZnRCaEdWZ3V5YjlnZmYyUUFHSzVmeXBUTmhhdFFDRHcrR21vc3J0Z0h1U3lz?=
 =?utf-8?B?RjJ1dDI2cXJTMGJxZ2syb3RWSzhZYW1vOU9UaXdGS3AvejE0cHFNYXJkL2tE?=
 =?utf-8?B?MFc0aytqVXNId1d6QTB0bXVKcHl0RUYraGZraWtPVzFUVmhRa3IzZllBMUZ6?=
 =?utf-8?B?YnhuS3hxc2d2YTJNRmkxa0lnSWJ5ZEYvYUZjcm9NM3JsaFRPSmdxZ0FkSVp4?=
 =?utf-8?B?RHJHZHdVNE5ackk3dHYwanNFYmFGak03bkdwN0hGS2swcmYyRHFrSkpma1lK?=
 =?utf-8?B?MjdyM3hNMzRvU2Q0eDlrazNiYS9CQklvaHUwclMwYmdEWXlBK1BsRzNhVjNk?=
 =?utf-8?B?bEFHRGsraHZ3NEVGY0xSMXErbWh3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2825a568-a7ee-4576-c340-08d9a25df293
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2021 02:17:43.3884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: czb5AdBf5lwe7AYcQaq8p5JMWSlOB1rnM+Q5kquSmmBjQCeT5dH9NpPH80TaVO3O6CHWtse/QEzckJGYvpPKTdC6nIw+3sE1lN56qS02j+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2037
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KDQo+IFRoaXMgaXMgYWxsIGZpbmUgYW5k
IGRhbmR5IGJ1dCB3aGF0IEknbSBtaXNzaW5nIGluIHRoaXMgcGlsZSBvZiB0ZXh0IC0gYXQgbGVh
c3QgSSBjb3VsZG4ndA0KPiBmaW5kIGl0IC0gaXMgd2h5IGRvIHdlIG5lZWQgdGhpcyBpbiB0aGUg
dXBzdHJlYW0ga2VybmVsPw0KPiANCj4gSXMgdGhlcmUgc29tZSByZWFsLWxpZmUgdXNlIGNhc2Ug
dGhhdCB3b3VsZCBiZW5lZml0IGZyb20gc29mdHdhcmUgZmlkZGxpbmcgd2l0aA0KPiBwcmVmZXRj
aGVycyBvciBpcyB0aGlzIG9uZSBvZiB0aG9zZSwgd2VsbCwgd2UgaGF2ZSB0aG9zZSBjb250cm9s
cywgbGV0cyBleHBvc2UgdGhlbQ0KPiBpbiB0aGUgT1M/DQo+IA0KPiBJT1csIHlvdSBuZWVkIHRv
IHNlbGwgdGhpcyBzdHVmZiBwcm9wZXJseSBmaXJzdCAtIHRoZW4gdGFsayBkZXNpZ24uDQoNCkE2
NEZYIGFuZCBzb21lIEludGVsIHByb2Nlc3NvcnMgaGFzIGltcGxlbWVudGF0aW9uLWRlcGVuZGVu
dCByZWdpc3Rlcg0KZm9yIGNvbnRyb2xsaW5nIGhhcmR3YXJlIHByZWZldGNoLiBJbnRlbCBoYXMg
TVNSX01JU0NfRkVBVFVSRV9DT05UUk9MLA0KYW5kIEE2NEZYIGhhcyBJTVBfUEZfU1RSRUFNX0RF
VEVDVF9DVFJMX0VMMC4gVGhlc2UgcmVnaXN0ZXIgY2Fubm90IGJlDQphY2Nlc3NlZCBmcm9tIHVz
ZXJzcGFjZSwgc28gd2UgcHJvdmlkZSBhIHByb3BlciBrZXJuZWwgaW50ZXJmYWNlLg0KDQpUaGUg
YWR2YW50YWdlIG9mIHVzaW5nIHRoaXMgaW50ZXJmYWNlIGZyb20gdXNlcnNwYWNlIGlzIHRoYXQg
d2UgY2FuDQpleHBlY3QgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnRzLg0KDQpUaGUgZm9sbG93aW5n
IHBlcmZvcm1hbmNlIGltcHJvdmVtZW50cyBoYXZlIGJlZW4gcmVwb3J0ZWQgZm9yIHNvbWUNCklu
dGVsIHByb2Nlc3NvcnMuDQpodHRwczovL2dpdGh1Yi5jb20veG1yaWcveG1yaWcvaXNzdWVzLzE0
MzMjaXNzdWVjb21tZW50LTU3MjEyNjE4NA0KDQpBNjRGWCBhbHNvIGhhcyBzZXZlcmFsIGFwcGxp
Y2F0aW9ucyB0aGF0IGhhdmUgYWN0dWFsbHkgYmVlbiBpbXByb3ZlZA0KcGVyZm9ybWFuY2UuIElu
IG1vc3Qgb2YgdGhlc2UgY2FzZXMsIHdlIGFyZSB0dW5pbmcgdGhlIHBhcmFtZXRlciBvZg0KaGFy
ZHdhcmUgcHJlZmV0Y2ggZGlzdGFuY2UuIE9uZSBvZiB0aGVtIGlzIHRoZSBTdHJlYW0gYmVuY2ht
YXJrLg0KDQpGb3IgcmVmZXJlbmNlLCBoZXJlIGlzIHRoZSByZXN1bHQgb2YgU1RSRUFNIFRyaWFk
IHdoZW4gdHVuaW5nIHdpdGgNCnRoZSBkaXN0IGF0dHJpYnV0ZSBmaWxlIGluIEwxIGFuZCBMMiBj
YWNoZSBvbiBBNjRGWC4NCg0KfCBkaXN0IGNvbWJpbmF0aW9uICB8IFBhdHRlcm4gQSAgIHwgUGF0
dGVybiBCICAgfA0KfC0tLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0t
LS0tfA0KfCBMMToyNTYsICBMMjoxMDI0ICB8IDIzNDUwNS4yMTQ0IHwgMTE0NjAwLjA4MDEgfA0K
fCBMMToxNTM2LCBMMjoxMDI0ICB8IDI3OTE3Mi44NzQyIHwgMTE4OTc5LjQ1NDIgfA0KfCBMMToy
NTYsICBMMjoxMDI0MCB8IDI0NzcxNi43NzU3IHwgMTI3MzY0LjE1MzMgfA0KfCBMMToxNTM2LCBM
MjoxMDI0MCB8IDI4MzY3NS42NjI1IHwgMTI1OTUwLjY4NDcgfA0KDQpJbiBwYXR0ZXJuIEEsIHdl
IHNldCB0aGUgc2l6ZSBvZiB0aGUgYXJyYXkgdG8gMTc0NzIwLCB3aGljaCBpcyBhYm91dA0KaGFs
ZiB0aGUgc2l6ZSBvZiB0aGUgTDFkIGNhY2hlLiBJbiBwYXR0ZXJuIEIsIHdlIHNldCB0aGUgc2l6
ZSBvZiB0aGUNCmFycmF5IHRvIDEwNDg1MTIwLCB3aGljaCBpcyBhYm91dCB0d2ljZSB0aGUgc2l6
ZSBvZiB0aGUgTDIgY2FjaGUuDQoNCkluIHBhdHRlcm4gQSwgYSBjaGFuZ2Ugb2YgZGlzdCBhdCBM
MSBoYXMgYSBsYXJnZXIgZWZmZWN0LiBPbiB0aGUgb3RoZXINCmhhbmQsIGluIHBhdHRlcm4gQiwg
dGhlIGNoYW5nZSBvZiBkaXN0IGF0IEwyIGhhcyBhIGxhcmdlciBlZmZlY3QuDQpBcyBkZXNjcmli
ZWQgYWJvdmUsIHRoZSBvcHRpbWFsIGRpc3QgY29tYmluYXRpb24gZGVwZW5kcyBvbiB0aGUNCmNo
YXJhY3RlcmlzdGljcyBvZiB0aGUgYXBwbGljYXRpb24uIFRoZXJlZm9yZSwgc3VjaCBhIHN5c2Zz
IGludGVyZmFjZQ0KaXMgdXNlZnVsIGZvciBwZXJmb3JtYW5jZSB0dW5pbmcuDQoNCkZvciB0aGVz
ZSByZWFzb25zLCB3ZSB3b3VsZCBsaWtlIHRvIGFkZCB0aGlzIGludGVyZmFjZSB0byB0aGUNCnVw
c3RyZWFtIGtlcm5lbC4NCg0KPiBJJ20gbm90IHN1cmUgYWJvdXQgYSB3aG9sbHkgc2VwYXJhdGUg
ZHJpdmVycy9od3BmLyAtIGl0J3Mgbm90IGxpa2UgdGhlcmUgYXJlDQo+IGdhemlsbGlvbiBkaWZm
ZXJlbnQgaHcgcHJlZmV0Y2ggZHJpdmVycy4NCg0KV2UgY3JlYXRlZCBhIG5ldyBkaXJlY3Rvcnkg
dG8gbHVtcCBtdWx0aXBsZSBzZXBhcmF0ZSBmaWxlcyBpbnRvIG9uZQ0KcGxhY2UuIFdlIGRvbid0
IHRoaW5rIHRoaXMgaXMgYSBnb29kIHdheS4gSWYgdGhlcmUgaXMgYW55IG90aGVyDQpzdWl0YWJs
ZSB3YXksIHdlIHdvdWxkIGxpa2UgdG8gY2hhbmdlIGl0Lg0K
