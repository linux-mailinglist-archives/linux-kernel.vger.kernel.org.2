Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7834230943D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 11:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhA3KR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 05:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbhA3Avi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 19:51:38 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84860C061756
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 16:40:36 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id i187so14943113lfd.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 16:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L1JguF+y5YGproR0D5kVlNt1Iwk3FRQ2NGggMOEny80=;
        b=JFUbIimY8sBuKRiPa91g7hAs2SmjvsKwiBLs+UXdjp878f2/IpXclmfTRnngy/s8t9
         Bg1dajuLjsm54ccQXq1qAkh/k8fEGLTajOmJRiFiIQgSjUQrUzl5VtVNZH9hJflI+R0M
         Qn7pV5gdueKnKegM5qzSB+1Wy2uqGIdmzCPlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L1JguF+y5YGproR0D5kVlNt1Iwk3FRQ2NGggMOEny80=;
        b=WATqufSQ842JXUC7tlw64Sw3diF+jlYxmRmpWdzsLhMsggUf08Ik2HW7c2Z052VuPF
         LHZ5R6u/FyaGhQ1k7wY+O5qQlKLeLoy1K5jYM0RSzI/Ia8vrGqAQQFVwQ719JeK/kF+m
         pNeMZFA2BM7q/nuY4rhEcbEwu1pNG/yVvzUyVdB34PYpP3QW8IfAGBCckz8Q96EXAzDH
         e6EP87dcqe7907n6mXx1FzOYXjdFHww38CNf+BoLizXtXqut9eIzTHZdZoTH8P4CYXE0
         ZLJoGDr0IsgL7PhfMPEdwIOxTrMPduZUV4oKdfr1wXbZtn81VAheIsxr1s79b+B+dO6V
         /MiQ==
X-Gm-Message-State: AOAM533491o6NafCC6cfvMv8lObbNuNkF7H9xIPc7PLSib2sRbhxC8AB
        2wI115cL5OYK6NYoPoxXbcWyq74fKEzybQ==
X-Google-Smtp-Source: ABdhPJxZ+O/sqcrKzeQJ1qnw04fOcQ3yRcJe4j6v4PrAkAxtFD19tsVzPSLktfCL3spGP8cI88Qbgg==
X-Received: by 2002:a19:240a:: with SMTP id k10mr3463497lfk.442.1611967234305;
        Fri, 29 Jan 2021 16:40:34 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id v85sm2216831lfa.56.2021.01.29.16.40.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jan 2021 16:40:33 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id u4so10995827ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 16:40:33 -0800 (PST)
X-Received: by 2002:a2e:860f:: with SMTP id a15mr3748790lji.411.1611967232750;
 Fri, 29 Jan 2021 16:40:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1611932305.git.dsterba@suse.com>
In-Reply-To: <cover.1611932305.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Jan 2021 16:40:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgOWo_i6Xv4JFMd+i3nKhhc4i-_zOeOO=dfTb523TpB+w@mail.gmail.com>
Message-ID: <CAHk-=wgOWo_i6Xv4JFMd+i3nKhhc4i-_zOeOO=dfTb523TpB+w@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 5.11-rc6
To:     David Sterba <dsterba@suse.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 4:37 PM David Sterba <dsterba@suse.com> wrote:
>
> I'm not sure the first post of this pull request made it through so
> sending again.

Already merged a few hours ago as commit c05d51c773fb.

But you may have fallen afoul of the "either lkml or lore is sick"
issue, so pr-tracker-bot isn't working.

We've had a few of those lately.

             Linus
