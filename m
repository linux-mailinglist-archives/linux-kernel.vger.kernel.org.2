Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141B745D09A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 23:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352515AbhKXW6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 17:58:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47684 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352309AbhKXW55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 17:57:57 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637794485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=33e828wB9dEjeifz4XOcX4tXiHJV404Ri36l36adBdc=;
        b=QL25vkWz5mQq9ypR1mfmeECHaoZFXVS51EIdeocF5QL5UpPcPy/vofDZ9im05kSuQzGiBJ
        hmVnAE32Zwr1VkRpV1E2d3zSHp/NaafeFx27NyPu3NeXBUKveOHM8EaU3XHWHEOM9acx4v
        TWEwjphxl+Xa8N5TxXy+pF+QZh0oBWvQ9a133TJwQqhgl5uKgyToljpih/0s43EbY/3lIm
        cqA8t+/NdjU5XMTORklBghjPF/S6+ETzyUnMQxqFwpOfWrExhkE8lszWssWX+C4T/s5tlu
        pI/lWC3ZBTxtDAQGnymKdUUdgrmG7v8S4EW/yoFY7yrdWzSp9BUsjrBqKIRw+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637794485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=33e828wB9dEjeifz4XOcX4tXiHJV404Ri36l36adBdc=;
        b=mA9Ro9+xZCYf8cq+L5iHAjp5rtiwfJn3ClnLyxZNu70rRhIHMx8CyC3LbEXLTKodK5/j7L
        0IJbIbc/zuN/RbDA==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] cpu/hotplug: Allow the CPU in CPU_UP_PREPARE state to
 be brought up again.
In-Reply-To: <20211122154714.xaoxok3fpk5bgznz@linutronix.de>
References: <20211122154714.xaoxok3fpk5bgznz@linutronix.de>
Date:   Wed, 24 Nov 2021 23:54:44 +0100
Message-ID: <87y25djhaj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22 2021 at 16:47, Sebastian Andrzej Siewior wrote:
> From: "Longpeng(Mike)" <longpeng2@huawei.com>
>
> A CPU will not show up in virtualized environment which includes an
> Enclave. The VM splits its resources into a primary VM and a Enclave
> VM. While the Enclave is active, the hypervisor will ignore all requests
> to bring up a CPU and this CPU will remain in CPU_UP_PREPARE state.
> The kernel will wait up to ten seconds for CPU to show up
> (do_boot_cpu()) and then rollback the hotplug state back to
> CPUHP_OFFLINE leaving the CPU state in CPU_UP_PREPARE. The CPU state is
> set back to CPUHP_TEARDOWN_CPU during the CPU_POST_DEAD stage.
>
> After the Enclave VM terminates, the primary VM can bring up the CPU
> again.
>
> Allow to bring up the CPU if it is in the CPU_UP_PREPARE state.
>
> [bigeasy: Rewrite commit description.]
>
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Link: https://lore.kernel.org/r/20210901051143.2752-1-longpeng2@huawei.com
> ---
>
> For XEN: this changes the behaviour as it allows to invoke
> cpu_initialize_context() again should it have have earlier. I *think*
> this is okay and would to bring up the CPU again should the memory
> allocation in cpu_initialize_context() fail.

Any comment from XEN folks?

Thanks,

        tglx
