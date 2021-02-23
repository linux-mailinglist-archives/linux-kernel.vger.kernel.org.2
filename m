Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9703223E1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 02:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhBWBw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 20:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbhBWBwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 20:52:51 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCD0C06178C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 17:52:09 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id a4so11391539pgc.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 17:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=i03OoVFIoCd9d7mopy6n9KNFtMtnvCU0u6uw787955A=;
        b=y6VAALqKDBuGX6IlrZ6Nxk+kGeorrzo+X840afRJZXc36kALZMxvq25W1uOf3vcyeK
         aGjJDgjLp0vu+hqBwxDoNR5Gw4JU7+uB31BBFnl0+DJ006zij7hjSi4KKwbELPmeg/dY
         SXuh7OaX/zHR066X7NOoJvDuOjAfcSCcR9nojEOmSbvQE5I4eeOlZKMenre2LHkehA9J
         pxeTL0a98YI8ZoO6Mywqv5B1E/s0XhCdR0aYyJUaj8wdVpIH0tBENZRTees2OVXoddzF
         g1meurMTUdjeLPVSxHw/Fjr7PGYv4yY0uHQYOTY4dOyt4zddrysLW9qiQE24s4P0pxGk
         HzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=i03OoVFIoCd9d7mopy6n9KNFtMtnvCU0u6uw787955A=;
        b=iqe+9BVF7zK3xVcL3llsBp8BrGkLJzXg8PJA4Lg+y/KC9qXkeuVgt2iBMRg4tYhsod
         5u+10rkSTt4Jjy74YyWYilYOBz1AAEXSPTLe7zU2rxjN4KL0UwniCZAVoFX4724T+5uS
         N7qF9sN7wD192NfyDt7ffTadnWDRbkT4IMcJDOtzSEO8wGvQcEoa5uPgF3WuGwF37hCI
         e4T13YsXsdJQcLlDQ8z7VQIEkhgnJiHy34uNxhUaairtjTRlOl0iYW563bAL2lWy5jg9
         xkmOWg/1LoLERkbkk3fsoW9wY9R8OaCWDBxBVE/tJs67ma+dBlIYIPq/Nzuqd5WrF3w6
         VjeQ==
X-Gm-Message-State: AOAM530sD7Uq2AbhNcU2MtMXFGSfQcFlVzeUj/6JEE9l+tE3oSPYYgkP
        suAF5ykRHTFBW/uXgQUubzZD4aBRzHOXlLWz
X-Google-Smtp-Source: ABdhPJwLc46PcHoUqhXBD+1kYH3vYipBu33FF1lWqHnjM7n9MCHjVhWU/v6owMLGkW3Jzy3CNTRWAQ==
X-Received: by 2002:a62:5e02:0:b029:1ed:8bee:6132 with SMTP id s2-20020a625e020000b02901ed8bee6132mr10401303pfb.48.1614045129277;
        Mon, 22 Feb 2021 17:52:09 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id br2sm757366pjb.40.2021.02.22.17.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 17:52:08 -0800 (PST)
Date:   Mon, 22 Feb 2021 17:52:08 -0800 (PST)
X-Google-Original-Date: Mon, 22 Feb 2021 17:52:03 PST (-0800)
Subject:     Re: [PATCH] RISC-V: Add a non-void return for sbi v02 functions
In-Reply-To: <CAOnJCUJq4Gfd_YvJz5K2yFwmsSiB3LDM6rSQ2d+O+jV8b0z_wg@mail.gmail.com>
CC:     linux@roeck-us.net, Atish Patra <Atish.Patra@wdc.com>,
        wangkefeng.wang@huawei.com, aou@eecs.berkeley.edu,
        Anup Patel <Anup.Patel@wdc.com>, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     atishp@atishpatra.org
Message-ID: <mhng-96a8d981-5dff-488d-af25-b3c40815b643@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Feb 2021 14:38:28 PST (-0800), atishp@atishpatra.org wrote:
> On Mon, Feb 22, 2021 at 12:23 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Wed, Feb 03, 2021 at 09:26:43PM -0800, Atish Patra wrote:
>> > SBI v0.2 functions can return an error code from SBI implementation.
>> > We are already processing the SBI error code and coverts it to the Linux
>> > error code.
>> >
>> > Propagate to the error code to the caller as well. As of now, kvm is the
>> > only user of these error codes.
>> >
>> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> > ---
>> ...
>> >  #else /* CONFIG_RISCV_SBI */
>> > -static inline void sbi_remote_fence_i(const unsigned long *hart_mask) {}
>> > +static inline int sbi_remote_fence_i(const unsigned long *hart_mask) {}
>>
>> Error log:
>> In file included from arch/riscv/kernel/setup.c:29:
>> arch/riscv/include/asm/sbi.h: In function 'sbi_remote_fence_i':
>> arch/riscv/include/asm/sbi.h:150:1: error: no return statement in function returning non-void
>>
>
> Sorry for the oversight. The return statement is missing.
>
> @Palmer Dabbelt : Can you fix it in for-next or should I send a v2 ?

I just fixed it up.
