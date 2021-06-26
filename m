Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE603B4EFE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 16:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhFZOcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 10:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZOcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 10:32:31 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE56C061574
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 07:30:08 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id b64so9486197yba.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 07:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SLJ4iP2lmTeTTHk2X4PtVqFQeH+zVixpyO5Oj7RolW4=;
        b=m+8wB5fMPcLr5kUHfaHhvYsT0BVD8j1cr1UmLg40EXT4yxN0/XoSyYUEzDXXj32LyB
         zqfn2nBRUGDWpoOMu+p8oqbqaF3o6o8yz6GJvetdy9WPvoJDq4//vPDKCzu+qaaSMUSS
         mYvAczRRCTcdIP9mBIEsng7QXyjvNF1OCZis66xVyhv+UQOzXIsyNPz/Jz/2w3RCM4Q0
         3sqzPlX+xECm7rfsY6TWxj/JX76UqZfcmIhZySUZGJT24Dkw49HEf7bfc5w1HZeLG9sr
         EfEMYt6EeGeEBsF+u+1Zp295uqv0WqF1+uKvPnz/ILDclk5SvljhHahFnO5IiylvbeLk
         oF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SLJ4iP2lmTeTTHk2X4PtVqFQeH+zVixpyO5Oj7RolW4=;
        b=gTbMX7clF+H2VZRdL+2BNDB/zlNn5NKagadLPS1hW4K/ctqKj3W8c8HG86QUGOP9S9
         UmJmS94BDKVSub6LtTU8uAGBGSZek7w9lV9ARK7rGsXDCdldGu90FJOQM8ehUYaxVMXK
         9vIHKlTncTfuKVbnY2Iy2OtNdUkv+Zevy//2o/69qlNvl1uFa18gN14J4rH/SoHgSLV0
         8ZuFf0YjzIM1zPP79oA8jgla+K/o2bt8detNzrNEf0pWJcyssjwQ08qllra1/yFuX5un
         XOTNlboaHAV2ao9Pt5qr6aWqKPYOuxY0Brz9itRP2Ue4j4LZW/+rAz0LfvLkWuy2l0TW
         jCpg==
X-Gm-Message-State: AOAM532PoONNJNZh7cxBZ6xhCsWASn4m8rBe8BkYoy6Tlmk3CgWrcDiO
        sQyKrOM/tojYD+dmfSPSXtYyq+EEfQIGlVAINqU0AyIR+jQ=
X-Google-Smtp-Source: ABdhPJzq6dOQ4VBu1IrkfIzybpz0O655Q3Jz4fPeibQBH96gHuJ0EJCGQX8HoxUnvce3NeeDYB0F5oSCk5jBFaFT06U=
X-Received: by 2002:a25:7704:: with SMTP id s4mr20237026ybc.115.1624717807520;
 Sat, 26 Jun 2021 07:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <YNYz+hVeqsQmiEqN@localhost.localdomain> <CANiq72=qtAcsyReu85AVT-cSf3dcvbnTpQYEF1JhxCRP0WgHUw@mail.gmail.com>
 <YNZGNvGn/pkMhsx+@localhost.localdomain> <CANiq72=HCKAyuLD3anAuSug4s0MKMHwRXdMPt0pNs-mTxD1CXg@mail.gmail.com>
 <YNbMyXR476FvEPaA@localhost.localdomain>
In-Reply-To: <YNbMyXR476FvEPaA@localhost.localdomain>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 26 Jun 2021 16:29:56 +0200
Message-ID: <CANiq72mXfLKLWTdRc2LpH-FyvsgKedEw6=Yr2mchE8MhFUOEqg@mail.gmail.com>
Subject: Re: [PATCH] ELF: add and use SUPRESS_WARN_UNUSED_RESULT\
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2021 at 8:44 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> Sure. But then developer needs to include another header to use SUPRESS_WUR.
> As posted, attribute and its suppressor go hand to hand.

These headers are automatically included in most places.

Cheers,
Miguel
