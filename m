Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951AC3B6927
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 21:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbhF1Te6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 15:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236643AbhF1Tez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 15:34:55 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508CEC061766
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:32:29 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id h6so11143306ljl.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Y/bR8wUkGVGzhBdcSek4wesHYZCjuAjxxcejF3EnLQ=;
        b=gfJRI600rr+UJrrk36UduQIC/Mlr+94+zjyh5Dw3k/qSrlCmRHQHOYMm1z/LbO0QS3
         js9GEsLvs1tHtLx6Z68jgqnnV5bDN9eC90k0v07W+lS97xNmXLUFJD+DdVY3eJg5xJPv
         avoRUjdC/9NNvm7tNfBNkF9bedlQhlKHCknsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Y/bR8wUkGVGzhBdcSek4wesHYZCjuAjxxcejF3EnLQ=;
        b=Npx49Q+EKrlkjBUe3lzP0bTmcwt0Cz3QheSg5FNZmNlgX8vNe7JGCUeQuZ0FyYStNg
         LvAZtgqD4hfKKCZknDlBstOWhh8DDXFZspERZ8j8EJd6m1KaZGfznryX5hB8y3iaR/JC
         pmO8J4erduiwm5i6lmRb/U55fSqtxBE18ax5eSDA1NI+y8sIExnrsUu4HeM4/xaQ5REj
         5b2XzEBqEASroPiK9qg8OjTXcEA/qlJUsBlMZ/zWx0GbK+b0y4YXa5+B8FSrEWcaekjk
         liH3sk17WCnbxnc7c98NexVUaNQwxLQvn/OZtghq74r2yM1A0mVw+vVOHglrN8A3nYdM
         ES4A==
X-Gm-Message-State: AOAM531tqxzUot6laK1//uLHgUzhcopHYg0DHYkYYatBt8vjSw5+Qnju
        j0U1KlUzf+PBScrtztGf5uSdR+szc1PhPAyj
X-Google-Smtp-Source: ABdhPJwrRC7K5JaxDH1dxaLMHt0oWawsg6o2vAz+cvnCpip29biFcoC7PxOtqLjPfeO80+9CVKOiOA==
X-Received: by 2002:a2e:81d3:: with SMTP id s19mr728926ljg.446.1624908747386;
        Mon, 28 Jun 2021 12:32:27 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id b15sm1398318lff.186.2021.06.28.12.32.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 12:32:26 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id a18so12450556lfs.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:32:26 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr19397814lfc.201.1624908745815;
 Mon, 28 Jun 2021 12:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <YNlxcCpk4shGcPrU@gmail.com>
In-Reply-To: <YNlxcCpk4shGcPrU@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Jun 2021 12:32:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wisVoq7COhA-B+5UAbisJqTn7Sehh-brqn6K3UVuFzoew@mail.gmail.com>
Message-ID: <CAHk-=wisVoq7COhA-B+5UAbisJqTn7Sehh-brqn6K3UVuFzoew@mail.gmail.com>
Subject: Re: [GIT PULL] scheduler changes for v5.14
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2021 at 11:51 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>     - Add "Core Scheduling" via CONFIG_SCHED_CORE=y,

Grr.

Why is this feature "default y"? I see no reason why anybody would
enable it outside of cloud providers, which doesn't argue for it being
on by default.

               Linus
