Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A173C8B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 21:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhGNTYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 15:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhGNTX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 15:23:59 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53918C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 12:21:06 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u25so5008916ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 12:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v10QhqiBsganCCgmOaMsqsTTOW61Q/0de1wnT1z/KrI=;
        b=VlX8vMjKyWBPtCSmBQhFBfu5qq/AJqQ+H6QHhpzR6y4WPcmCmWmzNrhDkPEwQ39brp
         oAM3bgD+jBrVKnw7aE6cdXMYi9JIkvARjFmNxxE+QWfyRWR1dzkBfRidY0d0+v0h8TiX
         UL8P9zfh+lsWIM2W5KVdfggWLX3wS+ysLPZhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v10QhqiBsganCCgmOaMsqsTTOW61Q/0de1wnT1z/KrI=;
        b=XYTpYcddp1WIkbWCckCOrfLWO3WeYhFEmYcek9hV2p8KPvtl8wHrCDduOW1mWVtBH5
         jqLwqX/uh79HCKMQIq8lXNCdkYFM6cC5syJepEKT9vn/bqBXSWclb66lQLCtfF3tjNWe
         /lqfEExaM9/d3LTbPh2es0Smtx9MRXHVBoipzwJh0738Dhi/d/DrGGPmp/wP+u19owh0
         A0wdWUObHx5LhzU4VGYQzQEKysPNMHZRDt+Jqdtz8TFsy0ZFqw0gbrv8VYks/wRi/iqn
         FC3r5vILk1lXlBQ3mwMTguzUhrX6uumNRKLXLEvbEotaDUf4/2G2ijn5gztpwPE+xGBs
         Qxvw==
X-Gm-Message-State: AOAM531cTz34sBFXU0E6HXm39OcAG3fyZY5EgSq7wS6IgKzQ/nPDyjes
        bZF54Y/xJ3Us9O2JMyyFpJL8Xe0GSD/8CKHw
X-Google-Smtp-Source: ABdhPJxm9kdgeMyqBkOZ5D1J9lwwAk4Mb2MitAwjr4bsredaWZo/+oN+fn09q8YnnwWaxED6antNQw==
X-Received: by 2002:a2e:950:: with SMTP id 77mr10624082ljj.438.1626290464390;
        Wed, 14 Jul 2021 12:21:04 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id a19sm228362lfl.34.2021.07.14.12.21.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 12:21:03 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id e20so5039701ljn.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 12:21:03 -0700 (PDT)
X-Received: by 2002:a2e:9c58:: with SMTP id t24mr10272134ljj.411.1626290463600;
 Wed, 14 Jul 2021 12:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210713171143.7784697e@oasis.local.home>
In-Reply-To: <20210713171143.7784697e@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Jul 2021 12:20:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5Pp5J-CAPck22RSQ13k3cEOVnJHUA-WocAZqCJK1BZw@mail.gmail.com>
Message-ID: <CAHk-=wj5Pp5J-CAPck22RSQ13k3cEOVnJHUA-WocAZqCJK1BZw@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Add __string_len() and __assign_str_len() helpers
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 2:11 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Add macros for the TRACE_EVENT() macro that can be used to assign strings
> that either need to be truncated, or have no nul terminator, and depends
> on a length attribute to assign.

I pulled this, but then I looked at the actual patch, and decided it's
not acceptable.

> +#define __assign_str_len(dst, src, len)                                                \
> +       strncpy(__get_str(dst), (src) ? (const char *)(src) : "(null)", len);   \
> +       __get_str(dst)[len] = '\0';

I can see so many problems in the above that it's not even funny.

Maybe all users would end up avoiding the pitfalls, but the above
really is disgusting.

And yes, there's a pre-existing multi-statement macro without any
grouping, but that's not an excuse for doing more of them, and doing
them badly.

And by "badly" I mean - among other things - the questionable NUL
termination that *overflows* the size that was specified, but also
using strncpy() at all.

Hint: use strscpy instead of re-implementing it badly. If you really
want the crazy NUL padding that strncpy does - which I doubt you do -
use strscpy_pad(), making it explicit.

             Linus
