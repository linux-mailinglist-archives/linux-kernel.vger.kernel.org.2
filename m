Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520473F6C37
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 01:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbhHXX2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 19:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbhHXX2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 19:28:03 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444FDC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 16:27:18 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bq28so500745lfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 16:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=RXUZYCE1kvj+2FOlsOE/g0PbS8+86ANN+fDn4eZ6uVM=;
        b=hvLw8Sq36xbrN7Xu0b22CBRdjw9qfSqhVGfamUDSw8+EAHAzAuzqg14044etAizESO
         SqPqC9ZzDCzRwtXPBdUcLo6IwLV/dLYx8DUXjq5BzPfIf3895qdVQfBkbI2rpW9sp7p7
         gHkZzbL3ly5UuRCofrW2M4kiob6sjdVSqvhVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=RXUZYCE1kvj+2FOlsOE/g0PbS8+86ANN+fDn4eZ6uVM=;
        b=rgnf72M51+4Ig9PxvGVzTQWSDZQ2XKdVeUl6NdlvxkJBX+FZEwpPHmYSOCpo4nfwyj
         nEG76KFTM5VW4h5pc0RK0/++U7D9CrGNa4MPFO3PA2FPt8uZkECBmMHOqDBgPoV7YVgk
         9xNWgjFIS/xAc9xo2Rn0UsqnvzX+yef1WwBgGvuqRXI4QzYYFMz977HmtapAgEsibbEW
         Z/vkf6xyOhHOAYf5xGivXxHcJL9FT30Fl5n9ndoEu3yiwJ21k90GavfqPGzEPHyn/rHf
         2EEDn8XkQuWNy+ijLMZKschzkHrhyFWj/elOtMMNE2ZyZJXTnBxWJM2814HNRqiWMQVK
         M4IQ==
X-Gm-Message-State: AOAM530SOQmSoWBjNS4df0oSbmnaMbej1UYNDCvNYbvOwB/jXhxOXLyO
        b3Ps49bMPOe/hQDj0Tx8ui8y2AV30zY3Pr9C
X-Google-Smtp-Source: ABdhPJxddyaZcBDFtccix+7ygxFwb4b6PnHMLrxdwSdoMK4xlRyLOYS4GFrrqWhPw4lUCPrnd3FDqw==
X-Received: by 2002:a05:6512:1042:: with SMTP id c2mr30800099lfb.283.1629847636483;
        Tue, 24 Aug 2021 16:27:16 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id t70sm1882217lff.91.2021.08.24.16.27.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 16:27:15 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id y6so40444700lje.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 16:27:15 -0700 (PDT)
X-Received: by 2002:a2e:81c2:: with SMTP id s2mr32547167ljg.48.1629847635304;
 Tue, 24 Aug 2021 16:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210824031648.GA2725@codemonkey.org.uk> <YSSuVO47ieWDfWMQ@hirez.programming.kicks-ass.net>
 <20210824151943.GA386@codemonkey.org.uk> <CAHk-=wiRe=JBK85HG7xtXH1XbOWcO1KYW8csuWfLuFoHKTqF0w@mail.gmail.com>
 <20210824213342.GA1708@codemonkey.org.uk>
In-Reply-To: <20210824213342.GA1708@codemonkey.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Aug 2021 16:26:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8XonsSN1SXjpSh3pO3-+EMZvdkb1xwJbLpZxCT2=thQ@mail.gmail.com>
Message-ID: <CAHk-=wg8XonsSN1SXjpSh3pO3-+EMZvdkb1xwJbLpZxCT2=thQ@mail.gmail.com>
Subject: Re: 5.14-rc breaks iotop swap io monitoring.
To:     Dave Jones <davej@codemonkey.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 2:41 PM Dave Jones <davej@codemonkey.org.uk> wrote:
>
> On Tue, Aug 24, 2021 at 09:34:02AM -0700, Linus Torvalds wrote:
>  >
>  > What happens if you boot with the 'delayacct' kernel parameter.
>  >
>  > Even if you enable it at run-time, processes that have been started
>  > before it was enabled won't actually have the 'tsk->delays'
>  > allocation. So I'm not sure how effective the run-time thing is.
>
> Yeah that boot option does make iotop work again.

Ok, so it's that delay allocation thing is it.

I'm inclined to let it be and see if somebody else notices, and how
big of a deal it is.

The 'delayacct' kernel command line is an acceptable workaround if
this is something only a few people will even notice or care about.

I wonder how much people care about some statistics and iotop these days.

I also assume the swap stats still show up in "vmstat" etc, and that
it's just that iotop ended up using fancier interfaces?

Or do I assume wrongly?

           Linus
