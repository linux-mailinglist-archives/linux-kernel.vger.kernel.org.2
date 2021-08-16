Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DBE3EDAFE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhHPQdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhHPQdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:33:36 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328F1C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 09:33:04 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id h9so28131513ljq.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 09:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j3P3jVOaCpqFg1Xx3rmbNYwlQro+UtAoix0AbNROZzE=;
        b=VrwfctE9SK7UdztlvKYpCHaU+2HBHmZeOXjt0BfsgRNEvBenAL20b0JWVI8L0O5Y9L
         XInPR09gdeDLBV4uuswLFlLn2dbVQ3/vPIifoKOYI28/x88Hnniq1cM01qWNWpsgKJB8
         NLkcpLiijia7xjFPVikqte0w7ZrubpjJFEGlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j3P3jVOaCpqFg1Xx3rmbNYwlQro+UtAoix0AbNROZzE=;
        b=sH90XGbD4a/z2haSIiWpY/DLOjwJ2kUC1sSTwVLjXQWNlq7yayr4EY3tBFBBtAbU9e
         DHp/1GcD0dIgKDPO6PvQjwb3ImHQuHWdEqsFfgnrto7JFIxnfM6mbXboqHpos6bPgMt0
         F73VHWFHB4+4gQACUILviWehlAc9Zchyn5Jc354bfP/v0582kLBKWBcujs2+B/9IZ+BJ
         eL1oIHqNPkWq8FX4k3qpEuogFqsdRGE/E81RsHa4smFuB0G92ZUYk1MGcARI7W1Ab0qE
         KSI6I0YSlvVRWgguLh+KKnogfOzWbbbrPBtaHnCmUAmWSkQA1Xx9tAhclvlZVipGzxsm
         X5NQ==
X-Gm-Message-State: AOAM533wtxclgScRKOTjs8RrGhlfzmDOnwkjL53FjS6Y+4IGwIY/LBzY
        ci9WMCuGzLkwVGeGOdqJgWYjnW148A+jHbtR
X-Google-Smtp-Source: ABdhPJxfLcGvaN6P9Tc4Pks7T+c8oWg0FehCm3DizK978Q6iNr6mg/DkgMiulodFmoiKxVDrN+Ft4Q==
X-Received: by 2002:a05:651c:883:: with SMTP id d3mr12917733ljq.17.1629131581885;
        Mon, 16 Aug 2021 09:33:01 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id z3sm862494lfh.18.2021.08.16.09.33.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 09:33:01 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id x7so28120057ljn.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 09:33:01 -0700 (PDT)
X-Received: by 2002:a2e:84c7:: with SMTP id q7mr12902872ljh.61.1629131581056;
 Mon, 16 Aug 2021 09:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210812141636.35e41575@oasis.local.home> <20210816110416.6fb6d54d@oasis.local.home>
In-Reply-To: <20210816110416.6fb6d54d@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Aug 2021 06:32:45 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjjVEPbObAoqmkrLSU4BgtrLNZYs4BrmvKcgOJQ2=EwEg@mail.gmail.com>
Message-ID: <CAHk-=wjjVEPbObAoqmkrLSU4BgtrLNZYs4BrmvKcgOJQ2=EwEg@mail.gmail.com>
Subject: Re: [GIT PULL v2] tracing: Fixes and clean ups for v5.14
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 5:04 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Did this one fall though the cracks?

Yes. It ended up being hidden in the thread about the previous one,
and not standing out in my "git pull" search queue.

Pulled now, thanks for pinging..

                Linus
