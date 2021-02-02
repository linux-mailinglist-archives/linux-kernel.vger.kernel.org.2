Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899FC30CB20
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239434AbhBBTOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:14:00 -0500
Received: from mail.v3.sk ([167.172.186.51]:49474 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238819AbhBBTB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 14:01:59 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 511ACE0B0C;
        Tue,  2 Feb 2021 18:57:04 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6kkDOWA5tmAl; Tue,  2 Feb 2021 18:57:03 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 84483E0B78;
        Tue,  2 Feb 2021 18:57:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FKeiKG_JfjRb; Tue,  2 Feb 2021 18:57:02 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 45753E0B0C;
        Tue,  2 Feb 2021 18:57:02 +0000 (UTC)
Date:   Tue, 2 Feb 2021 20:01:06 +0100
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ARM: dts: mmp devicetree updates
Message-ID: <20210202190106.GA368014@demiurge.local>
References: <20210121034130.1381872-1-lkundrak@v3.sk>
 <CAK8P3a2DYX3c-AMX9URSyrcQckY2UaRRTmnOwe=4q3P4cJ-t5A@mail.gmail.com>
 <CAK8P3a2Ub0w3v_H_0F84MPdQZ28vUgxdYNii7eVY0o9a_sg7DQ@mail.gmail.com>
 <CAK8P3a0h8r+K3cKKRJD6-rZ9H=F8ciKgkN6+XEF61scLbEqGOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0h8r+K3cKKRJD6-rZ9H=F8ciKgkN6+XEF61scLbEqGOw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 06:13:18PM +0100, Arnd Bergmann wrote:
> On Tue, Feb 2, 2021 at 5:41 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Fri, Jan 22, 2021 at 3:09 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > On Thu, Jan 21, 2021 at 4:41 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> > > >
> > > > chained to this message is a handful of patches related to MMP device
> > > > trees and bindings. Please take a look and consider queueing them for
> > > > for 5.12.
> > >
> > > These all look good to me, but I notice that a lot of them seem to be
> > > bugfixes, so please have another look and decide if any of them should
> > > go into v5.11 and perhaps backported to stable kernels as well.
> >
> > Hi Lubomir,
> >
> > not sure if you missed my earlier mail. To clarify, I have not applied
> > any of the patches so far. Can you recheck if some of them should be
> > part of the v5.11 release so I know which tree to apply them to?
> 
> Nevermind, I just found your earlier reply in my spam folder. Applying
> the patches now.

Would you mind sharing why your spam filter decided to flag my message? (the
X-Spam* headers, if there's anything relevant there). I'm wondering if it's
possible other spam filters drop my messages for the same reason and if it's
something I could fix.

Thank you.

Lubo

> 
>          Arnd
