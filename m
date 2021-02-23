Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D4A32343E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 00:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbhBWXbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 18:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbhBWXUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 18:20:41 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DF6C06178B
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:20:00 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id a22so172718ljp.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N/yik/iez7Vhg7/1JKjxYAAp3zLKK6slY5s2bzVJPEI=;
        b=aAVF1AJYiuYOItxrV9OrRctJHr3Lfcke/igUMBt3widY9DeA5idggiNgKtZd+hN3Xx
         w22z4QWveBDIr8iyrv+FDF8qoQGwmLlzIzPnyePpmASwHMtOzYtmn8X7SCX3u5VUcosu
         +oiaXsnSMt6y2jukwyatNKSJAvBosVEgx/0Qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/yik/iez7Vhg7/1JKjxYAAp3zLKK6slY5s2bzVJPEI=;
        b=o3AYk+Vk49pFmfnuRfJIKbDxnyRF9OzVfFw1A+f+vbyi+JgUxypFu0FeA0Td51S8fZ
         DjJrtMEIH/UV5ddXFulQTa97ETjiPDRugfyuwAYzaQeByEaJIP1TZxvDGr0p5eWqB7DA
         BzXNryIQpcxIUqqvrI5TobbYGwIGTN/C3NosmSWtkOAf+s406d0dSKWgfrwFCsVfi1nU
         c35JogBbBX7MuoA/6VPgie6Ql+p7WfyIDQsv76+R5TSHjf6mK4ADR56ql4L9vhaiTrXl
         NNMssMohJE2jRQNBRJNNO1ahtGP4IRVWTpIcjvQCe6Q1fJpc0KjFWilFtcYNwPpoHgp2
         U8Tw==
X-Gm-Message-State: AOAM531SCRAhj15w4q+pAGiSh6QmNZPceg2WHRs3DttzhHktCHA0n2Jg
        2OWcpagosreK2bIP+XFVBJElqkmSo/xvhQ==
X-Google-Smtp-Source: ABdhPJxGhwXjofhb3QojR/zVQLX11L6lpgBkVn5JrhUNtxpLO1S+lP3aH05XOGN812dNW7S/pz6q4A==
X-Received: by 2002:a05:651c:1196:: with SMTP id w22mr18443923ljo.42.1614122398882;
        Tue, 23 Feb 2021 15:19:58 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id q6sm48673lfb.288.2021.02.23.15.19.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 15:19:57 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id o16so166205ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:19:57 -0800 (PST)
X-Received: by 2002:a2e:924e:: with SMTP id v14mr1444944ljg.48.1614122396619;
 Tue, 23 Feb 2021 15:19:56 -0800 (PST)
MIME-Version: 1.0
References: <20210223181425.4010665-1-robh@kernel.org> <20210223181425.4010665-4-robh@kernel.org>
In-Reply-To: <20210223181425.4010665-4-robh@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Feb 2021 15:19:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiWoqUt5z0Phvr-0HQkohi2SkYRPuCGi0xefV0KE+t4kA@mail.gmail.com>
Message-ID: <CAHk-=wiWoqUt5z0Phvr-0HQkohi2SkYRPuCGi0xefV0KE+t4kA@mail.gmail.com>
Subject: Re: [PATCH 3/3] kbuild: Add a build check for missing gitignore entries
To:     Rob Herring <robh@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 10:14 AM Rob Herring <robh@kernel.org> wrote:
>
> Any non-phony targets need to be in gitignore. The normal way to check
> this is doing an in-tree build and running git-status which is easy to
> miss. Git provides an easy way to check whether a file is ignored with
> git-check-ignore. Let's add a build time check using it.

This looks ridiculously expensive with a shell and git invocation for
every single target just for this check.

Considering that I just had to fight my build suddenly getting much
slower, I'm a bit sensitive about these things.

          Linus
