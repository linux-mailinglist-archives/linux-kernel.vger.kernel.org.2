Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E59139C85C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 15:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhFENM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 09:12:58 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:52084
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229902AbhFENM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 09:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Message-ID:Subject:From:To:Cc:
        Date:Content-Type:User-Agent:MIME-Version:
        Content-Transfer-Encoding; bh=g3QK07zmCnj4vGM4RXf/eq2YtB11l6qir1
        FhvSEdfs4=; b=oUYNxiXYrxXLdZzjOIzVkOfWtputiPDDVO8K7Yl6rkTt5/OIqs
        /vvKtUsIXH2X6EC5A3r1rDK0t7IW7mDVEp7WRT4JDGJwBRF0Ft+g4Sv+l/c8GwzO
        CRJeooq/oX1doKrw2xRke4s2x3kDRJQ4gIN0xLUyMFZ/5OtPYCgodT7XI=
Received: from [10.8.0.2] (unknown [222.29.156.242])
        by front01 (Coremail) with SMTP id 5oFpogD32e7Fd7tg9S+aAA--.42184S2;
        Sat, 05 Jun 2021 21:10:30 +0800 (CST)
Message-ID: <b3762e3bc45d77869231271ffe0e259be118ad57.camel@pku.edu.cn>
Subject: arch_set_user_pkey_access only works on the current task_struct
From:   Jiashuo Liang <liangjs@pku.edu.cn>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, Jiashuo Liang <liangjs@pku.edu.cn>
Date:   Sat, 05 Jun 2021 21:10:28 +0800
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: 5oFpogD32e7Fd7tg9S+aAA--.42184S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XF13Wry7WF4xtFy8Jw43KFg_yoW3AFX_ta
        4kKF47tw1Fyrsaqw43Ga13JF97Xw4UGFy8t3y8trW8Kr93Jw4DAFsxAF4xKF45WrnavF98
        G3Z8ZFyxK3ZF9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbx8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        ACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6ry8MxAIw28IcxkI7VAKI48JMxAI
        w28IcVCjz48v1sIEY20_Kr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JU-_-
        PUUUUU=
X-CM-SenderInfo: isqqijqrtqmio6sn3hxhgxhubq/1tbiAwEDBVPy7rxVEQABsy
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am learning the kernel implementation of the x86 PKU feature. I find the
arch_set_user_pkey_access function in arch/x86/kernel/fpu/xstate.c does not
use its first parameter. So it is perhaps a bug?

The arch_set_user_pkey_access function is supposed to set the PKRU register
for the task_struct specified by its first parameter tsk. But it is only
implemented for the current task_struct.

Fortunately, it has been called only with current task_struct in the kernel
code, so it appears to be okay. However, it can introduce bugs in the
future because people may expect it working on other task_struct.

This commit seems to be related: b79daf8589921 ("x86/mm/pkeys: Fix compact
mode by removing protection keys' XSAVE buffer manipulation").

Thank you!
liangjs

