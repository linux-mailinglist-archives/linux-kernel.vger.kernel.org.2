Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DB23880B5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 21:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351950AbhERTqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 15:46:37 -0400
Received: from netrider.rowland.org ([192.131.102.5]:41479 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1351924AbhERTqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 15:46:31 -0400
Received: (qmail 1140553 invoked by uid 1000); 18 May 2021 15:45:11 -0400
Date:   Tue, 18 May 2021 15:45:11 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Al Cooper <alcooperx@gmail.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v10 2/5] USB: misc: Add onboard_usb_hub driver
Message-ID: <20210518194511.GA1137841@rowland.harvard.edu>
References: <20210511225223.550762-1-mka@chromium.org>
 <20210511155152.v10.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <YKPz7a68duMyXU5x@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKPz7a68duMyXU5x@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 10:05:49AM -0700, Matthias Kaehlcke wrote:
> Hi Alan,
> 
> You seemed to have a generally favorable view of this driver,
> but I haven't heard from you in a while :)
> 
> On v4 expressed a series of suggestions and concerns, which
> should be addressed in this version:
> 
> https://lore.kernel.org/patchwork/patch/1313000/
> https://lore.kernel.org/patchwork/patch/1313001/
> 
> Rob acked the DT binding and the of_platform change. Please let me
> know if the USB part needs any further changes or if you think this
> series is ready to land.

Those were long and complicated threads, and a lot of the material has
gone out of my brain since last October.  :-(

Still, at the time when this was first posted I don't remember there
being any big outstanding issues regarding the USB part of the
implementation.  It seemed to be pretty much all in order.

You can add:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

to this patch.  Greg KH may have some thoughts of his own...

Alan Stern
