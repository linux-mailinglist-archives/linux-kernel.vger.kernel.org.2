Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918AF40B416
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbhINQE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbhINQE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:04:27 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C32DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:03:09 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i25so25940244lfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n7ctOqjI0OFOcH0Oeo5Y4vcUw6qUQPJfKjCXEHxdUjc=;
        b=Lqp4/E8cOSeL8hsamKvQoOkuH7pv6rPAu3WIfGddN8KF1xijzgT3XiWVYvajw0mWlR
         t70e4fRcRS+ISS8iANYU4xL+CMRo0cqmQnVQgLna+LGn2sdKgx+yy0suLjZgLLmvsiar
         CaJhitAPI6YM1CWRlGdtdZPHDGonOzsCkXiNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n7ctOqjI0OFOcH0Oeo5Y4vcUw6qUQPJfKjCXEHxdUjc=;
        b=aItVUm4anMXXS4NEMStktn9ZSV39IKKXGWfP0N3Ht9R9crO4oGZUZpVsIDb/E7QFrt
         JuxLanDkep0pQkaVWN7s47qi5ey8e/wtj+AY4lEJHve2A90fD6/waKnDKpoIgoDAxF4v
         sJMM5QN3cqumjOPJmYztPVVOIUi69XJG8b/KqyYNy9BPUF00w84FtmZuk5br/067TCvc
         mPmWzCruuZPpUYYTWSL4qsVd9QwDTdzkYByZRe7eNLQ1SYeZ9Y7HfRUW3uKLwpjC/ANP
         UWADr+Y8XXcNcUe3/kjsPXTC4jpESjHNqUmxTTgpOCKslaxjtAs6Z9TRLIm1dvEoJU3s
         o0aA==
X-Gm-Message-State: AOAM533HekTDTtq1xl2xOGCBECgoOQmG6CfNTTFVpb5wU9eQZuiNS9Tv
        C++15FbXSzDkopVqXxS4+F4p2YEEjQ8RxmeHU7Q=
X-Google-Smtp-Source: ABdhPJzbdYk1NOjR6UxX035aTAtB4SeIKTBqoLsQYmbu2mxGALYS6iyK+frOBBkZ8xWlKJl/lVRGWQ==
X-Received: by 2002:a05:6512:3091:: with SMTP id z17mr621537lfd.246.1631635387602;
        Tue, 14 Sep 2021 09:03:07 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id p7sm1394366ljn.79.2021.09.14.09.03.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 09:03:07 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id r3so24894851ljc.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:03:07 -0700 (PDT)
X-Received: by 2002:a2e:8185:: with SMTP id e5mr15610886ljg.31.1631635386868;
 Tue, 14 Sep 2021 09:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <c1b1a299-c60d-28a4-07ab-1ecd211d6da9@i-love.sakura.ne.jp>
In-Reply-To: <c1b1a299-c60d-28a4-07ab-1ecd211d6da9@i-love.sakura.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Sep 2021 09:02:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjAyRpGGsN6r30X9bnOg8ahR4zRgFLhEH9Vip_O-rj7PA@mail.gmail.com>
Message-ID: <CAHk-=wjAyRpGGsN6r30X9bnOg8ahR4zRgFLhEH9Vip_O-rj7PA@mail.gmail.com>
Subject: Re: linux: build faulure: error: "__has_attribute" is not defined
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 6:42 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Can you tell me the commit ?

Two commits, in fact - both odd cases of "confused code ended up using
the GCC4 #defines despite not being GCC4":

    1619b69edce1 ("powerpc/boot: Fix build failure since GCC 4.9 removal")
    d0ee23f9d78b ("tools: compiler-gcc.h: Guard error attribute use
with __has_attribute")

hopefully that was all of it.

           Linus
