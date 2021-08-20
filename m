Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B936D3F283C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 10:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhHTIUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 04:20:01 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:64618 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbhHTIT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629447560; x=1660983560;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sd5IopyM97R2V7r75I95G6g1+g9R/j3txQhR5sfaQ0o=;
  b=wmjt+ZHp7aJsbUlT/GkOfDad0BOOy82oA3EAJaYZ2tVOthCYsJYRgoYS
   34xab3ZZkFWifqhLoRqj7tlepDqpK5McrFcLgbyv3JzE7cVxNVCGPPXpH
   4ICDR/yBwBHsehINVbLPmBse45ZtnRdYQpqpBdWHspWwixlm7E1lcLxBI
   UTqIfw5fTxxsmQKMZ0NjSb3JtO2o4pO4cxCBT6fuTasIsnI6ZSBnKiFow
   zAwJUG2vPgpm9CKA7qTnQ/OGhLbDyqCjOhKEl+JqVdK1T24f93RI1p/yy
   OHUx52bXzzWNI6Mx+nHXtlm5O1hshY7OLev0buqQIrW4CIHBMQNetqQqn
   Q==;
IronPort-SDR: 9d0ywQ6bQBynsIFoij2jmQ9Rr3uKn+wKx2Wl1+yu3Wg8WUInNq/xT+/9Q2Qf3V3kHQFWRvIp28
 vOLBG5dJbHKtY+TqJMf8uN8OqBx5BbpVDicgfmluKwjuajqkgX2IY5yi+H10YL5HkhRqQZtruQ
 vh5c1oEeAn4/aZyBT/TGWYVS2H3S61RZRxdvFzsOwMbQwPO30DBd11OJFq6VRIijkqtYufeUWN
 fRNA/tiwaRYXg4K+eUAaCPvFoShu5yOWfuATR0pfMeQjkZbHnrKer92sbSkwdcbhj4MWvtMGO6
 jVyoiR645NJ5j4FOMitYEAN/
X-IronPort-AV: E=Sophos;i="5.84,336,1620716400"; 
   d="scan'208";a="126503027"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Aug 2021 01:19:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 20 Aug 2021 01:19:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Fri, 20 Aug 2021 01:19:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjqTgKJKWBUlD6U5uhBcS3VLShOziloTxjJQDQg0IqckfHkWaiLriV64uBvTa0nuDItOzT0p4t9jEcKB4NYJ1RKUNCZQlcIhS5vPOxf3nJbyGU0NyCRITkSTcOyZ+aQ4DUgDfcDL6+/+KZZAbPLqH7gFEapJVABEfgy7esx5hAEbKPsH+q/fS1fVi7q98Jlg2tDRaHmzq+1X8HMkqNVdCqj9TPOmceH02lDjSVI7Oeb00mlSxHqX+n842xZe4JebW8Y/4b+scbaUJlxJAS+4muxwB+nY0NHEX8LPqcKn7L6bBIgE+7QfkgFixdWGnP+704lQVAKK4Uw8YeopnE1Tpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sd5IopyM97R2V7r75I95G6g1+g9R/j3txQhR5sfaQ0o=;
 b=ABYYYAuBWQP3vkCwaZF3SjzSDqDCS6cvg8ulByrr7LgyoCFoAxInTw+wP2+IEvKJDToycVguG4gDw1ELZO9/Edm2mGqGf97IKc5qIY9hh1OjIr9AJrovpAM8PZMPqqUZcFiEhCNiENs5vRjWXdqFfS+9mqTwCngk9nryIokQ06eJ9JSsllZxzoRce6GR3U5gq7nF4GTKKAg0dcnLZzhSCXVRaTaGbcJczHkLnTqYGSWQUTuOgC2JaPSttHrI57LgN5OVNzqG7Gos2jQC7q6IvQhh5QVWU8I79HHb8xQYBxLeSuMO4gOmdoRIxb/dGDYMmzhrF6d2tXm+9btpUrZMyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sd5IopyM97R2V7r75I95G6g1+g9R/j3txQhR5sfaQ0o=;
 b=nOqNDfG92k988t/dQOtVfzJ7svstajosgGl90upI38KV9l2uSCkqI5gnycPBdjQfsY7w7+1tvz3ZV5aQa9oT/eECZPlLh8ldAKvl11hfq0MlpwZLu/mS2UJkCn0HWvbQFHkxF85ASCgikW9ARTVyvtNGRae+rK52+te4PVMJ16s=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM6PR11MB2809.namprd11.prod.outlook.com (2603:10b6:5:c5::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.19; Fri, 20 Aug 2021 08:19:16 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e155:7e54:f51f:ff5c]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e155:7e54:f51f:ff5c%7]) with mapi id 15.20.4415.025; Fri, 20 Aug 2021
 08:19:16 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <lkp@intel.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Eugen.Hristev@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] clk: at91: sama7g5: remove all kernel-doc & kernel-doc
 warnings
