Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAC3320E44
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 23:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhBUWVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 17:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhBUWVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 17:21:00 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567C1C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 14:20:20 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id c17so52796857ljn.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 14:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1qgd2CaVptvTGUhKDlRkh0Z0LDGRbgbRYJVc77psjI0=;
        b=fQbjNDMH2LW1wJ6/r4mnToB2sVMQoAqDNnIZC0tTft5RHW4oL4vhaTeQgpZVKMxF30
         nT/00d78iK839oXEHN4u+yaZt1zEu/r+rdbRCiRpFFQ0sRSQ1Q8kcb6WJ03qin0IMNCZ
         KtNASVw7j3Rywzu1pVAHxoAg6F7vA+1EvIbPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1qgd2CaVptvTGUhKDlRkh0Z0LDGRbgbRYJVc77psjI0=;
        b=gSLxw740l3wrjL/9u9iGYea9qAhoMmZBsh6z4PLjVKLBNEqHp8b1NA3ctNVb/W46Gv
         rzbu3sy3rnGdLVhqHi+vtaxcVGgKCYbPeXW87HHr72ZvYb7ENu1JjJLGdamFv841f1/a
         LZM1HmPZw0mJx2Qt4XMVQ3vQI69YQ+T1ljpeKbQxCMRbbEGV0EItVJnw+GitpXMOKUEr
         GgI/5Ga5wMTqXLrzIkF1EnYfV4cB/p+2eICd2VNOmm5LfIAbrxXB829Z+7X3BExwU9/a
         ztvr+SocbtVMPV66gQ6Cz+gYmIv01LIzX/LjQL4JzaIxIYvdyX3YsZe4NISdUiOpziYC
         55Xw==
X-Gm-Message-State: AOAM532Hpnk9KEdWZqxUlhbzrlSpKzaj1rpZ3vhHq0bsX25bLtTLjqHG
        6Gm4NdTY+tUJi5dxty4HdRdDmFlGWIYd0Q==
X-Google-Smtp-Source: ABdhPJwFEy7bHNWgS1GWZmffxlEuRUDKv1RKhgS9UvMb7sR1lDaWMEdw7pIVLhMlkCi4S/hWF8eyNQ==
X-Received: by 2002:a05:651c:108:: with SMTP id a8mr12920266ljb.268.1613946018552;
        Sun, 21 Feb 2021 14:20:18 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id z8sm1695876lfr.124.2021.02.21.14.20.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Feb 2021 14:20:16 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id e8so13884349ljj.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 14:20:16 -0800 (PST)
X-Received: by 2002:ac2:4acd:: with SMTP id m13mr6041704lfp.201.1613946016272;
 Sun, 21 Feb 2021 14:20:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1613392826.git.gladkov.alexey@gmail.com>
In-Reply-To: <cover.1613392826.git.gladkov.alexey@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 Feb 2021 14:20:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjsmAXyYZs+QQFQtY=w-pOOSWoi-ukvoBVVjBnb+v3q7A@mail.gmail.com>
Message-ID: <CAHk-=wjsmAXyYZs+QQFQtY=w-pOOSWoi-ukvoBVVjBnb+v3q7A@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] Count rlimits in each user namespace
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 4:42 AM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>
> These patches are for binding the rlimit counters to a user in user namespace.

So this is now version 6, but I think the kernel test robot keeps
complaining about them causing KASAN issues.

The complaints seem to change, so I'm hoping they get fixed, but it
does seem like every version there's a new one. Hmm?

            Linus
