Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A37F36DDDA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 19:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241460AbhD1RI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 13:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhD1RI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 13:08:27 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84352C061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:07:42 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a36so62261912ljq.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GR7hKf7fNw0ovTS2B9IbzWhvenIGzwzqI1E/3AF1PEQ=;
        b=d9UvkCg1CeyvhE04LX7mXGh/zBDp0cwiO6q/gaRpc3WOVY+ojFQvZg7EjBeX/Jiu9R
         FTmZgbbYJ1YAsydfpOaxChtbOug8NpVgZzd0UUybISU9QkPB1GK2Qz2kycmp3p95KxCn
         k0NxpghCv9KA+nBMtxK9jfsBLB6zFZZYyp2Bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GR7hKf7fNw0ovTS2B9IbzWhvenIGzwzqI1E/3AF1PEQ=;
        b=tmFbAOY2wPbv2w46EA9KwR+MdAFZho9lI/7UUEPKlq6K1Z508lxaGPCKCToGI8+7ZN
         EFQHU+mU7xVCCZFUyiRhJTW1U11EjgatRXz9Z0xHYbFzzHC9MnYlV5nHfBY3JdwBDo1a
         88hg/H611MxPOx3XD1hNUyO6VdRooSTqMZL9WvxfvsP5RQ0mMx/9Fe/NHqkImvIKEClA
         t6FhMYZtlloheBFSkaX1rnSgbKzCW6lrKCP0du/W6UjnxhZHqw2jGmies12EnHwsChYs
         M9SKFH24KKOIQLJO/rKQKiKd9IvA+4ap040fKRtrQZSYA3qDLZW+ZXiWPnPfoQt1THLZ
         hihw==
X-Gm-Message-State: AOAM5324BCOqqBnZ6DtRy9VmdR1/nv+vjGKWaf8lXMyeeMzDsD957YX8
        jsNv0wUM0SqdQijof5U7v0oYJfy3ZMCbHOOS
X-Google-Smtp-Source: ABdhPJx1AX7z5xEx8MvfBXOMnns6DcC+IoiX8z25C/7qXidk6LRwOXKHkVe0em03SecstiO7qsCXfw==
X-Received: by 2002:a2e:7010:: with SMTP id l16mr21773579ljc.41.1619629660842;
        Wed, 28 Apr 2021 10:07:40 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id a20sm66685ljq.130.2021.04.28.10.07.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 10:07:39 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id m7so62259177ljp.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:07:39 -0700 (PDT)
X-Received: by 2002:a05:651c:44f:: with SMTP id g15mr20755418ljg.48.1619629659309;
 Wed, 28 Apr 2021 10:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txMo5f9QvPqdzt8g3CmUpyDFf2Q_0XS4V1FyjHX8WQPRA@mail.gmail.com>
In-Reply-To: <CAPM=9txMo5f9QvPqdzt8g3CmUpyDFf2Q_0XS4V1FyjHX8WQPRA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Apr 2021 10:07:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh22MOMM5Paw-dHVvkp6W+UKx8mv_TNJ1TY9iaAMS1rLQ@mail.gmail.com>
Message-ID: <CAHk-=wh22MOMM5Paw-dHVvkp6W+UKx8mv_TNJ1TY9iaAMS1rLQ@mail.gmail.com>
Subject: Re: [git pull] drm for 5.13-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 8:32 PM Dave Airlie <airlied@gmail.com> wrote:
>
> There aren't a massive amount of conflicts, only with vmwgfx when I
> did a test merge into your master yesterday, I think you should be
> able to handle them yourself, but let me know if you want me to push a
> merged tree somewhere (or if I missed something).

The conflict was easy enough to resolve, but was unusual in that my
tree had vmwgfx fixes that weren't in the development tree (ie that
commit 2ef4fb92363c: "drm/vmwgfx: Make sure bo's are unpinned before
putting them back").

Usually when I merge stuff, I can see that the fixes that were pushed
to my tree are also in the development branch. Not so this time.

          Linus
