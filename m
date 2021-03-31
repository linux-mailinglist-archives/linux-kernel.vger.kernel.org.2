Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9101350232
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 16:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbhCaO2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 10:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbhCaO2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 10:28:16 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50314C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 07:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=/USMBB5tdJb798E3Ew+mE5e8OfVTFhQ2z3
        foDoJoUxw=; b=V03ymP6pvnQl1qX46eZ14aIGakYtv+5IJZNJFW6EIktV+S3RsY
        VleDki0NiBju0UdGeqd3BUNwj1vMSZ8Gq0TkabCTbxr1jUaIbdASKkZOj/YxNUbp
        eKBkCS8WNWB+xOEEHI+lg3cbEOuZ5/+JF6q4AXlovSfZq1OCftnYMSBXg=
Received: from xhacker (unknown [101.86.19.180])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCXOpnohmRg0xh6AA--.15607S2;
        Wed, 31 Mar 2021 22:27:53 +0800 (CST)
Date:   Wed, 31 Mar 2021 22:22:44 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Guo Ren <guoren@linux.alibaba.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: keep interrupts disabled for BREAKPOINT
 exception
Message-ID: <20210331222244.45a5807c@xhacker>
In-Reply-To: <20210330183316.942215efe8e6e8455ad14113@kernel.org>
References: <20210330021624.2b776386@xhacker>
        <20210330183316.942215efe8e6e8455ad14113@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygCXOpnohmRg0xh6AA--.15607S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFWrGryrJF1kAry8Aw1rCrg_yoWDWrg_Ww
        1jvrZxG3yYyr4Ikan2qrn7ArZF9r17WFWxXw1fKFWDKa4Ut3yYqFsavFy5JrZ7tF4ftFZx
        uFy7XrZ0qry7WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbrAYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        W3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
        JbIYCTnIWIevJa73UjIFyTuYvjxU2rcTDUUUU
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 18:33:16 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Jisheng,

Hi Masami,

> 
> On Tue, 30 Mar 2021 02:16:24 +0800
> Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:
> 
> > From: Jisheng Zhang <jszhang@kernel.org>
> > 
> > Current riscv's kprobe handlers are run with both preemption and
> > interrupt enabled, this violates kprobe requirements. Fix this issue
> > by keeping interrupts disabled for BREAKPOINT exception.  
> 
> Not only while the breakpoint exception but also until the end of
> the single step (maybe you are using __BUG_INSN_32 ??) need to be
> disable interrupts. Can this do that?
> 

interrupt is disabled during "single step" by kprobes_save_local_irqflag()
and kprobes_restore_local_irqflag(). The code flow looks like: 

do_trap_break()   // for bp
  kprobe_breakpoint_handler()
    setup_singlestep()
      kprobes_restore_local_irqflag()

do_trap_break()  // for ss
  kprobe_single_step_handler()
    kprobes_restore_local_irqflag()

Thanks

