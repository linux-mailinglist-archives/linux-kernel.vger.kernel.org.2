Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C930E4178D0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 18:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343886AbhIXQfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 12:35:47 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:64558 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343651AbhIXQeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 12:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632501154; x=1664037154;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m4oVUSt2cjF66a6GM6GMZgXeCyOfb//vokkHkKd1YFo=;
  b=FgL3kaLkwUQFdAjNj/eb3zDJNc55Ruby6PofO1C58KkaLgJhREqn0Dm6
   gpDDZ/bXgIj68sFiRxO2n3tZx2MLBEo3u3fJRdrD4s2gMCDOjzW+LGut0
   mwDBcDJDycDAmDcuBUvwqYNELJ+RzqrhSlpbTKf5m/y3eaqKPfJ9rjr/n
   l4yXfy0CHzj9S5VMHeTD9uF1bXXe3KY8doG1YLzopUv2nQ4rzlmoWcF7V
   9zs7yizLhnk8M4Ep36XdYC+LREPsQ9jha8hIFsHJXEg34grxmXJvRnm0r
   2cHNkVs8m62SeFECym7nnnD7svISC7lWP6dHdiZdj2ZWcrBe3NAu8rlBF
   Q==;
IronPort-SDR: VnT2WTT6laVLDzvUZ2jvEwrHrNgX/0l33tIRT+YeyiqpA1ontMpilJhfj6PtY0cwM41MAQMcZs
 6PUd95kTAqS5qyOpeMfCJtO4zxkUiBPejM+9sWuxdE/HEoGoSOTkFfFomm4yzM35CJOlIsVlT+
 0Zbnz4bhywd/zW4hyIyuVAgW821K+t0CoduQPpF/b3tzzjsyV+tnX13+rJOywa/UbkhVlMqIje
 UTOYmNZ/D86WZsmVGMd6AhKPsxcg4Wc8iVLDYUjq1/OkPxFP//sg7gHM7I0LHlVqJ1wbEKBnp+
 QSiYv5g8jAWxQpbkMCk9tto1
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="130590253"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2021 09:32:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 24 Sep 2021 09:32:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Fri, 24 Sep 2021 09:32:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAT+IKqzJDlRUBm9nfjKL6x4c0zQN6m6BAoOQtMSVBRu1TKfONigQXkb0pfIi+A07qxtQBBAMdEAyYrC14DT0H/1zSNVIzXD0ZUKrOnrY6udfafZSdYLu0H6rrf5o2wbCR2L56IpyZQtUXSwzUioFDLJcX2YNb1U5agmPprel+6TuUsdO7VJYarvSJY/M9WsPTXyxVgQdgwzM2kOzs/pMu2sKgJmNLUZo7jiFy52BA0UvyLqJAvffcRIBO5M/sWO2ZNJ20Qhhpnsn51/F8N6B6jw9iAk5FlHvDlwsnWwJflVXT3u9tCuCYz0qOtmI5rwQWCT8yKG291R6JqIVSewzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=m4oVUSt2cjF66a6GM6GMZgXeCyOfb//vokkHkKd1YFo=;
 b=hpMjgztdanbp0x5J4e+oFRlFvUNlZ87Q+r9UUvpXBYsMy/WUbuuZc+PFw9FQie1lMuhcpTvg5kykqCJSHWgtYdqR4Zm2Zy0qRakLSWEj08TOYZZkacFtnbLtWxFchZA1rl4O6C3D08ec1cxhenYnahmGmT5oPgA0VtOl+SxvCSA7r+JobP5KoBdpdvsBcRVy7Y7dmJcznpxn11QGU8iWkaRO3TowivJaAF907/K74GVtk4SgJ5M82k0t7nrlahrVAe6taijDy1EmApX61CSgR8NkM/G6IY2WPK7zcjx5z3CDgaU5Kt2EzqT8n49wtnf39/RdvfEDkRA04+6cMFZ1ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4oVUSt2cjF66a6GM6GMZgXeCyOfb//vokkHkKd1YFo=;
 b=rAL66LVKGHQti0YBNBIYwausSjrmJ+N73H7SuKTvASKgpfuVy2kp9WqziRjst2pmiDnee5eTBN91PzZuc2ropdSpsBWNHMtuV3TzxChfoblzi07Jax3RrFCCAgsIWo0ZdLJlIKJtN9UuMRSb/hHoYYhvjUvARMPy0JAJVIrWyxA=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by MW3PR11MB4553.namprd11.prod.outlook.com (2603:10b6:303:2c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 24 Sep
 2021 16:32:32 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::c929:4928:894d:8b5a]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::c929:4928:894d:8b5a%6]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 16:32:32 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 0/2] irqchip/mchp-eic: add driver for Microchip EIC
