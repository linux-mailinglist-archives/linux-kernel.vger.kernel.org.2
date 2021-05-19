Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07081388A43
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344749AbhESJML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:12:11 -0400
Received: from tux.runtux.com ([176.9.82.136]:34290 "EHLO tux.runtux.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344736AbhESJKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:10:42 -0400
X-Greylist: delayed 506 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 May 2021 05:10:40 EDT
Received: from localhost (localhost [127.0.0.1])
        by tux.runtux.com (Postfix) with ESMTP id 282A16EFFE;
        Wed, 19 May 2021 11:00:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at tux.runtux.com
Received: from tux.runtux.com ([127.0.0.1])
        by localhost (tux2.runtux.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id klkjuXpH5xQ4; Wed, 19 May 2021 11:00:48 +0200 (CEST)
Received: from bee.priv.zoo (62-99-217-90.static.upcbusiness.at [62.99.217.90])
        (Authenticated sender: postmaster@runtux.com)
        by tux.runtux.com (Postfix) with ESMTPSA id 076366EF98;
        Wed, 19 May 2021 11:00:47 +0200 (CEST)
Received: by bee.priv.zoo (Postfix, from userid 1002)
        id 4F7DA46E; Wed, 19 May 2021 11:00:47 +0200 (CEST)
Date:   Wed, 19 May 2021 11:00:47 +0200
From:   Ralf Schlatterbeck <rsc@runtux.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Lars Poeschel <poeschel@lemonage.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/1] auxdisplay: Add I2C gpio expander example
Message-ID: <20210519090047.e63d2im5vgskqpcs@runtux.com>
References: <20210106113730.k5qveshjgcd57kgx@runtux.com>
 <20210106113929.fizyg6fcsmsntkiy@runtux.com>
 <CANiq72=Cfv=Qo2fs+HDjUc8pV37mL326SDS5JpGotUfHLwK_rQ@mail.gmail.com>
 <CAMuHMdUW3U6DVkHp3xiHFzvRUDJ1FwTNCnBWp5LCuDGxhds9wg@mail.gmail.com>
 <CANiq72mCFwYnbynQgwNGTt0mzo_rMrnQfpinz6DrPttFxUpyNQ@mail.gmail.com>
 <20210517152035.GA2581887@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517152035.GA2581887@robh.at.kernel.org>
X-ray:  beware
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 10:20:35AM -0500, Rob Herring wrote:
> Now it warns in linux-next:
> 
> Documentation/devicetree/bindings/auxdisplay/hit,hd44780.example.dts:52.18-62.11: Warning (unit_address_vs_reg): /example-1/i2c@2000: node has a unit name, but no reg or ranges property

[I'm the author of that patch]
Can someone point me to the documentation of how to check a single
example against the dt schemata? I think I had that figured out how to
run the dt-checks over the whole tree in january but didn't bother with
warnings since the whole devtree was riddled with warnings at the time.
Docs on how to quickly check for warnings/errors would help me a lot. My
naive usage of dt-validate on an example yields a traceback, I've opened
a report on github because I think that even with gross mis-usage the
tool shouldn't traceback...

Thanks for your help and pointers.
Ralf
-- 
Dr. Ralf Schlatterbeck                  Tel:   +43/2243/26465-16
Open Source Consulting                  www:   www.runtux.com
Reichergasse 131, A-3411 Weidling       email: office@runtux.com
