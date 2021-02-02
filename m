Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34EE30BBC3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 11:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhBBKH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 05:07:26 -0500
Received: from esa13.fujitsucc.c3s2.iphmx.com ([68.232.156.96]:15423 "EHLO
        esa13.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230264AbhBBKG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 05:06:27 -0500
X-Greylist: delayed 457 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Feb 2021 05:06:26 EST
IronPort-SDR: 6JJEAPSiT/9151WnnZnKMqlS+B3SBnS7lAEft2GxL50AsRS68kbVTfBftuPiMdiklvjGWWUdyZ
 6NB2gDRd+GMZqelZIZyDmo+A7bBu1e6BtF7uqPUWY1V6KiaynktMSUn+9efqXVafL6SIY72k0n
 D7Sb7J+oyjhZ4uqumz86Hh5OSimZqvymYoC3JybR/ujAzCFaM4XmPWarX6VZzR3c2Ug5ce8dX6
 4UwEnVukW28Rof/eKqXMnTUBhyH+Rl+Brm3f4HTqnVAkMQJB2BwLdoQu3yLmggio1gbuQq33Q4
 0Ck=
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="25216537"
X-IronPort-AV: E=Sophos;i="5.79,394,1602514800"; 
   d="scan'208";a="25216537"
Received: from mail-ty1jpn01lp2057.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.57])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 18:56:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkWeiQNAFwgz3QDINXtTMAFpiLKzSBDT7bJPQx0jFRg+rl4IcJjO74EH+a84EogTja9LhIxR3zKj5nQIukORm82CuixohF6KbDSXF6sslC5pCNG3otcERB6BcFexveQV8T20S8jY3vCRcrFfkA4yY01vgaBd03EXT5PesuR4bvg9jFXibo7uI4c8fsuQJ8NBiCilo6Fvh0uuXJ19IexFwrepMr6bEJASeVXnBK3Y/kXMUWkvX0xjvXj4fHLidNxs6bC9PJ7vzQ5yeH0xpwzC73PgbmdmH9qxpWfFU5BdxUiF03YvfGs2Zo9DzIhXPvOxGDvpA0I7mQLd2JE461uPZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAcn7ggJtXzRiwQYLSxDujJ4v/3zF3ROn4/VXGAxRss=;
 b=Ha62iRWDoXse+hTbJE50wPwKwgb8lY+jbLzoMr2YoTrZ/uuaK2XckY4Uwp/xmrE8Q/Qi8+pSDsItOJCPIHOw7vBORR08De6v58tXH34GCj65KrlklTaZJUvJOU7/uoe+E5SZYB/qwZUdZy3jWvfaLfm+RzHN09GdwBFnX17DaAzQlYl0u2E1uM4n15UCtrjEwCKec387Rw5Cje79OQI/Rc2rjeq4sgW8hg9pemAyXkrt+hijfvtcnHqTm0onQOJ0BO+ttsMmOdCGa9MgzzD0XVQI3Jrh13Gg5HLN//Edxw1bANwZX0UZ8HJhQmAUMJ1qaMrVr6qv5Y3Ewk8ykDKI3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAcn7ggJtXzRiwQYLSxDujJ4v/3zF3ROn4/VXGAxRss=;
 b=S3Simx8+JMkcusRGtjfFkoIiPFtNRZoj4kGap/bJwlYz82FR6hE8trL9DrQGuh9f39r36FOWQHIMoUQzTX+ZxsQjoPG3ZCknptwkS0IMz478baD90ruS83B50kG8R5jKKm3GXneG3A5D+OdRfvxY14nux/6cTWGCy4U9vyIiaaM=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OS0PR01MB5554.jpnprd01.prod.outlook.com (2603:1096:604:a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Tue, 2 Feb
 2021 09:56:18 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd%7]) with mapi id 15.20.3805.028; Tue, 2 Feb 2021
 09:56:18 +0000
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
Subject: RE: [PATCH v4 3/4] perf tools: Fix lexical definition of event name
Thread-Topic: [PATCH v4 3/4] perf tools: Fix lexical definition of event name
Thread-Index: AQHW+Iwa56rHnKzsoEqcHYuMoJlUcqpDXXQAgAFEHnA=
Date:   Tue, 2 Feb 2021 09:56:18 +0000
Message-ID: <OSBPR01MB4600CF896542C021AACFD574F7B59@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20210201111310.3231469-1-nakamura.shun@jp.fujitsu.com>
 <20210201111310.3231469-4-nakamura.shun@jp.fujitsu.com>
 <b25fe15e-f27b-fdb1-41ce-9728ce78d52b@huawei.com>
