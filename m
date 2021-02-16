Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D45531C921
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 11:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBPKzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 05:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhBPKzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 05:55:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FC7C061574;
        Tue, 16 Feb 2021 02:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ri0wAXITtLC2i7iZaTvCqXngoV666QrWELjdECOX1rk=; b=tQuErYUX4KgJJoqhYjroGACq4d
        vDZrc9d65vLQYly4ydlyiOyILOytcklfxnp3ODXrYlVhhS8QrRFtfS6zj180Y4ug1CrqxudVjNcXO
        jDpfIAbFm+zznysSmBtDD2tK/dv+1eslfT5rK0lvlnZEe+CUkrAdKO7umbh9W7ELGSwjJ2nK34aOi
        ABB5mgBFsXs67dPHu/XBUHw1li1/AtKNzTy6fKgrF4xzk8WMhdOBlOG+L0nJoEE3crimIJ7ArX2aE
        QjEXU+hYQunombfU65rAoKpcPENneXsaBCHdQiHSS8DY31O1tki9gkrxlF2R/4FjyobDhQmx2YbdH
        Gtf78hxw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lBxyd-00Glll-86; Tue, 16 Feb 2021 10:53:10 +0000
Date:   Tue, 16 Feb 2021 10:53:07 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/25] asm-generic/io.h:  Add a non-posted variant of
 ioremap()
Message-ID: <20210216105307.GA3996646@infradead.org>
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-11-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215121713.57687-11-marcan@marcan.st>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Your new iomremap variant needs proper documentation explaining the
semantics in detail.
