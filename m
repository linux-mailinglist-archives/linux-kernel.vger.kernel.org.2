Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4247332F00
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 20:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhCIT2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 14:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhCIT2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:28:01 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DDBC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 11:28:00 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id q25so29065326lfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 11:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+YSV6ncCEG+y5BT6rnDei0hUzTGyRtar1eyCHbKmYIA=;
        b=BpWbaJ9DlLjy2lfPpHHbAiFzYeSNCksb4Sv0yGoyTicKvDXTpdNBSZ7heRe8GWAlkK
         7jxNeEasX8wDIReyMSzEJ3IT0qEmKc+QxIc+KBE4tiKufvfrah/5FjjvwYe/10dRerGz
         feWcjIGoH/8abiiwJ84KXJOLDap3HzPPhea9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+YSV6ncCEG+y5BT6rnDei0hUzTGyRtar1eyCHbKmYIA=;
        b=uU56WSuW7MvKapFUkCZC23pyFEqOzy4ih8F2o2IS+AQTuxJnffOsPIugph29y/4A9H
         ZBTnzlR+b5s3qYF6EdoLWO/ro6iIABGEuQVQhBxAbS5K/g3W72uziaHkpZayliGPZMlB
         5dkx/tWSoRbHURbbhwS5snYappUSMZYulp1afFezDfoN8mAL4Vksb2iMiAf9scvNeTDb
         wNjOti7efjgCGp/u8aPmErzgKmBSiA0HbulVAAFUoKf0iynMhIb1uiaEfGRsqEBcidwB
         KB72wMXsAPjruUOls+uzaOuGxXAAaA7OZbsiTgMqCGg5RxRY/Vdlr9KYDINyECOmXLxK
         i3hA==
X-Gm-Message-State: AOAM530jEcERtrnZOlt62emRLE4KKIX5SJiBUsvq3MdHlTL4E5BGAYAi
        w0QJcEPd0rRkxgqBJemZ0BqBgfwpjt5wRw==
X-Google-Smtp-Source: ABdhPJzzMJmiuU/laDXHz2vo0ZYZIVoXfE5YxJZwK7+peNrQ01k9lCLCjCzeeKC+nQg3C5ZdnNCh1Q==
X-Received: by 2002:a19:7f95:: with SMTP id a143mr17893379lfd.419.1615318078654;
        Tue, 09 Mar 2021 11:27:58 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id m16sm2111091lfu.220.2021.03.09.11.27.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 11:27:57 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id u4so29140065lfs.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 11:27:57 -0800 (PST)
X-Received: by 2002:ac2:58fc:: with SMTP id v28mr17816354lfo.201.1615318077386;
 Tue, 09 Mar 2021 11:27:57 -0800 (PST)
MIME-Version: 1.0
References: <20210308.154619.729170517586257571.davem@davemloft.net>
 <37859f29-dc59-d6c2-6f92-abaae32ee4ab@physik.fu-berlin.de> <20210309.110812.234617387417457658.davem@davemloft.net>
In-Reply-To: <20210309.110812.234617387417457658.davem@davemloft.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Mar 2021 11:27:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=whgiPiFy9Ye_t=fV9J8VdqgZW5XQcb-1z8PgpQbVBWqCQ@mail.gmail.com>
Message-ID: <CAHk-=whgiPiFy9Ye_t=fV9J8VdqgZW5XQcb-1z8PgpQbVBWqCQ@mail.gmail.com>
Subject: Re: [GIT] SPARC
To:     David Miller <davem@davemloft.net>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sparc <sparclinux@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 11:08 AM David Miller <davem@davemloft.net> wrote:
>
> I'll make sure that gets into my next pull req, thanks.

Note that it's obviously always easiest for me to just ignore
something like sparc entirely, but on the other hand, particularly for
low-volume trees it's also ok to just say "I don't have anything
pending, here's the link to lore.kernel.org, can you apply that one
patch directly".

(And yes, I prefer lore.kernel.org over marc, although for single
patches it doesn't make much of a difference. For patch series, I find
'b4' so convenient that I definitely want the patch to show up on
lore.kernel.org).

I'll await your pull request or 'I have nothing else, take it from
xyz', this thread is otherwise archived for me as "done".

              Linus
