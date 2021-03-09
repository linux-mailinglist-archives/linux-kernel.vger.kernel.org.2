Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F179332427
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 12:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhCILet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 06:34:49 -0500
Received: from mout.gmx.net ([212.227.17.22]:36015 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230063AbhCILeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 06:34:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615289641;
        bh=+Rq5elMREdzySNeTCnfCnoul/II8s+/1ZY8B9u2JwYI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WiW00Az+w4AG5yDwZVr/MDJDz3O5YwfjMt3xPEHzdUQ1vmRxj7Q4efPRWpzuzyf49
         NA+L5NAWzh/o+Pz9QPyoD+IFOFkEvu49/AuOttkRO71QGZw6Dd2AO7zJ5MunOT1ock
         bZYyKSX4kTWxLpOAxIMmy29bf1J2RxKoub8LJYXE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.70] ([62.143.246.89]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZktj-1lDD7G1YnP-00WjMD; Tue, 09
 Mar 2021 12:34:01 +0100
Subject: Re: [PATCH 1/1] RISC-V: correct enum sbi_ext_rfence_fid
To:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Sean Anderson <seanga2@gmail.com>
References: <20210306054801.18263-1-xypron.glpk@gmx.de>
 <CAAhSdy08=ffPe+fYWX9ds4wNSMU3uzT8OENk0o93xpfZOKtYig@mail.gmail.com>
 <CAOnJCUKSf7tyz+56apVOqxNgnR_eYoidYw5=M2si753t4K71UQ@mail.gmail.com>
 <CAAhSdy0BK9-cG=rQNadbkzDWdXJgpiJ1QEywTgpBxr0NVa7cVQ@mail.gmail.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <c34fafa2-3cde-d74f-b448-3ef05baf63d5@gmx.de>
Date:   Tue, 9 Mar 2021 12:33:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAAhSdy0BK9-cG=rQNadbkzDWdXJgpiJ1QEywTgpBxr0NVa7cVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d7g0B4xGteITVC3jRkv4xU3S5KuM7RCgqYAoHbAmAYWp8rpEZTy
 XWGNNpCTCsmvW92jYunC4mTokIdR56aKzRMUL2bGM4KZLxLPZCZNGvCNcR0nfCiKGEQT2KG
 a/SoDYFNc2fSsH1NKzv6azQGEM6gp30h5kML7/VUK6Lg+had5BobnibTb/K1KUmTecGzc2d
 Gh1ONlIAU+vMtTqYE1tBA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wwQao1SBv3U=:cX5VL1yrC6tDqdH99XRj0y
 K474jWwpBMKfebmhORnDHYs70GDB+G66uR7O/P+pIMBanIomarx4/LD79/z4LKnnsEn/CUq2c
 frnEY4zZiZ5BoOCx7ffQm5E+q4vjXPCLHDZsXIVzS9EyvA3/jY+uuy3OpG8gNviVOy/H/e5be
 XRH/rWJ5YaFTZsm0gCX3KqFWC/c3sKl4WBf4RGo0t0/PV+Vc19P4AHLEpA0tYeUTX7qz8DpNy
 1mmD5uejaQOyV5qcv9pep2asCR0KBhUpt6t5WjDpxbcSZt0mcsJPZLD9q4mHrhpyoyijyDnlr
 1sfmM0bjiQnwbybc2Qo5BsNlQ+lHIOeHuVCnj60SBZOdiUf8sIAU4+as1FvQ6mozQJiNv8KTb
 IvaW2D00lEnwFRAKMjPIPMNLtf7FsF9Wa5Qa2FsEtynWT6Hv8NE0t87K7VG1FrseqDWFpvjEr
 R1AtjKxK9tVzaka/R6SBiroiLYwX4jOfSO4S/tIqS8zM3R9UVBM4uyTfcDUEZa00a6VTKn9/m
 SO7sIKnDfm+uXuFcSWFsd0EBWRfF6OT4Qy/87jFVon6FQlbu6HrL93oPhjba1BHpI3CPS7aoF
 7Br64wUcOhqYFua36GQUnjXdrHZgeU7n2+R0LLYbhWbtpwGqh0GHwvatZz/fj2eoJhN3CH5sr
 9VPYXdI8kz1w9s0WG+O16Ko/1IlET1CnWl49frwSNw6kBO+FPYXr0RGMw8FmAGlOL+H6QebNo
 xkkz6nOCKC9ugVTXippbMc7FHLcS+w+6NPF5p7C2GXsMc6FX4Hsa5Q56v8lOgRId/TNxa1nFq
 ZdQ4cJqOiaXnnxDApSbkd74GaugJXa/K2LaGyfG+fxZDmGxH94iFrp6UrTx4PbpM4oqH7Qk0b
 t9qseokexfQe7tXfUkqg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.03.21 11:55, Anup Patel wrote:
> On Mon, Mar 8, 2021 at 1:19 PM Atish Patra <atishp@atishpatra.org> wrote=
:
>>
>> On Sat, Mar 6, 2021 at 4:12 AM Anup Patel <anup@brainfault.org> wrote:
>>>
>>> On Sat, Mar 6, 2021 at 11:19 AM Heinrich Schuchardt <xypron.glpk@gmx.d=
e> wrote:
>>>>
>>>> The constants in enum sbi_ext_rfence_fid should match the SBI
>>>> specification. See
>>>> https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc#78-=
function-listing
>>>>
>>>> | Function Name               | FID | EID
>>>> | sbi_remote_fence_i          |   0 | 0x52464E43
>>>> | sbi_remote_sfence_vma       |   1 | 0x52464E43
>>>> | sbi_remote_sfence_vma_asid  |   2 | 0x52464E43
>>>> | sbi_remote_hfence_gvma_vmid |   3 | 0x52464E43
>>>> | sbi_remote_hfence_gvma      |   4 | 0x52464E43
>>>> | sbi_remote_hfence_vvma_asid |   5 | 0x52464E43
>>>> | sbi_remote_hfence_vvma      |   6 | 0x52464E43
>>>>
>>>> Fixes: ecbacc2a3efd ("RISC-V: Add SBI v0.2 extension definitions")
>>>> Reported-by: Sean Anderson <seanga2@gmail.com>
>>>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>>
>>> Good catch.
>>>
>>> I guess we never saw any issues because these calls are only used by
>>> KVM RISC-V which is not merged yet. Further for KVM RISC-V, the HFENCE
>>> instruction is emulated as flush everything on FPGA, QEMU, and Spike s=
o
>>> we did not notice any issue with KVM RISC-V too.
>>>
>>
>> OpenSBI & Xvisor also define the same order as Linux kernel. The
>> existing order(in Linux kernel)
>> makes more sense w.r.to Lexicographic order as well.

Here is the OpenSBI correction:

[PATCH 1/1] include: sbi: SBI function IDs for RFENCE extension
http://lists.infradead.org/pipermail/opensbi/2021-March/000703.html

Best regards

Heinrich

>>
>> Should we just fix the spec instead ?
>
> I would not recommend that because RFENCE is part of the released SBI v0=
.2 spec.
>
> We have to be more careful in software to follow the spec correctly.
>
> Regards,
> Anup
>
>>
>>> Looks good to me.
>>>
>>> Reviewed-by: Anup Patel <anup@brainfault.org>
>>>
>>> Regards,
>>> Anup
>>>
>>>> ---
>>>>  arch/riscv/include/asm/sbi.h | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sb=
i.h
>>>> index 99895d9c3bdd..d7027411dde8 100644
>>>> --- a/arch/riscv/include/asm/sbi.h
>>>> +++ b/arch/riscv/include/asm/sbi.h
>>>> @@ -51,10 +51,10 @@ enum sbi_ext_rfence_fid {
>>>>         SBI_EXT_RFENCE_REMOTE_FENCE_I =3D 0,
>>>>         SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
>>>>         SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
>>>> -       SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
>>>>         SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID,
>>>> -       SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
>>>> +       SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
>>>>         SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
>>>> +       SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
>>>>  };
>>>>
>>>>  enum sbi_ext_hsm_fid {
>>>> --
>>>> 2.30.1
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-riscv mailing list
>>>> linux-riscv@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>
>>
>>
>> --
>> Regards,
>> Atish

