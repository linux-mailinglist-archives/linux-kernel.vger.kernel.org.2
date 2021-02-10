Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AE33163DE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 11:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhBJKcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 05:32:04 -0500
Received: from muru.com ([72.249.23.125]:59766 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhBJKUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 05:20:11 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 302D380EB;
        Wed, 10 Feb 2021 10:19:46 +0000 (UTC)
Date:   Wed, 10 Feb 2021 12:19:25 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Hector Martin 'marcan' <marcan@marcan.st>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        soc@kernel.org, robh+dt@kernel.org,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 18/18] arm64: apple: Add initial Mac Mini 2020 (M1)
 devicetree
Message-ID: <YCOzLSqdsr83xf0b@atomide.com>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-19-marcan@marcan.st>
 <20210208110441.25qc6yken4effd6c@kozik-lap>
 <cd67b2ce-9676-31b4-85f7-de1ec9b2bf72@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd67b2ce-9676-31b4-85f7-de1ec9b2bf72@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Hector Martin 'marcan' <marcan@marcan.st> [210208 12:05]:
> On 08/02/2021 20.04, Krzysztof Kozlowski wrote:
...

> > > +	clk24: clk24 {
> > 
> > Just "clock". Node names should be generic.
> 
> Really? Almost every other device device tree uses unique clock node names.

Yeah please just use generic node name "clock". FYI, we're still hurting
because of this for the TI clock node names years after because the drivers
got a chance to rely on the clock node name..

Using "clock" means your clock driver code won't get a chance to wrongly
use the node name and you avoid similar issues.

Regards,

Tony

