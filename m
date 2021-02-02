Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28B230BBC8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 11:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhBBKJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 05:09:44 -0500
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245]:17601 "EHLO
        esa1.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229593AbhBBKJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 05:09:22 -0500
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Feb 2021 05:09:21 EST
IronPort-SDR: mi1pd1VIc+R+OzKUgVe1336DLqchqwfkorKO3Opf5Ziwi9pnEvqwnGXbG51ramm+DlUHv6F3XJ
 RZK3VCWhghOalFwf19CRX+t59IpikXgJj8zmH9p+YZP0zHhALSpIG5T+jgn5QfEiPQk1f9LDKo
 ZNxdAI10D/tp0PfIrJDIN0uTxtlDD9wWt96koyIzvGNmwGy1iL2hLrpw8n0IGm1JkWB8xKTTRb
 dsDZQF9QRqkv5WT5+Kr2BB7aIRJr/31U+IfJY4OOUFWkCGwD+93kirycsaqJdmyVGcRlkwp7rf
 ShM=
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="33606064"
X-IronPort-AV: E=Sophos;i="5.79,394,1602514800"; 
   d="scan'208";a="33606064"
Received: from mail-os2jpn01lp2057.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.57])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 18:59:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUS/6pmXVGIUM/Ee2gntJN82CgrH70Hj0Ewwal/WvWo25Fm0KpYMh+EUNdfHZIX/qi+mSGlxl8k+MqEE8wiivBx6Qa0aRoZaTQaOQDWoEuo1fB6F05bPjn6T+Uanu09+eSb2AxxH3a6cI7x4XhHDoVdB0pxNjl/VqKBzHV7gctNaKxlW67noQD+YhoECl9WeaqJk6KYWm4jWfjuCXFQ6sdHXPx72yC7Ruyv/5LX+vqrngzMv6wMsjVh7nZk1o05bcc4tXXpAWBj5rjAd7PRZPHLJMreXtwPhsZj+j0UqbOuOCsVoip4Za8ZBvOk1olhWreJFJRx0appxMkEr4j/n7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHtv/GtOcu7DAjq84QGOvsimCcMnmK85/qn//JBhUPU=;
 b=d/1mWPHVvqtmDj3DWtow7OpJ0/DEC6JzE8SrIibgUMnlsEZ6XHS1b3TuKFo/zQ/cRVmdEpz/bftR+DLQrXC+fyKybCP7gNmhvtk8dfKCRe/EiNVjMEZh2y2QDi4fI2XdCYLjJMzjTDkSx3M8SRZpaeemrq7KrKRK8PilfS06P0cBdSLcyxCcHPcqXdfy6qoJNLVxO9MPg3yX0Su3hRBAeqGSHreKK8J/MB2BjZLZk6MDXO2qwCgej1gbXAWhfYSHxkaayjuLBbWHiFxF01709PJWInIMj7nAO5lR8x3uIBcK0zdPjEV+c3n2yYW5E1w+Z/Fodwj1zrYzGlLgNPUmbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHtv/GtOcu7DAjq84QGOvsimCcMnmK85/qn//JBhUPU=;
 b=di7+dKzhuty2Z+f+XpfZQAdc7cWDS6y9e5WBI6IQAIHL5lbLhLPCWAJCmBxN0PlOw/Rtjw1z3J5iRWk8hWP6yJhKIbDLrW4kYLuJpoZYiPhxs5JHOCxFbK234DvjU5MqMMt9a6mpi1Y9NmL/53lLQ9MHmeO0a4Ff1e3pSsxwuiE=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSBPR01MB4055.jpnprd01.prod.outlook.com (2603:1096:604:4e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Tue, 2 Feb
 2021 09:59:05 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd%7]) with mapi id 15.20.3805.028; Tue, 2 Feb 2021
 09:59:05 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     'John Garry' <john.garry@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 4/4] perf vendor events: Add Fujitsu A64FX V1.2 pmu
 event
Thread-Topic: [PATCH v4 4/4] perf vendor events: Add Fujitsu A64FX V1.2 pmu
 event
