Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D39308FE0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 23:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhA2WNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 17:13:06 -0500
Received: from mail.v3.sk ([167.172.186.51]:59538 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233537AbhA2WMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 17:12:52 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 6FADEE0B4F;
        Fri, 29 Jan 2021 22:08:03 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WVW95jXP8lLx; Fri, 29 Jan 2021 22:08:02 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 90B8DE0B4C;
        Fri, 29 Jan 2021 22:08:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SBoZVgSkdasp; Fri, 29 Jan 2021 22:08:01 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 3BAA3DF932;
        Fri, 29 Jan 2021 22:08:01 +0000 (UTC)
Date:   Fri, 29 Jan 2021 23:12:07 +0100
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ARM: dts: mmp devicetree updates
Message-ID: <20210129221207.GA77366@demiurge.local>
References: <20210121034130.1381872-1-lkundrak@v3.sk>
 <CAK8P3a2DYX3c-AMX9URSyrcQckY2UaRRTmnOwe=4q3P4cJ-t5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2DYX3c-AMX9URSyrcQckY2UaRRTmnOwe=4q3P4cJ-t5A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 03:09:14PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 21, 2021 at 4:41 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> >
> > Hi,
> >
> > chained to this message is a handful of patches related to MMP device
> > trees and bindings. Please take a look and consider queueing them for
> > for 5.12.
> 
> These all look good to me, but I notice that a lot of them seem to be
> bugfixes, so please have another look and decide if any of them should
> go into v5.11 and perhaps backported to stable kernels as well.

I'm not sure any of these are worth backporting to stable. I believe
actually only these two are bugfixes:

  [PATCH 06/12] ARM: dts: mmp3: Extend the MPMU reg range
  [PATCH 12/12] ARM: dts: mmp3: Fix the CCIC interrupts

The first one only affects the audio, but the MMP I2S driver doesn't
work on MMP3 yet. The second one affects the camera, but the only board
DTS shipped at this point doesn't have one. Therefore both are somewhat
inconequential for older kernels.

> 
>        Arnd

Thanks
Lubo
