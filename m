Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B0432629A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 13:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhBZMTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 07:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhBZMSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 07:18:21 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9472C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 04:17:40 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id f4so8678938ybk.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 04:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HoZ68kY0XQwDeDCANByqTI4iwGN2Nd1i1e8s2bH1WW8=;
        b=o+CqHeDt5pmYVYJ/05gL59lL0bPbsrrN0T3nU8UfUEImdcfOZbT9CTSAoGNLsXfrDm
         9T5KbmIMi6CQQ+A99OplJ6mVt00E9vOVvAmeNeWx5kJnTAEOIVK/pGTCtrSRD8hiwH1I
         Bp0eCFtjYFF6IVdoSeErqJ0Qd1qSsVxaO9ZbKSmnfdE0Zu8XKIGPzKrol7Zur0H0zaCS
         cY3VHjRgTpBu4yl7opiNzN+ZgsavaUrOk137bW2tfi2OKZP3au1f6SA5WW2abm1SfeRE
         tLjFTbRxD0MirOkxLYtKJNTYOQVX/SyBU2DFtVgdYMmqFDD/rmiF6ZpkgtxQ13RxU3oi
         mmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HoZ68kY0XQwDeDCANByqTI4iwGN2Nd1i1e8s2bH1WW8=;
        b=Zn6d1HDZv/GgdBdplOM3eA6WLfODfwAcSPWKw9fIVZutnDGSWefknHIJXpxdxeyc+l
         0L5uy4jBv7d7ZDNUVnEBytkbsC62HIc+amziBKAxrjh2iwieaAeH+npzIYRk8BShqiTE
         IZfdtNb2AYj3BeRXnxfBENR2Yx9WLffusphaYWTe+47P0mLz4PSHYoaDlxzopR1xnntE
         leWCPCd6B/jZxOIvkgb02WovxPc5bqZvaxbeos6+Ea1UTVkIB/6Kk5yE5h5hl31hjnci
         v5a2p2jsuvaR4CAtRvgNgwajp5SFC6SCGks1Y8RUbjeyuyvwVeBk+UyQFL8jtsvOMe+d
         hwuA==
X-Gm-Message-State: AOAM531z/FZsyupdxHk7SGL7YrHnE1jCPnphzzUxvZU/MBZTVnYoIfeb
        7AKUe7KhrPAFVaiva77Z3JCDPW1vEJNq3Ruy0rE=
X-Google-Smtp-Source: ABdhPJxqweQvGLoe6Uvw6UvTcBSkYdiQcqkZDKBQCKaCpipjFL+lIfKMxMfWwYkdhU44w3QDNIBYL5CDWxvQwcu5Q/w=
X-Received: by 2002:a25:b91:: with SMTP id 139mr4028360ybl.115.1614341859620;
 Fri, 26 Feb 2021 04:17:39 -0800 (PST)
MIME-Version: 1.0
References: <20210226092236.99369-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20210226092236.99369-1-luc.vanoostenryck@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 26 Feb 2021 13:17:28 +0100
Message-ID: <CANiq72kk96cwBWKRN8iP_U55h5=F6nX+ke8HQ--xHLhDtqBEjg@mail.gmail.com>
Subject: Re: [PATCH] sparse: can do constant folding of __builtin_bswap*()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 10:22 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Sparse can do constant folding of __builtin_bswap*() since 2017.
> Also, a much recent version of Sparse is needed anyway, see
> commit 6ec4476ac825 ("Raise gcc version requirement to 4.9").
>
> So, remove the comment about sparse not being yet able to constant
> fold __builtin_bswap*() and remove the corresponding test of __CHECKER__.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
