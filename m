Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7B43F3B2B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 17:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhHUP3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 11:29:24 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38616 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231491AbhHUP3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 11:29:23 -0400
Received: from p5b3b3c9d.dip0.t-ipconnect.de ([91.59.60.157] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mHSvK-0000I5-5o; Sat, 21 Aug 2021 17:28:42 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Doug Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: rockchip: add RK3399 Gru gpio-line-names
Date:   Sat, 21 Aug 2021 17:28:40 +0200
Message-ID: <10392569.T7Z3S40VBb@phil>
In-Reply-To: <CA+ASDXO=Bjr+f4mtXwt7vtiTz6tSw7SPuY1RvNWMp6-43Baqfg@mail.gmail.com>
References: <20210820133829.1.Ica46f428de8c3beb600760dbcd63cf879ec24baf@changeid> <CAD=FV=UwAcJEDE3BQYuCDq4kRKPFAsuzPOseGY66wfXcW8Wn7A@mail.gmail.com> <CA+ASDXO=Bjr+f4mtXwt7vtiTz6tSw7SPuY1RvNWMp6-43Baqfg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 20. August 2021, 23:16:23 CEST schrieb Brian Norris:
> On Fri, Aug 20, 2021 at 2:05 PM Doug Anderson <dianders@chromium.org> wrote:
> > I guess one minor nit (now that I look back on the veyron patch where
> > I mentioned it explicitly in the commit message) is that on the veyron
> > ones we sorted this down at the bottom with the other pinctrl stuff
> > instead of sorting it alphabetically with everything else. I'll let
> > Heiko say which he likes better.
> 
> Huh, didn't notice that semi-convention. I can sort it however Heiko prefers.

Hmm, I wouldn't call it a semi-convention ... it was more an idea of
getting all the longer pages of "stuff" out of the way.

I don't think I have a real hard preference for the gpioX nodes
and I guess in the long run it might be helpful to try to limit the
number of "semi-conventions" .

I still like "pinctrl at the bottom", but I guess it might be easier to
with alphabetical for nodes with the rest :-) .


Heiko



> > I also notice for veyron that we had a second "ABI" exception for the
> > recovery mode pin, but I believe that goes through a different
> > mechanism now so we're good there.
> 
> I believe the recovery mode pin is dropped from recent designs (don't
> quote me in general on that), and there's a different mechanism used
> just to get the at-boot-time "recovery mode" state directly from the
> firmware.
> 
> > Even though I didn't do a line-by-line review, I'll still give:
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >
> > ...though it's possible an "Acked-by" would be more in the spirit of
> > that? Not sure...
> 
> Thanks!
> 
> Brian
> 




