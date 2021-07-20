Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE9E3CFC63
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 16:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240333AbhGTNys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 09:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240190AbhGTNkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 09:40:32 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C34AC06127E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 07:19:10 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id w194so24667264oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 07:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PECglYF/astRcKoQBZXfhQKHo7bG9nuGojwlhCAqJRU=;
        b=qt1vmHgZVFIUb8yUuAVuL/PhwVmkXoN854BTWx/Y1AlEFKokKhG3PP0hwh41sss3I2
         XwgWtgQARV2+Oulw0bjYN91lrBSPiHxXpVR5JlCVV3dBt4K13C87BvAsj9Gowsn/d4eO
         Vxd7/9UQgztMdJkWQUa4xO4si0Ui2d2Dldwe+sawjLvvbPrbkGIgIIehxsobl/pVK8s+
         vLHhdudHD46CGhPjzNFj+VdVJNBxxTAxAADlvBPY4WyOfsyfT7qvkZBMIBOBaaCR6R4a
         7250uMRZIYIqa1rU+9VJw47+NWDNeozFJNcgw6Fqvil85MGpFvhzLrOKOqD4f7w6Y7Wv
         x0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PECglYF/astRcKoQBZXfhQKHo7bG9nuGojwlhCAqJRU=;
        b=tUAYCjYy4iVolkSJ7EN0oGMXhey0XC9+OMmbWZ/Pf/0ePuV48PpC6Agypd6foAuc6o
         33q9o7Niuf6pDi09/fGSe9DN9rYxAL0pfEjfmqvwyhn9mxPRdeNkNM8J3bGb/J+Mn1vN
         YcdYxgPUSvB5KLPMRMlx+RCk30P/ggi44kdJvEwdSwXWxKaKZPeZ4fhonNlj4SsIMJ7j
         GQgXIw+7+DNNG4/dAB6HKlF8oYSJ9ANFamcshnI52y/ISHfD8sPLOJ4SFHj1FPmxKCev
         8ZarGSaivfQol5yA/35IwSnwp2owcHpq4wG27oHl1wA9QSLSFDqb8GQNNAL1CtlHdTHb
         RUJA==
X-Gm-Message-State: AOAM5309Xpn2zhowryENu3lGdx00QnPQx1zcQsnpYL/yVyFLr/EXfV0t
        F2Hv/bpn4W0pOicA6XvqActuhKP/GX4=
X-Google-Smtp-Source: ABdhPJwu8aSoT9Mdp5g5vQ2PkmuBoMKhlk/w73xNxxWWVcIwn8J40C//O1BZUjsxmD9Gv1GWNh2RiA==
X-Received: by 2002:aca:3987:: with SMTP id g129mr25172490oia.161.1626790749044;
        Tue, 20 Jul 2021 07:19:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j30sm4253284otc.43.2021.07.20.07.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 07:19:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <37097718-c472-025a-2058-55667badc5b9@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 0/4] __asm_copy_to-from_user: Fixes
Message-ID: <e959d084-ac32-7d39-41b8-151c2430db76@roeck-us.net>
Date:   Tue, 20 Jul 2021 07:19:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <37097718-c472-025a-2058-55667badc5b9@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/21 1:49 AM, Akira Tsukamoto wrote:
> These are series for the fix reported by Guenter, Geert and Qiu.
> 
> One patch to fix overrun memory access, one patch to fix on rv32.
> And two more for clean up and typos.
> 
> Have tested on qemu rv32, qemu rv64 and beaglev beta board.
> 
> Thanks for the report and instructions to reproduce the error on rv32.
> 
> Akira
> 
> Akira Tsukamoto (4):
>    riscv: __asm_copy_to-from_user: Fix: overrun copy
>    riscv: __asm_copy_to-from_user: Fix: fail on RV32
>    riscv: __asm_copy_to-from_user: Remove unnecessary size check
>    riscv: __asm_copy_to-from_user: Fix: Typos in comments
> 
>   arch/riscv/lib/uaccess.S | 27 +++++++++++++--------------
>   1 file changed, 13 insertions(+), 14 deletions(-)
> 

For the series:

Tested-by: Guenter Roeck <linux@roeck-us.net>

Tested with qemu for both riscv32 and riscv64.

Thanks!

Guenter
