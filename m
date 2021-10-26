Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146AD43AC37
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 08:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbhJZGVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 02:21:42 -0400
Received: from mail-eopbgr1400098.outbound.protection.outlook.com ([40.107.140.98]:12384
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233057AbhJZGVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 02:21:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NADruFMB1CB0IG6bX0jRZjWePsUu76UCSbCr0woU23aRCjXHjCeZeHF0ChwXiia5jLm3iJCsHN5o+DiC504RE23UiNz8gIDKdfBk+0K6u0vds9WrhkbDVGyLZH2OTZDzsWekqpNRGgeFIOyRkZ/Suzu6Vwhf/v1zlXkb8Z7y4+UQ2awf00ub3vDeF/USGAzojuHqBQgNRt+HuPaeuezirrLND50nnnZZT/jatXENLMWnRvpM90AMrz+/zkG+aHLHw8t2xwKhNp9Q3DADPPxNgqFwDXnwABBwG9tU8iK31CXboi4Nnauku9i5Aa4KRFiJw7LnLnxwKmBdc4zCtLm6Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRrLq1Je6AGq8qesvcmNlnr2/i8eRijVnDGTAuTI/ZY=;
 b=epzw2mMtpbnqLJwqDf8IODb4Xj7kpNLikvnUzsbf/vj245LHhS07LkzMeWd4DkBY3XDIJvuiiWIgML12ATE81X1hr0clHpndIrqVnUV6Iy5fvFD9Gwfi8PRvKDU1Rt+mEzgtihxbzkdgP2Jm6ZzTpM62mQSe9PuFyV571+IlSeuCDlxoLsjn0LknDYiPb2QFVVVneWFwoWCxHwaIC+D/5i2WOBZRj+eHNXaCVELA83eCZ7TVXuJcYCUETuMNLUB8jIhPdoFSJe2yB+L/AkvWezuP9IOHCsehyvcZNTcRefydkwnFABgufAiU7d6NV7yGSG+tpKiI3U59C4XanWlNyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRrLq1Je6AGq8qesvcmNlnr2/i8eRijVnDGTAuTI/ZY=;
 b=xGepfSt7vfvSnkvLEdaEdFVjv/54QBHTaumkJBp9gHIuFpqfPw/6DGWHLPb8wGhGn0xG/6BHDZ7g45fh5cWBUWlyUiN6FY18XMIstmF38ZA/7gXJcLUDjPzze8t/EVlmvcSajMrdKyOwZLUPOIH8p5MSloaHtoDQpLovfXWwjLM=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYYP286MB1376.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:dc::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Tue, 26 Oct 2021 06:19:15 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 06:19:15 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: drivers/char: suspected null-pointer dereference problem in
 handle_control_message
Thread-Topic: drivers/char: suspected null-pointer dereference problem in
 handle_control_message
Thread-Index: AdfKMVj5VkiFjZ1BTj2eYvsZgM9Y2g==
Date:   Tue, 26 Oct 2021 06:19:15 +0000
Message-ID: <TYCP286MB1188D6426E281A0947B3E51C8A849@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61edf487-214b-4dcd-04fc-08d998488949
x-ms-traffictypediagnostic: TYYP286MB1376:
x-microsoft-antispam-prvs: <TYYP286MB137636E5F25F69A5E7FA78708A849@TYYP286MB1376.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jrcuw4P/nOmPgOqp5Vi3GLEH+7NeREV7YupPd4ziQxmTneUpXexBrfuWe7Mv/WMXlrhopmVZa4peGbUxzPQ+Zrfow3wH8ewZlfFirVw1AhWXun+W1nTbFrWMz2x9cldsp+8ysYjWS0YA8ouQva3/hhdJqyJ2kDd1uwJrsal9gSDJf8hELzeb2SGaVSINMjJy8pCXa4nVzS6uhuD8dz72NipGKTm4bUQnFBgI0sXooWaLW4j2dSHaiggg2bkEfmEAFry5DC0gyOlgQkQ4hmRJ8fg4F+XRxVdqxry5oNH4zHWDR4Y3+RwhzsRNlKytL+xmVe7VotygueZdNXrqQ3YHj2C7Bw0PH4FiLP1ZV4rwkJWAu9KH0uQRs7jq2GqpLZ1DDs8E0NH1Q2o2Dofv9PBUqcl4sMd86F9hcuC5TqTNuGL7eJ7jGcMXJvyz1nOv0j0z4mprMlmTv6JHiZDJePnQ3l18CPHuRnW33tySoUDR+ShW9maww4nvTRAMyP712HBatjvO8IvBrTB1MkngGsWfirLQJLDYP79CKlh65TvV1vLS9GsBgdlkdn9isWhJhvKC1XOv702xFFej0eBiTNA9RX3tRnf6sQzhPl/4qNuLn3pPMyeNws2eMUZTrdA6NXVvofkRElV8rAcKPrVkjU4vH0xsl9qlZ8A6J3dMvV0v7lLhbnAmZFCIf3AP3Q2cYKhWBxlzcyPC8eOUx6svMl/7CNO/Hmkw6iynN7QaHQvYwUFVailxcQOZtHjrRkdJx8h5uV8HwW78h7qkgFHz5gnGcsFiJQvPIax+sUCwVwYhCZ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(66446008)(64756008)(38100700002)(33656002)(76116006)(71200400001)(66556008)(66476007)(52536014)(86362001)(966005)(26005)(83380400001)(8936002)(55016002)(5660300002)(6506007)(2906002)(122000001)(786003)(508600001)(186003)(38070700005)(6916009)(8676002)(66946007)(4744005)(7696005)(316002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kjRwFKjAeF8meQnvJNPlQmmmqeL4EgbqKaGYsCAiDcWazXSGleCFqBTzzp/O?=
 =?us-ascii?Q?FXFJkmXjY9spJFqBOZ+0prAoyBkWZyNsakdKOAncZBnPFJH2vqGmrvexaY5G?=
 =?us-ascii?Q?6MTu5aWlIVyW8hfS+3Uby/fZuLgzUj38+VFr2JU/F/NKcpmCG7hCwTsHlUfE?=
 =?us-ascii?Q?Y+0L2OjCLy9UdXjW24vhDnEm41PUO1uhBCvWG0yt1bCXr5IQjIQT7QYZDJ2B?=
 =?us-ascii?Q?I67Sy9XcudCdRoNaF9xBzs5L3GTervwJkcn2sM04AS7dzJYHg/orsQbq8SMC?=
 =?us-ascii?Q?4G16j/OJ3g9UBKe1EMEQrLmqNJGwuHklLVGOa1VIRseoAwxKr46EyddP6p0E?=
 =?us-ascii?Q?Je6TDD0ccRiR/S1KcKeG9dLSVowk3CZXN9vsDrFItYWt1z3wuR7YyB92mCSy?=
 =?us-ascii?Q?21hwyNNFBI7u9w/jz3Ij+Uvq3Lqc1Rd5/0iCV7jdgREmDpBNPyt58aKQaxbz?=
 =?us-ascii?Q?gvggF23yUwLB0zxI0AsRoQoNzHiM7O3Qoroh+IPn3QywwuhPL3rucHd15J6B?=
 =?us-ascii?Q?dGbjBkpo9P07c3Dp/BQKjOHSzhf60AD0Ooy3YOsO8L/CCAGgLxJfhhePtDgz?=
 =?us-ascii?Q?YveX07BKtFtQk4TLRsPwjN5hD7VVbJoowL6vg99afJE2UHaL7bq2EG5435TA?=
 =?us-ascii?Q?DK3oFZadzaScYw9PAfMHMj8vM83XqGcLRMNvWbYSqez5ROgbobt9AQSv/mTs?=
 =?us-ascii?Q?fwtQkdpINEJUDQaf5aVEAePeYc4o4iLnvoUlt/9SVpFrNrYkrgaEPXPmmjtL?=
 =?us-ascii?Q?3R1Z1t1ZffA7EKcCs63U1IqAMCdsd4ccw7+0W5jhdGk7F0zQeOQWkTOtnswY?=
 =?us-ascii?Q?avGOPSDSRiHP5XjIT+mesyoZ/5HOi3pEZALAWqg3PgnZk3AH04OnQoY3sFVr?=
 =?us-ascii?Q?2YffodikfsswTq0SdXHUvLvIk2I5NI18ryCRK/EA1mrKG0DIh7E5T4cWb6DI?=
 =?us-ascii?Q?/jJQL9oX/PwH91eYBCMEyXj9BcZRi7BpecWl/nYdZlqJdwhm//533M9YHBQ8?=
 =?us-ascii?Q?/w7m11z2/CK7xj7RWYqgiwCpZ1x3o3aaAt/T+2eIYT446+zLVC3r/8NhNNjk?=
 =?us-ascii?Q?JF/w1UK3p6HnQgUvwL1znK0AnhXkTv0OMylutEX2AFYB4Ak5QfpnM7Tp54NF?=
 =?us-ascii?Q?ImOgXTh0kr8NDM0TmZus8xAZDRFVmwJ8a7SU89JPWZLgJACInIFnWnqrLzzj?=
 =?us-ascii?Q?55sFgVs4aBuVi4JizdknSCymw5YcdpOWmzI+cFb/cdoBu7whHeeho38XXpkz?=
 =?us-ascii?Q?yvrwZOZ4clpGxnNmqJTAPGbs1ycaqi45rnFOLAx3LKi6tfKNFvTIHp6Qaq8i?=
 =?us-ascii?Q?TGQnBewHoiZjBEToibQLU81xPx4GM7pmLUPjNwn4D9pgWUl/V2U9y2AEoRu/?=
 =?us-ascii?Q?QGaH79lB4FrQCXxxP6N3eeEOmyk1K0scXLPQsKA/xaZ0SlA/sAO5H8QVa83N?=
 =?us-ascii?Q?NiHxCoGm4zyXMbzCYu1p8UJgCyDz29X+VgVmt/lwKE2GvUeJL0B4JpO7lGhd?=
 =?us-ascii?Q?KS+of0o6XZNFYAhKit9KulaVeso4gLw1XcoPf7+1Q51UlPLwu6D8ugfUNTDR?=
 =?us-ascii?Q?QTLkfGcwlgGpxx8qKTs3+k7OJ00+Jn12K33qVlVLeERNsqbGQo6Qup81vBB9?=
 =?us-ascii?Q?kKC5WsUJi5Dppf/Bc4NxJHM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 61edf487-214b-4dcd-04fc-08d998488949
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 06:19:15.5955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /RavjeYk0Mm7OwVp2YP1wApXCX2zxIUFpfuZrdTaq0vpj6MglubXq6RWcjtV2Vr1a0Tq73QkFsyCn6ONz3yBWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1376
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

https://github.com/torvalds/linux/blob/master/drivers/bus/hisi_lpc.c#L483

Our experimental static analysis tool detects a null-ptr-reference problem.=
 It could be false positive, we report this to you just in case.

Null check is missing for the return pointer of ACPI_COMPANION at line 483 =
and line 504. It seems that there could be potential null-ptr-dereference p=
roblem at line 488 and line 509. Could you spare some time to have a look a=
t it?

Thanks so much,
Chengfeng

