Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C443AFB83
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 05:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhFVDtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 23:49:51 -0400
Received: from mail-me3aus01olkn2153.outbound.protection.outlook.com ([40.92.63.153]:40195
        "EHLO AUS01-ME3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229904AbhFVDtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 23:49:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfbOAy/XLsrBJNp7cUrSk496ahO5xH/0GbyfBAgOB5kwU7oGYgRrEPlG2UQze4drC8THS0AzAXuBWEXpvBU8X4VmX9cIUFACndJeGP2C1z3EIl470pVNdYOhMt8J6FoGRzGjc4an7SaiCkSDRH6DtuPKwOC+aFFgm5kK6YD8yNT6STgQDakARebXuoSB4FwyM8mUU9tpBogcvqnU0ccNtidCAKRDEdPmnFtbT9t7E4QTW8KJ487u3C2mwAJHtjnCiOR/4b0XjnnqINYGqFYDxAlrbdhOg8NNcL41zkjl5WCLXOdqWTTYJlzr5GHzB8Vr/w4szLEPhGXmfVT/5l3tww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCHlPxxDRe0kSr9yG8iGUOvT3/TR4qCzs6nFSy/ec9g=;
 b=d8R0dCvcHdrCt/pnmdOfJq9Sc6xK7Ra9b/+KXdwmzkZEd43m3PxUbGqxHXfJ1L/FGwXq9hSx0Q/Frmoj85PseUUOJGrKbGK+xDePng+uzzkgKtG+Mi7yg4xSCjV0SEWdJgCH2wNyEqkBzjdpFMxiU+cH3IFIbJ7qlA4gKNscZYjZPBDb0v1juZsXSY8z5DTQARasroqRhe4dYo0hv4D9D6+82BfNglZmId3VgXA9HNKyJNQ54tpx/quCtCAzF1BzX9nDdAz9OeOeE1LQc7dmEjLGDHw0YQlENnpA8WHGnfx2vXp5gJ8mRu0JzhmU2jVn7N1saaNu9+2X81RcxUeEBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCHlPxxDRe0kSr9yG8iGUOvT3/TR4qCzs6nFSy/ec9g=;
 b=GBVRM7R2WAgCIT4ECOBi23qnYZ6gxm5/a14yKobc4GiuPl0GJTL5wu9DRiyP/wspuiQtNF0AL6S0+M7GjBddVFGukLlZDjFX/cJkJL1fzxQ158QEkQc0AFogBFWE5toOISpeihYc1Hv3ejH6iEApN7gFk50ms9FAh3suFXHtk8PS1URHYbUnAvIT/ClyZ/D8XU4ACEp9708AXrLBGDmiv7O6yqJCOV1kVUsLUv0fLjgAFrZVCatx6bREU1SZ/ejKBUoAhDtev7nsR4I7+M87TM19ob74ObZrlUR/y+QYwIHI8kc9fIkSosx9wU8EO4dxdUuY7bmp9EqlXKN9hB5Ykg==
Received: from ME3P282MB1969.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:a5::8) by
 MEYP282MB1432.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:b4::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.19; Tue, 22 Jun 2021 03:47:31 +0000
