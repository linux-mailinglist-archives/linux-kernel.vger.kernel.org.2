Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97203A1A24
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 17:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236718AbhFIPvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 11:51:55 -0400
Received: from tux.runtux.com ([176.9.82.136]:54726 "EHLO tux.runtux.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235827AbhFIPvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 11:51:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by tux.runtux.com (Postfix) with ESMTP id 3C31E6F02A;
        Wed,  9 Jun 2021 17:49:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at tux.runtux.com
Received: from tux.runtux.com ([127.0.0.1])
        by localhost (tux2.runtux.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id CS2SSc287vVH; Wed,  9 Jun 2021 17:49:56 +0200 (CEST)
Received: from bee.priv.zoo (62-99-217-90.static.upcbusiness.at [62.99.217.90])
        (Authenticated sender: postmaster@runtux.com)
        by tux.runtux.com (Postfix) with ESMTPSA id F1ED56EFBF;
        Wed,  9 Jun 2021 17:49:55 +0200 (CEST)
Received: by bee.priv.zoo (Postfix, from userid 1002)
        id 7ACBD46E; Wed,  9 Jun 2021 17:49:55 +0200 (CEST)
Date:   Wed, 9 Jun 2021 17:49:55 +0200
From:   Ralf Schlatterbeck <rsc@runtux.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Lars Poeschel <poeschel@lemonage.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/1] auxdisplay: Add I2C gpio expander example
Message-ID: <20210609154955.hp4tuoiyrhpmtyok@runtux.com>
References: <20210106113730.k5qveshjgcd57kgx@runtux.com>
 <20210106113929.fizyg6fcsmsntkiy@runtux.com>
 <CANiq72=Cfv=Qo2fs+HDjUc8pV37mL326SDS5JpGotUfHLwK_rQ@mail.gmail.com>
 <CAMuHMdUW3U6DVkHp3xiHFzvRUDJ1FwTNCnBWp5LCuDGxhds9wg@mail.gmail.com>
 <CANiq72mCFwYnbynQgwNGTt0mzo_rMrnQfpinz6DrPttFxUpyNQ@mail.gmail.com>
 <20210517152035.GA2581887@robh.at.kernel.org>
 <20210519090047.e63d2im5vgskqpcs@runtux.com>
 <CAMuHMdV80XUo5ihXUkogCikGA4H71Ada9w=9W9d9d1zdgrw0uA@mail.gmail.com>
 <20210519115450.qoqpy7d5dgnjtenx@runtux.com>
 <CANiq72m+gqGWpUnA1tk0GX-wKdDnXF_1dKftjOLEAt4rjsnoaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72m+gqGWpUnA1tk0GX-wKdDnXF_1dKftjOLEAt4rjsnoaw@mail.gmail.com>
X-ray:  beware
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 03:55:10PM +0200, Miguel Ojeda wrote:
> Hi Ralf, Rob,
> 
> On Wed, May 19, 2021 at 1:54 PM Ralf Schlatterbeck <rsc@runtux.com> wrote:
> >
> > The hd44780 displays are often used with pcf8574 based I/O expanders.
> > Add example to documentation.
> >
> > Signed-off-by: Ralf Schlatterbeck <rsc@runtux.com>
> 
> I have queued this one into -next, adding the `Suggested-by` tag.

Thanks!

Ralf
-- 
Dr. Ralf Schlatterbeck                  Tel:   +43/2243/26465-16
Open Source Consulting                  www:   www.runtux.com
Reichergasse 131, A-3411 Weidling       email: office@runtux.com
