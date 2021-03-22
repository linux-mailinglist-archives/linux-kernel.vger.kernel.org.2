Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADB83436AF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 03:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhCVCeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 22:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCVCeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 22:34:19 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029BBC061574;
        Sun, 21 Mar 2021 19:34:19 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id w8so4970125ybt.3;
        Sun, 21 Mar 2021 19:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+M2KCWe9PmYDmuYbFsQWm96C6UR5RZvQzIhU/uZ+6X8=;
        b=fEFWbIGd6Nbc096iBv3yJL77XH92zohhwPHjyVAZrJbJWeYoWe7vtX+acDTn8dueAA
         pcy2SzlX6CbzuGb45HJUXIHNgM0KRJsnaDiJiVC2sB+G92RaSt2GZCEuor3KRad2Fef4
         Xl409vbUxS/MQ1G8z5cOwDDAAnyl3bucVEnIN/uxUWj4/teI3aDnWgqA3nvnUl5c3gHn
         yAd9+byyIzZZ/kL+pk2xOZMjCec8tXk7YhvgAF6H+ZprGqdgF3t8oR5i1Q4Cw72Dzzr6
         /ii13UL+PAc2dYSYczH10Hn7FL/8yz03LaEAswb67VHUoguzyvNK031r1ie3nIvQD66x
         TBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+M2KCWe9PmYDmuYbFsQWm96C6UR5RZvQzIhU/uZ+6X8=;
        b=B1KPYnE3OJLk4HxndaR7q62vLI+QwMnrLH5TRqZryuO6v0bM9Aw5sxIYwyB7XCgtNF
         gZng9J1jZBkFVvL7G6q6XJtHnNHpwprB2zn/1ogeJQpiYSqYhTdQq/qK89CMfch6qgKm
         eLNhMhVgausbe4rmJc+tQSPY4/D2PkHovzsp5DcfnJJgGcpgv/D/mmSuMX8ILW8M+J0S
         ZDtsF8Fl27E8MjsilazWEdsR5X8XvIRuiRj1XMJxDwNtEb79SmgFspQXVwdfTsbbM5VB
         4IYwIB0CmjyYzzIuCd8EUMGMnojkcaNak3cpMlNgOYVVKwplHPJ3323m/SjTjxfLBY+Z
         6BkA==
X-Gm-Message-State: AOAM531Ni2UXaWYw6+yn8UMZ1aB+AaH5suHbMrXOsyLXoAJ042tDjVJw
        uo2BbyoJEjd5UNqk2VUhMP2koqyjiRpkZC/F4Gb0ce+2ZIg=
X-Google-Smtp-Source: ABdhPJyKW61bmvII4fSNzxnT5ExoVgd5lbSZ83I31xfimWEGYvdI0t24u61GvaE+xV8hOLAudea/B/uEAeY2hg1K/Gg=
X-Received: by 2002:a25:d94b:: with SMTP id q72mr20418703ybg.135.1616380457934;
 Sun, 21 Mar 2021 19:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210321193705.GA13699@duo.ucw.cz> <CANiq72n=XNwH8JrPfpzTMrHujhCYVzk5BgVmifiVcTk3W_=L2A@mail.gmail.com>
In-Reply-To: <CANiq72n=XNwH8JrPfpzTMrHujhCYVzk5BgVmifiVcTk3W_=L2A@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 22 Mar 2021 03:34:07 +0100
Message-ID: <CANiq72m_v37syDZC4qBQNw8ESFT_0WOLa6ek3ebM5Je09A84Ow@mail.gmail.com>
Subject: Re: Getting Rust to work
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        rust-for-linux@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2021 at 9:03 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> The supported architectures are in
> Documentation/rust/arch-support.rst, so we should link to that.
>
> Yeah, this is mentioned on the bindgen section in quick-start.rst, I
> will try to improve make it more clear, perhaps I'll a section for
> libclang itself.

Done, see if you like
https://github.com/Rust-for-Linux/linux/blob/rust/Documentation/rust/quick-start.rst
:-)

Cheers,
Miguel
