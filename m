Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC31357007
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353449AbhDGPSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:18:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353444AbhDGPSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:18:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4622A61262;
        Wed,  7 Apr 2021 15:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617808713;
        bh=wp5Kiq2yK8eQG66G8fRxjJMmHVWTNazhDUY7L57YSKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JJQrTBpeIoQ+YMwpTJ0wlDmiS01GPvlhMqYQsItY2fu/k6P0Mmi/0vSVj1mOTn5vh
         xS3mcFK31oRIiMuInhHLr5f3v5VPRLvsqGXZ5onoTjO15t8qeYGGxeKYpdt//CEwWU
         1W0pUxbn5n19WVAV+FBXY4UAhhVXNc8h944gC1XY=
Date:   Wed, 7 Apr 2021 17:18:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: serial: 8250: deprecate
 aspeed,sirq-polarity-sense
Message-ID: <YG3NR4bGRjIGZhgx@kroah.com>
References: <20210402182724.20848-1-zev@bewilderbeest.net>
 <20210402182724.20848-2-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402182724.20848-2-zev@bewilderbeest.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 01:27:21PM -0500, Zev Weiss wrote:
> This property ties SIRQ polarity to SCU register bits that don't
> necessarily have any direct relationship to it; the only use of it
> was removed in commit c82bf6e133d30e0f9172a20807814fa28aef0f67.

Please write that as:
	c82bf6e133d3 ("ARM: aspeed: g5: Do not set sirq polarity")

> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 1 +
>  1 file changed, 1 insertion(+)

What changed from previous versions?  That always goes below the ---
line.

Please fix up and send a v5.

thanks,

greg k-h
