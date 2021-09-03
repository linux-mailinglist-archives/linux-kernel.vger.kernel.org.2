Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008174003E7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 19:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350240AbhICRKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 13:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350227AbhICRKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 13:10:17 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7B6C061764
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 10:09:17 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id m14-20020a4ad50e000000b002912a944a47so1699707oos.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 10:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5PWbw7S+qU29tEkyFXIybjYrSvc7pM3nTSPJNWmDTlQ=;
        b=EsJ6HLjT8FylyG7CmxPFi3I+fdLzO5+MEcDJ2Px5X97vYnPggl8u+6Gbe4TRipa/8M
         tmTQLlyA3TV90kA6qhyX8XZv8kqbp02mrMhLHs6FKEPObnS0iCVkM1tuTXuEc/RuJDhE
         C2WW+unq7YB1Tfb74dtqhXSp6H6LTFxPVVOn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5PWbw7S+qU29tEkyFXIybjYrSvc7pM3nTSPJNWmDTlQ=;
        b=mfYoUXrm5TobjWvuFadID+NrsK1nsa26XFHW2b/ASzgD1LtAvQqs0j9Zgur1vZglHt
         3HIT+e7uuOozcAs1wYC30JPU3qIPzVL6XAqzLo3z3GxMUvIrsb5OiVKdKlW6qWIdi5hJ
         4037uPmTbIpJ0RoBM4p93exSBkaUraSnB5qQCkfKGPrT1ErU5ZoPoEvgfQ/SVrN7r3jq
         A9E09jYKpT3rGx9S4Dz+POQtXLzr4FAaf+esUEVatDyvCtz2blo91kuwPMkoDkp5dIW4
         g/pq2VlURst6Pog2M0wU7PN7XRhjGSSpDAqj1iwbHOUGcPVnic4EmIgwEOmUKHIdhIYj
         gN2Q==
X-Gm-Message-State: AOAM531i8BgvpRso/oALNBUA7ZU/DqB1PeV6pRbX1JgEXI8Sl9JTlg2B
        Xr+an7Mhjky34rEi4xnyE854RofSjS4Pbg==
X-Google-Smtp-Source: ABdhPJzc1ee6vQcYfUmOK1f/8z4pkajHZJi8RQakCua73InstS9ifl7ssa0ZOvk2m5SCCUTNnwyqkw==
X-Received: by 2002:a4a:9d0f:: with SMTP id w15mr3845992ooj.62.1630688956342;
        Fri, 03 Sep 2021 10:09:16 -0700 (PDT)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com. [209.85.167.180])
        by smtp.gmail.com with ESMTPSA id u15sm1097018oor.34.2021.09.03.10.09.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 10:09:15 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id n27so87796oij.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 10:09:15 -0700 (PDT)
X-Received: by 2002:a05:6808:1892:: with SMTP id bi18mr6722859oib.105.1630688955126;
 Fri, 03 Sep 2021 10:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210826124015.1.Iab79c6dd374ec48beac44be2fcddd165dd26476b@changeid>
 <20210901150840.GF5976@sirena.org.uk> <CA+ASDXMLBpF6bQLCoxkN-+CqjxOX-ujzYBTV1f=zU1J7fFNuDA@mail.gmail.com>
 <20210902170613.GG11164@sirena.org.uk> <CA+ASDXPJO=F+fa2zE4LDdRzMjgiugJfuzZKnZ-pndagVtw++Ug@mail.gmail.com>
 <20210903111023.GE4932@sirena.org.uk>
In-Reply-To: <20210903111023.GE4932@sirena.org.uk>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 3 Sep 2021 10:09:04 -0700
X-Gmail-Original-Message-ID: <CA+ASDXM7GrbahVyneW=TwHi9Uu7sF+7GcC=U0866_m=GXnFmtQ@mail.gmail.com>
Message-ID: <CA+ASDXM7GrbahVyneW=TwHi9Uu7sF+7GcC=U0866_m=GXnFmtQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: core: resolve supply voltage deferral silently
To:     Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 4:11 AM Mark Brown <broonie@kernel.org> wrote:
> In terms of not understanding the issue here is that the patch didn't
> pass the smell test, it was your explanation that helped here not the
> pointing at a driver change that lacks obvious relevance.  I really
> don't know what the reader is supposed to infer about the change from
> the commit,

OK, I might see where you're coming from. Personally, I'd still like
to reference the commit in some way, because I've never used bypass
mode that I'm aware of, but the mentioned commit added a new case that
I do care about. I like documenting motivation, where reasonable --
but apparently I need to do a better job of that part.

> I don't think anyone came up with anything more tasteful to do with that
> hardware, like I say the hardware is itself very hacky.

OK. I guess I was specifically asking about this patch (and the new
usage of ->supply in commit 21e39809fd7c, to some extent). If the
usage of ->supply is the best we can/should do, then we can leave
21e39809fd7c alone. If you don't care to "fix" this log message, then
I can forget about $subject patch too.

Or, do you only want me to improve the commit message (drop the Fixes,
mention bypass mode, etc.) and resubmit?

Brian
