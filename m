Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C92C413686
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbhIUPxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhIUPxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:53:10 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FA2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:51:41 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id u8so31082525lff.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MkXHPdAhcSE9xDW+80D8agbOXNet4KTl5XiQgqDc2zU=;
        b=dNbgvD29tC2jUZsEa3i+j+nIi9D95c8p0MK/WQzBzOClcuGGXW7wpbRLTBrDk7DmjD
         Sb118SK/qk7m8bWiR+g1Pw8CcoseQ7zFkwnW2aqxGqiCEu9oTnfyJlkH1klP+Thl9qi/
         GiAXkH9gIriuboqjjRbzCA93XMVIMIO4/rHjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MkXHPdAhcSE9xDW+80D8agbOXNet4KTl5XiQgqDc2zU=;
        b=obDn0OWobaTAqvqmggeRL0vy/0PiTIJdJiQQaUQRKMZwoX8pivmXi5J1rREQOhoI3A
         nEtUHaZJh6OWJfvC+hpf0x4taPmMN4+JnmTvb0EQPTLNMZZcGxrizF+eUl+vpdsxXAO+
         OLJ5U98vmWtxku4jmPmc86x7sbaJ0QpS79DWnLyMhFlEwML6DifGVnlK/FZecS+9YNo3
         hCe0e34UMo5swcHQtVAthrhc79kKYhkB5KvgBol8MgdVC5OKGdw/hkunDUChEp6TchXt
         wBbELekMnNkIFWDZabkYl/mR++mo/LvQ6t/7TLM3C5aqmdKGs4LZjYPeYdgq9jpitnRi
         qxUA==
X-Gm-Message-State: AOAM530K5yFVkJ10YWS53qV/zxurjMHwS54q33hG3IwSUZOQa93xPKWN
        o7iRUge65v4gbamB5fYvQv+WRAzVKUK3oEJdGoo=
X-Google-Smtp-Source: ABdhPJzsh31H8e+HQxapAu58r27miyPoKtXZeh/IV6H1uD23rtJurQzwIMoJg6n9LejaiM2y0uTFCw==
X-Received: by 2002:a05:6512:128b:: with SMTP id u11mr24275068lfs.24.1632239486692;
        Tue, 21 Sep 2021 08:51:26 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id s25sm188982ljc.100.2021.09.21.08.51.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 08:51:25 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id b15so64596605lfe.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:51:25 -0700 (PDT)
X-Received: by 2002:a2e:bc1e:: with SMTP id b30mr29184070ljf.191.1632239480629;
 Tue, 21 Sep 2021 08:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210920121208.54732-1-arnd@kernel.org> <2955101.xlVK0Xs8nM@alarsen.net>
 <CAHk-=wgaaUgz58Avt_W=7mAsp1DSoLh79mkcGASa-OUbPmjvVQ@mail.gmail.com> <1700211.4herOUoSWf@alarsen.net>
In-Reply-To: <1700211.4herOUoSWf@alarsen.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Sep 2021 08:51:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whj5m992Qj0goO0s=qru+5JpW3NdfjoaSsp8vhTUg6wgQ@mail.gmail.com>
Message-ID: <CAHk-=whj5m992Qj0goO0s=qru+5JpW3NdfjoaSsp8vhTUg6wgQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC v2] qnx: avoid -Wstringop-overread warning, again
To:     Anders Larsen <al@alarsen.net>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 8:49 AM Anders Larsen <al@alarsen.net> wrote:
>
> When it turns up in the tree, I'll cook up a fix for the strlen() issue in
> fs/qnx4/namei.c following your scheme.

Now pushed out.

            Linus
