Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576403A5038
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 21:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhFLTLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 15:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbhFLTLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 15:11:16 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C59C061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 12:09:05 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 131so14222686ljj.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 12:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ga1InjZw/kSI9gDXsr9QAikDRt/eqge6C65ybQbAbWw=;
        b=gJJJE7LJ5IT0Jmn4YVDLEtNdz6exMrFOkDQlKfDi12eIH9fwYVGEKP4iYCgZmlmzeH
         A4mQgg2zJjGrgsekQe27BTfIeVb2sjEC4J7eOzzS4iE/xiZRqUZ/Uy2bVcp3Vt4zWlrh
         Plz8Ch8WXiZznUhpMBxlsBZQP86tNSmkKprzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ga1InjZw/kSI9gDXsr9QAikDRt/eqge6C65ybQbAbWw=;
        b=I3BHzdaxrXiVJNlS3KPT1hOx0rG24XHxXEQbS97Tu62Fk8UwLh/eZMaNAdbY6y44es
         4XzuGKUj/MfiIAt1ewUIXn7zsucnAFPJnwJCKvlO5vEL2HeCT09Tn+AAoGzyBxY2Uf5b
         Slri6kn/Hdf8Fk1ZfJ8l60Lf9uRiaLzvbvptLw44yukchLPwS+MYYCjQYbsfq/dRxUJ9
         5+YqvcukIov2UrA5Og8hJBhHutT6PUo8FYUpV4gsYHVguoUVxpPTEfbiHH6+HjOqShHJ
         2TkcGHChgI8saBweO4ZTVzAABxnGFnzbcJjRf5j6x7NNqUQBZL4a30tNekbHZQTaHh+p
         Cj2g==
X-Gm-Message-State: AOAM5303goSchHqY+E4KIPXAga7vVZmMVobGdZPMcNvTsBdP/HBvtRIU
        zhtYeqlDKrkSqXSZQVHHy31NFEsuumJQIgNtecQ=
X-Google-Smtp-Source: ABdhPJy3L3JhMS6WNDYb+N/+KScAk9WiIehPWpoUfgBhuR4mRy1aEk+vQ4CW9Y18/noCVy4a27Trmg==
X-Received: by 2002:a2e:751d:: with SMTP id q29mr7373121ljc.118.1623524941605;
        Sat, 12 Jun 2021 12:09:01 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id f4sm962412lfc.147.2021.06.12.12.09.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jun 2021 12:09:01 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id m21so13825172lfg.13
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 12:09:00 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr6282565lfc.201.1623524940718;
 Sat, 12 Jun 2021 12:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdY+DKx-c+74b2xiGQ2H9+e2yeup+HEqg1+u1nvQoO6pXA@mail.gmail.com>
In-Reply-To: <CACRpkdY+DKx-c+74b2xiGQ2H9+e2yeup+HEqg1+u1nvQoO6pXA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 12 Jun 2021 12:08:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgRA2B1b0gn18t+e_TaJdJGQ8Lurpw7qmyZZmQaGwZo8Q@mail.gmail.com>
Message-ID: <CAHk-=wgRA2B1b0gn18t+e_TaJdJGQ8Lurpw7qmyZZmQaGwZo8Q@mail.gmail.com>
Subject: Re: [GIT PULL] pin control fixes for v5.13
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 3:07 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
> tags/pinctrl-v5.13-2

Nope, not there.

I think that "linux-nomadik" is bogus, I do find those commits in the
usual "linux-pinctrl" tree.

How did that odd thing happen?

           Linus
