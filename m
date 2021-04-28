Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA41636E0F1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 23:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhD1VbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 17:31:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230141AbhD1VbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 17:31:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9E7C61441;
        Wed, 28 Apr 2021 21:30:33 +0000 (UTC)
Date:   Wed, 28 Apr 2021 17:30:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Joerg Roedel <jroedel@suse.de>, Jian Cai <caij2003@gmail.com>
Subject: Re: [PATCH 2/4] x86/entry: Use asm_noist_exc_nmi() for NMI in early
 booting stage
Message-ID: <20210428173032.10a5e959@gandalf.local.home>
In-Reply-To: <20210426230949.3561-3-jiangshanlai@gmail.com>
References: <20210426230949.3561-1-jiangshanlai@gmail.com>
        <20210426230949.3561-3-jiangshanlai@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2021 07:09:47 +0800
Lai Jiangshan <jiangshanlai@gmail.com> wrote:

> While the other entries for the exceptions which use Interrupt stacks can
> be also used on the kernel stack, asm_exc_nmi() can not be used on the
> kernel stack for it relies on the RSP-located "NMI executing" variable
> which expects to on a fixed location in the NMI IST stack.  When it is
> unexpectedly called from the kernel stack, the RSP-located "NMI executing"
> variable is also on the kernel stack and is "uninitialized" and can cause
> the NMI entry to run in the wrong way.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
