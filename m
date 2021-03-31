Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68FF3502DB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 17:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbhCaO73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 10:59:29 -0400
Received: from mail-ua1-f51.google.com ([209.85.222.51]:38731 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbhCaO7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 10:59:18 -0400
Received: by mail-ua1-f51.google.com with SMTP id h34so6223811uah.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 07:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OSz6CJVoblhMY8XWXlg1kvvJ25J01Wnwx8w1J/DwPGI=;
        b=A1tXf/Amd6By7Iq3gbqxsbpBmFldKMAWEzOseRKAPi9Tqo+xnExouOGUCm80X55Wwk
         JSyVn0PHCoxVnM16KEj+bx3Y6cQZ+87oWsTirlUlrjE9gLoy2JLU0zlFvgRD4NbWb3GY
         EI01bNr5S/xyHH10hlwaLQJhHK5PdG9HJTEj4zHvGFAuGyLuWVZ3k/BTpe2XYtNYKycR
         yukTWSgGtTREexSDQwT0iMVXGtY+bCU63RfvT7ijJHQZLjgQJZctRKxbS2N8wAmtYXbc
         8LDlj0im2ON8tjecXj7Rlgq3XWAVDvUODi55q6B+a7baCWxDzz1JQv5KNK918Ccf2l2A
         r8Zg==
X-Gm-Message-State: AOAM532TiOHnBGyqY/ewHcUUuv5c7R6MCRk8SxG1HNg7YTRRFabSC+IN
        TOm5fNUPE6PPP3kliD8YQio0P/kBWQQG6fwXpQv0kJ2A
X-Google-Smtp-Source: ABdhPJzEmo+jaXA7S8yS/UF/SJmYHJFLOB/hurTZFxBIYrv1888gifZn3UHF5gKQrF1WMIIXGLgwWMxdEX3JjeWV9oA=
X-Received: by 2002:ab0:30b3:: with SMTP id b19mr1779026uam.58.1617202757611;
 Wed, 31 Mar 2021 07:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210331144336.25628-1-masahiroy@kernel.org>
In-Reply-To: <20210331144336.25628-1-masahiroy@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 31 Mar 2021 16:59:06 +0200
Message-ID: <CAMuHMdV2pR=rdN7ny_rLq8zCacFy9aw+hMuOQNnHcJ8q_nZYQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] m68k: remove meaningless $(OS_OBJS)
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 4:44 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> 'git grep OS_OBJS' hits only this line. $(OS_OBJS) is just empty.

Indeed. All other users were removed in 2002.

> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.13 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
