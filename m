Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CE54189F4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhIZP1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbhIZP1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:27:32 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F70C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:25:56 -0700 (PDT)
Received: from zn.tnic (p200300ec2f244100fb10325199271b24.dip0.t-ipconnect.de [IPv6:2003:ec:2f24:4100:fb10:3251:9927:1b24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CDC4F1EC065A;
        Sun, 26 Sep 2021 17:25:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632669950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BVzZ9QNfM/FF2wSmCvF517e0J/3++zPtXkU9aKuPgk8=;
        b=bkhwCs7g1z3QHsUeDsR0vsC20FEYwA+4QN6y2FensmJ7GiR3Aw4K1hD31aerZM+ju/9Fam
        nthNZLPfY2K+CaW0EBtEbIykTlKLkX5Vj2jiSBuOvaOYmF4pk1shgW7RhDxKQ2wX2c7hNq
        bCNTAQOymJOtUCL8PIalaVcwFFvJ8sY=
Date:   Sun, 26 Sep 2021 17:25:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Laight <David.Laight@aculab.com>,
        Numfor Mbiziwo-Tiapo <nums@google.com>
Subject: Re: [PATCH v4] x86/insn, tools/x86: Fix some potential undefined
 behavior.
Message-ID: <YVCQ+GGaPrLBMGRf@zn.tnic>
References: <20210923161843.751834-1-irogers@google.com>
 <YU4gyQg1ntTeTL98@kernel.org>
 <20210925133944.a0648549c28b047bd9aeaeff@kernel.org>
 <YVBgp57askJVro9S@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVBgp57askJVro9S@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 08:59:35AM -0300, Arnaldo Carvalho de Melo wrote:
> So you want me to process it?

https://git.kernel.org/tip/5ba1071f7554c4027bdbd712a146111de57918de

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
