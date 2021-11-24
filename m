Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA8D45BF12
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 13:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244185AbhKXMy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 07:54:58 -0500
Received: from mail-ua1-f42.google.com ([209.85.222.42]:45849 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344495AbhKXMvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 07:51:45 -0500
Received: by mail-ua1-f42.google.com with SMTP id ay21so4754776uab.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 04:48:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZVQrmYsOA+1yP9aB5HSucOqwJxIhbAyU8XlDIT0KzCU=;
        b=DLd3a6aY01yrI9X1OD8pBTjnVY/fHtWro8ye2vHugVHxROhpc2CaBDThsujE3pLBP8
         POSM8o0VprqC+hdGwiT3QTKUTIGRJCHQoZtW++K9QbkQin7+VtZRoFRdPw2gjtgnZF6E
         bhCc/zQg4/E9is9bQzXN7LQufxM+TxL8gsty4WHqR2pmTb19eWweCU9z1+tJWelt1y3x
         l+8nMJQDZ+hgrW4wETIbOpNHAGwGBQnKzpu3O3PwWL3zgC367zc2Qmc++Cj7fspSYN4r
         jL042bZZM1fZ7QQ+0u+/5/iAs3BpmO/tzpphocg3CS7vi3rIdv9mYoiZhLI4CPgqvTu2
         freg==
X-Gm-Message-State: AOAM531ByMmPcErYLOnNXCRI3YK2Ciw5o6kbhF1F+Q33hvsOgVgxNj+U
        RKB8Qihi+8BUyFp+eHbKy4k6s1xqIA/Pvg==
X-Google-Smtp-Source: ABdhPJwdPydqApg0JyeQK3IEzrJrA7WkRWlNs/Q/m2W2Eqs9WaGqJWrMM4LXhXedyhI7mfIlwDflFA==
X-Received: by 2002:a67:de88:: with SMTP id r8mr22032633vsk.15.1637758115296;
        Wed, 24 Nov 2021 04:48:35 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id s2sm8073119uap.7.2021.11.24.04.48.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 04:48:35 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id j14so4765238uan.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 04:48:35 -0800 (PST)
X-Received: by 2002:a05:6102:1354:: with SMTP id j20mr21639125vsl.41.1637758114460;
 Wed, 24 Nov 2021 04:48:34 -0800 (PST)
MIME-Version: 1.0
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 24 Nov 2021 13:48:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWFE6zyN04zK9D=8Nps5Jy245V+bCbXvM82Aj7CZQouEQ@mail.gmail.com>
Message-ID: <CAMuHMdWFE6zyN04zK9D=8Nps5Jy245V+bCbXvM82Aj7CZQouEQ@mail.gmail.com>
Subject: h8300-next
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sato-san,

Is there any chance you can send a pull request for h8300-next to
Linus? It's been part of linux-next since next-20210820.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
