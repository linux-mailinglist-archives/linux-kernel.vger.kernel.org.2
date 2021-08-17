Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D383EE165
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 02:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbhHQAkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 20:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbhHQAkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 20:40:06 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1461C061148
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 17:38:43 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id d4so37905017lfk.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 17:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pHaGWBp+iPke7D8PjWpRsP5FDk17EO5HdXW410aqSA8=;
        b=WUH6XmE9plzv3pLCMtudUeKkDwsm7fcLTqzEqRJzv67yYANEIvv65L5K4S7jRcS6n/
         ++d/KmbA8avZT3WWVKq6PRXv/oMsqDe/sMf4vqnITD6849cqzsCBLKFhCvshwvAUeoGi
         tYM7iUKQ+oOjw3s6tKh+BBEwpTniI6lqmI/a8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pHaGWBp+iPke7D8PjWpRsP5FDk17EO5HdXW410aqSA8=;
        b=mqOUvsPuPwKK7/khWYEiwXKTp+KTDspCuYVqFFNB6fK7ljqWgi9rLevCQioQ9itmzE
         CE2Yp92Iovb3rj4BiSMqxrMHydvZQoPE7l3eG++xTGT40r9Dm8nYsPz4ZfnKPpr7q7Wj
         G1b0uUYg0jZ4OOJqnJTzluw0I2TiMFnrVdzYb1oiojCIVg9t0egxGEm/8+0QQaEtDNxq
         1zyF2RaBZCIG/HNH9Jhro54CiCYa4Rl3kcUfgNHyk5Cta/b1fdwamGUzw42dM5HYVHd3
         sumWj84mjL+AYebidV6jGSr3w6fkHntyWUkQp7zs7xB94om6deBY2dXgzUx9JVedYKa7
         DcYA==
X-Gm-Message-State: AOAM531toc5847Z5YO4ARRZwpEANjfmHSn05EV/WeJs5uFIyvR4amPvi
        jZuiEnUG9lSCrbi0+E4czEFqb/7Zyg/LaCop
X-Google-Smtp-Source: ABdhPJxVQ4zlxD5hCmtNoV0/xB7oQeUp7bq7zP0Mo0XG3G9k2fVth+cgAiajvkwTz2Rl9FJA56NPwQ==
X-Received: by 2002:a19:c1cc:: with SMTP id r195mr387705lff.426.1629160722112;
        Mon, 16 Aug 2021 17:38:42 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id i6sm14510lfl.17.2021.08.16.17.38.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 17:38:41 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id g13so37908587lfj.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 17:38:41 -0700 (PDT)
X-Received: by 2002:ac2:5a1a:: with SMTP id q26mr353737lfn.41.1629160721393;
 Mon, 16 Aug 2021 17:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210813224131.25803-1-rdunlap@infradead.org> <CAHk-=wj4chmL3TUdXHhAV+eU-YVNj-ZtZBjNJEFBzTnPMP3_bA@mail.gmail.com>
 <CAHk-=wgnvC=Tyejg_ts1O7yZYRxAgS+mxStCWM+PcyFPnaw1sw@mail.gmail.com>
In-Reply-To: <CAHk-=wgnvC=Tyejg_ts1O7yZYRxAgS+mxStCWM+PcyFPnaw1sw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Aug 2021 14:38:25 -1000
X-Gmail-Original-Message-ID: <CAHk-=whP8o-K2=WWQm=cqx5YTpZcb+KCVvomZ+NeV19CsBMp3w@mail.gmail.com>
Message-ID: <CAHk-=whP8o-K2=WWQm=cqx5YTpZcb+KCVvomZ+NeV19CsBMp3w@mail.gmail.com>
Subject: Re: [PATCH] Makefile: use -Wno-main in the full kernel tree
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 2:33 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So the warnings that clang gives with -Wmain seem to be much more reasonable.

In fact, I can't recreate the warning even with gcc and -Wmain.

I get the feeling that this was a temporary misake in gcc, and perhaps
only warns in a few very specific versions, and the gcc people already
fixed this long ago.

Oh well.

              Linus
