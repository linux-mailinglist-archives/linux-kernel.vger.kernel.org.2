Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E3435AEE3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 17:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbhDJPjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 11:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbhDJPjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 11:39:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B71C06138A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 08:38:52 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1aea005aa758d9575cf1c9.dip0.t-ipconnect.de [IPv6:2003:ec:2f1a:ea00:5aa7:58d9:575c:f1c9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9BA481EC030E;
        Sat, 10 Apr 2021 17:38:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618069130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FPedXbgW2ONGMibyPsuCTqUeDxWmPCWINZBEmAvaLF4=;
        b=nWDGJ3n1R1eNWQaIfj8w0fvPvXC6uEj2ZPstO5PeQUdheajyZODOEycACeb8goJqRt+Eat
        OeYSqN7hWr8RS0qD3vinollUGCg/f/YiEyDRkJnJcED1o1SOAUVQNxFtxHsIDDZJ41AVoj
        DW6KG5bTmB1A76lxJEdO98mrdhChoSA=
Date:   Sat, 10 Apr 2021 17:38:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        andi.kleen@intel.com, dave.hansen@intel.com, len.brown@intel.com
Subject: Re: [RFC 1/2] x86/tsc: add a timer to make sure tsc_adjust is always
 checked
Message-ID: <20210410153853.GE21691@zn.tnic>
References: <1617092747-15769-1-git-send-email-feng.tang@intel.com>
 <87y2dq32xc.ffs@nanos.tec.linutronix.de>
 <20210410094752.GB21691@zn.tnic>
 <20210410144856.GC22054@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210410144856.GC22054@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 10:48:56PM +0800, Feng Tang wrote:
> And the bigger risk is still BIOS's writing to TSC_ADJUST MSR beneath
> kernel.

For that we need to do more persuasive work with hw guys. Needs a *lot*
of perseverance.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
