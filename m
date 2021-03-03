Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBDF32BA7D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 21:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357710AbhCCLYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:24:02 -0500
Received: from mail.loongson.cn ([114.242.206.163]:49786 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240149AbhCCCQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 21:16:06 -0500
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxmdT_6z5gCpkTAA--.24602S3;
        Wed, 03 Mar 2021 09:53:04 +0800 (CST)
Subject: Re: [PATCH] riscv: Return -EFAULT if copy_to_user() failed in
 signal.c
To:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <1614670097-28536-1-git-send-email-yangtiezhu@loongson.cn>
 <aa84cddb-9c04-3bad-49de-2fb3056ec44a@codethink.co.uk>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <07aa690f-b37d-7d91-414f-f5dfda98a868@loongson.cn>
Date:   Wed, 3 Mar 2021 09:53:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <aa84cddb-9c04-3bad-49de-2fb3056ec44a@codethink.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9AxmdT_6z5gCpkTAA--.24602S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWr4Dur1xurW8CrWrKrW7Jwb_yoWrKrW5pF
        4UCa4akrW7Jrn2vF92vw1rua4rArn3tFy8Kr90k3WfAFs0qr45K34kta4jgF4rJry8Ca1v
        kFyqkry5Can8WrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JV
        WxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
        8wCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
        vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyT
        uYvjxUgGNtDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2021 06:01 PM, Ben Dooks wrote:
> On 02/03/2021 07:28, Tiezhu Yang wrote:
>> copy_to_user() returns the amount left to copy, it should return -EFAULT
>> if copy to user failed.
>
> This looks technically correct, but the caller (only one)
> will check for non-zero and will covert that to -EFAULT
> in setup_rt_frame().

Yes, as you said, the original code logic has no problem, it will covert
that to -EFAULT in setup_rt_frame().

The initial aim of this patch is to make save_fp_state() return error code
if __copy_to_user() failed, just like it returns -EFAULT if __put_user() 
failed.

I notice that restore_fp_state() has similar issue, it will return -EFAULT
if __get_user() failed and maybe return -EINVAL in the other error case,
both -EFAULT and -EINVAL are error code, but when __copy_from_user() failed,
it does not return an error code, which seems not so consistent.

>
> I expect if this change is done, it also needs to be done
> for the callers too and there's a few others than assume
> !=0 is an error.
>
> I think it would be easier to define save_fp_state() to
> return non-zero on error and note it does not return an
> error code. It may be worth exiting the functio nif
> the first __copy_to_user fails?

Now,
(1) is it necessary to do some changes? If yes, I will send v2 later.
Like this:

[PATCH v2] riscv: Return -EFAULT if copy_{to,from}_user() failed in
  signal.c

copy_{to,from}_user() returns the amount left to copy, it should return
-EFAULT error code if copy {to,from} user failed, just like the return
value is an error code when {put,get}_user() failed, this is to make the
return value consistent, no function change.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
  arch/riscv/kernel/signal.c | 12 ++++++++++--
  1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 65942b3..c76d877 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -39,7 +39,7 @@ static long restore_fp_state(struct pt_regs *regs,

      err = __copy_from_user(&current->thread.fstate, state, 
sizeof(*state));
      if (unlikely(err))
-        return err;
+        return -EFAULT;

      fstate_restore(current, regs);

@@ -67,7 +67,7 @@ static long save_fp_state(struct pt_regs *regs,
      fstate_save(current, regs);
      err = __copy_to_user(state, &current->thread.fstate, sizeof(*state));
      if (unlikely(err))
-        return err;
+        return -EFAULT;

      /* We support no other extension state at this time. */
      for (i = 0; i < ARRAY_SIZE(sc_fpregs->q.reserved); i++) {
@@ -87,8 +87,12 @@ static long restore_sigcontext(struct pt_regs *regs,
      struct sigcontext __user *sc)
  {
      long err;
+
      /* sc_regs is structured the same as the start of pt_regs */
      err = __copy_from_user(regs, &sc->sc_regs, sizeof(sc->sc_regs));
+    if (unlikely(err))
+        return -EFAULT;
+
      /* Restore the floating-point state. */
      if (has_fpu)
          err |= restore_fp_state(regs, &sc->sc_fpregs);
@@ -140,8 +144,12 @@ static long setup_sigcontext(struct rt_sigframe 
__user *frame,
  {
      struct sigcontext __user *sc = &frame->uc.uc_mcontext;
      long err;
+
      /* sc_regs is structured the same as the start of pt_regs */
      err = __copy_to_user(&sc->sc_regs, regs, sizeof(sc->sc_regs));
+    if (unlikely(err))
+        return -EFAULT;
+
      /* Save the floating-point state. */
      if (has_fpu)
          err |= save_fp_state(regs, &sc->sc_fpregs);
-- 
2.1.0

(2) or just leave it as it is and ignore this patch?

Thanks,
Tiezhu

>
> Note: setup_rt_frame -> setup_sigcontext -> save_fp_frame
>
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   arch/riscv/kernel/signal.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
>> index 65942b3..2238fc5 100644
>> --- a/arch/riscv/kernel/signal.c
>> +++ b/arch/riscv/kernel/signal.c
>> @@ -67,7 +67,7 @@ static long save_fp_state(struct pt_regs *regs,
>>       fstate_save(current, regs);
>>       err = __copy_to_user(state, &current->thread.fstate, 
>> sizeof(*state));
>>       if (unlikely(err))
>> -        return err;
>> +        return -EFAULT;
>>         /* We support no other extension state at this time. */
>>       for (i = 0; i < ARRAY_SIZE(sc_fpregs->q.reserved); i++) {
>> @@ -140,8 +140,12 @@ static long setup_sigcontext(struct rt_sigframe 
>> __user *frame,
>>   {
>>       struct sigcontext __user *sc = &frame->uc.uc_mcontext;
>>       long err;
>> +
>>       /* sc_regs is structured the same as the start of pt_regs */
>>       err = __copy_to_user(&sc->sc_regs, regs, sizeof(sc->sc_regs));
>> +    if (unlikely(err))
>> +        return -EFAULT;
>> +
>>       /* Save the floating-point state. */
>>       if (has_fpu)
>>           err |= save_fp_state(regs, &sc->sc_fpregs);
>>
>
>

