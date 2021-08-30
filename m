Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FC93FB41C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbhH3KuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:50:08 -0400
Received: from mail-eopbgr130048.outbound.protection.outlook.com ([40.107.13.48]:46532
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236412AbhH3KuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:50:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZI+JOwpZobkjeBSkDWwlLor11i0HwC/KXl/MwhzX3iJiELks+PeGQuXrcHQeRol/HVzLQFVoxCwmy2s6HdoKPrmOQF2GAmHaLE4sYTt52QDlBAyW2285naLUhtgdq9K5RASu+xoQ/c7sNXgU6AElGJi97mozuWjn9Sase9DtkdM2Za14ZPKVaOLr5MQUtI1IlTtgIP+xMNrY3J+hnDy5agbCOuET48psVEAtV1oWHgbhiGNa7lRBzZnwlQrBC6k6+Wp634HFOuSDBP8ddKg2ULWa5V25SeN2l44asPZJANmuOfjLfK02UafVUPwyzvJIFqLU+JHp0n9gW7qo8LApDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HU2kJIFLjcLrWUoKACcaMKI72u6c3qyGUn1SAdaQMm0=;
 b=Sbpqw5om5EH1sRLUU9nO/3wB5aZiyjzYFk8HCkOhFVQauVGUDXym34kdLtzST76yD5crLZffDCvXWNRapzd+eT/vE42WYeOTK9ebAAxVpieFtxPWPKpT6jrYYSCXi8RfxR5VEoH0mAQSL71BxXnfg/b6n9avp9ODMwJoggK4YnaS7T1t+RnG3twcuhL8tml4YW8ZWtDjxDf2TZLIulRoRXTEejLwVlMFxDCMpt5SP7NEBX61pcqk0ViEHzOOfxSCWxuzNQLFqAsgrcmIuDl6CljmKFafNG3K8zWT7BFCOfuEyVi1eQMqsCnJ4XeXhrL+sM40g6mavKv5oxvhDyJlpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HU2kJIFLjcLrWUoKACcaMKI72u6c3qyGUn1SAdaQMm0=;
 b=fTzvScVrZT9dy/BRPC1ao56F2ipc6h20Ynwp+/djyFE6L25oA5pOl+ZVDlRNng1HnbdmqkmHCHdyukjcGQqMdYY4ATpmnkljTWpE9bukj0qnMvv04omj+N2ZfSE0LuLMRsoJ4Eaa3F0iJ5DnNlFtXEesyjTrzUYPmkgxOAxz1X0=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VE1PR04MB6512.eurprd04.prod.outlook.com (2603:10a6:803:120::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Mon, 30 Aug
 2021 10:49:10 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::109:1995:3e6b:5bd0]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::109:1995:3e6b:5bd0%2]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 10:49:10 +0000
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
Thread-Index: AQHXmfLp4ns/CR9SwkOJBzcXz4/yJ6uGaLyAgAEgBoCAAD+PAIAEHRuA
Date:   Mon, 30 Aug 2021 10:49:10 +0000
Message-ID: <20210830104909.aknshexcge6s7z27@skbuf>
References: <20210825205041.927788-1-vladimir.oltean@nxp.com>
 <20210825205041.927788-2-vladimir.oltean@nxp.com> <875yvr3j5c.ffs@tglx>
 <20210827161227.4pnaglgctikobpf6@skbuf> <87pmty1ww3.ffs@tglx>
