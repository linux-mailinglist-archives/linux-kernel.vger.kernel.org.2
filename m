Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88F53584DF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhDHNjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:39:47 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:45520 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231195AbhDHNjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:39:42 -0400
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C00C7C09C2;
        Thu,  8 Apr 2021 13:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617889171; bh=q0+7fa2LJ35gT3Eg/emhNJDiDEIehsLQQ4dUApsLRUQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=aZiyrCDaYssKkeoAweiVyookuwmTP4dU5lz4EYd9+0UyBG89R8v5HlXbId0wmMNAr
         yDrJ1Jl1krNQZrA6Dc4V7a6hP/zSdJzw6ZlYkfa15zvwNzfSApJg1yGKbcOyPJuYVw
         GbekR+KYZ4Ob1580ga3WYOz1egT4pip1nc37tsBWi4mfQixVG1V6+02HTU2t6i3atD
         X7RtYDqdnDIRi+6XvTMeinvbWxiuFNRx12H05i7SKwA9Poyh9rgRzh30j4jx3y0iwj
         RWo34Fu60bgd2EUvUDYYvGiBPC8XdzVCW1GPtSoTyzc7pPZRePGTdx96uvfafS65Uw
         kYokTAcelZEzg==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 96DF2A007C;
        Thu,  8 Apr 2021 13:39:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4EFC24014D;
        Thu,  8 Apr 2021 13:39:31 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="H43JZVwj";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ld9Ck0R3RquztllBfaRXXW3468i3EnF7Nb+huoMsmGSDJuJlZKetZ5ILptwqcbaVrAs25ZxqZEhoYL5xOUZs3SqXqFJ3M4T26F4S7CXDEkQy8i0utszEzJkmTmAFNKuAnOWWFK+H0zkI2QceIiCVJhnCK8WRQNyT4ZfuIYnrU5fexmM9eL9MP2bCBJJ33YFBngcK/bIWHv62x94Rjnr+WI7R2zu4B09lPeI0MUiTwo86+KAd51e8Kt1f/5aFEyId4c66Mmuwx33tUT0oYH87OUta+Y2DEyxbDyqXPO65tCjClsnjJuChOqSe/DI/WTkzASHzQYXf3JFzfsSjoZde8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0+7fa2LJ35gT3Eg/emhNJDiDEIehsLQQ4dUApsLRUQ=;
 b=Oivlyl/yrAbOVjmdY6kg9SCvkPYLUVa5LcqjwDpP2xht5+uRz6C06HTHpgBodneEqc+Qf0M/v4aOjLEKpXPhxXubwF/qqyhVku1VNY+UEbzDqnU2ntpHGcYv1j++127HkdGhSpBcS8yMyOBVawnMYGBCJjGsiyqICLe5scS9HDOGZ+fQmO2sZC5tOh7rEqiKOiah1FzY6PD/Cq0xSIwQBIOZmlIHo/NyOeek+DcT1BaUpFFBRQIygRAAnHpho7b26a0CTs5H3cAOduCN4sq60advR8msrKiwxdgXyipCiquSj2e7tn+FDwlEZFpFITsVVcHMew8oXlgwOYyEfZLt8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0+7fa2LJ35gT3Eg/emhNJDiDEIehsLQQ4dUApsLRUQ=;
 b=H43JZVwjs/GlKt5gLdy1/AVNYmZ42u10qaJ9uhfXmLWY1fr5kWlxqjHwa5u9Vjnr55NziF7B0Sx9/ApU8mj/HE2EhLV0JPNI1gVEcnWISkX4M91C8zwlnebItaaKEhoVVbDAYH9nqFAZs+oVyfLJhhzbGyVsLzYaN4qe2LFGbTU=
