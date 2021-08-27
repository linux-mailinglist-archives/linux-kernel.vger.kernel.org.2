Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5353B3F97A5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 11:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245042AbhH0Jrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 05:47:53 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:33724 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244725AbhH0Jrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 05:47:40 -0400
X-UUID: 033b9a7cefe74398aeb2b5d7deb840b9-20210827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=czhraEWgBtYmDqqcqgdredG/r9vO1WNkf4ExcdXQ1g4=;
        b=I6PWdf8bzoT/hkjg/shXMjsDHwgk4pAs8Iyn/dLfrNUkJNCOgiSp4JQYcj3ROxPFjjFQjQ7CelIas+Ujy0KpUbYZzgXl5/CuAnW9yyc0afKy66fRtCKRT18irpRysR8wWvP7UwNM98P1ZLWk4Qe5qZgKlWJ6o0B6H/RvdmVwPEA=;
X-UUID: 033b9a7cefe74398aeb2b5d7deb840b9-20210827
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 789387821; Fri, 27 Aug 2021 17:46:48 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 27 Aug 2021 17:46:47 +0800
Received: from APC01-PU1-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 27 Aug 2021 17:46:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARaF0OTkMaKKCrAlCbYMr6o9mhYgTi6/gPP/c8MWkz+092j/MCzLTBVTp0CQnwUIdVLruHygn3+c7CbOoRCmO1m4G4UJ2+xQZkbGLPQgqtc46FEnVHFqJ9unVorH13O2hRqUJETq+f+JfPnaPeZBKWEToKkwhlxz0WzFDsDI7HgbhFJLGbpCURVPtVi88fvYIgn1d6s5wbuhlUKSCLWxt0j9yKpgXFgwhDIUPgML6Hn19BVRverrXmKI/pdSS5F0dp7+ra3TF1cPSIJb97tFuKlNaXOfh0SSNWmC/+8Ngt5lFRH5+esg2RMIGiSe/b6O7KEEVJbxlGEZHoLf82LMpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=czhraEWgBtYmDqqcqgdredG/r9vO1WNkf4ExcdXQ1g4=;
 b=a8y8IxcEUIQLWJgYVh2Az/JeFt7kkTLhKj5y2RHRc6ASQnja8YHwUyhVKfW83RUA45kSLRVCEoTng+u6k9tnKGgWCn1Ig6/KMfCv6fwA2SXJAmgMwiGGj1Jzm8Hbr6HpVA+nnyKeBZuRqvuv1DfXLKERdU5ougS6LkMYkMTi2fkQDAVbg/FZxwXCrUqj/09oKoiYgDDuKYIRskJ08lWz8giFOdbAHhwUAQt3JZHyS1tRk0wsi5Xb6EpAVSVQT9B1m77sFho47Jqur9u3Hek3Mz3MD4qyx2ykVu55jQq+DeWD8aD6ueG2+5dRA4D9+EBEhSTpdandEmAHCinYOYwKSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czhraEWgBtYmDqqcqgdredG/r9vO1WNkf4ExcdXQ1g4=;
 b=oKwRepVIQRoSckIlCO284t/T2sFZls0+WZrIIcSlAP7CQ2xAKl8ZFeH7Qit9XMPBmtbQXy29GRfjrQ35n6/3bhqYIq/dzei0ItMqnDAhdb4KBiDpxX0rp8/X0Viy+YKh0Pkyh7bxXdNjtc2HU/YeUtfcg3IWKFrkPhMcI20IJNU=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by KU1PR03MB2758.apcprd03.prod.outlook.com (2603:1096:802:29::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.11; Fri, 27 Aug
 2021 09:46:27 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::1898:f611:33ba:b58c]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::1898:f611:33ba:b58c%7]) with mapi id 15.20.4457.017; Fri, 27 Aug 2021
 09:46:27 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        =?utf-8?B?WWFxaWkgV3UgKOatpuS6muWlhyk=?= <Yaqii.Wu@mediatek.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "ikjn@chromium.org" <ikjn@chromium.org>
Subject: Re: [PATCH next v2 1/6] Revert "usb: xhci-mtk: relax TT periodic
 bandwidth allocation"
Thread-Topic: [PATCH next v2 1/6] Revert "usb: xhci-mtk: relax TT periodic
 bandwidth allocation"
Thread-Index: AQHXmiVazC+quBfOAkq2QLX4yDaH/quFqkeAgAEDPIA=
Date:   Fri, 27 Aug 2021 09:46:27 +0000
Message-ID: <d13ece6a1b050092affd0c67f19ef69887ae0c3c.camel@mediatek.com>
References: <20210826025144.51992-1-chunfeng.yun@mediatek.com>
         <YSd93+3D/PbacgsP@kroah.com>
