Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76D732A761
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449132AbhCBQPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:15:25 -0500
Received: from mail-vs1-f45.google.com ([209.85.217.45]:37156 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376817AbhCBNin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 08:38:43 -0500
Received: by mail-vs1-f45.google.com with SMTP id l27so3091683vsj.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 05:38:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S83xpZrRO2vsmOHrKP4fYqAMwPLcdiuf0B6CB48W+1Y=;
        b=Qqq0lxrPNbVREq8FLdC5r1JWdR83RWDmBt0vo3F+Lmiw5VaVbvyZcqXscXOkTfYOpv
         vbD48eb+5sZR03qdFuHhqfFPSuSmfU6DZuyCT1HBl2IOvb/i1KytXptJSuQTyhFdzwu5
         c4K+mszoGjaQAaPpeKZKfnvTs9VBj46o9njmU8QjrxjYgBw5XmOs8vlFjjHnsOsDhY0f
         kCOTXqqhXLCp3D8u5YDm8k3hTxNTEEhMW8iLeoAvqhn+X7CmeX4MLe8vqt4eUzEEpGiB
         lddITGy5Sb3kXPhT64v0VU/DS2bD5dNoPzlWElm1ePs8HNZ3mkiWaUAXiS/0pQR5E6DH
         v+tg==
X-Gm-Message-State: AOAM530Ud0cxkI+oFEutWNtsMrB94/ZwfTIY/9AelKfYR+N+pPVueAsk
        xBxKNk1ziD6kcKXIeJA5ZMgq0pKzu0FxM0/kR056gP4X
X-Google-Smtp-Source: ABdhPJwF1CH14dyYdQNyF0S76UdIAbCyxS08yhx/MaBD+X5Om8NSEqFnrUJiw9WD0G45PsGWhQNBQ4Xitb1TOVPdJkE=
X-Received: by 2002:a67:fe90:: with SMTP id b16mr2294947vsr.40.1614692274640;
 Tue, 02 Mar 2021 05:37:54 -0800 (PST)
MIME-Version: 1.0
References: <20210301142112.342909-1-masahiroy@kernel.org>
In-Reply-To: <20210301142112.342909-1-masahiroy@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Mar 2021 14:37:43 +0100
Message-ID: <CAMuHMdWyxwqYp_xV17ESJtRZ19iGT1Bsm8YrxpGuXcRQiBiSEQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] m68k: syscalls: switch to generic syscalltbl.sh
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 3:21 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> Many architectures duplicate similar shell scripts.
>
> This commit converts m68k to use scripts/syscalltbl.sh.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.13 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
