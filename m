Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3159A3D323A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 05:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhGWCtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 22:49:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:32956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233499AbhGWCtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 22:49:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CDEA60EBD;
        Fri, 23 Jul 2021 03:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627011007;
        bh=YErrO5x/unzIGIs/Nw2Woznbf+pZoN0es7LVf9cgeTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wl8sN8xB098z7yNK9TLDFtVG56/NjvUzzYhVIjv4LIk4E5wUhqCe7nsDg5jwCQ8LF
         9K+6I7qVl70DJKwmxffe5X7yEIWsS9/+xJ3uiB48AV6ItRA2upVk0lNGTkuKL3tbmh
         IDGtpljZpaMzcUwxbH4+6lOffreqAlLr2zXf4fuMgnW5wntlrO/KryP9/aiaKVCKzD
         x870fSX62SZxJ7TD+qJLUm8Mgr+0NwIAKmitdhd/vzFVQAzc98p3/KcwX/DQKcel5S
         I0NDKJ6n9lZZ+8BoXlr1wMXCSgKjrGJk2kLK1RKM7LpfxiGVKNEiWhOIhWH1UJlyRL
         vjYwqb/52wH9w==
Date:   Fri, 23 Jul 2021 11:30:02 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        kernel@dh-electronics.com, Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH V3] dt-bindings: arm: fsl: Add DHCOM PicoITX and DHCOM
 DRC02 boards
Message-ID: <20210723032953.GI28658@dragon>
References: <20210714202252.5898-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714202252.5898-1-cniedermaier@dh-electronics.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 10:22:52PM +0200, Christoph Niedermaier wrote:
> Add DH electronics DHCOM PicoITX and DHCOM DRC02 boards. The DHCOM DRC02
> device can only house a SOM with iMX6S and not with iMX6DL, due to some
> thermal design consideration. But for compatible fsl,imx6dl is chosen,
> because fsl,imx6s isn't available, the iMX6S is basically a iMX6DL with
> one CPU core disabled and therefore the kernel discerns the iMX6S/iMX6DL
> automatically.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: robh+dt@kernel.org
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: kernel@dh-electronics.com
> Cc: Fabio Estevam <festevam@denx.de>
> To: devicetree@vger.kernel.org

Applied, thanks!
