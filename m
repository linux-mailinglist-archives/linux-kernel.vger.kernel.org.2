Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B5C308FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 23:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbhA2WKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 17:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbhA2WKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 17:10:11 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD40C061573
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 14:09:25 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id v15so9237149ljk.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 14:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iWBzIR5PaI5tM3y8BQu5EjvLRWIMPZLVJ4ojQMb/AW0=;
        b=IW9DvVSIJvcBOBL5VyzFUFL4kdynrmE1fKlD8O8oqCwRkB6ijSiNzSzoXXOblVIpUO
         k7XKGQzgzsAg6ys/ZfVFiHeBOyTG58mBP6axOBltLKWFGgZCVHtQi3luMp2bifVPoHG/
         Dmw2l/Pav0SejxBpopjGoiN0gJiIHQV5N/Xu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iWBzIR5PaI5tM3y8BQu5EjvLRWIMPZLVJ4ojQMb/AW0=;
        b=C8p1iJVywk9Y392u8xH+a57hHwl1UWzaYFEsfqG5v0W2F3d4VV8bwdhHEWgmhsbYuJ
         JEyU7/zojBWsEEFufRcg6J0Fc8x+UCclITnqxb/5WKjwosfjtNS41zI+D49QI+j6BqNt
         XSXtiZpVrM7SZMfCTkRjnvDPwvIu3g1E6IMz1oacXWsXB/yZgoDab+mXBf2SdFu/Jc3Q
         Yesdkzy6SDn5dDTbhAsG3NW0CqBg/CvCApLfqXIy7V5l0cRqXrficOY8yJ7LXObNr3BT
         klmJ79Sm7+f0MZC5i1GXq1NorekLB2rYK1wHVNIITPSKZOuPCmueUykBM2mittzIdXDY
         TP1Q==
X-Gm-Message-State: AOAM532pEDPm2FzM9cSzxUcN0fyENaTKBomooCzavnciq4K+ud/EcJVj
        gHlXhUIV4E9A1jyCTyZKbx+wi1+u+HZVUQ==
X-Google-Smtp-Source: ABdhPJzCUhpPtmdUH/JWCo1ACWiMj1V/TFIkqrvPNSyJYGkRpDPyBeYkzv0swKywDWBmcgMhWMz6kw==
X-Received: by 2002:a2e:952:: with SMTP id 79mr3634148ljj.289.1611958163679;
        Fri, 29 Jan 2021 14:09:23 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id y7sm2166601lfy.39.2021.01.29.14.09.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jan 2021 14:09:22 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id b20so4376237ljo.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 14:09:21 -0800 (PST)
X-Received: by 2002:a2e:8995:: with SMTP id c21mr3379696lji.251.1611958161381;
 Fri, 29 Jan 2021 14:09:21 -0800 (PST)
MIME-Version: 1.0
References: <20210129190322.GA4590@gaia>
In-Reply-To: <20210129190322.GA4590@gaia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Jan 2021 14:09:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh=1K+i6cd-Y_St3ktJAdrqriXf=ct-DcFUR2GkrraLaA@mail.gmail.com>
Message-ID: <CAHk-=wh=1K+i6cd-Y_St3ktJAdrqriXf=ct-DcFUR2GkrraLaA@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 fixes for 5.11-rc6
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 11:03 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> arm64 fixes:
>
> - Fix the virt_addr_valid() returning true for < PAGE_OFFSET addresses.

That's a really odd fix.

It went from an incorrect bitwise operation (masking) to an _odd_
bitwise operation (xor).

Yes, PAGE_OFFSET has the bit pattern of all upper bits set, so "(addr
^ PAGE_OFFSET)" by definition reverses the upper bits - and for a
valid case turns them to zero.

But isn't the *logical* thing to do to use a subtract instead? For the
valid cases, the two do the same thing (clear the upper bits), but
just conceptually, isn't the operation that you actually want to do
"(addr - PAGE_OFFSET)"?

IOW, why is it using that odd xor pattern that doesn't make much
sense? I believe it _works_, but it looks very strange to me.

Also, shouldn't _lm_to_phys() do the same? It does that "mask upper
bits" too that was problematic in __is_lm_address(). Again, shouldn't
that logically be a subtract op?

             Linus
