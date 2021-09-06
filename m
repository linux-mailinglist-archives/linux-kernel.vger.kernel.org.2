Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B57D401656
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 08:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbhIFGUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 02:20:20 -0400
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101]:5049 "EHLO
        esa14.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239474AbhIFGUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 02:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1630909156; x=1662445156;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0urNThEh47TkunWe2oWsdOogZ9Rvmb+yGq+s3vBKec8=;
  b=clnuRno7xbYPmUXEnp+Sv+aAQ6WyYXqaiahIPnwpN27LkTJjN/s0tlqv
   LFJcztfXOV/iRDHjGBw1AL4iuaSZXxY8QwQ62HUgFbTpfcR1xB0816rZQ
   0g2FoxgL0NIoB9WVoPfvMqFq9xfsMNzI1oJ8brFriGHOB8qCHVtl521RG
   9vgX3cwNV75LMcqliPcwWCgi89lR5fcnpCumWT5b7NyHY8pWq2TcrPuBa
   KP8EdI3Oq4OIteKOlmJyMNA//7irCjSH9goU2yeTjFQ19GyLgp7dGp5uB
   iFLCmNx+r/dzbnpV5D5XmjhA6MeQpzeGj6inO/kjp23tOEV5cWwtbqQuJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10098"; a="38492157"
X-IronPort-AV: E=Sophos;i="5.85,271,1624287600"; 
   d="scan'208";a="38492157"
Received: from mail-pu1apc01lp2059.outbound.protection.outlook.com (HELO APC01-PU1-obe.outbound.protection.outlook.com) ([104.47.126.59])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 15:19:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyoP8hvnGCZEJ4r+lg9Kx5Cygv133Co67DItto50aA9bk/umt7bFqSMFDY5yzk97P7Wbrr+VfbUNF11/kh3DG7qomNc1ZX7e0pm4wnjVvHVWQEuOBL6p4sGEej6+UZfJwX/OtgAhKrmWpF1b3ElBMR8iRf3M31GDs4NuP9xS6GKzV4Jl1B8p2BtGnVNdW9nE6GUfxrhYxDTwb0040j4zlhIzUwyWBaQ2DnjE/n1vzd+qzm/X6No9OKo1p4+Wk63IOR8G0icdbxO1JWIVPJL/wELRlkS1IMKNip9RNbvRNrUJz9X8fC1dRv8b82MXB4BCyqL+1TaV2Ttqkwl4hi/2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0urNThEh47TkunWe2oWsdOogZ9Rvmb+yGq+s3vBKec8=;
 b=ezXPeFD111HlBo/O9QUV14xGEnw/AcnWwhm3qoVX6YPJhW4jY8b8PeGO7De3DlBUXG77rr/cFZYQzahCgg8p/WM9NWv3nMjI8WuDy8InVI9X2SPgYKZT2KJdjPIxMmtl3aCq4DP7G9oOeqsG+MEegcATHgenvQH9HEWcDi9FhDWj5sLSYMC+u/qszzT6McW1Aq9ncbbYBk+m9oMNe0WhlGZCaNZ4S/RM6ORPFQNXKY/lYxDuks3EGz279sMVXsId7VA9+dGe5MQdkehRb/NkJbNuhB/WOpqwWhbxatIE4l24DG2r5aMOwCB3tWvImlXYM06mswy5OS5n1CguhDf2DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0urNThEh47TkunWe2oWsdOogZ9Rvmb+yGq+s3vBKec8=;
 b=hh71Q4Yo/rmlHXjZui7QpExn7cUW7McTrvO0nXGP/5Vzf7pa6yD3Njrk7FoT/gdnDytt6OqBSA0z+w3QczQsFnnzFNWoUoTW/7BlLuJ30PHkkSRDYCqYGKoI4QXllGp8Wq8RMj/CpBexBSj4mgD2MrnlJhQpSjxayaGu12Xhu68=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TY2PR01MB2650.jpnprd01.prod.outlook.com (2603:1096:404:79::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.23; Mon, 6 Sep
 2021 06:19:07 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b94b:d5ad:b6ff:956b]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b94b:d5ad:b6ff:956b%4]) with mapi id 15.20.4478.025; Mon, 6 Sep 2021
 06:19:07 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'James Morse' <james.morse@arm.com>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        "'soc@kernel.org'" <soc@kernel.org>,
        "'tony.luck@intel.com'" <tony.luck@intel.com>,
        "'arnd@arndb.de'" <arnd@arndb.de>,
        "'will@kernel.org'" <will@kernel.org>,
        "'catalin.marinas@arm.com'" <catalin.marinas@arm.com>,
        "'olof@lixom.net'" <olof@lixom.net>,
        "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
