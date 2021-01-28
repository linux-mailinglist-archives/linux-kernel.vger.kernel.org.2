Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0F430805E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 22:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhA1VTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 16:19:21 -0500
Received: from st43p00im-ztbu10073601.me.com ([17.58.63.184]:60936 "EHLO
        st43p00im-ztbu10073601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229596AbhA1VTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 16:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1611868696; bh=ciV1++1D+OLCgxRRqznQGe+RYOrt49WBPH7f6XfbotU=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=ZQg5ltqK84t/9xNXnvyu4NFbQU1yTz8VaClkIymGEG2sVUziMyLeKFsbxKsO/dJlh
         8W7XULtR9wf/ToLNn9E8mP2ksLyvIqBssNnOBqJLAGO84Mi+iGYpQlxb2kQN7BynJd
         01H8JcWW3jDIlLZsShPzGQZP2BTCdDJqJlSAMKEq3Ao2llovf/E/Kgvo5Te39zHCnQ
         vw4H/2y6KFAzrTIpBvG7bUo7bgS7Qr4ojhoxuBnkhf6SsZrbfzvxmRsI/oh0UGkuYS
         N2NLstugYbmqhuizC/1E10DtthMGemgxxRZR/qpBGKVxV1BZfZogMGH+n1gY6Axdx5
         Bb2vdV2Io848w==
Received: from gnbcxl0029.gnb.st.com (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztbu10073601.me.com (Postfix) with ESMTPSA id 979AF8201B8;
        Thu, 28 Jan 2021 21:18:12 +0000 (UTC)
Date:   Thu, 28 Jan 2021 22:18:08 +0100
From:   Alain Volmat <avolmat@me.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ARM: dts: sti: Introduce 4KOpen (stih418-b2264) board
Message-ID: <20210128211807.GA15542@gnbcxl0029.gnb.st.com>
Mail-Followup-To: Arnd Bergmann <arnd@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210128075825.10368-1-avolmat@me.com>
 <CAK8P3a2TxPHc60c7+FoLm831rTPvyftRixL+BQfeVf3p_szopA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2TxPHc60c7+FoLm831rTPvyftRixL+BQfeVf3p_szopA@mail.gmail.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-28_12:2021-01-28,2021-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2101280104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

thanks for the comments and sorry for the large 'To' list. In my v2 I'll
limit to Patrice Chotard (STi maintainer).

On Thu, Jan 28, 2021 at 02:08:51PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 28, 2021 at 8:58 AM Alain Volmat <avolmat@me.com> wrote:
> >
> > 4KOpen (B2264) is a board based on the STMicroelectronics STiH418 soc:
> >   - 2GB DDR
> >   - HDMI
> >   - Ethernet 1000-BaseT
> >   - PCIe (mini PCIe connector)
> >   - MicroSD slot
> >   - USB2 and USB3 connectors
> >   - Sata
> >   - 40 pins GPIO header
> >
> > Signed-off-by: Alain Volmat <avolmat@me.com>
> 
> The changelog text seems fine here.
> 
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2021 STMicroelectronics
> > + * Author: Alain Volmat <avolmat@me.com>
> > + */
> > +/dts-v1/;
> > +#include "stih418.dtsi"
> > +#include <dt-bindings/gpio/gpio.h>
> > +/ {
> > +       model = "STiH418 B2264";
> > +       compatible = "st,stih418-b2264", "st,stih418";
> > +
> > +       chosen {
> > +               bootargs = "console=ttyAS0,115200 clk_ignore_unused";
> > +               stdout-path = &sbc_serial0;
> > +       };
> 
> I don't think the bootargs should be there, both are just hacks
> when things don't work correctly. If they don't, then try to fix them
> first, by making sure that all clocks are properly listed, and that the
> stdou-path points the working console.

Indeed, bootargs can be cleaned up. console is not necessary, however
it's going to be hard to get rid of the clk_ignore_unused now and I'd
prefer to keep it now, in the same way as for the other sti DTs.

> 
> > +&rng11 {
> > +       status = "disabled";
> > +};
> 
> Why do you disable the random number generator?

I shouldn't have putted this within the board DT. This rng11 is not
available on the STiH418.
In the v2 serie I'll had a separate commit to fix the stih418.dtsi instead.

Alain

> 
>        Arnd

