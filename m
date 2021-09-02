Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A5C3FF316
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 20:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346903AbhIBSRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 14:17:52 -0400
Received: from mail-dm6nam10on2051.outbound.protection.outlook.com ([40.107.93.51]:57697
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346712AbhIBSRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 14:17:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acoGzY2b+0x4jg0LaMhkjzIgqL+UR+Lt4S8nZI4OV1woit9mg0GO9437rXMXMjAkHcc0+5DnQawsqblIAnKdl28p2ttPvNcKz0LgqgCXlBmkIUSvHTK7eSQGX/tO+C8dAloVC+E1EquSkmAtxHjhs83FbKWCJ9gBafuHDVVPvVyFGQV8FWUb62fWG4TckYaGSRZZVZmwpFzvOn3AIVU6J1xf0cBsDtrp8pOj73RWw+OuszBfTyWBAL14lb4TXpX900hOj4pPnAREfXmrzU1VRAuaEP822oYfzapeIz/hx9SSJwl/9zB+VGRlziXcKxggZfdrz7wPzMVf8RJxylTcJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Obr+mXwGSF/mdvo+SMlLA7L29RlgEIHWJ2kBNhiefZs=;
 b=DdTRnpLDAr8OjY4apTAE0Hbf7TzmyaErRSfYdlgLmAlCncPe0Ufl4MNmvphHNbH3va76rorDtUyypAuiuTmYvhnvIq0tHi7XK/ahzp+EML99wQAaJLvUL4eNUbB6Lm4qxPzxR8pry5slNvNPesOSz/fDXPEdRiQ/SOkn8cbwKhBWR5gIQvoRZAwhg/73RWMfNATfmfA/WkyRGUhyEagzsTpIZOPDOMLyb7jLMFD5pIYmBMHp9WfXmf3GQZILcALKkk8fapCoeW20spSUIZKvXamN1Kgm809YvQkguuI2FWJk3gNw/qBppb8/9UEdMY8IeRbV/HKxNz2dYAOK0rKsLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Obr+mXwGSF/mdvo+SMlLA7L29RlgEIHWJ2kBNhiefZs=;
 b=d84bi3EyQ1sy1LjD2ozZtjPH30Vp5Qg4vZQYr3F2gGtY2dDCxWrOqoW+VcLlmfWTrihvqwU+kN3c2tokaCa6+s8vBjIkMqllQRn5trCbUivCIk480+nkjzz5vK08athfAMIQMvtRs+az9p1IAyo/LF7VUNo1b8gla/SVP6V8tg8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MWHPR12MB1870.namprd12.prod.outlook.com (2603:10b6:300:10a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Thu, 2 Sep
 2021 18:16:50 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::41ef:d712:79a2:30c1]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::41ef:d712:79a2:30c1%7]) with mapi id 15.20.4478.022; Thu, 2 Sep 2021
 18:16:50 +0000