Subject: RE: About resctrl code rebase
Thread-Topic: About resctrl code rebase
Thread-Index: AQHXn1NwTLwp8TDbHk+k0EwVJVXXBKuWjhqQ
Date:   Mon, 6 Sep 2021 06:19:07 +0000
Message-ID: <TYAPR01MB6330974317488E525DBA4E2E8BD29@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <TYAPR01MB6330CE3CB67CF8F602D44D098BCD9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <97164928-e2d7-fd3f-e063-9174b028ed65@arm.com>
In-Reply-To: <97164928-e2d7-fd3f-e063-9174b028ed65@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9ZTUyNWQ5NjktYzZkYi00OWFhLTgzZjgtOTI5?=
 =?iso-2022-jp?B?YzcyMjcyMTM1O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjEtMDktMDZUMDY6MTM6NThaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30db8375-a919-4e8f-a07e-08d970fe3b9f
x-ms-traffictypediagnostic: TY2PR01MB2650:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB26500A34C8177D5D668238EA8BD29@TY2PR01MB2650.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rHWe5kckb4V/j2dBDdR92L+FVied3abelEfMu0cmPpgMeUf9/Ytq2cKUfZUiq2gOU8YMO4s30/Ir7AoC6wtZaqJsLogHIx9hb+aDqvfS06SGd7xsObdhyjGYomyHCj/XG2vSRboZp+j3OaALvSQhmPCYQknLBG0a0GyF46I58FVLrONxinq9eVv5A5eTTLbM0rvD32XUdxzc2Zy6I098v8QLWJslSJv77MR89GW2Bxv9jztLrD9oBtiJjZCDeyuFuGLkeq1s4YjYHqm0pJvCsn5d7jQo5mth0ZMnrrYZwLu3BeYpTUxix8dBd1/zASXcaLDUHDVCGOfo92UCT4AJJBrpeMDiL1D9JLXjgSHIVkc/ebJvrtDUhVbpYpsZBgDIryU0h0oR6vdb8wdQ8uFKYp8KnOvpRzpGaKLPpoiSrhROx7kv/rJ30wU8WBTP1awAF4IWJzbsTpwqCnCuc7gW9eEX+4MH4exOxNp4UrsjXyg0FrwdoIL0+OTltKzn4a4Uy6GGqyj38Na8cUTNYra0muMzJwzJ8dIPjgYmZNWaaodY5omnO2etiMkK8t6f4ycTJVv7Il4Pkq7vW3n7bE3Dk268kQBvXQwwB8BTURKhq2Ei0LQZxJW6wVzonb5B7A8GmSItoESgJgRbIAVa0bn7nuZzuoLI3OcRUE67LDSQRtR/sQbBeF95p+9hc0TDNLuLYF4Re3QOfqEv8I0tE8cWNpqSFhUoqAxprq2VTEEGrUWmNPXOucp1oitO17Dl9fgxGhkveFb65H+b1f3lgvPUjKRDsOwVj/c2qcYiObVSOdIFIUnw5USdahWSoryKuBGwhbqgtACeRERlYEpjjkXxXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(107886003)(4326008)(38070700005)(38100700002)(478600001)(8936002)(316002)(966005)(8676002)(5660300002)(9686003)(33656002)(54906003)(83380400001)(2906002)(7696005)(55016002)(52536014)(53546011)(3480700007)(6916009)(86362001)(66946007)(6506007)(26005)(71200400001)(186003)(85182001)(66476007)(66556008)(64756008)(66446008)(76116006)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?dm9YY3lkdWw2cGtIak0wQTUvMU5QeUxnYWRSWWpLNlNRN0NJSmliQm5Y?=
 =?iso-2022-jp?B?Q0VXaHRiTXhFbVZoeVlieUYvbC9XY1k1VDY5czBDd0hPVkhDMURYYUdR?=
 =?iso-2022-jp?B?QlJWdXNsd2xTdlpiRk1WMHJycFZpSFVabS9JYWJlT1F3dUFjblB4RHM1?=
 =?iso-2022-jp?B?UkJSbzlwVHhTSk1nNHIyWjlVb2RyOU9aR25DVCtxdW11VlMxVmxnV2V2?=
 =?iso-2022-jp?B?TE9iT3kzYzlHZlcxWXYyMk1lZTRheWNRaXVxckN5VVAydzc1cFBZUU9L?=
 =?iso-2022-jp?B?WXFyTFhaRkszam1CQ1VjUDczZm5HRE1yMzdtc0FGOWZ3TlE0OS9BK2FZ?=
 =?iso-2022-jp?B?dHV6NXB1NTZDK1BOc1lpUHUzV2ZGbjcyaC94MWFuRmZ4ZURvZ1B4bkgv?=
 =?iso-2022-jp?B?UW1iY1NwUnpKZFprL3dwN3lMMTJ2Rm0zbUxLeVRjbVhqeFZJeXllMjR5?=
 =?iso-2022-jp?B?dnFzRy9FSDZrajJSeUdFYVRGVDhPNlVuWXpkSE9sR25nMFVnQmhOSXg3?=
 =?iso-2022-jp?B?Q3FIdzkvc2pZWFIycEdNdURHYy9TdStjOHIzY3ZaOXcwaDZRWDJDMUZ3?=
 =?iso-2022-jp?B?dGsvbEJXK3RhYTlPOVBvdDZJTERIckJXWE5icXRud2UrcW83WWNOSUs2?=
 =?iso-2022-jp?B?ckNiek1zVFp6ZFdpZWFxemFBbUYwZU5Cd1BnUUFoVHJNNXNRREVpV1Bu?=
 =?iso-2022-jp?B?Y1g3bTNUcVZUQW1vZmhKRUtPcTJ3TmJncFhVWGpiWmxqK1VBamxLYlgv?=
 =?iso-2022-jp?B?TnRhK0tvcnBIeXlscnVLejhYOUxzY1Bja0ZQc3JNYXkrUXl4WXdmZDhD?=
 =?iso-2022-jp?B?cEYybkY1NmFGbEFXNFQvbnFLbU9UeHZLUXhqcWZSZ2YwUEdNNUc3U0JE?=
 =?iso-2022-jp?B?R056UEJ2NzVmZUNCYTU3dUxLdjYzRnNFK1ozMllvTHdHUFpsS3R1R05Z?=
 =?iso-2022-jp?B?R0xvT3N5eHhVQUhwR0VCbXhTVjVHbjJWNldVRjlmYW1ZYUdlSXdVck04?=
 =?iso-2022-jp?B?Wnp3WGRLYnRaZzZWYkpsL2s3NVVqZEMxdnQzUDBua0t4MGRidzdBRHZG?=
 =?iso-2022-jp?B?Z00wRnc3aVgyTFA5b3VEMGxKeGRDOEtpL1V2ZlVUby9XOU02Nk1nMWZV?=
 =?iso-2022-jp?B?d3BQcTZaWTh3Y05yQ0h0QTlXL1JHQnlWb2dQRWNIWVQ2czhIa2pteDdw?=
 =?iso-2022-jp?B?N0NFaDhtOWQ0dmVUaXdhZUQxUXBXMnJWNFFoQklFMEp0amtLeE12RlJi?=
 =?iso-2022-jp?B?M09nVWltUE5LeDMxY3hDN1F3bHBXZDdtbjNid0hIVjRrR0QwT0pZSGlJ?=
 =?iso-2022-jp?B?MXNQd2xKRGtFZ3BCMyt0QzVQQ0FLemJvckpzajNsZktVZkoxNWpGaTUx?=
 =?iso-2022-jp?B?TmI3WEdFVGJZelBBNnpkaXBJRHlvWkdPZVBUcjNXbkVmVHhOTExVWnV2?=
 =?iso-2022-jp?B?M3lXU2J5K3BqWnNXN3E2azJwendnZzlpVlpSYkJzajcvejRzRmMvSnpu?=
 =?iso-2022-jp?B?dERxQ2cya09YQXpRdmw4REt0bWgwUVdxSVowOWs2eUNEdDFqcFlNN1dN?=
 =?iso-2022-jp?B?UTU3c1Y5eW9TYVZXQiswUWUweUJwNnc0QWlpZ0hjdHkvVDU4NE5oYjhv?=
 =?iso-2022-jp?B?MythSnhTZThXYVdXNWplMU1aRWI0Tm5kSFQ0NVd5VjhLQzZ6NHdhd3A3?=
 =?iso-2022-jp?B?RDdnVFRzYnVWSUkzQWw1WHBrMm5WQmJ4VkcvTW9vcm5ZS2dMdG1BcHRS?=
 =?iso-2022-jp?B?TzdFL3gvV3E0RkRGZjFMSTZPL2JYMUJ5SUVxWlVqamJXY0t5SWNnZG5M?=
 =?iso-2022-jp?B?K3FvNktrZmxFZDZvVm1YWUFpSVFRb3FNL1RHRVY0U29qTmk1YzRhMXE1?=
 =?iso-2022-jp?B?Z1lVdkZJRVpPbU1udW1SOGdFK1ozZnR2ZmtRVXNoS2t4OHBFTWY5RENE?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30db8375-a919-4e8f-a07e-08d970fe3b9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2021 06:19:07.2762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: McRTxRz7rGswgV5u2l+lc8q7MjTRcw2W43JL6lCatuFLKOKFcOFt63TLTwv0nnL/Dx0apbV5HWDvU3v/SiVMWFkH2Xi7PwuczO0H08BUcpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2650
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, James Morse

