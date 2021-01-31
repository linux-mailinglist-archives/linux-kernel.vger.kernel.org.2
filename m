Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639CD309EBE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 21:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhAaUMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 15:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhAaTqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 14:46:11 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCF9C061A30
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:35:17 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id a8so19845564lfi.8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=TMdAwgGCU0UK2zGDufFD/rnwy1XjE0usi+CtbeAisS8=;
        b=XZNf2G5ga3i/e0kxJm4Usq8ojU9pUUov9Ps2+vp3HvTpxsIJVu8VDUJLGxtXGyvwcQ
         AAnh1Lu2EQb+IGdRHowyxfY2TJ6TxDwoC0LovnoCrtz25JVV3UJKzw3zRjVu0gFSlSnM
         98MUPt4nnZIrbp+Jl0FWzGyR6UG9YyOQib4Pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=TMdAwgGCU0UK2zGDufFD/rnwy1XjE0usi+CtbeAisS8=;
        b=KJs6EgYOROi2UwVfP2ununT6e3QrR1PC4kjdNq+4Dxfi62uyMQK24bsCrV0Tct4c5t
         wraO6UI7BnJH2+LDwZF0jsU9WeTiXN/TAvl+LJkAh1oJP5ylUTedGvtqRlONcZEL49qr
         tLG4DN8vmBeDT7OmpJ56DuxgYHhwDbmb0PLHjAssJEoYP60ltdByFxJefNJZLrJ5RYAH
         2APAi1Oz9ZJHZVOVhIBZVwAs3sJ0TmQl0dpfe4lTnJuHkLfIMYl55rBehV+V2xYK16dk
         gQ+KW3wFQVKD2lssd6pBDam+TMJg5ZOjEic+wJGY+Hwg7LNptTkEO0vbnr0NeIwpPCUD
         vTaQ==
X-Gm-Message-State: AOAM531O1xtmunMtwds9Vgo/CkI1TcTd4MmzBBZ8A1i6SLcpIs1fpWkl
        2g3I1z6TlOILO+5xvQAarF4EhozNoA5AfA==
X-Google-Smtp-Source: ABdhPJyiCVwf08ARiZCri6d8GzpszPXJI4NKQyyybLkjr6RQZ0M0cfMZh5Ix75TBduUP9tXD8qYW8A==
X-Received: by 2002:a19:6b13:: with SMTP id d19mr7363911lfa.74.1612121715612;
        Sun, 31 Jan 2021 11:35:15 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id i17sm3558173ljg.59.2021.01.31.11.35.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 11:35:14 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id t8so16905383ljk.10
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:35:14 -0800 (PST)
X-Received: by 2002:a2e:850d:: with SMTP id j13mr8269533lji.507.1612121714111;
 Sun, 31 Jan 2021 11:35:14 -0800 (PST)
MIME-Version: 1.0
References: <20210131114017.GA1332@kunai>
In-Reply-To: <20210131114017.GA1332@kunai>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Jan 2021 11:34:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiZ5-eiJbkJxQo+kXPN=wRBTGZZHKUB8eA428Uft7j1Eg@mail.gmail.com>
Message-ID: <CAHk-=wiZ5-eiJbkJxQo+kXPN=wRBTGZZHKUB8eA428Uft7j1Eg@mail.gmail.com>
Subject: Re: [PULL REQUEST] i2c for 5.11
To:     Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 3:40 AM Wolfram Sang <wsa@kernel.org> wrote:
>
> one I2C driver update this time.

Pulled (manual notification because the automation seems very flaky).

            Linus
