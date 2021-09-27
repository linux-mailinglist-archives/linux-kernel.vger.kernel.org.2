Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516A8419451
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbhI0Me6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:34:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234346AbhI0Me5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:34:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3046A61052;
        Mon, 27 Sep 2021 12:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632745999;
        bh=LX+JLN/iexEf9h06+p0bd8vUymoDBBk9mc2YNudMZdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xu8i2/meG401cQ5JSWZCk15kcvcWfazsVYR/TSkSafpeJfy/1nrJeXDCN61OtCB/L
         zNHFCxDTj2vUURnPwa5Lf9wDiKDf7IyEi6Ti3EoEl6/bICDuTXblFuf2FhV9Rcv2mt
         BUQKetBG97LJJ1VO1N9vjuV2rNPZVSbTku4Y8527uKZtu8fbF1OgCz8+Vkmr+ExmoC
         NlJF6cZd6DuhIC0pREPDqLXDC/1j0H021iBs5iZZq1BzKu/9GxFeT3SPu/yODExbGL
         jvV/Kp2D5DOLkLnPCCa+ns05RoM3RpOGekUxYMQGSQXOKt/wiQweh/HExx2P/vlh8O
         jClPzcmxoYqcw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2617A410A1; Mon, 27 Sep 2021 09:33:16 -0300 (-03)
Date:   Mon, 27 Sep 2021 09:33:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
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
Message-ID: <YVG6DKKpdIfAs2/Q@kernel.org>
References: <20210923161843.751834-1-irogers@google.com>
 <YU4gyQg1ntTeTL98@kernel.org>
 <20210925133944.a0648549c28b047bd9aeaeff@kernel.org>
 <YVBgp57askJVro9S@kernel.org>
 <YVCQ+GGaPrLBMGRf@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVCQ+GGaPrLBMGRf@zn.tnic>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Sep 26, 2021 at 05:25:44PM +0200, Borislav Petkov escreveu:
> On Sun, Sep 26, 2021 at 08:59:35AM -0300, Arnaldo Carvalho de Melo wrote:
> > So you want me to process it?
> 
> https://git.kernel.org/tip/5ba1071f7554c4027bdbd712a146111de57918de

Ok, processed already, case closed :-)

- Arnaldo
