Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308A444191E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 10:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhKAJzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 05:55:21 -0400
Received: from mail-eopbgr50123.outbound.protection.outlook.com ([40.107.5.123]:44961
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233890AbhKAJvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 05:51:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXt+nZ2u0IuglEayyCmbXijsUeDj1zQlXe2+yEr6yNghZqTif4y++R1d3uAfb6oe1BAWJarLfXM/kFlDkzDXgDlMhtiLxUP6iTzU6Bi6Siah0UKNhPibPvdlqsfn9Q6/GPGwbz/ZhQhMQgcTpewkGwOn4lZlcgFvzSVr1l20gAxwhvazWES/UJ3d8GNBBA+mliDARjGVapRj+9y2T+rKheK5r75q0Im3f7UWCHkeQ0htDc0L+ACO1xgHQoRkEp4Nd/NL3QjMY9eOMec5tQ6jq4y2U5Y/chq/9vzji6xfQfm3ZUOE162c/dugfNQQiHwnF0aQgoQKNMrZCEBDT9L3IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJWe57C+cC2ydX0EcPyZfym/oxR0jt1JwuMNpStHf/4=;
 b=KleiBuBj+xyUci2SmoI5yXWhSjtZ3PSxOnls2Iql8LZC3pa7flZITerHHG4bCeXuU20YYJqVVYFAUFfWaoGgt+llrzw5vVKE29xt9TmwMFgNLgnKLlh3d0FtPprUnMNttAAnD6QGl4nQVjPmlA30EObWoQ7cxv1duJHU7v5hrkFCFwyHcpycuLaHqvYQmHwDo9Crcqfqh887QIRpXz9pHCuHZa80ivpkFVJ7LGWId0G+oZLiA9YKSkF5QW1+zXy5NLe+2NFx/XwyovlWUXBa/4++zbDyDWnsardx9Qq14km6YbwiVjKOJN2eO8mq1L5aLfV5TAz9YYk1dSDw8uq8xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJWe57C+cC2ydX0EcPyZfym/oxR0jt1JwuMNpStHf/4=;
 b=HlMFjaODZKXoinnNULouvbCanpN23DKOM+ukihDzznXmpqNc8n/uYNJJUXbr/k33vJyEVmVwmhbg8CbvcZYKI2hGtOWo5k9BukkfWAg8qglhYJsUSJxOkCjSWFhS+48iL3w24tetMXoYoqCYi69xnEp77Dn4PoY3o5ZzBXbmaN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from DBAPR05MB7445.eurprd05.prod.outlook.com (2603:10a6:10:1a0::8)
 by DB8PR05MB6092.eurprd05.prod.outlook.com (2603:10a6:10:a7::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.18; Mon, 1 Nov
 2021 09:48:46 +0000
Received: from DBAPR05MB7445.eurprd05.prod.outlook.com
 ([fe80::90ca:ed3d:a3e5:1651]) by DBAPR05MB7445.eurprd05.prod.outlook.com
 ([fe80::90ca:ed3d:a3e5:1651%3]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 09:48:46 +0000
Date:   Mon, 1 Nov 2021 10:48:44 +0100
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        marcel.ziswiler@toradex.com,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: stmpe: Support disabling sub-functions
Message-ID: <20211101094844.GA4549@francesco-nb.int.toradex.com>
References: <20211027082155.206449-1-francesco.dolcini@toradex.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027082155.206449-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR2P264CA0021.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::33) To DBAPR05MB7445.eurprd05.prod.outlook.com
 (2603:10a6:10:1a0::8)
MIME-Version: 1.0
Received: from francesco-nb.toradex.int (93.49.2.63) by MR2P264CA0021.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:1::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17 via Frontend Transport; Mon, 1 Nov 2021 09:48:45 +0000
Received: by francesco-nb.toradex.int (Postfix, from userid 1000)       id 7DC4110A03BE; Mon,  1 Nov 2021 10:48:44 +0100 (CET)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c25e727-326e-4c25-1c62-08d99d1ccc27
X-MS-TrafficTypeDiagnostic: DB8PR05MB6092:
X-Microsoft-Antispam-PRVS: <DB8PR05MB6092317CCA13FED0BE33EA64E28A9@DB8PR05MB6092.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ktKRYdQKoUUcPbDKT3XkCJ1nrjJuK5usPQ43sVXy0xxLzoSlsAc8ARCqrWi1MBUV6GujtNhoV87Us6DaCZAyvtiGdxhJyksn0SL46AwLfQZx2ZC0pwt71Fid7kv/zsE0ImPe21m8Y4Z/9T9MY0D3ceDnCR/jjbo5iepQExUCmC9VybX5xiI3TFy7N2e4wndRaUbJXqAROmTfQ9hi/zLWzMNGXBLJu5v19WPyNlw5WSTn7Kz1nhzV9neh24A+pjipPh1LlTVGxwYMEpok/H2DC4/iX1+lZjT8K9LTmk6kSIf21YPZb8ZfJjK8K5VXJP4nXZhnjLjvoOcDxgqjzf6LW6f6X7JpaSiWbH7hiH3OOuzVrX6b6uRTuHPG1cMxJT3kzmQlB+fn0uijABGaV/BNGVwZbGVbjgoiy0QE68jJa9ANV3mPBb2xcNnpY6niMo8AjuUmlIF8gHzpbiQ0ICbTbvsNwL/sq4v1slSdTkYD7m27VtA8CXD3s9bORlWpjZ0Sl6f+MNtYPpES/1cEkQBI5G1lzXitKpO/HLV45YUTRjaxaVw5LX+llZW5hUzwqTuJQMMRI/XeJZpO2FuCw/H8LUFSiV5obxog1Fvij2E95IM/QVdBNEpJOlkA2Zb7k1LXds4R7WTclgjaRkQ1zLdAmhjcXTzPCaiUetHRGa/G2y+hK9cwzfV52Msnd0gYZoTV5OAqumoxVSATAfQ7UyvQgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR05MB7445.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(5660300002)(1076003)(8676002)(4744005)(8936002)(38350700002)(38100700002)(44832011)(186003)(33656002)(508600001)(66556008)(66476007)(4326008)(66946007)(86362001)(54906003)(42186006)(83380400001)(6916009)(2906002)(6266002)(26005)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wOb2D/zpcpHprnWqkG0aMzFH9qhxOnYnUgMLObda6oWZVHsB0sXfKzgYRSFt?=
 =?us-ascii?Q?9SP4PLO1uyzOjzmd6pzNuxlVW/xeEc2QUDTEvUq/SXoxSeelIcygnA4iqzg6?=
 =?us-ascii?Q?reaOox4eXzVec/UwQ8LPa2OUkNIG79LonEkGqSvHs5e0jOaHu74/nns7Xoul?=
 =?us-ascii?Q?zsyiSwUARDJzDQ6xBrTQP3HUc2v7Js4/UQ3gp5nZU48lIuplXVUlCgVMHgi6?=
 =?us-ascii?Q?F2x7TaNSvl3HRykq+7m23QVlIVPmeH/WUcPnOXxGcikhaWRNU92ZOKJ1j9mH?=
 =?us-ascii?Q?XF/Fsyf0oD8gMTaflNxPldDoXr0323S7PBUyFXmqSSgKihUjfKqJbjYyhOXJ?=
 =?us-ascii?Q?1buBrNdMAn9r388lgno9+ZCHVvKRLcXfOrKoK3EBAz0xpmkdrvvVxPdsKVjw?=
 =?us-ascii?Q?vzCxjPy8+7U3WWtCkCMuzFChK431xvYH9rc1N6mOYk73kC9p5i2UbxzEx32t?=
 =?us-ascii?Q?31HiuSgRd0PKfB+42kTJiVuX+YWC/mm3YQS1YVepjvm8ltRpP2mYoHBfPZn7?=
 =?us-ascii?Q?5s8XH3lDRNUM8AZST5bzvMJR7/7cwLJ0u2DMffAYtGSV2nYzLYTMWg7iUaS5?=
 =?us-ascii?Q?Ic1SuXenQfVSxrqvbwpvLOqYFMUZ9WFXu7hdS/PX5uDLRy/aNiNQafuKtHvt?=
 =?us-ascii?Q?VuYCumjPWNcPSIyvvKfYdy0Tgmqd+e8/5DZD48+v4ZyCBn2ixxoOaC954nAh?=
 =?us-ascii?Q?4r7XGjyIdW2DBC9X4z86OeY5Jv4iI1zAURm8C6nCCdv97X351OfxdcCN6onS?=
 =?us-ascii?Q?YrqwGlt3B20vMaKZmwEOvCeuw0L057TouZP6UJGuUiUUU/UtQYJW7FnBTo8P?=
 =?us-ascii?Q?asOtCVN4fkWN8Ni9cWgBUiF9FKbM56RF01YtIiWVHVmre08AavuuZzDV+Vb1?=
 =?us-ascii?Q?QoSLCayrods5g+p/V+EDF+tLe/uFrww/VMvE/eIGnrBCJ5T+ep9NBbWcCovt?=
 =?us-ascii?Q?Q4ARlQIuMgRnsRN3pkQ63HHHk5mJZz4klUvTLra7d3RuBrelL2mGMJA+yuU6?=
 =?us-ascii?Q?F0AfDA6tQz/YSikA3MDuYZSs/kuD8MuWxeh9+lNlaMK8bkeqnzPq30vBQto2?=
 =?us-ascii?Q?QSC6YF+WKnMslDeSNQlcMvQHQuOGZltpjG29ijT42pBlvL67Ib9ZR/GuDf7x?=
 =?us-ascii?Q?iIUxF57jHKEFTwexUhoeP1SZ1iwOdkMYetYIazj4xeM/rg1JnChWn1haR1L5?=
 =?us-ascii?Q?iSapfacK81T+euhutO7Ko2QVR/+9MUsDP31PfhQbWLrmy5a8vgxdtdaCzXwH?=
 =?us-ascii?Q?MThz/bcU+zI8m4wglYnWzazpTC22gXJyMm9GLAfMw+1skfhdoRYWyO7BW8IG?=
 =?us-ascii?Q?ApuarmZrm6w1JoA0I2IjblU7UdHR7oOxKlDeKpFt6HH4DUHwYd0axpWdUJLm?=
 =?us-ascii?Q?iBfmVAsc+VBzr9A3aTIsJTa//oxrWgE875X0VvfkAH0+mqJD7mdb13gqvFHz?=
 =?us-ascii?Q?N0thwLcEK/nESCIB7xpRwzE4TXf6M8nWheFyxMXM2RnDMmxRr671UwNxlhEl?=
 =?us-ascii?Q?zrhDwkIqLNVAeouVNiSXBgQ0qsgFN8KpWCVKydEG75bLnv1zxG7psmPn2Q08?=
 =?us-ascii?Q?+X7QpvL19Z3yioPzrO0mpHz4jHOoZ0uPsxHvfuxuc89nOqW4VNqN5Khe2KlW?=
 =?us-ascii?Q?8QQcw0uEWFyCbsaMPrdk+ZASOWUD9r8xW4HxNc2KmLzEu+g5IW9oSrmRuYkV?=
 =?us-ascii?Q?KgD59A=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c25e727-326e-4c25-1c62-08d99d1ccc27
X-MS-Exchange-CrossTenant-AuthSource: DBAPR05MB7445.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 09:48:46.0431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBOChEdNj8ta/Kp4UnD6tAUPsDwjOvIoxMVsTwwZIufkaeBNrhC4W3RsMABAAl9mGwdrXyau3QSbFFVQig0q90R3PGrgApwWYI9DmMKOe2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR05MB6092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 10:21:55AM +0200, Francesco Dolcini wrote:
> From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> 
> Add support of sub-functions disabling. It allows one to define
> an stmpe sub-function device in devicetree, but keep it disabled.
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Hello Lee,
any chance you could take this one line patch for this merge window?

Francesco

