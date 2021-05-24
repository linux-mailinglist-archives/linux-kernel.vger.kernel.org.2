Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2662438E300
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 11:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbhEXJNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 05:13:14 -0400
Received: from mail-ua1-f45.google.com ([209.85.222.45]:42584 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbhEXJNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 05:13:12 -0400
Received: by mail-ua1-f45.google.com with SMTP id 14so9097271uac.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 02:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u2sASwauofjg7T0woopah+DK+Yb9wrfPhSPc8kUL6dI=;
        b=V6CmoqO0A2rz5Hqc18anvoFllUhCU7wCOFQSwyR/eZ4P2iEcP6QQo4hLNm7c/BCX4Q
         wGseE1iqClT+i0L7s/P0GeYpnit54JSCN7P2Vtb8KVudcs+b19C4QAhh6DruxPwUvM7n
         niKZzK5VJA33lNyJ6q/hKjA1kISGa2KeQvI1/SZbOnx32YV+WAmyVwvAMEJc/7uyoMby
         E5PRIFSZlQs0m4cIylBrw7SEwywYWlTBXLbL7LteMs4CxQKBTU4spwIZiBE64+Pklmoa
         gYGDncUt5Z2Fo0HixVje6OYBjNGwn5TR8rMlK/40i+ZzoC8yHQf4v6z+ND3cqTrTB1WX
         ywhQ==
X-Gm-Message-State: AOAM531mrUJ4agLeX24iT4LztiOybXBVU0LZy8gnSDVcbmAfgd/4iD7x
        vAjAnIdCQQ9/sZj9TsxUZdrEr8vXu6yNKLKauCFQt6IfdO4=
X-Google-Smtp-Source: ABdhPJw0keOPUDxoobO98s1aJB78TQSDm1ODYuwfqEBroOdjcoWzzJ/zUeC75NVZwnpQkSNKr+SImYKqgEco6N0IfDs=
X-Received: by 2002:ab0:2a8b:: with SMTP id h11mr21517917uar.4.1621847503771;
 Mon, 24 May 2021 02:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210521184519.1356639-1-gregkh@linuxfoundation.org>
In-Reply-To: <20210521184519.1356639-1-gregkh@linuxfoundation.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 May 2021 11:11:32 +0200
Message-ID: <CAMuHMdW42UAWRPWe09=0c=pkNLwwswoQHEbSHyXEjsfF6UZJdw@mail.gmail.com>
Subject: Re: [PATCH] debugfs: remove return value of debugfs_create_bool()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for your patch!

On Fri, May 21, 2021 at 10:28 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> No one checks the return value of debugfs_create_bool(), as it's not
> needed, so make the return value void, so that no one tries to do so in

Please explain in the patch description why it is not needed.

> the future.
>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -836,20 +836,11 @@ static const struct file_operations fops_bool_wo = {
>   * This function creates a file in debugfs with the given name that
>   * contains the value of the variable @value.  If the @mode variable is so
>   * set, it can be read from, and written to.
> - *
> - * This function will return a pointer to a dentry if it succeeds.  This
> - * pointer must be passed to the debugfs_remove() function when the file is
> - * to be removed (no automatic cleanup happens if your module is unloaded,

Why isn't the above no longer true?
Are we no longer allowed to remove individual debugfs entries?
Do we always have to remove the whole parent directory and all its
contents together?

> - * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
> - * returned.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
