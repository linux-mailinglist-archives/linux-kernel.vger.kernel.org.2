Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCCA3F468B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 10:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbhHWIV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 04:21:59 -0400
Received: from mail-eopbgr1400047.outbound.protection.outlook.com ([40.107.140.47]:2992
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235455AbhHWIV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 04:21:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9jHW8b2Gv7IC7MIrJ76xS6OMv97aE26mwl/l9/zTGlFL6/8idIMDL8mNnC3qIsGx5jYWRKWvotOkVZSqKpP94mvnZRmY+Uquv5iedAk2mNptlh9slRpjPRk5WwWmzLFRPVYo0BlJXCUqr8iBPDxIpj4rE61D0L12+oiw+4fLkCDXDi8/bekGVhru8euY0lCMf5YOHryZQJgFV8MdzeqdL2YbvrJuNXUFArXikUxmLdFRPseVWcpnH5GxC1I42iT+o+cFo2DgOdiZYCfCQI2WYF4/fwOuJqXgA4P/+DqrFmYY81luouvyDAvay8scWlxntCJXUGgsSlmGHE72bMZtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzdCnM3gkri8psNgzV1vKej0U2LZc8eJaBNgA/UtpHI=;
 b=YXYNOQJRUnH1ttwkmqOQwKn79W2QIdD3i4pH5V1vylTj0ffz48Sgg6vhhrBzxDHyeiklCq16B/RcBUhFgarryedptHmx5CDNjE3f7mumEIM/PFEiYNsav2FgLs8VJLsmC9iTz4yu8kNgwA+o+yRMmzzGSFrzbEI23jQk8ET1apznRNGTavpJQAirtFLjLf5b3PgbidbsGX7khnWh9QpVObbXmEasPB5EJKR1CIVR4BrfZNJa+454fQiwDZBeG9U6CaC9l4PKErLPiVMVzZnfM7wXVCH8EjGSJ8Vb87XHgsxuWv7/UCdGWQJCP5tthT+MTg/9rwLlSbue8IIVjV+Enw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzdCnM3gkri8psNgzV1vKej0U2LZc8eJaBNgA/UtpHI=;
 b=PmcQgAPhSOnZxcDzMcg2bgn9COXCxEo/fQKVUACVqRz+SP2/G9hTD0TFWlEwD7FD9bB4Nr9sqYYcmlodhfBelKTog1aQ4Bdj9w54zqiszIPrvwWmRXr0kqwZy0gmGnUw5r4OzKWKLcCEvJNqAxH4mzknDf3bUoMEjCoqUrQf1/0=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYCPR01MB5934.jpnprd01.prod.outlook.com (2603:1096:400:40::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Mon, 23 Aug
 2021 08:21:14 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0%7]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 08:21:14 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "cgoldswo@codeaurora.org" <cgoldswo@codeaurora.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] mm/memory_hotplug: fix potential permanent lru cache
 disable
Thread-Topic: [PATCH 2/3] mm/memory_hotplug: fix potential permanent lru cache
 disable
Thread-Index: AQHXlnDu4VOxhskvS0OxDQIUgKMkkKuAwsmA
Date:   Mon, 23 Aug 2021 08:21:13 +0000
Message-ID: <20210823082113.GB1520304@hori.linux.bs1.fc.nec.co.jp>
References: <20210821094246.10149-1-linmiaohe@huawei.com>
 <20210821094246.10149-3-linmiaohe@huawei.com>
