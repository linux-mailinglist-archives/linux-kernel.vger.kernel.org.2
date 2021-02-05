Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BC531076D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhBEJLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:11:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:59932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229669AbhBEJJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:09:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EFB064FBF;
        Fri,  5 Feb 2021 09:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612516172;
        bh=JdD0MSkgGiDQgR1RqZMYYZuQVt/HbkXgGJeoHCpYJio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kmMA0pCiSfbnVQOP9h8OWUUs1gL0W3kE2qPu9+x+tMXmNjuqO/DHFbIepE4bOuxOH
         GQBcrhUsbX6GyzQt/WPlsYs5a77THjVGJM95iiwKE+V3ETQ+/VZGmRJinOIeJVXMBT
         +heMmOj2VdzbISIWeHN8fbVnuqzIlYv7PGtKlcpI=
Date:   Fri, 5 Feb 2021 10:09:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ikjoon Jang <ikjn@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [RFC PATCH v2 1/3] dt-bindings: usb: mtk-xhci: add compatible
 for mt8195
Message-ID: <YB0LSQdCZk3xL+ru@kroah.com>
References: <20210203102642.7353-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203102642.7353-1-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 06:26:40PM +0800, Chunfeng Yun wrote:
> There are 4 USB controllers on MT8195, the controllers (IP1~IP3,
> exclude IP0) have a wrong default SOF/ITP interval which is
> calculated from the frame counter clock 24Mhz by default, but
> in fact, the frame counter clock is 48Mhz, so we should set
> the accurate interval according to 48Mhz. Here add a new compatible
> for MT8195, it's also supported in driver. But the first controller
> (IP0) has no such issue, we prefer to use generic compatible,
> e.g. mt8192's compatible.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: no changes

Note, I do not apply patches that have "RFC" as that means you do not
feel comfortable with them being applied.

Please resend without that when you feel they are ready to be merged.

thanks,

greg k-h