In-Reply-To: <b25fe15e-f27b-fdb1-41ce-9728ce78d52b@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckermailid: 8658df32ac824585b3b5ae12d8e52c09
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da6528ca-7a39-4497-4c13-08d8c760c9ce
x-ms-traffictypediagnostic: OS0PR01MB5554:
x-microsoft-antispam-prvs: <OS0PR01MB55549743DC2F38FED9A6529BF7B59@OS0PR01MB5554.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pev4+OxOwVmpqnBnV2h9yy5jETIxpabdNgOQ1P9A1VDRlvQkBMf1z0sNjPS1sJMvcpVvjfiwPChyCyTBbLfmJ8FLDTA2tePyQGqA6rg0ZLL4QXO6ut2Mtgyh60Ly/iKL66jEfb4fjmJWkUUY5eSoNYiXwL/4MUBC/v25+MoulCWVehlPybGq5ZE0mDu1AJ/RCPK47IYmvx5uoKfLeNDsvmaRhzZY7gz5xIuIqdaVzV8fnwQXdTZT6z/j6B3UdXAhP67tXYXLdr4l2hXNJ69w8vgkW4L/oRIFZFiKVyX648Z8bryRSdI6lVp4CPnSp3kk6DUZYfXI7OcJ28naj9yKlZ23wi1lUJmDmW+ZCCNS7YfNzcy377eDOY92Alr1mUmo2gf54xXQ0o4xL3B/NI73g2lyw/aE7hAJPbbkdUG2GVCMd6z7EJpFBb2xkrwtEWFh+vx957BUdjNYFvFl4CfUHE8WpmM7FG4koQW02SFX8iavNgiVZmxF9JKUOzpohDpiVPhgpNXeeSZHT/FPGhU1XkNOXGCSFxBZ4KTobbQdIrNcnliHfF3WkPgcc9Wx6pW3+wyMch1/Pk05UNihRb/8rg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(4326008)(7416002)(5660300002)(478600001)(2906002)(186003)(52536014)(85182001)(55016002)(6506007)(921005)(66446008)(83380400001)(66476007)(66946007)(26005)(64756008)(7696005)(66556008)(76116006)(71200400001)(8936002)(9686003)(316002)(33656002)(86362001)(110136005)(558084003)(54906003)(8676002)(777600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dXVNbUpZYVMraVFzSDhPL0l2VWV1M1lRZTZhK0lzNVJrNEk2ajdFRWpRUnB3?=
 =?utf-8?B?SURNK0w2SE9reTk3c1RRbWJGNUM3QXRqcnE2TjVYVjlxdGhiTWlJZVBham12?=
 =?utf-8?B?ODMrWDlwTTBkdmk5eWE4N1gwVkdwQ05ydVVWQ2x5bHNla21JK0VQTnM5MmJC?=
 =?utf-8?B?c1lTdWY0TG5ZYjl1OStDRmFYNDRCZXJLUU94cU1JLzU2aUF1SnU3U0JoTVFR?=
 =?utf-8?B?allmanovN2NvQkdtTy9paUZQZ0FudUs1cjFGR0xXdXZEL0hlUk15V3dsVmtJ?=
 =?utf-8?B?RldrRGVISGMrQ1ZZU3BKQWRqN0VQYkJSSVZJQUFHSlFYWFkzaUlrQUp6eGVO?=
 =?utf-8?B?U1ZEWjJlK0NPeWpacnJaTmMwVW9oRVVTQnN0eHl6SENLVEpWVFJvMCs1ZDVo?=
 =?utf-8?B?WExFekdPTjFqWG54RElHeGp1MjNOUEozNmoyTG5tek1kUVRENzFsR0tQWWUw?=
 =?utf-8?B?TzRacWRvYzhBUG9hS3kwUTNWdmxWVUpBUmdaYzFUVFlPSHVvaGNZcWxKeWlX?=
 =?utf-8?B?ODdEMWdLRzNlSit5eDFlZUE1VlVjMmxkYSt6U1YxMElibk13Tjd1ZytTNmhV?=
 =?utf-8?B?dE5lRStjL1B1dTdyRnp2UHVyRjVvbTJyNmJ5Q20yM3o5SXhxeGg4VU9kSk94?=
 =?utf-8?B?bkcxcVhLbXJCWWNUZUY1dmZGZ0pXcjJ5K05lbnFibktSK3c1QVZRNXhMMFI4?=
 =?utf-8?B?c1ZpMytDc0VIZjc4ZHhMNnpFOUREM3N2ajR2a3RaaG1OSU8zZnJWMkxNSXB3?=
 =?utf-8?B?alJjSzNjeVIyVExKbkZYNTNOcWk4dmJRUkYyS0k5MkZ1S000TWtFK2hsNVRP?=
 =?utf-8?B?ZXdkamZDNEZ6L3RBNHpPMVpZcGZ2bjVFZm5ZS2NoTnMxQWJtWGhKbkgwZlBu?=
 =?utf-8?B?NlBCbVUvUDZZbU16b3hDRFRTUkxGZmVvZXgzNjQrZ0hQQTlKZWpQVFhIcGp2?=
 =?utf-8?B?SC8wZ3k2OUl4ZWczTWZvV1pZUnpCbkh0SHl3bWh3M2tBcmdiSVN2RDNjS3FJ?=
 =?utf-8?B?VjFOUVRDQi9DYmZ4UTBuaSttVnVXcDgyL0Q5Z01kMXZhZk1UNkgwaDhWZGg3?=
 =?utf-8?B?K0NUTGhrWnJoZFVTK3dhNTlCeXJwSjN2QlBIV0ZTeStKb1ViL3REUTdDOC9U?=
 =?utf-8?B?VDhaVVE3MHNJNWMxVkNOL3pIYXJmMTNjbWlUclVtTUc5T1VBb1lDeS9Yc0NZ?=
 =?utf-8?B?ditoeUJEcklYdTUwNnlab1E4Zmc3M0lteWxad3pXaGJDN1NzbmtkdmxxK3U1?=
 =?utf-8?B?OXNRcGpuUXA1ZGx6T1FEc1E1UEVXQ2dzSFltTnNpdG8zUjNGcHVxaFdobnJr?=
 =?utf-8?B?VSsvSkpSZUhwKzhCbEVSRldaZXo1S3ZXdGYwM2s5WGJJVXlVN0kyeVVwMVlI?=
 =?utf-8?B?ZXZVTndkVXhobEM5MmVkay9VSTNUdTk1Y0pZVXhMSC9KRy9QcjlKSThCQlkx?=
 =?utf-8?Q?VwKOSu93?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da6528ca-7a39-4497-4c13-08d8c760c9ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 09:56:18.8383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L6rhn8ZTEJjG56zvEptpjta3dkiJ2LVJyDvzf8UMvTw2hPqNNbehUczzOl6xtXZILrlKGPpdZepfa+WXRR5vriBsz8CcpgmoYRvloTBhvv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5554
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEpvaG4NCg0KSSBoYXZlIGFwcGxpZWQgdGhpcyBwYXRjaCBhbmQgY29uZmlybWVkIHRoYXQg
dGhlIGV2ZW50IGNhbiBiZSBzcGVjaWZpZWQgY29ycmVjdGx5Lg0KRXZlbnQgbmFtZXMgYXJlIGRl
ZmluZWQgaW4gdGhlIEE2NEZYIHNwZWNpZmljYXRpb24uDQpJIHdhbnQgdG8gZGVhbCB3aXRoIGl0
IGF0IHRoYXQgdGltZSBpZiB0aGVyZSBpcyBhIHByb2JsZW0uDQoNClNvIEkgd291bGQgbGlrZSB0
byByZXNlbmQgdGhlIHY1IHBhdGNoIGFuZCB3YWl0IGZvciBhZHZpY2UgZnJvbSBvdGhlcnMuDQoN
CkJlc3QgUmVnYXJkcw0KU2h1bnN1a2UNCg0K
