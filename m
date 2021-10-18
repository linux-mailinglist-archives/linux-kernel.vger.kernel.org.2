Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A044327D6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 21:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbhJRTns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 15:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhJRTnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 15:43:46 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288F4C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 12:41:35 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z11so2127858lfj.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 12:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ItTJzIFWSeB5rmBU+FendnKoekV76l/1a/X4v9add+Q=;
        b=H4wXr5SRERJdoNSWITjR7bS9JJ8gLITCpg+vMJXq4qXSwFNbSx+gnHK00Jms65B6jT
         6Yv6vYSSgJewe1TqJXzXQnFNcavuIwp7zfz/BmMtcec0LgF/iFtBPT749K8tZ6/mkEEz
         q4Dmw54k4oY18+0+EyRdL5k2D8dBprCxl9S4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ItTJzIFWSeB5rmBU+FendnKoekV76l/1a/X4v9add+Q=;
        b=xErSFFmm435oDPs8pVzTJ4puYbg7R11RfOCRHkOO+Hm5AghJRjoxyQh3hf/etsXPYu
         Bq2/4LWw+xJzN3SKg+UzlcWrcoA+pwwyLuo/RvCMuHAAdAEmE2Jl8rYhEpxJAuBPgdCe
         EsdMS7oZkGjbT4D1N5hGHw0ldHRcSd8KSnBFa0jrigqgMCWO8H+HwJ3vZs7F5zhGNseK
         Zeg57KnY8sVgtiSFEA3T6E/uf9psHvVC/2C4wocvrPZn9UxHT7Dih/7QwJNS66MNyq/Q
         sGzx/Hp1wAqjCLQZdR615OtaOQIJkZQduN3GU6D+mzryLC7Qcv2tSgqr9xjN1R/yYx5P
         d57w==
X-Gm-Message-State: AOAM5321YCE63IdNJUMW6BymOD5JCcQ4L+4OKO7PPn4CPpgGgNVpRoZh
        zRtO45ukl/t0whrIpC1b9r3A0uQN2S2PyA==
X-Google-Smtp-Source: ABdhPJxngp3qAyETbHqYslv2txUzqs5SKStN7uM2A0aRjbJMZO8UUtNhqXgHo4RaoaHMpdCPizkkeg==
X-Received: by 2002:a05:6512:304b:: with SMTP id b11mr1697806lfb.259.1634586093320;
        Mon, 18 Oct 2021 12:41:33 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id o15sm234715ljm.139.2021.10.18.12.41.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 12:41:32 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id n7so1734351ljp.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 12:41:31 -0700 (PDT)
X-Received: by 2002:a2e:5cc7:: with SMTP id q190mr1848523ljb.494.1634586091557;
 Mon, 18 Oct 2021 12:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20211018182537.2316800-1-nathan@kernel.org> <CAKwvOdn4_DrgaZoAo-v7CbYurNUpfAK5tnzT023=WCDzkmYQVg@mail.gmail.com>
In-Reply-To: <CAKwvOdn4_DrgaZoAo-v7CbYurNUpfAK5tnzT023=WCDzkmYQVg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Oct 2021 09:41:15 -1000
X-Gmail-Original-Message-ID: <CAHk-=wi7hUsTTcmPfZCkUEw51Y3ayq3JJxzFsNgodsxxDyk9Ww@mail.gmail.com>
Message-ID: <CAHk-=wi7hUsTTcmPfZCkUEw51Y3ayq3JJxzFsNgodsxxDyk9Ww@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Fix bitwise vs. logical warning
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Tor Vic <torvic9@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 8:34 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> LGTM, thanks for the patch! I guess this would be the first
> "interesting" case this warning has found in kernel sources?

The patch looks obviously correct (tm), but I'm not convinced that the
warning is actually all that interesting.

The thing is, using bitwise operators for booleans is _exactly_ the
same as using logical ones as long as there are no side effects. In
fact, any compiler worth its salt will already convert some cases
between the two as an optimization just as part of code generation.

Of course, that "as long as there are no side effects" is the big
thing - then the short-circuiting of the actual logical operations
clearly matters. But that wasn't actually the case in this situation
(or in the kvm situation elsewhere).

So in both of these cases, the difference between "|" and "||" ends up
purely being a hint to the compiler.

In this case, even if there are no side effects, it's clearly
pointless to do the second strlencmp() if the first one already
matched, and the "||" is unquestionably the right hint (and honestly,
most compilers probably wouldn't even be able to tell "no side
effects" because it's a fairly complex expression - but since it's
inlined and uses compiler intrinsics, the compiler _might_ actually be
able to see that the two are equivalent).

But no, I don't think that warning is very interesting. In fact, the
warning might be overall detrimental, in case the hints were
intentional (like the kvm case - although I'm not convinced the kvm
hinting was actually meaningful).

                 Linus
