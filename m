Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894A843F92F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 10:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhJ2Isd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 04:48:33 -0400
Received: from mail-eopbgr60043.outbound.protection.outlook.com ([40.107.6.43]:2542
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232536AbhJ2Isc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 04:48:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0ezt4ghx2+3LzEfdfTYjtMBNB6Dlw3OB3ydBDxlu0v93jC3WxRbmAQnEplzBNpILHflJORzgwPYFm/Xy2Fipq+QC9GdouyMsdQWnmLD2xQfJuwnWD5U9QETD5+ZKYFqKLV+ReKPlklGIFQgL7R0S3RIBdRXQDEVLgM3hTjNe1lWbMS0QQ7jIWzzertaODr5lYGg/qMoPl0T+PgpxBQCo5Vx3ze9WdQt9SDMTnkVq/GCaI1x7YecHPstxWFjv8Zsb8gqdkiJrhXA4wElKQZ3nBYnkCD52Ac9P+8oXWtbm4lnaAckIJqODZTxT6Ncw0oS0UFe7/jeKhRZI1RjKLMWyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTDStIBRGBai6k4Sg8TuqljLsBE7qGaTiJhoA58k70s=;
 b=aeNL0DV6cXdglsqukM3w3F3s25h4bbGJGM5dJ0RWkNtbq7c5pEc1E7dCGg8qImBZk37l4/TFtU8G74/YtXUpVC8SdiwXVw6EDpHq8zbJSwx6fdkg5oG7BUuI5S9Kedzcts+/gpKBjJIcfy6k9L9pzGlkw7lqI79jKglrK2zCHrIfdtPawLgyI+CPS8Zgm0mwFYm9QnwH+e0Uv17qyQFAWv1mtgFRpk0nu4OvGXJBeYqwAigCy5IKY85VU3ta61ZOLnj28/2AUpw58Fcz4u5p9sRVbV7kf4o25Es835ada8jA+Xk0JcgGgFvrh7ahd42IrhjnAAZ6WVSUMr84A8solA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTDStIBRGBai6k4Sg8TuqljLsBE7qGaTiJhoA58k70s=;
 b=smnlvpgPT2FWdnJcUMWMU1LzWPGHHdE3voaCeuDVmQmDF5vfMKotQr6jzYPFGiXuJyfu9fsV2+JHR3ZzpxXtlb2jJorEmsUAP0VFHGSR7KzwYsDTZG9GgtFazlkGoJNpd5uRTFQNZGSysies+2+CwjlOR0/Xmi5a4PITnWhFtXc=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB9128.eurprd04.prod.outlook.com (2603:10a6:20b:44b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Fri, 29 Oct
 2021 08:46:01 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%5]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 08:46:01 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v4 7/8] arm64: dts: imx8mm-evk: Add the pcie support on
 imx8mm evk board
Thread-Topic: [PATCH v4 7/8] arm64: dts: imx8mm-evk: Add the pcie support on
 imx8mm evk board
Thread-Index: AQHXy9DfGpvXEsXAsUWKOxCiXYHDmqvppE2AgAAGnLA=
Date:   Fri, 29 Oct 2021 08:46:01 +0000
Message-ID: <AS8PR04MB8676918E2FEDA00845BD31038C879@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1635406037-20900-1-git-send-email-hongxing.zhu@nxp.com>
         <1635406037-20900-8-git-send-email-hongxing.zhu@nxp.com>
 <ddd1606a22782bdf0ca81c8259eb8aeb2eb056b8.camel@toradex.com>
