Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC58340C320
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbhIOJ5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237026AbhIOJ5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:57:50 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DC5C061575
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 02:56:31 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id n17so1502125vsr.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 02:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bi2Li95FjTQbP229xr5aPwoMov5SBLFdX/ViIKbaEMs=;
        b=d1PGqUb6RI1Hkr0PY+D7wgWgC6xWLrBSjroqtHDY72IAIqRDrqCwk1EDIamp18yw5I
         P8+cyJGkqJWGjSZMMXDaVeUxUDp1nfePhXbJYxY5KkVhbnY7mb7uG/sbwFLrfaJUsg7U
         /OO5sAYncPfXosOmWFeNux9quT87txMkLRLdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bi2Li95FjTQbP229xr5aPwoMov5SBLFdX/ViIKbaEMs=;
        b=AjOq5W9TJRCZEwjflPQQebg/Xoltj808djo+jrHF1LcOMlwAFfUNbmvpfjxl08zWla
         KBi7yIClCAThn3tgsut/6pNnz+UGHhXBRt/FqPm5KUOwr/3VS1oYQeSAWIaWu31mvAfi
         LO5LVyjXohqZ8qvbA3gpmylNpBMAvUPdW+kjA6I30St1XIcg4a1m3IvWecqjW1hJVXkT
         MLczl9bILsXVy/YAj2h0vQ/kbolpkFNKnDOWzsr+pFw7OXGilUtBHyQis8HnWvLmjmi8
         MK5u3Fx4OJwJxdSyyZtV5jSYMJq2Cc/i3wfiaJLfv0iN5+v8CTSHWxD9wZrstBYaBaHp
         1ORQ==
X-Gm-Message-State: AOAM530rJX+ceSh4mmequnD5paJ1IsaHjDd5QO5tDN1WmBPzW/5GuwSa
        2ojX/Xv34SFdZw0nI6DOzPSKea6Vm2eE9kaceL67mg==
X-Google-Smtp-Source: ABdhPJwFQtu9wRDUW6RgTbzTcuP9nnYuYdmzBblXXtr9HPdrUMdoPnNlk0u5Z9qSx3Ft5ToJQiLHq3yKsU9heRYmNAc=
X-Received: by 2002:a05:6102:3f12:: with SMTP id k18mr2520322vsv.14.1631699790331;
 Wed, 15 Sep 2021 02:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210914184141.32700-1-romain.perier@gmail.com> <20210914184141.32700-2-romain.perier@gmail.com>
In-Reply-To: <20210914184141.32700-2-romain.perier@gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Wed, 15 Sep 2021 18:56:19 +0900
Message-ID: <CAFr9PXmav7d7Qm5wXJDYxZCaNVZn0n4rQMZSe5QQ2Y8BpFtMGQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ARM: mstar: Mark timer with arm,cpu-registers-not-fw-configured
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Romain,

On Wed, 15 Sept 2021 at 03:42, Romain Perier <romain.perier@gmail.com> wrote:
> +               arm,cpu-registers-not-fw-configured;

This looks good to me.
I guess the title should be "ARM: dts: mstar: blah" but I can fix that
up when I pull it into the mstar dt branch for 5.16 if we don't need
another revision.

Cheers,

Daniel