In-Reply-To: <YSd93+3D/PbacgsP@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ecd52dd-3104-46db-8133-08d9693f8a49
x-ms-traffictypediagnostic: KU1PR03MB2758:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KU1PR03MB2758430E4A9A207FD70A6C07FDC89@KU1PR03MB2758.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kZJSd6XxFcyWnU1YsdPQA7tXioDJOsPO/hebsYcXSfZblH2FlmcKLP+IzhRqlqoZgmDxlAVCuAUdyHpQgK/ZXb9hyVGMJZCi1cBeIHLJLCWnIk9aR+EevpqKsPfDVxjD+5EYBGupJSeSlv8xi2LJhisFKiTVqNGvzIEuh3iHRuJkMIAKi4k2qISfu8LiC2BrYuCaoAHM3FUFuYZl9SXoLEV/qaPSQ7LEY7r5C2e5UGdKQb+VgyHTHwao1+Q+iJhYTdxkqHDBNDyFRVXAg8i8NM/dknVgqTx9nUNhlSmWI4/1Piw0bgjPJaLFdUKpErdCYS1sVnjj5kgtXdCbeljKO15LBI8/envwFgdf7TZ1BuDcvPKUfmAX9VPfeJfQB7HYoHSVj0WW2O7q+TqX+DWVa9ZOnDbp+HAdjJvv9jfDd+/FFNBFvjN1oy0+RiEpnne3JzmQKq1pK5mJ65SoSu7QxZFan7b/SoR2ejy+puDtEhnDzM+LBUoXrPRe9qOF1z90/t4+4hwPVJCf2vtPu6TWj47sKDRcrwz/B7OTlHdOePOyxfrc9cr0LL08qDcJOHrdoQEnC70qAIxSIaYeWBI1N2stBY1MqbZqBXMj0oxORJ8czS4pcMCGsimcnjoiV4FrLlU7hhWKLPeLHKglutNX+lnzbAaGD/WG7Jn6DKlhQ+iSBukfpqeAZ8XKpxQ2Ue4V0vdo9Dn6LDmpQLERa/+WVaItrC5E8YnmZY1g0YdXRTngHypBmHCp6s12t3nYcKjGNKeEEumdnkiEJoDuZN7otWlLiqM3MYBRo7rF87mkfA05aTrW36C/pn2ZlafVOnWmQ82QDCQgVvwv7vWEmW0TF9B3Oqjjg0KaFYw22RP3vsU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(8936002)(38100700002)(6512007)(38070700005)(2906002)(71200400001)(508600001)(2616005)(8676002)(186003)(76116006)(64756008)(66446008)(66556008)(36756003)(966005)(91956017)(54906003)(6486002)(83380400001)(66946007)(6506007)(26005)(316002)(6916009)(66476007)(85182001)(5660300002)(86362001)(4326008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZktHekZTc2pvT00zQ2pxQUEwNm1sSitabnpKWU1EY3gvazNGTDAybXZ2ZUU1?=
 =?utf-8?B?dzlIalRMSkROUytkb0hlVktsMmZaQUJ1YW5sOThhdENFVU8yNm51QVFuajhY?=
 =?utf-8?B?Y3pNc2JNbUo2Z1k4eHNyWjlnY1FVZ2lqeUFhUVhJdXFCOXlGZ0xYVVNxVmZN?=
 =?utf-8?B?QytkdHFxN0NaKzdwRlVFdmlnNDBHS0ZoczgzQ2U2cTlXNC9sTVg3TUFUTFdm?=
 =?utf-8?B?eVZGZE1OSWZFWEI3SkYvTnhQcFNueENFeFkveEJZVm01K2F4RjdRRkRmUThN?=
 =?utf-8?B?cGo3MGhjYlRKTFlYVHpydzY1QmplV21xQnhvR3VjSG9EdDk3QzRiRU1KWjYv?=
 =?utf-8?B?YkJUdml3d0xPRDJDODBoZngweHFaYy85U3I5R24wNHlVNXdWcWhPb0JjbnVt?=
 =?utf-8?B?UWEyM05XTGxqeDdWckkzZTFyR2UrTFBDeXRFaG5MUGZ0UGNaT3NoMTZRbG9P?=
 =?utf-8?B?K2FGUmxPWW0wZk9sLy9FWWlMMVVlU2ZLKzluend2eWFPRjh5eHJCd283ZEp3?=
 =?utf-8?B?cDRqamVQdUFBNDZkQTR3bzAxQWRkalY2V2RwMUF4Y3cyaG0za0RQa0FEQk1j?=
 =?utf-8?B?UUlTbTRKbytVK3lVTFkweVUzclVHTkowWWpwRUdJdEU2aGhiUkVUaUNOZXBP?=
 =?utf-8?B?cmFGT3FxSUljeWtSZ2ZMdGlxeXBCRG5ZSmdlK1hsSjJQSk02YXR3eGRBSEFV?=
 =?utf-8?B?aEF6VkZrY1QveEFXeU52Mjd4YzhLeEFONGxkaU1aYm5nNHUwRzVKRnBwYUZl?=
 =?utf-8?B?QmVYWHVVVFpjTDZyMERZVDY0NzhuVmRSQnQ1eitLRitjZlJOWjJnTllBYUJn?=
 =?utf-8?B?Wi9tWWhQbkplQjcxWHA4UkowUzU4U2NBUUVOdGpFZmVOaVd6N09kLzBIUTFy?=
 =?utf-8?B?YTV5VDJ5Rkc5eVBIbm92NzZFUzJSU2hvRFFBRG1QTk5RSWlRYUR1OGNtbjkr?=
 =?utf-8?B?SEIrZk5EL3NRSGV5Y3RpQ3JCUHkycDN5ZW5OMkxLWUV0elNuTHhTNjFrTnc5?=
 =?utf-8?B?ZUk0cUo2VU5GQzRhVHprY2k4MGRFelAzN0l5VlNSL0ZEMVArWlVjclBlZXpu?=
 =?utf-8?B?YUtTTm83c0FHSGNLKzF2T1hUK3hVbkRZdnc4YkdZWHRVUnVoU2FlK2JROTAv?=
 =?utf-8?B?emZvdG9laTFZd01LaEpiNWNPOVpkUVZpUlFnUWhST29aQXhGaUxqWUQzSU9U?=
 =?utf-8?B?d0NocHgrN1VtQVFDVDFPdDE2SFd3VVVEWjVYeXBPa3BJb21MNFRnN2RJMFdV?=
 =?utf-8?B?ejNBSERUbUpmaVRTaFFJUng5R2FpTWNPbTlHemFPRjY3UjRLUGxWaFZYMVNP?=
 =?utf-8?B?andWTUtPUnhaTUVhWVdndVlhSStidFJSYzJ6Y3hZK2tydUROaTZGQ3AwN2RQ?=
 =?utf-8?B?dGRIWDZtY1BPcHdlR3NlclFyMTkrNlcxTk1vODRUZlRpL0V1aWRVbklOMEZy?=
 =?utf-8?B?c1RzaDRGUTRxWVUrdEw3a0lNWHZlcDJtZDdiSFhOaDZpaExhZFh6U05xOEM3?=
 =?utf-8?B?V2dITXpsVEp2K1Z0aWZsS2RLaGZ0M1FGOUc5R0ZWOHlvTk81RlF6TUFHangv?=
 =?utf-8?B?WGt0ay94bnFId1FmRHVlRDBKZURORHMzeGhRZjBTTk1jYmNvUjdscUFCdWlN?=
 =?utf-8?B?ZGJJb0Uzc0xFLzAycGpGUC9tTElSZ1Npdk9CNHN3YjBmdU9INnZpWU84dG5P?=
 =?utf-8?B?ZFFBTDRnWVhsNXFjdUk5a3EvcENYc00wYWgwNjNGYXpBSGdybCszd0hTWXgw?=
 =?utf-8?Q?Pf2uXaiI2vOOIGvpiq3H656+VvIbqNcQl448bAO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3275B026F2E8234B91EEC5CFA9159C27@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ecd52dd-3104-46db-8133-08d9693f8a49
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 09:46:27.1905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sMTE8bjD7Kqd+VZ5gKwhv/D0LSnwns7vPJpVC9pHD1sb+9828AeFCjzQ4XlC9JFUqfevxjx/RgUJaHFR3spsO15BWavKqk9Vol7Gbh7T3ik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1PR03MB2758
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCk9uIFRodSwgMjAyMS0wOC0yNiBhdCAxMzo0MSArMDIwMCwgR3JlZyBLcm9haC1I
YXJ0bWFuIHdyb3RlOg0KPiBPbiBUaHUsIEF1ZyAyNiwgMjAyMSBhdCAxMDo1MTozOUFNICswODAw
LCBDaHVuZmVuZyBZdW4gd3JvdGU6DQo+ID4gQXMgZGlzY3Vzc2VkIGluIGZvbGxvd2luZyBwYXRj
aDoNCj4gPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEyNDIwMzM5DQo+ID4g
DQo+ID4gTm8gbmVlZCBjYWxjdWxhdGUgbnVtYmVyIG9mIHVmcmFtZXMgYWdhaW4sIGJ1dCBzaG91
bGQgdXNlIHZhbHVlDQo+ID4gZm9ybSBjaGVja19zY2hfdHQoKSwgaWYgd2UgcGxhbiB0byByZW1v
dmUgZXh0cmEgQ1MsIGFsc28gY2FuIGRvDQo+ID4gaXQgaW4gY2hlY2tfc2NoX3R0KCkuIFNvIHJl
dmVydCB0aGlzIHBhdGNoLCBhbmQgcHJlcGFyZSB0byBzZW5kDQo+ID4gbmV3IHBhdGNoIGZvciBp
dC4NCj4gPiANCj4gPiBUaGlzIHJldmVydHMgY29tbWl0IDU0ODAxMTk1N2QxZDcyZTBiNjYyMzAw
YzhiMzJiODFkNTkzYjc5NmUuDQo+ID4gDQo+ID4gQ2M6IElram9vbiBKYW5nIDxpa2puQGNocm9t
aXVtLm9yZz4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBt
ZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gdjI6IG5vIGNoYW5nZXMNCj4gDQo+IFRoaXMgc2Vy
aWVzIGRvZXMgbm90IGFwcGx5IHRvIG15IHRyZWUgYXQgYWxsIG5vdywgY2FuIHlvdSBwbGVhc2UN
Cj4gcmViYXNlDQo+IGFuZCByZXNlbmQ/DQpWZXJ5IHNvcnJ5LCBJIHNlbmQgdHdvIHNlcmllcyBb
MV1bMl0gZm9yIHhoY2ktbXRrLCBidXQgZG9uJ3QgdGFrZSBjYXJlDQpvZiBjb25maWN0czoNCg0K
SSBzdXBwb3NlIHlvdSB3aWxsIGFwcGx5IFsxXSBmaXJzdGx5LCBkdWUgdG8gWzNdIGlzIG5vdCBh
Y2tlZCBvcg0KcmV2aWV3ZWQgYnkgUm9iIChJIHRoaW5rLCBvbmx5IG5lZWQgbW9kaWZ5IGNvbW1p
dCBtZXNzYWdlKS4NCg0KQW55d2F5LCBvbmx5IG9uZSBwYXRjaCBbNF0gaXMgbm90IGluIHVzYi10
ZXN0aW5nIGJyYW5jaCBkdWUgdG8NCmNvbmZsaWN0cywgSSdsbCBmaXggaXQgYW5kIHNlbmQgb3V0
LCBzb3JyeSBhZ2Fpbi4NCg0KDQpbMV0uIFNlcmllcyA9IFtuZXh0LHYyLDEvNl0gUmV2ZXJ0ICJ1
c2I6IHhoY2ktbXRrOiByZWxheCBUVCBwZXJpb2RpYw0KYmFuZHdpZHRoIGFsbG9jYXRpb24iDQpo
dHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvbGlzdC8/
c2VyaWVzPTUzNzQ3MQ0KDQoNClsyXS4gU2VyaWVzID0gW1JFU0VORCwxLzldIGR0LWJpbmRpbmdz
OiB1c2I6IG10ay14aGNpOiBhZGQgb3B0aW9uYWwNCnByb3BlcnR5IHRvIGRpc2FibGUgdXNiMiBw
b3J0cw0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVr
L2xpc3QvP3Nlcmllcz01MzI1OTUNCg0KDQpbM106DQoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5l
bC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8xNjI5MTg5Mzg5LTE4Nzc5LTItZ2l0
LXNlbmQtZW1haWwtY2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbS8NCltSRVNFTkQsMi85XSBkdC1i
aW5kaW5nczogdXNiOiBtdGsteGhjaTogYWRkIGNvbXBhdGlibGUgZm9yIG10ODE5NQ0KDQpbNF06
DQoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9w
YXRjaC8yMDIxMDgyNjAyNTE0NC41MTk5Mi02LWNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20vDQpb
bmV4dCx2Miw2LzZdIHVzYjogeGhjaS1tdGs6IGFsbG93IGJhbmR3aWR0aCB0YWJsZSByb2xsb3Zl
cg0KDQoNCj4gDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQo=
