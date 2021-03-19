Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4D6342542
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhCSSsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbhCSSse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:48:34 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77004C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:48:34 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id h82so7248960ybc.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Jx5P65OeVrEQ8kuUn21jtcWHeaKuOd31GWQKeBE+FM=;
        b=D/4Lb6zRCgUoWomlWOVFdebRuBNeCeLilkMZb8RLWJ++BiKdxi3pNxHn61wS0wEV3r
         cNQjM9t5APs9Wn2e0iUZvMxeVUM8vLmsyVxtq8VUs//avMGDKXOpioA0kslxa7ptgS2K
         kv84897sQrHnLhAJvNWPoj1WFFho4hajITeqr2fN7ut02L4TUxJJJHJBPHuEiwEc48tY
         m1S0NXtMSrO8upbO3uBhPo8oj25UhixvAo7D8IDd3EE5z9AQWdgIxZwUa7YJ5EMVqcxS
         ihC7R2NBHsoGZbdzIabqs6WQRcr6P2tLFuDfH3VtY9ghCV9juq0/DBRfTzVm69rZ6kP2
         r7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Jx5P65OeVrEQ8kuUn21jtcWHeaKuOd31GWQKeBE+FM=;
        b=D2GgVzTLBqmDchnK/OkK3LuSoOYbOmB+3Lt9jUgnVHvzWkLZYYAG9BIm3vdFS3gePH
         rr6vnNkbuyavKvO8akakLXrdl4P+vEfOoSOIUhlDU60l65GgsEmpLl6M+I005C6cW6Uv
         3E/w//keDLmo+dNdaBmRQD/i0TfWa3QGsHSiMbxeEixBzgMu1fKdyh5ozdyiFeFQjeYs
         ZslbL9eAYYarA9Kw78UfE6HSEYjs9tLmEgbrmw6pib5gQt6z3N2BoeDNNN+Elzn6phTq
         sMN1ULsQS7xPPNrAbHQn+QfnG+xhauiH3ZCuxZsmTABAo2yazJHdVrcngGz4i8yNDIG+
         46kA==
X-Gm-Message-State: AOAM5325XMD1A06//M5pQ88cWoNoiK6FBSPgaJL/lzOz8GiyaXQpb7lC
        3VNx0BVr/ZLUAwT2MiH01opSqXm6gHB14Ph568U=
X-Google-Smtp-Source: ABdhPJyIYVSCRXYX+a9DpKNDd9bqT4gphyuroGc+5OVH1NvPLhmcDKLw0kfJL9EfA0hOZ3CzvBSXgg9wSLroymbWIgg=
X-Received: by 2002:a25:844a:: with SMTP id r10mr8760319ybm.26.1616179713902;
 Fri, 19 Mar 2021 11:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210319183714.8463-1-ansuelsmth@gmail.com> <20210319184234.jsudy6solmtrq6vz@archlinux-ax161>
 <YFTxOcf56lPBi2sb@Ansuel-xps.localdomain>
In-Reply-To: <YFTxOcf56lPBi2sb@Ansuel-xps.localdomain>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 19 Mar 2021 19:48:22 +0100
Message-ID: <CANiq72=sEtv6-uMqY5QqpHSEqZnMj=6VrhgyFE2a=wZy=+_SEQ@mail.gmail.com>
Subject: Re: [PATCH] clang-format: Update ColumnLimit
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 7:45 PM Ansuel Smith <ansuelsmth@gmail.com> wrote:
>
> Sorry, didn't notice that. Considering that checkpatch complains and
> some reviewers actually state that 100 is the new limit, I think it's
> time to update the file.

IIUC, 80 is still the soft limit, but 100 is now the hard limit.

Cc'ing Joe.

Cheers,
Miguel
