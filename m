Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802763A1FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 00:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFIWYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 18:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhFIWYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 18:24:20 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B74C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 15:22:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id r198so37186457lff.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 15:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KNDvchUWt+OJCGYsDEAFTxCA5hS5069SCS937X33Hwk=;
        b=YT5eBUGg+dF8fSmFj4VIVtIcOboGHZuGVgcfBkj44NLEOJoW+jOH+bQp4npNbOVcl5
         YPZt0xhsnGYqs/xQUGIxsWSLb0PrqtI4E22Uxx5KsoBg2k4D5KaOA+GZCvoGEsD2Tumk
         /zVJIv5gvDBqVFlC8qg2826Fs6PwllrH9OHjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KNDvchUWt+OJCGYsDEAFTxCA5hS5069SCS937X33Hwk=;
        b=aTwhQ1QyJjdeY/MH5YGNhMIlgyqHsvWNnk8vnfef/ykyGlSHB1x6ybzsxLdsRavq1p
         jkaceMTm/EzL5zLc0k/h8gqp8W6zROXDUlEZWlvu7/jSpF2MFwExWhyzlR+5t2YY0Pcj
         gLIdZzFHB7/9PCFhCdUvnYHndJ8OWaZEHMcuhpEJDmx9lWagrVygYpReZxKrHhBH+aTc
         ukqyvtHjmEqQ9XY7i+9PpqBHnWAbFwvuzmY06xOJpFymXnNihBXPGse7n88vdDGI4MeK
         dJ12tYxFlJ0oT3cE8oL0srHU/TulN334FE8ssZPhB73+WjOLPAUqFSpKiCQl1cTL6V+4
         UV2g==
X-Gm-Message-State: AOAM530Wee5p8TEVafHJZ71GUG4A8vOdZ+wyFwqABWAKX819KIsvDBxp
        DetqFCnL8fsHV3cjRZpT711Kkraq9qNhy/MecRs=
X-Google-Smtp-Source: ABdhPJzCw1hJakgbOI+7pKB0YpF8gFb/SKe3ug1a8NnSTNMLfFyt+KxKP6ENb+3k1cXuQYygOk1f3g==
X-Received: by 2002:ac2:446a:: with SMTP id y10mr1057867lfl.298.1623277329264;
        Wed, 09 Jun 2021 15:22:09 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id f9sm110825lfu.71.2021.06.09.15.22.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 15:22:08 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id x14so1866820ljp.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 15:22:08 -0700 (PDT)
X-Received: by 2002:a05:651c:383:: with SMTP id e3mr1481528ljp.220.1623277328528;
 Wed, 09 Jun 2021 15:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210609220457.220164154@goodmis.org> <20210609220537.927890401@goodmis.org>
In-Reply-To: <20210609220537.927890401@goodmis.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Jun 2021 15:21:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3S_DxdQkXVaQKcUBCyjiYHC3KqPBTMY151rvZzqKVFQ@mail.gmail.com>
Message-ID: <CAHk-=wj3S_DxdQkXVaQKcUBCyjiYHC3KqPBTMY151rvZzqKVFQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] tracing: Simplify the max length test when using the
 filtering temp buffer
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 9, 2021 at 3:05 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
>                 val = this_cpu_inc_return(trace_buffered_event_cnt);
> -               if ((len < (PAGE_SIZE - sizeof(*entry) - sizeof(entry->array[0]))) && val == 1) {
> +               if (val == 1 && unlikely(len < max_len)) {

unlikely? No.

Also, I still think that "len < max_len" should actually be "len <=
max_len".  It should be ok to use the whole page, no?

Unless there is some *other* overflow issue, and "len" doesn't contain
a terminating NUL character or something like that.

              Linus
