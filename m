Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FBC3FB904
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 17:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbhH3Pci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 11:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbhH3Pcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 11:32:36 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC299C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 08:31:42 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id c8so19464405lfi.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 08:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p0kOZNrasloq0VyNOKkM6VkVzIYu/+jMAU4U9uSDKVQ=;
        b=YERcgoTLA5AXdTVRuoawvzo7fkitkBZX7e6CVaUMsgF33ZBZjfsE+0Lu+IGYBKFQgR
         C7Fir0FnEyxCZxlq/Cr9tP4I+u3XWNG+Uy1rNysPbFI9NO12/PbkXyuWneAG9vLBXk1g
         aTEkQfk+NScRj3ASxntN07hkyehX6NUU9+N4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p0kOZNrasloq0VyNOKkM6VkVzIYu/+jMAU4U9uSDKVQ=;
        b=npeBwQWuabPfaDRX8Hw7agTe6bIc9ln8GBOHjIE/eHtfZboA3knGNBISFJ8HvTl9Gi
         05nwK8rc0nQMzwBbETn43sjXYWJWEDNm5RBOy174sQi2Lb+HSzEedNgHfQABf43v6lRs
         lroQnxSwbYnl/1lK8sAWPLJFv6gHloXksFUpe2ZjDbX7mqzw+0rx7knq7sVKBvi2Hurh
         6XeW0Noa5ej2yZeqhsTdrlD6ININzVCLF3MJ0GW7HzhkgaeIxcaEpehDhG2gFUZI18eT
         v0tCqnIIaTLUuqn9QiHfKBOe5z/Rf70ciGEJItV00DqHa5V7y97VEIifR/9UY6DqgO6H
         ez3g==
X-Gm-Message-State: AOAM530PPTpyQ8WqvgGaFqnbZLRL3Szw4cn/LDpjXvVvYgen0xlSMdyk
        2K40oMhTR2gwFNz+XWFe60YfaGjdAtGi1Tkg
X-Google-Smtp-Source: ABdhPJycavh25DgsB/gacP+5KXEa+jwlXeGtcPSn/lKAGjAIHRyT3fos7imkzl+4bXPiXAdBKN+YGA==
X-Received: by 2002:ac2:482d:: with SMTP id 13mr5672324lft.120.1630337500717;
        Mon, 30 Aug 2021 08:31:40 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id d13sm1420014lfk.232.2021.08.30.08.31.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 08:31:40 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id i28so26606027ljm.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 08:31:39 -0700 (PDT)
X-Received: by 2002:a2e:7d0e:: with SMTP id y14mr20881081ljc.251.1630337499647;
 Mon, 30 Aug 2021 08:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <YSydL0q8iaUfkphg@schwarzgerat.orthanc> <0f094eb9-11d4-1bd5-0a1b-823317ad4f7d@kernel.org>
 <YSysHCQyN+brJLEj@schwarzgerat.orthanc>
In-Reply-To: <YSysHCQyN+brJLEj@schwarzgerat.orthanc>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Aug 2021 08:31:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6-HbEPEC6-Fz0kqnHsB4nZryWi5TEZEN=NCWzBtg4iw@mail.gmail.com>
Message-ID: <CAHk-=wg6-HbEPEC6-Fz0kqnHsB4nZryWi5TEZEN=NCWzBtg4iw@mail.gmail.com>
Subject: Re: [PATCH] console: consume APC, DM, DCS
To:     nick black <dankamongmen@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 2:59 AM nick black <dankamongmen@gmail.com> wrote:
>
> Jiri Slaby left as an exercise for the reader:
> > So simply:
> > return state == ESosc || state == ESapc || state == ESpm || state == ESdcs;
>
> Sure, I can do this. Would you like me to recut the patch?
>
> > I wonder if we can simply hide them all behind single ESignore?
>
> I'd rather not--I have plans beyond this patch which will
> require differentiating between them.

I've applied the patch as-is since I'm starting my merge window work
with "random patches in my queue".

I'm not 100% sure we care all that much about trying to make the
console be more vt100-compatible, considering how long we've been at
the current state.

But I have to admit to being slightly emotionally attached to us doing
reasonably well on this side. One of the original things Linux did was
console emulation, even before it was an OS..

                   Linus