From:   Babu Moger <babu.moger@amd.com>
To:     jpoimboe@redhat.com
Cc:     bp@alien8.de, bsd@redhat.com, corbet@lwn.net, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, babu.moger@amd.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: [v6 1/1] x86/bugs: Implement mitigation for Predictive Store
Date:   Thu,  2 Sep 2021 13:16:37 -0500
Message-Id: <20210902181637.244879-1-babu.moger@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812234440.tcssf2iqs435bgdo@treble>
References: <20210812234440.tcssf2iqs435bgdo@treble>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
Received: from bmoger-ubuntu.amd.com (165.204.77.1) by SN7P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 18:16:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2b354c6-b66d-4e39-6ea9-08d96e3dd4c9
X-MS-TrafficTypeDiagnostic: MWHPR12MB1870:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1870AA652152A481F90E0FE795CE9@MWHPR12MB1870.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRW2kg9siR4JJY08Y1Pwy9JX9JlOZisOaAI/CUwy3lzpBXIsH+HMX5szZi20sKhI0ifsyfMu2d4WWQ9mx3hPy6go9JTArP6jBv71qD98B/69RF/sJzPCPUGQ4m9RD107HAPzXzR1qs1hfsZmsuuZZF0LY/ekXc4QzTWUUXiFpFH1m3ck4mBM9Wmtv8d1/0KBmkkj2g3G7sJz0KpTmN/E31m/AeFX8fETA270TyRyWRItdRw5Kz4Fto1bDuYQqpVVU/3B7mnxpmGOBfCwB1DZbmkuHenmy0KzP6Mxy3TCaFAjhpPHTYFFXNC+n7ujKswqQoKe+X+6fijFEGsi91Ygf2LJFVF668T+g4nFur/yzXdazIvgE2S23r9Y2Elt5PsNEhDKfP5zk/gFeG74efgWhrGtwtaZAXPwDHcZmJV/IfiVOnfddTALSvEeq7JHuqVVylmjZvnsKTw/zSTJWvFyyLgW/1q/tiBGVJFmHWyDb4bVwK66NF2KC02YFi5GrUmOQ6L7m+Y1hj1A4uarNzNSukkKU1BXJRgvgNavfo8033T8o4x04Ls846pGhZ/KmTeVsUjNvZyXsAWHoc9FBkRR7GW6900Fn3Tbes8bdqvLDQtod0d1bLG2GPLHpWHxZYdvEX9NXmjPzrIwuCrOlHTNkkhzJBYvfcsFA5AXPUMJD9EAvvQoMT3j8o4J9wxHxugpyxkyfDFdXQpazkc6X2bTIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(186003)(38350700002)(26005)(2906002)(6486002)(4326008)(66556008)(316002)(44832011)(1076003)(66946007)(5660300002)(7696005)(66476007)(38100700002)(8936002)(36756003)(83380400001)(956004)(2616005)(6916009)(4744005)(478600001)(86362001)(52116002)(8676002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ICDiAQia7sNQQl8jdLqXU3QWd1aSjQijkZpG/w+amxr1CeMfehGj5ERl1qOC?=
 =?us-ascii?Q?lD9Adq+wvCrN2oYISMAEn0YqDUUymsZYMWoGLTXi8liNj2z+mdsZuNhflIly?=
 =?us-ascii?Q?0DRNuTkkz2DLj/QFrINADPlaRp7uqGhcLwfYqyRCW93qaoBFlPH6IfQro0Ly?=
 =?us-ascii?Q?7nChEviizG6JofUwRCOdlE/yDGz2UqmV9SyhLTwZ12v1vlzB3SE6RoY3ocfB?=
 =?us-ascii?Q?UVIkz+xPjOSQ6aW5N3G4aP8JRZZsvyeQekvm1Znl+VU8A06QjpCD+liVZXHU?=
 =?us-ascii?Q?iFL2rAA7H+JVP3Cwc7czPrNSN7WMhU62V332cDBebJilrBvAW8lVUH+VXjly?=
 =?us-ascii?Q?z8c+lYBzTg5c7EHTU6PIN8fRaMxcA0lgCSmbVtWAz/z+FzC0QOFW1rwPvJ9m?=
 =?us-ascii?Q?uIzyYOSPaB2GmGaJlDyZmk3v3f5rvThGdGJuSM3ikKvVqdLJlferFwyYY81E?=
 =?us-ascii?Q?QycCqJGjLQm7HaVz/5efKsiu1x+cto/E73kocEwiDMX+3Cj6jFcqvnTr3P7T?=
 =?us-ascii?Q?k1Fkijq7hjLbgig2XwC4AtHLLdUfIwnkgELRfmpjISYlFphy/pNtgaIsYutf?=
 =?us-ascii?Q?sVDWogw1pZz4pUGEq0oIljh2Kl6my0yje2N97AyGQtgKn9Uk01Uwf0fT/Hde?=
 =?us-ascii?Q?G/3ZxD9+BQcd0xkMPAyy7gChYvtH/wvTtB6J+wW1odtVks0aVZghD0RWBAVu?=
 =?us-ascii?Q?zgETDv3eZbcBpBrxufeT2an2SDhyREtT8yXjYIQQB1yk/8wOHsPb1HvZlzx/?=
 =?us-ascii?Q?ThzzuHKwEgwC78b/P8+aMZ9Oz+N03NeKr8IdrWJ7ic9ZFB4Ao4LlbrJSlHXL?=
 =?us-ascii?Q?ZEFnNnkutDeg3XyexDOldiyYLpE/g87gR6+2A4g283uvuh0LqzUUysoMMhiS?=
 =?us-ascii?Q?qTstmavk3eGWhuOE6pSPOxcm5XKjPfrZclRX7ah0CBZLNRr+63moGhjHfFST?=
 =?us-ascii?Q?7hrryHSGIxlseSnUUonCAL3PRu7pmjF8jAGJosvW9qoMDneNo9oV/1WwA5jP?=
 =?us-ascii?Q?NcixknpIBRmA+ODl9F79zdf7o2WnRJWSUNh18gKU+MmCIDAINTb7CL/6xDGl?=
 =?us-ascii?Q?X6bCyq6k786q3tQZR1rmRlOlzowaUUxuZ9Wc2QHFXbszatk4AWGpkLLQRWcI?=
 =?us-ascii?Q?QTj/z+gatoNeZjQJ5kIdUqKpkhrQFM9eEU4TNXJ+UyY/y6Z+sx6GkFkLxjl5?=
 =?us-ascii?Q?Qk5kafd71Te+0GzyJpoeYXm33QPxRsF5Vd3uUyDuNzHf85qGmR9yqTSDoxFt?=
 =?us-ascii?Q?inIX5DTDnkcgq2XQ0ZJVOg2TjdTU+bRWWHKc69GiQNmiAqKmkOM9TPevbvMQ?=
 =?us-ascii?Q?pExKNjp7Rter6IlKeP8rdnh9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b354c6-b66d-4e39-6ea9-08d96e3dd4c9
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 18:16:49.9194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1HwKV7ZHFaD4Wc50SZbDmxWM2y6rVfRr/Pe6oex9LZj6cy8x1S/cx1JpbL2I6ii
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1870
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I dont have this thread in my mailbox. Replying via git send-email.

Josh,
   I took care of all your comments except this one below.

>I'd also recommend an "auto" option:
   >
   >	{ "auto",	PREDICTIVE_STORE_FORWARD_CMD_AUTO },    /* Platform decides */

>   which would be the default.  For now it would function the same as
>"off", but would give room for tweaking defaults later.

There is no plan for tweaking this option in the near future. I feel adding 'auto'
option now is probably overkill and confusing.

Thanks
Babu