In-Reply-To: <ddd1606a22782bdf0ca81c8259eb8aeb2eb056b8.camel@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa28b11b-b29b-456c-75b5-08d99ab88914
x-ms-traffictypediagnostic: AS8PR04MB9128:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AS8PR04MB91282FBE6DFA6BCDB36A2D818C879@AS8PR04MB9128.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ELE9ynWVtQxYWghHUxetrWuk6cHtqSkkigkt1E8p9XTHqjPpm5YGICbdCuA37wu0frXwj04j6N9zwjcfV1JjSx9/x6tfuvVzo9YUGNJVbhdLA2HAiZt+GOiOwsyTP0VHPJXDSpymPlD/JP5VPYxzH9MUrs7RPg6jSqysaiETpaBlbZsy2EUgb+7updbGjcNT3tVeIr/7sLZr9KFWyRUae+vczOPfmqtmgqiul9MJYSbZh844TYiXN6a69rKMB58C6/7eZgS1hCtfaVOO96ny+LGPLch7SCHtG+CgOablsoIQNhnzFj4JKsqX0xUQTb4WYIEBwFDiu7zry7lH/GGBLI7ujaBO3GfEceJuK6v3uTC7q4kTDRm5Y+YdFulwRoK7b8ZalbKYESzF0e08M/xxoUzBDQK/8PPrrW64cKTFk0K6R9tTST9wiFYNhHtVGpNzihotqehb8/aZ/vPsWDcPuT45d6VddlqLeWoXrg02HVlHWX8EzxqNdiXZ5QJiQaepZ8a5JywvVj2VLhScCeGUvNPRWXH9cN5NQgx6p1YGnZvaq3BTyQCgVj8XcEfVcNuu8KL+fiixXK+X/XZVjuMtAe+zs2ZuPMF1LzIUrEqNF9d/ceeFT5Jg5ddzOJzye2848jzVRglIgGSR+YF2x6lqoemHe70gmceF3BhyxjbVeK5WpD+fy78rshaedFjP1IJdCsx2B3xV7HF0RI3CFNEvJv3EN76RaZyflFQS4MvbCeE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(186003)(66946007)(76116006)(4001150100001)(66476007)(64756008)(66556008)(66446008)(122000001)(8676002)(316002)(9686003)(71200400001)(4326008)(7416002)(38100700002)(53546011)(5660300002)(7696005)(55016002)(54906003)(52536014)(2906002)(508600001)(110136005)(6506007)(8936002)(26005)(33656002)(83380400001)(38070700005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXZaUldvcGZGZjRzYzBKaGIxYUdUZGtjMlFhUnZ3eXZOclJwV3VLdXFrZUxX?=
 =?utf-8?B?NWxHZzFvZ2Fkc3VTMlQ2MmtQNEZmUjFGVk93bnpxQXdMWk1Dd1R3clp3aVZj?=
 =?utf-8?B?Vy85VXlHM2tvUHA3OG5ZeWt2c2g2N3NJN2ltb0Y5dXVTVFYrKytPQUV2QWVF?=
 =?utf-8?B?cTEyT0kxK1phdFNhUTA5NE5nemNrV1RpOUFYSnYwOENsVWt2cVQzNmd5QXQx?=
 =?utf-8?B?UzMrVGw5Slc5Yk1PSm5mdGx5NE5QYm9CeWFJQVlNN3Z0ODAyM0FBQjB0TXRj?=
 =?utf-8?B?dzVGaW9vWjFnWm5BdFZpU0tMeU5QU1JuKzJqVW5oYk1QdW1leFZiNjJqT2Rp?=
 =?utf-8?B?bExzcThhc2NjL3Y0VGJxeW5vdnIxTUs1R0dhamJsekRZMTRWaVBYRXpOaCtD?=
 =?utf-8?B?d0tpYk90MFFEdnRKamlJajd0UkQ5NTNXTGtRTi9GeWtObVNMQkRUbVY5TENl?=
 =?utf-8?B?ZTV0ejhDcDNrQ05WNkVpZll2RHVieXIwZUxidG96YWhWR2MzUnVmdURGNk9y?=
 =?utf-8?B?R0YwRmlpNDlGZEFMbGJKVVdTclNNQlRWU2s1cUxpZk4xN3Fjdm5YMDZOcUVv?=
 =?utf-8?B?VW55MFB4aEFmd1NzTVZOcm42NGExQ3BJek8xSnBGeW5lc0dTTHNLcGtwTHJ6?=
 =?utf-8?B?UkVTSk12TzlXZllqYU1vMDNGOTQ5VG45dXM2V1NUV3pUNTRNV29zT0hQUUpY?=
 =?utf-8?B?RnhZdXVKZmE1MldGMXNpRTB2dzBoRFh1Um1XNmhCR2tDV2xEWDRGby9UTnR1?=
 =?utf-8?B?aEVHTGNmYWh5QUFRdHlkdXZJY3Zvc2UyUDVqY0phNmNkc3E3S2JUQmV2azFs?=
 =?utf-8?B?cFdvbmNucnlQb0ZmTlpZQ1Zqa043T3czWDVQRWRLNjJ1blVQREcrQ3lHODR0?=
 =?utf-8?B?L3ZqT3NLNzNPY2tkRGVZR3hHVkpTSDQ3eVFINUhvZ2NwUjFQZ04zY3REQmg2?=
 =?utf-8?B?SnB5eUNTbElWaE1CZzZXWGdtYW53aFRleE9tZnArV0w3ZlhsNmF2VGdIYUJw?=
 =?utf-8?B?WUh2ejErcHEyYzRuOUF4RFBGSW5OZTRYSVUzR1RGOXQ2TkEvQWE4YlhFcVRo?=
 =?utf-8?B?ajFrcWs3WWd0d1ZaeFAzOXBzbUo5V09NY0R4c3pGWUhBbkw3Ujc3bkJVVW05?=
 =?utf-8?B?RS9XSHUwZU9mRjZqcWdhZG83UC9keTFxeVdSRU56VUlLRHF6aUFIQndzRHBX?=
 =?utf-8?B?aWJneXNRRVJLSHF6eGV6UU5SQVpGSjhpUDYrcTIvR2Y4T0pNM25mZDZvZ0pu?=
 =?utf-8?B?SG9TTWtyM05tVUZmR2F4Ty9BZ2lqckI3T29DSUFtWUNodXlrSjNnZzBraTE0?=
 =?utf-8?B?a1V4LzRwaXM5NGYrMEhBeHF6VEVlbW9oUnYrRTA3Vi9WTGxqWVJybnNseTZa?=
 =?utf-8?B?TWp6VmQ0NEtEZFp3NFBEekRYZWpWQ1lxOEpVYS82ekdrMmNpOXN4UEE1RFlU?=
 =?utf-8?B?V2tDbC9sS3czNFJWQVNxQnFHL3Z4VW1pT0pRbUNjei9pOTZJQ2lpNllwY01a?=
 =?utf-8?B?YXQ3bytyeHFuYWs3RUg5U2RtdDZIVW1FSloxWEIwYUgreTVnUmNORjV2ck5t?=
 =?utf-8?B?dDQ5cUtpNEJOZ0FyNjNqK3RhZXVISzIwT2ZZVnVwMk5zMjdPL0J1RGtSRVNZ?=
 =?utf-8?B?c1c0UE5XYU1sdCtrSzhlcTJkakZsNzFHd3VEd25RcVVRU1c5djRBYjRGMWxW?=
 =?utf-8?B?SlhXbDdZeGhYN21QYnJkSVlJZ0MxMWl2a3FlM0I4VGhJdzBDM3pINFlYMXpG?=
 =?utf-8?B?ZEc4bmNIUWtwc3Nxenp1aGo1aUxnejZ2UDczckdKL1kva0NuMTdnZGZQUGFx?=
 =?utf-8?B?elNFdmJOaG95RFErQnZLckgram8xSThwclpNeWlhRVVJQ1RYelNoQ0FtbndC?=
 =?utf-8?B?U1g5bGdMYUEwWEx2Q08zd3hFMm9WeWhGYUFDdzJ2VitWekYwSmlKYlQ2Nk16?=
 =?utf-8?B?dWFPdFROeWVWOGJwSVArTG9pWjhRQU9aWlZicXQ5VEZYTWNUdzlUeTFqVGls?=
 =?utf-8?B?aXVOMmNUNnhYNHNJVS9CUERSb2NQTmdOZEpKblVwQUNDMGFudDZtK2FuNVA0?=
 =?utf-8?B?QnE3UUNncms4SmZyRGJYcmhVb3dxclFhRTZJbWtUUVI4ZTBzTHRNNzFsRE5L?=
 =?utf-8?B?V3l5N0hPTGNVRmUzbVVuSFdiL2VsK1ptUU9NSlgzSWQ5alZSbDVkbCtidjd6?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa28b11b-b29b-456c-75b5-08d99ab88914
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2021 08:46:01.2761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LN4KStCmyETN+1KrjPNU/PZUtZpZI7fvqGmyjg6RDG5NqTIbsezpLvT0m1NUOm1v8++qUgRQRZ/zizryJrNP1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9128
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjZWwgWmlzd2lsZXIgPG1h
cmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDI5LCAy
MDIxIDQ6MjEgUE0NCj4gVG86IGtpc2hvbkB0aS5jb207IHZrb3VsQGtlcm5lbC5vcmc7IHJvYmhA
a2VybmVsLm9yZzsNCj4gbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgc2hhd25ndW9Aa2VybmVsLm9y
ZzsNCj4gdGhhcnZleUBnYXRld29ya3MuY29tOyBnYWxha0BrZXJuZWwuY3Jhc2hpbmcub3JnOyBS
aWNoYXJkIFpodQ0KPiA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBsaW51eC1waHlAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0K
PiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDcvOF0gYXJtNjQ6IGR0czogaW14OG1tLWV2
azogQWRkIHRoZSBwY2llDQo+IHN1cHBvcnQgb24gaW14OG1tIGV2ayBib2FyZA0KPiANCj4gT24g
VGh1LCAyMDIxLTEwLTI4IGF0IDE1OjI3ICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBB
ZGQgdGhlIFBDSWUgc3VwcG9ydCBvbiBpTVg4TU0gRVZLIGJvYXJkcy4NCj4gPiBBbmQgc2V0IHRo
ZSBkZWZhdWx0IHJlZmVyZW5jZSBjbG9jayBtb2RlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
UmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IFRlc3RlZC1ieTogTWFyY2Vs
IFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+ID4gLS0tDQo+ID4gwqBh
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0c2kgfCA1NQ0KPiA+ICsr
KysrKysrKysrKysrKysrKysNCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA1NSBpbnNlcnRpb25zKCsp
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14
OG1tLWV2ay5kdHNpDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0t
ZXZrLmR0c2kNCj4gPiBpbmRleCBlMDMzZDAyNTdiNWEuLmZjMTgwM2E4YWY1YiAxMDA2NDQNCj4g
PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0c2kNCj4g
PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0c2kNCj4g
PiBAQCAtNSw2ICs1LDcgQEANCj4gPg0KPiA+IMKgL2R0cy12MS87DQo+ID4NCj4gPiArI2luY2x1
ZGUgPGR0LWJpbmRpbmdzL3BoeS9waHktaW14OC1wY2llLmg+DQo+ID4gwqAjaW5jbHVkZSA8ZHQt
YmluZGluZ3MvdXNiL3BkLmg+DQo+ID4gwqAjaW5jbHVkZSAiaW14OG1tLmR0c2kiDQo+ID4NCj4g
PiBAQCAtMzAsNiArMzEsMjMgQEAgc3RhdHVzIHsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoH07DQo+ID4gwqDCoMKgwqDCoMKgwqDCoH07DQo+ID4NCj4gPiArwqDCoMKgwqDC
oMKgwqBwY2llMF9yZWZjbGs6IHBjaWUwLXJlZmNsayB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2siOw0KPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgI2Nsb2NrLWNlbGxzID0gPDA+Ow0K
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2xvY2st
ZnJlcXVlbmN5ID0gPDEwMDAwMDAwMD47DQo+ID4gK8KgwqDCoMKgwqDCoMKgfTsNCj4gPiArDQo+
ID4gK8KgwqDCoMKgwqDCoMKgcmVnX3BjaWUwOiByZWd1bGF0b3ItcGNpZSB7DQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsN
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGluY3RybC1uYW1lcyA9ICJkZWZh
dWx0IjsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGluY3RybC0wID0gPCZw
aW5jdHJsX3BjaWUwX3JlZz47DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJl
Z3VsYXRvci1uYW1lID0gIk1QQ0lFXzNWMyI7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDMzMDAwMDA+Ow0KPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzMzAwMDAw
PjsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ3BpbyA9IDwmZ3BpbzEgNSBH
UElPX0FDVElWRV9ISUdIPjsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZW5h
YmxlLWFjdGl2ZS1oaWdoOw0KPiA+ICvCoMKgwqDCoMKgwqDCoH07DQo+ID4gKw0KPiA+IMKgwqDC
oMKgwqDCoMKgwqByZWdfdXNkaGMyX3ZtbWM6IHJlZ3VsYXRvci11c2RoYzIgew0KPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQi
Ow0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGluY3RybC1uYW1lcyA9ICJk
ZWZhdWx0IjsgQEAgLTI4OSw2ICszMDcsMzANCj4gQEANCj4gPiBwY2E2NDE2OiBncGlvQDIwIHsN
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgfTsNCj4gPiDCoH07DQo+ID4NCj4gPiArJnBjaWVfcGh5IHsN
Cj4gPiArwqDCoMKgwqDCoMKgwqBmc2wscmVmY2xrLXBhZC1tb2RlID0gPElNWDhfUENJRV9SRUZD
TEtfUEFEX0lOUFVUPjsNCj4gPiArwqDCoMKgwqDCoMKgwqBmc2wsdHgtZGVlbXBoLWdlbjEgPSA8
MHgyRD47DQo+ID4gK8KgwqDCoMKgwqDCoMKgZnNsLHR4LWRlZW1waC1nZW4yID0gPDB4Rj47DQo+
IA0KPiBVc3VhbGx5LCBoZXggbm90YXRpb24gdXNlcyBsb3dlci1jYXNlIGxldHRlcnMgaW4gZGV2
aWNlIHRyZWVzLg0KW1JpY2hhcmQgWmh1XSBPa2F5LCB3b3VsZCBiZSBjaGFuZ2VkIGxhdGVyIGlu
IG5leHQgdmVyc2lvbiBsYXRlci4NClRoYW5rcw0KDQpCUg0KUmljaGFyZA0KPiANCj4gPiArwqDC
oMKgwqDCoMKgwqBjbG9ja3MgPSA8JnBjaWUwX3JlZmNsaz47DQo+ID4gK8KgwqDCoMKgwqDCoMKg
c3RhdHVzID0gIm9rYXkiOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArJnBjaWUwIHsNCj4gPiArwqDC
oMKgwqDCoMKgwqBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiA+ICvCoMKgwqDCoMKgwqDC
oHBpbmN0cmwtMCA9IDwmcGluY3RybF9wY2llMD47DQo+ID4gK8KgwqDCoMKgwqDCoMKgcmVzZXQt
Z3BpbyA9IDwmZ3BpbzQgMjEgR1BJT19BQ1RJVkVfTE9XPjsNCj4gPiArwqDCoMKgwqDCoMKgwqBj
bG9ja3MgPSA8JmNsayBJTVg4TU1fQ0xLX1BDSUUxX1JPT1Q+LCA8JmNsaw0KPiA+ICtJTVg4TU1f
Q0xLX1BDSUUxX0FVWD4sDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8JnBj
aWUwX3JlZmNsaz47DQo+ID4gK8KgwqDCoMKgwqDCoMKgY2xvY2stbmFtZXMgPSAicGNpZSIsICJw
Y2llX2F1eCIsICJwY2llX2J1cyI7DQo+ID4gK8KgwqDCoMKgwqDCoMKgYXNzaWduZWQtY2xvY2tz
ID0gPCZjbGsgSU1YOE1NX0NMS19QQ0lFMV9BVVg+LA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPCZjbGsNCj4gSU1YOE1NX0NMS19QQ0lFMV9D
VFJMPjsNCj4gPiArwqDCoMKgwqDCoMKgwqBhc3NpZ25lZC1jbG9jay1yYXRlcyA9IDwxMDAwMDAw
MD4sIDwyNTAwMDAwMDA+Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoGFzc2lnbmVkLWNsb2NrLXBhcmVu
dHMgPSA8JmNsayBJTVg4TU1fU1lTX1BMTDJfNTBNPiwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPCZjbGsNCj4gSU1Y
OE1NX1NZU19QTEwyXzI1ME0+Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoHZwY2llLXN1cHBseSA9IDwm
cmVnX3BjaWUwPjsNCj4gPiArwqDCoMKgwqDCoMKgwqBzdGF0dXMgPSAib2theSI7DQo+ID4gK307
DQo+ID4gKw0KPiA+IMKgJnNhaTMgew0KPiA+IMKgwqDCoMKgwqDCoMKgwqBwaW5jdHJsLW5hbWVz
ID0gImRlZmF1bHQiOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqBwaW5jdHJsLTAgPSA8JnBpbmN0cmxf
c2FpMz47DQo+ID4gQEAgLTQwNiw2ICs0NDgsMTkgQEANCj4gTVg4TU1fSU9NVVhDX0kyQzNfU0RB
X0kyQzNfU0RBDQo+ID4gMHg0MDAwMDFjMw0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgPjsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgfTsNCj4gPg0KPiA+ICvCoMKgwqDCoMKgwqDC
oHBpbmN0cmxfcGNpZTA6IHBjaWUwZ3JwIHsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZnNsLHBpbnMgPSA8DQo+ID4NCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBNWDhNTV9JT01VWENfSTJDNF9TQ0xfUENJRTENCj4gX0NMS1JFUV9C
wqDCoMKgIDB4NjENCj4gPg0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoE1YOE1NX0lPTVVYQ19TQUkyX1JYRlNfR1BJTw0KPiA0X0lPMjHCoMKgwqDCoMKg
wqAgMHg0MQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA+Ow0KPiA+ICvCoMKg
wqDCoMKgwqDCoH07DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoHBpbmN0cmxfcGNpZTBfcmVn
OiBwY2llMHJlZ2dycCB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZzbCxw
aW5zID0gPA0KPiA+DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgTVg4TU1fSU9NVVhDX0dQSU8xX0lPMDVfR1BJDQo+IE8xX0lPNcKgwqDCoMKgwqDCoCAw
eDQxDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoD47DQo+ID4gK8KgwqDCoMKg
wqDCoMKgfTsNCj4gPiArDQo+ID4gwqDCoMKgwqDCoMKgwqDCoHBpbmN0cmxfcG1pYzogcG1pY2ly
cWdycCB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmc2wscGlucyA9IDwN
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBNWDhN
TV9JT01VWENfR1BJTzFfSU8wM18NCj4gR1BJTzFfSU8zDQo+ID4gMHgxNDENCg==
