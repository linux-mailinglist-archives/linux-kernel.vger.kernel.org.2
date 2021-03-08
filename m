Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110C3330929
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 09:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhCHIJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 03:09:17 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.116]:42012 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230342AbhCHIIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:08:41 -0500
Received: from [100.112.135.57] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.us-west-2.aws.symcld.net id 6F/81-48750-88BD5406; Mon, 08 Mar 2021 08:08:40 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGJsWRWlGSWpSXmKPExsWS8eIhl277bdc
  Egwl/DS3OTgi0aH+9ldHi8q45bBZPFp5hcmDx2Pm9gd1j/ZarLB6fN8kFMEexZuYl5VcksGZs
  aVrGXvBXqqLh5BOmBsYLUl2MXBxCAg1MEp/23mWHcF4ySiz9sBvK+c8o0Xp9MZTzi1Fi1bsDz
  CAOo8BSZomFvzayQTjHWCQOPHwB5WxglOj+9ZkRxGER2M0ssezHDBaIAfOYJI7O/ckG4dxjlO
  jffweojJODTUBFYtu1E2AtIgLnGCWat/9hA0kwC+hIHLw9CaxIWCBNYtaX6SwgtoiAlcS+I0e
  ZIGwjiZP3D4PFWYAG/d3yAizOKxAj8XTbKtYuRg6gbeYSTZvDQcKcAhYSH+ZcAhvJKCArMe3R
  fSaIVeISc6fNYgWxJQQEJJbsOc8MYYtKvHz8jxXitwmMEitnrWeDSChIvOz/CFUkK3Fpfjcjh
  O0rMf/hVBYIW0vi1aojUENtJI4+X8ACco8E0J3/DlVChLMlbh/bxTiB0XgWkjMgbC2JeQ2/mS
  BsRYkp3Q/ZZ4F9JihxcuYTlgWMLKsYzZOKMtMzSnITM3N0DQ0MdA0NjXQNjU11TU31Eqt0k/R
  Ki3XLU4tLdI30EsuL9Yorc5NzUvTyUks2MQKTUkpBu/kOxhevP+gdYpTkYFIS5S1a6pogxJeU
  n1KZkVicEV9UmpNafIhRg4NDoOPo0TWMUix5+XmpShK8c28B1QkWpaanVqRl5gATJ0ypBAePk
  gjvsxtAad7igsTc4sx0iNQpRkuOCS/nLmLm+N68EEgembt0EbMQ2Dwpcd5pIPMEQBoySvPgxs
  GS+yVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwrybQKbwZOaVwG19BXQQE9BB7jZOIAeVJCK
  kpBqYvFgZLI3sH89xu14/f6lRxxfx4KDFMuvLlXV+e9z9FBoekZb56srE8N/TNzw8vPAe33xz
  0aYN1z0eV5T5FfFPXTE7LLLZ54n+4+fiLD79nrEiD6urgqr9f3nnS+UxzjtSySkrIsRhUO0Sc
  sJszaFlCdV6/vLrQt8fcCkQL1/QIqR8/8nVpUf/hK364VJa/HbPLo/rs0SOWwtN+/95wsx6U+
  Vfyu+sXeok7I7Fl7D/meuTsNZw5RrJ3feCPi8++H/CXZvfJqq3ePZv+1jqtbrl0EmZq96skQq
  shteFeB/aT1nxx2Xt1cUKtZqTb6q8YpnZwjzjxOzJugU3vltMKLn2SermEb7678zly24drbhz
  XomlOCPRUIu5qDgRAH2VpdNpBAAA
X-Env-Sender: lijq9@lenovo.com
X-Msg-Ref: server-2.tower-355.messagelabs.com!1615190918!106525!1
X-Originating-IP: [104.232.225.10]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18343 invoked from network); 8 Mar 2021 08:08:39 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.10)
  by server-2.tower-355.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 8 Mar 2021 08:08:39 -0000
