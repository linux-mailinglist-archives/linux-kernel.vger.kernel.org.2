Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051373F436A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 04:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbhHWC3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 22:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbhHWC3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 22:29:43 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27F1C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 19:29:01 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id w4so27194086ljh.13
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 19:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IR1lGgNjx620GDYDUFw4sHEjn3SoxS9D5LgUR1mi1CA=;
        b=BmfVyMFe0jz4GlzOOVgcc2qkHuwE4EpOakOuqPf6ge7JVa9++WNBtn5yV9dUy6N+RG
         6TD+wgmVK5XOwePoTXCQZkcoRezfC+Qa0Ios0+RDtzVcYTYv50gvssbe4fOBPIix+aaN
         fDFRapTz/F30OiJEqqolmlXYKqe8obbRbAq8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IR1lGgNjx620GDYDUFw4sHEjn3SoxS9D5LgUR1mi1CA=;
        b=Z8YRl3yO4eh6PWvrDLAFHf9OMSJVqm2sZhRD26BfZKTuN2dzWdwSzyKHrTAguIczmL
         KpDYdqLvtJMG66wML+IzjAFN0P8aM+ylRPgA7uhxyR/98HrUPp/DU2bqkAF7OYANOj/w
         PMX+yxySZw7f20mE62clkUNoMYlva+Pxa+LZzvhtXAHeoWCUBm6Ok9whyFAP5dBeX0D6
         7zk5drfpfShdsTHvqs3gKdX0v+iD34llApmMEE9ud50Na7QRwVl7xBWdbYnv36+zDblh
         KP3gcoF53QpyjHIdSxykCSGosUNzs1qR/4/hIAjlwMbOLo/CkQccbwNXgCkB3FHMIRPo
         xV1Q==
X-Gm-Message-State: AOAM532y5Q0GkMs4DV6Xw6hj8JcL0V1B5KxNeIVjanTSfkyVWorhF9bK
        bFqGQvDRm/8pvlKhj5dMJMwRVKt2ohS89jlp4lE=
X-Google-Smtp-Source: ABdhPJzsZzJvhm280Oc8LliOk6i9Qapn47mJPLo6qpL8wCwFP/nm0PYjoWNmbgLh1pNIo2v8FSFYeQ==
X-Received: by 2002:a2e:a889:: with SMTP id m9mr7211085ljq.195.1629685739972;
        Sun, 22 Aug 2021 19:28:59 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id w7sm1324824lfp.209.2021.08.22.19.28.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 19:28:59 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id x27so34725916lfu.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 19:28:59 -0700 (PDT)
X-Received: by 2002:ac2:4da5:: with SMTP id h5mr10168731lfe.40.1629685739313;
 Sun, 22 Aug 2021 19:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgZ_W7ZF84Mtq6KRjF4FEoYh14dnw+Oc0avZz_6WrCkfw@mail.gmail.com>
 <20210823014455.GA1133377@roeck-us.net>
In-Reply-To: <20210823014455.GA1133377@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 Aug 2021 19:28:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whh71bqAwpu1L5rCahVJY4wo5_XN9-njDiD0eHorgga=g@mail.gmail.com>
Message-ID: <CAHk-=whh71bqAwpu1L5rCahVJY4wo5_XN9-njDiD0eHorgga=g@mail.gmail.com>
Subject: Re: Linux 5.14-rc7
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 6:44 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Nothing left to report from my side.
>
> Build results:
>         total: 154 pass: 154 fail: 0
> Qemu test results:
>         total: 479 pass: 479 fail: 0

Well, it took longer than it probably should have, but we got there eventually.

Thanks for keeping at it,

              Linus