Received: from BYAPR12MB3462.namprd12.prod.outlook.com (2603:10b6:a03:ad::16)
 by BYAPR12MB4773.namprd12.prod.outlook.com (2603:10b6:a03:109::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 8 Apr
 2021 13:39:28 +0000
Received: from BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1]) by BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1%4]) with mapi id 15.20.4020.018; Thu, 8 Apr 2021
 13:39:28 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Youn <John.Youn@synopsys.com>
Subject: Re: [PATCH v3 06/14] usb: dwc2: Add enter partial power down when
 port is suspended
Thread-Topic: [PATCH v3 06/14] usb: dwc2: Add enter partial power down when
 port is suspended
Thread-Index: AQHXLFvge0CGm6ECeEupS6JWMcWL3qqqoHiA
Date:   Thu, 8 Apr 2021 13:39:28 +0000
Message-ID: <df85b0b6-2bcc-e64b-ff80-fcc650b9cac3@synopsys.com>
References: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
 <20210408094510.6C4E9A022E@mailhost.synopsys.com>
In-Reply-To: <20210408094510.6C4E9A022E@mailhost.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [37.252.80.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43286d80-0822-41e4-57de-08d8fa93bb76
x-ms-traffictypediagnostic: BYAPR12MB4773:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB4773C3B60BF18C678F696871A7749@BYAPR12MB4773.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OegGa5SbBpuNndO8Xyu1Jv8KnUl/iB8S6ME0EzwLCZLHAWIFOEGo7E9HrbtOVzs53EOjvjoCN7TJ1ymCu8HB+QTAh54+0Qm6LcewPrMptDxZrsHuU/wW7rm8ktBFU2U7Kal5g0yPrrgqSqgNksldwB2WXlt5/2bCY6qygo8Zy7L8s/9zCvKp9k4vlex0jdF38zqCVZJ9W+jd0kGyowKaNFPE9sSuYVCvDwBZ3RJHucbBRuq2HhmK+dwl2fw7JiOvv7JESc8lV57/jz499DYydu3GXOMagc4AIMx4da3eg6KAG/x7WHcLC2XwMWhZbGoq/+KA2ZWiDl1rIXKexT/T9kxbsJIQ31Nv5hu8KlEZpXySadHax12M/gBUPnd4JPMflETqtlrXqRYUoaD8FBivV57qMDCC+o5k+iv0s/EUu9KWuHIR8js//ouWYh71X3WNXbT56MgkE8OXZKzN0xevj+bLxrUXTp7EHWuxR7bXTxmxhS9Wwd69umFrVAo0Q8Qk8KfBZAEEnb1UhoLqi7tpHypvlCMEam8sPLMu2GYJIA9QbbaFoERkGuL3p62UJbhaqRqDXklK8fpBfRho1N/HOKMJm2mrbuXShM52BFx+13nuogvUCbcNfjKINkUVgMu/hI8OFtMyZ7Dya+LUWfJeC3xkF8EXOL7NTGtb/zsO1qpexZ2i32otCzQtKIi/mtK4MyoW17X00lr27uVH0JZnW89Tfrl/4tcWFwlsfRZYow4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3462.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(396003)(136003)(376002)(39860400002)(66476007)(66946007)(66556008)(83380400001)(107886003)(64756008)(31686004)(478600001)(66446008)(15650500001)(4326008)(86362001)(36756003)(31696002)(6512007)(110136005)(316002)(2616005)(2906002)(8676002)(5660300002)(8936002)(6506007)(6486002)(186003)(38100700001)(26005)(76116006)(71200400001)(91956017)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bGVNMzRUZjFkWkgvclp6MFdYTWNWSTJtNHBtdHg0Y3kvVmFvYkRramhjcUlw?=
 =?utf-8?B?NlRpTUFhNWtzbGtHSkFuQlY1d1FPeENWejJvZDdyNFFHelQrOUVOdHIrdUpL?=
 =?utf-8?B?QXJHTVRGeTVwV1MwV3haUjc1aGlOaFFKQkNYWFRxYm9ZcGorRjFIU2lIK1kx?=
 =?utf-8?B?Rm1xdldGZEQ3aEJVSFRTMzdsYkNHd2lPTFhIenlCS1hJMUU4dFNSNkxLSTZo?=
 =?utf-8?B?NW1pK05YR1hjYU14QUM2OFJKczBPd1UzL0Jsdi9Uc1ZyR05KU2NQMS9maFVk?=
 =?utf-8?B?emgvWFZjZHp4ZTBTa3dRR1JBZmNpWU1DeURHTVJTdDd1SFBtb28yYkZFMU42?=
 =?utf-8?B?cjhJWHRPQU94c3NvdDF5NkxMdHpOR0dxWWNaUUtDT2xDTFZpL2FnYTZxTGZU?=
 =?utf-8?B?OFVmVG1rbXRicGxLWVhSZWJmZE55NEhWWFhoSHNxWlF0bitoVC9vNXpQUzVI?=
 =?utf-8?B?bzhiRTk5SjBIZjhCWnhDQWZwbytlUnNmeFU5eEZMR285elRCMm55dkswUWl2?=
 =?utf-8?B?VzJZUjZxYVpGamMyYzQwRHcvYmdwVDdyRitxdzBxSzZPSmtSWElnaHZyb1cx?=
 =?utf-8?B?c0lpM0FRYVFOK3BWNWlJbzcxNEN0VDVrbHZqUjJkV2o5VTVnRXYwd083TGNl?=
 =?utf-8?B?R1NGTm0ybmtIOUxmemlVT1NsWGJQUDR2d2JTb0lpTld0eXpmaHRMek5kZGJt?=
 =?utf-8?B?Qm8rVklZUTE0N2FSb011cDJrTzg2RHNnK0Q1VE1QMTk0ajdYeWJXeWVzOTRI?=
 =?utf-8?B?Ym9UcXBOOFN6cFdQVlZ2aGhNN2tZZkszRHUyUXBWSStHYmw1SFNKTXpUMnhJ?=
 =?utf-8?B?c1IvMHNmdW9RMHFZM3Z6Q1VSTGw5Sy94RWtzNUt4alJlU0NnZEVkVDhweGph?=
 =?utf-8?B?c3lYbUN0bWNkWi9kbForVUF0Zmg0V1I4NEZXWnRIbisrYWhFbUxCYk43VUVH?=
 =?utf-8?B?MllzVnBpYTVOL2Jmbk5UL1Y4NmFlYXk5cjQ2Vi9scm9Va0pqcFlNeHo1YVlt?=
 =?utf-8?B?SDBDek9hbHU4eXlLK2RGYVVvaVZpSENZZEhLZ285WTV5OGIwcnl3QklMUStx?=
 =?utf-8?B?MFdnZ0xkRzRiby9xQlU4Y3ZkM2FWbmN0SW9PV3hvMDM2Y0h4QzV5RW9adlo1?=
 =?utf-8?B?K2pvSW1KYzcxZlptR0c4bnB6bm5DcENNbDY4VjRoeDV0TGVzbGJhMWRrTFhZ?=
 =?utf-8?B?b0VSK09nSFVOV1NqQ3phUVhDb2srMUhzU1J5RVE0MVptRXc2WEovWXVmMjBK?=
 =?utf-8?B?VWZDVWFReTF3d3FJOTh1VkUzYjZreUVmQnF6TnVVRlhaL255OHNvdGx6eHpE?=
 =?utf-8?B?UGRPcThWZmlJMGdITmNnaTc1NW5VMk5JVm56ZWtGdGZPMStmUzhqa29GaXhT?=
 =?utf-8?B?RFk4cWlNNW0ycUtNSVpNcmNqQTlibFIwdHF0dmVnS1I4ZjJiME5HcU5ydXBQ?=
 =?utf-8?B?MXVwN0pUdDJUdnhOeEtRZW5xREpreHRMVFF0WWZxTjRyOUJkUmlDWldLdjY2?=
 =?utf-8?B?WXErSW50cFJ6bC9EbVdlcnpCRERJdDlWdEVSVThLUUZUdXZORVRMempwWkhB?=
 =?utf-8?B?QjJnaWEycGVqZkhqMHZFVFdMaFAwUkcrNjl2ZkFVNlRYVUYvazJGd2d3cFgx?=
 =?utf-8?B?ZEIwSGZQeCtISnk4TEtZS2dtanpwQVJXdFo5Vll6UURoZ3Y5UDRucmJHREtj?=
 =?utf-8?B?RlZHOHZuQytMRHNlWmF5SElIOVdCM0FBbTY5YlpEZS9adkRNOXAvR3kwaXpv?=
 =?utf-8?Q?9a0eo736GSpvE5lJGc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2ABF5B502AB14B4EBF7766573CDE4DAF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43286d80-0822-41e4-57de-08d8fa93bb76
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 13:39:28.3557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lM6TeUf9b9kEfXbZWg713a/XkM4DG27y/Dp2WPmXCk/h9YHfwJJRVX2/nSRUBcrrXLjLU+GbLOGSg+4I9uBTHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4773
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC84LzIwMjEgMTo0NSBQTSwgQXJ0dXIgUGV0cm9zeWFuIHdyb3RlOg0KPiBBZGRzIGZsb3cg
b2YgZW50ZXJpbmcgUGFydGlhbCBQb3dlciBEb3duIGluDQo+ICJkd2MyX3BvcnRfc3VzcGVuZCgp
IiBmdW5jdGlvbiB3aGVuIGNvcmUgcmVjZWl2ZXMgc3VzcGVuZC4NCj4gDQo+IE5PVEU6IFN3aXRj
aCBjYXNlIHN0YXRlbWVudCBpcyB1c2VkIGZvciBoaWJlcm5hdGlvbiBwYXJ0aWFsDQo+IHBvd2Vy
IGRvd24gYW5kIGNsb2NrIGdhdGluZyBtb2RlIGRldGVybWluYXRpb24uIEluIHRoaXMgcGF0Y2gN
Cj4gb25seSBQYXJ0aWFsIFBvd2VyIERvd24gaXMgaW1wbGVtZW50ZWQgdGhlIEhpYmVybmF0aW9u
IGFuZA0KPiBjbG9jayBnYXRpbmcgaW1wbGVtZW50YXRpb25zIGFyZSBwbGFubmVkIHRvIGJlIGFk
ZGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQXJ0dXIgUGV0cm9zeWFuIDxBcnRodXIuUGV0cm9z
eWFuQHN5bm9wc3lzLmNvbT4NCg0KQWNrZWQtYnk6IE1pbmFzIEhhcnV0eXVueWFuIDxNaW5hcy5I
YXJ1dHl1bnlhbkBzeW5vcHN5cy5jb20+DQoNCj4gLS0tDQo+ICAgQ2hhbmdlcyBpbiB2MzoNCj4g
ICAtIE5vbmUNCj4gICBDaGFuZ2VzIGluIHYyOg0KPiAgIC0gTm9uZQ0KPiANCj4gICBkcml2ZXJz
L3VzYi9kd2MyL2NvcmUuaCB8ICA1ICsrKy0tDQo+ICAgZHJpdmVycy91c2IvZHdjMi9oY2QuYyAg
fCA0OCArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPiAgIDIgZmls
ZXMgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMi9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2MyL2NvcmUu
aA0KPiBpbmRleCBiN2Q5OWNmOWU4NGMuLjc2ODA3YWJkNzUzYiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy91c2IvZHdjMi9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9jb3JlLmgNCj4g
QEAgLTE0NzAsNyArMTQ3MCw3IEBAIHZvaWQgZHdjMl9oY2RfY29ubmVjdChzdHJ1Y3QgZHdjMl9o
c290ZyAqaHNvdGcpOw0KPiAgIHZvaWQgZHdjMl9oY2RfZGlzY29ubmVjdChzdHJ1Y3QgZHdjMl9o
c290ZyAqaHNvdGcsIGJvb2wgZm9yY2UpOw0KPiAgIHZvaWQgZHdjMl9oY2Rfc3RhcnQoc3RydWN0
IGR3YzJfaHNvdGcgKmhzb3RnKTsNCj4gICBpbnQgZHdjMl9jb3JlX2luaXQoc3RydWN0IGR3YzJf
aHNvdGcgKmhzb3RnLCBib29sIGluaXRpYWxfc2V0dXApOw0KPiAtdm9pZCBkd2MyX3BvcnRfc3Vz
cGVuZChzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcsIHUxNiB3aW5kZXgpOw0KPiAraW50IGR3YzJf
cG9ydF9zdXNwZW5kKHN0cnVjdCBkd2MyX2hzb3RnICpoc290ZywgdTE2IHdpbmRleCk7DQo+ICAg
dm9pZCBkd2MyX3BvcnRfcmVzdW1lKHN0cnVjdCBkd2MyX2hzb3RnICpoc290Zyk7DQo+ICAgaW50
IGR3YzJfYmFja3VwX2hvc3RfcmVnaXN0ZXJzKHN0cnVjdCBkd2MyX2hzb3RnICpoc290Zyk7DQo+
ICAgaW50IGR3YzJfcmVzdG9yZV9ob3N0X3JlZ2lzdGVycyhzdHJ1Y3QgZHdjMl9oc290ZyAqaHNv
dGcpOw0KPiBAQCAtMTQ5NSw3ICsxNDk1LDggQEAgc3RhdGljIGlubGluZSB2b2lkIGR3YzJfaGNk
X3N0YXJ0KHN0cnVjdCBkd2MyX2hzb3RnICpoc290Zykge30NCj4gICBzdGF0aWMgaW5saW5lIHZv
aWQgZHdjMl9oY2RfcmVtb3ZlKHN0cnVjdCBkd2MyX2hzb3RnICpoc290Zykge30NCj4gICBzdGF0
aWMgaW5saW5lIGludCBkd2MyX2NvcmVfaW5pdChzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcsIGJv
b2wgaW5pdGlhbF9zZXR1cCkNCj4gICB7IHJldHVybiAwOyB9DQo+IC1zdGF0aWMgaW5saW5lIHZv
aWQgZHdjMl9wb3J0X3N1c3BlbmQoc3RydWN0IGR3YzJfaHNvdGcgKmhzb3RnLCB1MTYgd2luZGV4
KSB7fQ0KPiArc3RhdGljIGlubGluZSBpbnQgZHdjMl9wb3J0X3N1c3BlbmQoc3RydWN0IGR3YzJf
aHNvdGcgKmhzb3RnLCB1MTYgd2luZGV4KQ0KPiAreyByZXR1cm4gMDsgfQ0KPiAgIHN0YXRpYyBp
bmxpbmUgdm9pZCBkd2MyX3BvcnRfcmVzdW1lKHN0cnVjdCBkd2MyX2hzb3RnICpoc290Zykge30N
Cj4gICBzdGF0aWMgaW5saW5lIGludCBkd2MyX2hjZF9pbml0KHN0cnVjdCBkd2MyX2hzb3RnICpo
c290ZykNCj4gICB7IHJldHVybiAwOyB9DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2My
L2hjZC5jIGIvZHJpdmVycy91c2IvZHdjMi9oY2QuYw0KPiBpbmRleCBmNDI0N2E2NmMyYjIuLmU3
ZmIwZDU5NDBiYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMi9oY2QuYw0KPiArKysg
Yi9kcml2ZXJzL3VzYi9kd2MyL2hjZC5jDQo+IEBAIC0zMjgxLDE1ICszMjgxLDE4IEBAIHN0YXRp
YyBpbnQgZHdjMl9ob3N0X2lzX2JfaG5wX2VuYWJsZWQoc3RydWN0IGR3YzJfaHNvdGcgKmhzb3Rn
KQ0KPiAgICAqIEBoc290ZzogUHJvZ3JhbW1pbmcgdmlldyBvZiB0aGUgRFdDX290ZyBjb250cm9s
bGVyDQo+ICAgICogQHdpbmRleDogVGhlIGNvbnRyb2wgcmVxdWVzdCB3SW5kZXggZmllbGQNCj4g
ICAgKg0KPiArICogUmV0dXJuOiBub24temVybyBpZiBmYWlsZWQgdG8gZW50ZXIgc3VzcGVuZCBt
b2RlIGZvciBob3N0Lg0KPiArICoNCj4gICAgKiBUaGlzIGZ1bmN0aW9uIGlzIGZvciBlbnRlcmlu
ZyBIb3N0IG1vZGUgc3VzcGVuZC4NCj4gICAgKiBNdXN0IE5PVCBiZSBjYWxsZWQgd2l0aCBpbnRl
cnJ1cHQgZGlzYWJsZWQgb3Igc3BpbmxvY2sgaGVsZC4NCj4gICAgKi8NCj4gLXZvaWQgZHdjMl9w
b3J0X3N1c3BlbmQoc3RydWN0IGR3YzJfaHNvdGcgKmhzb3RnLCB1MTYgd2luZGV4KQ0KPiAraW50
IGR3YzJfcG9ydF9zdXNwZW5kKHN0cnVjdCBkd2MyX2hzb3RnICpoc290ZywgdTE2IHdpbmRleCkN
Cj4gICB7DQo+ICAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICAgCXUzMiBocHJ0MDsNCj4gICAJ
dTMyIHBjZ2N0bDsNCj4gICAJdTMyIGdvdGdjdGw7DQo+ICsJaW50IHJldCA9IDA7DQo+ICAgDQo+
ICAgCWRldl9kYmcoaHNvdGctPmRldiwgIiVzKClcbiIsIF9fZnVuY19fKTsNCj4gICANCj4gQEAg
LTMzMDIsMjIgKzMzMDUsMzEgQEAgdm9pZCBkd2MyX3BvcnRfc3VzcGVuZChzdHJ1Y3QgZHdjMl9o
c290ZyAqaHNvdGcsIHUxNiB3aW5kZXgpDQo+ICAgCQloc290Zy0+b3Bfc3RhdGUgPSBPVEdfU1RB
VEVfQV9TVVNQRU5EOw0KPiAgIAl9DQo+ICAgDQo+IC0JaHBydDAgPSBkd2MyX3JlYWRfaHBydDAo
aHNvdGcpOw0KPiAtCWhwcnQwIHw9IEhQUlQwX1NVU1A7DQo+IC0JZHdjMl93cml0ZWwoaHNvdGcs
IGhwcnQwLCBIUFJUMCk7DQo+IC0NCj4gLQloc290Zy0+YnVzX3N1c3BlbmRlZCA9IHRydWU7DQo+
IC0NCj4gLQkvKg0KPiAtCSAqIElmIHBvd2VyX2Rvd24gaXMgc3VwcG9ydGVkLCBQaHkgY2xvY2sg
d2lsbCBiZSBzdXNwZW5kZWQNCj4gLQkgKiBhZnRlciByZWdpc3RlcnMgYXJlIGJhY2t1cGVkLg0K
PiAtCSAqLw0KPiAtCWlmICghaHNvdGctPnBhcmFtcy5wb3dlcl9kb3duKSB7DQo+IC0JCS8qIFN1
c3BlbmQgdGhlIFBoeSBDbG9jayAqLw0KPiAtCQlwY2djdGwgPSBkd2MyX3JlYWRsKGhzb3RnLCBQ
Q0dDVEwpOw0KPiAtCQlwY2djdGwgfD0gUENHQ1RMX1NUT1BQQ0xLOw0KPiAtCQlkd2MyX3dyaXRl
bChoc290ZywgcGNnY3RsLCBQQ0dDVEwpOw0KPiAtCQl1ZGVsYXkoMTApOw0KPiArCXN3aXRjaCAo
aHNvdGctPnBhcmFtcy5wb3dlcl9kb3duKSB7DQo+ICsJY2FzZSBEV0MyX1BPV0VSX0RPV05fUEFS
QU1fUEFSVElBTDoNCj4gKwkJcmV0ID0gZHdjMl9lbnRlcl9wYXJ0aWFsX3Bvd2VyX2Rvd24oaHNv
dGcpOw0KPiArCQlpZiAocmV0KQ0KPiArCQkJZGV2X2Vycihoc290Zy0+ZGV2LA0KPiArCQkJCSJl
bnRlciBwYXJ0aWFsX3Bvd2VyX2Rvd24gZmFpbGVkLlxuIik7DQo+ICsJCWJyZWFrOw0KPiArCWNh
c2UgRFdDMl9QT1dFUl9ET1dOX1BBUkFNX0hJQkVSTkFUSU9OOg0KPiArCWNhc2UgRFdDMl9QT1dF
Ul9ET1dOX1BBUkFNX05PTkU6DQo+ICsJZGVmYXVsdDoNCj4gKwkJaHBydDAgPSBkd2MyX3JlYWRf
aHBydDAoaHNvdGcpOw0KPiArCQlocHJ0MCB8PSBIUFJUMF9TVVNQOw0KPiArCQlkd2MyX3dyaXRl
bChoc290ZywgaHBydDAsIEhQUlQwKTsNCj4gKwkJaHNvdGctPmJ1c19zdXNwZW5kZWQgPSB0cnVl
Ow0KPiArCQkvKg0KPiArCQkgKiBJZiBwb3dlcl9kb3duIGlzIHN1cHBvcnRlZCwgUGh5IGNsb2Nr
IHdpbGwgYmUgc3VzcGVuZGVkDQo+ICsJCSAqIGFmdGVyIHJlZ2lzdGVycyBhcmUgYmFja3VwZWQu
DQo+ICsJCSAqLw0KPiArCQlpZiAoIWhzb3RnLT5wYXJhbXMucG93ZXJfZG93bikgew0KPiArCQkJ
LyogU3VzcGVuZCB0aGUgUGh5IENsb2NrICovDQo+ICsJCQlwY2djdGwgPSBkd2MyX3JlYWRsKGhz
b3RnLCBQQ0dDVEwpOw0KPiArCQkJcGNnY3RsIHw9IFBDR0NUTF9TVE9QUENMSzsNCj4gKwkJCWR3
YzJfd3JpdGVsKGhzb3RnLCBwY2djdGwsIFBDR0NUTCk7DQo+ICsJCQl1ZGVsYXkoMTApOw0KPiAr
CQl9DQo+ICAgCX0NCj4gICANCj4gICAJLyogRm9yIEhOUCB0aGUgYnVzIG11c3QgYmUgc3VzcGVu
ZGVkIGZvciBhdCBsZWFzdCAyMDBtcyAqLw0KPiBAQCAtMzMzMiw2ICszMzQ0LDggQEAgdm9pZCBk
d2MyX3BvcnRfc3VzcGVuZChzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcsIHUxNiB3aW5kZXgpDQo+
ICAgCX0gZWxzZSB7DQo+ICAgCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZoc290Zy0+bG9jaywg
ZmxhZ3MpOw0KPiAgIAl9DQo+ICsNCj4gKwlyZXR1cm4gcmV0Ow0KPiAgIH0NCj4gICANCj4gICAv
KioNCj4gDQoNCg==