Received: from HKGWPEMAIL03.lenovo.com (unknown [10.128.3.71])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 236E061137F8D74BEFC3;
        Mon,  8 Mar 2021 03:08:36 -0500 (EST)
Received: from HKGWPEMAIL02.lenovo.com (10.128.3.70) by
 HKGWPEMAIL03.lenovo.com (10.128.3.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 8 Mar 2021 16:08:33 +0800
Received: from HKEXEDGE01.lenovo.com (10.128.62.71) by HKGWPEMAIL02.lenovo.com
 (10.128.3.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2106.2 via Frontend
 Transport; Mon, 8 Mar 2021 16:08:33 +0800
Received: from APC01-PU1-obe.outbound.protection.outlook.com (104.47.126.55)
 by mail.lenovo.com (10.128.62.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2106.2; Mon, 8 Mar 2021
 16:08:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/28j28HxTONNL1CVpZZsbyQubFJbykb/DP7YXMtY1HAunXiBdYOzYsXZj7W3q/BmNuVh4zCSxFYZmD9W77I5rncjPiLJWWgRFQ//P3X8yToBddTTq9ovQGLutNvMQFHc/B9MNSY8gOp63fCQpn81od1dotEbBKuIq36200bhpXN1frdkVjH9UZe/rhuNdEZfQ3MXIzGw7b6NhypM5n4/QiqT8Tjd+ECTMGzYJT9RN2ookozl/RTaG+3mk2Sl+ItikluLma5vWecTetEvzcibDwCAEI4x3AT/lO8EX4Xct5xVaFg/I6Kvznmp2eUtkzQDcpWHevjOFDxlis2C5Sp1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxh+mvO550bZcIK8LpvTxIyx1TwGP9ATKMVHUeTNvlw=;
 b=OQn6RCPRLl76ab5VjBgwjym8jHCYKrOEyPmHjWcdX5ezfNkU9JB1UchJiiLJpHPTgV8sCcd/Ja3ksNIXone3d5cRs2g9S03C+cx55YcaXeqxb2FefAX+epvaWvbUDSu9YIShXbKMJMGZfjpxgy7IEaAQGkCJxKf3F4G+6aZlNb26hXQhirBESvqS6ToWTGeXsi0ar2vHDTrAD4l+r6bX8ZcW/IecaaMQFQpYvvOBFvo/uOIIEzIZsHDurnCjME9J/KPMfFl8EI4WnEYqip4mVINlKBcUrQIpNCbXgCpkiblpLcn/VIXip9/PQXunC37AXubqX18T/izjmuG+mgUiyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector2-LenovoBeijing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxh+mvO550bZcIK8LpvTxIyx1TwGP9ATKMVHUeTNvlw=;
 b=Lu0RbQeCEQ8FSJ9H/3ctNZ54lhSLrFznNggqAxfAyTLme1g+wtaism6pux47MpQvhzaxS4e1fyGHPVREFD3eyKbVGLZQUIocXsIeqXFjOoVRG7cwW9L5bgPVNDWnJdLA0TIn/yp2R37yY1OfgmH45xamzv2H6BNhOI/Ct3hYcY8=
Received: from HK0PR03MB3700.apcprd03.prod.outlook.com (2603:1096:203:74::13)
 by HK0PR03MB3009.apcprd03.prod.outlook.com (2603:1096:203:4d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.13; Mon, 8 Mar
 2021 08:08:31 +0000
Received: from HK0PR03MB3700.apcprd03.prod.outlook.com
 ([fe80::d923:be7c:16c6:b9f8]) by HK0PR03MB3700.apcprd03.prod.outlook.com
 ([fe80::d923:be7c:16c6:b9f8%2]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 08:08:31 +0000
From:   Jiqi JQ9 Li <lijq9@lenovo.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mark RH Pearson <markpearson@lenovo.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHYyXSBod21vbjogKG5jdDY4ODMpIFN1cHBvcnQgTkNU?=
 =?gb2312?Q?6686D?=
Thread-Topic: [PATCH v2] hwmon: (nct6883) Support NCT6686D
Thread-Index: AQHXEONlo6uqJyVBcEqZAQGxtj2EYqp5wmLQ
Date:   Mon, 8 Mar 2021 08:08:31 +0000
Message-ID: <HK0PR03MB370019695C26B1D35A39BB9F83939@HK0PR03MB3700.apcprd03.prod.outlook.com>
References: <20210304104421.1912934-1-lijq9@lenovo.com>
In-Reply-To: <20210304104421.1912934-1-lijq9@lenovo.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [57.197.58.15]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb0ea622-8702-4e89-c86c-08d8e2095cd3
x-ms-traffictypediagnostic: HK0PR03MB3009:
x-ld-processed: 5c7d0b28-bdf8-410c-aa93-4df372b16203,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR03MB3009443558B8FD590045B41883939@HK0PR03MB3009.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VKigepyhCwxWbT5FgGUwab+qYVypDNw/2hzF826AslVSaRara0yfRJcxSIxbwMMoc0PNAMLaKVr6SNBXWkwZVvtTiU0iO1DUVqcwhmuR1xK3vvwCnOJGKAgUG5Rcwng7p2j9rBYKncdEM1YEXCiRn9VCX85I5tAFfozLdJKwMinSn/JDeG3n6qKeLqvkuOD7G4m2jYNqmXX4ekzCP4jnhgAIST/hV61FGPs4jAk9HtteWAoDyupSCDPqeQ6eBpRAbFXGsVXsCR+xQG/d2xadnvw0PmWAMutz1mIJCeGvEfAT9urCCUL0tzpbR0yFZxXg1LUf5e9i4LtrwboFtAqu23VC8kcnXlqS0FTSDNy6YLt7LkrQnOhyfiiJABvl0SA+uuGLxPlugCGGABWO9ZXYuxs5XsdbYSS6AoONoGyqKXtibvHhgmZAtY7zRF+0DizTTjdAPevkghWs3rEx7mjztwtS9NVUhQdBg0JVp2D0Jkr1YCWuZkoB4qlxAceVD5+eOgN28EiDtRkqHVEtpDMfnzniinT0568F6k+fs64IzSxWQ3AiwUfuPKidgaAJIbHJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB3700.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(9686003)(71200400001)(33656002)(55016002)(66946007)(110136005)(66446008)(478600001)(4326008)(86362001)(26005)(316002)(2906002)(5660300002)(8936002)(76116006)(64756008)(7696005)(83380400001)(186003)(6506007)(52536014)(224303003)(107886003)(66556008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?gb2312?B?QUlyWGtJUHk2MDF0WndwS0t0bk03ZXR0Q3dJV2xDUktueVYvNnk5WW5DYmhG?=
 =?gb2312?B?M014WXJqclZuV0YxWVVXaEdlaUY3VG0wY1d2TmpzMWU0a3pmM1lualQ0NEdT?=
 =?gb2312?B?RnJwM1FxWVgxaERzQlNuVnpTandmVzNzN3hqcUhCZVFhM1lFa3d0RXYyYkZa?=
 =?gb2312?B?YVVpVlROaVgrcm9JTnFCWU1lTms5a3FKTVUxK3FlTFdlVy9VZzFaNFArdTZ5?=
 =?gb2312?B?TWR1L1lLMzdsWGZrRldyWWR2MFd3NXBjeks2NzJSTHJSU0o2bTJHY0pSY2VE?=
 =?gb2312?B?MDNrSXVKRWV6UndxK1liRElGUEZzQzFURC9HZjFSODZuVmRmVlBlTUZzR1RF?=
 =?gb2312?B?aUR6WjN4WWZRTXUwZk8zZXp5bUtsN0FTRHVwdFNrUTRMWWhFZzRXMURuKzIv?=
 =?gb2312?B?T3NaRzlFMk8xNjYveWd3b3pLTkJWU2lsdElTeHNZeHBXNmpsY01KcDNQUjdV?=
 =?gb2312?B?dHdZM1d5dkhJZGRzdlZ2b0dpdWdCNWh1MUYwNUMrQ2hlMnF3bkhYaGJFTmJa?=
 =?gb2312?B?RUh3bnA3aGpyM2tibmlVZzJ6amdvUXRZSTZDRW1oL20rUEpHMlI4TUJwcmUr?=
 =?gb2312?B?WCtudmMwR2Z3cm1DWW9pK0w3dENVV0ZYSXZ2R0YvUWJaS09DOUZtSVdUMzgx?=
 =?gb2312?B?U0VWSEJlZzBjclNFTmFHMUVxSnpkMDNNSzY3RmZMQVIyL0FmRUVEU01vbWpO?=
 =?gb2312?B?YlJ1UkFVWnp4TldZbVp1L3BSZWUxYzkzVjNERldMTDNnZ3JrQU9zLzcxbG5W?=
 =?gb2312?B?VXpzSWZaM05BQVo4K29rM3hhWFc2bmZWcTNEVXh6UmFEVVRZRk5Vc0NlallO?=
 =?gb2312?B?STI4bmRnVFdseHQ3b2ZrY1ZmSWFSMjFjU0poUmlBVlZpeXJGaytvN0srdFRR?=
 =?gb2312?B?KzdWVGF6NGpyVGYxcTdLYUtnSnFKK0p1ZHZkOXJZR3NkcllDMjI2WlFsY3lj?=
 =?gb2312?B?bU5IeUZiM3JDalpTaFkyckZOWG9pQS9Genlla1VOWSswbTVuck9HZnp1aGY1?=
 =?gb2312?B?bkRSRVhQMndjeDU1Z25ON1JwdmpaV2ErU3BXc0xNQ1l4SkhnUW5ieDdKTFpz?=
 =?gb2312?B?RS8vMUVsUm9pVzdPK0lPUEllbk9BOXdoSnczUVhPN1lhU1lkR2FORThGNVF1?=
 =?gb2312?B?ZDVraXdQakIvZVlrcVdydllpcXVaODZVSTdIVnFNOVU0THlqa0U2UUNTdUdE?=
 =?gb2312?B?TTdrWGlQa2FDdGM5NnI4T0pZTFlGV3VXU3NrZm8xR3A1dElLYXMzc0VSUlBP?=
 =?gb2312?B?bUZFQVBUK2xuWHM3bzZ1WktmUnAwa1hvRXRpRGZyT3I2NThqdGdwRnZlUGs2?=
 =?gb2312?B?dGQ3eDA1ZVkvTTMwZGdLaFJPUFp4Yi9NMTVtWTlTWUlkb0RIbEFQaTU2c0p0?=
 =?gb2312?B?UWNyUGhTdHh2ZUpLWFlGMVdya1R2TFhHZGc4bFBUbjlER3ZqdVZpTTNxR2Qy?=
 =?gb2312?B?RkdVdWV6ZUNjRE4vZ2RTQTFTTzQwMEROaUk0UnlickFQcmd6NSt5ZWRsNE11?=
 =?gb2312?B?MnU2alp6ck9PNnRGUnh0SGRpS09mMGE4OHhZZU1LZHFaSFZYcVVRTUhYaEN2?=
 =?gb2312?B?Zjl4UitxaVZvL0tWV1hXalA3eW00eW53WDhJY1Q4MTA4QkNlNElqTXdYNVFl?=
 =?gb2312?B?Z3kyMXBEN21yVyswb3lyREFpQVpyZDZiZkZYemJEMDFzTnAvZUpWOFEzbW53?=
 =?gb2312?B?WjdsOWNmWmluUnc5em5SZFF5NVVnTnVVbnNmd1U5TmxNaU5HUE5hQzRISll6?=
 =?gb2312?Q?auee+qrNRlEkyQXohPet6sm06/2mDa+seQT1V0X?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3700.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0ea622-8702-4e89-c86c-08d8e2095cd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 08:08:31.2101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 111Dp2kcs1PHj0MdzI5F3uctAOozVlZpV5sIaYgPCvo916iV28B8Z+OtC8ifZKKaXSauxJmRU9GjfdvJCbOy0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB3009
X-OriginatorOrg: lenovo.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3VlbnRlciwNCg0KQ291bGQgeW91IHBsZWFzZSB0YWtlIGEgbG9vayB0aGlzIHZlcnNpb24/
IFRoYW5rcy4NCg0KUmVnYXJkcywNCkppcWkuDQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjL
OiBKaXFpIEpROSBMaSA8bGlqcTlAbGVub3ZvLmNvbT4gDQq3osvNyrG85DogMjAyMcTqM9TCNMjV
IDE4OjQ0DQrK1bz+yMs6IGpkZWx2YXJlQHN1c2UuY29tOyBsaW51eEByb2Vjay11cy5uZXQ7IGxp
bnV4LWh3bW9uQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
s63LzTogTWFyayBSSCBQZWFyc29uIDxtYXJrcGVhcnNvbkBsZW5vdm8uY29tPjsgSmlxaSBKUTkg
TGkgPGxpanE5QGxlbm92by5jb20+DQrW98ziOiBbUEFUQ0ggdjJdIGh3bW9uOiAobmN0Njg4Mykg
U3VwcG9ydCBOQ1Q2Njg2RA0KDQpBZGQgc3VwcG9ydCBmb3IgTkNUNjY4NkQgY2hpcCB1c2VkIGlu
IHRoZSBMZW5vdm8gUDYyMC4NCg0KU2lnbmVkLW9mZi1ieTogSmlxaSBMaSA8bGlqcTlAbGVub3Zv
LmNvbT4NClJldmlld2VkLWJ5OiBNYXJrIFBlYXJzb24gPG1hcmtwZWFyc29uQGxlbm92by5jb20+
DQotLS0NCkNoYW5nZXMgaW4gdjI6IENvcnJlY3RlZCB0eXBvIGZyb20gTkNUNjg4NkQgdG8gTkNU
NjY4NkQNCi0tLQ0KIGRyaXZlcnMvaHdtb24vbmN0NjY4My5jIHwgMTEgKysrKysrKysrLS0NCiAx
IGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9od21vbi9uY3Q2NjgzLmMgYi9kcml2ZXJzL2h3bW9uL25jdDY2ODMuYyBp
bmRleCBhMjMwNDdhM2JmZTIuLjI1NmU4ZDYyZjg1OCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaHdt
b24vbmN0NjY4My5jDQorKysgYi9kcml2ZXJzL2h3bW9uL25jdDY2ODMuYw0KQEAgLTEsNyArMSw3
IEBADQogLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCiAvKg0K
ICAqIG5jdDY2ODMgLSBEcml2ZXIgZm9yIHRoZSBoYXJkd2FyZSBtb25pdG9yaW5nIGZ1bmN0aW9u
YWxpdHkgb2YNCi0gKgkgICAgIE51dm90b24gTkNUNjY4M0QvTkNUNjY4N0QgZVNJTw0KKyAqCSAg
ICAgTnV2b3RvbiBOQ1Q2NjgzRC9OQ1Q2Njg2RC9OQ1Q2Njg3RCBlU0lPDQogICoNCiAgKiBDb3B5
cmlnaHQgKEMpIDIwMTMgIEd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJvZWNrLXVzLm5ldD4NCiAgKg0K
QEAgLTEyLDYgKzEyLDcgQEANCiAgKg0KICAqIENoaXAgICAgICAgICN2aW4gICAgI2ZhbiAgICAj
cHdtICAgICN0ZW1wICBjaGlwIElEDQogICogbmN0NjY4M2QgICAgIDIxKDEpICAgMTYgICAgICA4
ICAgICAgIDMyKDEpIDB4YzczMA0KKyAqIG5jdDY2ODZkICAgICAyMSgxKSAgIDE2ICAgICAgOCAg
ICAgICAzMigxKSAweGQ0NDANCiAgKiBuY3Q2Njg3ZCAgICAgMjEoMSkgICAxNiAgICAgIDggICAg
ICAgMzIoMSkgMHhkNTkwDQogICoNCiAgKiBOb3RlczoNCkBAIC0zMyw3ICszNCw3IEBADQogI2lu
Y2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+
DQogDQotZW51bSBraW5kcyB7IG5jdDY2ODMsIG5jdDY2ODcgfTsNCitlbnVtIGtpbmRzIHsgbmN0
NjY4MywgbmN0NjY4NiwgbmN0NjY4NyB9Ow0KIA0KIHN0YXRpYyBib29sIGZvcmNlOw0KIG1vZHVs
ZV9wYXJhbShmb3JjZSwgYm9vbCwgMCk7DQpAQCAtNDEsMTEgKzQyLDEzIEBAIE1PRFVMRV9QQVJN
X0RFU0MoZm9yY2UsICJTZXQgdG8gb25lIHRvIGVuYWJsZSBzdXBwb3J0IGZvciB1bmtub3duIHZl
bmRvcnMiKTsNCiANCiBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IG5jdDY2ODNfZGV2aWNlX25h
bWVzW10gPSB7DQogCSJuY3Q2NjgzIiwNCisJIm5jdDY2ODYiLA0KIAkibmN0NjY4NyIsDQogfTsN
CiANCiBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IG5jdDY2ODNfY2hpcF9uYW1lc1tdID0gew0K
IAkiTkNUNjY4M0QiLA0KKwkiTkNUNjY4NkQiLA0KIAkiTkNUNjY4N0QiLA0KIH07DQogDQpAQCAt
NjYsNiArNjksNyBAQCBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IG5jdDY2ODNfY2hpcF9uYW1l
c1tdID0gew0KIA0KICNkZWZpbmUgU0lPX05DVDY2ODFfSUQJCTB4YjI3MAkvKiBmb3IgbGF0ZXIg
Ki8NCiAjZGVmaW5lIFNJT19OQ1Q2NjgzX0lECQkweGM3MzANCisjZGVmaW5lIFNJT19OQ1Q2Njg2
X0lECQkweGQ0NDANCiAjZGVmaW5lIFNJT19OQ1Q2Njg3X0lECQkweGQ1OTANCiAjZGVmaW5lIFNJ
T19JRF9NQVNLCQkweEZGRjANCiANCkBAIC0xMzYyLDYgKzEzNjYsOSBAQCBzdGF0aWMgaW50IF9f
aW5pdCBuY3Q2NjgzX2ZpbmQoaW50IHNpb2FkZHIsIHN0cnVjdCBuY3Q2NjgzX3Npb19kYXRhICpz
aW9fZGF0YSkNCiAJY2FzZSBTSU9fTkNUNjY4M19JRDoNCiAJCXNpb19kYXRhLT5raW5kID0gbmN0
NjY4MzsNCiAJCWJyZWFrOw0KKwljYXNlIFNJT19OQ1Q2Njg2X0lEOg0KKwkJc2lvX2RhdGEtPmtp
bmQgPSBuY3Q2Njg2Ow0KKwkJYnJlYWs7DQogCWNhc2UgU0lPX05DVDY2ODdfSUQ6DQogCQlzaW9f
ZGF0YS0+a2luZCA9IG5jdDY2ODc7DQogCQlicmVhazsNCi0tDQoyLjE4LjINCg0K
