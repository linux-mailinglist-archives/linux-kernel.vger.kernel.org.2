Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A223FBD31
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 21:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbhH3Tzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 15:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbhH3Tzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 15:55:33 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BD1C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 12:54:39 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id y6so27917529lje.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 12:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dmyfSfylOt+Tzbx415hrkOW9Mk/nhHSmR3Gy6HTOhcA=;
        b=QbXfRSwa+LMhk9G5lUWdH5zAr2DNjtCp3hXBoOuE80fg3AZsM/hC3OBnKao0pwTCXJ
         fs3Z5r15AsWCJ2Gm3BDIQwr+65a0yRK5rmjPW4qYfl4JRLQWoJOGSsQa7yExA5jHQe7L
         UDwlqTIxXO2gD+j3+7vKt13Z8WWIkPFEHVefE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dmyfSfylOt+Tzbx415hrkOW9Mk/nhHSmR3Gy6HTOhcA=;
        b=pdQsPkJH67OcfxnHa2T7CT91DTaiMMvQ1vzLtbtNHwVZwwvPqE5yGcQOA81qwHgukq
         nczJvN3OO9NI+0Rqr3k2L1ReCm37CDrd8F1m2RnTtmuzSMDhAsTJ6WAwIkhxYNd448Jx
         37+Sp65xcmDaXC8w5TfGsrL8AwbQtBegujBT1NGpGPk+tv3beJrP4YbJ1JMDUmMtE+Er
         Zv3s7OuEzfqqYSOBzJD0dYiD9g9aDcjLbIXlpHv3NIco7LSMXBCjxWeNro+w25WPui+N
         MJFWQI0ygI1mGjF4YVtF6vu2AEtUg2y1osO5FpHNmEh+F7QY9lPFPlCaGGDRFTgmmXwC
         mieg==
X-Gm-Message-State: AOAM531wHP2M/UcpfZ3pikfZmIsaSY6zFXRDBsvlaHPgjXTaRh9zlTI6
        us4aAfml/C0SHvhfeodcUCDn1Au1vDf/avfk
X-Google-Smtp-Source: ABdhPJxa3TXDsNMXq3+1fV5kX8BeCXZ2ElJrAyDWb1S+vTp3hQ8t6Wv3K1IW0U65/G8bYucS8mvJfQ==
X-Received: by 2002:a2e:9e05:: with SMTP id e5mr21847596ljk.166.1630353277009;
        Mon, 30 Aug 2021 12:54:37 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id w29sm725201lfn.97.2021.08.30.12.54.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 12:54:36 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id d16so27885248ljq.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 12:54:36 -0700 (PDT)
X-Received: by 2002:a05:651c:908:: with SMTP id e8mr21741445ljq.507.1630353275746;
 Mon, 30 Aug 2021 12:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210830041459.GA3067667@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210830041459.GA3067667@paulmck-ThinkPad-P17-Gen-1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Aug 2021 12:54:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVNCemfBsTvSLGBycu55ArJAponTYhBqO8fzApiKj1xg@mail.gmail.com>
Message-ID: <CAHk-=wiVNCemfBsTvSLGBycu55ArJAponTYhBqO8fzApiKj1xg@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v5.15
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Akira Yokosawa <akiyks@gmail.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        xiehaocheng.cn@gmail.com, jiangong.han@windriver.com,
        Joel Fernandes <joel@joelfernandes.org>, jwi@linux.ibm.com,
        fishland@aliyun.com, Mark Brown <broonie@kernel.org>,
        Willy Tarreau <w@1wt.eu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        yanfei.xu@windriver.com, zhouzhouyi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2021 at 9:15 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Please pull the latest RCU git tree from:

Pulled.

I do note that you are one of the few people I pull from that haven't
converted to signed tags yet.

It's not technically a problem, since I trust the kernel.org
repositories, but when I notice I try to gently push people to use
signed tags even on kernel.org repositories. It's just a good idea.

So here's that gentle nudge.

I even have an old pgp key from you in my keyring, so I know you at
some point had one. And making git use them really is not a log more
than using "git tag -s" to create one, and pointing me at the tag
instead of the branch name.

         Linus