Thread-Index: AQHW+IwaTDkxjimhBk2agd6bvCyU06pDXBgAgAFGPzA=
Date:   Tue, 2 Feb 2021 09:59:05 +0000
Message-ID: <OSBPR01MB4600B423DB2D36E93CFF82E0F7B59@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20210201111310.3231469-1-nakamura.shun@jp.fujitsu.com>
 <20210201111310.3231469-5-nakamura.shun@jp.fujitsu.com>
 <66d5411e-222a-224f-1099-f476e3dcf6df@huawei.com>
In-Reply-To: <66d5411e-222a-224f-1099-f476e3dcf6df@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckermailid: ea5bd60d98e945aab47f1277a78522b9
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d101c207-7e14-4ead-7179-08d8c7612d28
x-ms-traffictypediagnostic: OSBPR01MB4055:
x-microsoft-antispam-prvs: <OSBPR01MB405550E5B0E4F03D51E3B12DF7B59@OSBPR01MB4055.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b2ZU2Ij4/KS3gvyTkAwIlwe7ktSmwWFSOfguTSX3oTP8S9nW3ML8NiHpvGRjzEykL3qy4s+KBYF6kZ10Tg1u12udHNoFufVSEfcxzW8ZkBvTaenkn2GR7n8yZuIHT1ZKimAMSxzJ2DUCG8Chfb0a9QbZz0azjwB4SNO200yx/j5r6NmK+ooZ/zfedrkHvNNipG5Hk6pR6r7XfJw/nVv/7JTpXhr6Q1LJuzeXrGy59OkZuzDBmDwcV5z/xa8OB7MyQPU0WYHrojwPnTnFwb1P1Ca6vgT7gEksjctWVF4S6Vj7aArUTWnhQyDoePjZroCAh5EeiWitGxhP8vVseqLLIOzNqN5dFmE4h4XIo8KB8v9NHgDwAsLBk76W2rgDljJsaXIXX70VAIyQPFZ6luYh0U0/HgtAsCGWRMPM2IzrJMz3pfqSw8Gj5caWX4AL3AwhK3qogPO/McHev6ft05PhOzDnkvqRXRUQh1YLe4rXzXjPFBekcO97Je6WOmus7X6Qz4uJQr2JIO5zGlSExL+2eulgI5T1GHDxVeXhyQhv69kvF9y00VDTSJe+oe3tRlHZyH/zTOQaAiyWfvhVPXV5RZ2ktBQfXsvOh9V2IoEGIQbxNoQ0Obe2crZuSd3c4/dlI9L5w1IohxluvU4T5Yh17vZLOaxSgSZZjv6ehFvMuqY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(7696005)(86362001)(4326008)(8936002)(71200400001)(5660300002)(4744005)(966005)(316002)(110136005)(54906003)(9686003)(6506007)(66446008)(64756008)(26005)(55016002)(85182001)(186003)(66946007)(33656002)(478600001)(921005)(66476007)(8676002)(76116006)(52536014)(7416002)(2906002)(66556008)(777600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WlBveWNSOEgwNFdoL2ZML1cyUWRrZGhvemtOdjBGTFJ6TERsd3ZmOXZ0Z2xr?=
 =?utf-8?B?UUhiMkVSTHpvdVhIaUtFdUM5UW8xWVZ2clJpSm1LR1Z4cXFRRCtlR29xVW04?=
 =?utf-8?B?RXlLTjRqUzJYTGxlQUZrREtMN1EveCtDQjZaT1VLWXdCVDZ0aHpUQnZLN29k?=
 =?utf-8?B?NC9CMmpNWGtQNjNIV1cydFhYbHJFWEdDZXBmdXBGY01ZYkJjTnFPTDU1YzJo?=
 =?utf-8?B?N09RT2o2NEgwVExNYWtVeVpCNnhHUWRSTzdLN3RVTHRDYnBkVUl2bGpxRWtM?=
 =?utf-8?B?bFZQbm0zL1grVk1FY3Q2NE5peVFoM3k3ZGl0OUUydHJBczdsbzQxTHRNNlZQ?=
 =?utf-8?B?UEVSR2VYckFaZnMrc2Y4bEsvYkhIc3VXb0YvNk1uTjBrQXhOeitrc20yUW81?=
 =?utf-8?B?czduQmUrbERaUnV5SmlNMGNuZXBXMU5UNVIvNWVBTG0zM3FFYzEzd3B5MTRW?=
 =?utf-8?B?YlpOdFNFc1hyNTY2eVk4V21OdS9RdWZKOE1xQlVrbFNiUFRySGppKzA0SFVp?=
 =?utf-8?B?aytKOVFYaHRGT0ZqTVFzYkNUcHdjZGlJbjFFKzQ2cXRvWXJvKzc5ODRiTXFQ?=
 =?utf-8?B?dGNZVlFwY1JKZS9mcGV0dzNXUUQvQTRDU2NXQVZlOHUrdHRpVnE4R01PRVpK?=
 =?utf-8?B?SnBVNE9QTTltbHpLUm04cHJtaFM0RmdudmhlMXE5eTl3S0gvSEdYdDlwSnB4?=
 =?utf-8?B?MnZXZ1JsdXpQQmRPdlhiZ0FuMVBZUUh2ckwzNVJ4amNBN0tVSFZibnFGeEli?=
 =?utf-8?B?MHNKUUF5Z3FtSDkzNXFUci95VytUZFZDbDFEaktoenlITUdWNC9GNzNWbno4?=
 =?utf-8?B?c285OXQvUEpwUHVPbCtUOFZvZzJUNVRUSVk0MjVhN3ZLWVFDMjZUR1JQb2Js?=
 =?utf-8?B?SDZRdkxXZVhlMXNUUW5ySmlyeDdOYUc5aHNEV0pIRk1VMFhiYUY2S1hITUth?=
 =?utf-8?B?NStTek5FbjFHYjBpZnI4Q3ZQRVVnV1BtZjdXQ1YxdGJranJETWJGb0pHc0xq?=
 =?utf-8?B?cnIyTFY3amdvaWhHUHpzWHFUUVlYclU0WWZuTk5uV0xleHVYZU1iSG1BYVNC?=
 =?utf-8?B?SUFxYTJReHZIZjhWcVRFTU1XWmNHaWVaU0lWZjlGVjlBUFE1UU9VUHZuSisv?=
 =?utf-8?B?dmJNdXRFeHptNjRhRCtWV3VxVVhCcS9LSmFoRDFpRkJSUStVZEt5OUlNNnhS?=
 =?utf-8?B?MWdYNmdZaWtMWUtrdnZLYXJCKzdBaTZXZDZyTFA1dWszcG81c1VBVEFqU0wv?=
 =?utf-8?B?V2tTOWRTUXJ5Rnp2MGViOGlRUXhlZDdlSVcrekJpa255RW9teXE4aGVVRTNR?=
 =?utf-8?B?THRJeFhhRFVjc3haeGRKa24xTWF4c29iQ0s3cEhhNkJBaGFjeU9OVWVPL05w?=
 =?utf-8?B?VnlVQ3NOekkweHlzTWdaa2JXQ2g3bDlsMkpGbit0VkZFZXRINnphM0FvVkYx?=
 =?utf-8?Q?hw8p623b?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d101c207-7e14-4ead-7179-08d8c7612d28
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 09:59:05.5545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OO5AfhrFL/8YGnAs6kJ7fIqHXcaQFQqRltpR81Hj7wMgxJB9762Sw+dvP2r3XdLbBoipfjs/Oo4P83WBBxc6DyopjC/0bssMIaio7JSQb8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEpvaG4NCg0KVjEuMiBpcyB2ZXJzaW9uIG9mIHRoZSBzcGVjaWZpY2F0aW9uIHNoZWV0Lg0K
SXQgaXMgbm90IHRoZSB2ZXJzaW9uIG9mIEE2NEZYLg0KSSByZW1vdmUgdGhlIHZlcnNpb24gZnJv
bSB0aGUgc3ViamVjdCBiZWNhdXNlIGl0IHdpbGwgYmUgbWlzdW5kZXJzdG9vZC4NCg0KSSBjaGVj
a2VkIHRoZSBtYWlsLCB0aGVyZSB3YXMgYSBzcGFjZSBiZWZvcmUgPC4NCmh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xpbnV4LWFybS1rZXJuZWwvMjAyMTAyMDExMTEzMTAuMzIzMTQ2OS01LW5ha2Ft
dXJhLnNodW5AanAuZnVqaXRzdS5jb20vDQoNCkl0IG1pZ2h0IGJlIGhpZGRlbiBieSB5b3VyIG1h
aWxlciBzZXR0aW5nLg0KDQpCZXN0IFJlZ2FyZHMNClNodW5zdWtlDQoNCg==
