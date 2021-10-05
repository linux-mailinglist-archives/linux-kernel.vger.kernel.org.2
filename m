Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183B8422F45
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 19:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhJERfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 13:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbhJERfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 13:35:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B194C06174E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 10:33:43 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j8so61688wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 10:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JyiTOdZCKa2gs/4fF39tBn5hwnBKvvKWvwW4x5Jkm5c=;
        b=S8s0woBANlfJ4LVp1+ZAi9xOpMdgFw1+X0LlCphYKhM7/92wLKUZ8w9Av7bX8YeBA4
         DEEVi/dQJOvv71jAg0ientWMPWT6QiQ9MYIppoAnFq08KjxzKeGworXByPq+HfD+Sk+/
         NZQ1CO45APzqKWX3waXhRqMoMFMKNU3vOyrd0zY5ftyC2Rs4RgIKS2O5XfLYTD7hGasa
         2RZefbC7jnISQZSHe8cs3gdO3Vsw32zdM2KMxfihl7RkAdw9UgglVVkkPtHk0zAPvtIr
         zyb6gUmBziUykdyaNOWqYrOQyxn+WALvY1m6GO4KZnl9I/J4kzPppztwYxpzmwX8M1uh
         rXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JyiTOdZCKa2gs/4fF39tBn5hwnBKvvKWvwW4x5Jkm5c=;
        b=JWynQIuf1NipkzuSw+nJ5OvDUcDcIAGzzZQpt+cLd7/9S1N4QeRyosaupa1ghCOYKY
         uNveHd83T6Ka35KVuT/iGaxF8Ukz6jDjZkekz/ibyUO7erOSJuEXYqskIeOVthnOudhV
         Ppr1zZrQNcVsiAMWRukFbSamW1KwIROvWtCLJFlW5nU5Nz4YbKK4xflHWyMC5t5ltMzK
         7vvkd9kU/92hIqSh5zywxHRF1nkCCjeiuleI21EMbGtevVLV+NbOcRM0I6Xl5zSZ1f00
         ZXCABMy+eyVVwXTInG4MJmHYy12mSRi8vlbQZTffIqqC3NXKpUpCYSeb4JxseDU770U4
         xpqg==
X-Gm-Message-State: AOAM530rL9iy0viK/Ir+prjG9vSj3z6O79AVU0oyZwPt9wMrnh33yCLX
        u0qoE7xFOJttMcQMUIlBCxlW/CSbMKnEQTxOE4be4Q==
X-Google-Smtp-Source: ABdhPJyBb6QGWOezRgqZXf07NX3FGemGpdoO9hhjEy/Y0q0E4LirRxVrE9Km7R9lsNA2Cit2RpFUyr9w8942Q4LuBmI=
X-Received: by 2002:adf:bd84:: with SMTP id l4mr23681769wrh.420.1633455221157;
 Tue, 05 Oct 2021 10:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211005161833.1522737-1-lee.jones@linaro.org>
 <YVyE3Ax1PRtiBwf+@gmail.com> <CAL9PXLws4DjvPB=1KNpom3W52pXNauXQ4V==MprDx73YQ1-sgg@mail.gmail.com>
 <YVyKc51r2tfMmQuO@gmail.com>
In-Reply-To: <YVyKc51r2tfMmQuO@gmail.com>
From:   Adam Langley <agl@google.com>
Date:   Tue, 5 Oct 2021 10:33:24 -0700
Message-ID: <CAL9PXLz7D=BHqG-Lpb1PNq=vC3CD4juyMUa+Swch1NiE0fD+2A@mail.gmail.com>
Subject: Re: [PATCH 1/1] sign-file: Use OpenSSL provided define to compile out
 deprecated APIs
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 5, 2021 at 10:25 AM Eric Biggers <ebiggers@kernel.org> wrote:
> Okay so this patch is actually a build fix for when OpenSSL doesn't include
> ENGINE support?

Correct.

> Currently this patch claims that it's removing the use of a
> "deprecated" API, which is something entirely different.

The ENGINE API is deprecated in OpenSSL 3.0 but that change doesn't
remove support unless it has already been compiled out of OpenSSL
first.


Cheers

AGL
