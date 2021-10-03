Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E0D420244
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 17:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhJCPcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 11:32:31 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:52785 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhJCPc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 11:32:29 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MNtjq-1m8nRA29DU-00ODiN for <linux-kernel@vger.kernel.org>; Sun, 03 Oct
 2021 17:30:40 +0200
Received: by mail-wr1-f46.google.com with SMTP id t8so25670134wri.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 08:30:40 -0700 (PDT)
X-Gm-Message-State: AOAM532425xnZ0Hc0oDyKJSiol4yv9UT2rvlQvxP3UZgHFI8leewShj8
        u/YPdVcCjqy0C75Ble8JrK/wpoDZnmNOrilTSQM=
X-Google-Smtp-Source: ABdhPJwJGaMMarFg1ioVjxCZ2/4wMv2JVL+5Fcq22wk7PQqXZw0GCeAokU19zp848kd3HeQyLietiBcO8YZxvzJvNCE=
X-Received: by 2002:adf:f481:: with SMTP id l1mr9039258wro.411.1633275040200;
 Sun, 03 Oct 2021 08:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211003002120.198752-1-palmer@dabbelt.com>
In-Reply-To: <20211003002120.198752-1-palmer@dabbelt.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 3 Oct 2021 17:30:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1rwMWQSmdW4ARkk6swT9VC2Fcx5nBWVugSOuhv8o7QHg@mail.gmail.com>
Message-ID: <CAK8P3a1rwMWQSmdW4ARkk6swT9VC2Fcx5nBWVugSOuhv8o7QHg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Include clone3() on rv32
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Brauner <christian@brauner.io>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:iNKzHJR4cAi4PeB/Q63yDHAB3+PocKq6MAga8pNGBsh+CHY+L8F
 8Y+B0V/8v/pX1JIK8VUr4gCl/v5XyPdTXCaT5+NMUw2Y5wyKXedbH6y6PSWRHj/awp+P70Y
 S/QOaN8eGIw3qewgsupHmRCtOInJrGjWt6z+3GINNgSTKuchSiWAnRqDey5nl9ccnpeQ7V9
 nuKowEgkvDUst11hBYSYw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bpXX6TckVBo=:DOPWkbSwkYc900OpITYIQD
 j4GF+7vTZ3jEHG8pkLWh0Ft60AAKa+8oUtqfyr5bM0h7OxAP7Ism3MiH/dKkRcXXKIkKpkWrd
 v3KMwDPAlxH0Kw9v3sL3xezJwCztVkORtKMZf6J+aRrQb2S+k6N5YG0BA08qtHLtqumfVg9je
 znmdwb6MSdQdkypH0zyeU5NeoyHjsLcNNUAS81qddBj3BTob3yC2Iyl4CEv2A+5sTlNGAgoNO
 6xWF/5bNlET6bc+X4Z171t85zbeDsxyEtTDsg8qaglwQK6tv8LW9yyDTauPD/tpDvw3cILs6c
 n9wlyjahpGCL0tmaZhopQevE6kz/HhDMtAUlwDj9PY9HKd4vr0KGr722DlQ4M7iyg1z6femBX
 95K3XfSdhCdz9kZ9G0eXKEbyDPlInfNcnnslucVQiNEMeES+cioxd83JmDav1MY3p3c3CRi7l
 EbHanRzQDJFZ826MXZjD88NrDTUx0YPanElcwA3kJLVC7MaPtXiAeVmYWNAAy6W8lMcVDHyZh
 3s3ZG7XirHKAui5fR9AFd8PICUicn6sPXtZBYSzHPS6KLuSuifL0M3kBKWhGgLij5dsE7yDk/
 r7Za4VBiyWVIv8rCrSI6FhpcKtRVhHKk7S0Km/9mpxh+tYNCLMMhKKKpbDBdkGujpkppIEAgO
 r0/zWIgascNV/Z2nHbTciRTBtKAHcfUJ83k9i0GVYQi4YKtwVtOfbU+HHIGm1qrOJSnZnrvJZ
 PPGK/umPMPj+V3crrx5TNmzdiGrYnr0V2BlzLIYufs/QxPpRIqozDdQTUWStl6rKUMp3iXlUI
 Ow/MR7u1dUQzBcMaLCb4NY7iTelCLUuBThlVcnY4lS9s53A+PEyouNVYIxy0DkIF6lUfZgHNY
 7xhViGFTAv4Lw5+bG+Lg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 3, 2021 at 2:58 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> From: Palmer Dabbelt <palmerdabbelt@google.com>
>
> As far as I can tell this should be enabled on rv32 as well, I'm not
> sure why it's rv64-only.  checksyscalls is complaining about our lack of
> clone3() on rv32.
>
> Fixes: 56ac5e213933 ("riscv: enable sys_clone3 syscall for rv64")
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>

We should probably reverse the polarity of this symbol and force
architectures that don't implement it properly to say they don't
have it, but for now, it definitely makes sense to treat this the same
way on 32-bit and 64-bit risc-v.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
