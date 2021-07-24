Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7AB3D49F8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 22:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhGXUIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 16:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhGXUIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 16:08:01 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C63C061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 13:48:33 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id m13so8112476lfg.13
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 13:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkWrvOPY5YMJdNiUpcOqAfdb8xsUYMx2JcvOypU1XNQ=;
        b=g69pzxE9e8cMyNoOGFWp5awgJGEF6+Iaxa0r4cDue9MD3cYP8ZVxWKCkfGGffy6N1O
         qFuxInn0w9N1vWdJYlOC4+QnKiBJy+xi1qlQEh2X1MMSKfSImt8zDIxLq8rL7pQnzvc+
         esoypTbnCENFS0jjGIa5lVxqLKEPdGxsFJcI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkWrvOPY5YMJdNiUpcOqAfdb8xsUYMx2JcvOypU1XNQ=;
        b=ZL0ck1ldPJtw2iKufJUqwGl2ApW2swR/ojfw8eA9Z6ZgXm5m35dwxDagvFJFA88XLg
         LNWq1Jhd1ObjtACxWUYzEidkCct3ElKa1j1/F5RwxTT9SwmghDM6q4PmJ5uMNLmB0fYM
         tr/lFo+bt5w2qNF1iF+H6K61372XsDkzb00gJXTDTt8u26tkSgM6doud9nTPvtID4kJE
         RBChIf12PKDlHyptGc5zA1Kyp6ppgMHRTnY5z+98BDq4wME3IzrXW4KBOwQPVvghFM6c
         1M+Am3n0QkcJPJt3tDqqWT3ksTX4tFAyTW0crEkcSPXdSCURg2hhENEU6ZqdAZjxqcnt
         MWSw==
X-Gm-Message-State: AOAM532e2PKQnD8efxBTO204hUxgWYbjYtWLH3KoPxmf1/s72u/1oZ//
        f69mEb547meugZnZXaRbgRZaDW6ULVECX/ov
X-Google-Smtp-Source: ABdhPJwQQyPDzpD7jY0uG2exqmt3Qn4/zoPo7FA4ailxUhS62P9zi9r1mM7d3/39FDNe+sG3UbnojQ==
X-Received: by 2002:a05:6512:3619:: with SMTP id f25mr7659386lfs.260.1627159711343;
        Sat, 24 Jul 2021 13:48:31 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id u10sm3747229ljl.122.2021.07.24.13.48.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jul 2021 13:48:30 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id a26so8097459lfr.11
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 13:48:30 -0700 (PDT)
X-Received: by 2002:a19:c3c1:: with SMTP id t184mr2995021lff.41.1627159710136;
 Sat, 24 Jul 2021 13:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <eeab973d-f634-a182-6d76-f3912f8cf887@kernel.dk>
 <a607c149-6bf6-0fd0-0e31-100378504da2@kernel.dk> <99068691-01ea-d2b5-3dd3-1a2852fe5723@kernel.dk>
In-Reply-To: <99068691-01ea-d2b5-3dd3-1a2852fe5723@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 24 Jul 2021 13:48:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wggE0PF4fAi8cFEpi=ryyV=WyYupddcHHbE3nggQJgYig@mail.gmail.com>
Message-ID: <CAHk-=wggE0PF4fAi8cFEpi=ryyV=WyYupddcHHbE3nggQJgYig@mail.gmail.com>
Subject: Re: 5.14-rc failure to resume
To:     Jens Axboe <axboe@kernel.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Scally <djrscally@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2021 at 12:44 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> This does appear to be the culprit. With it reverted on top of current
> master (and with the block and io_uring changes pulled in too), the
> kernel survives many resumes without issue.

That commit seems fundamentally buggy.

It makes "acpi_dev_get_next_match_dev()" always do

        acpi_dev_put(adev);

to put the previous device, but "adev" is perfectly valid as NULL, and
acpi_dev_get_next_match_dev() even tests for it:

        struct device *start = adev ? &adev->dev : NULL;

so it can - and will - do

        acpi_dev_put(NULL);

which does

        put_device(&adev->dev);

and passes in an invalid pointer to put_device().

And yes, that adev very much can be NULL, with drivers/acpi/utils.c
even passing it in explicitly:

  struct acpi_device *
  acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
  {
        return acpi_dev_get_next_match_dev(NULL, hid, uid, hrv);
  }
  EXPORT_SYMBOL(acpi_dev_get_first_match_dev);

Am I missing something? How does that code work at all for anybody?

I probably _am_ missing something.

              Linus
