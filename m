Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1093F9C34
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 18:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245532AbhH0QN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 12:13:27 -0400
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]:27779
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245514AbhH0QNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:13:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwI74fgS21cKEo9w690AshX38GtlDlSXnFTRyEvsGdprd9J+X21is5XtNgZ8Ijys3sLXs/CEafv+Dt+Dj0AUFkZ9ryC7Ubyz9FcwaPoIWAfAk9/et7CpBWNGto9/loxAM9BZaCaN3QAPxOBZJ6m68FMVuG4oxQf/5Muw3rc48k6H9Sg3LKPXnGuhcOfMbk556x2UznA0UFjZZyBoVA871w58ouYnxwsjR+fh2Szr2b1vBgRhycFtjhaTtxyUUk/H6kdBBZgkW93psAbRsuI+hUy3vy1fSca/TSqVtrUQFbby5G0uqD/fKKxagyGbxJ/NRqTdhvih1n3vWX9ZShvC4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPHjgjB97KQxjQBmj1mnUL8ZZgO2AjlVi43hMqEOc+8=;
 b=WPhubscK6h38osjB9lZYjs87rVyAg8mvXUfA7dfwbDF1M1P9YX7gi6xOqfoKTyrxsxq9mk6c/6nfLAXlLUsaYyi2m/wCiVTrt0Q42YphWROeonLW7SSwFGfevjXtUUic6n906W1UoTKF28na/9Qsl5oBm2RKEPbR4l6EVeS4kK9kAOaxRK/GWv470Mnv5GYD6n554JtjYZkDzv8bg2l4rPjLFmIFGevpul3FOzw8Q2+aV0Gp7QSqRajy5j/6ufvbbSawDjuPI+y1+7bu3qt7uYpoa1in0Xjkoy509pg91CUP5+mcP3RiVel9RVYpglg6NYWGBE3S6wkIxJ9IVFwN+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPHjgjB97KQxjQBmj1mnUL8ZZgO2AjlVi43hMqEOc+8=;
 b=PIzTjSPHpjAlc7KPdXfqLPFOjR38mdRmDTNZ0PgCHIQszCJcRZ01WF3T5IoYkOq7D1Fe1kM0Xoa7AhUGQckJElr7wRBZQ9ey76Nr6PjdNXFznQc5yh2Nijtl7uWDdQ1HUk37tn3T3PG3rgylr3y0Qj6napE+kuef0t25HUUBXWM=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VE1PR04MB6512.eurprd04.prod.outlook.com (2603:10a6:803:120::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Fri, 27 Aug
 2021 16:12:28 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::109:1995:3e6b:5bd0]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::109:1995:3e6b:5bd0%2]) with mapi id 15.20.4436.027; Fri, 27 Aug 2021
 16:12:28 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Mark Brown <broonie@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>, Biwen Li <biwen.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] regmap: teach regmap to use raw spinlocks if
 requested in the config
Thread-Topic: [PATCH 1/2] regmap: teach regmap to use raw spinlocks if
 requested in the config
Thread-Index: AQHXmfLp4ns/CR9SwkOJBzcXz4/yJ6uGaLyAgAEgBoA=
Date:   Fri, 27 Aug 2021 16:12:28 +0000
Message-ID: <20210827161227.4pnaglgctikobpf6@skbuf>
References: <20210825205041.927788-1-vladimir.oltean@nxp.com>
 <20210825205041.927788-2-vladimir.oltean@nxp.com> <875yvr3j5c.ffs@tglx>
