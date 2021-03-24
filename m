Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7258D3476B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 12:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhCXLAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 07:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhCXK77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:59:59 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0728C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:59:58 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id o66so13639193ybg.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XpM1cY5sp/JjfTRcv3P+ap8JQE382RgH0KIhA5k3QS8=;
        b=Tz5fPK8P75R7FEsjpgShKeQ7oHZ93q/z5JoKCuYylT29KRFsRV+opntbKuVlTr7veD
         NiF6t6nIGVcaXdtGOtoOhXQIk1Z9RJt6Vgyv4U4KYorBsMvOocLOryGuIyxmlDC7P3o3
         f3kYOr16eRue/xKzrgWZTpb1jhSXxgTFtfsa1Cn1AU1enUG0W+CWdBuc8cBcNhWIwgqF
         zZzvHw4yko3f7Grruj2dCFaWOxbakospmSUauWThvSfCyEN6T8TYfaNCXI2LRai6rMcK
         O3tZBl8LiaO0oNi2BSXYpw/sIJGpln6lk43sfOMFtD3P65gIKEM5oILtx/g9/gRRUf5Y
         PY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XpM1cY5sp/JjfTRcv3P+ap8JQE382RgH0KIhA5k3QS8=;
        b=k+iE+a+DQ647q+VJatxLUXwzxa0qBP50bKt+Ecy+3tK6RFq0e+KE8TKoeQSgbFv1JT
         GoBVosG32A/xHLgTdk3P9yzjjuSbTl/sn2nn6a7jlHAmZDkuDjSxChVjpzDuBHJaPQ+2
         lj9Y7rnBKAeRSGpGFwnAyIvK4rOX50Qn1nIFMntDwunm6eLM4K9z3TWiwcclwqkDvCto
         oggRwUwKrxi6M3fi5ok3j68GOHwSs1YmFKmvud8sxQBDh7bmhNqoBvThMvJRcqGxIHRw
         3aWU29QOSqo9blIJWvryAuLFzlH4zzkHyijASV4HQ3GRHmwZdCES/b/Zh3gXguHEQDIJ
         C7qQ==
X-Gm-Message-State: AOAM532wiVtR9BTNPM+tOdntaDTeX6T/9nIlE5u/5u02hZRyAsktzVeX
        ZBxY3OiGni+aiPWog3wR+ENQIERrs3ZliIyeC7Y=
X-Google-Smtp-Source: ABdhPJwcWCICXHjRMJ3mw+jZxwHmdog6sQ6QVsJhRxioskIJCgKKj+5nsHraVgAP++u40ExObhTJIpjGPM+jP2qBg/A=
X-Received: by 2002:a25:e748:: with SMTP id e69mr3942809ybh.93.1616583598250;
 Wed, 24 Mar 2021 03:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210324054457.1477489-1-masahiroy@kernel.org>
In-Reply-To: <20210324054457.1477489-1-masahiroy@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 24 Mar 2021 11:59:47 +0100
Message-ID: <CANiq72kb6sVQXVx6a5NwjFfrfJVZ35KVpj0xV8E7DU1SRV3AuA@mail.gmail.com>
Subject: Re: [PATCH] treewide: remove editor modelines and cruft
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Wed, Mar 24, 2021 at 10:57 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The section "19) Editor modelines and other cruft" in
> Documentation/process/coding-style.rst clearly says,
> "Do not include any of these in source files."
>
> I recently receive a patch to explicitly add a new one.
>
> Let's do treewide cleanups, otherwise some people follow the existing
> code and attempt to upstream their favoriate editor setups.
>
> It is even nicer if scripts/checkpatch.pl can check it.
>
> If we like to impose coding style in an editor-independent manner,
> I think editorconfig (patch [1]) is a saner solution.
>
> [1] https://lore.kernel.org/lkml/20200703073143.423557-1-danny@kdrag0n.dev/
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

+1 It is great to get rid of those.

For auxdisplay:

    Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

For the rest, I did a quick visual inspection and didn't see anything wrong.

Cheers,
Miguel
