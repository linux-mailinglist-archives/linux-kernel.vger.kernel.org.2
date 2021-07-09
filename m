Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FE63C2211
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 12:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhGIKJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 06:09:22 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:39332 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhGIKJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 06:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1625825198; x=1657361198;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jUXT5EflSYGDT88e/QjMvGa0ZEMnJWi/KYtYQ3oN5As=;
  b=wkWQOJQ2703sCobmmteycr7XFdpYRNZl3rW1n8CAf/Befp7HHX8/DK5c
   lrjJY/GeBN5LarYYYbQl/QBlDmDdfM3b1nfBcZHCfuWYKVa6P9o5j/8/o
   DWe3xberDQW2/cKOmedkduILT4oXzUSqBwdkg5cqCVR4ND8LLRbN/bG2z
   TZqdAs7juobuU6BEamdRjppNtmAB9sTbg9mVHj1HufQtWFwRuCSW41/n6
   3z+ZoNrTzKmZJ0/fSshO//u+SbYUyH6inFuKToxU61EIF4jZFTpq2bzV5
   w7BJWq/uzh+q1B4RH0mKEweySS3Iqt7nVQXy7DsMZF8CKzraZTcBWm67x
   w==;
IronPort-SDR: DghHrpRQ5RD6uxFM8OYjYz1m/jgtxiBZ7Fo+gCaRP9GU8Os94uEIvz9KIQDlAaDZ6SXfgFeVnb
 vQ1ktKVj83lNRBMAHyT1tr0Wo4NRtXryzWMTF42rXJoBjyMLxdpn4icphFZ8uHcKMvLkY8ub+0
 yRMcOVUs0yfH083syTji9Y2kKeHEgqSifq8VW0H/exn9p9CLb2LCrsZkMLxHq8CkdqLvLs4EIP
 1UaRuCYjoP8PNWyKeCE9JxY5WZa8DwcjeIyk+b/BUkVqyxMwXFj3v9izabDy2YjRdzOSsI8y3D
 Lsg=
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="128231304"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2021 03:06:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Jul 2021 03:06:38 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Fri, 9 Jul 2021 03:06:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaSzDzzae5pmnN7SfCiOmuaKUCu6txNsVKXPbPnYwhiT0aQarlOZxVXZTGkzjuOPubl4TSjiduoVZEszszqG0Ffr7Be0qSFunB7iU2sK4wEK0AZWNxLcY+kbVyIDWPukadparbYAI1T69f22dHxGBu2rO55nIphWWtSQRuAkGceDBnE+K/GUHw+tZhcsBQDrdw97ZU8jSeRq74BMdR9ZaQISXjVvyiIluqNN53WDH/tHVtM2wEwv1QpvABlVJs+G+QHkleW0v1mwxEI6McObdACN2/GV0h2swCiQ5t49h9updK5lkw0maIffBrCOZy5WQKhYgjlnbAGxQDFgukvnjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUXT5EflSYGDT88e/QjMvGa0ZEMnJWi/KYtYQ3oN5As=;
 b=ieoqj2RxxR3YE2r/r9ynYS1ClX9K0Ew4hklOWgfnxqvlw5h3c+nY78ZC7ZIVF5yd9dp0RRncxj/0/9weXOYARuXZ33joYmS05KylN5XF1MopYtUIn6J/g/WM/GZGumdjlVf4MSd0RFlPDRTwGUInwgP7cOpoxuqfauoCcoZJIoKuUM0YCUveIWWWgZFx8J+Fr2jg0o7d8YRy+2V+iHSz3s1hP4/zszsCKWVA4Gv+VTRQ9lncWUO930GpRxu3U+1nZ0aAsH1tIB6JTcnoOoZSR5EhQdwu7+AZi9WsLueKY3znViBqqV9s5vXqji8qXUZDE5AmwIQhTcDWI+qr4k40wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUXT5EflSYGDT88e/QjMvGa0ZEMnJWi/KYtYQ3oN5As=;
 b=Q8NndNpe4KJatLXvqibJ+VfSleO6lFfNhZQudozfMoiMT8dGcbJ74sqgF7uiBH0KgXLcdyLUOY3HzhqfMPF/uUn0gY5lQPpWMIBWFrQa91BBA5erMEEZ+YFK5Y9wEaQhOJJsmL+pFKb1XXgPyWobK1Z8oHqe1M2QWOV85XqImyM=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by MWHPR11MB1696.namprd11.prod.outlook.com (2603:10b6:300:23::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Fri, 9 Jul
 2021 10:06:36 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::7476:4bab:7cdb:8957]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::7476:4bab:7cdb:8957%5]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 10:06:36 +0000
