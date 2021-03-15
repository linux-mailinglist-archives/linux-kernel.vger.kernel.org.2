Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C9933C6D3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 20:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbhCOT3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 15:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbhCOT2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 15:28:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317C1C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 12:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gEsaQOn4V2M9OEebLwu2Db4xuNsqBto5A+tsML/xvUA=; b=asUrE3GICQHxfwfECREMlmCGTS
        nnSUlgJ9YhGZoNiy65UxdI2eGr0TE3Xcct4bujbw8jNy49yPufTZ6sSHaAe3xN2NndHYgiQ/02YlQ
        g1LuXsj0Wdo11Di0flwNjgB57thsPf1X1VcCgSbxvZnO2YRXVpuNzcKDJ7iyht3zNXeGpFJAL4j2t
        etMygyVL8EpRsLxnFkEFHWWFt1LN6wW6LI9X3kTx8xcOg/Cx1YCj9ebV7IcgXgyJ0ONt3GlhWgZ5B
        ZpXjfBVLtoovJ3ratpaQGRHR9Mt319wgEFlXqW7z4NaqkRaMZTZiZ6wyCLLo5FAekHCyJvNKvhFhX
        otzDHBIg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLssl-000enL-LS; Mon, 15 Mar 2021 19:28:10 +0000
Date:   Mon, 15 Mar 2021 19:28:03 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        marcan@marcan.st, maz@kernel.org, tglx@linutronix.de
Subject: Re: [PATCHv3 2/6] arm64: don't use GENERIC_IRQ_MULTI_HANDLER
Message-ID: <20210315192803.GB154861@infradead.org>
References: <20210315115629.57191-1-mark.rutland@arm.com>
 <20210315115629.57191-3-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315115629.57191-3-mark.rutland@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 11:56:25AM +0000, Mark Rutland wrote:
> From: Marc Zyngier <maz@kernel.org>
> 
> In subsequent patches we want to allow irqchip drivers to register as
> FIQ handlers, with a set_handle_fiq() function. To keep the IRQ/FIQ
> paths similar, we want arm64 to provide both set_handle_irq() and
> set_handle_fiq(), rather than using GENERIC_IRQ_MULTI_HANDLER for the
> former.

Having looked through the series I do not understand this rationale
at all.  You've only added the default_handle_irq logic, which seems
perfectly suitable and desirable for the generic version.  Please
don't fork off generic code for no good reason.
