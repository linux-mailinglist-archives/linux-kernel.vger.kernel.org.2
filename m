Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0290830D795
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 11:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbhBCKcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 05:32:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:53216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233555AbhBCKcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 05:32:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B09D664E38;
        Wed,  3 Feb 2021 10:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612348296;
        bh=CYVgOCDOrg5Ej4JSZWXzmO4nRwEV0xspTKLDaP80Qqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cRZA8g71/ZrpNE0lonjdkXJkp+AzevRm6bF6qQ1cCtuFPsH6w3rga4p+owHR0xSbI
         QXIBxiCgeN4kKKcmrEYBQ6AWsSIIU6pIY+gTf1WWuvEjRj3njhz557b097L13FNfg6
         Ztw7ZvL8iEAu3V1mhJrj6CMXaAPtC0JqhemMAatA=
Date:   Wed, 3 Feb 2021 11:31:34 +0100
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
Message-ID: <YBp7hnyPJwgK598V@kroah.com>
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

Note, I do not apply patches with "RFC" as obviously you do not think
they are worthy of being applied.  I don't see what you are asking to be
done with this set of patches, please explain?

thanks,

greg k-h
