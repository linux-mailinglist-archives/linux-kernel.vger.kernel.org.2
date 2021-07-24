Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C243D4A7F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 00:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhGXV44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 17:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhGXV4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 17:56:55 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48594C061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 15:37:25 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a26so8389998lfr.11
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 15:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cY0BhOrvODPENyUsm9z1Yrl8qRt1JzTAgFuu64aV0Eg=;
        b=OBvZE5As6RWvMwX/zaxwZ3OSGMw1WumbTwVJejWQU2z95xYFqYwLXNy7yKOczs99d/
         p1iGOZWkMDb4T6CY6qYMEp/ei/5qjBNu+dZMkz3BLHBt5Cbq9T38wDlOwzi0cPsb0qVU
         7UBZgavtuCMPYPq5peWA+Pya76+VYDAgKfmmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cY0BhOrvODPENyUsm9z1Yrl8qRt1JzTAgFuu64aV0Eg=;
        b=sA+VWw1C3ltOLSqENfuZq1CvMvFIN1xR1pJBUaTENrxhpObgcDkbF1g48lOfnH/HrI
         BNZHzO1+ajxL7t+H0niitANDzVzYnTH2YWb3lLngxgsn0GAjpxaTeYb9/YhOnT2meTbo
         dF7Wa9UnFwaWmkk3fKQsYuZMZLBROqV0q7xr171GrKrkFpkplCDNCUJp9SWJCKM612/7
         mhmoj3w6+PMnw8Aqc4krZTlddc7mwWy4Wpnj0l9tKrjd7qCOA0pJ7YJ9fmfFBpERMFdX
         ROWwRMdiUXglcZ38AcdTCC1bx3DCSOEeC/LnFsPjXm5vg+pE8z2pOI/gMEmjmn79lojI
         H4pA==
X-Gm-Message-State: AOAM532M9tGF9kySx8hThFz5f+SM3gzSk9fED8tQQgKuGs8CeygR/lZu
        z/dJv0+8HP3T6/7q6rFRyuBNcqQHBa/+TkEQ
X-Google-Smtp-Source: ABdhPJz3Ov+S4BPNqPSQC4FkvzZm0MY9R7lQLFHJuzElf9hCLovur2ov9Kra1Q9fm3BILkThyy0PrA==
X-Received: by 2002:a19:e00a:: with SMTP id x10mr7761523lfg.536.1627166243281;
        Sat, 24 Jul 2021 15:37:23 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id p7sm2592120lfk.51.2021.07.24.15.37.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jul 2021 15:37:22 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id h11so6396388ljo.12
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 15:37:22 -0700 (PDT)
X-Received: by 2002:a2e:9241:: with SMTP id v1mr7293290ljg.48.1627166242379;
 Sat, 24 Jul 2021 15:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <eeab973d-f634-a182-6d76-f3912f8cf887@kernel.dk>
 <a607c149-6bf6-0fd0-0e31-100378504da2@kernel.dk> <99068691-01ea-d2b5-3dd3-1a2852fe5723@kernel.dk>
 <CAHp75Vc-RMBMO9eR3apX=zC30FA+22CgZeT4vee45XxFCqpjjg@mail.gmail.com>
 <8d6122f0-3ffc-d26a-0dd3-3e45843435a9@kernel.dk> <CAHp75VeJwuUmpn15iS4NgzO9Qh=O5ve9i62xCzQEJ=5Mm11N3g@mail.gmail.com>
 <53345d55-9f8c-13d1-9da7-08262bc81a4e@kernel.dk> <7632e656-ff4d-3964-b3fc-5802935183c8@kernel.dk>
In-Reply-To: <7632e656-ff4d-3964-b3fc-5802935183c8@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 24 Jul 2021 15:37:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=3u-_QXWSDzMPhv04zNNB3DcNHZGVthBvaa+iX8F=fA@mail.gmail.com>
Message-ID: <CAHk-=wi=3u-_QXWSDzMPhv04zNNB3DcNHZGVthBvaa+iX8F=fA@mail.gmail.com>
Subject: Re: 5.14-rc failure to resume
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2021 at 2:39 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Yep, works with acpi_dev_put() checking for != NULL before doing the
> put.

Ok, pushed the oneliner fix so that we get rid of this issue asap.

            Linus
