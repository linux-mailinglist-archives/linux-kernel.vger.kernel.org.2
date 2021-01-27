Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155A1305C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 14:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238163AbhA0NEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 08:04:49 -0500
Received: from mail-am6eur05on2087.outbound.protection.outlook.com ([40.107.22.87]:48993
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237807AbhA0NBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 08:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAEY7uOmOnMvbaLNPwGgrZ3WZZ7fZw+8sNCChI7/Nzk=;
 b=XGyanXeLK50wYPpS5fMwf/fRmYkf8g49EE39BrxFkSdS6XiOic4GXYxEQGlFFuL2nZuby/Qf7xxHso3UZbOVeGg3RwV6YZn2RwlZ3dtVXMYn8q28WZ0dOhQ2UZ+p1LI8pPfIDa8nYMOX/IuqGhDD4IhvEGA1K3+wWYzRBGYtPKg=
Received: from DB6PR0201CA0024.eurprd02.prod.outlook.com (2603:10a6:4:3f::34)
 by AM8PR08MB6451.eurprd08.prod.outlook.com (2603:10a6:20b:315::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.16; Wed, 27 Jan
 2021 13:00:44 +0000
Received: from DB5EUR03FT060.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:3f:cafe::2f) by DB6PR0201CA0024.outlook.office365.com
 (2603:10a6:4:3f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Wed, 27 Jan 2021 13:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT060.mail.protection.outlook.com (10.152.21.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Wed, 27 Jan 2021 13:00:43 +0000
Received: ("Tessian outbound 4d8113405d55:v71"); Wed, 27 Jan 2021 13:00:43 +0000
X-CR-MTA-TID: 64aa7808
Received: from e01228a8b62a.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A4BEEC7D-1000-4121-9563-A9070C8E0F54.1;
        Wed, 27 Jan 2021 13:00:38 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e01228a8b62a.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 27 Jan 2021 13:00:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQGr/ZaRiLJMfa8xxSBTKvrcqVecWk/3CcmBnBhjMO0Fmwcpj40YxCrAruw7agLSRSd9mXj3rlDzokhWShpKNSBg2Ie9v7JE+p8KpikchTzU7fSj8TDE6OaQlY3yl9NnUsCOyqCh77Tw+ZqH4Rw0M/4Ds0tEoS0H9m8e91zzrzILBisBxYEUB5EO5BOxy6lwbo6Ih8wKZwWSnFnd5JKf1TOQAS0tE9ctHdmo/dLbFXDtxT0On77Lk/4K1o9UzTP+EOyFOWxxQi6gZ+0nwhGIV+6kdpuQj90lfJ6q5SxJmf8Fh1WVSkITpcsgrxXFXmD5lDVKDjpN70qt/5QIt7ObMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAEY7uOmOnMvbaLNPwGgrZ3WZZ7fZw+8sNCChI7/Nzk=;
 b=LHu2vxdLDnao3xG79E9qx/SPFexR6z1LBZl4pRGb8P+WthFLQnJgiku5DY79df80+2eSILSWWlxcdkMi7GV0AuG+1n4NF8wLZDqaai3BFh74bSkNbUi79aKLqv7Usj/RdF8W9YhDC1/54MhPOOvpc/Gg+eXTyhhjDEpjFmG32b7kkt6cxnJ5b+xDTbESyUlXLIC3Zx3eIUDeQKSvCD9Y9UMa8i4RnSNvBgus2PwTn/BRG+x7eTbMnP/WIoQFEsgxIeynCfqaYQ0jbjEL2bPQRZAnn4hrfXZzy+/aFGnHZfo6gZMGsmm2PH67+lMiWPDsQz77dhFf3bsEwENYUy05Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAEY7uOmOnMvbaLNPwGgrZ3WZZ7fZw+8sNCChI7/Nzk=;
 b=XGyanXeLK50wYPpS5fMwf/fRmYkf8g49EE39BrxFkSdS6XiOic4GXYxEQGlFFuL2nZuby/Qf7xxHso3UZbOVeGg3RwV6YZn2RwlZ3dtVXMYn8q28WZ0dOhQ2UZ+p1LI8pPfIDa8nYMOX/IuqGhDD4IhvEGA1K3+wWYzRBGYtPKg=
Received: from DB7PR08MB3355.eurprd08.prod.outlook.com (2603:10a6:5:18::18) by
 DB6PR0802MB2533.eurprd08.prod.outlook.com (2603:10a6:4:a0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.16; Wed, 27 Jan 2021 13:00:38 +0000
Received: from DB7PR08MB3355.eurprd08.prod.outlook.com
 ([fe80::54aa:8448:7c5a:c39d]) by DB7PR08MB3355.eurprd08.prod.outlook.com
 ([fe80::54aa:8448:7c5a:c39d%7]) with mapi id 15.20.3784.016; Wed, 27 Jan 2021
 13:00:37 +0000
From:   Al Grant <Al.Grant@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>
CC:     "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>
Subject: RE: [PATCH V3 14/14] coresight: etm-perf: Add support for trace
 buffer format
Thread-Topic: [PATCH V3 14/14] coresight: etm-perf: Add support for trace
 buffer format
Thread-Index: AQHW9KuVqX+CG1q7qUmydSTm90xyhqo7bh6w
Date:   Wed, 27 Jan 2021 13:00:37 +0000
Message-ID: <DB7PR08MB3355B1A444324DBC5AF8003C86BB0@DB7PR08MB3355.eurprd08.prod.outlook.com>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-15-git-send-email-anshuman.khandual@arm.com>
 <YBFiecTmjA30qRaW@hirez.programming.kicks-ass.net>
In-Reply-To: <YBFiecTmjA30qRaW@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 30691DDF34E99E47924056DE155B05BA.0
x-checkrecipientchecked: true
Authentication-Results-Original: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [86.166.128.248]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a9f762c3-f05f-459b-38f2-08d8c2c38e95
x-ms-traffictypediagnostic: DB6PR0802MB2533:|AM8PR08MB6451:
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM8PR08MB6451E6AD93CB1983476F36EB86BB0@AM8PR08MB6451.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 5hVF72HFFraJdqZkAlo19+Msz5Y/Ec3MKnHwY1nuqsuUwXs28EOtxv8017KV94/HnpV5/uYF80l71IXemPzpUzXmHw5Cy0aTMx9KHD/rJTwaFHc+OzboOAZ+c6qDrnff6CK+/4lzA6H+rO59rmeVxzlr2iwHhOZamNN+j0UKbz/DaI/gnFI7BRZREU80UpbZbPcx3J1Q3oQXNrgZiiM6+OPwCa03KnRNy6w4937+W6JsVdwrCSO3jnVUAK/xNxKlbkEY1h30iHAqUi+ZTxO4ukCjiz2TMijyOfS5XaCCSPZCXtQLdZTk/qa7IhJEV4HT57bVYkIj8mhimbM2sn0BxzMI17llt7jFND4Fimly+/5VixhijRgjrFM7MCbsf5GcBIn0Aq/+1pwiR26rBrUhUDo/c5d/Lt8qz2uK32roLIip4R6I9h8CzDNke7g6MKzyOxUGEMhQ0Uubrgjq+p2Veu7FmTxrOoNLZgITefEY0ao6pggxTRNjX9gOXkvw7VdP2Q99B4qqZ+ycNvkdUcqySw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR08MB3355.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(9686003)(478600001)(110136005)(76116006)(66556008)(5660300002)(66946007)(83380400001)(71200400001)(66446008)(55016002)(66476007)(2906002)(52536014)(8676002)(4326008)(7696005)(8936002)(316002)(64756008)(33656002)(6636002)(26005)(6506007)(186003)(54906003)(86362001)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TXhGa3RpMGo0bXdJSWJ5RGM4QkxMWUpWNG5Oa1pTNmlUQTR1cm51SXVZWUJU?=
 =?utf-8?B?blVtTWh0RlQ1UXZXd3lVbkVwalVZTnlzODExZUtROFdYLzVXUHBacGV6Nitk?=
 =?utf-8?B?TFlEZ3JqNW53dUk2L0twK3BUSFdjTUlvMHpSbng3UTlmVHJrYjRVK3drenRk?=
 =?utf-8?B?L1dTZnhEdGRvWldOOEE5cURYL0duQXpWMWZDQjh3elBVanFzQzgvbWZMWHhv?=
 =?utf-8?B?aVd5d1VhVjMzUW82dVViUXRoQVBWcEttLzVvVVdWUHhyaUZEMlZsTDc2a3NF?=
 =?utf-8?B?MGVJVFBIL2ZWSjJlMmU1NE1YZ1hSWkNYU0luaXh5eVpob2RkTHBmN1k5T0xT?=
 =?utf-8?B?VGdYUW56WUFHYlNQZnIrL1dKVW5xaFZHeW5ncjlXZTFHMzhXSkdKQ2lpSDRP?=
 =?utf-8?B?TE1ZTzZtaDZSV3lNQmkrdldZU084dmpibXU0SHhMSldGLzdBOGRlOVV4RUQw?=
 =?utf-8?B?MnVoNUkrSU15K0crUFJLVE9zUDJQNnh2Y05VZWFNdXQyT09scUN4eFZqdENT?=
 =?utf-8?B?emtRU0l0aWh6bWVCcVBEY1pBWE0wZ0haR0xXZXRaRERWc0xUd20xVk1uUVAr?=
 =?utf-8?B?N3g3SUpEcE55OHZSZFBNV2t2NW9KQnBRaW8waUVqSlhOVWN1d09jRnFJcStt?=
 =?utf-8?B?ZDEwL0wvelFHazRheUhJNHhjNzdaUm4zUmVLUkFJNVdEV1g0bXdEUWtEc0l0?=
 =?utf-8?B?ZUZtaGFmTFBsOEpCSnZPUHZlanY2bFkzbERnWU5pVnlBaTFqTytuVmI2cEY4?=
 =?utf-8?B?MmxuU2FuVEdmTEZKVmNUc1FxcGpsdWJiaHMvWmpremZhZFdsWS9WTU9FZnVm?=
 =?utf-8?B?ckRSVTczb2RNTFZnUGxTQ09Vcy85QWt2RzNVV2drUXBpb3k2amVQQ0I1dmNq?=
 =?utf-8?B?cWdZMTdzM0RNZ2djN3gxVlIxQUR1bUI3NWRCUGQvcHhzZGJmMkJJQ2ZCUUVH?=
 =?utf-8?B?T2dYSS8rQmNDeVFpUTM5dk1HUmw0VE8xcGtkRFpCTUpsWnhKb2dNV3h6aEV2?=
 =?utf-8?B?Nkt1MTNmZ0wxV2R6M011NjhzOXZJR0pHdWYwNWl0RDQ3VWNKNDRNdlFuSVlx?=
 =?utf-8?B?MXdzQVFrbGpjM2dTblFXUVdYVnpKcEJQRUVlZWcvdjNSZ3U4NGhXRDBPQUpZ?=
 =?utf-8?B?NUR5ZHVDQUk5dEVEUlIzZ1RZWnNCRTFBbHlWeWQ3cUw5OVQ5YS9FOE8rWEh2?=
 =?utf-8?B?bXR1MkpRVVFLMzBISmdQTVRFYUk0Y2thVWNPaFVuNjN6bmdtR3oxa3Fod3I3?=
 =?utf-8?B?eFlZY05aL2pMckw5cDFuQnFKTGhwcUR2cndheGJzUFlNL0xuZzJxRG1VbWxS?=
 =?utf-8?B?Mm80cEpaUXRBdHplaUswSVAxU243NHd4TnVBd3hkKzg4QUx4c2ZneVdwV1pQ?=
 =?utf-8?B?ellxZUJ1NDhSWFJyZ3NpaWdHQllBS3grbGFtdUR0aXJpZkZDWUVlYVRBaXU1?=
 =?utf-8?Q?viI7Ject?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2533
Original-Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT060.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: b02ef974-f559-4582-b975-08d8c2c38af0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CFoGRGfiHB9m15e0KQdGUuYdBYYasTjs4wdE/Q6cE3iQaJ8II7DMC9tuYMV9fEs+jLKDGDKhkx9jzLp4Tcgl7SH8GFKrdyNiOk7X2RUYWy6LDe8yKuMRUWckNNB+JH21j0KxSvKbVQ0DNin2xdUkUWLRPF+1oQoE99/lbtNzfiuz4nYMIJie8Sd0a+MrfCzIl0m6pxBR0/PrbzBNuseE0lbB/gVRz7YReIuxGy6LtcE7k4DIQZhh98X9i2FsjvothwmgJIYdk/z9dVeWUAASRcmttkz73oHtcfk9iP28c/broTdUf8H2Rtqbw1kQAtJ1Sz66yiQQ/AbQndf3FifqWdEHEtobTxgooO2EYdk1R2q5O4t+yJbzzHLHBH8YPf1u3qB757Boz9r09k7wIWHmFDeFXQZd2ciDOIKhDESYNFEpIF4zliOutYaQfMwhD2sE0EBZ49ECkQm3qQyjGDvpTzx/jc13PPmogrxAmHrfPTMImyfmLB2ZYk7/zB7Rtkw7c/CPj4FmW2pmIrLz0CVnyKHwbGsl4wfrcoh8VRIfOq74h9nTA97tmMW2nIVuxFo/Y8VrKTNTsRhcMQupUS4ocSorxuUfoxXcLpqOPyYufJI=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(46966006)(316002)(83380400001)(81166007)(9686003)(2906002)(356005)(26005)(82740400003)(478600001)(70206006)(52536014)(8936002)(55016002)(54906003)(82310400003)(33656002)(5660300002)(70586007)(186003)(6506007)(4744005)(47076005)(7696005)(86362001)(110136005)(336012)(8676002)(107886003)(4326008)(6636002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 13:00:43.9330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f762c3-f05f-459b-38f2-08d8c2c38e95
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT060.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6451
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICsvKiBDb3JlU2lnaHQgUE1VIEFVWCBidWZmZXIgZm9ybWF0cyAqLw0KPiA+ICsjZGVmaW5l
IFBFUkZfQVVYX0ZMQUdfQ09SRVNJR0hUX0ZPUk1BVF9DT1JFU0lHSFQJMHgwMDAwIC8qDQo+IERl
ZmF1bHQgZm9yIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgKi8NCj4gPiArI2RlZmluZSBQRVJGX0FV
WF9GTEFHX0NPUkVTSUdIVF9GT1JNQVRfUkFXCQkweDAxMDAgLyoNCj4gUmF3IGZvcm1hdCBvZiB0
aGUgc291cmNlICovDQo+IA0KPiBXb3VsZCBDT1JFU0lHSFRfRk9STUFUX0VUUiAvIENPUkVTSUdI
VF9GT1JNQVRfVFJCRSBiZSBiZXR0ZXINCj4gbmFtZXM/DQoNClVuZm9ybWF0dGVkIChyYXcpIHN0
cmVhbXMgY291bGQgYmUgdXNlZCBhbnkgdGltZSB5b3UgaGFkIGEgd3JpdGVyIGRlZGljYXRlZA0K
dG8gYSBzaW5nbGUgdHJhY2Ugc291cmNlLiBTbyBpbiBhIHNpdHVhdGlvbiB3aGVyZSB5b3UgaGFk
IG9uZSBFVFIgcGVyIENQVSwNCml0IHdvdWxkIGJlIGFwcHJvcHJpYXRlIHRvIHVzZSBhbiB1bmZv
cm1hdHRlZCBzdHJlYW0uIEEgVFJCRSBpcyBhbHdheXMNCmRlZGljYXRlZCB0byBhIHNpbmdsZSBD
UFUsIGJ1dCBwb3RlbnRpYWxseSB5b3UgKGkuZS4gd2hlbiBkZXNpZ25pbmcgdGhlIHN5c3RlbSkN
CmNhbiBkbyB0aGlzIHdpdGggYW55IHR5cGUgb2YgdHJhY2Ugc2luay4gU28gdGhlIHJhdy9mb3Jt
YXR0ZWQgZGlzdGluY3Rpb24gaXMNCnJlYWxseSBhYm91dCB3aGV0aGVyIHlvdSBhcmUgY29tYmlu
aW5nIG11bHRpcGxlIHN0cmVhbXMgaW4gb25lIGJ1ZmZlciBvciBub3QsDQpyYXRoZXIgdGhhbiB0
aGUgdHlwZSBvZiBibG9jayB0aGF0IGlzIHdyaXRpbmcgaW50byB0aGUgYnVmZmVyLg0KDQpBbCAN
Cg0K
