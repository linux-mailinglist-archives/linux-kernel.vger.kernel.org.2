Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EE2414FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 20:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbhIVSZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 14:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237066AbhIVSZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 14:25:14 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43061C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 11:23:44 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m3so15644648lfu.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 11:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TbPbDvaSC8wqkWcHaupYqo44jz32dr4SiQpAk5OkdMw=;
        b=Uc1SwP3fAVxCTPC+RKuOk9uQhdzydJzPHQVcfvrDhIewdX8mQv+HsdjsNDY1ID7l2i
         T/5MnacJj/QHwoMOjnVDmpPk3GpflPeYq4TlcGW+I1j5XdEhipwKO0PxO7515BvUvcXN
         28u4sqB0s/FaTyO8pZ4nTEC5U9HRxkc2RbDraLOnqSswVYgRyY8RXryg1GJ9bRIzZosm
         d7ufhrlFzqUroN8Y9Tcx1/F3WL6XiR953w5p51zLwXhLQ+PhNaJRienrDPnIBRcxGAZv
         pzM/xyFMsqPHkLvk9+c4qihe2XTF1+uLOboAsth5Cw+e09MH4bUZbtlkW241jSpXqmlR
         OPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TbPbDvaSC8wqkWcHaupYqo44jz32dr4SiQpAk5OkdMw=;
        b=5ZA7uPZvkNuYCY9IXToz8Mja1Rc84ZSDq4+YAOmpfy9o6CHYA2URHvK26ttsRN/8an
         OAxAp6sNf3v1odlOEltyWW5rgjux6w7r/NkeBg/rusLockEEbiK7h/L2HTNaNbZtx5Jv
         KS9ANkkZptkV6cxcUvoTdZWmcuFoeKp7pw1ycyEkEFkDdgIqHxHSM9nRZxA8+d0c8g2x
         GPT+eHQseA50pDbtufG1WT1U6XK/GgXZ4egCaPjhCgDT4S1FyxNbjIdq49B7ytVe2v5d
         pvtScOs7QlPj+uSDomstFuzMiP9iHs9wS5ZxQFt19U7OCySuPmj7LHaghgixYAbE5TNT
         CENA==
X-Gm-Message-State: AOAM530D1yMqhMEQK7xcPWqyCBjdqinnRcrBrhe7O1GqbNu+MrBodN66
        v+Gk2yLwYsZVU8PsPRHQvKJOVB0r/aF0PkGlu2g=
X-Google-Smtp-Source: ABdhPJyg/KMRncYPbM0aspsoKGduYybE8TOcNA5jS3PuDcRZ5GV1PEXuQ6BPaH4J5vCEi8QgJUDeALAOzRK6iRH+r2k=
X-Received: by 2002:a2e:5049:: with SMTP id v9mr766002ljd.128.1632335022131;
 Wed, 22 Sep 2021 11:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210920205444.20068-1-ahalaney@redhat.com> <20210920205444.20068-2-ahalaney@redhat.com>
In-Reply-To: <20210920205444.20068-2-ahalaney@redhat.com>
From:   jim.cromie@gmail.com
Date:   Wed, 22 Sep 2021 12:23:16 -0600
Message-ID: <CAJfuBxwAufHVE-gZcqShY-Q=yvOvTmTgtLVAnu2J=q1XmxqGfg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dyndbg: make dyndbg a known cli param
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 2:55 PM Andrew Halaney <ahalaney@redhat.com> wrote:
>
> Right now dyndbg shows up as an unknown parameter if used on boot:
>
>     Unknown command line parameters: dyndbg=+p
>
> That's because it is unknown, it doesn't sit in the __param
> section, so the processing done to warn users supplying an unknown
> parameter doesn't think it is legitimate.
>
> Install a dummy handler to register it. dynamic debug needs to search
> the whole command line for modules listed that are currently builtin,
> so there's no real work to be done in this callback.
>
> Fixes: 86d1919a4fb0 ("init: print out unknown kernel parameters")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>


I just validated that this does NOT block or short circuit  bare
dyndbg=  processing,

[    0.981166] dyndbg: dyndbg="+fl"
[    0.981281] dyndbg: query 0: "+fl"
[    0.981836] dyndbg: split into words: "+fl"
[    0.982281] dyndbg: op='+'
[    0.982861] dyndbg: flags=0xc
[    0.983281] dyndbg: *flagsp=0xc *maskp=0xffffffff
[    0.984044] dyndbg: parsed: func="" file="" module="" format="" lineno=0-0
[    0.984298] dyndbg: changed arch/x86/pci/irq.c:1312
[irq]pcibios_fixup_irqs =fl
[    0.985284] dyndbg: changed arch/x86/pci/irq.c:1259
[irq]pcibios_lookup_irq =fl
[    0.986281] dyndbg: changed arch/x86/pci/irq.c:1229
[irq]pcibios_lookup_irq =fl

you have my T-B

> ---
>  lib/dynamic_debug.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index cb5abb42c16a..84c16309cc63 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -761,6 +761,18 @@ static __init int ddebug_setup_query(char *str)
>
>  __setup("ddebug_query=", ddebug_setup_query);
>
> +/*
> + * Install a noop handler to make dyndbg look like a normal kernel cli param.
> + * This avoids warnings about dyndbg being an unknown cli param when supplied
> + * by a user.
> + */
> +static __init int dyndbg_setup(char *str)
> +{
> +       return 1;
> +}
> +
> +__setup("dyndbg=", dyndbg_setup);
> +
>  /*
>   * File_ops->write method for <debugfs>/dynamic_debug/control.  Gathers the
>   * command text from userspace, parses and executes it.
> --
> 2.31.1
>
