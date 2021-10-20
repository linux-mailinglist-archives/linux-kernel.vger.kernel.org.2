Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCBE434EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 17:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhJTP0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 11:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhJTPZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 11:25:57 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21063C061749
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 08:23:43 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id v8so3228634pfu.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 08:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9G/tgOu2U++uQPjqj0kkd4nYpGihFaCQehhixgnnnLM=;
        b=FdohNWF0lePfGiRKbumHGZsAGaLjjDCPzFQFJ5ok+qZV3MvXQXsTce3m8nzuOrUnOr
         HttiXl3VBBlg2SEnXtxSdhhz7nt7n32i+kurO9oz+oBp7/JUPLTfrw8bVeIzI8il5S7y
         +Su1eI0BuwtFDay0O0erLFi3b/nM3KpBQZVvhdsPE7Gp/4mGxEFqpqGmj9rBVgryz6BN
         SaPNpOoiKt0kp6fO0TlMNeoK0ocPWI1b1P11Y8XNcreX1k1KK3F385FOV+dWpZEiNGVx
         5/jrgrsNrsP+j27vJioi2jBsc8BHASyJCxdF9Sg4ljAVZm8zss22Mwm4hbaf1v0w9NTN
         w+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9G/tgOu2U++uQPjqj0kkd4nYpGihFaCQehhixgnnnLM=;
        b=lZqrUTa3u9SY8nuC9s3rt/uHTQvnfIy+959jSlqeK0y5v9MasVkWGSJ+PXZEmnmjt2
         DEQeFhqpj+kpQbF4qpBbVZvxyZfxiInErrZ/n/RrPK+nlyjlWd8gdaPTFyGQj9F+QZTZ
         bx40JwbpeCLC+H3cgExC/sPwKXovhL8YnoRNJt7xDd6ojBRcwO0/wDmFDVbhyw+/cOaH
         M3M44tOMKmno5OAXQzKp7kQXtipH/beMmtt74m0p7auUh2hi4U6Z5/CM7aN2rI2u7IgW
         1W3UbJUmCQWNUO4om39hB3G9dEzpUDk+Ldsfx1CWpWMjJc/onZ2KoMVUyqUspvtO3FIY
         0D8A==
X-Gm-Message-State: AOAM531jWwMxteCUS8VrjVAlr0KPrZdJfknCS+LDdmfXMbqfX2vq9SM4
        s8wRxuazTfh/kf0Mx20CXTsgKi79l2yx7Re4ZA8hxA==
X-Google-Smtp-Source: ABdhPJxMcqpB7sT6+TEBLZlfW/zH2N29UinV40wClq1lYF1N0TvyDt6Cn320FsJLqNSwctbV9rFqwmrYd7zmA3a7PEk=
X-Received: by 2002:a65:6499:: with SMTP id e25mr91668pgv.146.1634743422326;
 Wed, 20 Oct 2021 08:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211020013153.4106001-1-kaleshsingh@google.com>
 <20211020013153.4106001-3-kaleshsingh@google.com> <20211019222756.1fde436b@gandalf.local.home>
 <CAC_TJvcZ4ndpQpsj4ANj9LpzSu6GfPSdxpVc0XShbi9u_bSUyw@mail.gmail.com> <20211020111301.0032a43d@gandalf.local.home>
In-Reply-To: <20211020111301.0032a43d@gandalf.local.home>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 20 Oct 2021 08:23:31 -0700
Message-ID: <CAC_TJve8pEHSvPAWecX9Lx04q7_bWd2izv=5FJLc=3vSKiDnZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] tracing: Add division and multiplication support
 for hist triggers
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 8:13 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 20 Oct 2021 07:54:59 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > Is it worth adding something like this for the multiplication case as well?
>
> No, multiplication is a pretty fast operation, and the added branches to
> test would cause more overhead than what you would save. But, division is a
> very slow operation, and I believe that even with the extra branches it
> would still help.
>
> If we do this, it should be a separate patch anyway, where we can actual do
> measurements to see if there was an improvement, and revert if not.

Sounds good. Thanks for the clarification Steve.

- Kalesh

>
> -- Steve
