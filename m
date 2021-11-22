Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D44458A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 09:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbhKVIL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 03:11:27 -0500
Received: from mail-ua1-f45.google.com ([209.85.222.45]:46804 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238735AbhKVILX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 03:11:23 -0500
Received: by mail-ua1-f45.google.com with SMTP id az37so34740613uab.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 00:08:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pCwPVxjiiXjhwUGSnDBz+stSxiYomGO7y/AFBYehvbs=;
        b=68o6uaV2sfWvBM5FIFZ+XokhpLaPIJCDABjcbEAZeHJdO7RQJQLXkCsYzpqOZ/fkEC
         3I6asY2iO3Z9WAD9h99IinGwQ9XrJ8Fr1s6TAfCwf6G4LEnPLaD+tUFsZBZFsWIPGbQa
         XIpLhH9xD+hsR+84DRMKR9q/Rsd9JBhXiuqvkud3OSUKsAznpssElbYJhZYwhLapIN1i
         kss2t2b6Xd8T/KsWS2hhwFIRGYG555OS68m4B7ZP1JVShrJvinK21VIx1EwwEMvzGvwN
         p9C9kKTpyfMjSxbHK4goYxE4JmsLdWSDsjuaos8BFg2U8MP1X4Z+6dvn6E5pAWT9z/Wm
         IQog==
X-Gm-Message-State: AOAM5331zMSbH9PBMUkl/BEowJH+5rkG3fGkOLIEGir4tYgFUMiLEwcu
        Bf60wzTdS/Lgh9hxxAsjFMdeFzmFePz90Q==
X-Google-Smtp-Source: ABdhPJwoYK+0BwL6TcVUHCjjbTY91wAqGFIuhBeryiGp4IXrT9pB3xFtvfqCo4ebcefwJ14V1auuYA==
X-Received: by 2002:ab0:4405:: with SMTP id m5mr82033948uam.11.1637568496954;
        Mon, 22 Nov 2021 00:08:16 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id j145sm4006653vke.47.2021.11.22.00.08.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 00:08:16 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id b17so34896472uas.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 00:08:16 -0800 (PST)
X-Received: by 2002:a05:6102:e82:: with SMTP id l2mr127366434vst.37.1637568496222;
 Mon, 22 Nov 2021 00:08:16 -0800 (PST)
MIME-Version: 1.0
References: <20211121174930.6690-1-michael.christie@oracle.com> <20211121174930.6690-3-michael.christie@oracle.com>
In-Reply-To: <20211121174930.6690-3-michael.christie@oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 22 Nov 2021 09:08:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUNiuFdwXgj3kvKybm0Jb2g9N-2FgaB0U0LnQQ88y72aA@mail.gmail.com>
Message-ID: <CAMuHMdUNiuFdwXgj3kvKybm0Jb2g9N-2FgaB0U0LnQQ88y72aA@mail.gmail.com>
Subject: Re: [PATCH V5 02/10] fork/vm: Move common PF_IO_WORKER behavior to
 new flag
To:     Mike Christie <michael.christie@oracle.com>
Cc:     vverma@digitalocean.com, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2021 at 6:49 PM Mike Christie
<michael.christie@oracle.com> wrote:
> This adds a new flag, PF_USER_WORKER, that's used for behavior common to
> to both PF_IO_WORKER and users like vhost which will use the new
> kernel_worker helpers that will use the flag and are added later in this
> patchset.
>
> The common behavior PF_USER_WORKER covers is the initial frame and fpu
> setup and the vm reclaim handling.
>
> Signed-off-by: Mike Christie <michael.christie@oracle.com>

>  arch/m68k/kernel/process.c       | 2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
