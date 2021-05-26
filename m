Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BFC391B52
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 17:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbhEZPNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 11:13:17 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:59462 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235377AbhEZPNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 11:13:12 -0400
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A79D2C06F2;
        Wed, 26 May 2021 15:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1622041901; bh=FETtLevtwKxZgay2IOggl9bzoPOax6LS4Gqshb+wDBc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=AZf0dYjyxlY7VS+UegTzm2FjWXBCLAUjM9MgDV6S9Kg3o1TnYPpth1k4v5Qqv44R8
         6zs7AB14y1VqoMvpipOo6Ilqu/WOLAnUbg4NkI9FHvRE7H32715aD1qt2rdEIG1hUD
         GLh73UZ7SUbqLpCKxWhp3WWN7ndxkSHtq6RWmnEDpDUuWY8nHz1qbSQiT1SNoXavxf
         Q8jUb23BAXPhad4t5nxcZ7cZZ9qZ5u1rkvyqJjjg3I2zEMKylFjMQhW9w4Z+3DWIPy
         vhBgXAmPehJPBoWTLeIAA6eyiRIicwds2hP8XRNk6HIdjSLyJjiCA+PHlqZZ5Xr2pi
         4vvnic3Z9MLFg==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8AB5CA0081;
        Wed, 26 May 2021 15:11:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 884CD40A47;
        Wed, 26 May 2021 15:11:38 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="AtzlDvSi";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAUNWwdRpmZ0SilHqanPJRLPPirnx/tjmHbXQYG2nnO6y5gol+K16VnTUgkpTCe7rECD/r9jJsUxX4BCGs6TLziv44hlXEEzzZW7iaz5inE5WxU+4JRvFH0j6nJGYvHJ0BeLZFi5xSwDgwRrMLZXqM13BspPB1YUS9as/0yWESjCFPCq482miRbxmzeF24lpUi8I8bDk5IHkA0Rs7RsGAWobEQi101TjAKlNNz7vVQGr+v1aj5YirXiFj0HSd+mvZnzFprmAobQcc4FOViezHAyPeB/yUmW3wtOPH/K7ThdorxR9DfWUwU2xs4FCTEVA5qjV94uOJQQGXr/BxP3OOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FETtLevtwKxZgay2IOggl9bzoPOax6LS4Gqshb+wDBc=;
 b=MRb4RBBPxcQliMR+r2TNlcLqeC6M398aZQF+SdhiAqM2rGP1X8f1SD7slqrqK1pmek0uJ0NA636+fH9UD3HaKGvDYL9j5fL1Pkz9yiviAuLbu4JCa38lgPNwQmD/NXfvIz9Q/WzcOSaBB4cVq/inFnqIv19hlIuE7trdJZzaHLMM8Arxc3BdzOZp8nC01fM9By2oFRu0IDUbl5boT3PRc3Wjf8RQCHnP7v5hjwfD8L7hmLI3gVAeIMgmrqruL64ARgz8d2lmM04dJvFh2y1j+nSJCg4y5zjpOVP9LQwAXV2DKB5FnHxctS2MCqi4J/UbfO9hhoOBPWdaRIet6hSDZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FETtLevtwKxZgay2IOggl9bzoPOax6LS4Gqshb+wDBc=;
 b=AtzlDvSiBGKPYs45meFPZNmWm1cmB0E/YZY6T3q1tSXg85R/UL5uV0Ozm+RG+fbOWa30kB86UCOSY/OK9xByGYaER6xGFPsk0eTi/b+qKJO4Bv3a1IVOrU5Yvue8J+6xmQaQUwqD1onJCiaZ9Ea6sLObDsZgZbBkq6AxYTF3xVI=
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:39a::12)
 by DM4PR12MB5215.namprd12.prod.outlook.com (2603:10b6:5:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Wed, 26 May
 2021 15:11:36 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::bd1a:d4df:7c02:e458]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::bd1a:d4df:7c02:e458%6]) with mapi id 15.20.4129.036; Wed, 26 May 2021
 15:11:36 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Dooks <ben@simtec.co.uk>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 15/24] usb: dwc2: gadget: Repair
 'dwc2_hsotg_core_init_disconnected()'s documentation
