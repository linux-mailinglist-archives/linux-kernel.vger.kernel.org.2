Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4F5435DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhJUJUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 05:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhJUJUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:20:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03DEC06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 02:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yUMBZ/1PbxAlvy7xiNmqmNKCccTur8IZ6x9U51X12rw=; b=GNdZ4Vu286kmZKQFPnD6uMS/I8
        GHoJAiR8feJU+OlIioVecEQOp48QlZLpi/ZZFyZcfZLiumKRt9g9vPygQhmvteNZ2semWMAJc61uh
        X2JbTKeWhYMAVrubNpe3/20mqCwq/uwX/EGMny3m3P9jpJeIdOfFI0chZF4NPJmTpLF02RkVjrj4n
        /SB6I7HeL2f9zvhkiwEmyOvuTljlgohOVSYJU/tUUJCKf1lujlYs+Llo+7s8E2ZrPcDQc9aqpJ8ei
        wjV++v3DGTwhMAqA+L3/IpTDeaDD4xtDAJ9fweCc+n7ePhCQWDVK4xlal/1T7raz9DMuLN3kYnkwk
        7s0tvElw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdUAh-00DA3R-SH; Thu, 21 Oct 2021 09:16:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 78EB530024D;
        Thu, 21 Oct 2021 11:15:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B00C2D4101F0; Thu, 21 Oct 2021 11:15:35 +0200 (CEST)
Date:   Thu, 21 Oct 2021 11:15:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: MAINTAINERS: Add Dave Hansen to the x86 maintainer team
Message-ID: <YXEvtyKbka4gMby/@hirez.programming.kicks-ass.net>
References: <87zgr3flq7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgr3flq7.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 11:08:16PM +0200, Thomas Gleixner wrote:
> Dave is already listed as x86/mm maintainer, has a profund knowledge of
> the x86 architecture in general and a good taste in terms of kernel
> programming in general.
> 
> Add him as a full x86 maintainer with all rights and duties.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Dave; I welcome thee to email hell :-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
