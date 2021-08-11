Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8883E8B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 10:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbhHKIIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 04:08:31 -0400
Received: from mail-eopbgr140048.outbound.protection.outlook.com ([40.107.14.48]:37754
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236083AbhHKIFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:05:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTIJmt0ZOGNZw/uaHPViqiyLRAzppak7mDbckkjQPIPsMMt7ILDy5ybbppD5AXVkfAigPOwGfVY4ZsX64phUp8/opfUxhZAjtSh4zRvEZ7HLx2r5Bi4wKMnRmVh0/TmgoiBflfnJsuk/DN+NV08sr+4RrMf755yXhv8ijHiq5KU8xyLpR0VIRpFEfDfWiTnPffdJPYmH0mWGTzET/W95Zt0o3p/xbhpAE0117fSWWjTHH4E7l/PWyeWMVMOG9zXeT+eWUrkfZH5gDQHjg0cLLYcSz4L9PlPIsl3N7kbDdjwkTW0eK7/QEmnvNY3NyVxVthpgXCTS1ZPFLqmbtcscIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6L9cLQ9q6fhA+4g5OaJ/3TfDs2xmrBeWuFPIxaOv7A=;
 b=BpXpzqlblvjXGuh2OHpyCcuiSmrjohKdFdkSxwruseZPZFbu0jdb+4l82aLLo1VpiQNEmXemqAFygt5WmUvzE1QaRhiHPS+itkKSE3M7EDRwohCA4WZ0aBUbhLrxmvVHuYFJv5xVs2Ty6zN5xQsoSl/lIUfmgdmjEAHJymFFeNSMofpAY9+e9TX5aPjy2XO763BNunqgJuNs77uAwD9SvTfKpUFoMWjRrUairrtZkcYStzJIBcEHGXadY/Ywu1sTUkg+mavMB1ilMKd3RdQvSNVnrMntAe61ur1849kVuihmXhVauMRQvbPqX7TkwfOL/bCOiGdYTHN2FcpbGxcZqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6L9cLQ9q6fhA+4g5OaJ/3TfDs2xmrBeWuFPIxaOv7A=;
 b=HLsgF+/B/hYK/N3+fdeaUXGPX0P03TzV7Wpbfwq/omB0t/rJRFiL9aK3yiahLOu72X1rPZ8pcAwQbubYYdtlIhpRw2zdLa6M3XHdo0/uA0vvz9j1TZwZKPWrQOayGkSRlsUH80nVgq/6TTRxCvCwkeeQ8bfm5Np6Bj1W4SGH6Hc=
Received: from VI1PR04MB6800.eurprd04.prod.outlook.com (2603:10a6:803:133::16)
 by VE1PR04MB7454.eurprd04.prod.outlook.com (2603:10a6:800:1a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.26; Wed, 11 Aug
 2021 08:05:06 +0000
Received: from VI1PR04MB6800.eurprd04.prod.outlook.com
 ([fe80::498:421b:7d3:a0c3]) by VI1PR04MB6800.eurprd04.prod.outlook.com
 ([fe80::498:421b:7d3:a0c3%8]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 08:05:06 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     =?gb2312?B?SmFuIEyouWJiZQ==?= <jlu@pengutronix.de>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V1 1/4] bindings: nvmem: introduce "reverse-data" property
Thread-Topic: [PATCH V1 1/4] bindings: nvmem: introduce "reverse-data"
 property
Thread-Index: AQHXjbpIBwDJH2bCBk6a1JjgGNijp6ts2VGAgAEYXzA=
Date:   Wed, 11 Aug 2021 08:05:06 +0000
Message-ID: <VI1PR04MB6800F6169275A323DE0FD782E6F89@VI1PR04MB6800.eurprd04.prod.outlook.com>
References: <20210810073510.18218-1-qiangqing.zhang@nxp.com>
         <20210810073510.18218-2-qiangqing.zhang@nxp.com>
 <17daf0f387dff8145559df6a983b0a222c100514.camel@pengutronix.de>
In-Reply-To: <17daf0f387dff8145559df6a983b0a222c100514.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5d0147b-8110-4435-b284-08d95c9ebb60
x-ms-traffictypediagnostic: VE1PR04MB7454:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB745484453A51BA04E261042BE6F89@VE1PR04MB7454.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gr4FFiQE5aPV1/JdkYX30EGZCFAtnr4unL8/amX6rETvohNaOJz8t0zlfxaiD+7Kg7GcXIu3N4epI0TjNyYZy7kUExUD5v91eyR2m6qV8U5rFa4WOV/Y5uKYPIEmO4CZ6+6vIGez2EtxOvP05q643kAHubMbBcyZR+Zf8+mibEufozv6Y703VldAt57T9QtJevc+Zn0qRRdrG/E72GVzks/XGWLJSL4NDK2lRsnBHfpCY8koMBJon742SddeUpt4daf3SpHRyMDh4UZvFt0I7uDVMuaPZ42OPHRL3rZY4L5kEwtEInpKPTegjYGw+ulLu0/XPoFNG9i/WDWJwFIDE3zX3fTGT9Uc6D14JaWKYob/XIQkosIFGNMOSIf/7H018j+V4tx+ZXcyYAL4rK/O2GuqatPA9n8fL5nIdWmISnEfl+up9FvFM1S7+ErKWMad6d4s+RJDSYwrtoqrzlbtNTaojEVzjRlAjKRTvQuSpR1xBQJZ3T0YQAV1arwo2Dq972ErF/QZ19uDvNm5uHdWD7QizhVsZbbzSEcwku7Ve5JOymYIIqj303EcZqxBIEm4kI8125JIKy4Y3GMGBjIKAgkqWDJMJ7yMMDCbbHjH2Pg8RKWu/LAYmioEXBCqoMTVd4UkR71ra7BNrJqmxunFIJaSAJ98sAT4C65OZudUHd6IID1mbRgx/sluz9LG7FdPv0D3HyV6thw+cWTEbb3Ao7eZ2HQ6xW8GZBcvR+TOWY9dkEu2S4IZduPxWnau8bqz2xVeevSYj+0yvIRVP31XXVOdSJrhChLa4bTZ1RbLVV8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6800.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(4326008)(66946007)(9686003)(76116006)(33656002)(66446008)(508600001)(66476007)(83380400001)(66574015)(45080400002)(71200400001)(55016002)(52536014)(66556008)(64756008)(110136005)(38100700002)(53546011)(8676002)(316002)(38070700005)(6506007)(2906002)(7696005)(122000001)(966005)(186003)(26005)(8936002)(86362001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VXlXS1ZjVy95NXYyOWpZbmRnZXo4SGFSY3cxMG96dUtuekhoQjNybFhBd3Zr?=
 =?gb2312?B?aTZUMXRCYVhWejRweTFCUXBNTWVjUURIbVBZOFROR3BCbEp1cHh2aXZaREVr?=
 =?gb2312?B?MUlmY0k2T1pXU1dTenNNVHZXNFZicWFoN0JKQ2Z2TmxIb3NhemlIUGlkMzFy?=
 =?gb2312?B?YnJtWW5vOVhzUFd1bDhSZFVQUWZGR0xFVnZCVnNaNW1lcDZzUjIwT1pGN3lJ?=
 =?gb2312?B?KzArZkxqMlVBWVBKQ1M3UGt0V0RaSWUvbDdsSHFlU21yeGJNZDEzWEhhOTgz?=
 =?gb2312?B?VTVwZVQ1TDd5NERNNGU5N3F5YUd0RlQvNENsVUVEemZTUm1iTWRPZHhQN1VC?=
 =?gb2312?B?MkxkVWVTZnJHbHZYeWFCMU1tVUdlRWlvNmxIVkRMZjdFUnFCRUUwWXJpMzE0?=
 =?gb2312?B?elBWVzlsek5sekxhUU8vUmNzTXdRWUdaODNtbDNIWmlOWkltSkdOcUVMTmVP?=
 =?gb2312?B?R1dGQmZlU21TcEQwY3lWaFptZ2dvbUJaVlp5RWFzazFyUnJMdFQwd2tTQzAv?=
 =?gb2312?B?MUpEN05oUlZDU2l2dTdTN0VrNWoxdFRGR1hUd2VxOFd3QlRFSk8wS3A5aDJh?=
 =?gb2312?B?MzlmR3UwSEVWd0FaU293OVRoSk9mUEU4ZTBxYWtZOFREUGN3eWJvVXBWYmli?=
 =?gb2312?B?NlNGV0pLOHluWkNrVDNFWmI3OHZlR0JyZWNmVmNaRVAyVFRSRTNUTmQ5OHlL?=
 =?gb2312?B?L0VaUEZzN1dhVUw0VkV5U2FKWDdMcFlPNDYzNWRnMDNsTGt6VUhPM0NpMHRX?=
 =?gb2312?B?TjJTQW1Pc3NkVDRzbGpjdms2WWZBc3FNZU1MTGtYOHE3UEhnbk8zeENWaUFt?=
 =?gb2312?B?VERmaXBseEtTTlBuWHBnTSthNlZrdDJweHVQZzFHdEYrVEIvSlFOV0llMHgr?=
 =?gb2312?B?bzRrQXI0V0Z2R3NrV1RwckgzR0hzVkF4QUUzUDBFMGx6NlRabStmeGVncG1x?=
 =?gb2312?B?Qk1xa0RnS3JGTmpFZE9vb1F3Mi9pUkc0NVlOazRTZENZYUxIV1EwbU5oaG1S?=
 =?gb2312?B?Y0M3MkVUQ2x4TDR5enJuZzRTWmhmUWRBZmN2b1pJaDdhczdwWVJKdGd6QVEy?=
 =?gb2312?B?YmljM2VmTVc2dkwrRHFmNkliNTZlMUo0LzBxQWdaaFVvSnZBdzZDMDdXaGJI?=
 =?gb2312?B?dVFZYlJVTWlZSVdJRlUvaUlSdEE3M2dZaEZ5NkFkRitoWHJvckplVkxHeXZt?=
 =?gb2312?B?VkJZSmxCenBYeHBzdkl1VHFGR3BlUEx2ZVJMd3ZQRFErODFIVFRJSTk2dWVG?=
 =?gb2312?B?dkNyOVByQkdoNzhWSEFpNUgxWW94aEZ4NkVtNDhJVUZodXFuYWtwYVZUR2I3?=
 =?gb2312?B?U0ptMkR4eEFoZ3RoVDhlZmVOaTQzbHk0bDF1Q1NyRWxDN2FtZEtlM0NEVE1j?=
 =?gb2312?B?bVhVWWhJTHBXZVBOZ1padDZ2YjUvQ2JVbEllR0VsR3BtdHFoNHF5akdWUW9G?=
 =?gb2312?B?OFRQZmtLNU4yMTYwUkRPVWt1eVEwbS9US0FPdHU1K0p4U0l1QlgyeFBmL2h5?=
 =?gb2312?B?ZHFBT1Y1dit1TmMzMlBheFlnRG5LZ3FhTHlJclNhblpDajJKU1Rrd2VDM1dV?=
 =?gb2312?B?T0ZQM0JuTmNDbFhHZmw4eXdTNVpjcFhtZm9FVFdTZ1hVVEVocTVPUnVid1Uy?=
 =?gb2312?B?ZmoxTFdXUHhUdFM0UG1GanFDREJTU0h5Nko1cmxOTXFFWXU0WDdzeXdwbGdI?=
 =?gb2312?B?dmZYNXlUSDBlcVQvVkwvZUVrZkdIa2wvVjZwQ1Y3WXlUM0lRZFhGVS9aR1dG?=
 =?gb2312?Q?qS+4pWZAHoX9QLHLYcFcJVLMb59mi5BuXipzL4M?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6800.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d0147b-8110-4435-b284-08d95c9ebb60
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 08:05:06.6148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0N7WZf4oXLIiHsIoDnKgQ0tEkeBD3NAOWBYdxCj5o8q4xVjwF7wGZhbWnqw/qCCsGVekbaMxsv6pFVRh27MgLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7454
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphbiBMqLliYmUgPGpsdUBw
ZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMcTqONTCMTDI1SAyMzoxNA0KPiBUbzogSm9ha2lt
IFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT47DQo+IHNyaW5pdmFzLmthbmRhZ2F0bGFA
bGluYXJvLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnDQo+IENj
OiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhw
LmNvbT47DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYxIDEvNF0gYmluZGluZ3M6IG52bWVtOiBpbnRy
b2R1Y2UgInJldmVyc2UtZGF0YSINCj4gcHJvcGVydHkNCj4gDQo+IE9uIFR1ZSwgMjAyMS0wOC0x
MCBhdCAxNTozNSArMDgwMCwgSm9ha2ltIFpoYW5nIHdyb3RlOg0KPiA+IEludHJvZHVjZSAicmV2
ZXJzZS1kYXRhIiBwcm9wZXJ0eSBmb3IgbnZtZW0gcHJvdmlkZXIgdG8gcmV2ZXJzZSBidWZmZXIu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0Bu
eHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bnZtZW0vbnZtZW0ueWFtbCB8IDUgKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9udm1lbS9udm1lbS55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbnZtZW0vbnZtZW0ueWFtbA0KPiA+IGluZGV4IGI4ZGMzZDJiNmU5Mi4uYmM3NDUw
ODNmYzY0IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9udm1lbS9udm1lbS55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL252bWVtL252bWVtLnlhbWwNCj4gPiBAQCAtNjEsNiArNjEsMTEgQEAgcGF0dGVyblBy
b3BlcnRpZXM6DQo+ID4gICAgICAgICAgICAgICAgZGVzY3JpcHRpb246DQo+ID4gICAgICAgICAg
ICAgICAgICBTaXplIGluIGJpdCB3aXRoaW4gdGhlIGFkZHJlc3MgcmFuZ2Ugc3BlY2lmaWVkIGJ5
IHJlZy4NCj4gPg0KPiA+ICsgICAgICByZXZlcnNlLWRhdGE6DQo+ID4gKyAgICAgICAgJHJlZjog
L3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvZmxhZw0KPiA+ICsgICAgICAgIGRlc2Ny
aXB0aW9uOg0KPiA+ICsgICAgICAgICAgUmV2ZXJzZSB0aGUgZGF0YSB0aGF0IHJlYWQgZnJvbSB0
aGUgc3RvcmFnZSBkZXZpY2UuDQo+IA0KPiBJJ2QgcHJlZmVyIGlmIGl0IHdhcyBtb3JlIGV4cGxp
Y2l0IHRoYXQgdGhlICpieXRlcyogd2lsbCBiZSByZXZlcnNlZC4gT3RoZXJ3aXNlIGENCj4gcmVh
ZGVyIG1pZ2h0IHRoaW5rIHRoYXQgdGhpcyBpcyByZXZlcnNpbmcgb24gdGhlICpiaXQqIGxldmVs
Lg0KDQpNYWtlIHNlbnNlLCBob3cgYWJvdXQgJ3JldmVyc2UtYnl0ZS1vcmRlcic/DQoNCkJlc3Qg
UmVnYXJkcywNCkpvYWtpbSBaaGFuZw0KPiBKYW4NCj4gDQo+ID4gKw0KPiA+ICAgICAgcmVxdWly
ZWQ6DQo+ID4gICAgICAgIC0gcmVnDQo+ID4NCj4gDQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4g
ICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+IHwNCj4gU3RldWVyd2FsZGVyIFN0ci4gMjEg
ICAgICAgICAgICAgICAgICAgICAgIHwNCj4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVj
dGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZ3d3cucGUNCj4gbmd1dHJvbml4LmRl
JTJGJmFtcDtkYXRhPTA0JTdDMDElN0NxaWFuZ3FpbmcuemhhbmclNDBueHAuY29tJTdDNzkNCj4g
M2E2MDE4ODU0MDQ1NTkxOWI2MDhkOTVjMTE4ODc4JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTlj
NWMzMDE2Mw0KPiA1JTdDMCU3QzAlN0M2Mzc2NDIwNTI2Mzc5OTQ3NDklN0NVbmtub3duJTdDVFdG
cGJHWnNiM2Q4ZXlKV0kNCj4gam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2
SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzENCj4gMDAwJmFtcDtzZGF0YT1TMjdPOEFWOGxSdkd4
eUV1dEpsNlVoNEFqYkFyRCUyQmt2UWwlMkZJMDVaVTFQOCUzRA0KPiAmYW1wO3Jlc2VydmVkPTAg
IHwNCj4gMzExMzcgSGlsZGVzaGVpbSwgR2VybWFueSAgICAgICAgICAgICAgICAgIHwgUGhvbmU6
ICs0OS01MTIxLTIwNjkxNy0wDQo+IHwNCj4gQW10c2dlcmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2
ODYgICAgICAgICAgIHwgRmF4Og0KPiArNDktNTEyMS0yMDY5MTctNTU1NSB8DQoNCg==
