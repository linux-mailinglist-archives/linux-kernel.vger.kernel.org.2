Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AF33FFD8E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 11:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348975AbhICJzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 05:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348948AbhICJy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:54:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23637C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 02:53:56 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d5800e0c92975d32b0bec.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:5800:e0c9:2975:d32b:bec])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 416BE1EC059D;
        Fri,  3 Sep 2021 11:53:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630662830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=l2Az5Dey31zXva/yBZao+vifIvNusQrJfvr7LRYgTeA=;
        b=crqwpJeEjwjJvAQD/n02HYstWIeCmVzf0E3ELdFjTDXDCkIsaL8SENqk6CM4xeBx0j8MIH
        Uw9VehcTsp+WJF1FTSLMZPx+uyt2q9AF/O3Q+qcJAPPoaj1XaU+lGdeqBcYqoVsMfit5mj
        gm58RUvxZY7juHxS6QlZWSRbMnhL+MI=
Date:   Fri, 3 Sep 2021 11:54:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@suse.de>, kernel test robot <lkp@intel.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86-ml <x86@kernel.org>
Subject: Re: vmlinux.o: warning: objtool: mce_wrmsrl.constprop.0()+0x6b: call
 to __sanitizer_cov_trace_pc() leaves .noinstr.text section
Message-ID: <YTHw1YWYNgPK5KfF@zn.tnic>
References: <202108221334.TiXxFSTZ-lkp@intel.com>
 <YTEncGj84Sj/IdDb@zn.tnic>
 <YTHpmGmlo9N+1Rs7@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTHpmGmlo9N+1Rs7@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 11:23:36AM +0200, Peter Zijlstra wrote:
> So I was wondering why they'd show up in any case, since objtool is
> supposed to NOP them, but then I remembered I still have this patch
> pending:
> 
>   https://lore.kernel.org/r/20210624095147.818783799@infradead.org
> 
> Which I suspect will cure that for older GCC.

Yah, works with gcc-10 here too.

Tested-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
