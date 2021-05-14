Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA08380F29
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 19:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbhENRnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 13:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhENRno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 13:43:44 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93ADAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 10:42:32 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i22so1175174lfl.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 10:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z2BEVo2gdHA+YW84az98d4ViUxW08aEVoJlhBhP4mlQ=;
        b=ZmQiX2I9H1fZGUevqtQOOCJrEct1Nk5Lsk0QNLPmgB0qYmECyy1vwXWs/SJ4QQ1mvl
         9MozrFx+5stjBtCmEl91KHahpHkbkXMUkih+tdMrftMjO0ydkUu/vUYOjTMep8R+KE6m
         19GI97rUr53bJd2vYavJ2+viPG2eU2bACdn54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z2BEVo2gdHA+YW84az98d4ViUxW08aEVoJlhBhP4mlQ=;
        b=r7TZBlHkzuLIFmVeXhhwap3D0rqh3mbQ/1MZUI2zEZEBzKWe0ihCXxmZ6oG6pV3cCB
         0QCZ+Lv2NzYOkW8amYiCh/433vwjZbcnY9hs2usCuJmTNIe7coF7eolVcE54oyxvpI7f
         yQuECA0juGJxveprenSPKvVybVNuc6hWPJoM4/k05Kwc5dtHNd9tK0nA6c3xfqwpHYmP
         /XvQ9alt/rl58audNEs4dIE9WifGsLs936R3FuxTy9XHMLUnoBRnupJPJCMZVI7CSKPi
         UvebY/V7GIXMEoxySQJVloWw9Pwgs6yzjmodpvMcgdJeK45Ws12bPDflWEMgNxK9WFZN
         ghpw==
X-Gm-Message-State: AOAM5309JQ3r2lcOVe4gHpYm682TKZsrWsbSbmxH6Y7ITHM8LFXM9Z/W
        8+xOF9B1F4uAScFBv5FEeKcl14loDyBaej2hutw=
X-Google-Smtp-Source: ABdhPJwzPLF4v7LX8lJ8XDlUj6uaU315oa/l/6Guaqc6QGRL6GBqsC3zTOiAasnijcmjFSu/mxI3dA==
X-Received: by 2002:a19:ad41:: with SMTP id s1mr33020016lfd.306.1621014150971;
        Fri, 14 May 2021 10:42:30 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id a35sm1283311ljq.124.2021.05.14.10.42.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 10:42:30 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id x19so44187893lfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 10:42:30 -0700 (PDT)
X-Received: by 2002:ac2:4a9d:: with SMTP id l29mr299593lfp.201.1621014150212;
 Fri, 14 May 2021 10:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tyXjogjugi55XdAQd-ucMCk=ohDXS+vqdiaMk_aCL6aHQ@mail.gmail.com>
In-Reply-To: <CAPM=9tyXjogjugi55XdAQd-ucMCk=ohDXS+vqdiaMk_aCL6aHQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 May 2021 10:42:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wge8rgL-VUHZpWFg_cTFkp1D_AZJTRzV86jod4NSJsppw@mail.gmail.com>
Message-ID: <CAHk-=wge8rgL-VUHZpWFg_cTFkp1D_AZJTRzV86jod4NSJsppw@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.13-rc2
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 7:34 PM Dave Airlie <airlied@gmail.com> wrote:
>
> Just realised I got the tag header wrong, these are the rc2 fixes.

Heh. The tag message also says:

> vc4:
> - drop an used function

which just makes me think you may have started drinking early ;)

I fixed it up. Sk=C3=A5l!

                 Linus
