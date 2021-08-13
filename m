Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5375D3EBC54
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 20:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbhHMTAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 15:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbhHMTAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 15:00:01 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97355C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 11:59:34 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id d4so21516353lfk.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 11:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IkdhgNopT40xrLBIwsMwp7xot6YqUnlD6M0VTKI4Un8=;
        b=RLK3xUK3bEGpxgGuy1zLolLiG174+veKzBMATo6QlHmzBHc4J7r7zCAZaKUOnlyT3o
         VhYwJ3Dx9F5/D/0a7GzWt9jrGNDOoZ8bho0cljj00lDq96HAG+bvY8CiNZzDH16DBggV
         ETTzc+DhoDUeqllck8NFAwJ3jcXzaKpEEY2xzibqOz5w65AVE2C+smEKwXifwitKkWTO
         HkW00sUVzMhd3rB6NawIR1ih56hnF7xc8LfK28j4eXhMl1zoxI9RY5dFb3t9RAsXtOBg
         bxbshxVCu038Y8Z2Mm1wI29mVQo4QZ4gAk1o0x21UliOhLVHA3NV09KWJFkC7Td3wn8D
         LUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IkdhgNopT40xrLBIwsMwp7xot6YqUnlD6M0VTKI4Un8=;
        b=Aj8t+gmt9ndsfIFFwZ7DpDkCFDAJt2GaluCCD13OywJTZkBWprtD/9ZUWrz9zrCI/G
         VIPacvRQsEfoevLyahiJous4fAH/ixl2gRI4ts2IRN/yP5t+dCMdAWsHuOaWKEjGjEPr
         9PxiQLPGye4GsIy5qosk5LW5RyF3a9A9bTlgn2bk/WkhNQRfwUP66MeSLQJ62iPW45OD
         RBAOMYKkW1GAQo3DLYc9IvC/We2dfRtoV3kDrdI9tLjq3zYBckDVaA9OI7s/WYw2UUwF
         GMbYuFjEDOEAPl9X9y+HZqm2UYoCiPbAlUs726Q8B4tWy5g33UP4lVKiNkFTZgvs13Tj
         9oCg==
X-Gm-Message-State: AOAM530I0Vf/SOdUo5RoKCbzyDNdtxx1KXPjRtIXvNdPkVcgkbNHebyu
        Bt0LpG8TZMssU7QOaPYmTJCHu+xp8Rf3gbFz80v0Dg==
X-Google-Smtp-Source: ABdhPJwsIOeMmC9VnBS83ZxAW4s1cMc3L/OGiW0XzMjYW2gzyzggGU/mQ9BcfuNqon7n/4/vbP5xAEnVWftjqmyMi4I=
X-Received: by 2002:a05:6512:3041:: with SMTP id b1mr2588473lfb.122.1628881172555;
 Fri, 13 Aug 2021 11:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210812204951.1551782-1-morbo@google.com> <87sfzde8lk.fsf@linkitivity.dja.id.au>
 <CAGG=3QUz2LNgC8Hn6rU68ejjv4=J9Uidef0oH9A7=sKTs+vf7g@mail.gmail.com>
In-Reply-To: <CAGG=3QUz2LNgC8Hn6rU68ejjv4=J9Uidef0oH9A7=sKTs+vf7g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 13 Aug 2021 11:59:21 -0700
Message-ID: <CAKwvOd=rN9s5YBtt-AMnaqXhYCsAT=6yp29_oomRvTaev6Q6zw@mail.gmail.com>
Subject: Re: [PATCH] ppc: add "-z notext" flag to disable diagnostic
To:     Bill Wendling <morbo@google.com>
Cc:     Daniel Axtens <dja@axtens.net>, Fangrui Song <maskray@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 11:24 AM Bill Wendling <morbo@google.com> wrote:
>
> BTW, this patch should more properly be attributed to Fangrui Song. I
> can send a follow-up patch that reflects this and adds more context to
> the commit message.

Sounds good to me. The TL;DR is that LLD has a different implicit
default for `-z text` vs `-z notext` than BFD.  We can emulate the
behavior or BFD by simply being explicit about `-z notext` always.

Or we can dig through why there are relocations in read only sections,
fix those, then enable `-z text` for all linkers.  My recommendation
would be get the thing building, then go digging time permitting.
-- 
Thanks,
~Nick Desaulniers
