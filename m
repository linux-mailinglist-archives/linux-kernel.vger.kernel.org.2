Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21E63A6DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 20:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbhFNSGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 14:06:09 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:43912 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbhFNSGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 14:06:08 -0400
Received: by mail-lj1-f181.google.com with SMTP id r14so21254547ljd.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 11:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hth5OJx5DLnrqVkGsO9sFZaOxm24SUjgcf7q16vYO9k=;
        b=SYh2bWEUABHXqRB6ouYLMnFXIxkuBj3g9OGoJcjymr/uDkZ0b2ocpQIxY7OD3aoqry
         y/WDysWKakiopu5mag8D+4V2VdjD01blp+N5edF/BQ0EXgzT8QLbBsWXILbf7+h84XUb
         ftZIOw1NIhwgxMzRUzmXKeXGQC6u8yO//bp98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hth5OJx5DLnrqVkGsO9sFZaOxm24SUjgcf7q16vYO9k=;
        b=RZvyqxrPut5Sxyjw1A8nLJYiiGv13A+0GPqooLo635FQ+Z+NgOUACYiwhUUEUJ3ZVw
         w9kMsU/0R7+jz8NfFWsMuvsHEIaGgF+GeU7w2UlGwm5XwTEoVRWx9EqhoiauWpYJsT5P
         owq6tOPUE1v0KRZYlKIytL1wBbhnul0ThNm9Vk51CTVYdglAbJ1Hun1GgO07JWkDPCmA
         tTmghAj9ATT+BXXYpRNxcjvL2KPWx2dglNQAwAhAFH89tJ221GarrM/XeP5FWFW3gRYy
         2mOOQ+3VlX4dnTNbpLOHsfttwy3AQQrW+nTyw5UVB7XyPakdbYNd5t7LKFa+8vfCBn5/
         ZyxQ==
X-Gm-Message-State: AOAM532K/YAcw7G8G72jkUXlHrRM+lz5Iin3hH2NMruWvhkGgDWzOhFt
        2MIeSPGIhXfqrdmnnP8RDT5m8GiYwSA2EilLutU=
X-Google-Smtp-Source: ABdhPJw+rTbL7lmOtYd0WRPdlg6/Zzi8W59QL6hCagG2YZeAQtHwAUTFzpI6M4IDH5vOmNahd8wFHQ==
X-Received: by 2002:a2e:9e16:: with SMTP id e22mr13739144ljk.447.1623693783757;
        Mon, 14 Jun 2021 11:03:03 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id p9sm1547095lfo.276.2021.06.14.11.03.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 11:03:02 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id r198so22488707lff.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 11:03:02 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr12358175lfa.421.1623693782157;
 Mon, 14 Jun 2021 11:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210608171221.276899-1-keescook@chromium.org>
 <20210614100234.12077-1-youling257@gmail.com> <202106140826.7912F27CD@keescook>
 <202106140941.7CE5AE64@keescook>
In-Reply-To: <202106140941.7CE5AE64@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Jun 2021 11:02:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLBq63v_h71YuBM2aNjCSBprkBEO3fevbWnkp8TDeh5g@mail.gmail.com>
Message-ID: <CAHk-=whLBq63v_h71YuBM2aNjCSBprkBEO3fevbWnkp8TDeh5g@mail.gmail.com>
Subject: Re: [PATCH] proc: Track /proc/$pid/attr/ opener mm_struct
To:     Kees Cook <keescook@chromium.org>
Cc:     youling257 <youling257@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, regressions@lists.linux.dev,
        LSM List <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 9:45 AM Kees Cook <keescook@chromium.org> wrote:
>
>         /* A task may only write when it was the opener. */
> -       if (file->private_data != current->mm)
> +       if (!file->private_data || file->private_data != current->mm)

I don't think this is necessary.

If file->private_data is NULL, then the old test for private_data !=
current->mm will still work just fine.

Because if you can fool kernel threads to do the write for you, you
have bigger security issues than that test.

               Linus
