Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62EF3ECE97
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 08:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhHPGZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 02:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbhHPGY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 02:24:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93967C061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 23:24:25 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so30746477pjr.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 23:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=23pZdDZvayZfho6lEg24byBzL5clbVqj1eN+MVW+fDA=;
        b=tWu+9GYLUX7sA15K9OMss48Xysc3lLH/dxhPkn9HvOhOEzGuS23A6p6C0TZiNU+rOV
         rXAZXBmlVwY7CTW4cdkZEuqLwEhY3sMpkLBdMwhPlyF3kOr9SgX6zwWGT/pGFLZi0zAC
         Bj4T6cldi0UDd5PKFo4TSXyzlfCd989tLkWPSB+nswV6IDLGkj/h7j51GSJaqSJW4zXj
         8qWCpiSmVD905N8k7bCw0LzHRJ6ciQXd9LHRfb5uRjV8Muk36IWtuew9GYfvNMK1m6dL
         GqnBv0+MSJBn2xx10nUjDydPkFqLa4OXD63Geta4L+zcsoVfzjH8KRDTvwT/qcG9+/hL
         Sizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=23pZdDZvayZfho6lEg24byBzL5clbVqj1eN+MVW+fDA=;
        b=sYTguGC/X3m28Zh0c9WFx3p8TCmE2WIO7Bq10IHWhWD+kfA0TDWa6RByQ1SpI5kN7p
         dGNLcp9NYFo5k6Pq9YsUpcJl87MjEhctDVyScCxsFAD3tSnvkjPZetJMS+vAVdUZzgSN
         dArsK65rM4yq/7yw7yRIxLoJdwoH4wUS4sm0qAMLogGGhtd7/wZqBsL3lS3J4DGKpbvQ
         coLl9RFdzuyDfyhwDezspmWC5Dds7J7ZnYcXciRtIwjZjE+mVDHHqOArQ1xTTl8Xpjnf
         xVVnZc3o/qKV2+ENC56wfxjjmMB6JVg2/mePL5TPTKwT3tpdb5XLzfFavuiQX+uRfmLr
         7Njg==
X-Gm-Message-State: AOAM5309NkPzfuxc6hpvdkwK2ibLAiFvjVPagX5ElbUQE3xhoOrqMWQx
        JOc1DZD0KiaAirVrNhHl/yI=
X-Google-Smtp-Source: ABdhPJzVAIJ31lpj7u5UPVpJBogp1VYtKi8dYeVvFvYl4YX++6DL2/CZUT9rmqfnDARCiomG0WSojQ==
X-Received: by 2002:a63:f749:: with SMTP id f9mr14654432pgk.77.1629095065068;
        Sun, 15 Aug 2021 23:24:25 -0700 (PDT)
Received: from [10.252.0.31] (ec2-18-183-84-255.ap-northeast-1.compute.amazonaws.com. [18.183.84.255])
        by smtp.gmail.com with ESMTPSA id x19sm10051269pfa.104.2021.08.15.23.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Aug 2021 23:24:24 -0700 (PDT)
Cc:     akira.tsukamoto@gmail.com
Subject: Re: [PATCH 0/1] __asm_copy_to-from_user: Reduce more byte_copy
To:     Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <65f08f01-d4ce-75c2-030b-f8759003e061@gmail.com>
 <a70451d1-57ad-6b49-24c1-6408ef94a959@gmail.com>
 <61187c37.1c69fb81.ed9bd.cc45SMTPIN_ADDED_BROKEN@mx.google.com>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <a85be25a-3a67-2baa-531d-98fa4f292f30@gmail.com>
Date:   Mon, 16 Aug 2021 15:24:20 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <61187c37.1c69fb81.ed9bd.cc45SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qiu,

On 8/15/2021 11:30 AM, Qiu Wenbo wrote:
> Hi Akira,
> 
> 
> This patch breaks my userspace  and I can't boot my system after applying this. Here is the stack trace:
> 
> 
> [   10.349080] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [   10.357116] Oops [#15]
> [   10.359433] CPU: 2 PID: 169 Comm: (networkd) Tainted: G D           5.14.0-rc5 #53
> [   10.367422] Hardware name: SiFive HiFive Unmatched A00 (DT)
> [   10.372981] epc : __asm_copy_from_user+0x48/0xf0
> [   10.377584]  ra : _copy_from_user+0x28/0x68
> [   10.381754] epc : ffffffff8099a280 ra : ffffffff803614a8 sp : ffffffd00416bd90
> [   10.388963]  gp : ffffffff811ee540 tp : ffffffe0841b3680 t0 : ffffffd00416bde0
> [   10.396172]  t1 : ffffffd00416bdd8 t2 : 0000003ff09ca3a0 s0 : ffffffd00416bdc0
> [   10.403381]  s1 : 0000000000000000 a0 : ffffffd00416bdd8 a1 : 0000000000000000
> [   10.410590]  a2 : 0000000000000010 a3 : 0000000000000040 a4 : ffffffd00416be18
> [   10.417800]  a5 : 0000003ffffffff0 a6 : 000000000000000f a7 : ffffffe085d58540
> [   10.425009]  s2 : 0000000000000010 s3 : ffffffd00416bdd8 s4 : 0000000000000002
> [   10.432218]  s5 : 0000000000000000 s6 : 0000000000000000 s7 : ffffffe0841b3680
> [   10.439427]  s8 : 0000002aad788040 s9 : 0000000000000000 s10: 0000000000000001
> [   10.446636]  s11: 0000000000000000 t3 : 0000000000000000 t4 : 0000000000000001
> [   10.453845]  t5 : 0000000000000010 t6 : 0000000000040000
> [   10.459144] status: 0000000200040120 badaddr: 0000000000000000 cause: 000000000000000d
> [   10.467049] [<ffffffff8099a280>] __asm_copy_from_user+0x48/0xf0
> [   10.472955] [<ffffffff8009a562>] do_seccomp+0x62/0x8be
> [   10.478079] [<ffffffff8009af58>] prctl_set_seccomp+0x24/0x32
> [   10.483725] [<ffffffff80020756>] sys_prctl+0xf6/0x450
> [   10.488763] [<ffffffff800034f2>] ret_from_syscall+0x0/0x2
> 
> 
> The PC register points to this line:
> 
> +1:
> +    REG_L    a5, 0(a1)

Thanks for testing! Do you mind teaching me how to reproduce the error?

Akira
