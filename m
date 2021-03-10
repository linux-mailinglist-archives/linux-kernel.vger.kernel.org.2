Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770C63333CF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 04:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhCJDX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 22:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhCJDXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 22:23:47 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2580BC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 19:23:36 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id ha17so17945pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 19:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=DWyTUhvwk7T3icFRK4BtJnm+zs8Gs2hcwj9A3iJOz3A=;
        b=0GxaKgJsaTDDVtT034u0SRTqHS4k1CmbhQlB6ba3wW99r8ttLytrR9yDeILChO7yPo
         C6lCvpOrfsJiKx4QQTce7HO3LHkzgGG8xdFuRzZKoBCT/LVj3A7wP45OyYAEKMCrZjKa
         ifr5w1AadvudERIFmEnhErWJj66HHhQeIcz1bS7yuFYhDQ1s6Ur1/H23t74pczW1LlqC
         K4O/66GhTsnDXROeVJQhxO/9uJaOTZaq06CPbHBVelI4oZ4mUf3vyasiyBtNKu59uX1e
         dTooqNokOUyLLwjTNDHBDj9aJunIGw/V76ydWL+z3AATtgLw0CKvggO7Qkn+odHgxwyX
         PuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=DWyTUhvwk7T3icFRK4BtJnm+zs8Gs2hcwj9A3iJOz3A=;
        b=YKUcBgMpOGsZMrvFDmVIj/MdX7fqbrr5CKNSEvFBnn0cujhWTtBu2KTeS7UwzWUr7H
         YU7acqkr/TMI37tFE3SX9OeB7oP3+1B8oS6gnt74xZDIUki5G6BTCAzDuB1YMEIpYqN5
         RaGt589q+3gb1n9TJYRre4/asNyI3gXJFF2BAggiFefSaqNtKkBMgPYqo0VzwNT7f7T0
         GI5uz1VPFw5XCUBnwUKs86ltx72+ZA46NJcmG9w0pUjUKeIpMr9und5GD73MG9+JbVxh
         YuDHkeqjbnxF7Npy1vYt//u6MsBuJSCg3U0YfcYOkc3HTjTZ6lbBoZlCK89iTX/xS77D
         3f2g==
X-Gm-Message-State: AOAM530cIsJvxVlmeowNsRoBYWWijIBOvADWY70v5bI38QnoduV5MuET
        SVcEE/QmJr+tXlQEJ5Nt/HbtoA==
X-Google-Smtp-Source: ABdhPJy9QLWAguT1HYxJMNMcPIK9TGvBSO8t+XA+FMHO6VEo5lC0BX+oBGKtR9k6KYsLiRnC9WajHA==
X-Received: by 2002:a17:90b:fce:: with SMTP id gd14mr1246512pjb.64.1615346615567;
        Tue, 09 Mar 2021 19:23:35 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id k15sm8430751pgt.23.2021.03.09.19.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 19:23:34 -0800 (PST)
