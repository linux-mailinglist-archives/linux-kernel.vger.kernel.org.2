Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A93387B5E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbhEROlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:41:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60598 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbhEROkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:40:24 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621348745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nOqq4RhmAB+qpv6uf+uXRfuAamb5bYXRuwIA5uBor6k=;
        b=vJsFEMhcSBUNcZhuUZn06UyjkBH8HMC6wRmxpsx7dQs2IV9wPFyK7O4wVSJJMTOOB1xQhU
        Xc+JqG/S8Clecbv5zGB0OB/IJo1tCN2Rns3Vi/71QbixQfIDs1qy5JeSi2sBuES0YEMwUf
        sg3oK6sROAajdRM5O4C61pEF2mZWbmMYgSYjXH7QPW/Zr67H/bExecPt37RAG/WyIUjJgX
        6TRuVMWN7WrphgtqOONH55oTpsZATafvg0rg/+7XwbSCPJpUUCmufHGYKWqBE2dIhTZAQs
        TBlfy8nJ2FoNwQ32UEJdxAaLGgdUYTtPxNjI9R1TXaNRAdc4p8htBjuho92EEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621348745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nOqq4RhmAB+qpv6uf+uXRfuAamb5bYXRuwIA5uBor6k=;
        b=ZeEZdE2qfoMfxGWtr2yUfR6Ks8DcTSCyrCN0U+DUgcU1n1eSKKtncmLYuZyZEaHuy+CRTW
        gECkWcT10YJw/iAw==
To:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH 1/4] Documentation/x86: Add buslock.rst
In-Reply-To: <20210419214958.4035512-2-fenghua.yu@intel.com>
References: <20210419214958.4035512-1-fenghua.yu@intel.com> <20210419214958.4035512-2-fenghua.yu@intel.com>
Date:   Tue, 18 May 2021 16:39:04 +0200
Message-ID: <87cztods3b.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19 2021 at 21:49, Fenghua Yu wrote:
> Add buslock.rst to explain bus lock problem and how to detect and
> handle it.

Documentation/x86/buslock.rst:7: WARNING: Undefined substitution referenced: "copy".
Documentation/x86/buslock.rst: WARNING: document isn't included in any toctree

Warnings are overrated...
