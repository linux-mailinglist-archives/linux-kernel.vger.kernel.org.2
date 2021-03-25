Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338CA34996E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 19:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhCYSXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 14:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbhCYSX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 14:23:26 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0288C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 11:23:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id v15so3924462lfq.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 11:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aWd60XOby/g8jwc4Pu4WsrQLPuqRg22p9eHk3Bl4Mhs=;
        b=AY1BKKtjRLIrYTRxTnPb92tt0ayAa5COOUtIQpdpbJtbinoLC0XYie03CbA10mKWIg
         /OzQXXhS3OV/jIAwiGfYahxk9EkT5rHgpS02WU328E2PgEeXtfhBjFACOsGo9+b7bzFl
         NCnZbz2L8G4QuO9+OZwOZKBOMEsaKxO13nniI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWd60XOby/g8jwc4Pu4WsrQLPuqRg22p9eHk3Bl4Mhs=;
        b=Qu6FSrYkFJ8U7S1XNJhv3WIjOKw00SMJ23JF3iuXZw0xLJu6kldM8jB41qS2NEIArd
         mdxcg2zLIGkoKXmLyR99jByMKFGNJHoy57n5fGl2X4ubLaXNfNAaZRqsKn+3gJhONYm1
         9J60qtluujFwjovxa96zaL7YNVBXIdKRig/uOGrqL1g4N4xdbeVtfYjvkoL//rWvwzsH
         f1LflSHP6ao5ENpnfwnaVXtpjv8BeXAsUKEE/FAV1cWTXc7PtN7Lg5ODIdmE2wkqff00
         Uc27OaVv0X3yWt4mNa4nYM7FhpH11+6O+R8qJJmpL399W3NluUaD8FASsnW9s/fcY8mc
         fK3w==
X-Gm-Message-State: AOAM532SKFV/phVg52kbQXqM9Q11kQWLXMuhzl8ybsL6x7HBQ2kGmoGw
        0e9gmcjawlafno6sRJmXf7qXret86f8uSA==
X-Google-Smtp-Source: ABdhPJzk+130m6vQ6kI8EnjQgJxCWg1F/tecKrTuRIS8cNRCKvSFn4ioIQpqdu0crV+DHvc7EkEyug==
X-Received: by 2002:a19:6c6:: with SMTP id 189mr5992418lfg.426.1616696604012;
        Thu, 25 Mar 2021 11:23:24 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id i7sm856901lja.15.2021.03.25.11.23.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 11:23:23 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id f26so4367157ljp.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 11:23:23 -0700 (PDT)
X-Received: by 2002:a2e:a306:: with SMTP id l6mr6293084lje.251.1616696602756;
 Thu, 25 Mar 2021 11:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210325163358.GU2916463@dell>
In-Reply-To: <20210325163358.GU2916463@dell>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Mar 2021 11:23:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJxziChniE2zmkbFxEpizYFg=XaKyq_O_Rfh_Lr_idkw@mail.gmail.com>
Message-ID: <CAHk-=wjJxziChniE2zmkbFxEpizYFg=XaKyq_O_Rfh_Lr_idkw@mail.gmail.com>
Subject: Re: [GIT PULL] MFD fixes for v5.12
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 9:34 AM Lee Jones <lee.jones@linaro.org> wrote:
>
>    - Unconstify editable placeholder structures

Hmm. This does show a real issue with that gpio driver.

It does garbage things:

  static int intel_quark_gpio_setup(struct pci_dev *pdev, struct mfd_cell *cell)
  {
        struct dwapb_platform_data *pdata;
        struct resource *res = (struct resource *)cell->resources;

where that cast is exactly because "cell->resources" _is_ const, and
the driver violates that.

This horrible mis-use of a const pointer is why the original patch
that got reverted didn't cause build-time warnings.

Honestly, I think the right thing to do is to get rid of that cast, and do

        struct resource *res = intel_quark_mfd_cells;

instead, so that you clearly edit somethign that isn't const, and so
that the compiler would have warned about the whole constification in
the first place.

This broken pattern shows up for both intel_quark_i2c_setup() and
intel_quark_gpio_setup().

I've pulled this, but I really want this kind of "take a const pointer
and violate it" crap removed. It is *only* correct if you know exactly
which pointer it is, and then you should just have used that original
pointer in the first place (ie use that intel_quark_mfd_cells[]
directly like suggested above).

           Linus