From:   <Conor.Dooley@microchip.com>
To:     <bmeng.cn@gmail.com>, <palmer@dabbelt.com>,
        <Lewis.Hanly@microchip.com>, <atish.patra@wdc.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     <bin.meng@windriver.com>
Subject: Re: [PATCH 2/2] riscv: dts: microchip: Add ethernet0 to the aliases
 node
Thread-Topic: [PATCH 2/2] riscv: dts: microchip: Add ethernet0 to the aliases
 node
Thread-Index: AQHXbuOt78KiCv7mkU2HU2lFOfAqWas6dmuA
Date:   Fri, 9 Jul 2021 10:06:36 +0000
Message-ID: <a2135d4f-4ecb-160a-a56a-30db76acb948@microchip.com>
References: <20210702014319.1265766-1-bmeng.cn@gmail.com>
 <20210702014319.1265766-2-bmeng.cn@gmail.com>
In-Reply-To: <20210702014319.1265766-2-bmeng.cn@gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0941a1ed-e52a-40d5-de02-08d942c13cb0
x-ms-traffictypediagnostic: MWHPR11MB1696:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1696B790A964C2A132D165DD98189@MWHPR11MB1696.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EjeVbYnZCF5LHVemShQUP4aFzrDmsKILUyA0aXbuozxmg/EmrgvLo8RH7kMclhBcp/Dk0KiLOCrfstJZd0Q5ale05wGimeivv7zWNWUa/9ml0nzxUtcxokf9tnV0gZy68Omq+r+sW9FkHgWOrjz7HLLNvkRTxmmQZ5UizvPPVADqYqduWhNs9yNml3OQbia85MgoaYkskFWP/fXiVqsOvAILcmmyGvzBhOnTyX7fpr40quHkNnptLke+yrQdkG9zT/UnsWVV3zCt0UUYtOWqRZeaNAdkLUfFeH9Ht6RdnjcwP8RiyiJxfv0u4qYMS7OloriT6ohNubrP8X0RH0NkeT4BCd4FEj6VEtAhm94jEYu2i/WnIYyP+1xoMNydpr/7ukSOsKfyhxBvnqv9+mfZVppauz9ooG3c/dffzkQl1Qdxhe+9JvhgU5/MNfNOgqYfel8bua3rNfBubNvs/6PUaBgJohT6ygipFGek3aGey2LuMFNmd3XvGAVaifqlDnQyV63E0asf0MTCtWQWeR2bLt1YVb9PCVZRldQiPnGYuMRz2JXMeZ6vH6HsOU7GSG7nTnLiYwDM1jMCcoBhOBYk16bns54fywV0baQ6u9K519uug3csPMnfpr6a3soQOu1jWJke0AEoQz6PqQxfRrzboXdS+zRXBR+fK1JUu/ZkR1ZnwfcG/8m1d30vioE7QVSJXlHEI/ii0wqaGGdLmZRY3wWq3lE++XgyMpFgV1XByE4AJZ+3YjDHfIXtcCHVcNC6iFK94djKRyO5LSM0ALuGJzW9mq8PQWqq4cV+SpRSnSZCTCwETZQCWu6kYxfmZ+i4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(396003)(136003)(376002)(6506007)(2616005)(2906002)(5660300002)(83380400001)(71200400001)(64756008)(53546011)(316002)(110136005)(8936002)(36756003)(8676002)(31686004)(66476007)(66556008)(66446008)(478600001)(31696002)(966005)(26005)(76116006)(6486002)(122000001)(4326008)(91956017)(66946007)(186003)(38100700002)(86362001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEQyb2xLcUhEQllaNXd2ZERkbDdVSmhJbVdZME1kaWNQaUZHYWxQcFJQcWNi?=
 =?utf-8?B?dlZqWEgwM2VPRHdWODNDYWZhRkJYd0puZ0k4U2Uxbjc3TlVFVDI1OWVWWlVM?=
 =?utf-8?B?d1BsNTZSNGJyLzlaTDJQNlJnOFFuZTRhdGxuSWtoZldTMW5xenM5d3lpaVVX?=
 =?utf-8?B?L002cXM0VzFydTFaU1Fjc0g5ak5oOG05MnhwakZOdVF6ZWFtNzBJbXRxRVJB?=
 =?utf-8?B?Mjh1cklrUU9EVXhDbFhIK2tHUHB3YUR3R3pRS3R1MndRaU1aa0VFT3AzS0Fq?=
 =?utf-8?B?M0g3bkZxWVFoaG5pTFRsczRVWHJqWFZrQXowNUpEbDgxQXlGUnpXS1E3OFZm?=
 =?utf-8?B?WmQzU3A5My9aMGJhMEJ5Q1ZkWFdsMXhiWUNyMzNIV2o5NUM0WUw1aFY1ZWN5?=
 =?utf-8?B?S3hXazJ2Vysva3NCM3VXVmRrYXhxZTNyc25ST0JOVGp3ei9laVN1eFNGcDdJ?=
 =?utf-8?B?ZFEwU2NnMnIweTBXdEdQQ2lGdGxtZUI1QWMwL0wrcnkvLzhDVFY3YjZ1VFFo?=
 =?utf-8?B?Qlh2azM3cklXNnZKNEk1UXRzWGVwTXFLVi9vQVVRbXZicjRBTk50Vk5pRWVY?=
 =?utf-8?B?ZnlMYkgvaW1SczZqaHIvdUZpck9FRU9zVGtPY1hMZENTdGJRS1ZzOUthc1JZ?=
 =?utf-8?B?V2p0WjF1QWIwT1BLT2pmdlFERXIxeGhvdXNFTktHWVFjNzExSXQzcmw3ZnRm?=
 =?utf-8?B?YmRoNXplbEt1ZHhjekoyMkhKTUVBSVNQaTBnVXczN25waXdYT0N5bFllREtv?=
 =?utf-8?B?ZkZseTg4K3k5MWZXUnoyUGJQYjVDRHVDNW9sUjBTTUN1N1gzTm53UGorbHh1?=
 =?utf-8?B?eHZEOUFqVVZEdHhKTWQ2ZkFWZkhlR2ROS0JnQlJFVTZOU0kreUFPQy9SQlpL?=
 =?utf-8?B?RDU0aGFYL0VVeFV3azFFOXF3UjNkeVAxQmkzRk1mUXc0T01PL3lYMGxVb0Rl?=
 =?utf-8?B?SkNzWjdmVEtzOHhLTHFYekFqV21XVVlCVHdQWDVEUVd3OUVRcnYyNkVsdEda?=
 =?utf-8?B?MlJTdE9QTE9QUFM1RHQ3UGJNanRDS1RyZ2IrUEdrRlFJWjNZL3l0clFxSzU1?=
 =?utf-8?B?RVN5QWJTeWZXZlB2TXpwWktlTmlPTHdRU2lreFUrRmxPeVlqUlBNdll3RmVi?=
 =?utf-8?B?TVJyamh6K0hMYkJDY3BVbkowdUtBbkVkdjJ4WGw3WjJBM1M3MStVT1RqWXNV?=
 =?utf-8?B?cHlVNlpjbHRlQnFjVUgvaStTSWd1T2xFREFJT2pQc3d5RTZLSVdhM1ZYYmVM?=
 =?utf-8?B?ZElZRVphTjV4enNmTDNtdzNXRFNTMTNoNW5WNStuWXNBWVZDSFYrUnRRL1Rs?=
 =?utf-8?B?RUQzbitlU1ZwVjdIQ08xUTVxdHNkVzFpc3VuY3hZZ0pPbmJNT1hFSDVRdVVX?=
 =?utf-8?B?Y2h0Zk55NUJwYWZ6dlkzeVl3OHpab3JxNnZheUh2RGpCYWhIWXlkZm1USm9G?=
 =?utf-8?B?ejlQMlJoaFFta1h4TFRpekxiT3F3LzZPYkltUG1BYWZMY1RETmtHZTZOQTk4?=
 =?utf-8?B?Nmx3NnRBajkzVTlwL2VFc2sxdndXVU9uaG1kakg4aGRDZitWL0t5ZWlzNkRo?=
 =?utf-8?B?QXNnS0grWmNyanhEU3JKNzg2STg2OGJMQXVEQmRJSWYvMVFzK1ZFbVhITFAy?=
 =?utf-8?B?UUNmak1FRUU5M0ZGSHFyaGx5K0Z5ZEdmRGNvZjZmWjhtU1ZtWUFxL0VBNUdU?=
 =?utf-8?B?bVRTd1NETDNyZTBLckNSK2hlS1E4TXhDOU5hRmRIUFAyQWRpZmIzN0FYNCtp?=
 =?utf-8?Q?J80WrEHvkblisOS5dacV+QDFTscSQgveMiggroL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <145D0CA58DEB7D4A84105D86988D606F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0941a1ed-e52a-40d5-de02-08d942c13cb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 10:06:36.2985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Ham/52+KPlGojXrnel2nXFCeIFhof1Xx6PIghnmmXHWzzPp/tY4WNXW+DlTZosC4SnGtDaQKzkSaWwpZfmNUFJR09AE7XtSilkIJV98bi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1696
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIvMDcvMjAyMSAwMjo0MywgQmluIE1lbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPg0KPiBGcm9tOiBCaW4gTWVuZyA8YmluLm1lbmdAd2luZHJpdmVy
LmNvbT4NCj4NCj4gVS1Cb290IGV4cGVjdHMgdGhpcyBhbGlhcyB0byBiZSBpbiBwbGFjZSBpbiBv
cmRlciB0byBmaXggdXAgdGhlIG1hYw0KPiBhZGRyZXNzIG9mIHRoZSBldGhlcm5ldCBub2RlLg0K
Pg0KPiBOb3RlIG9uIHRoZSBJY2ljbGUgS2l0IGJvYXJkLCBjdXJyZW50bHkgb25seSBlbWFjMSBp
cyBlbmFibGVkIHNvIGl0DQo+IGJlY29tZXMgdGhlICdldGhlcm5ldDAnLg0KPg0KPiBTaWduZWQt
b2ZmLWJ5OiBCaW4gTWVuZyA8YmluLm1lbmdAd2luZHJpdmVyLmNvbT4NCj4gLS0tDQo+DQo+ICAg
YXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbWljcm9jaGlwLW1wZnMuZHRzaSB8IDQgKysr
Kw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBh
L2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21pY3JvY2hpcC1tcGZzLmR0c2kgYi9hcmNo
L3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9taWNyb2NoaXAtbXBmcy5kdHNpDQo+IGluZGV4IGE5
YzU1ODM2NmQ2MS4uMTZjYzY1NzMxMDdiIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L2Jvb3Qv
ZHRzL21pY3JvY2hpcC9taWNyb2NoaXAtbXBmcy5kdHNpDQo+ICsrKyBiL2FyY2gvcmlzY3YvYm9v
dC9kdHMvbWljcm9jaGlwL21pY3JvY2hpcC1tcGZzLmR0c2kNCj4gQEAgLTksNiArOSwxMCBAQCAv
IHsNCj4gICAgICAgICAgbW9kZWwgPSAiTWljcm9jaGlwIE1QRlMgSWNpY2xlIEtpdCI7DQo+ICAg
ICAgICAgIGNvbXBhdGlibGUgPSAibWljcm9jaGlwLG1wZnMtaWNpY2xlLWtpdCI7DQo+DQo+ICsg
ICAgICAgYWxpYXNlcyB7DQo+ICsgICAgICAgICAgICAgICBldGhlcm5ldDAgPSAmZW1hYzE7DQo+
ICsgICAgICAgfTsNCj4gKw0KPiAgICAgICAgICBjaG9zZW4gew0KPiAgICAgICAgICB9Ow0KDQpT
dXJlLg0KUmV2aWV3ZWQtYnk6IGNvbm9yIGRvb2xleTxjb25vci5kb29sZXlAbWljcm9jaGlwLmNv
bT4NCg0KPiAtLQ0KPiAyLjI1LjENCj4NCj4NCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18NCj4gbGludXgtcmlzY3YgbWFpbGluZyBsaXN0DQo+IGxpbnV4
LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1yaXNjdg0KDQoNCg==
