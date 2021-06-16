Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065BA3A8EDC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 04:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhFPCgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 22:36:38 -0400
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38]:29675 "EHLO
        esa18.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231233AbhFPCgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 22:36:38 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jun 2021 22:36:37 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1623810874; x=1655346874;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1L4H+eEvliyDKCyn4Ez3NAhlXewpxXLxcgOE2TleV3Y=;
  b=m5g9Tcw1/1y1lFxaK8D3hhv6mvMad6Hb+d2QvwyYLgEAHc+bLQKjuytV
   G/5dS/X8fjx5WZu3vP57CNVUFdhzklNffdGFeHFiFGlmcJoM2MgW9oDVL
   KmWRDSP/RBzL7JqarlFaqxtlwlUnp2SI6DjnNQqcYv390ebjRI83KHaWX
   /RrNOrRRlEQ18s1AdIAH839tK4RqPJHWi7Fu1eddTnDBogSueNg6Rsq4n
   Ms5snl/DniAfhvHDVUfd1Vc8NRcRrEkt2qz/Nq0JAmb2zf7fKHLuILiC0
   LLWeSbc9RVDtfi3KMzE0nCbpL5Y/p/eXDSMkS1tQlaJq4HfbZ1mdjYa0B
   w==;
IronPort-SDR: cR/J0ILqQ7N2+13/fSS42EpvOj1y3yiaZmc3jRO1MScfHyQwfN+woTeSHeWEr7+pGz0WBdY7kQ
 +pk8YbSUYPUDX+LOrtsCV4BkgujYb6zzVWE7LMJyRNnQFTT3L1fbDZ7DqAbNTD/ebiF+dTtbZm
 /MSP18228pUc3E6Kc9+hdHELJHM6iDWm6iYr/3uzzWjpobzJm370w5Y+p0tS0A8ThMP5ckoOd+
 oIlsKLGkSQKXZJ5mELvS2kQQc9zfadnEMcJb+r+Y8QBCm6L93Ghh4E62AX08xv1KN4dYIfi/Uq
 RHo=
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="33686327"
X-IronPort-AV: E=Sophos;i="5.83,276,1616425200"; 
   d="scan'208";a="33686327"
Received: from mail-os2jpn01lp2054.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.54])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 11:27:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4kbckqBBiXGJN7CFb1bvzLiBS8bPuGzL3uy58v4b5X6b11WWawDGp/HgjipLBiKDX6tfdoCE0DcWp7xsTrEEtB++YNchA312sCxdqAJwwPOXwxMThj8tWKJ8HONEhtQ82UWwydUgmahszsuhTktnJTrtRIpZ+GaBEAtbdJAqWEpBZXpCORE/usMvSf9sTvl/SMnELJb4UBa2DxD2AVq0hzIl3srlgly6vtDFwoyifBAqB/HmipngCwl/mb4koX59pneYBomJcDJ6Zn0PngmU54vwNpWh5DpgU0E2EBfyEK3jsa0pJwA2yBNN01UJPa7SxlzPTaTCK/hL7+nDXQJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1L4H+eEvliyDKCyn4Ez3NAhlXewpxXLxcgOE2TleV3Y=;
 b=QB/84mUxg/MXP0erLYRAmQ0Mx0x/65RHCt42cHXTcrqDElER/wsBudQx9/x+mr/igdZmwOSBbE3XwsGFCFKkbZDZLEdm/AhOfGUVf+lFEWZ5Bx60EnKwmJnnWwwHwuf1k+mp0ONeLUMnCpAE7g8NX+xSITn69Z9beyiJQUrhsupY60tm3kbByIjzJELIt/8dCwyVElQd4PVMGRH2b+IfRXc4knVoldPutX3DmdWqXTxlBP+iTDmQx5EULkJb0giWyffDzb+1cOyKPTbk0QQA2RlQ8M6kDu2NXdQCsC00wOVMLxOAyJn3xjWZ+1Gy//WMPcJstrQLBFUpUB3zcHvpcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1L4H+eEvliyDKCyn4Ez3NAhlXewpxXLxcgOE2TleV3Y=;
 b=YhjLTUI9nb+jsXG41n13SdAL6Gm6m+iGZ1G/X+QqPCgjVDfMQJkRZuh/ASwycQs5TUnqegrwa/SP0L/I0iP+PvW0SU1HABhJ4ropd7XAInAiNLipG0TncBa8Pf6xNm1XAfVuPdi66MZ4ehsqNrtSYLGLbvXzaVM0l5DZbjHJrzI=