In-Reply-To: <875yvr3j5c.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 279d4c55-b0d8-4db0-0353-08d96975773f
x-ms-traffictypediagnostic: VE1PR04MB6512:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB65121A02DA94FB43A8048F33E0C89@VE1PR04MB6512.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K7YZfwUrpL7VFPlrwr+6ra8PZYgFihl9sPsHxmrjvMEU5qf+xjZ/lC0vbelxYqroMDI4BOzWNrvaPf7/M8cPMLHatSwtFucaVTTZGXrZAM2mL1hhwJ3dwFi43II8MClPph0Isb1kntjklfxwONZTO9dzRDWgubTEe+6PRJ2BRrNrU1CwwU/HebD8B/SyKN24/S088XCCDYDbN1sVHdNVCxFUrJAk9Cg2N3Ho9x8FZMj5Aj6iSXg4QMk4flteLS27ekOdvX4VaOeTNtyOIC5H4DPzAUym1xj9ZQO57h/qOT7ejmewXMw1E14G8nDrN8z68MZql41y9KvYeGFDSafzNKS0DtNkXDEVj/KmScaYTA924su1MmuOMMiINAvH8x0pqYX82bdWya+fbGTGuydZm4NR37rNBBLcqj0emO0BRUhL5HXQw46e/5adItBjRMqhMz9s2tOpec6x/Q8lCnHly9I2MHOb/SMg6SkCSTf6ZQ3WeRFsuLN3u9SiIAySIuK/v7euzFDw1eqLjCrCiAm42Gy8lrbAohD6tO35GqOVIc6tO2xJvRT+ZAFWYCMQBXd/y0jR/O6kWR+yAmDgSJrqlOzoTvsb2NamEeFxY5BPnE1nD+AiVGbQTz4W+42E+Lul57vKte+xZaaQulsw9tcQA5f8QYYHjuWM4rdWlFX744C/lNustUsKEcSSzGoAdHF5ffnaYRJ5gWw4k418kDyRow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(66556008)(66446008)(64756008)(66476007)(66946007)(122000001)(4326008)(6916009)(6506007)(44832011)(9686003)(86362001)(6512007)(38100700002)(33716001)(316002)(8676002)(8936002)(5660300002)(26005)(478600001)(1076003)(76116006)(71200400001)(186003)(2906002)(83380400001)(38070700005)(6486002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nio5ypZHCGu1ngg0olDZrcobYec1nvAUEPyJ0uHsaCS4gTxRnB65sY7lqgDY?=
 =?us-ascii?Q?KHETz/eImOLhnlJqGJEDFqC63NlRo+YrWh9929tOv6/9O5E0R4LCDv2W7ItS?=
 =?us-ascii?Q?vsBKpaXdYqNV6wFUIPYOCiwkwVk+DwgayU0InjUIaWNHLJxXujbofr4EzOJM?=
 =?us-ascii?Q?+0sYmXjHgrsJQVOkyYFONAPJuZD5fBtLQaoCFSV6IV5xMxcvBGWlaCJNwDnk?=
 =?us-ascii?Q?WAdY264zi15Z0lXy2lPwMLvuN2O91G4u0IlB5CfphLlMlS2kKoQe0rzB9bQO?=
 =?us-ascii?Q?7kZu4uDP6LEE2J2wWGrGFQDMcRb1fIpr17lKRSIwHXFMMWlg5bSb9pga2gh6?=
 =?us-ascii?Q?9l8Ktyt7kG89VDgmgH6Fd9yaC2aF9bpqAADV3OL/504jDNVi064flbs5ngNv?=
 =?us-ascii?Q?8ME3q4zl9GOv5zbDLSFTkr2EQI15GqXJmBmyfz7uXtTOj9FHRpfQ2zQP9K++?=
 =?us-ascii?Q?x5pOwDli2VaOJvbe2DHHqK5uoHqz8Sm+lxiPTfP2HIFtTm358lbt+lZNyEUD?=
 =?us-ascii?Q?mucpY7azk4Y7Kunlcn5SK0F24NDduu6aPfkCTxXTC2OFMDFh0iliuoKq/4pG?=
 =?us-ascii?Q?00L3kBa78liitqiWOLXOfWIM+7cCr+HYJCd2vIUPqEOg5QlPyc4qY1shK62v?=
 =?us-ascii?Q?8+IRuKmYbGXWMH8Bi4pDpl6d+YKCJwm7H7BRnFqtWg7MDQJzsuJaKFxuASVi?=
 =?us-ascii?Q?lCFNXoZuzBAYDV9Ynxnr0KyG0iPcWm/UUF2MmR7budwxFQ0hpRHkFf5iHUQg?=
 =?us-ascii?Q?TcPdzevd7N1eVmWiosEu+a6bAZHC4j8Gs8a6WSeTJOEpKTCQEY69NHNz9Iyu?=
 =?us-ascii?Q?RjLYHc92zux4gJ2Cza2n4ilXr26oDM8iD4HkwydQ4MUXh0U+GxcKeHOmgsn0?=
 =?us-ascii?Q?ZFN89No3RvGPJsna+7gvCA9XJwJlDu0TrbsEMLMkLWOdalwkMiDQRdHuZKbH?=
 =?us-ascii?Q?wJ0XGFqe9RLOWyYPyKuaMRsiANhM5VBCjj/GwyzkSRG5Q5LM9bWNzryP2mVU?=
 =?us-ascii?Q?jC4VPjA8BToVCJeAUxBNIJKpTQSBB/41YukmvoNjif8VptKnr4qDOF4pZHA6?=
 =?us-ascii?Q?pvaJd0OwY3W/4+OyiYjJ9j4c+LWSBnpQ2D2RsbzeTlkhra2k+FIWiMC5XPm0?=
 =?us-ascii?Q?HY1vaP+cX7ehDynSyAv7iNasu+eM/sBi/cIn/FIQPXyZwY1U1LEZ1ifJkM73?=
 =?us-ascii?Q?fiMZSelOm9ycHRog1UefQcz3FJJlpt4n93PFZo501QoNZGjiLh8m9pPbhsh5?=
 =?us-ascii?Q?Nsnk1v5mBZzNFl6PllzOZ7cFlQvXjLE8XHewq/FlJAa0BSJk6UN0KZLsn/yb?=
 =?us-ascii?Q?eS8Txgu4vExZKLoBoTe0PZOK?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <41320510ACF9E04C9E2AE7CBCE43A353@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 279d4c55-b0d8-4db0-0353-08d96975773f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 16:12:28.1025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TpRdVcnwg64P6bVXMdtPYeeE0mxV2CTtpAXhjjEMxyU0xHLAe4qsWTAiSZdIcertQNaaKv1DGM+AyW1RoEc//g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6512
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 01:01:35AM +0200, Thomas Gleixner wrote:
> On Wed, Aug 25 2021 at 23:50, Vladimir Oltean wrote:
> > It seems reasonable for regmap to have an option use a raw spinlock too=
,
> > so add that in the config such that drivers can request it.
>
> What's reasonable about that?
>
> What exactly prevents the regmap locking to use a raw spinlock
> unconditionally?
>
> Even for the case where the regmap is not dealing with irq chips it does
> not make any sense to protect low level operations on shared register
> with a regular spinlock. I might be missing something though...

Mark, any comments?

Generally it is said that misusing raw spinlocks has detrimential
performance upon the real-time aspects of the system, and I don't really
have a good feeling for what constitutes misuse vs what is truly justified
(in fact I did start the thread with "apologies for my novice level of
understanding").

On the other hand, while it does seem a bit too much overhead for
sequences of MMIO reads/writes to be able to be preempted, it doesn't
sound like it would break something either, so...

But I will say that I've tested that and it would solve both my problems
(the stack trace with ls-extirq and the fact that I would like to avoid
reworking the ls-extirq driver too much), as well as problems I never
knew I had: it turns out, armada_37xx_irq_set_type() uses regmap too
(and a sleepable spin lock too - irq_lock). The latter would still have
to be manually patched out.=