In-Reply-To: <87pmty1ww3.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8df65605-6c9c-4371-62a0-08d96ba3ccbd
x-ms-traffictypediagnostic: VE1PR04MB6512:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB65126743B0E2A9CA933CA47DE0CB9@VE1PR04MB6512.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OFSHTIXgqourpcSVIAdxN6KaYjZrGuXWX0gyBVrhQjkiuDnAvJ/+RZmKaxmfKYAQUesLFnXnmJI7PyTWfl//GxkAKtEBu4J9Sym40eKz+vktyHMwD3LzUCP3W70QZNjz5z82T1bHhP1NRY9CjsX89gbHFBDp+JizIRyAw8odA5tIyhwuT9SE1Ote90WyYs6RFtJ8oanmL0ZQ4S3ZWmqlbKJburyzUIqEtPRny7O1fpoIgLIQSvHoBQqR0RZ+73ScCxflvFeT/+zAVwBFdwC8InlYgUbn1ke3Cw45wmjc33gafRbHmoEYGvyfJfI0zG1AsVM70AADtgFxJv4A9YXdz3uSiGqihsrAOFo7FWWCdmIooJNKeInwe5N5hFxn3LYT23DOoyS+lppqmWcGUqmbCet5fwyNvvhfiHnNMzgZWhjwxVN8vUhJGxWQxLcphRcXrtJBdwz0Tz8zG9tU03JtaBgWVaxxRaJNinjB+xiwiGw0VTYkok9U0jVv4/flsOftlC4jewKg2FK9Dy8x8IpijQNTOEsozILpLjs94KdxaxvwiaXduwENIlKCnPKT/+MArx3UoliYfgh8vPyJ5707mQfr8MoIShn4So+2INbhIDgOyVP5sEmOOxBDRqXPsSyVdc2RLVD6b1GBTMDBEKY1zo4vbQe9A6sCXGa5jkCoBwvfTMkPzbkDDwX9/gdxCgfqoDO6sLevBMUy944E70tBeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(136003)(366004)(396003)(39860400002)(376002)(38070700005)(6512007)(9686003)(83380400001)(66946007)(64756008)(91956017)(66446008)(71200400001)(66556008)(54906003)(2906002)(6486002)(4326008)(26005)(86362001)(33716001)(44832011)(478600001)(316002)(1076003)(66476007)(6916009)(38100700002)(122000001)(8676002)(76116006)(186003)(6506007)(5660300002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?feP4sgZWhoOxsI5B2vFucU/Jal96vt2RCjxtaIkaZ/k3rUwCdCowrL1afwP/?=
 =?us-ascii?Q?XdyqBA8IemiB9A8mvevhuSaVGtUz3yT10W9YVWEgCUF7859BNjhYF+3qOUSN?=
 =?us-ascii?Q?TxB0bHM/1T3FToOoyUGBMQE07vCyJKxOV6rTJL+/zlb8YDDPPbvvR+1tOP3h?=
 =?us-ascii?Q?cE9Qd0/nnwpN4sIlDvxMvGJ2yswabWOe3CczCnOQS7HGHUkU4758DRdqXU6K?=
 =?us-ascii?Q?03JnWsjW81BJy147ZxrVSRuopEvrUiSZWfbwC7EQC+cfDtMWKiVQaKkr4Dc4?=
 =?us-ascii?Q?dQL2mehV2LPk9HlaeafCwv7ukA49dDRses+383h/9VoUmZGFoo44vxrVVnSb?=
 =?us-ascii?Q?skGOoOhjqlJm2PTnm82zTz9I5ey/UmNPs4EDdVmFKBcxXPNmX6xVGDuwvwi4?=
 =?us-ascii?Q?53dxrlxDO0sGPYHWSTNMaj97xn6EDBq7DGY6U0WQh4DfOW2vVEleFyBZ2Aha?=
 =?us-ascii?Q?KpvaGeqqJS3OlX1GiqKq63dUsyOcMtbQiGp3Vhh26MLFHOUX1I3cRtbMgcom?=
 =?us-ascii?Q?urHRckd9gdiflhCUIgG+//IVE+0xkMmgpATXvIkoEBOO045+mCXHcxIrQ/dv?=
 =?us-ascii?Q?wocgkp69jPp8n4Rmg8IXbsKTXDlsvrchr8LITVVvsPPCkMkupSsMXTEYKbKI?=
 =?us-ascii?Q?H++9taDqB6dbrqvrQglQNhy/lk4uMnfiwgvn0VXLMygvN3BFhxQnUQT+ew3f?=
 =?us-ascii?Q?GaPcnzmdbN2IA43tz7ACTlxN2EGMtRjBOmPdUhtYPBF0fc9QwizDR654P42r?=
 =?us-ascii?Q?ffSpfq/0TNTeqRSh0ZbsSvW3cePUtp2W+EwqtAsfNwNrYXKOhz8MGZaPBOD8?=
 =?us-ascii?Q?ikR6Cs41eBPU4HL3AJY58jHthAKDRMhWY/C/eR/Ej1hx7d2uAr9ZEPQO7GS+?=
 =?us-ascii?Q?E63qs2YIvcMDcgb6PmmMFFXmECJOZb4MhMcEvUAekapSTcRPXnB/JFxMyEbK?=
 =?us-ascii?Q?8khR6crY8lPNVA9vNcd2xMJQvrHw9HbiyOI39z5aWRkAOpodS9Zv7S5d8IuI?=
 =?us-ascii?Q?tXMn6/3AF/eyuA+SPxLD1sfLRmQm+7hU26+Hbn/kGeog1RMZNHQlt/RPE53/?=
 =?us-ascii?Q?LUUVI1xZRiiwPme3eFYr3krveuF70C7VvgDTaj/nDVtMawnhs5GLI2u04eda?=
 =?us-ascii?Q?7TAUoIU6d1WjXGBW8qI//+k0jsGoBonqATw8b5sRxq2WgzHfflZcmM/CFrG6?=
 =?us-ascii?Q?L6xqKc7Q1xRbZtoFZC58VILNk5/CDMD9oNLN1TMGD6o6kfHBabCxWctuNhZx?=
 =?us-ascii?Q?0uaT5tQZd/QP+weclzXaANMudlMGItkc/XhMTlGD3OiMFYMMgCV3cm7JQzzP?=
 =?us-ascii?Q?jzNkiBW7IQayh+nHQwk2HSxe?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7FF900E22BCA0541A4EF51910A929884@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df65605-6c9c-4371-62a0-08d96ba3ccbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 10:49:10.7361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7sFP423K0/pJe1Y51hngDQ7BLrtqdk4VJSyXG9HNQJYmWHdH0XPDQxXLxG+xtZc3Lr04pHzzZ6V7GuoLhHX0nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6512
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 09:59:56PM +0200, Thomas Gleixner wrote:
> On Fri, Aug 27 2021 at 16:12, Vladimir Oltean wrote:
> > On Fri, Aug 27, 2021 at 01:01:35AM +0200, Thomas Gleixner wrote:
> >> Even for the case where the regmap is not dealing with irq chips it do=
es
> >> not make any sense to protect low level operations on shared register
> >> with a regular spinlock. I might be missing something though...
> >
> > Mark, any comments?
> >
> > Generally it is said that misusing raw spinlocks has detrimential
> > performance upon the real-time aspects of the system, and I don't reall=
y
> > have a good feeling for what constitutes misuse vs what is truly justif=
ied
> > (in fact I did start the thread with "apologies for my novice level of
> > understanding").
> >
> > On the other hand, while it does seem a bit too much overhead for
> > sequences of MMIO reads/writes to be able to be preempted, it doesn't
> > sound like it would break something either, so...
>
> The question is how long those sequences are.
>
> If it's just a pair or so then the raw spinlock protection has
> definitely a smaller worst case than the sleeping spinlock in the
> contended case.
>
> OTOH, if regmap operations consist of several dozens of MMIO accesses,
> then the preempt disabled region might be quite long.
>
> I'm not familiar enough with regmaps to make a judgement here.

I think "how long are the read/write regmap sequences" is outside of
regmap's control, but rather a matter of usage. This would point towards
the current solution, where users select whether to use raw spinlocks or
not, being the preferable one.=
