Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B8532E403
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 09:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhCEIzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 03:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhCEIzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 03:55:39 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251D7C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 00:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1dOSsl0ExEm6bWdQ+Ooyu1UuW3pSAJp7+tgguODTd9Y=; b=qXge8qFbgNK36kP81MsA6vz9rw
        tLQrBuIDEs50ocUAU2SnJOS6MaNV9YQpYTgKS+5fIAOtVGBCin03Lu7t0cr9m9wBuWokueH1/evBb
        8g3tX/5f/Vv2rbK8Wgzv2PpBt9ZPClPUhJv2Ev9IvN3LWm74mjqz0+MLzD+hM1F4wSVxz6DfXenZ5
        IhR/MY6lJ73wyIPClQmntIpQ3IWMiXaZv376PieDtUzyHYsCsRlGqxyhYFgOJZSu8hGvdPdQKxCel
        VYjMahKPCW22ZxU4s1tDDikCRjm41bWhE9bHgdQ9AFVvjxpQBeUoNUnTBVPfDhVVBhVmiso5a7Pwu
        wlD8324Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lI6FD-00E70q-U3; Fri, 05 Mar 2021 08:55:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 486BD306BCA;
        Fri,  5 Mar 2021 09:55:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A2982BA960CA; Fri,  5 Mar 2021 09:55:35 +0100 (CET)
Date:   Fri, 5 Mar 2021 09:55:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 17/21] tools/objtool: Convert to insn_decode()
Message-ID: <YEHyB9j4VHu12Xzl@hirez.programming.kicks-ass.net>
References: <20210304174237.31945-1-bp@alien8.de>
 <20210304174237.31945-18-bp@alien8.de>
 <YEEdlNN3OIi59hbr@hirez.programming.kicks-ass.net>
 <20210304180652.GE15496@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304180652.GE15496@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 07:06:52PM +0100, Borislav Petkov wrote:
> On Thu, Mar 04, 2021 at 06:49:08PM +0100, Peter Zijlstra wrote:
> > This is going to have trivial rejects/fuzz against tip/objtool/core.
> 
> I was just wondering whether to you show you how I resolved :)

Looks good, thanks!
