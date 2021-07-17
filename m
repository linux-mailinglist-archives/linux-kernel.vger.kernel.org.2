Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409D43CC0B7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 04:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhGQC1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 22:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhGQC1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 22:27:12 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5C2AC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 19:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=JtLTl9T0wG9pndopfAX2sGRznNc3Jk0+HP
        K4G+ituY8=; b=ROVKHEv6clDWqcKEd5XYiWKePTPl6Ekc+pb/s6gH0HpBFPFqF0
        gMfmeJjCqbitlbKZsnhzPFnrqFBgIbaPlP338cCs/Fa48e4enpaIPZ14CTd6kSvv
        8vW1+9Pmx6BkCN5lEbtxroJX+s22L3PQbQm73NTRXkxQZ+aopcU8V8aR4=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygDX3hY_P_Jg76J+AA--.90S2;
        Sat, 17 Jul 2021 10:23:59 +0800 (CST)
Date:   Sat, 17 Jul 2021 10:18:05 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Tong Tiangen <tongtiangen@huawei.com>, <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v2] riscv: add VMAP_STACK overflow detection
Message-ID: <20210717101805.2afabacb@xhacker>
In-Reply-To: <871r7yz241.fsf@igel.home>
References: <20210621032855.130650-1-tongtiangen@huawei.com>
        <87pmvjtumc.fsf@igel.home>
        <20210716205332.5856df78@xhacker>
        <871r7yz241.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygDX3hY_P_Jg76J+AA--.90S2
X-Coremail-Antispam: 1UD129KBjvdXoW5KF4Dtw1DCry7tFyDKFy8Xwb_yoWxXwb_ZF
        y0kFy7Gr4jvrykZFs3Xws8A3Z8tw42yryq9rWUAF9Fqw42qFya9w4kJF92yFn09as7KFy7
        uryS9wn8Gr129jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbFkYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2Iq
        xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
        106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
        xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7
        xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWU
        JVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7GYLDUUUU
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021 17:53:50 +0200
Andreas Schwab <schwab@linux-m68k.org> wrote:

> On Jul 16 2021, Jisheng Zhang wrote:
> 
> > I can't reproduce the panic error. Mind to share your .config?  
> 
> https://github.com/openSUSE/kernel-source/blob/master/config/riscv64/default
> 
> Andreas.
> 

Looks a bit strange. With the above .config, I still can't reproduce the panic
either by

cat /proc/PID/wchan

or

cat /proc/PID/stat

I use the latest linus tree w/o any patch. I noticed that some SUSE_* config
in the .config file, is it possible that you applied some patches? If so,
can you please try the lasest linus tree w/o any patch?

Thanks

