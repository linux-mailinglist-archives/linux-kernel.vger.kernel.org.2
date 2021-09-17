Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCE340FA17
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhIQOWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 10:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhIQOWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:22:39 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 158F1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 07:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=eNWjUOhlNPYKaMAtioES/rG0dxTk7gZ+ai
        70R1grEPw=; b=fLx9paXp1EWnCFjjfADFUp/Af7IqNSE21ZEidBrrWrsDe8Tmw7
        DOvqEG/jWmU7AGjCRsosyasr6Gvgm6j2LYYU+sNw9Pn+CV4ATyj6ky9JAewUH0LL
        oWxrA1Xn1kXdDYTBG5yhHKgOrURckiHFwT6nESH0KMoywASc6ZFgz2iUE=
Received: from xhacker (unknown [101.86.20.138])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygBXW4dSpERh3mcRAA--.2969S2;
        Fri, 17 Sep 2021 22:21:06 +0800 (CST)
Date:   Fri, 17 Sep 2021 22:14:29 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Chen Huang <chenhuang5@huawei.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Darius Rad <darius@bluespec.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] riscv: improve unaligned memory accesses
Message-ID: <20210917221429.4d3a15ca@xhacker>
In-Reply-To: <20210916130855.4054926-1-chenhuang5@huawei.com>
References: <20210916130855.4054926-1-chenhuang5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygBXW4dSpERh3mcRAA--.2969S2
X-Coremail-Antispam: 1UD129KBjvJXoWrKr1xAw1fWw4kKr47Jw13Arb_yoW8JrW8pa
        1UCFnxurWFgrn7KF93Jwn3uF15Z3yfGF47JrW2ya4Uur1YvFy7WrWjq3WDG3srXrn7C34D
        GrsavFnrua43Z3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUy2b7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s02
        6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
        I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
        6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
        0_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j
        6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j189NUUUUU=
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 13:08:53 +0000
Chen Huang <chenhuang5@huawei.com> wrote:

> The patchset improves RISCV unaligned memory accesses, selects
> HAVE_EFFICIENT_UNALIGNED_ACCESS if CPU_HAS_NO_UNALIGNED not
> enabled and supports DCACHE_WORD_ACCESS to improve the efficiency
> of unaligned memory accesses.
> 
> If CPU don't support unaligned memory accesses for now, please
> select CONFIG_CPU_HAS_NO_UNALIGNED. For I don't know which CPU
> don't support unaligned memory accesses, I don't choose the
> CONFIG for them.

This will break unified kernel Image for riscv. Obviously, we will have
two images for efficient unaligned access platforms and non-efficient
unaligned access platforms. IMHO, we may need alternative mechanism or
something else to dynamically enable related code path.

Regards

> 
> Changes since v1:
>  - As Darius Rad and Jisheng Zhang mentioned, some CPUs don't support
>    unaligned memory accesses, add an option for CPUs to choose it or not.
> 
> Chen Huang (2):
>   riscv: support HAVE_EFFICIENT_UNALIGNED_ACCESS
>   riscv: Support DCACHE_WORD_ACCESS
> 
>  arch/riscv/Kconfig                      |  5 ++++
>  arch/riscv/include/asm/word-at-a-time.h | 37 +++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
> 


