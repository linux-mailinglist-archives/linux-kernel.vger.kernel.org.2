Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904F83C986E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 07:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239852AbhGOFbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 01:31:47 -0400
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:37191
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239812AbhGOFbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:31:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goWypVsYRP78qCcu6Dag6ZnFiLFaTBXH+S9+5W/NskTVvGBEcRFUs4ZKP3kj1dRytciWKy9TM4Hr0gOsHpLJuDCdp3cy/XrMYGFwut0bqTmlGZvgvTuF7nWvs4CCnodEGAPGvMrPsVeO4vqZiwY9fc9LvZKppGcCJMw+0xYMcGTcIKMgK8r3MLud2xYH6ooEtihKYq5vRs89PBIdy5UfBqZzlJlPmYWNd13ZGU3nNAiBUvOeMfoqLruLVXyoZCb4IztU3R6nrYgmadBk4g9Xe9TCs+jXr/KZNH57mCsbw71U/jU3VPLsa4Vp5xvuOaymTbXkWh0DnuePV+7AVOxgzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXM1eIA3MA0T63sJa5iDhWrvaDW/AFFdFfy9nDC2P8g=;
 b=ZWWJXZeuqTSzZC/mTNP/EU7mYcomfOPtx25MN80fYykHlCidpIrtbfyiJo1oz1r/MwRPMrQgukDlMeglb/FxnWVf7j2FoW5dXaccaRs11TSSMHpzi7i940Grut17IwJQN2S6j55Go7jjDJl7P4Y7dejkZhCQRABJnxGZ4DlV1KbdRGwxrZZp6ZLgufiodEBxCroiPpxcAMYn0t+Ph1l4B1/SAPR2b+WMGisaIhrfkXbVtEy0K3vi1oEMNhyRfpQPoObrYDcLq4ETWbiOJd5lXgTIgLB64cqlUBotGQ0ZU1YM2dxu8bIrrep+kJxZi7AT+jtCjzrP86FM5NbwkPIy1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXM1eIA3MA0T63sJa5iDhWrvaDW/AFFdFfy9nDC2P8g=;
 b=Yzrju6DYGLHeDIawlNefkhHlETDTFl85agdkdTZnXtaX/Ku8Io0C53UZ5HHnL7lazTbDlb5eQC50ip1ZykzfX2IUTkc8ziC92+oDdD52r6H5cyjCYOl6Zj8gpXEEjthRqoEY/dZ20HP9Z9WX32F4/6FVxhp9guylysywGO0aQtQ=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7051.eurprd04.prod.outlook.com (2603:10a6:10:fd::20)
 by DB3PR0402MB3915.eurprd04.prod.outlook.com (2603:10a6:8:e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 05:28:50 +0000
Received: from DB8PR04MB7051.eurprd04.prod.outlook.com
 ([fe80::bc7d:3cd3:b58d:b44c]) by DB8PR04MB7051.eurprd04.prod.outlook.com
 ([fe80::bc7d:3cd3:b58d:b44c%8]) with mapi id 15.20.4331.022; Thu, 15 Jul 2021
 05:28:50 +0000
Message-ID: <0ae047e216298e6239e39ec40a2d545ac07a7406.camel@nxp.com>
Subject: Re: [RFC PATCH] clk: fractional-divider: Correct max_{m,n} handed
 over to rational_best_approximation()
From:   Liu Ying <victor.liu@nxp.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Date:   Thu, 15 Jul 2021 13:26:48 +0800
In-Reply-To: <YO7AcaHyB8js9FJg@smile.fi.intel.com>
References: <20210714064129.1321277-1-victor.liu@nxp.com>
         <YO6qfQMcvr9szZTJ@smile.fi.intel.com>
         <1f1b38f9c42093bea5e6a8ccb458bdf799069157.camel@nxp.com>
         <YO6+nkzDlNM/KJio@smile.fi.intel.com> <YO7AcaHyB8js9FJg@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0122.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::26) To DB8PR04MB7051.eurprd04.prod.outlook.com
 (2603:10a6:10:fd::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from blueberry (119.31.174.66) by SG2PR01CA0122.apcprd01.prod.exchangelabs.com (2603:1096:4:40::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 05:28:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59615d14-dae4-4a1e-63da-08d947516d8d
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3915:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3915285EE8C85A9008081F5298129@DB3PR0402MB3915.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jt+jPDqLDjy7yaQmwze+h+ZQOqcF5zBLCMp8tljyeGiEfVKPYdNR71kGVrI1dppckmFMSQ2WcGzL22zRiFxdMK+bFjW1uNCT8H4Nx44/ppXI2MmFFNZagNG+qZwZ27VsBllat0gbngLRsQt0tYnQufYEgxrb7cLsTWlopNIpvkQ3RD6QuNsPUkUHt9HP/qO4m9F+x712Nd4cg74cFAqNOtpJ8bLiRudlwsqpuVmH2MBIynORBcuOekAx9Vxq2PFQ3+cnPLoW/7Si95nrJtrsWUKKX/Tl/u+6VMnJN3bJsCoB6tXy/UJfh936g0Fj51PvYIdiVn18APk+gu3zsqwT6SYmSD/05haMJrY3H0qTRgPb2KztfLEYkrg7IL9ZcrV0lpBo3owOSV2XcYNyNBnaiEP7FHeVu3p17wUljZAQ6N7oT+AeeDpORX2lo0PK6y2Jdifwy9CMoGlmyy/hdCrxRNTg9c6i2NfbCYPngiuTui1LczfsxwzPglXu/3GEbVnnkt+PdRCnnRgjD7j1L2e19L1Wphd7xlg4h9RL8baSAy7Lbcp4yjxyMiTjgriDC3AwpYX1RyCXlCA6hYFbAjhf8kRaBH3gXC3q6JiS57dU9aK7cv6M9NeX8kz9gHNvA+pEKnGkFRrbZ//e4sc6XKYAa8kr0SNuEJ0eoibRiFH3sms8+rL7K43u1ZCzrZEskMTRZkiQc/oqjIAVs5Lc3LGVhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7051.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(6496006)(478600001)(52116002)(36756003)(6916009)(66556008)(2616005)(956004)(86362001)(38350700002)(186003)(66476007)(38100700002)(4326008)(26005)(6486002)(2906002)(5660300002)(8676002)(54906003)(66946007)(316002)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3dSWVZNOVlWR1prK0Q5RVlOdm4wZXRBbng1VjFGbnM0anFPQ0g2ZW1wdmR2?=
 =?utf-8?B?SFViZm9yR3cvKzE3MGpjOG5BSWpNSG52VndSSG41Ti8yN1h3SmFjcFlRWU1X?=
 =?utf-8?B?MUlxWVF6MW1RTmNNWHI4TVNqOFo3WitzWmhmOFkwU3IxOGRhdUcrUDZoc2xS?=
 =?utf-8?B?ckhFdSs0NHZsTkVmQVY0WkoxWks2STlFTVp2YW1oZHgvWGpCeGxrYklybHRR?=
 =?utf-8?B?Uy9rQ2tSS3FpQk1KR3hwbXBRNDVyS2czeThveDNKZ0p2YUhGTVlzUEsvT2dB?=
 =?utf-8?B?WkU0dGU2ODU4cG9rSEtQQkR2ZFJQc2EvUW9vYzg4OWZsbkMxRU5JQXFQZkFN?=
 =?utf-8?B?UW4zR28xUi92eHhYY3REZGhSMjlXUWxrdlJrdHVyTkNqandIT3ozNGFENHJ3?=
 =?utf-8?B?cW1TL2pnTytsdU50andVMmlXSVBCYzVuVHQ5WW5FU2R5bWNWbTNrMnBVTmFx?=
 =?utf-8?B?bGdwazVLbVAvM0tiZVZWTldIclRrUnNiRXFkQ0p5R2ZxTisxemw3djk1VEo1?=
 =?utf-8?B?aG96TTN6SS9VNkdZME40REppV3VYNDEycmVJNFVHRklqQk9aSjZHQWhTd1Fr?=
 =?utf-8?B?UmluV3U0NlAyd2pMaHV0UmhWcXcvOWNwWFNtOURyVThaYUxmVUs0ODBNSXlJ?=
 =?utf-8?B?aldTK2xybytwemd3cTRWUm9SbjU0QlFuT2xvRVJoWnBIaGpwQStoaVE5TDBx?=
 =?utf-8?B?d0thbjdoYmcvbUhXbDRnVzZ4WS93c0NiNUI5ZW8xdUVzK0lLU2QydkhpS0Qw?=
 =?utf-8?B?dTdjMUlPVE5XUytzcFN3bW1OY3FzUGR1Y2tNM2RBai9oQjc5UDR3aktScU1V?=
 =?utf-8?B?cG42WFRGSTE5MENBMmtpdG41d3JOUHMrdnEzcVlBZFVoU2RHNHdwOUQvN0Iv?=
 =?utf-8?B?YkpnN3Rva0dORVhDR08rTjZSYTdUSUVGVThRN1ZWSnZhTllSK1BUcVZmWWNv?=
 =?utf-8?B?ejVOU1VoVnBTMERXMW1aOFBYdFQ3UjhBTTVFcWd6ejZlQWlnOHc4MlZrRGlW?=
 =?utf-8?B?Sk13ZDhOSzkxam5mRTgxZ1I2QTEwSmlHVEhsSGtuV2trZmhBQ2o0di8rZDVy?=
 =?utf-8?B?bmlEdmlnR1cvS21hMTBPUVlENXlVanlZdVpyUldndzRMSUNOcHh6L2wwUGEv?=
 =?utf-8?B?OFA5MTRQMFBxZW5PR3ZYMnlVdjJwOWRpVk90bDBwVHhKeStxYk10VFRLa0ZS?=
 =?utf-8?B?QlN0cldTSTFHT2ZlaVdaZlJQSlpUK2M2bkZreDFIQTZuTGNaSDVPZExnc3Uz?=
 =?utf-8?B?WVFxN1NUbktYb01pUzNRcjdaakZqWndIdDhZQ0dpazNIQmdoM01udWlUVmZk?=
 =?utf-8?B?QW43YzM2aVdTUXo1ZmE2MmtrUHBOVzhpS3QvSWRmYnhHdm5TN3ZpbVdhbjdM?=
 =?utf-8?B?aXRSckhZcFpiNDF2dlRCeHgzTVhPazd0WkpMOGp1cllaK2VIVTBjbVozOWlL?=
 =?utf-8?B?NzdUaWVRNXRxZ1pBbmkzRnpGM09yYWlQaVl2Tko3OEJBK21YOVZSbG1kTSsy?=
 =?utf-8?B?MFRvdFVUeDVNWDNiYUdsSFBOUjEvSTFEVmdLSVlkb29NaUswOG1kVFRSak1V?=
 =?utf-8?B?Rm9WaWM5a3ZLQWpBTzI2NDhEdVBvWWFqbm9OUHZzRmhiTE5WcFhBd1B0S0Fk?=
 =?utf-8?B?aEJKWDZxRE1SMDVCdm8vVFBaL0pkTXRCcjl2YWZ0VnFLWUpSS21SVFV3V2hq?=
 =?utf-8?B?c2t1cUhpRUVYY2hJbFpYYlQremUwNStaS0x6VEsvczN2N1IxNVZJckt1bzZW?=
 =?utf-8?Q?76ZdwITfemA5+5OC/EGFkCTzdC10eD19xubLiIB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59615d14-dae4-4a1e-63da-08d947516d8d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 05:28:50.7811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VFP0V2dJ7KIR8KC1cglvdAeAhdkFHa3U5fHXSh4075zh24YEhG9i/Q9QwM13tPNeQA93vl6gvwJNlbWc0mRpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3915
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-07-14 at 13:46 +0300, Andy Shevchenko wrote:
> On Wed, Jul 14, 2021 at 01:38:22PM +0300, Andy Shevchenko wrote:
> > On Wed, Jul 14, 2021 at 06:10:46PM +0800, Liu Ying wrote:
> > > On Wed, 2021-07-14 at 12:12 +0300, Andy Shevchenko wrote:
> > > > On Wed, Jul 14, 2021 at 02:41:29PM +0800, Liu Ying wrote:
> > 
> > ...
> > 
> > > > > /*
> > > > >  * Get rate closer to *parent_rate to guarantee there is no overflow
> > > > >  * for m and n. In the result it will be the nearest rate left shifted
> > > > >  * by (scale - fd->nwidth) bits.
> > > > >  */
> > > > 
> > > > I don't know how to rephrase above comment better.
> > > > 
> > > > > scale = fls_long(*parent_rate / rate - 1);
> > > > > if (scale > fd->nwidth)
> > > > > 	rate <<= scale - fd->nwidth;
> > > > 
> > > > This takes an advantage of the numbers be in a form of
> > > > 
> > > > 	n = k * 2^m, (1)
> > > > 
> > > > where m will be scale in the snippet above. Thus, if n can be represented by
> > > > (1), we opportunistically reduce amount of bits needed for it by shifting right
> > > > by m bits.
> > > > Does it make sense?
> > > 
> > > Thanks for your explaination.
> > > But, sorry, Jacky and I still don't understand this.
> 
> It seems I poorly chose the letters for (1). Let's rewrite above as
> 
> This takes an advantage of the numbers be in a form of
> 
> 	a = k * 2^b, (1)
> 
> where b will be scale in the snippet above. Thus, if a can be represented by
> (1), we opportunistically reduce amount of bits needed for it by shifting right
> by b bits.
> 
> Also note, "shifting right" here is about the result of n (see below).
> 
> > Okay, We have two values in question:
> >  r_o (original rate of the parent clock)
> >  r_u (the rate user asked for)
> > 
> > We have a pre-scaler block which asks for
> >  m (denominator)
> >  n (nominator)
> > values to be provided to satisfy the (2)
> > 
> > 	r_u ~= r_o * m / n, (2)
> > 
> > where we try our best to make it "=" instead of "~=".
> > 
> > Now, m and n have the limitation by a range, e.g.
> > 
> > 	n >= 1, n < N_lim, where N_lim = 2^nlim. (3)
> > 
> > Hence, from (2) and (3), assuming the worst case m = 1,
> > 
> > 	ln2(r_o / r_u) <= nlim. (4)
> > 
> > The above code tries to satisfy (4).
> > 
> > Have you got it now?

I'm afraid I haven't, sorry. Jacky, what about you?

Is that snippet really needed?

Without that snippet, it seems that rational_best_approximation() is
able to offer best_numerator and best_denominator without the risk of
overflow for m and n, since max_numerator and max_denominator are
already handed over to rational_best_approximation()?

Does rational_best_approximation() always offer best_numerator by the
range of [1, max_numerator] and best_denominator [1, max_denominator]?

Regards,
Liu Ying

> > 
> > > > The code looks good to me, btw, although I dunno if you need to call the newly
> > > > introduced function before or after the above mentioned snippet.
> > > 
> > > Assuming that snippet is fully orthogonal to this patch, then it
> > > doesn't matter if it's before or after.
> > 
> > Please, double check this. Because you play with limits, while we expect them
> > to satisfy (3).
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> > 

