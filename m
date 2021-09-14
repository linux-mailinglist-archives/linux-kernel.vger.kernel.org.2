Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376C540B49D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhINQ3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhINQ3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:29:42 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781C5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:28:25 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id s11so29434203yba.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKT5HRhcJsF/QSIoO/8hH/r3lotrNW4fdGfvNVtbZX4=;
        b=tiGvuJHDquC2ZhXKS9flhyLzaVhKki74rZRiWAu/xKcZkYAFCBYo7j8VJ/mGqXmewA
         epO6fgMvdjKb88KTn42eIBy0GDhCpcOzJAdzun0R0hxvCMzMgYwRJimg0a/s2WF2AaNv
         ssrbdqRATJCOLk7szMRvLJREAWl13+rVAkItGjEVZnUXipLOh51FTz9NhmchAkg09mzW
         4MtOOslI0euq1pnffwgqhRtnj6woLpO+LadqStNU5Bbl+Bdq0D/GdsaoQLHdXgbXqGP5
         YCybu6SIfkZkDgPQ+4E8ylB84ikFGHYtDPmWmu7OpVL03GA1vUuUvdMMzlJt5M1XLX5X
         YdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKT5HRhcJsF/QSIoO/8hH/r3lotrNW4fdGfvNVtbZX4=;
        b=3aC+Zc6EdNHptlqIN4YpC7c7LVHxEXbX+/ekhslWLKzBKrOmTepevLxyXjW7bT6Nji
         +Q7sPbcxfPANWORwNeTQ8jaUluZ6pIAddUEGMFFW3yIfYgmcFE/EnF93L2AN6FjlJs2x
         K5FNzh4nI/YL/wRCCQmmlAhiOiCI5907eT6nCLx1n98P7n+sS8vhVoSPfg3RN28SGIWj
         gPzDHLXGXZUhlQ1uJYIkzmaK3w+sAgOrc4yMJqE0JTbJ3Aro735TozAY+qmZYdbeFopt
         XLWoVvobWqcyyKYJUYtd6IeCGrbox4FUgjxXtJtE8H4JitPzzLCLVZy9D1O4g26lQ9iw
         hgcg==
X-Gm-Message-State: AOAM532mO4dReRLikiC6+e/SB/kuTk5VhBsin2SSfhi7/lpmxx93h2zG
        GZ7d+W5v13bNQbmtGn1kO75ip+YgTQoD9GIRTh4kug==
X-Google-Smtp-Source: ABdhPJzPuvGxtDYl/hNgNF7zwTJHlSYQ+Up2XrIhovZ4oUcC+g7XPxydq9osWlNOAtSwfn8feuDthS3PR54SOzFOaSA=
X-Received: by 2002:a25:2b07:: with SMTP id r7mr20227ybr.296.1631636904323;
 Tue, 14 Sep 2021 09:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210914043928.4066136-1-saravanak@google.com>
 <20210914043928.4066136-6-saravanak@google.com> <YUC7c9BNuHPOEg4g@lunn.ch>
In-Reply-To: <YUC7c9BNuHPOEg4g@lunn.ch>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 14 Sep 2021 09:27:48 -0700
Message-ID: <CAGETcx-B+yE8X2rn4GdzAikVO-swXb9a5-CxOG_HSuiQoHQZcw@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] driver core: Add fw_devlink.debug command line
 boolean parameter
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vladimir Oltean <olteanv@gmail.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 8:10 AM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Sep 13, 2021 at 09:39:27PM -0700, Saravana Kannan wrote:
> > When the parameter is set, it enables all the debug logs that would be
> > useful for debugging fw_devlink issues.
> >
> > I'll add the documentation if we agree that we should add this param.
>
> https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html
>
> It is better to make use of existing infrastructure, maybe with
> extensions if needed.

I did think of this, but the problem is that dynamic debug logs can
get compiled out (when DYNAMIC_DEBUG isn't set). I think debugging of
fw_devlink needs to be possible without having to recompile the
kernel. So in a sense similar to how initcall_debug works today.

-Saravana
