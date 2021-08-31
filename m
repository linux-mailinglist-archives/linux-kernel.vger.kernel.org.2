Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0615B3FC687
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 13:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241407AbhHaL1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 07:27:15 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:21003 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241387AbhHaL1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 07:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630409179; x=1661945179;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xyfLpAvn4rKjZ1i0weiOHdtjrfatBqhRj7Pm8ihM6dY=;
  b=aieS2GVuYgvLlGrO9hujz2sQvTIZqUByCBYGUgZK/MtIFVvGa8jfS6UE
   0gDBW+0sVBntaG/JJ8r43oUmkHZXqPXp4NFHMvmQhOJS1S2nVr81Y0mXq
   TSQ5xf1ByVjQ8WscT4s8aNOCf72Kwqg0ta7AHPnVTEe8GE4NP8z1fVLZo
   ZFc+FppeTSntzEaqG45cAFHVZKJ/7kqpPGx8JXEq9ZkjVRCjZgvjuY5DX
   WdGi00qWtzqws0Alkp5zr3q6ukx52A0km36XEl5hgB8d935fBL/pucPJy
   hnwEoMcCiePswYmhIPNLXMwcGUFTKrsnSkAbLfEYEnjdo2GgkYHrCb9ls
   A==;
IronPort-SDR: 7gPURcgZX0Ten0iS0WADz0JqS3Z7jSbTcxuLlrBr1N+9nvmm/WHnFUxYr4NiabeQ/qyMr4fVCu
 r+uk++QHO9ZYOeHjodBHtcXSWMbrIiaK6e9QPtpQ0deBg3Ntbruw+GnGR8vunuTR9AlFJ8GSc7
 UrEE+7GYEKe8Xk575i9KL76/nRi3RLi7H1psbWTSUHh5Ytm2RGZrYDaF7eUX3chpQ2fPbnqZf8
 PGbr5guFiBGDc6kH9b9SflsAh+5FQHtPGsB7jtBYJ2ROtx5BdwFUyEQdbrmXa8PGWptrsd1QOD
 A+Q/lPSewTs6XOu5Vv2gWV+q
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="134800191"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2021 04:26:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 31 Aug 2021 04:26:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Tue, 31 Aug 2021 04:26:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sy5TPzDuou1T3p+JATEJkWNRfLOBVRRQFtea3WcUHJCTM4uGb18h+//8ShT5ZhBdbzjYlSONTc52FqmrPbJ2bef3KZUCUaG2GQtDITjBwKJGwGbZEMzCMcCoY6tWT9Djb40oOpG8qaR2g2QSyWnV8xFgFP9/Lc236ShGENapFVtc/9I9RlWUhPl4MznizB4RKuhp7P0aem8KuF/wLPXLNQ+8ybuenMYRp/MFZ0R+RHhBEGAG5sDnC7KEd1dL5zBqoRD5c/WkAUPYSPe8Ipz0ADBXYyd9pkuTDY4aXWfykOjzRe2DGUMfqhYPtpmqucu60ZTKrPYgH4/mBYuGOgVVVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyfLpAvn4rKjZ1i0weiOHdtjrfatBqhRj7Pm8ihM6dY=;
 b=Zj8QlNcCM2HEgeQM8nxomAtTFVTeNmC9FE2AI1iHhwNlAwCj3D9Fz8ARIxTYeUpgJuRkPERKaL96GcTSX8gsoFsNVTeXVa+fJj6OCLgNTAHoFO7aRtii7ptfvp8ZzPQnGMvmIVtB+/VhvYkALKh3PmokgQ9vxmWpDLfRbBLeOXC/niiO4QQ59thtUAuXMZ8d5qAUxeURX1MNAKAPhQJ+gNg+NnSfuiYjgYccllrkgO8IeIfjG+LXs520TShXSiuNJJ576JmHWo/djiQBeNN8opjSe9rVaWXevRT4Xpr5D39z/3hyRmZivufmZmzKVKyhioizM7bDFnGkFE/ehyzgAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyfLpAvn4rKjZ1i0weiOHdtjrfatBqhRj7Pm8ihM6dY=;
 b=UGsWGWIS/nrKhNd8kfXjCcvqPMZ7++5qZAlD2jHAdMwG/V30KzkB/U+mfwt1WzUe2ur8YMUldg/gu/asTY1bI8sccHcmyt9fpKVkZOujbINVPD9tTbiEwns8015U9dCXT/+yRm1g8tpFFd+7eMW1iwuEOyVp3an0qWY9UJqCp20=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by MWHPR1101MB2128.namprd11.prod.outlook.com (2603:10b6:301:55::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Tue, 31 Aug
 2021 11:26:14 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::d96a:4568:b553:97a4]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::d96a:4568:b553:97a4%9]) with mapi id 15.20.4478.017; Tue, 31 Aug 2021
 11:26:14 +0000
