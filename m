Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0AD44E353
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 09:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbhKLIiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 03:38:50 -0500
Received: from mail-ua1-f52.google.com ([209.85.222.52]:35390 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbhKLIit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 03:38:49 -0500
Received: by mail-ua1-f52.google.com with SMTP id l24so13051947uak.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 00:35:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBk8MCSNtlUvD8rLqSbjXq3e+2xkJNNwK7CzcOaPWQY=;
        b=gTZGU2CqjbPNutUN3btSMzgO1AEADAVW0bvxc443zvMVeKa/KG2AmoYfnl1pGlWR48
         uOSzLMFVadf9QdqB1tSubTH+z+I/5D2ufNzpPKwZAm9TEWnFI6A+Ap3lR9/yaBvHeyC+
         Wo2HXYsT/d7DRpbHLFPRiqDoXI927Q7Ln9EBpx1HsXqrUdWAjkrOfqaLWgPmsw/UH4W7
         5lTEJNsdGUEz7wOLMh/I/fV9nkpNWuk4eRwIhEE3r2SFjh3IlROEf+8cXOg42tyqjhjo
         jG15iXguW8xU6cCp9wM0YUY6FMCTJpVKtJRHSOG5uq1WAhe3EdfAPP2fCnr6weny30dI
         z/XA==
X-Gm-Message-State: AOAM531lAAl2BSftfqxK/L2GniH2fqgP6eFeR/9ijRGGVtD+ICqc7QPi
        DoPGmpKPjNOJxu+Gx4RDvQUEbWG1DVjBSw==
X-Google-Smtp-Source: ABdhPJxRiTQJSxz4Q4PUnN3fnKvHjvfHXMYOTq9ObzErCO3xAiZyyx7yV5/puI9Lt+290KSjRMkRwQ==
X-Received: by 2002:a05:6102:d94:: with SMTP id d20mr8075380vst.12.1636706158184;
        Fri, 12 Nov 2021 00:35:58 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id d22sm3672187uan.15.2021.11.12.00.35.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 00:35:57 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id v3so17251678uam.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 00:35:57 -0800 (PST)
X-Received: by 2002:ab0:15a1:: with SMTP id i30mr20017412uae.122.1636706157380;
 Fri, 12 Nov 2021 00:35:57 -0800 (PST)
MIME-Version: 1.0
References: <e07d814e65cd38c00bf7b6cb806e81a4d32286ef.1636593047.git.fthain@linux-m68k.org>
In-Reply-To: <e07d814e65cd38c00bf7b6cb806e81a4d32286ef.1636593047.git.fthain@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 Nov 2021 09:35:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXPu1Kp_1RE_RG=Pg65rn0vt4WJ0x6cZ+=QkJEi_h+Eow@mail.gmail.com>
Message-ID: <CAMuHMdXPu1Kp_1RE_RG=Pg65rn0vt4WJ0x6cZ+=QkJEi_h+Eow@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add macfb driver to Macintosh section
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 2:12 AM Finn Thain <fthain@linux-m68k.org> wrote:
> According to the MAINTAINERS file, the Framebuffer Layer (and
> drivers/video/) is an orphan. However, macfb is still maintained
> so update the file to reflect that.
>
> Cc: Joshua Thompson <funaho@jurai.org>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

I can take this, if Joshua is happy (haven't heard from him for a
very long time).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
