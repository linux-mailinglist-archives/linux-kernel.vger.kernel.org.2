Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C836420440
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 00:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhJCWL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 18:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbhJCWL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 18:11:58 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354F9C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 15:10:10 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id g41so63224433lfv.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 15:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U9Mf9GI5Pm+kL+VrrV0E+/1cX+8MmlfNpjuTrHIHDBU=;
        b=yz+MMKs016NPuE07ZM/SC+j0anFa+U46jg+mEqlMroGgSo0OVRX/iofinaFE6ejX/x
         VmzstodfD09SW17AUy8oeN4nfpEg1VsLCoPIb3qX1pz40qF5uWpt7PQdZfFt4IkANUkT
         kbO945a/obo21YaI+yunotwvgZA8hGf4DX4wS+5Fqkd9lGVGx6BrKMR9YONncGZPmD2l
         Tay+n7KiAFQIa9c81prLgONI+BqzyXEFY5hXEdfBGz8n4MuJHHMfJAs/nVy7IAfWj2zF
         Od88lzNIPSr8M89btm4C01W7RyiHdr7I1IN5cmBmIA39pWY3OBgpEFZGEJrVPRfiQUmW
         aJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U9Mf9GI5Pm+kL+VrrV0E+/1cX+8MmlfNpjuTrHIHDBU=;
        b=XPmUQ/EJIzAX/Bt7JLajXIPqajNU0k+FAOQ3GsFMT5xw8QyNj/fboHMYRmelXpYEXU
         ORW6k+FypwYc2v0S68vAT3d0IsKABqf67HgP7qLnpfjFns061lMaRmix3W5axrCADSOw
         SfnmT4TmA/R9iadoJVLq1ugrHbXFlwN+wHHf39aaqooZmloD2/hlMrCVkIYSyzOoolir
         HrWjSBvKW8c711/lxFccGJUeTBvS9glPLkgZxQrkFPdE8OnMYCgb2OCsLX+83EZ2ZeFJ
         ZDsmIu33G6xvXUmXoccY2+6rrQEFy/tsuCTyJhKMusI0chM5NuPm+i5c8AKLNwMx9jAj
         unkw==
X-Gm-Message-State: AOAM531dS2b9eGid2fI2WxJZVxWgdqhsWThSQfY5I798SFUWwkcTMxvd
        bihTzriXXf4jrSoXURm8hktGqpypjYW/a+zm23DEIQ==
X-Google-Smtp-Source: ABdhPJwXQxgJnBiCJXHiEECucos6gkDzEYPUpOuN9ryCXhy30bNBzWy6TPluZ4UpN7159wDQXClY4Uo7sDaMjt8BupI=
X-Received: by 2002:a2e:510a:: with SMTP id f10mr12187903ljb.358.1633299008538;
 Sun, 03 Oct 2021 15:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210930232617.6396-1-dipenp@nvidia.com> <20210930232617.6396-9-dipenp@nvidia.com>
In-Reply-To: <20210930232617.6396-9-dipenp@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Oct 2021 00:09:57 +0200
Message-ID: <CACRpkdaO8ydTEkPU4LT+ibzb_-5VEw9mdvMbu+R9cR6zv9MsDQ@mail.gmail.com>
Subject: Re: [RFC v2 08/11] gpiolib: cdev: Add hardware timestamp clock type
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Kent Gibson <warthog618@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 1, 2021 at 1:26 AM Dipen Patel <dipenp@nvidia.com> wrote:

> +       if (test_bit(FLAG_EVENT_CLOCK_HARDWARE, &line->desc->flags)) {

I don't know if it's here or a few other places as well we could sneak
in a IS_ENABLED(CONFIG_HTE) to make sure the compiler will
optimize out a bunch of the HTE support code if HTE is not in use?

Just an idea, I guess it's not the most urgent.

Yours,
Linus Walleij
