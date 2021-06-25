Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3533B4A03
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 23:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhFYVMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 17:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYVMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 17:12:40 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF41C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 14:10:17 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o35-20020a05600c5123b02901e6a7a3266cso4269032wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 14:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+uzZ6lIzg9KSxzcI4+ElC70U5kXVOTQQhsbNZv2sO28=;
        b=mXXieRp3t1Pk/cAMzPOp27NVX9VvTrVzb5Yh67k/76xRSzJfQX68DKI96uNp9uIROh
         Xt8ub936ZAzaySJPoGLNBZJ79Yu3cJe0vAIAAcaShFb7euaaeB0u5CxYlCYyg3kZHBew
         +wp79kIO79ipUsIsuTnzusUf/WTauVldREz8bkD9gNaxvLGu72yD+zd3cE7mWTWi3Q1P
         NFJnpo5stkjONyFJZtLU9XUOdTeKADy7/yLmAiuVfesRuaLQQtuYm/fW/1rOL9XQ72R7
         iwyzq52vEjOxYqCDJkugJES3hyjOXcRR2PZ1pb3ibJPjB3irocIZi6GhOC5dJ5V4fqWK
         sNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+uzZ6lIzg9KSxzcI4+ElC70U5kXVOTQQhsbNZv2sO28=;
        b=c6OoEtR2Q0BPLtOQqun7c3ReafPV/ko0658s5AzysNbxKRYxAwUH8gONVjNaNcPUgt
         FtE6KSkUkzX7sdGiPUcFz1M2xbIJJ+BfY8DW27K/LV129anwIseKksfekdwikrUoi+/p
         4JabHvInloqUnZr2d2GZWZzSbUUE6jJlfZE0HkFrXASYTMDHCwJytwQKbUvzkRgYhmki
         4IsfwQvyH4UlQgf5r6tjzTvLW4lAe3rhBgFAbTs31j/MHcx1GtoIgzM+/gOxvOD2Gy0c
         vPoWRNfCLhusx23+laTlEp963zmGNOfRO1+lAycENn88qWP+2Orh7wNSEWJWuR1cTbBe
         nmxg==
X-Gm-Message-State: AOAM533fjBKMF9PrdwdOwpIekpupp1ZSy7pK+zYnnhJDfTMYOZcVmAYA
        xNhAdXZEpBezusgMmjI/qQ==
X-Google-Smtp-Source: ABdhPJyBnKG8eRmWxtd/6s4yte9o29AV/728nDUfYqENx3hwFmI8KTaTtJYDT72vvaKC3ZOtfGMNBg==
X-Received: by 2002:a05:600c:281:: with SMTP id 1mr12485607wmk.171.1624655416583;
        Fri, 25 Jun 2021 14:10:16 -0700 (PDT)
Received: from localhost.localdomain ([46.53.250.16])
        by smtp.gmail.com with ESMTPSA id l18sm7098984wms.14.2021.06.25.14.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 14:10:16 -0700 (PDT)
Date:   Sat, 26 Jun 2021 00:10:14 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH] ELF: add and use SUPRESS_WARN_UNUSED_RESULT
Message-ID: <YNZGNvGn/pkMhsx+@localhost.localdomain>
References: <YNYz+hVeqsQmiEqN@localhost.localdomain>
 <CANiq72=qtAcsyReu85AVT-cSf3dcvbnTpQYEF1JhxCRP0WgHUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiq72=qtAcsyReu85AVT-cSf3dcvbnTpQYEF1JhxCRP0WgHUw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 10:34:29PM +0200, Miguel Ojeda wrote:
> On Fri, Jun 25, 2021 at 9:52 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > +/*
> > + * "(void)" is enough for clang but not for gcc.
> > + */
> > +#define SUPRESS_WARN_UNUSED_RESULT     (void)!
> 
> While it is related to the attribute, this macro is not an attribute,
> so please add it somewhere else.

This is natural place. If you're supressing WUR, then the WUR macro
itself is defined implying that the header has been included.

> By the way, the name has a typo.

Ha!
