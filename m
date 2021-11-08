Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2002D449A81
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 18:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240468AbhKHRLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 12:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239513AbhKHRLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 12:11:01 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EA2C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 09:08:17 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id s24so30811754lji.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 09:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65miRtKjcQoB0mOWVzjrqpLODFU06mZAT89YUhPl7dc=;
        b=ed48pfeHw1+WGINq6nUTEsag3oPDd5U2/MicY1R0n8GS6QX/iWA07jXDTNGrMNAbOK
         jgnz+o+PfroommzHZFjC917EZZJS5ENzpEgU4eh4w+tnLYHF4oa4lAET4DwkA7/3//JS
         +DGI9uVrF523b4nJeYnS2I8KBSjge9IK4X6Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65miRtKjcQoB0mOWVzjrqpLODFU06mZAT89YUhPl7dc=;
        b=DCWTbqh1VZAcCWbqwzm3R4Fk7NkTLplXN4I+LMNtLKidZfA/XU94Xcok4NilW6zJYv
         Qft29TQRAC6+AlcOY68oDbVskFN0SW6lKL3ZXOuqQG88MdiR35DBLGUJMb0DXTeRZbgM
         SfWjiFutCCRhyNfgf0ihexDVjRnjS2wa2OqGVDG5NziXhkpA6E6vW7lLetXnvzW7weP8
         8BqVg+OgpNzllBSXfpOQGSeGqy6/P00hChxjkp47UEe0GgBPqF8lRNHa42bMEMESMpEc
         ubeoThFTaLrPg+iZYJOuljyOrkM10QAg+GjF9+MjpUfUTUcell0w73y/b5Msec7pJpeE
         CtDQ==
X-Gm-Message-State: AOAM533Pj958iJ8yyyv+tVkYcNiVEYr2OaKjnkoj1A3RhmkgGr/p0c6T
        fqIEZLeEdDbz/w4RRorKZZ/Lb7R1MCSG5VL6
X-Google-Smtp-Source: ABdhPJzdAoizhp3CL3SO8G3yL73sPPb75ctsQ/NhgTDRPzxPXJORnXYtwwJzJGADh98ag9VXcN8S8g==
X-Received: by 2002:a05:651c:50f:: with SMTP id o15mr539878ljp.506.1636391295258;
        Mon, 08 Nov 2021 09:08:15 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id r3sm1875605lfc.114.2021.11.08.09.08.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 09:08:14 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id l22so10972878lfg.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 09:08:14 -0800 (PST)
X-Received: by 2002:a05:6512:31a:: with SMTP id t26mr751511lfp.280.1636391294230;
 Mon, 08 Nov 2021 09:08:14 -0800 (PST)
MIME-Version: 1.0
References: <YYWxSlB1CNhhjUTQ@bombadil.infradead.org> <CAHk-=wjQyGhKCM+F8vRS6SSesXk1rZEP4QxdTjvr8DXmC-e1Lg@mail.gmail.com>
 <YYlK2QKpmb+ipalA@bombadil.infradead.org>
In-Reply-To: <YYlK2QKpmb+ipalA@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 8 Nov 2021 09:07:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=whvQ0JxYDB2BWx4r3Ym-MM1U5G_OY0E=31UVqbwz2_-Dw@mail.gmail.com>
Message-ID: <CAHk-=whvQ0JxYDB2BWx4r3Ym-MM1U5G_OY0E=31UVqbwz2_-Dw@mail.gmail.com>
Subject: Re: [GIT PULL] Modules updates for v5.16-rc1
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 8, 2021 at 8:05 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> Sadly, no diffstat or shortlog was provided in:

So I don';t know what your local names are, but I suspect that what is
going on is:

> git request-pull modules-linus git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ modules-5.16-rc1

That 'modules-linus' is supposed to be the upstream that your work was based on.

If the 'modules-linus' is your own branch, and has all your work in
it, then the diff and the shortlog will be empty, because that
'modules-5.16-rc1' thing doesn't have anything new wrt it.

So if your 'origin' remote branch is the one that tracks upstream, the
command line should be something like

   git request-pull origin/master git://git.kernel.org/....

please give that a try (but don't update your origin tree before you
do, since I've just pulled things, and then you'll get the same
"nothing to pull").

It should have given you something like

Shuah Khan (2):
      module: fix validate_section_offset() overflow bug on 64-bit
      module: change to print useful messages from elf_validity_check()

 kernel/module.c | 79 ++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 21 deletions(-)

I'll pull this as-is, since the rest looks fine and it's small and I
do see that it's just two commits from Shuah like you described
verbally. But for anything bigger I really do want to see proper pull
requests.

                   Linus