Thread-Topic: [PATCH v3 0/2] irqchip/mchp-eic: add driver for Microchip EIC
Thread-Index: AQHXsWHFVu7AaI6kdkKTgJptNdQs8g==
Date:   Fri, 24 Sep 2021 16:32:32 +0000
Message-ID: <68755c28-946a-a526-21b1-e40dd4fc5722@microchip.com>
References: <20210924162817.2135056-1-claudiu.beznea@microchip.com>
In-Reply-To: <20210924162817.2135056-1-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b653238-aff2-42eb-baab-08d97f78e893
x-ms-traffictypediagnostic: MW3PR11MB4553:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB455345DD240FF5C9D75185D387A49@MW3PR11MB4553.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AFchkfg6SO8NlRtawFgMve1yedBOSnaIN3UtTT12U6xEq9MZCOxJ78ZX6w+VXLjOP1ZZJqs9jv6ZVVPA88ygitrHiS1vYs8KXlUQGyX+qB0p3MFjGAhdfCvUANvOIqMsA36NGo3bWYygB0SQ/unKPBvWFgVFx/0vjeI9PsbH5mQywISfoFjVSLEXCFAhLpCw9o1/bna4z5+rrhm00m3eIndnSKRtFSpaH7lg8cKt9cdeioVYulPVRSEpWhGqc6xMFAXJZAaeC9KdBzNpd/N+6op0NyjItmJ5HYd2V/yh5cDGw/zmiceNX/aBSSm0HZLPAd1gKjUFE5etKA2YUReHqkIlMo4h4JoBOXdEVkQksse/Wnh5CKQecxDq9/yVr2K9DPl1rxXOtW3fsL6WVWoz/+u4iYrnc0vPK2spp3VIRM+VeC5kJIkkMdIx0j5tfGz7RWlwtG9YFv0QI4eUnDGrVjsYtndQ4QyL7T1gxuR51w2IcXUz7CBwRgna7xvrbzsYcE2lFoCM4oxe+OfKydti1rz/BPf1M2AJbpop46DIAKqKZOOLpsW3E5UecXU7UegZYn7RsI0FHMS0nKXVf3te6zyfI3Z7a7I024FD5QZHDK6+sZ2vnZs6aNAn5WDb5wSM5N68O9Wz5B04TZFQxTzz+NhNm62v+ooRg38Ibor21hZr2KxhjHF5xqC8088SxsOYUyBrToc95FuX374OBpRQFNUGKCdRffMy9nFaYv/mWms6YqOI4p7oUoCrM2wyOlrqFF2V3EjApnH27rD6g9qSjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(4326008)(66946007)(66446008)(64756008)(31696002)(66556008)(66476007)(76116006)(36756003)(91956017)(6486002)(83380400001)(54906003)(86362001)(8936002)(110136005)(316002)(8676002)(2906002)(71200400001)(31686004)(38070700005)(53546011)(6506007)(5660300002)(2616005)(508600001)(26005)(38100700002)(122000001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0wrTkhNMUpRK3VmTE13ZEgyRUhFQitNcFpMYUdMd3hKbkw2NWtEUmhWZnEy?=
 =?utf-8?B?SVowR0QzNUZxa1JHQURYQTZ5dkZNazFYV041YjZ6QmMyRzZYbUxLc0d6eVNI?=
 =?utf-8?B?K3hNYkhCdXduMlQxL3hVTHJPcmVaTUx3M1d5VDJUdlk0SHZHc1AxNUxtWmtD?=
 =?utf-8?B?aUxMaHRnOUxFTklXT0dxUGo5OGw2Qi84d0J5Y0FkUVdYaDlJL01aQUJURXJT?=
 =?utf-8?B?eEFmNTFkL1BrUkJOS1QrZ0p3aFEwNnBVamJrZ1E3andZY3FQNEY3MHRJVkYy?=
 =?utf-8?B?cmhQc0FlUmI4bUpkS2U0OGNFdEMrLzZmSzJKSnlQbU1DbEtWTTcrT24wZGxV?=
 =?utf-8?B?aDhlL0todG1pYlZCeWZGNmhqWGtIS0dMNDBDWVNwY2Q3eGpkRGFiYXZtZWpP?=
 =?utf-8?B?MXRUelM2MVB1eUVjMGlXZWNJUzNZRnIyWmFURC9HZWl3SU44R09kMlN3bURF?=
 =?utf-8?B?SDl5RTZwUHFHZUdweTBUMktKdWJFcmhhNW1qUEpMRzFXcXhpazJyWHpnMGVn?=
 =?utf-8?B?Skl6VUttZStHYjBHNDRwL0Q5Z1FwRzJhK2xvZ085SDBYN2FBeHR5UThhK1N4?=
 =?utf-8?B?dVpPaEk0NjN3RExRVVN3Um5wMWVUc0hhMzg2dXpBTXhFRUNiVG9mYksya3FH?=
 =?utf-8?B?NjFDalVKdGdXVEcyL2lKNnF0VU96N2FBcGMydEJSc0pFYnU3c0VlZDdXdXFE?=
 =?utf-8?B?ZVdWQXhIaEFiSjRGTFF5VUFwUVcrM1Z6OHRTaEJLVjE4MjBSVTQ4YWp6cnkx?=
 =?utf-8?B?Q0d5b2lKVHBnQnNXbnNyVW55WDRZNE5seEhLVXdCTEVsdGdBNE1TUFZrRm53?=
 =?utf-8?B?bkJockVVc1IwOG9JSmk2cDZKQkZjUHRpQjhrbTlVN1pYVEx4S25tUHBvMyt6?=
 =?utf-8?B?N3c2cXBLN3hpVU1TajV1Vnljc2RsZnpKZ09Nay91OU9zWWpNTlFDT0liQUw1?=
 =?utf-8?B?bmZFc0xjTk1Vb0ZBejBlSkNtcWJmOVRlZktZU2pqclRkTkVOcGZDeWRSOTV4?=
 =?utf-8?B?QkZ0azYwbzZMWkFsQmM3UThvK0NnVlY4K0h5SzV0SDNES05uRkFTOEx6Sy9U?=
 =?utf-8?B?RUVkUStGMFFEZ3NJMjdaYnhNYU9FbG45ZGk0a2Ryc3hIempzbWNqN3ZiQmpm?=
 =?utf-8?B?M1EyaXBHQXdPZU5ldEVmZW0ybkVDamdNQlFHT0tyWU0xa2x3RldNZzc1L3VM?=
 =?utf-8?B?MDRjb1V3NWl1U2ZnUXFzUFdKVURJTEtZSmZDN1NKbVBPWGFSdGdMamhsZXhZ?=
 =?utf-8?B?c0hEaXNBbU8zUlloT1RCNmRObkhMc3d1U1VwR1BNbk43MFFoM0lHMDFSQS9z?=
 =?utf-8?B?WHpReDRBTGQwQXM0SjhTNU5FMTlkRHVjcEFtdEtMemlGaURqeXR0SXpWVmE3?=
 =?utf-8?B?Q3JlRUVWWTIwa29wTElFcFR0M2lZTnMvM3E3dndwQ0FnSDRmbU5mV2JPRkV3?=
 =?utf-8?B?OTZHY0kxcVF1NEZSNU56Uksyd0JJc3F2bE53YmYrZm95STJLbE9JYU53RXBw?=
 =?utf-8?B?QXlhWG5XWHVSRW5aQ1lxYnNUSFBLWElHa0tyeUprQ3FqYi85aVNPb2JrL3JG?=
 =?utf-8?B?dWpINjBCTEpEbkg1Y043NlJ4VXNDUmdYSjFpTGNPaHlPNDNQYm53MG1kdysy?=
 =?utf-8?B?MzVhdGgzWjNZS2FUaXgzaDhJTFRreGJURmlWSy9kNHpFcFVIZzgzWTV6TWJJ?=
 =?utf-8?B?OG04YlQ1MThuVkg0TmV6djVqNXEwSEZabndUMXlibnZFeWtwMTVFdFhMNnBM?=
 =?utf-8?Q?sjIVIQf/4sd0UBP1EU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71E58FA30255834D976F0E4904025768@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b653238-aff2-42eb-baab-08d97f78e893
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 16:32:32.2861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kz+oXGB6BRaEc/M2hOTa/Lr7bW388K/gIiPs62xLxvCspTBRGNZB5liIb4dlvKuwBmWDsZOOZUjjZ35ODy94oFsdCl43ErOhUZxHStyxeYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4553
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnksIHRoaXMgaGFkIHRvIGJlIHY0LiBJJ2xsIGZpeCB0aGUgdmVyc2lvbmluZyBhbmQgcmUt
cG9zdC4NCg0KVGhhbmsgeW91LA0KQ2xhdWRpdSBCZXpuZWENCg0KT24gMjQuMDkuMjAyMSAxOToy
OCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+IEhpLA0KPiANCj4gVGhpcyBzZXJpZXMgYWRkcyBz
dXBwb3J0IGZvciBNaWNyb2NoaXAgRXh0ZXJuYWwgSW50ZXJydXB0IENvbnRyb2xsZXINCj4gcHJl
c2VudCBvbiBTQU1BN0c1LiBUaGUgY29udHJvbGxlciBzdXBwb3J0cyBmb3IgMiBleHRlcm5hbCBp
bnRlcnJ1cHQNCj4gbGluZXMgYW5kIGlzIGNvbm5lY3RlZCB0byBHSUMgYXMgZm9sbG93czoNCj4g
DQo+IHBpblggICArLS0tLS0tKyBFWFRfSVJRMCArLS0tLS0tKyBpbnQgMTUzIChmb3IgcGluWCkg
Ky0tLS0tLSsNCj4gLS0tLS0tPnwgICAgICB8LS0tLS0tLS0tPnwgICAgICB8LS0tLS0tLS0tLS0t
LS0tLS0tLT58ICAgICAgfA0KPiBwaW5ZICAgfCBQSU8gIHwgRVhUX0lSUTEgfCBFSUMgIHwgaW50
IDE1NCAoZm9yIHBpblkpIHwgR0lDICB8DQo+IC0tLS0tLT58ICAgICAgfC0tLS0tLS0tLT58ICAg
ICAgfC0tLS0tLS0tLS0tLS0tLS0tLS0+fCAgICAgIHwNCj4gICAgICAgICstLS0tLS0rICAgICAg
ICAgICstLS0tLS0rICAgICAgICAgICAgICAgICAgICArLS0tLS0tKw0KPiANCj4gd2hlcmUgUElP
IGlzIHRoZSBwaW4gY29udHJvbGxlci4NCj4gDQo+IFRoYW5rIHlvdSwNCj4gQ2xhdWRpdSBCZXpu
ZWENCj4gDQo+IENoYW5nZXMgaW4gdjM6DQo+IC0gdXNlIGlycV9kb21haW5fdHJhbnNsYXRlX3R3
b2NlbGwoKSBpbnN0ZWFkIG9mIG1jaHBfZWljX2RvbWFpbl90cmFuc2xhdGUoKQ0KPiAgIGZyb20g
djINCj4gLSB1c2UgSVJRQ0hJUF9QTEFURk9STV9EUklWRVJfQkVHSU4oKSwgSVJRQ0hJUF9NQVRD
SCgpLA0KPiAgIElSUUNISVBfUExBVEZPUk1fRFJJVkVSX0VORCgpIGluc3RlYWQgb2YgYnVpbHRp
bl9wbGF0Zm9ybV9kcml2ZXIoKQ0KPiAtIHJlZ2lzdGVyIHN1c3BlbmQvcmVzdW1lIGZ1bmN0aW5z
IHZpYSBzeXNjb3JlX29wczsgYWxvbmcgd2l0aCB0aGlzDQo+ICAgZHJpdmVyIHByaXZhdGUgZGF0
YSBzdHJ1Y3R1cmUgKG9mIHR5cGUgc3RydWN0IG1jaHBfZWljIGhhcyBiZWVuIGRlY2xhcmVkDQo+
ICAgYXMgc3RhdGljOiBzdHJ1Y3QgbWNocF9laWMgKmVpYzspDQo+IC0gY29sbGVjdGVkIHRhZ3MN
Cj4gDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gZml4IGNvbXBpbGF0aW9uIHdhcm5pbmcgb24gYmlu
ZGluZ3MNCj4gDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gcy9tY2hwL21pY3JvY2hpcCBpbiBiaW5k
aW5ncw0KPiAtIGdldCByaWQgb2YgZ2xpdGNoIGZpbHRlciBzZXR0aW5ncw0KPiAtIHVzZSBzL2Vp
Y0AvaW50ZXJydXB0LWNvbnRyb2xsZXJAIGluIGJpbmRpbmdzDQo+IC0gcmVtb3ZlZCAnJyBhcm91
bmQgaW50ZXJydXB0cyBpbiBiaW5kaW5ncyBhcyBwcm9wb3NlZCBieSBSb2INCj4gLSByZW1vdmVk
IGdsaXRjaCBmaWx0ZXIgc2V0dGluZ3MNCj4gLSBzd2l0Y2hlZCB0byBoaWVyYXJjaGljYWwgaXJx
Y2hpcCBkcml2ZXINCj4gLSBhZGRyZXNzZWQgcmV2aWV3IGNvbW1lbnRzDQo+IC0gdXNlIGJ1aWx0
aW5fcGxhdGZvcm1fZHJpdmVyIGluc3RlYWQgb2YgbW9kdWxlX3BsYXRmb3JtX2RyaXZlcg0KPiAN
Cj4gQ2xhdWRpdSBCZXpuZWEgKDIpOg0KPiAgIGR0LWJpbmRpbmdzOiBtaWNyb2NoaXAsZWljOiBh
ZGQgYmluZGluZ3MNCj4gICBpcnFjaGlwL21jaHAtZWljOiBhZGQgc3VwcG9ydA0KPiANCj4gIC4u
Li9pbnRlcnJ1cHQtY29udHJvbGxlci9taWNyb2NoaXAsZWljLnlhbWwgICB8ICA3MyArKysrKw0K
PiAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA2ICsN
Cj4gIGRyaXZlcnMvaXJxY2hpcC9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICB8ICAgOCAr
DQo+ICBkcml2ZXJzL2lycWNoaXAvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgfCAgIDEg
Kw0KPiAgZHJpdmVycy9pcnFjaGlwL2lycS1tY2hwLWVpYy5jICAgICAgICAgICAgICAgIHwgMjgw
ICsrKysrKysrKysrKysrKysrKw0KPiAgNSBmaWxlcyBjaGFuZ2VkLCAzNjggaW5zZXJ0aW9ucygr
KQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9pbnRlcnJ1cHQtY29udHJvbGxlci9taWNyb2NoaXAsZWljLnlhbWwNCj4gIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBkcml2ZXJzL2lycWNoaXAvaXJxLW1jaHAtZWljLmMNCj4gDQoNCg==
