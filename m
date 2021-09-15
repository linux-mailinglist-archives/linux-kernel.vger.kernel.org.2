Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F5540CAFE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 18:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhIOQsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 12:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhIOQsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:48:45 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F52DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:47:26 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p29so7218567lfa.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e6Ne3z4MtSnJ/vK1ZJn5/mCrHd5s/vqOGwn4pU9m9rM=;
        b=FS8MW3/8uzhepRTR2peBggn1lxDQ7uLFD80wCqhl5lCI8shdKO98zodrStXh2QI+Ay
         Zy7XARNhmJ1RVf2Ss2bGaF0UYbj/wiM2Z5Nvki3aHW4SShPkYEVzETqc1ZqCU8p3Ywu+
         j+XQYfOTEgS/kippDdujReklHV31tm33SJGsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e6Ne3z4MtSnJ/vK1ZJn5/mCrHd5s/vqOGwn4pU9m9rM=;
        b=0dS9W++px8i2SI/MU5fcVwS10DLXi3+OQUF0SpDUNYwlJTQXLyZ0QQLmi103P8rPJT
         BNKF9L3kXY/TVoCFzc2dtgB6i9WzkyqlSNFFjWw+f2OENvLhgDZRX57KanvwlnmXZtRI
         hf0Z+Nvvce956R+KwPF028U4N3MNfMT49jJ0Og241rL6cKxi/voXofPnPjaxBltv4ApW
         fovAkyGSZeRJ8g833BehMGaLFiwOlp+5IZ6tORxdwA0a6wYboyuroZKti6MGsBllkcHO
         OjyqjdbPOogAwyx3baqsPNwUck0te0Z4YTV1geDVJyzRE9eqLX1u6nrOEL+gDtSLY2Gl
         upYw==
X-Gm-Message-State: AOAM533IeLp911IZo6leoXMl8GggCPNUJyuvchkZ0VG+/7FeS7CjJ8ME
        UsD68AQUsHozM090OiYcZZr8Jljwwfa62Mb6aO0=
X-Google-Smtp-Source: ABdhPJylpQEta4D7R1zplPbIH7WFGGETWbK59bItbITkRVDOezCRfZgbKglBRNaspPQucZ9y4EVipw==
X-Received: by 2002:ac2:58c6:: with SMTP id u6mr671730lfo.222.1631724443772;
        Wed, 15 Sep 2021 09:47:23 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id t67sm26726lff.292.2021.09.15.09.47.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 09:47:22 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id t10so1673608lfd.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:47:22 -0700 (PDT)
X-Received: by 2002:a05:6512:3991:: with SMTP id j17mr681048lfu.280.1631724442380;
 Wed, 15 Sep 2021 09:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <163171196689.590070.15063104707696447188.stgit@devnote2>
In-Reply-To: <163171196689.590070.15063104707696447188.stgit@devnote2>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Sep 2021 09:47:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjtP5U-jr7cpTS78iqyh6rys15-Gf0VwoqngNNH1AQH8Q@mail.gmail.com>
Message-ID: <CAHk-=wjtP5U-jr7cpTS78iqyh6rys15-Gf0VwoqngNNH1AQH8Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] bootconfig: Fixes to bootconfig memory management
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 6:19 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> But still I'm thinking how I can move lib/bootconfig.c and bootconfig.h

So having slept on it, I think the solution for now is "it's been a
problem only this once, let's ignore it for now"

IOW, I'll apply your trivial fixup for the bootconfig copy of
memblock.h, and forget about it, and then if we end up having more
problems with it later, we can look at a bigger fix.

          Linus
