Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFC336A411
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 04:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhDYCE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 22:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhDYCE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 22:04:58 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98773C061574
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 19:04:18 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a25so46651581ljm.11
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 19:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dBImDjtC+qnZ8/5fP2PL/vVTHMmZW0yK3v6Rit5lABk=;
        b=GUJOgG+BvBe+DaGrfpnz9o1gDEYYNiBZpRgXRxxL0ZilC65247muQ6yEjKB40wZTOs
         ZAmT+dJweHEMu98gmjD8ygVomy9raa0B3SKr3XzLkKOBFfGq2sq9Z9QpFTZ7hK3Nru+M
         vKq1754eCVzgnAfgm6Bx7Et59dI0K4T6tjpBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dBImDjtC+qnZ8/5fP2PL/vVTHMmZW0yK3v6Rit5lABk=;
        b=ihwHpYKQD2I1icETcS2E6X1hsFYyd0GEABtilR1s8iQUViA5WNAUQxe35P9Ja1GhaY
         kZAK7PGbfuMn3fkwiWABZaxKhRVQxnsjm+V7fhllmjSjGVnu0oAtl11jpHYstbXYuQIu
         4/UJKPFWA3X0EsiusnJSuNZEcAEn+LD1i0pz/onHPvybLCvzvNPvrHPJ9xtfeDBS8qB/
         Pp8SPLe76v5eWYrC/RkdhiSdP9k/0iHSE7bABWRQVveRr8ljeSOmJkTMyJrTZXTO3z8r
         jTWzI8BCc43Koo04tOh5/wmgbY6L2h7YqABQJP1pwTxE6zoiZ3BojrM/OCiUNYCuqSKx
         F1vA==
X-Gm-Message-State: AOAM532nhZbel4eCs26sH4JmvJAU01cD/T38lSnkjIkQkOJ7KRsFVXmU
        cVf9fFEX7eHcknsGAksbqMVB99MQNsrXBKwd
X-Google-Smtp-Source: ABdhPJxgZpK/AMLg+5BguNeuizfwbC8iCxwJrmXP8qBB8nCEieAferUFROsadGfkSy9Re3VsGPH49Q==
X-Received: by 2002:a2e:a592:: with SMTP id m18mr7662712ljp.189.1619316256844;
        Sat, 24 Apr 2021 19:04:16 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id l24sm975088lfc.23.2021.04.24.19.04.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Apr 2021 19:04:16 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id s9so2020988ljj.6
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 19:04:16 -0700 (PDT)
X-Received: by 2002:a05:651c:1117:: with SMTP id d23mr8080059ljo.220.1619316255975;
 Sat, 24 Apr 2021 19:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210423063227.GA17429@xsang-OptiPlex-9020> <CAHk-=wg8iAG6bBB+zdoZvZx1XYmyAXrWL0gPs_eTrTt+tXN0Tw@mail.gmail.com>
 <20210425014816.GB5251@xsang-OptiPlex-9020>
In-Reply-To: <20210425014816.GB5251@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 24 Apr 2021 19:04:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiW7xdHZTBgVOpVFM_7bek0HGvioQvCCyDXCbRa2fWdXQ@mail.gmail.com>
Message-ID: <CAHk-=wiW7xdHZTBgVOpVFM_7bek0HGvioQvCCyDXCbRa2fWdXQ@mail.gmail.com>
Subject: Re: [mm/vunmap] e47110e905: WARNING:at_mm/vmalloc.c:#__vunmap
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Harish Sriram <harish@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 24, 2021 at 6:31 PM Oliver Sang <oliver.sang@intel.com> wrote:
> >
> > Oliver - how reliable is that bisection?
>
> we will check further if any issue in our test env.
>
> by bot auto tests, we saw 12 issue instances out of 74 runs. but not happen
> out of 100 runs of parent.

Oh, that's interesting. So only 12 out of 74 runs saw that __vunmap
warning, but if I understand your table correctly, there were some
_other_ issues in there?

Are those also for that same commit? (ie those RIP:kfree /
RIP:kobject_add_internal / etc)?

I'm not sure how to read that table of yours - if I understand it
correctly, it looks like the parent commit had some different ones
that the child did not (eg 2 cases of BUG_at_mm/usercopy.c?)

So it feels to me like there's some memory corruption somewhere, and
that commit that it bisected to likely just changed the failure case
(due to timing differences or allocation ordering changes).

IOW, there seem to be other panics even in the parent.

Yes/No?

             Linus
