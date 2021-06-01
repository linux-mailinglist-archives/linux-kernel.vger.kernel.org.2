Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAA3396F74
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbhFAIu1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Jun 2021 04:50:27 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:50725 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbhFAIuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:50:03 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MIMXE-1lZe4G3TaW-00EMBT for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021
 10:48:20 +0200
Received: by mail-wr1-f54.google.com with SMTP id z8so8258793wrp.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 01:48:20 -0700 (PDT)
X-Gm-Message-State: AOAM533QOO5OeeTN11ZjwSBdUqMZ1223fI7vvUtCppvcfSV2dwYLyKh/
        XgHvat4i4PvFgBs3/QAsHeFP9gKi0rL0pzfoSkE=
X-Google-Smtp-Source: ABdhPJzkeMWVTFDfYkZdPFfoHdXkGgyRCZiuT7UP/tjIkH0Fwy39gQE+fV9ql/6Z7Y7PTcrvWjaIasjrJ8GLB4ttM1U=
X-Received: by 2002:adf:a28c:: with SMTP id s12mr27903812wra.105.1622537300583;
 Tue, 01 Jun 2021 01:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210601085127.139598-1-libaokun1@huawei.com>
In-Reply-To: <20210601085127.139598-1-libaokun1@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 1 Jun 2021 10:46:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2w3iHR8LM12MF9OtXeJiREtuQuALBEmUCyHgZxSXnczA@mail.gmail.com>
Message-ID: <CAK8P3a2w3iHR8LM12MF9OtXeJiREtuQuALBEmUCyHgZxSXnczA@mail.gmail.com>
Subject: Re: [PATCH -next] powerpc/spufs: disp: Remove set but not used
 variable 'dummy'
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Jeremy Kerr <jk@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>, yangjihong1@huawei.com,
        Yu Kuai <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:iIJDZefKzX89QtrstLv8EYhw0YZQ6OyHIW8YefexoNcicMHzyOA
 RcxjDOpb3FQf49gsDvVSYtxn5pg2C2O/u6rK2ei6TbdqXmhIPuNH2VsVMExrZQDheuhyf7V
 1hnsJG629vE7ihp4zXFhvbiN93edmA0WS92p8pKOnWIOYeXuARqxLA7rC0mlmGB/vMyqrux
 um4C1EjA2UNhTVU1LZQlw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:h+0U9SJ4JS4=:in0Dp25Vqc9Nz+9ZcPqnHi
 Y+Z0f7O98NOEbfmDNvO1mN3V75iMZcc9TZpEy6+jHGOnO8lqBustrS35+bfJgiFgaYEgjtvBt
 LhaMtX+Mh7uu/VtH6Q7zT4Sj/EGRsa2x6e+9T1mu1nvwGdrkWK72XhKZ3RVtsGu9x2501UhEL
 zKEF9bRSNtWAbzyXxEfLTM1YMigVArCW+8KT8ereHTiczH6gdIw/7I4wEn+znILmtvVX5XHaG
 SvAZH9Z99s6J3OLE7yPbbuwR3g+6SpzK2gocLR3vk2beChbsZjH/fjrJFSExZ7UteJdrH+AX9
 RbFyPKzPhd9qUhIIQl19gAyhlcldHf3lAMsJhX4TyhUrXKyrfMliwn8DZJ3Tw/skf8FAM+Neu
 wrxn0h1TIEPqYZPwKLxWSPMNdhXiy6xwEkxXgknpGBygtXJhpGyDsFp1GprDyRhnMRZp/cCz+
 UAoOnyBpX2vhEXHmIy6dQGFCsvOA7IguS9xHAMa0IGLRpVDws3JUTRzPJcjf5aYD7n5Hbc3CY
 wQ4omvj5NfWdB3E0oripgM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 1, 2021 at 10:43 AM Baokun Li <libaokun1@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> arch/powerpc/platforms/cell/spufs/switch.c: In function 'check_ppu_mb_stat':
> arch/powerpc/platforms/cell/spufs/switch.c:1660:6: warning:
> variable ‘dummy’ set but not used [-Wunused-but-set-variable]
>
> arch/powerpc/platforms/cell/spufs/switch.c: In function 'check_ppuint_mb_stat':
> arch/powerpc/platforms/cell/spufs/switch.c:1675:6: warning:
> variable ‘dummy’ set but not used [-Wunused-but-set-variable]
>
> It never used since introduction.
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

I think in_be64() used to cause a different warning if the result was
ignored, but this is no longer the case.

Acked-by: Arnd Bergmann <arnd@arndb.de>
