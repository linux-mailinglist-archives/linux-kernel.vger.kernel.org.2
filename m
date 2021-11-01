Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCB8441D26
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbhKAPLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhKAPLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:11:16 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AE3C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 08:08:43 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id s24so971469lji.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 08:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=73GY2ssc7/sItg/k5mLVHEB5CQWhUCwaXe7+KIwXESI=;
        b=gOXu8I9ytDd3ZX3oehRVWSx49by+y0OxpsidEmdXlkKjq/b/fqjZAUmO4P9d8E/qHZ
         p+dWtEoxm2l3hANeXU8hc5TiW5mG6wXzNbTBnO35XsnmJ6BkILs+mjgaOfm3+P9eSVx8
         Hg4FQaV11nBqVCQ7OSsLtqZ4YW1dmambLOcx8eRPAvTzK7jz3nsjUQMAgdwc8CFjqBSb
         zmQKmg7q004SrSY3TIn3Ws0+Oymv2Icz0A7/dn7yZg4cz+WFwM5xlWTbVEzEUB2NQt7v
         htY5YOeJj5tJ2wuJhspDHektBzp/hyGfrpyIX7y1NYQbaHs02tT5g4SCJQYI/BXkTE2m
         TUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=73GY2ssc7/sItg/k5mLVHEB5CQWhUCwaXe7+KIwXESI=;
        b=du8isTjmwieFS3MYObbzGSdwssXbtAn+jHd8LMDF7nG3AwGEwo3jcYJlTJxBi8uMR6
         dxQorzHn3NwUaTxGG3su4LOlUsDQIqM7V/j2p14tUL13ft1iD3WH/CRs3GL64BE14uYQ
         j4ZPOIyPizMFwiQZA7Bcff89hZ+RV/nhxGnYyiJpQi0sTJ0uSg1B4X4/jDsltMaSCBgd
         tpeR3JPJaqpKJbkzbfwUN/6YyQNCgLt+YOcNZ+hHBc6WiX5unydtJGmPgYcVEfXk3z7J
         r2cDHzaUweMPe+XA+lmMRuVrFyHcGMzKPyzcnpuZPigy8e7vAmIUoE2YDQ7VqATpAR3a
         HB7Q==
X-Gm-Message-State: AOAM533p74WR3j+ucEib17fQcF8yXUci70EkXoJ79Gv4TRFW4YBikhUd
        1XenV5PyRbrPJ00W592LYDls3BKfd6Gb7yIx9MU=
X-Google-Smtp-Source: ABdhPJx9nJBovrmB0T/x1FD1pGu//sJH8FB1eNPsWJIGzY4Z8cetngcbT+a7YpjGPV5FVaf52GqR+KgIEpGsYMWzPHM=
X-Received: by 2002:a2e:a209:: with SMTP id h9mr32508909ljm.74.1635779321685;
 Mon, 01 Nov 2021 08:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjfbfQobW2jygMvgfJXKmzZNB=UTzBrFs2vTEzVpBXA4Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjfbfQobW2jygMvgfJXKmzZNB=UTzBrFs2vTEzVpBXA4Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 Nov 2021 17:07:51 +0200
Message-ID: <CAHp75Vef8QW3Y0yA702KUqPDHNRLN0kCv06=cgPpgPbUeAb-dw@mail.gmail.com>
Subject: Re: Linux 5.15
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2021 at 11:09 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It's been calm, and I have no excuse to add an extra rc, so here we
> are, with v5.15 pushed out, and the merge window starting tomorrow.
>
> Which is going to be a bit inconvenient for me, since I also have some
> conference travel coming up. But it's only a couple of days and I'll
> have my laptop with me. Sometimes the release timing works out, and
> sometimes it doesn't..
>
> Anyway, the last week of 5.15 was mainly networking and gpu fixes,
> with some random sprinkling of other things (a few btrfs reverts, some
> kvm updates, minor other fixes here and there - a few architecture
> fixes, couple of tracing, small driver fixes etc). Full shortlog
> appended.
>
> This release may have started out with some -Werror pain, but it
> calmed down fairly quickly and on the whole 5.15 was fair small and
> calm. Let's hope for more of the same - without Werror issues this
> time - for the upcoming merge window.

Do we really now have any use of COMPILE_TEST=y WERROR=y with `make W=1`?
To me it seems every CI just disabled it because it's impossible to
build a kernel anymore.

What is the roadmap of fixing this (to some extent)?

I remember that Lee spent a lot of time cleaning up W=1 cases. Maybe
he knows the state of affairs of this with -Werror enabled...


-- 
With Best Regards,
Andy Shevchenko
