Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9106B308CAF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 19:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbhA2Smf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 13:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbhA2SmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 13:42:07 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A606C061573
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 10:41:26 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id z9so7406233qtv.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 10:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ku2Wtzp4AOvn1tZk6Gm2zAKzbzJRvwj6cHEhqib91lQ=;
        b=K9l7yrIL02K9CtNDwCzSRzt4c/262v5+QIWUnoorMP74a3TbbcH6OrrhSX/Xb4J5i3
         koeDC2PCmRupZIrDafOjlaSYrjbuUrtA1QPO/DQne/yJ+48aJ9iUqE4ncbJNXKZo/IHh
         p/sY9V/ssGbQaEiaU9S2f1mnWdNMW6YluyDlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ku2Wtzp4AOvn1tZk6Gm2zAKzbzJRvwj6cHEhqib91lQ=;
        b=J+FyJvF/ycB/xwA5waPH55+SF/EGvFkfv9jLo5/vmhm1RFqHjpdv3PFog3EbkE6TTW
         0FvQB6nj6xLwDBtLr+RN/9pilpTYMYjFhN/NjBh4mi6U1/5HDdIl926OtrUCjoXCLP3P
         0S3/JKtAgoWZhYJ8zA2gQcHTSZkABbVVMHBq2yGFLDEhydMQOHqj+mK083UKpe74/Tig
         sE9tFMDIh8P/D4AP7mJf5HxdJpxDWs3O2hPJO/x/8y17HnGmFBCiNelXh4kifDDn/dSW
         kX1NWiIqT5b5QBUwKuOSFBpyl9ISRpVZ4rqAz1uvtDeXY61bVWiLSpk918AqnHNyJ4O8
         wXmw==
X-Gm-Message-State: AOAM53178JGO64PnPp9crDtFu3Jk6jbImunbkf1bF9oA8mWGA8f7UYld
        N5Oh/ynaSuHTTUdwg8ACVtmND7RE5XB7FQ==
X-Google-Smtp-Source: ABdhPJxhcW3SNiVJX8I5g/zoJNE+LCGe7WJ3odRaxFubJ5aLasAeanj6l3Zg/b7li7xxj2mtvoHxAA==
X-Received: by 2002:ac8:3571:: with SMTP id z46mr5745097qtb.83.1611945685437;
        Fri, 29 Jan 2021 10:41:25 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id r4sm4064956qkf.112.2021.01.29.10.41.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jan 2021 10:41:24 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id q201so6297190ybg.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 10:41:24 -0800 (PST)
X-Received: by 2002:a25:b74d:: with SMTP id e13mr7800330ybm.405.1611945683825;
 Fri, 29 Jan 2021 10:41:23 -0800 (PST)
MIME-Version: 1.0
References: <1611820190-12559-1-git-send-email-stephenzhangzsd@gmail.com>
In-Reply-To: <1611820190-12559-1-git-send-email-stephenzhangzsd@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 29 Jan 2021 10:41:12 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WXJD+cyZajdEpd_KvpVq9b7_XV=iP2+QwxaXjiRb_xtA@mail.gmail.com>
Message-ID: <CAD=FV=WXJD+cyZajdEpd_KvpVq9b7_XV=iP2+QwxaXjiRb_xtA@mail.gmail.com>
Subject: Re: [PATCH v2] kdb: kdb_support: Fix debugging information problem
To:     Stephen Zhang <stephenzhangzsd@gmail.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 27, 2021 at 11:50 PM Stephen Zhang
<stephenzhangzsd@gmail.com> wrote:
>
>  int kdbgetsymval(const char *symname, kdb_symtab_t *symtab)
>  {
> -       if (KDB_DEBUG(AR))
> -               kdb_printf("kdbgetsymval: symname=%s, symtab=%px\n", symname,
> -                          symtab);
> +       kdb_dbg_printf(AR, "symname=%s, symtab=%px\n", symname,
> +               symtab);

nit: in this file it seems like convention is that alignment for
continued arguments is to match up with the first argument, so the
line starting with "symtab" needs to be indented more to line up under
"AR".  Similar in some cases below.


>         memset(symtab, 0, sizeof(*symtab));
>         symtab->sym_start = kallsyms_lookup_name(symname);
>         if (symtab->sym_start) {
> -               if (KDB_DEBUG(AR))
> -                       kdb_printf("kdbgetsymval: returns 1, "
> -                                  "symtab->sym_start=0x%lx\n",
> -                                  symtab->sym_start);
> +               kdb_dbg_printf(AR, "returns 1, "
> +                       "symtab->sym_start=0x%lx\n",
> +                       symtab->sym_start);

nit: This doesn't need to be 3 lines anymore.  Probably best is to
stop splitting the string.  In general the kernel convention considers
it better to not split strings even if you have to make long lines,
but in this case you won't even make a long line.

Other than those nits this looks really nice to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