Thread-Topic: [PATCH v2] clk: at91: sama7g5: remove all kernel-doc &
 kernel-doc warnings
Thread-Index: AQHXlZwRopNai7liFEG26zBzMdu+cQ==
Date:   Fri, 20 Aug 2021 08:19:16 +0000
Message-ID: <e88f2e2b-ed2d-fd21-0297-f75ea75c42dc@microchip.com>
References: <20210819223237.20115-1-rdunlap@infradead.org>
In-Reply-To: <20210819223237.20115-1-rdunlap@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7cbc33b0-d0f2-48dc-b551-08d963b333bd
x-ms-traffictypediagnostic: DM6PR11MB2809:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2809A27114DC47ECE6DD8B3087C19@DM6PR11MB2809.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GCLAqcddKT5rk66+bewsXvaZpC01ZUKN9X944yS0ti7gxk3QYHerey9fAg8BrddlAYwZQONCvrdTajSTg+aE4aDBW+Ay4Y+vsmvP3SbFfbExYCd7SYKiP4IBPuLe9BMp4pOHlJSiKzeQA7hZSPao0qoIX0JECR+KAM+Z8nb/GabUNAKgVX+ukl8lcfTmr5Vb/yYyZ2MGCLQ/vqewblmJn+chfW3l8IC4pNnNJZLqTxEveP61dBnveYniAzdUqf1gzRFjqPNQdZhDTrqc8JR+ZEviLFJIbi9fiNlgnXiSV/Vqz5gU35iW0BXaPTZ3onqstzohtvn9fpFWl1W4siJ88401X/M4v83IATDMx/6ERs6cQheHY/t+++DswucpiAiik+fCdccHjPq9gsyYrOa1hyuuNbDer5OfVNRzdWk0erMv5ocAD5gkQzFbu3FLraqRR/XSg9gW9VdXJd6du/piLaJkysHxGRURJrRvIn2kEa1oStk7sjZTdVHUq0Pju6p//hyBqNDlcv7v4J6a3bKMVDPK88VSICvbfc51uqXGEGJZlr5DxETdGll0oM08mUM6hOBay0Alc86W41gwbxBjD/6RplB00ZMOp6HeAdPvKAyJM8SqXn4CNX9VPiDtu+D3gQCKhUO+ZRFUnhEx6VIylEh/GtBoEG7Gckwy2uxnKwP5vsQYCtRFpdC+N8fp/kk8DqE/z+HUuajCH8NZqyPcoBfNG+aavj1wJyOr5kBY4jUM9BVfisogs/0PJ28y1UhL8yRd1Tt4m7PPW7/sQ2+FRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(396003)(366004)(39860400002)(186003)(6486002)(36756003)(316002)(71200400001)(76116006)(110136005)(31696002)(6506007)(26005)(91956017)(64756008)(66946007)(478600001)(2906002)(66476007)(4326008)(31686004)(122000001)(86362001)(38100700002)(53546011)(8676002)(83380400001)(8936002)(2616005)(54906003)(5660300002)(6512007)(66446008)(38070700005)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEdQV0NZV2ZJaHpabDFkN2xFM1J3clRCTkRNQVc3TkNsaWJCUERxcEx5Y3BC?=
 =?utf-8?B?U25vME9KZmNNdE9oelJ5Y0ZBZHJUVXAxS2E4ek02eS94aVMyTlhPQy9PMHBD?=
 =?utf-8?B?amVvWUhGM3plQ1l4RU82Y2lYVDB3bHlZODJHL25xSXcxWEdGb1pxWVB2aTdk?=
 =?utf-8?B?dkV1dUFoNFNLM08zY1pKeWQ5OHgxeEQyc0xBYlNXaGhIOW9GZWhkR2h6Tk1m?=
 =?utf-8?B?T3FZNXFKWFNnUWZZRWhSQWdVejFYaDZPZXpwd0NQam9QdjViejkvZFdNZW5P?=
 =?utf-8?B?Z2UyaHFjOE9VZFhyZXJCb2F6RFJDSTR6dklmRHRqSE9yb3l0bFBkbDdVV2xw?=
 =?utf-8?B?MmppdEhBazhlYktkV3RZU20rcUhpeVZIU1VkbU9UWVFOeU8reUc1Qis0aFZ4?=
 =?utf-8?B?TFdlMCtuUStXbDdVNDZuYkFiZTNWc3ZURkNwbGFDaFFsZVZTemxjaVdaa2NO?=
 =?utf-8?B?M1luYmFOOXhWVDZJZmFxb0JZTDgzM21rTGdZSldycCtLSXNoeWVDeVFLeGJT?=
 =?utf-8?B?MEdBWUdEWXMzV2s5RmIyM3AzM0dxVG84Ym8xOHdhd29sOWl3bE0wckY2YU9M?=
 =?utf-8?B?OG1CMEV4TlRRUkVBMzRSYnMwUHg0M3NURERlRktSZDhQRnI1UGhpRkxBWlhO?=
 =?utf-8?B?ZVJaYUx0cWhiZjdveGNMNmhwMzdBKzRjem5LZUFJaGJHS0dFL0o1VE1FRndT?=
 =?utf-8?B?WHphVWtWL083T0hSSWkzTUlPUTBpMlNHQ2JXTFFiQi90a3FMUXZnNEluVHJp?=
 =?utf-8?B?RW83VkNuZ21Zdzh1UHZsQlNPYWZKNjVVdk94ejYxOHgwdUlPVUtDcGwvY3la?=
 =?utf-8?B?cXhSVkxkUEVrTHdOQkM4MGtZNXBvZGJvTlZQMlN5dEF2RkI4cjZsZnNpTDc1?=
 =?utf-8?B?eHBUVFd3Y0pBVkx5SHF0cDhQNE5xRzFtZ2tPYko3Q1p0RXV1VTNvc0oybVRy?=
 =?utf-8?B?ZFVMYXJtSjVkVW1iVnN6aUovS3NmQlBta3JEQTFKVHZBeWdCT2NldkQxbE5x?=
 =?utf-8?B?ZXJhQ1Ura0RaSGpCUkExQTFmTWJYQW1MQlUxcnJIN1JBOTh3K0lETFdaa3hN?=
 =?utf-8?B?UllNZnRlSGsyMnArQ2N3dDVQaWM1T0ZDVXZGbGxmdXFzWWZQblF4Zkg0N2N3?=
 =?utf-8?B?bGdGMEJCNzdEZVp2a2dZL0Q5R0lLRS9HMy9tajJ5NWFSSTNLY3lwTVA2YUFX?=
 =?utf-8?B?Y3pTM3VsbjZIQTZnV3hDY2dLeCtub0xta3BMZkREMVM0TklzRmYvME9LbFR2?=
 =?utf-8?B?dXNCbTZHYkFjc2JrWUFhT3o2L0xXTlhoTlVNRFVjQzN1SElUYzJxd2tOeDhC?=
 =?utf-8?B?a2d5L2RlRkVKSFFydEV2enVjM0U1YnlXUHZNdkNyQy92Z241TFlzODlaeGRs?=
 =?utf-8?B?a0J1bjlnM21CWVRWRWNGd0xkRFBuZG0vbVBxWWhMUGVQWHR2Skh2anZ0dWoz?=
 =?utf-8?B?STlsTGtocDl0U3I0RFVsSVpWQTRTV0pxR2ZiaE1Nei85V1lWait5OHJJOFl3?=
 =?utf-8?B?L3V1MkxmVHliSjRUZXNrOXlEekJOZE16RnlnK0lYMWRpZ25yS2tydW9zRk5i?=
 =?utf-8?B?U1VlTnpaL3FUQno2TE5zMmsvN29NaVZIbVIybjQ2ZExaRDlCU3NqZ25VNkda?=
 =?utf-8?B?dmNQTlk3QUc5dC9RTy9iNktjclFRNGd0YkpDZm5jZmsybXFzQUoxNmhMa0l2?=
 =?utf-8?B?Z1U5aU4wU01pM0RxZEt5TlBJcGpkdi90ODNQeUZubVQ0eFdkY0swZXNiV3hr?=
 =?utf-8?Q?CX79k6Tu5zJZad0ejI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D1F71D9E3C2FC40848E3FFFC9C3201F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cbc33b0-d0f2-48dc-b551-08d963b333bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 08:19:16.6883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgDiK7zBerNfThB8WLGxcCLQ37PlSfXtIGlNOW0/bt6Co8hVb4SEaTTFyyJIhkiGWxvgNqkfMGTgZa3sgY+WjdTY+3wC8/+kXPdib/s2irQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2809
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAuMDguMjAyMSAwMTozMiwgUmFuZHkgRHVubGFwIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFJlbW92ZSBhbGwgIi8qKiIga2VybmVsLWRvYyBt
YXJrZXJzIGZyb20gc2FtYTdnNS5jIHNpbmNlIHRoZXkgYXJlDQo+IGFsbCBpbnRlcm5hbCB0byB0
aGlzIGRyaXZlciBzb3VyY2UgZmlsZSBvbmx5Lg0KPiBUaGlzIGVsaW1pbmF0ZXMgMTQgd2Fybmlu
Z3MgdGhhdCB3ZXJlIHJlcG9ydGVkIGJ5IHRoZSBrZXJuZWwgdGVzdCByb2JvdC4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiBSZXBv
cnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+IENjOiBDbGF1ZGl1
IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4gQ2M6IE1pY2hhZWwgVHVy
cXVldHRlIDxtdHVycXVldHRlQGJheWxpYnJlLmNvbT4NCj4gQ2M6IFN0ZXBoZW4gQm95ZCA8c2Jv
eWRAa2VybmVsLm9yZz4NCj4gQ2M6IEV1Z2VuIEhyaXN0ZXYgPGV1Z2VuLmhyaXN0ZXZAbWljcm9j
aGlwLmNvbT4NCj4gQ2M6IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KDQpSZXZpZXdlZC1ieTogQ2xhdWRpdSBCZXpu
ZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+IHYyOiB1c2UgLyog
aW5zdGVhZCBvZiAvKiogY29tbWVudHMgZm9yIGludGVybmFsIGRvY3VtZW50YXRpb24gKGFzDQo+
ICAgICBzdWdnZXN0ZWQgYnkgQ2xhdWRpdSkNCj4gDQo+ICBkcml2ZXJzL2Nsay9hdDkxL3NhbWE3
ZzUuYyB8ICAgMTQgKysrKysrKy0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlv
bnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiAtLS0gbGludXgtbmV4dC0yMDIxMDgxOS5vcmln
L2RyaXZlcnMvY2xrL2F0OTEvc2FtYTdnNS5jDQo+ICsrKyBsaW51eC1uZXh0LTIwMjEwODE5L2Ry
aXZlcnMvY2xrL2F0OTEvc2FtYTdnNS5jDQo+IEBAIC0zNSw3ICszNSw3IEBAIHN0YXRpYyBERUZJ
TkVfU1BJTkxPQ0socG1jX3BsbF9sb2NrKTsNCj4gIHN0YXRpYyBERUZJTkVfU1BJTkxPQ0socG1j
X21jazBfbG9jayk7DQo+ICBzdGF0aWMgREVGSU5FX1NQSU5MT0NLKHBtY19tY2tYX2xvY2spOw0K
PiANCj4gLS8qKg0KPiArLyoNCj4gICAqIFBMTCBjbG9ja3MgaWRlbnRpZmllcnMNCj4gICAqIEBQ
TExfSURfQ1BVOiAgICAgICAgICAgICAgICBDUFUgUExMIGlkZW50aWZpZXINCj4gICAqIEBQTExf
SURfU1lTOiAgICAgICAgICAgICAgICBTeXN0ZW0gUExMIGlkZW50aWZpZXINCj4gQEAgLTU2LDcg
KzU2LDcgQEAgZW51bSBwbGxfaWRzIHsNCj4gICAgICAgICBQTExfSURfTUFYLA0KPiAgfTsNCj4g
DQo+IC0vKioNCj4gKy8qDQo+ICAgKiBQTEwgdHlwZSBpZGVudGlmaWVycw0KPiAgICogQFBMTF9U
WVBFX0ZSQUM6ICAgICBmcmFjdGlvbmFsIFBMTCBpZGVudGlmaWVyDQo+ICAgKiBAUExMX1RZUEVf
RElWOiAgICAgIGRpdmlkZXIgUExMIGlkZW50aWZpZXINCj4gQEAgLTExOCw3ICsxMTgsNyBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IGNsa19wbGxfY2hhcmFjdGVyaXN0DQo+ICAgICAgICAgLm91dHB1
dCA9IHBsbF9vdXRwdXRzLA0KPiAgfTsNCj4gDQo+IC0vKioNCj4gKy8qDQo+ICAgKiBQTEwgY2xv
Y2tzIGRlc2NyaXB0aW9uDQo+ICAgKiBAbjogICAgICAgICBjbG9jayBuYW1lDQo+ICAgKiBAcDog
ICAgICAgICBjbG9jayBwYXJlbnQNCj4gQEAgLTI4NSw3ICsyODUsNyBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IHsNCj4gICAgICAgICB9LA0KPiAgfTsNCj4gDQo+IC0vKioNCj4gKy8qDQo+ICAgKiBN
YXN0ZXIgY2xvY2sgKE1DS1sxLi40XSkgZGVzY3JpcHRpb24NCj4gICAqIEBuOiAgICAgICAgICAg
ICAgICAgY2xvY2sgbmFtZQ0KPiAgICogQGVwOiAgICAgICAgICAgICAgICAgICAgICAgIGV4dHJh
IHBhcmVudHMgbmFtZXMgYXJyYXkNCj4gQEAgLTMzNyw3ICszMzcsNyBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IHsNCj4gICAgICAgICAgIC5jID0gMSwgfSwNCj4gIH07DQo+IA0KPiAtLyoqDQo+ICsv
Kg0KPiAgICogU3lzdGVtIGNsb2NrIGRlc2NyaXB0aW9uDQo+ICAgKiBAbjogY2xvY2sgbmFtZQ0K
PiAgICogQHA6IGNsb2NrIHBhcmVudCBuYW1lDQo+IEBAIC0zNjEsNyArMzYxLDcgQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCB7DQo+ICAvKiBNdXggdGFibGUgZm9yIHByb2dyYW1tYWJsZSBjbG9ja3Mu
ICovDQo+ICBzdGF0aWMgdTMyIHNhbWE3ZzVfcHJvZ19tdXhfdGFibGVbXSA9IHsgMCwgMSwgMiwg
NSwgNiwgNywgOCwgOSwgMTAsIH07DQo+IA0KPiAtLyoqDQo+ICsvKg0KPiAgICogUGVyaXBoZXJh
bCBjbG9jayBkZXNjcmlwdGlvbg0KPiAgICogQG46ICAgICAgICAgY2xvY2sgbmFtZQ0KPiAgICog
QHA6ICAgICAgICAgY2xvY2sgcGFyZW50IG5hbWUNCj4gQEAgLTQ0OSw3ICs0NDksNyBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IHsNCj4gICAgICAgICB7IC5uID0gInVocGhzX2NsayIsICAgICAucCA9
ICJtY2sxIiwgLmlkID0gMTA2LCB9LA0KPiAgfTsNCj4gDQo+IC0vKioNCj4gKy8qDQo+ICAgKiBH
ZW5lcmljIGNsb2NrIGRlc2NyaXB0aW9uDQo+ICAgKiBAbjogICAgICAgICAgICAgICAgIGNsb2Nr
IG5hbWUNCj4gICAqIEBwcDogICAgICAgICAgICAgICAgICAgICAgICBQTEwgcGFyZW50cw0KPiAN
Cg0K