From:   <Conor.Dooley@microchip.com>
To:     <geert@linux-m68k.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <atish.patra@wdc.com>
CC:     <bin.meng@windriver.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <bmeng.cn@gmail.com>
Subject: Re: [PATCH v2] riscv: dts: microchip: mpfs-icicle: Fix serial console
Thread-Topic: [PATCH v2] riscv: dts: microchip: mpfs-icicle: Fix serial
 console
Thread-Index: AQHXmn0dSEF9gIZ8yUq0D/Rfd1OWp6uNgQiA
Date:   Tue, 31 Aug 2021 11:26:13 +0000
Message-ID: <986c2460-dc5c-44f8-67b1-526cd9dfc4e1@microchip.com>
References: <01b0aaeb50a960e36077669449a854e5d4c18a83.1629983839.git.geert@linux-m68k.org>
In-Reply-To: <01b0aaeb50a960e36077669449a854e5d4c18a83.1629983839.git.geert@linux-m68k.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00e9b8ba-8780-4078-620e-08d96c722445
x-ms-traffictypediagnostic: MWHPR1101MB2128:
x-microsoft-antispam-prvs: <MWHPR1101MB2128C48D46FACD8B67F9ECEA98CC9@MWHPR1101MB2128.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K/iVeV1ozX63aDOLVj8WztLYuyyw817tyKpb1U7n1DqrL0/4powReF4t04jEUi/sL+FPmvtGrv7arZSxvl38tUHEatZ674Kc9CTxWkCEfzOrUif9WPBbMlAFAIk7A3eHrn5I5zJ1z1p9Xvku2RXCUuO0TTLq+SmAKLqUgOHE/P1hL1IrqP3RW3nyNFQ7/Bo5/UaNJM9oOM+4VxGnsxmrzLHyxkYN+BohMo71kO035om2TY5pSEZM4F46lMXkwIJFfn6/KdAoY6dUhOFW3W04BKIMa6yFOGowVhiXMuXpLuScHMJvp5ZKgtYQFbfduxDVGVbvah2n6QpXLdp6m/gtaxuZegHS0ssKAiK3WqZsnWF4GV8aZEJ9JekCiaaMKabdPQUP5x/JHB3/VMpeFVbx8kieRYUB9l51cR83wZdFikBeMPKBfNrPrvTdGjxHZYnvFe6ztzBCl3VOsjp6Ng1Q2BhXz09VXKnCvaVsBXcmu0uHCq54Xzi3BNbZfKjgJutbLCEQ38+R0OkO75+vyF/3dns5Wf3XMx54ec0LdaKYQM72DT8ZmpYCgd8/OA8ku5PtZ7dcNk45uMgGhAlcVWZ06aNJs61YrV0m69Of4O4/OdXMTzB+ufe0zWWWROxwpwoT1JUP07NiHeRcsxaMPoGLOrSr0/nTPI3qATbWZliKbCiFuhHCHKs8T8P/3/EMmQ2dRwBGtQLQ/5d7DJfFU3YObwy4/NaIucaq/FVETRgzbPh4JoFuokQo7KyWFWE3cqfoGuyUs//6Vdb5b53DaKadJl8FXMsBWdwEZI7MdNsWwKh9+++5kXjvHXst02Px9Mx6Bq+wMYiRMa83YpAap7pSCkK6Fzl6O2u8gguc8TbjgKs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(396003)(376002)(136003)(366004)(2616005)(2906002)(122000001)(110136005)(8936002)(38100700002)(6486002)(478600001)(31696002)(8676002)(54906003)(26005)(4326008)(71200400001)(186003)(316002)(66446008)(6512007)(64756008)(91956017)(66476007)(86362001)(5660300002)(76116006)(66556008)(31686004)(53546011)(6506007)(36756003)(83380400001)(66946007)(966005)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHIwZ3l5akx1emthdHZVbVFmMW1oNTFLTTZnUzV0eDJGeDczMVhqYWpFbG40?=
 =?utf-8?B?UEE3cTQ2MVg2NXRQb3R4MzM0dVM3VDVocnNyTHBibVJqVmxrVUJHUkVGSkMr?=
 =?utf-8?B?QzVQS2sreXEyakNFMklwYjNPR0xtaDVKVjJFUEhIWjk3ZDRSWE40MklSb1kv?=
 =?utf-8?B?VTRnQ3ZYRzZTMm0zd25oVEFOeUpZTjhVb0RMSzA3TDhSc282OXRGbUlxNk9W?=
 =?utf-8?B?cWtBME9OcERmMWV1UkdRd21CVE9zVEQvNE5HT2dkeXJMQm93dmVUYWV2d0JY?=
 =?utf-8?B?SG5XcjduNTFDVThxMWkyNVQwT2FKTmIreVFNL1lwdnRKWTF4c2VJN3JRcTZO?=
 =?utf-8?B?VzVXL0wxOVU2eHVPbCtjMzJ5RndFOGtFQkxjVVkwSmZmZ2h1MHF3NmJWWVVF?=
 =?utf-8?B?SGxuZFdxRTcvN3FSRXBGb3BFYmdTNTFsa3JqTTY1QmxsZ1UxM2NjZnNZbkdz?=
 =?utf-8?B?bHh5eG9xelF2MnhNKzRNYXgvV1NKd0lkTWpQWGVyekprSlIrWHZuVVlGTHll?=
 =?utf-8?B?dGVybXdKOGNaM2ZRYmxLNXVnU3ZjTmpxNkhzOXUxZ0N4bkdnQjdVdGs3MUhL?=
 =?utf-8?B?a1VOcWlqNGxmUXJBRWU4WmRTZ2MraXR6dUhQcDVDdzJNamRUZm5iTVlySi9C?=
 =?utf-8?B?ZlRqRkFsY05lLzl6aVBEU2gxWkErUVhCSUVCM01UbzV1bkR1NGxkNjNWeElX?=
 =?utf-8?B?L2JScVJ1YVlZenVsb2NaOHlMeHNGS3Y2ZEgyZXRrc3Rwc3l4L0dJOGIrVmdJ?=
 =?utf-8?B?V1dzVW5WRXRHeW1FbWpJekNiMWRrNnlCZ3ZjRkQ3SHhrenZ4V0FMSnBLOStB?=
 =?utf-8?B?RUNwaldoMElCaFVSbmxlZjNQaGtMVjN1NU8rMWxQb2dLem1pN2hSRlowRW96?=
 =?utf-8?B?Y3NWd0cxOUV2U0RtTGVkdmNDMFNCQWN0UENZbHZDRWhhK3hwUkc4ejNwZWNx?=
 =?utf-8?B?cFY2UTN1UEUySGV1TUVYZHJ0a0pXcENaYklMc09BMWRZQXA5Rkp0d3F5T2RZ?=
 =?utf-8?B?MnZjZS9LamQ3NmRBc0xBR1NUbFczTm9ycFQrdlFNWHVRd3dEOXpzRnRJbktk?=
 =?utf-8?B?NmNFMFhTbDdGNHVhVlowcXlVdldqUTU2YWx2akxvZnduUEppcXpUVXA3Vyto?=
 =?utf-8?B?cklLNy9zZzhjWVNRK20rWVZtdnluNVFBMU5EdTU0WjVzL2xNTlVqZ3FwbjB4?=
 =?utf-8?B?U0RqV05nUkkwYmxwWUh3SDBjZHJDRXo3dGRTRlJIUlVNcUM0bXdRanlEZytF?=
 =?utf-8?B?cWJXSVhaVzRUOVpVWlJpdldrUmFuUGE1SGhROUV2dHVaMEZ2dU9NM2pWNjY1?=
 =?utf-8?B?SFlSSnlRRFVndHJ6bFc2YU84NVZpYTBmdmpWNHFLS1A4MUlVbXBLeGJVV2xT?=
 =?utf-8?B?QnBQVlZ1eXpDKy9kUm96d0c1bnFNZ3g4ZVNVMldHSFFxZE9rSmZyWXlUNTBF?=
 =?utf-8?B?a0xzR0tCZXFrWGVGTk1NL0REQVhLVUtRcTVhblNSTEZpbk9tZjdwcW9oOFFa?=
 =?utf-8?B?YkJTTDRodkJBVVhuYmQvZWR0c3JCbnB6UUxFWkN5cTNtNS9HZjNPeU1mWmQ2?=
 =?utf-8?B?K1YrWm00ZXRwd2swVXF1d1dJbFNQSDVaQTg5R094cWxtOXhLV0RJY0JZQ2Zy?=
 =?utf-8?B?eEVuYzdpa2FMZm1jQlhaNlFlYUU4M0FOZkh5czhHTXZDN1dQL1NsRWxMOHBj?=
 =?utf-8?B?T2FCNVA2ajFseUszVExJZ1pCSUFYeVpDZUs0TzBKcCtjUis4YlVjWDdwbWNh?=
 =?utf-8?Q?2uU5yBuc7PYIGKJSDp9H103eeUGIxcW6XsZ2aaT?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF7697B6C5C76E4F9A04C548C9B337CE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e9b8ba-8780-4078-620e-08d96c722445
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 11:26:13.8949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sPpu/AJJdnJiDbXiV78qkMdQ5Wm8pbiM48PpzaDKoHlg1lTUvlCobpzmJuUi9woHwpdPCEopmdRGiN01lXidsDdT/AlhUpE4QGr4ZgC4v6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2128
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYvMDgvMjAyMSAxNDoxOSwgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOg0KPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4NCj4gQ3VycmVudGx5LCBub3RoaW5nIGlzIG91
dHB1dCBvbiB0aGUgc2VyaWFsIGNvbnNvbGUsIHVubGVzcw0KPiAiY29uc29sZT10dHlTMCwxMTUy
MDBuOCIgb3IgImVhcmx5Y29uIiBhcmUgYXBwZW5kZWQgdG8gdGhlIGtlcm5lbA0KPiBjb21tYW5k
IGxpbmUuICBFbmFibGUgYXV0b21hdGljIGNvbnNvbGUgc2VsZWN0aW9uIHVzaW5nDQo+IGNob3Nl
bi9zdGRvdXQtcGF0aCBieSBhZGRpbmcgYSBwcm9wZXIgYWxpYXMsIGFuZCBjb25maWd1cmUgdGhl
IGV4cGVjdGVkDQo+IHNlcmlhbCByYXRlLg0KPg0KPiBXaGlsZSBhdCBpdCwgYWRkIGFsaWFzZXMg
Zm9yIHRoZSBvdGhlciB0aHJlZSBzZXJpYWwgcG9ydHMsIHdoaWNoIGFyZQ0KPiBwcm92aWRlZCBv
biB0aGUgc2FtZSBtaWNyby1VU0IgY29ubmVjdG9yIGFzIHRoZSBmaXJzdCBvbmUuDQo+DQo+IEZp
eGVzOiAwZmE2MTA3ZWNhNDE4NmFkICgiUklTQy1WOiBJbml0aWFsIERUUyBmb3IgTWljcm9jaGlw
IElDSUNMRSBib2FyZCIpDQo+IFNpZ25lZC1vZmYtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2Vl
cnRAbGludXgtbTY4ay5vcmc+DQo+IFJldmlld2VkLWJ5OiBCaW4gTWVuZyA8Ym1lbmcuY25AZ21h
aWwuY29tPg0KPiAtLS0NCj4gdjI6DQo+ICAgIC0gQWRkIFJldmlld2VkLWJ5LA0KPiAgICAtIFJl
YmFzZSBvbiB0b3Agb2YgNDE3MTY2ZGRlYzAyMGM0ZSAoInJpc2N2OiBkdHM6IG1pY3JvY2hpcDog
QWRkDQo+ICAgICAgZXRoZXJuZXQwIHRvIHRoZSBhbGlhc2VzIG5vZGUiKSwgYXMgcmVxdWVzdGVk
IGJ5IEJpbi4NCj4gLS0tDQo+ICAgYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbWljcm9j
aGlwLW1wZnMtaWNpY2xlLWtpdC5kdHMgfCA2ICsrKysrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlz
Y3YvYm9vdC9kdHMvbWljcm9jaGlwL21pY3JvY2hpcC1tcGZzLWljaWNsZS1raXQuZHRzIGIvYXJj
aC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbWljcm9jaGlwLW1wZnMtaWNpY2xlLWtpdC5kdHMN
Cj4gaW5kZXggYmFlYTdkMjA0NjM5YTE4NS4uYjI1NGM2MDU4OWExY2M4YiAxMDA2NDQNCj4gLS0t
IGEvYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbWljcm9jaGlwLW1wZnMtaWNpY2xlLWtp
dC5kdHMNCj4gKysrIGIvYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbWljcm9jaGlwLW1w
ZnMtaWNpY2xlLWtpdC5kdHMNCj4gQEAgLTE2LDEwICsxNiwxNCBAQCAvIHsNCj4NCj4gICAgICAg
ICAgYWxpYXNlcyB7DQo+ICAgICAgICAgICAgICAgICAgZXRoZXJuZXQwID0gJmVtYWMxOw0KPiAr
ICAgICAgICAgICAgICAgc2VyaWFsMCA9ICZzZXJpYWwwOw0KPiArICAgICAgICAgICAgICAgc2Vy
aWFsMSA9ICZzZXJpYWwxOw0KPiArICAgICAgICAgICAgICAgc2VyaWFsMiA9ICZzZXJpYWwyOw0K
PiArICAgICAgICAgICAgICAgc2VyaWFsMyA9ICZzZXJpYWwzOw0KPiAgICAgICAgICB9Ow0KPg0K
PiAgICAgICAgICBjaG9zZW4gew0KPiAtICAgICAgICAgICAgICAgc3Rkb3V0LXBhdGggPSAmc2Vy
aWFsMDsNCj4gKyAgICAgICAgICAgICAgIHN0ZG91dC1wYXRoID0gInNlcmlhbDA6MTE1MjAwbjgi
Ow0KPiAgICAgICAgICB9Ow0KPg0KPiAgICAgICAgICBjcHVzIHsNCj4gLS0NCj4gMi4yNS4xDQoN
Ckxvb2tzIGdvb2QsIHdlJ3ZlIHN3aXRjaGVkIHRvIHVzaW5nIHRoaXMgb3Vyc2VsdmVzLg0KUmV2
aWV3ZWQtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQoNCj4N
Cj4NCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4g
bGludXgtcmlzY3YgbWFpbGluZyBsaXN0DQo+IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5v
cmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1y
aXNjdg0KDQoNCg==