Thread-Topic: [PATCH 15/24] usb: dwc2: gadget: Repair
 'dwc2_hsotg_core_init_disconnected()'s documentation
Thread-Index: AQHXUi8wByJsJ3EENUWvZp6ihlUR5ar13neA
Date:   Wed, 26 May 2021 15:11:36 +0000
Message-ID: <64d27857-c609-eb34-021f-4beb40cda525@synopsys.com>
References: <20210526130037.856068-1-lee.jones@linaro.org>
 <20210526130037.856068-16-lee.jones@linaro.org>
In-Reply-To: <20210526130037.856068-16-lee.jones@linaro.org>
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
x-ms-office365-filtering-correlation-id: 9d855b9b-054a-4759-2ac7-08d920588e23
x-ms-traffictypediagnostic: DM4PR12MB5215:
x-microsoft-antispam-prvs: <DM4PR12MB5215912E869A034FD79EF345A7249@DM4PR12MB5215.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZfrAfkFHtL1v6sEKj+4CfVAkE+jIhbEgrl0cNDTaEikXRZAxrQ5I4xqSyqHvTaQufN6U8w4Wfokxfmb6PCPU+o+YwrjqGAOgQekfxIYAUig2WzlJQ6CEmkI4mrLXcXHpFx03fJMKxqGQOhPrgniT3MzD68UwDNXidqIquPbCCEX8Rno1TJbaB3gPu5QgDYGQt5G8oJ6eRZnlpNVTBGgpASDhwyKkcQjknt3Lgkv8Ry/4l03FJnZyYdnLJblLHsUSflAUSDA1SG7d90ZGiBbFtIEjCx6cI8OrK8JQq7byEWss6P+qjYiCVhFkgnLilXmsqGU7OYVOlKk1p3n+CdqQRit3bVsr6yL4raUL5Df3bcIsB6hk+f0e76s2JR2x81L4GHXGM0Vmaf1gE59YAeCRXuFZ0aAaZWb3GQqFddirrGG2BbpVblX4MT6Z4wuLvXoCRDx8drdQTAXWYDZVjTk7ECs9ikTeQAPRKUQkxBcEjVXf2m1o58wNlO3Nn28Qjh147XjXyCgALld3GxNe581/YPRM94QrtqaHf0DVlOIqgr9T9QoudEx3hbKySMT8LUT9xbVAwSS694RWqYBBOX1Z8Htd7ZBz0k6lMDnbEheI3DOQ2ywanrZ6lGK9EQE63FjdVw2QC0UwXfd7H3UeBUWB17VHryyK3SCHqFIB8R788ACF1CfM259iu6kJeJAqAv49
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39850400004)(366004)(346002)(6512007)(26005)(36756003)(66556008)(2616005)(64756008)(6486002)(66946007)(53546011)(6506007)(122000001)(66476007)(8936002)(6916009)(86362001)(66446008)(91956017)(83380400001)(76116006)(38100700002)(54906003)(31686004)(4326008)(5660300002)(71200400001)(2906002)(478600001)(31696002)(186003)(8676002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NitGNEZxOHp6T2JnWmlIbFZXNUtxbkw1eUhURTVGTWpHZXhHTjZJWEo0TXN1?=
 =?utf-8?B?T3VlSWdpeTh6eC84V0pwRXBPUy90SzBVL0VRdEJyUFY0RGxSb1ZGeGJFeVJk?=
 =?utf-8?B?TVMrbERKYVROaW9uQzZzNk9mS3JTU3d3aW5zT0MrWGZ0eGNzL1IvSTNaaGp1?=
 =?utf-8?B?d3hJZFl5ZUVGeisvWktSeE53MUxLSGpSakRxbVd6TmFiZnV4ajdXL2ZQWUJS?=
 =?utf-8?B?RkYremR5Zzh0TlExQUJNWG9mMTlhcnUwNEZGeU16ZDZ2eFpTSFdadDgrays1?=
 =?utf-8?B?ZHdWajgrT1FuSTI4Qk9sWDd3RUJHbU9uWXg3QTNia2dhYldPRFVxeTlXdTlX?=
 =?utf-8?B?a2M2bDVlUi83VW1UZnRETFVDZ3Rpc2dJaFE0akNWbWlqRTdWVzdsTHg2MzBR?=
 =?utf-8?B?VU56NWRkY0ZnYXA2ODVNSi8vMEd6S3JTbklXYklGbDdSdEZCanVjTGkySjNz?=
 =?utf-8?B?K0cwR3NDeWo1TVZPUElRb1FKZmdVeFBhVUdqVTBvTzdSck9PMjRibzV1aWJ1?=
 =?utf-8?B?RWYzV1RhQTgzeDg0MHpsaDFUcUJ5WmVkK2V6YXNLLzlkN2d5WFc0MzBaK2NO?=
 =?utf-8?B?akpibzA5NmRoUjdIelVCUHRKWVZTaHFCTUkwYjVCbS9JWGhVRU9BMjRyb1VR?=
 =?utf-8?B?Q0xzYnZIa2hocTIwZDFCTFRBSURyRUUwV1hyOCt0aWdPMVNQdVpVdnBTc1hX?=
 =?utf-8?B?YlNvT1h0eDhpUnEwOXlRNmF5Qnc1dTBaTjViSHdUY2FBNzJuZE9ndm9jSjhq?=
 =?utf-8?B?OHlHSGh6OURSblVSTTh6Ym1XUzlnT1ZOTUpvQXRSeWVLeVRaNmI1VDBSdjI0?=
 =?utf-8?B?WHFRQ1g1RXJJUTBzck11RlRTb0JBN0hCT3prRmFIOHN6dGJBT0I2Y1JCVkhS?=
 =?utf-8?B?OGJncm1OQzF2THNnQjMraWJ2QzAxalhiREw0aHNKV3pPVG9SN3ozRkp5LzdD?=
 =?utf-8?B?aWluM0N4RmtUMThFcUdlbnhidy9qa0dEMm5sdkdmR25xMVRvS04vd0JWMTZi?=
 =?utf-8?B?VGw2bUdHVVNScVVyZEVuYjZYN1hoQVpQQjJURDNDaE5hc1ZFRDNHT3E2ZGJV?=
 =?utf-8?B?bEg1OVBQM0w4MHU3WVdvYnExWXZlZXM5UmNFZ0hwU042dzRIR1ZHblVoY1A4?=
 =?utf-8?B?MmJ0bi9kem4xREwxNkhpbzMrTDZDeXY0NFpnWkFxbVZkN0FXNTVUOWU2YjJR?=
 =?utf-8?B?YVRydEtKTHJYOUJWTTNyQnI4elhjayt5Y2x5Z3NEdGJRNFdmNjBKYTJuQlhB?=
 =?utf-8?B?dkdCNUY3WUhwT3ZFU1NvRWhBcUxmUTB4RnJOckF5ZlliOGtnSDlCZXEzQTNC?=
 =?utf-8?B?OU54K2w4ZUtVOXUyRUZ5QUpmZzhBR3d0cnJROSs4SFJKWG0xMDhWYTdxdk11?=
 =?utf-8?B?QmdLTTlFcmt1WUhhb3RCQ3hXWmdYTXAxUmUwNWhXMWh0Nm90dEV5SE90R3du?=
 =?utf-8?B?ZjVIOStid1R3RzZwbTZpUTJqL1g5eUdwR2V6UUtXQ0RoQ09OUkY3MEp5L1My?=
 =?utf-8?B?WGdtbXdqUXRiVFhjU2FZZUhsYWo1aDRtczlFaDhPR2tZd3pJNllkb0VEZExq?=
 =?utf-8?B?R29qdU5pSm1vSi9JcTZhQjBwemlRZU9udWNvbDh0T25WdWw3ZzRHK2dNOXpm?=
 =?utf-8?B?bFEvcDNQRUNidm84aXFVRHVrQ0F6QlpJSXQvVk0zS0xRMC81eTQ5T21tYVZv?=
 =?utf-8?B?cmV5ZlVoK2I0RW50VjlXd0RpbC9Eb3ZpTFRlMFZqRm5qTkh6c1hveGQ5WW1R?=
 =?utf-8?Q?/ITYFe+6lFuGeXQGE2u3nCqTK7rEfE3UB22r7/D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FDB9D3BDFFE174B9292AEF077E558B0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d855b9b-054a-4759-2ac7-08d920588e23
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 15:11:36.2630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NpObE0F2csT5v4sUETwiNg4sg3ZnETHwUnyrM9+hQJnR58OQL8Ba3b6qsBzSh8xzaSAj4Aa+BZNLHCVxfzUKIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yNi8yMDIxIDU6MDAgUE0sIExlZSBKb25lcyB3cm90ZToNCj4gRml4ZXMgdGhlIGZvbGxv
d2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6DQo+IA0KPiAgIGRyaXZlcnMvdXNiL2R3
YzIvZ2FkZ2V0LmM6MzM0OTogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBmb3IgZHdjMl9o
c290Z19jb3JlX2luaXQoKS4gUHJvdG90eXBlIHdhcyBmb3IgZHdjMl9oc290Z19jb3JlX2luaXRf
ZGlzY29ubmVjdGVkKCkgaW5zdGVhZA0KPiANCj4gQ2M6IE1pbmFzIEhhcnV0eXVueWFuIDxobWlu
YXNAc3lub3BzeXMuY29tPg0KPiBDYzogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZz4NCj4gQ2M6IEJlbiBEb29rcyA8YmVuQHNpbXRlYy5jby51az4NCj4gQ2M6
IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxs
ZWUuam9uZXNAbGluYXJvLm9yZz4NCg0KDQpBY2tlZC1ieTogTWluYXMgSGFydXR5dW55YW4gPE1p
bmFzLkhhcnV0eXVueWFuQHN5bm9wc3lzLmNvbT4NCg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvdXNi
L2R3YzIvZ2FkZ2V0LmMgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMi9nYWRn
ZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzIvZ2FkZ2V0LmMNCj4gaW5kZXggYjE2ZmIzNjExYTg2OS4u
YzU4MWVlNDFhYzgxYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYw0K
PiArKysgYi9kcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jDQo+IEBAIC0zMzM4LDcgKzMzMzgsNyBA
QCBzdGF0aWMgdm9pZCBkd2MyX2hzb3RnX2lycV9maWZvZW1wdHkoc3RydWN0IGR3YzJfaHNvdGcg
Kmhzb3RnLCBib29sIHBlcmlvZGljKQ0KPiAgIA0KPiAgIHN0YXRpYyBpbnQgZHdjMl9oc290Z19l
cF9kaXNhYmxlKHN0cnVjdCB1c2JfZXAgKmVwKTsNCj4gICAvKioNCj4gLSAqIGR3YzJfaHNvdGdf
Y29yZV9pbml0IC0gaXNzdWUgc29mdHJlc2V0IHRvIHRoZSBjb3JlDQo+ICsgKiBkd2MyX2hzb3Rn
X2NvcmVfaW5pdF9kaXNjb25uZWN0ZWQgLSBpc3N1ZSBzb2Z0cmVzZXQgdG8gdGhlIGNvcmUNCj4g
ICAgKiBAaHNvdGc6IFRoZSBkZXZpY2Ugc3RhdGUNCj4gICAgKiBAaXNfdXNiX3Jlc2V0OiBVc2Ig
cmVzZXR0aW5nIGZsYWcNCj4gICAgKg0KPiANCg0K
