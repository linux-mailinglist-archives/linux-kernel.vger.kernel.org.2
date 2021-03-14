Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6838633A54A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 16:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbhCNPKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 11:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCNPJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 11:09:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043F8C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 08:09:31 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id mm21so62013830ejb.12
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 08:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KfDq+xbpQTSxBagga+kuMHQuw6M5WXdS6DbeFFRtt9c=;
        b=FQhyGsAK4SFajSgHlzfV9CAyyxvCAW4V1dsdO30YZyFHlw/yct1W5z/p1MBkNvrxAZ
         NNB5Bj9mysZyufHgin0lh+0P75dpsKxS1/YqqS5evVdE1Uy27VZ98KnlsOkVpFKESzPm
         gIG+xAWs+8coznHKd4t/bOXjQMBJGiaG4vUzsg0EpEYJW8T3GNqr6sWtdb0bkDwEiTUX
         BYzDrVzcCWsc49PTzO1JKrivqoMGzdtG7NB8WatynCVA+rcEwMIbu56jgoi1ZLszpry4
         WApMfLDumbtWpwMgcgauba5BJiklW4t3uf0GWyNFi92Z0eCcHim6iick4bZLyT6bjYRU
         RreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KfDq+xbpQTSxBagga+kuMHQuw6M5WXdS6DbeFFRtt9c=;
        b=rH2kQ2BYp+wTEvHGS1dHTkfUfz3IxkiJkQLGJJaG2KLOiMynUgOnlfnUieDLNl70v1
         Q/zaSRuX1vWd2yLIFQRQ/fBYQ9q/o5py3b4OZbg2WAKaeV05IY4FBLkb2xRpm76RXwKv
         AXPUelShmneMuJHF4OyfthfI74d+iggt4OKZF73GlBqK6oXq2EFpofDI9xKg3un6q2jO
         criDjLrK+15Qwi7oMTaN6oTfXsv9tEmgBRBcyA+5Hgq9eVJzN14kT5rtHh3gSREkFPq7
         /UIvSiwDU7eSHbAVG2wGILft16NEEfC5AUxRPGVo8aXtQF/NeWi/4XoT4lThcpCzGnge
         NBfA==
X-Gm-Message-State: AOAM532l9buKXucpsHJucrpDr/z1zOPS+HiiisRPgbde8BrArx17xa7r
        qVIAZMTx2Sr5Vd3ubLwlDzw5C0xEBGQk+f7BkDA8FpfQ
X-Google-Smtp-Source: ABdhPJzs1bhEzBrZnwMHWi78g+ReQod68AsTpJHEHiQt4sjFzigmdJrrVp0FLKqq5+NUYQjZ+pOBq0CoEw0F3MFHbGw=
X-Received: by 2002:a17:906:30da:: with SMTP id b26mr18950811ejb.376.1615734569776;
 Sun, 14 Mar 2021 08:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210301153656.363839-1-masahiroy@kernel.org>
In-Reply-To: <20210301153656.363839-1-masahiroy@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sun, 14 Mar 2021 08:09:18 -0700
Message-ID: <CAMo8BfJALr7=QjYzx4jBq=DWXn8WsVwudygpAAh9eN6wk0qLJw@mail.gmail.com>
Subject: Re: [PATCH 1/3] xtensa: stop filling syscall array with sys_ni_syscall
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 7:37 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> arch/xtensa/kernel/syscalls/syscalltbl.sh fills missing syscall numbers
> with sys_ni_syscall.
>
> So, the generated arch/xtensa/include/generated/asm/syscall_table.h
> has no hole.
>
> Hence, the line:
>
>   [0 ... __NR_syscalls - 1] = (syscall_t)&sys_ni_syscall,
>
> is meaningless.
>
> The number of generated __SYSCALL() macros is the same as __NR_syscalls
> (this is 442 as of v5.11).
>
> Hence, the array size, [__NR_syscalls] is unneeded.
>
> The designated initializer, '[nr] =', is also unneeded.
>
> This file does not need to know __NR_syscalls. Drop the unneeded
> <asm/unistd.h> include directive.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/xtensa/kernel/syscall.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Thanks. I've applied the whole series to my xtensa tree.

-- 
Thanks.
-- Max
