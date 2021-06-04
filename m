Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A54B39B75F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 12:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhFDLAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 07:00:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229667AbhFDLAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 07:00:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67D3D600D3;
        Fri,  4 Jun 2021 10:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622804299;
        bh=RpiLOvgSTldH32Z5nI8EixhVdPHH7DAf0w2UqTQw13c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JmXpTS1KqbpT3ioqIXQ7ezFZdB3if8+GfSHEwwv2djRfGtNXI6TCj5GNo6rvQs+73
         QXIjbVki5qZPzo/stXpFZFn0bNH6syOPnxB3lUJHfTsFjw2DKDjZdXrspv3HKIF+6J
         tU4WsBlji8q08rd0Qa43NzB3q/fiYrmiwuNtJSDU=
Date:   Fri, 4 Jun 2021 12:58:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3-meson-g12a: fix usb2 PHY glue init when phy0
 is disabled
Message-ID: <YLoHSJIOSRTyF0r1@kroah.com>
References: <20210601084830.260196-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210601084830.260196-1-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 10:48:30AM +0200, Neil Armstrong wrote:
> When only PHY1 is used (for example on Odroid-HC4), the regmap init code
> uses the usb2 ports when doesn't initialize the PHY1 regmap entry.

<snip>

Meta comment, you signed this, and it worked!

Looking up https://lore.kernel.org/r/20210601084830.260196-1-narmstrong%40baylibre.com
Grabbing thread from lore.kernel.org/linux-amlogic/20210601084830.260196-1-narmstrong%40baylibre.com/t.mbox.gz
Analyzing 2 messages in the thread
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH] usb: dwc3-meson-g12a: fix usb2 PHY glue init when phy0 is disabled
    + Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> (✓ DKIM/lists.infradead.org)
  ---
  ✓ Signed: openpgp/narmstrong@baylibre.com
  ✗ BADSIG: DKIM/baylibre-com.20150623.gappssmtp.com
  ✓ Signed: DKIM/lists.infradead.org (From: narmstrong@baylibre.com)
---
Total patches: 1
---
 Link: https://lore.kernel.org/r/20210601084830.260196-1-narmstrong@baylibre.com
 Base: not found
Applying: usb: dwc3-meson-g12a: fix usb2 PHY glue init when phy0 is disabled


Odd that DKIM didn't work for baylibre-com, but hey, I'll take a real
signature over DKIM anyday!

thanks for doing this.

greg k-h
