Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDDF30AF0F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhBASWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbhBASU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:20:26 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E503BC061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:19:45 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id h12so24111152lfp.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2mg+MSVpxBsUl63+D0GDVyLxT6h/x9cXXO0qAiWDNfg=;
        b=dn0JBeEeLM4tJqo6IlEZXREvKSSN5yrInJxLcskKihzyjU0lJerLnems/wREodgiNX
         ydL/D5riN8/0RU8dAiTADr1INVFUB5+9eY7L5Ay2r7kVYZudhxt3h6jaZygcJKe23jbf
         9AuzQfzKMK0Bu2OkoYuNVEtjXLcmpV8Tx9AUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2mg+MSVpxBsUl63+D0GDVyLxT6h/x9cXXO0qAiWDNfg=;
        b=UF5c6yTqI053uove2bplDlQf18SC/NikSmwCgxz6dsnLivFdHcw25Qakq1ik9mbMT0
         ydjzOdEobiOZLWO7tgoI9Gr7sNAbAkYi1mopWFxkYWVJ18eUC/+KRe/WJtDztzM7Gf3O
         BmvWpua1HFNtJ+pHLDXl15qrLEvB1yko8g/N1U0d6BdgangNQK74nGICZnjHVK9IU3O0
         z9HKz7+hDsxkp0RlW8xe+TZWfCD+5ytBfNjIk6V8j1KU9GkqMthaQ1n3fsfZzSN6mV7h
         Ny/qkAOxpk9rqfsXoG9xwWxX0OXfUHHgZIYqkzZH7SMvC+An+effs865nwZzFTBANRns
         hyWA==
X-Gm-Message-State: AOAM531ZaDAt9hhlzFj4mfELo8GV8ZvqCx2en2+WA/12l1VdXjtsH/on
        h3Sq/hx1qYLcu43JaURRm5fs0jFovYarxw==
X-Google-Smtp-Source: ABdhPJzbTG4DlHjOfLhgcsAlBjj1zBqiGBKoayUuo4Mww4AayNmJ3ZdnPgjyjRHYiRJB13ShYxDeaQ==
X-Received: by 2002:ac2:592b:: with SMTP id v11mr8723753lfi.512.1612203584095;
        Mon, 01 Feb 2021 10:19:44 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id f5sm3022625lft.218.2021.02.01.10.19.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 10:19:43 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id e15so3955426lft.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:19:43 -0800 (PST)
X-Received: by 2002:ac2:4436:: with SMTP id w22mr8667553lfl.41.1612203582896;
 Mon, 01 Feb 2021 10:19:42 -0800 (PST)
MIME-Version: 1.0
References: <20210201174555.GA17819@redhat.com> <CAHk-=wjKeFHBn60eJJjvJOW2+bdtwbeSb12R+=PBQJSSHe+FbA@mail.gmail.com>
In-Reply-To: <CAHk-=wjKeFHBn60eJJjvJOW2+bdtwbeSb12R+=PBQJSSHe+FbA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Feb 2021 10:19:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjJerA3xGtK8HdEcdAnmaaTz-iVvc_xqokzNTBivKomVQ@mail.gmail.com>
Message-ID: <CAHk-=wjJerA3xGtK8HdEcdAnmaaTz-iVvc_xqokzNTBivKomVQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v4 0/4] x86: fix get_nr_restart_syscall()
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 10:18 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Yeah, looks sane to me.

Oh, and in a perfect world we'd have a test for this condition too, no?

                 Linus