Date:   Tue, 09 Mar 2021 19:23:34 -0800 (PST)
X-Google-Original-Date: Tue, 09 Mar 2021 19:22:05 PST (-0800)
Subject:     Re: [PATCH 1/1] RISC-V: correct enum sbi_ext_rfence_fid
In-Reply-To: <CAOnJCULZFHPPXhL5ZyH9qNfb5BgUHos1PU2q6Khb7uT=N-7a3w@mail.gmail.com>
CC:     anup@brainfault.org, xypron.glpk@gmx.de,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>, wangkefeng.wang@huawei.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        seanga2@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     atishp@atishpatra.org
Message-ID: <mhng-559b7914-90be-4626-9f00-487e35289eac@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Mar 2021 11:28:39 PST (-0800), atishp@atishpatra.org wrote:
> On Mon, Mar 8, 2021 at 2:55 AM Anup Patel <anup@brainfault.org> wrote:
>>
>> On Mon, Mar 8, 2021 at 1:19 PM Atish Patra <atishp@atishpatra.org> wrote:
>> >
>> > On Sat, Mar 6, 2021 at 4:12 AM Anup Patel <anup@brainfault.org> wrote:
>> > >
>> > > On Sat, Mar 6, 2021 at 11:19 AM Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>> > > >
>> > > > The constants in enum sbi_ext_rfence_fid should match the SBI
>> > > > specification. See
>> > > > https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc#78-function-listing
>> > > >
>> > > > | Function Name               | FID | EID
>> > > > | sbi_remote_fence_i          |   0 | 0x52464E43
>> > > > | sbi_remote_sfence_vma       |   1 | 0x52464E43
>> > > > | sbi_remote_sfence_vma_asid  |   2 | 0x52464E43
>> > > > | sbi_remote_hfence_gvma_vmid |   3 | 0x52464E43
>> > > > | sbi_remote_hfence_gvma      |   4 | 0x52464E43
>> > > > | sbi_remote_hfence_vvma_asid |   5 | 0x52464E43
>> > > > | sbi_remote_hfence_vvma      |   6 | 0x52464E43
>> > > >
>> > > > Fixes: ecbacc2a3efd ("RISC-V: Add SBI v0.2 extension definitions")
>> > > > Reported-by: Sean Anderson <seanga2@gmail.com>
>> > > > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> > >
>
> Reviewed-by: Atish Patra <atish.patra@wdc.com>
>
>> > > Good catch.
>> > >
>> > > I guess we never saw any issues because these calls are only used by
>> > > KVM RISC-V which is not merged yet. Further for KVM RISC-V, the HFENCE
>> > > instruction is emulated as flush everything on FPGA, QEMU, and Spike so
>> > > we did not notice any issue with KVM RISC-V too.
>> > >
>> >
>> > OpenSBI & Xvisor also define the same order as Linux kernel. The
>> > existing order(in Linux kernel)
>> > makes more sense w.r.to Lexicographic order as well.
>> >
>> > Should we just fix the spec instead ?
>>
>> I would not recommend that because RFENCE is part of the released SBI v0.2 spec.
>>
>
> Fair enough.

Yes, agreed.  It's very important that we don't change the specs we said are 
frozen, that would be a huge mess.

This is on fixes.

Thanks!

>
>> We have to be more careful in software to follow the spec correctly.
>>
>
> Agreed. Apologies for the slip up.
>
>> Regards,
>> Anup
>>
>> >
>> > > Looks good to me.
>> > >
>> > > Reviewed-by: Anup Patel <anup@brainfault.org>
>> > >
>> > > Regards,
>> > > Anup
>> > >
>> > > > ---
>> > > >  arch/riscv/include/asm/sbi.h | 4 ++--
>> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
>> > > >
>> > > > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
>> > > > index 99895d9c3bdd..d7027411dde8 100644
>> > > > --- a/arch/riscv/include/asm/sbi.h
>> > > > +++ b/arch/riscv/include/asm/sbi.h
>> > > > @@ -51,10 +51,10 @@ enum sbi_ext_rfence_fid {
>> > > >         SBI_EXT_RFENCE_REMOTE_FENCE_I = 0,
>> > > >         SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
>> > > >         SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
>> > > > -       SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
>> > > >         SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID,
>> > > > -       SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
>> > > > +       SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
>> > > >         SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
>> > > > +       SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
>> > > >  };
>> > > >
>> > > >  enum sbi_ext_hsm_fid {
>> > > > --
>> > > > 2.30.1
>> > > >
>> > > >
>> > > > _______________________________________________
>> > > > linux-riscv mailing list
>> > > > linux-riscv@lists.infradead.org
>> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
>> > >
>> > > _______________________________________________
>> > > linux-riscv mailing list
>> > > linux-riscv@lists.infradead.org
>> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
>> >
>> >
>> >
>> > --
>> > Regards,
>> > Atish
