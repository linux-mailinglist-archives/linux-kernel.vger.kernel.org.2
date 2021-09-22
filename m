Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85F441515C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237468AbhIVU1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbhIVU1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:27:10 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61408C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:25:40 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u8so16313290lff.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=32+aYzuaFD1O1viEyMAbzrc37otijziLTHIx/x5GVqU=;
        b=bglC1jKwLFWblaCzoqFGj2TZxYkx2+0o4kjbG7EFOH/ZWj79L+2XA4WbYVlaiZPaaF
         p3XlKpu+DswBZY+rQXxwpEf8QQCUMLJZxPq8D1nboHRcPpi+Dl/IeuEPE+NsF0BJNo9k
         fnz0WVF9fzqBHN0ReOA/z8WWB2VX+cNiaifZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=32+aYzuaFD1O1viEyMAbzrc37otijziLTHIx/x5GVqU=;
        b=DZPWOjAM6Xugr9x1y/H96CJBa7xd4gYiWhbMnC94G/A+Pj0VV4bb1D64DudaLruqb4
         evwNurgTQsqJhZVsN6D4Rpbx6AOPZf73IJuQZnRHv7SGgnnF9K+4sYBtj37kVywa1vNB
         vGMemOyV/1ou2vszKY69EVonnn7oDXHEPoQHwGUBqVJOpw9f7FAOSrJsYFbQK9tsNbD3
         P6/CAtJh7smiw/7v8X7VcGILTIYADn36xKF+gP8lD6RTg97TxQuBWAr5+vecXSrCD1YO
         B2bFmk5LhTmfxuJfx/kSPPIPSuQeVa5AitYocTNKqO3Kh6Dv2eyIs0WNs6D4FroMWsdD
         jq6Q==
X-Gm-Message-State: AOAM533Zo9UrP4JcrRyv7dNy2uchBDT9tINa2Ncv9V9x2O7pjyAOpD2t
        KmIVciqpUYTpV0ta5M9OQqu7aLFoZji22eWo60k=
X-Google-Smtp-Source: ABdhPJw7+hm3iNWIZ5nMalh2Bdcw4DtGr+h8XPSlCFaClSGkhTUcZsVbXmkDZVlGaY0Tv/2StyxP7A==
X-Received: by 2002:a2e:a4ba:: with SMTP id g26mr1298046ljm.254.1632342338450;
        Wed, 22 Sep 2021 13:25:38 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id bd9sm361956ljb.29.2021.09.22.13.25.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 13:25:37 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id x27so16955376lfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:25:37 -0700 (PDT)
X-Received: by 2002:a05:651c:1250:: with SMTP id h16mr1357916ljh.68.1632342337491;
 Wed, 22 Sep 2021 13:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210903160302.yh42vpkuob45dbpb@gilmour> <CADVatmMqT1yq3YHBzt4-VsL8uVHUULmy2gpaH27rAqimao2i_A@mail.gmail.com>
 <20210904091050.g5axxctgelciihjn@gilmour> <CADVatmN+9euG5Fegor1+kaSPewbW8vRwBgnxmr5SsK3mOE6FEg@mail.gmail.com>
 <20210920144730.d7oabqfbx7pmyyfb@gilmour> <20210920154333.vunyxeshdb7jt5ka@gilmour>
 <20210920155350.h6624mt65vwg72p2@gilmour> <CADVatmNi+jN+EwiWuoDoocZFyErDVNt1ND0BxtjuKiV63aNuJg@mail.gmail.com>
 <20210920171042.oq3ndp3ox4xv5odh@gilmour> <CADVatmOs7Cc1EdCZXMyXcWM-3-J4bU_3zF1thkOohVUL-G6ZrQ@mail.gmail.com>
 <20210922095725.dk4vk42zb3kh7y6s@gilmour> <CADVatmOMV5gMhCuoP65O9mbW639x5=0+bGh92WVL8FFX2Mvu3w@mail.gmail.com>
 <CAHk-=wi=8Wp31FSyOH5A8KY+7f3dSuP62zUpvTtyvENm1Hh7xA@mail.gmail.com>
 <CADVatmNZB6yjS6zXqUcY4xsUTyX3pa6VysB6RmT1CGV5LXer6g@mail.gmail.com>
 <CAHk-=wh+y=C5hVhE1X=AvZz+OM5Yp8eLHYGth31pfoJVF7UKKQ@mail.gmail.com> <CADVatmPDeSxeY3GTZyC6+G0N76su0E6Y3LF_h6BOcBf5QAtjvg@mail.gmail.com>
In-Reply-To: <CADVatmPDeSxeY3GTZyC6+G0N76su0E6Y3LF_h6BOcBf5QAtjvg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Sep 2021 13:25:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whASMriPYRdH8kxC_UwObBtwHbPvf7rb58sUEZZyaFxJg@mail.gmail.com>
Message-ID: <CAHk-=whASMriPYRdH8kxC_UwObBtwHbPvf7rb58sUEZZyaFxJg@mail.gmail.com>
Subject: Re: Regression with mainline kernel on rpi4
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 1:19 PM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> I added some debugs to print the addresses, and I am getting:
> [   38.813809] sudip crtc 0000000000000000
>
> This is from struct drm_crtc *crtc = connector->state->crtc;

Yeah, that was my personal suspicion, because while the line number
implied "crtc->state" being NULL, the drm data structure documentation
and other drivers both imply that "crtc" was the more likely one.

I suspect a simple

        if (!crtc)
                return;

in vc4_hdmi_set_n_cts() is at least part of the fix for this all, but
I didn't check if there is possibly something else that needs to be
done too.

                Linus