Received: from OSBPR01MB2183.jpnprd01.prod.outlook.com (2603:1096:603:22::14)
 by OSAPR01MB4866.jpnprd01.prod.outlook.com (2603:1096:604:6e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Wed, 16 Jun
 2021 02:27:18 +0000
Received: from OSBPR01MB2183.jpnprd01.prod.outlook.com
 ([fe80::702e:951e:8f05:5cbf]) by OSBPR01MB2183.jpnprd01.prod.outlook.com
 ([fe80::702e:951e:8f05:5cbf%7]) with mapi id 15.20.4219.025; Wed, 16 Jun 2021
 02:27:18 +0000
From:   "hasegawa-hitomi@fujitsu.com" <hasegawa-hitomi@fujitsu.com>
To:     Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "'fweisbec@gmail.com'" <fweisbec@gmail.com>,
        "'mingo@kernel.org'" <mingo@kernel.org>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'juri.lelli@redhat.com'" <juri.lelli@redhat.com>,
        "'vincent.guittot@linaro.org'" <vincent.guittot@linaro.org>
CC:     "'dietmar.eggemann@arm.com'" <dietmar.eggemann@arm.com>,
        "'rostedt@goodmis.org'" <rostedt@goodmis.org>,
        "'bsegall@google.com'" <bsegall@google.com>,
        "'bristot@redhat.com'" <bristot@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Utime and stime are less when getrusage (RUSAGE_THREAD) is
 executed on a tickless CPU.
Thread-Topic: Utime and stime are less when getrusage (RUSAGE_THREAD) is
 executed on a tickless CPU.
Thread-Index: AddG3PD5Dm9CD2RNQ7+TrQrb7bYc8AE2IspgAAJjxoAAIq+F+AARwywAAAAeGgAAXleiXgAEnWKABQ2pIdU=
Date:   Wed, 16 Jun 2021 02:27:18 +0000
Message-ID: <OSBPR01MB21839A0A9B2464953E1A316DEB0F9@OSBPR01MB2183.jpnprd01.prod.outlook.com>
References: <OSBPR01MB21837C8931D90AE55AF4A955EB529@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <OSBPR01MB2183384B29F6291EB7C0BB81EB2C9@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <YKN5cQpFSdsgBlBU@hirez.programming.kicks-ass.net>
 <OSBPR01MB21835E55331FCAE6F75E8332EB2B9@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <YKTZag/E8AaOtVT0@hirez.programming.kicks-ass.net>
 <YKTaNJ7r/sHnwb5W@hirez.programming.kicks-ass.net>
 <OSBPR01MB218357232513BC4EACD0FB59EB299@OSBPR01MB2183.jpnprd01.prod.outlook.com>,<20210521084147.GG3672@suse.de>
In-Reply-To: <20210521084147.GG3672@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-06-16T02:27:18.149Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfb1b2b5-eeca-472c-e2aa-08d9306e439a
x-ms-traffictypediagnostic: OSAPR01MB4866:
x-microsoft-antispam-prvs: <OSAPR01MB486663C6814CD0E70C282B3AEB0F9@OSAPR01MB4866.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PlNlYY6oPArtPjzdjsBXvNqzyZMjaa8ufCE3JvryHIGmg06FehGm8BM0V0GwKdU6A1RbMI3bvKDlOrhdb+gTf9ANhcY5oG4W6JoD0VYtSULvxZ7qsDrDldTro5W6MFybX+ZFAYzuVM2dXDNnV8GG9UpXx6rFZq/Jmx8jzpv2uiUCmi0N/Qx07qmXpzcb3+h29GWMBTLaoA3YGno8q0TdoJP4steGNfrSdknzuF2nUlP2OHaKBNM7tWVyb1SifMgTEHhHde7/eFweWY49kKckv3WPDN4i/VLTFpr0gSfJCF3Pftguz+JAvb9mVySSibbtw0/Q6QTYbyOTw1FEDQKFx3Ox/7bGTGI7BkDqkYUSJ9CBi2Dlksv2AX+Zco6RHGdPrD/JoRlq4nPQh7Vc21pU0QtX1e99bwAO8rYPaZIzQU1yQYCnFW+WYgBDs3FHTDzD2AufCy+dN2EhMm2sZRcd4uydBQBKl3bnljWLOFBDAb0nYSdw0xk76gB/wGf2M1qbKNtTCIM6711jxstYGem4/we8m37oUyhNZ5BZY9rrm0TWEF8jTn7Ip6m/qkT8xZb0CIXsmlNgk6Vs3RDSsnqpva2COWg1FHQ6xdaDVaq86B5QM+QoG1SmUtHxv8jpakk3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2183.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(66446008)(66476007)(33656002)(9686003)(478600001)(66556008)(4326008)(64756008)(76116006)(186003)(26005)(7416002)(55016002)(83380400001)(6506007)(85182001)(52536014)(5660300002)(8936002)(316002)(122000001)(86362001)(38100700002)(66946007)(110136005)(2906002)(8676002)(7696005)(54906003)(71200400001)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?My9qNUV0ZlJRMU1QdXh6K1VjMHlSa0VmYVVoVkZHdW45Qk1ybEpLR2x3Q25Q?=
 =?utf-8?B?T0doMXQrYm1KaSs5di9nZ2c3NnI1MzlteTZNRkZwM2hBbG92MlN4TG0wUXpM?=
 =?utf-8?B?WTh5OGIzRk95RU9RR0FUREJlYmZYUFRzeHZZbG1Xd0dPM0lLN3JYOEFyYmtM?=
 =?utf-8?B?MnptelhJVlo4ZGo1OFhlWjRuRklEZEVFWkZPYitCTWNGZUZCMThsS1ZDb0ly?=
 =?utf-8?B?MFNYZFFJakowTEx4eWJrSzBEWEs4QWE1SWN3YjhGaG90amg1ZjNJM1BSczRx?=
 =?utf-8?B?MTl4L2lGRmRsbmFZbFRoNXg3VnRiM1hzTzFvOC9IVi9BeFpmTE9QTXNDajBj?=
 =?utf-8?B?NTdQNTl2UGFzM2VOZDlxaGVYeloxZXFqUktreUdjdXYrTG5lcC9IMkFwajYw?=
 =?utf-8?B?cTVxY3ZPdEZuSk5IMHl5dE9FL1V5bjNqbjFJZzZJeERWeExRQmJaUmhhTGwz?=
 =?utf-8?B?dDQyQk5YczVuaEN2N25pUm12U3AyM1dkNngxK1JzNERldnRnOWlEb2g1emd4?=
 =?utf-8?B?Q1BZUmtuTmRnSDJrMTczMHIvMGtqUVRrL0ZVYXZJUGFzbUZGMks5QUFmMFBM?=
 =?utf-8?B?dXFQY3pZU2FPUkU3ZHlXTzVZQ3JjeTQ2cFBXZHZJSitneDV3Z24rU2N2dEwr?=
 =?utf-8?B?Y2Vta1E2ekJROUFIM2VIbTdJTnlSMEVSQmh5UUd0UlllYzE4RjYzUFBaVloy?=
 =?utf-8?B?dDNNdkZxcXJ1QzFLWVhGazZSQ0FuckpPL0V3TitHR2ZjcEZmcmNTbFc5THda?=
 =?utf-8?B?V1EyRDd1d1NHMSt0RFI2RGl6UEh2VzlEd3N0dzN6NzJFMmpYbGw1d0w2bllV?=
 =?utf-8?B?ZWEyTm4yUHZuczJqNWx4T011cEUxaFJCa2QzVnp3azlTUmU2ZHNqankxeWF6?=
 =?utf-8?B?SStqY3M4ck5yNFBOU3p0SlcvQkV0K3V2b25oTUVqVmVuTnlMOVF0bVVVaWJW?=
 =?utf-8?B?RjNabXJKYzM4eXhSWjZPRjdFZzFhYlg3VVYxWnpYaEZCUnFlRzhVbmZ4RERC?=
 =?utf-8?B?SmlGTldBc2J6dXV5SjFoanpHRk1Sc2tiR21zVmpUZzc5dXd1WjRLVlNsYTF6?=
 =?utf-8?B?dCtzRFJoYnBxUVhHK2RyU3gvNndEMzZBS1VsWUptcDc2Zk8vaXhWV0p0cGxG?=
 =?utf-8?B?TFl0R2kyM3cwU1JpR25UOEtDbGRneEZEUG9yVEdQWTExYnBVRHFua0hLWi9D?=
 =?utf-8?B?bnd3T1g4dHEwZkloZHNzNERsOUpFYWJKcUhNa08rbkRYVVhxNWFJb3RkVEhT?=
 =?utf-8?B?WXhyYUo5V2lQUi9rQi9pY21PcUNXR1ZFV1FzaHF2dlRFVFlDWE8yY29pdU44?=
 =?utf-8?B?eit4UFJjcjdYeExocnpGZTJtbmEzbFA5NVc3M3BkdXpMQXhiQUsvMzNkNkhz?=
 =?utf-8?B?K0x2dzkxSVFPNDNZcFpOaG52N0tkVTc1KzNjUE9OczdGenh2VTlOZEZKb1V5?=
 =?utf-8?B?MzlQa1RjN1BadnZmM2prYlhhczFGMzM1Z0NQUG1JZ05zK095a2tDNU1iL1ZF?=
 =?utf-8?B?MThNNWpJQjZobUpROGg4Y2FOV1Y1eTBvb096UThqMStmcXdaUkVNa0hIemtp?=
 =?utf-8?B?blJoZlVaNmpCVlZRS2M2SHAwRDZkUW9iL3lmSUZKNFlwZHc5Z1l4TUNSSTB6?=
 =?utf-8?B?ejNtV1NLY1Q0cWhvcHE5MEZuVDJ4U2tGZmcxTzJwbENUZlpKL2FYLzBneDBG?=
 =?utf-8?B?YVUyMmF1THdEQXNueUIvaHJzZVpmeDZTbW9UN2t2QktiZ2oweXZOUWNuM1dr?=
 =?utf-8?Q?2X8v7eWHvCmR6Xuza0=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2183.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb1b2b5-eeca-472c-e2aa-08d9306e439a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 02:27:18.7616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JZpmX76KadwNOpaccJZ4gPEhRqqUBizb4Gwtqg8W3WMK6QEgLWm0gUi37fBuZpFcgIEuMW2EBhFEKTuDgvn7VvNQB3HFU5jUfzn4n8etpVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4866
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWVsLCBQZXRlciwgYW5kIEZyZWRlcmljCgpJJ20gc29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5
LgoKPiBJIGRvbid0IHRoaW5rIGl0J3MgYSBzdHJhaWdodC1mb3J3YXJkIGlzc3VlLiBJIGtub3cg
d2UndmUgaGFkIHRvIGRlYWwgd2l0aAo+wqBidWdzIGluIHRoZSBwYXN0IHdoZXJlIHRoZSBvdmVy
aGVhZCBvZiBnZXR0aW5nIENQVSB1c2FnZSBzdGF0aXN0aWNzIHdhcwo+wqBoaWdoIGVub3VnaCB0
byBkb21pbmF0ZSB3b3JrbG9hZHMgdGhhdCBoYWQgc2VsZi1tb25pdG9yaW5nIGNhcGFiaWxpdGll
cyB0bwo+wqB0aGUgZXh0ZW50IHRoZSBzZWxmLW1vbml0b3Jpbmcgd2FzIGNvdW50ZXItcHJvZHVj
dGl2ZS4gSXQgd2FzIHBhcnRpY3VsYXJseQo+wqBwcm9ibGVtYXRpYyB3aGVuIHNlbGYtbW9uaXRv
cmluZyB3YXMgYmVpbmcgYWN0aXZhdGVkIHRvIGZpbmQgdGhlIHNvdXJjZQo+wqBvZiBhIHNsb3dk
b3duLiBJIHRlbmQgdG8gYWdyZWUgd2l0aCBQZXRlciBoZXJlIHRoYXQgdGhlIGZpeCBtYXkgYmUg
d29yc2UKPsKgdGhhbiB0aGUgcHJvYmxlbSB1bHRpbWF0ZWx5IHdoZXJlIHdvcmtsb2FkcyBhcmUg
bm90IG5lY2Vzc2FyaWx5IHdpbGxpbmcKPsKgdG8gcGF5IHRoZSBjb3N0IG9mIGFjY3VyYWN5IGFu
ZCBhcyBoZSBwb2ludGVkIG91dCBhbHJlYWR5LCBpdCdzIGV4cGVjdGVkCj7CoG5vaHpfZnVsbCB0
YXNrcyBhcmUgYXZvaWRpbmcgc3lzY2FsbHMgYXMgbXVjaCBhcyBwb3NzaWJsZS4KCkkgdW5kZXJz
dGFuZCB0aGF0IHRoZSB1c2Ugb2Ygc3lzY2FsbCBzaG91bGQgYmUgYXZvaWRlZCBhcyBtdWNoIGFz
IHBvc3NpYmxlLgpIb3dldmVyLCBJIHRoaW5rIGl0IGlzIG5lY2Vzc2FyeSB0byBnZXQgYWNjdXJh
dGUgdXRpbWUgYW5kIHN0aW1lCmZvciBwZXJmb3JtYW5jZSB0dW5pbmcgaW4gbm9oel9mdWxsLgpG
b3IgZXhhbXBsZSwgaG93IGFib3V0IGludHJvZHVjaW5nIGEgbmV3IHByb2NmcyBlbnRyeSBvciBr
ZXJuZWwgY29uZmlndXJhdGlvbgpzbyB0aGF0IHRoZSBSVVNBR0VfVEhSRUFEIHByb2Nlc3MgY2Fu
IHN3aXRjaCB0aGUgZXhlY3V0aW9uIG9mCnRhc2tfc2NoZWRfcnVudGltZSgpPyBUaGF0IHdheSwg
SXQgY2FuIGxlYXZlIGl0IHRvIHRoZSB1c2VyIHRvIGRlY2lkZQp3aGV0aGVyIHRvIHRha2UgcGVy
Zm9ybWFuY2Ugb3IgY29ycmVjdG5lc3MuCgpUaGFua3MuCkhpdG9taSBIYXNlZ2F3YQo=