In-Reply-To: <20210821094246.10149-3-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd62d397-dd13-4ad2-8ea6-08d9660ef8db
x-ms-traffictypediagnostic: TYCPR01MB5934:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB59349C301310CB66E0C7921FE7C49@TYCPR01MB5934.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y2s52mrrXGIK42QS9KLCGbdK1tKbpA5SaN57tKjRHZu4GqRu6+U9aGNEZWvzJDZUclwmkp5cP5igniMC0lj3J+urDLCHtM8n37NZ+/mHZkJVc69wbgKfnOH88p+54qHDEfqUvORq7hhSg/8yusDJr1aizfEGfj0c5a/Z3C7Y1D0BFsmvwvisEjCsOiilZ/fuEVBGvJZR9UNMrFOwmOlUztHL6pebavwdxcE5skcQtgIgs65P+RHzP4bk6ZySCReuzRqiJ1bLyBE/ULWdbkoOofdYjPwbAvWc5HFOjSD4qcLCpV7PnldV4s+QvREkBV0be44XH3fk2lQTd2SOMfrfurgg9m+yILuunglT+EndL3z2/G8+GDPRN9auSNbbUEJDaRj+BiNBr9iOKBFd9WrCWoI9WpZcmvSybjTm5Ka9pcbfo4jG0L80eUsxHe2JVH75AF/07tdX3kIlAZYqICaxiuHkZyAcwXJHxgD6E4hI+8egFGMJLlLGOtISGAq4R5Q4nZB8ZbtVX+dfU2rY+sb3Nl7q1x0wnntmXd16jbsCggGMrTjpsuGMfienhjw6L5Zo6oxwtXWB02EXAsWUc/fE54IuG+wBqrWUxjN3TO/jMuZSi9WTPkOh6WcXOYVjWC77Il1aheOvx/Yn/WRVUb4n+9k7ve53RxMbB1IwH29RwjJbXCfdqYskijTo64gIhAGt/N7lGYzLAALx4ACGm6w0mw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(26005)(85182001)(186003)(2906002)(6486002)(5660300002)(1076003)(38100700002)(38070700005)(8676002)(54906003)(9686003)(76116006)(66946007)(6512007)(4326008)(64756008)(66446008)(66556008)(66476007)(6916009)(316002)(8936002)(478600001)(33656002)(83380400001)(122000001)(71200400001)(4744005)(55236004)(6506007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dy90NFVBc2xYeFMrbUFFdlQwRGk3STNmTVVodDFXSGxULy85Y2JhQktsRjI1?=
 =?utf-8?B?cmNBWTlmclN6TVNFYWFMelpneFZRVEZtOVhsdDVZaEFjeTRLSDg0TzRnWGRL?=
 =?utf-8?B?YjE3cml3dVV0STBLank3Qml6L0JoMkYvRVNmMkJ2aW9ZMXFkTHptWEF0N24w?=
 =?utf-8?B?MXkvNnIvN0tQbnlWaDRGb1BWdDJta2VyQ2d4Qm50RDFINDY0SjlCRDdUN0l3?=
 =?utf-8?B?TEVJRzhIT3NSMGk5cURjUldaUkdzbVVJZnVOUzJLOFBHNlBVaVZnRlAzM2li?=
 =?utf-8?B?MkdieDQwNGZXc3BMc2RaUU96eWhIb2R5UTRmMjNIYURlamNuT2VHSFVMVDdK?=
 =?utf-8?B?eW9WSzRlVnNtRGRmeDhUTGhwYmZlbU9NcXdmQVBoVmxxc1lCV0pIZ0h5eHBT?=
 =?utf-8?B?QmpGc0d6UklxTW9FZlB6N3FycTh2eERscGMzWGhKV3phUTlMOHdXLzIvYWx5?=
 =?utf-8?B?cjBQaGxlcmM3WUMxbzV3Tm9oYjJiSFNYNkFPay9VVVp2RDVtd3ZkdE0xdlc0?=
 =?utf-8?B?MEhDbk5Bdkw4M3JVUGJUcHVrRDBuMXBhTzNHNGlKTm1vMVMyZFpRRU1tWUxk?=
 =?utf-8?B?aVBoUW80aWNkZHBzd3ZXNXdqOXYxbE9Bd1NabFBuY2VQYmdLZHI1QmJBYk1S?=
 =?utf-8?B?TXYwZVRVeGk4TU55S1hMSFMrUWZTME4rUEduTzQxVUd0MEtkTEliUGRlQjdB?=
 =?utf-8?B?NU9jN1pGdkxKUHZ0VnFyaWNFbUU0cGthWFF0TVBYclZNZ1FJQ0lXaGxKbCtL?=
 =?utf-8?B?enU3dG9ockorNkxFUFYvdytNdDdGaHpmanNqaTl1bkpWS3ZuUU9XV1hiVHN4?=
 =?utf-8?B?Z25heW03c0YyZ3JrRHA0aDdoOEtTQjkvaDhFbjlUMU0rRi9JWjY4TUc4MEJP?=
 =?utf-8?B?N0NSV25CMWxPZXFpeld3aFd4d3MwTnB3U045dTlRYitKY3BBdndtUS9kWlpC?=
 =?utf-8?B?b3BOTGRMR1QvVmV5aE9YdHU1YVdoZ0x5UTNNSHN6YTh6ek9lS210TXN2NGRB?=
 =?utf-8?B?WDZZMlR3T2hLaGNCd2FsY1BBVE1ZdmJZUTIrQXQ4bmZ0ZkN0b0QxaWd0ZzZV?=
 =?utf-8?B?L0hMcHI4MEJxZk9FMCswbVM2a0lBNjJUTkxMWk5sUEJWeUptMUtTOVNwTmhX?=
 =?utf-8?B?Q25kN21PNk0vRnVHdk15QTF3WWhWcmUycGNHUVBQQm1FSXdja3JxK2RKMEpn?=
 =?utf-8?B?cVRNK3hQNCtFbGJ3U1p6elI2a2lnZTFvM2M1MnV1VjNLMlk1SGZOQ3NiSzZM?=
 =?utf-8?B?ZW0xeDBrNm5PVEt4bndMVXMyVTlybHhWdVBZU0xzZXNERmhVZUkrdEhMSGRT?=
 =?utf-8?B?RjVpVnEwaVoxZ1ljL0V4eVdkSDFXRWJ4VDFSRm9xM09RRHBiUHhCeEZsRXdM?=
 =?utf-8?B?UXk5UmdCQ3czZURzWFpvTTNINVQyYndjQ1JFeHdxbWxzUUxnN3dOVzR4UU1B?=
 =?utf-8?B?SW96VW5ITk5EZzNmZkRJVkloZ2RjbUs1RTkxN2g5VXhXUXdGSXFsa2JpU1RG?=
 =?utf-8?B?Ulo5QXZueWJ3U2p2SDAvdFF2bUtmMlZsR1hTYmZybldBOE16bXh5blBPQ0RZ?=
 =?utf-8?B?WXNRU3Jpdis0ajIyK1o4KzVUaThEY3JMZUhBaFhXVHFoV25sWjAwSjBqbWZy?=
 =?utf-8?B?ZjV1NVFrYjQySlFITE5CZVJrT0VWMGV0UmpwcExGcy9OSEc2WENiY1pBbmRT?=
 =?utf-8?B?RkFmREFNRmJhOUFITks2S0tmVFZOUGVRZ2RnTkZQakNFNi9rZE5BMHlJb2Rm?=
 =?utf-8?B?ell0ditoU1BJaWtUYm9nblJPMlJPd01ZdkFvcEpreGpXTGxWSXUzUXYxNi9w?=
 =?utf-8?B?ejRYTWh4Y0taYmtoOUxqUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77CC5016C9AA564E87E553097300CA8A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd62d397-dd13-4ad2-8ea6-08d9660ef8db
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 08:21:13.9719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zBlMlj5mNkE6+HConnzyWRIWUAmPUTaNoFjXGU5dwvXAfK5l10TaFVMfJ02XL1Y04qhqBEO9xAuiycKX/7uibg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5934
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBBdWcgMjEsIDIwMjEgYXQgMDU6NDI6NDVQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gSWYgb2ZmbGluZV9wYWdlcyBmYWlsZWQgYWZ0ZXIgbHJ1X2NhY2hlX2Rpc2FibGUoKSwg
aXQgZm9yZ290IHRvIGRvDQo+IGxydV9jYWNoZV9lbmFibGUoKSBpbiBlcnJvciBwYXRoLiBTbyB3
ZSB3b3VsZCBoYXZlIGxydSBjYWNoZSBkaXNhYmxlZA0KPiBwZXJtYW5lbnRseSBpbiB0aGlzIGNh
c2UuDQo+IA0KPiBGaXhlczogZDQ3OTk2MGU0NGYyICgibW06IGRpc2FibGUgTFJVIHBhZ2V2ZWMg
ZHVyaW5nIHRoZSBtaWdyYXRpb24gdGVtcG9yYXJpbHkiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNaWFv
aGUgTGluIDxsaW5taWFvaGVAaHVhd2VpLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IE5hb3lhIEhvcmln
dWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+
