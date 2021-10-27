Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AACB43C122
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 06:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhJ0EHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 00:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhJ0EHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 00:07:06 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B370CC061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 21:04:41 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y7so1470065pfg.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 21:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Izz2fSeyp7FglLJXkUAzOzwe9eczJwqGRtb97g7cQGw=;
        b=NyISBRU3aODLArR4lea/SISpA7/zkEP9FG+wdnUmbXfTYwn+iY4lxF+u4WsnyaWcsE
         EfK/OT4dk3HwYCy9gjZC4VwyzjQ9zmAhuutnXxJIpPAD/w3uVCtjWogL0sYgvLG74R+v
         g6R5D7ncWinK5HCdKMsc6NiEeGrmqQoRWJFAQQAA77aRoza/R0cG29084cNFUn7f0aUm
         VdmFFyGKLjWLIuGKycPA6pLy3hjB+XFt6+F3hUABK9tinH9C+Aa/rOkKwPQVM1WJZl+u
         bow0zvjF7qRvdF3zi3kG4OxKHn1OHxdmRFNVC9hREC+r19Dom3frarwKheRIMqVPZ+FQ
         /cng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Izz2fSeyp7FglLJXkUAzOzwe9eczJwqGRtb97g7cQGw=;
        b=ldxP5lXfFNr8RjBv3NRKkVXQbSUv8KupYJq5ZCjunFJ/00HVYspOC0CkOCUk1yrSgH
         hUttNloHgTXDW344HgpTdzEnq+S7KjQlg3Ipq9X59G56x26zcUN6vbOvOlgdEYim8VHY
         cJ3RYKml9W/0Yhlh/BFilfGBb/raaFmqXlwDNBBhEeb0IjnvUGbSzUf/D175ku8xmYIN
         k5NxJx/awOXTks84YGWWIHwb4M0VRCfaicTjVWtO4nrjhZO2fb++BDyjY93C3zQ3puGl
         J5+15zt1EKKQEvK7wgFn1CT/MjMIjwJYC7Ars8v4hNzq0wnkmcZZOiOy3LRb8l0h8tEI
         ZN6Q==
X-Gm-Message-State: AOAM533Gck+eGdTAnIubWri9IER+M6xFs4qIp2v8GGuX9vktV7WzIc/8
        VbaWWg0a2Lyeh67r86bCk82Up992gOl6k3hEgHnuDw==
X-Google-Smtp-Source: ABdhPJz0w3mvn4TX+ptIQYahw35WumxHe6KDzRZcbPE7yRtG2MVa4Il8IeujEeZaRa+ai+C0+yqpV1LFJQgVSPxIohU=
X-Received: by 2002:a65:6499:: with SMTP id e25mr21858529pgv.146.1635307480887;
 Tue, 26 Oct 2021 21:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211025200852.3002369-1-kaleshsingh@google.com>
 <20211025200852.3002369-7-kaleshsingh@google.com> <20211026151451.7f3e09a4@gandalf.local.home>
 <CAC_TJveHgsPZw7p7BWOgQw6h8GNU_Pv_WUjNmw3AUq+wnSzk6Q@mail.gmail.com>
 <20211026201846.08990d1d@rorschach.local.home> <CAC_TJve-mKSojaXtukdFeQKvPz-8TQtS=pgGD0Z18Wt6yJi7dg@mail.gmail.com>
 <20211026211511.403d76ca@rorschach.local.home> <CAC_TJvdwqQAKrVs3w6NcQNBT+bAgdyqR+8Zt_An7R9AQSSthGA@mail.gmail.com>
 <20211026222123.5e206fcf@rorschach.local.home> <20211026231557.1eedad9b@rorschach.local.home>
In-Reply-To: <20211026231557.1eedad9b@rorschach.local.home>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Tue, 26 Oct 2021 21:04:29 -0700
Message-ID: <CAC_TJveyKhZ3jyTZ33jbxSKTxxJ1WG+NUUUbf11pJ8Gqk7UeaQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] tracing/histogram: Optimize division by a power of 2
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 8:16 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 26 Oct 2021 22:21:23 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > I'm sure there's an algorithm somewhere that can give as the real max.
>
> You got me playing with this more ;-)
>
> OK, I added the rounding in the wrong place. I found that we can make
> the max_div to be the same as the shift! The bigger the shift, the
> bigger the max!

Nice! :)
>
>         mult = (1 << shift) / div;
>         max_div = (1 << shift)
>
> But the rounding needs to be with the mult / shift:
>
>         return (val * mult + ((1 << shift) - 1)) >> shift;
>
>
> When val goes pass 1 << shift, then the error will be off by more than
> one.
Did you mean, val should be such that when we do the (val * mult) we
only get rounding errors less than (1 << shift)?

I think we also need to flip the delta now since we round down initially:

    delta =  (1 << shift) - (mult * div)

Thanks,
Kalesh
>
> -- Steve
