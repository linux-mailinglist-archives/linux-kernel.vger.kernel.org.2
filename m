Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9760412686
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 20:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355485AbhITS7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 14:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354941AbhITS41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:56:27 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28602C0A88CE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 10:05:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id b15so52069448lfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 10:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGaD6AlZjPBokDnZ02tpVPzh3NsPwqmIjeFWkEkRoSE=;
        b=QsSxLzq+ps4dQfN/nfLkDVGEJRoUNVw2MarI+2uXV9KE0AtrzhKx+qI0WZs8h23Sn/
         CAe3GHPOAKPXLZfEibFPhZiKWJIh7VgFay4UPqOp/tI/ALdW4lwCTcJIkobR53QMS+5U
         NGuoJf50rRach+FLajqQuJW9lPW2IFgECqmXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGaD6AlZjPBokDnZ02tpVPzh3NsPwqmIjeFWkEkRoSE=;
        b=o6CNuskateew9nqgnNr8CgStpjmAUmXHIcUQ6cIARaCNMlqvOrbtoChg/ypiVpJU+F
         uJp+O+AhrCB/2Q3qEJMsYdEmvhXNi4MZyN8cEUC5LCvN/3iudtLz3kQCjHLrfP7G/9wp
         fgBpLxeIz55Dm06wHbc2favw2puSRmauvCGxcoItdOnPgQWGTuxe0dgyfOaW8XHJyTZ4
         CGarz4XWJzi4dHMMnIuzB9BxyTjDHYYXhyWBn/rwIfaPshpztyFfKlk/jFx5HP8C+eu5
         K8hJMH8q05U4y2NgV1ta6CncbVKIe1sCSPWBL/L5St1f2lc1ebPtdG9lEvj2MeSXDnGB
         Zuww==
X-Gm-Message-State: AOAM532b8mi08RY9sgSTWhAe0sLYf+sz9vhCmmnwWbgqgesMFvNovwGB
        CEu8jUWqVGTPtWqeWjHPBJYWD+rssdd+Yin9
X-Google-Smtp-Source: ABdhPJyhhXjCJTBiaj5sAv08nK/aDN1k83WZoCq/fCYNTedT9DZdrNloIJD+YkNC6xpFpGylhOR0Jg==
X-Received: by 2002:a2e:944d:: with SMTP id o13mr9510501ljh.419.1632157500433;
        Mon, 20 Sep 2021 10:05:00 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id a16sm503594lfr.186.2021.09.20.10.05.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 10:05:00 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id g1so70987657lfj.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 10:05:00 -0700 (PDT)
X-Received: by 2002:a05:6512:b8f:: with SMTP id b15mr7635650lfv.655.1632157498590;
 Mon, 20 Sep 2021 10:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wirexiZR+VO=H3xemGKOMkh8OasmXaKXTKUmAKYCzi8AQ@mail.gmail.com>
 <20210920134424.GA346531@roeck-us.net> <CAHk-=wgheheFx9myQyy5osh79BAazvmvYURAtub2gQtMvLrhqQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgheheFx9myQyy5osh79BAazvmvYURAtub2gQtMvLrhqQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Sep 2021 10:04:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgnSFePkt9_TxgdgFvMz6ZyofLFQLuV_Tc7MQVXYdgSng@mail.gmail.com>
Message-ID: <CAHk-=wgnSFePkt9_TxgdgFvMz6ZyofLFQLuV_Tc7MQVXYdgSng@mail.gmail.com>
Subject: Re: Linux 5.15-rc2
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 9:18 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Anyway, this email ended up being a long explanation of what the code
> _should_ do, in the hope that some enterprising kernel developer
> decides "Oh, this sounds like an easy thing to fix". But you do need
> to be able to test the end result at least a tiny bit.

In the meantime, the build fix is trivial: make that broken sparc
pci_iounmap() definition depend on CONFIG_PCI being set.

But let me build a few more sparc configs (and this time do it
properly for both 32-bit and 64-bit) before I actually commit it and
push it out.

              Linus
