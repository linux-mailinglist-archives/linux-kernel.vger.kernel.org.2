Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A66A315D0F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhBJCQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbhBJBSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 20:18:35 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B009AC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 17:17:49 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id f2so649754ljp.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 17:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nHnLggVl9/hXeSebba4yzkr+hIR5OBctPPYNNb0SIgY=;
        b=cDFtcy5/7OPlKLOPqlkIJwtraBtT0CeAGsHHJ6dnZDRCncCH/bbHV1m3IP7hiikJaj
         DGfV0np5RJG9p1hYiCU0UnPEy2N2LuZ5MxL9FMFghJWJPlwQMJTl3ycRPDqYB3JtTZky
         mY4ZBjFdZbB2PjT1Wf/hAxedM7CP2PcNEYJlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nHnLggVl9/hXeSebba4yzkr+hIR5OBctPPYNNb0SIgY=;
        b=neYRxVNISd2dstxUmk0pH+DfMK5o/at42nHZsNjHzA757U0EPs30jJyT9xoyp5spZQ
         zA89624INn8sMe6125LAvgzl7bxIADhxaeY3RY/qqULQEFyc7HSYeSdCe9WGft/B++CL
         Fwt787eYFh/Me5xpT649z9+ezsGuCchP1xRT28lof99OqCOuAbpmG36u69d9fFRnKdoY
         7gbTlOF97Semr1qDdFw70qQhbh1BMBirrw/cuautwZIbNvf5tfGiuIjnAy7ZrgZaBJM7
         BerYEHOAmNmmMqqusOdfbjEqgdxqTL/5LhlK9bspQzXqAaID/BltHrj2vU1rQOwmeg2U
         L3/Q==
X-Gm-Message-State: AOAM531lzK4kZhjNUEFzZQ8na+GcMJ/r7zKpwnoZLhTXJAtZu/+RUJNp
        gS9QOHMzBmDOOCUWOgoxKgyNzDipE31wVg==
X-Google-Smtp-Source: ABdhPJyohn3913EDC+h9RqcTgYTGipiyc1Yrmf3Mkx/NPeYosM+m7kb/XuXYSVXb6+fJ/NmCgQNoDg==
X-Received: by 2002:a2e:7114:: with SMTP id m20mr371924ljc.296.1612919867750;
        Tue, 09 Feb 2021 17:17:47 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id r18sm35021lfm.59.2021.02.09.17.17.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 17:17:46 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id c18so661732ljd.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 17:17:46 -0800 (PST)
X-Received: by 2002:a2e:720d:: with SMTP id n13mr387223ljc.220.1612919866012;
 Tue, 09 Feb 2021 17:17:46 -0800 (PST)
MIME-Version: 1.0
References: <20210209094327.GB242749@kernel.org>
In-Reply-To: <20210209094327.GB242749@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Feb 2021 17:17:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiNxm3FJEjTsY+g49GRWV4nhfivbkkb4b3=GabT=N65uw@mail.gmail.com>
Message-ID: <CAHk-=wiNxm3FJEjTsY+g49GRWV4nhfivbkkb4b3=GabT=N65uw@mail.gmail.com>
Subject: Re: [GIT PULL] memblock: remove return value of memblock_free_all()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Daeseok Youn <daeseok.youn@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 1:43 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> This a small cleanup in memblock for 5.12 merge window.

If it's going to make Andrew's patches easier to apply during the 5.12
timeframe, I'm happy to pull this early.

Yes/No?

             Linus
