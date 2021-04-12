Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110C635BAC4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 09:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbhDLHYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 03:24:41 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:46769 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhDLHYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 03:24:36 -0400
Received: by mail-vs1-f50.google.com with SMTP id l8so6134290vsj.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 00:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FmbDoSu36cdmvIZoh4wOCjXx71TJWIKmYq1MspstesE=;
        b=tnHwbYWUy4DqdT90rraHlFzE2MvE/TjHCHYieKj//OSYNxJBoS+5U5VfcQ/80zAclI
         tk0IaDoP+XI0IRJ05M3e4wB73Zpa/YeB52wDYqcB7fONGIsqwdPtNfBb8MNwRCqPbBKQ
         E7wAHrB65fdrHho2m8xQF8SUUA9WPib6LOgPhwwSeXZMpAiCdZaYEcwZji9prWnYqQOZ
         LLUFlV2KGeGRVxPu1QgHliCPTRGZ1xPxbnEsat9Mla06pRQZv+zswnhWP6GHMHOI9FqY
         kROQ4orkHl1WihNDLZJ6JLMsptbnm4e/2NOXL42bcC5yIYWa9y4q4Ob/3OqNMtiUoCf2
         xHkg==
X-Gm-Message-State: AOAM531ytZZMqJsSl51F9swUx0nulINMHDd5DLiC5cDM5Gkfd6q55bbf
        364aE4kwvugfKAXOP7qX+bUE47ea1jrpRFVYAjA=
X-Google-Smtp-Source: ABdhPJyXvju3Gh46hIymtaF0bLVlri9nme00VpTKYLyTfyTcneCf1cRs3OF/wpAAWpUyarp4Dr3Cfksto2s45SL1BDM=
X-Received: by 2002:a67:f5ca:: with SMTP id t10mr18164600vso.40.1618212258056;
 Mon, 12 Apr 2021 00:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210407200032.764445-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210407200032.764445-1-Liam.Howlett@Oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Apr 2021 09:24:06 +0200
Message-ID: <CAMuHMdVM5XFnxbF=q2KH_1NRx5iyosb1xQ3co1VBakSmRgiNpw@mail.gmail.com>
Subject: Re: [PATCH] arch/m68k/kernel/sys_m68k: Add missing mmap_read_lock()
 to sys_cacheflush()
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michel Lespinasse <walken@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 7, 2021 at 10:00 PM Liam Howlett <liam.howlett@oracle.com> wrote:
> When the superuser flushes the entire cache, the mmap_read_lock() is not
> taken, but mmap_read_unlock() is called.  Add the missing
> mmap_read_lock() call.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.13 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