Thanks for your reply.

> On 01/09/2021 09:35, tan.shaopeng@fujitsu.com wrote:
> >> As you known, Fujitsu is implementing a feature that add A64FX's
> >> cache control function into resctrl.
>=20
> >> Fujitsu will implement this feature base on your rebased code. I
> >> think the commit of refactoring arch/x86 implementation of resctrl
> >> has been merged into the x86/cache branch.
> >> https://lore.kernel.org/lkml/162871088112.395.12879267279872673224.ti
> >> p-bot2@tip-bot2/
>=20
> I'm afraid this was only a small part of it.
>=20
> I've also posted the next series here:
> https://lore.kernel.org/lkml/20210729223610.29373-1-james.morse@arm.com
> /
>=20
> and there are a couple more after that.

I understand.
=20
> >> I would like to know whether you have rebased these codes that move
> >> the common parts of multiple architectures to somewhere.
> >> And where is the rebase code?
> >> In addition, when will you release the latest MPAM patch?
>=20
> I will keep posting 'the next part' of the x86 changes once the earlier p=
art is
> reviewed.
> (please help!)

I will check these patches.
And I'm going to test these patches on machine with x86.=20

Best regards,
Tan Shaopeng

> I can't push the latest branch until the ACPI spec is published, but I ho=
pe that
> will happen this month.
>=20
>=20
> > I'm afraid that my message may not have reached you.
>=20
> Yes, I'm horribly behind with email!