Received: from ME3P282MB1969.AUSP282.PROD.OUTLOOK.COM
 ([fe80::3424:8e:7191:6ed2]) by ME3P282MB1969.AUSP282.PROD.OUTLOOK.COM
 ([fe80::3424:8e:7191:6ed2%9]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 03:47:31 +0000
From:   Liu Yu <f78fk@live.com>
To:     c951@outlook.com
Cc:     Mathias Kresin <dev@kresin.me>, Paul Burton <paul.burton@mips.com>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: ralink: Add rt3352 SPI_CS1 pinmux
Date:   Tue, 22 Jun 2021 11:47:15 +0800
Message-ID: <ME3P282MB1969E8CD1E2058D8CA2AC8FCC7099@ME3P282MB1969.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-TMN:  [BYUpBmV+5n73Eu3UVHiIE0O522Q0Z9Fx]
X-ClientProxiedBy: HKAPR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:203:d0::28) To ME3P282MB1969.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:a5::8)
X-Microsoft-Original-Message-ID: <20210622034715.18497-1-f78fk@live.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (123.235.214.42) by HKAPR04CA0018.apcprd04.prod.outlook.com (2603:1096:203:d0::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend Transport; Tue, 22 Jun 2021 03:47:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e21b827-3fca-467d-45ab-08d935307665
X-MS-Exchange-SLBlob-MailProps: sTyj/kSftotZ9l/0hwipXF4mme9ssjIQ7zlN7TrTez2U94lpoxIpA9sh/FhpZq1vcZQUlU4TZeBrXfn6wJr1nfy4fMa8zk5E8Mjl9EQ0eaK0KtXRtmum0M2rDGC7uDhzfbn9cl2xDFQQm2Rt5ExAQj3jhW4ZywJgq74mcUoAPFdALcy4tebegcxDIVdzvbHpVvy4UnBqurL52hX4Cg7mdvE36oXrlmfxRV+Pn+mooeqILQ2vSc0HO9080zN449Vttv0wSeKKz0gC5a1rVODGkCxIKE5yT6Kq2QMIzrBO8aSCHnfde/81Bz0xG+uh0K46DzkDwfBq21B5cVhrtL4vLqav5PNcPQX2hO846ePNDXXr22yxu/APSwJRk8IYTuLVLQRj3IjX/bNwgYkcotw3HfBPnA5KVSLb3PZgwpI0fWe3Qd8WrBcKulQCViHPwsU18ddOOZVMw+bEkVnNJ08W4YbcX2e9c+HHq+KCWwgIMopzGeeROe3Vr2VOb24/Gq7urD2VsfGmUW9jutbzoaph46GNOalXK1CMEtl5QPSHWAN1sbHXQh76VwozQXL9FiioPL1aLcBRApuBr/pYQAYGt3al50DrzBxJXAUHM9dUpTZbhH55NCmYeAyMkuNW2Z+ybdHQFtUsN+nhSl5orMh6vIk9uLuLxsAG0fwNKs8rg2pr6Oh91Z6RwAqtctEHhku35liIc6IpkaAoCpMHSZJUU0hgtslHMOrvc/XEH5edu0L54ZYOtAUon1Atb2PNfSVvvzXBkPSvK5TUQ+XNxuhuGNPOADoESx+8ydOVZ6h8BJfD7Fwg1PekRIWclclZfimMlO5SgylEepM7rnCi+pWaEw==
X-MS-TrafficTypeDiagnostic: MEYP282MB1432:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kNjbb9p2bIxt/mgWjQ2Zrh5Gy9Nk1zs4r/HiuVRdj9WSQhRHqWJM8K7+pIWR2SG0A7aPa/W56tPIoh/AoyIZoyok0hgTpWK8guQF0p5DscfcNHfmMpKKBbmY7U45dsJrAhrVnb0Z+9r5RqR71ICFsNv9pgh3rhWJkireUACQrXakMVxu5xPv/nUEN8FteLrTTWPWnW9QvkE0UzhFXSkROtUtcGwcyVMrXpioG/SjLyr/ztBctDEuWJzvQNYTq3w4BoWdqnEjkUsDu+Z4MJI/2ywSKuUJU2eD5+SBNzbtKArrJs31TQzXtKn1ELku0zHHGzXhikK2IZPtgpjUnRrg/twNLj3Xsi95eohoWnEJqNLzSxA5/AHDzM8U7yLcCAx1WHtS9GEcjlSlNuN1t3P05/dyGPA4hrs6EZ4i6j1yYjkdPCysQMq/aVvx+uj9Ryzqd7x7LXTPXX5MRTgzt3tHsEUa8qKDecFEm7qSxYmdOp4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wCX0bOZzaWy2atwaI3huo+kzK9ekwCCACz+qTEZdEJ9rmjz9TcMTmV2J3CEFlHWI73qzHGAyvOg5uZFAHR+NiU5HdHf4nTBcYsK/DkNRn5gwuzmmn0k/evZVT1iJunrEoaRaZqwwa/e4onG1ktOFZw==
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-8dac2.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e21b827-3fca-467d-45ab-08d935307665
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB1969.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 03:47:31.3235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB1432
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathias Kresin <dev@kresin.me>

The rt3352 has a pin that can be used as second spi chip select,
watchdog reset or GPIO. The pinmux setup was missing the definition of
said pin.

The pin is configured via the same bit on rt5350, so reuse the existing
macro.

Signed-off-by: Mathias Kresin <dev@kresin.me>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20301/
Cc: John Crispin <john@phrozen.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/ralink/rt305x.c | 5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/mips/ralink/rt305x.c
+++ b/arch/mips/ralink/rt305x.c
@@ -49,6 +49,10 @@ static struct rt2880_pmx_func rgmii_func
 static struct rt2880_pmx_func rt3352_lna_func[] = { FUNC("lna", 0, 36, 2) };
 static struct rt2880_pmx_func rt3352_pa_func[] = { FUNC("pa", 0, 38, 2) };
 static struct rt2880_pmx_func rt3352_led_func[] = { FUNC("led", 0, 40, 5) };
+static struct rt2880_pmx_func rt3352_cs1_func[] = {
+	FUNC("spi_cs1", 0, 45, 1),
+	FUNC("wdg_cs1", 1, 45, 1),
+};
 
 static struct rt2880_pmx_group rt3050_pinmux_data[] = {
 	GRP("i2c", i2c_func, 1, RT305X_GPIO_MODE_I2C),
@@ -75,6 +79,7 @@ static struct rt2880_pmx_group rt3352_pi
 	GRP("lna", rt3352_lna_func, 1, RT3352_GPIO_MODE_LNA),
 	GRP("pa", rt3352_pa_func, 1, RT3352_GPIO_MODE_PA),
 	GRP("led", rt3352_led_func, 1, RT5350_GPIO_MODE_PHY_LED),
+	GRP("spi_cs1", rt3352_cs1_func, 2, RT5350_GPIO_MODE_SPI_CS1),
 	{ 0 }
 };
 
