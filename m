Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98C83EA956
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 19:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbhHLRTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 13:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbhHLRTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:19:21 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67FBC061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:18:55 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id h2so11606224lji.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u4g2Aqom+BNA6EFZNYAedbMkfxJn0eCYGbMW5+veCEE=;
        b=A73tiXilkiAVjlqmotQW2c2YZ2F8VOkrBnxZaROGpt6k9qrvrVjQ3MKppq8qjrlyzR
         HKCwgz39i5LR6knPJwB8/CcKpJmy0ewZ/GiQnIVaVsIa3B6yywtdE+jtFj31YZ74Dznq
         tCelAlcxb5p0rtS4TeHjzQUUCBoyrYiJNLL9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u4g2Aqom+BNA6EFZNYAedbMkfxJn0eCYGbMW5+veCEE=;
        b=IEqITK8ktyhTQNDG2XiHICwM9/vgM3CB2wN+BGhc6GuckMuIPaxz8YJBmx+DNSpXrZ
         9PhrJSff1SIPuGkZA9s1ASYVqmdUvl4KvZVlxJNkGtW8rehrK6l2Sp04OkOieUSUes2E
         zVsVLyPiktH8Rx3SGNIypJpMvIoeKFw+C3+VH9bCztOylVfwn1WwfGgcvb8nN31P2SpT
         Dku2VmaQ1EVtVsFGsu800cPJwpQIxLkB12NP4WfC3d5907Nq4cPB/zim6hObXcT1WXwe
         hr6zufeg9fXBEzJH/1M2v8qvKzaHqwAiQKF+ZyZPAcOIFeIcUifB5OsC33fvZxDxNIcg
         CpiQ==
X-Gm-Message-State: AOAM532+4bMKzZJCLIiwyl5wqTx5YEjnZmzdcBIa8PJrz3gmnSdDxBh0
        vE+atr1xS/4Vhl8DlH70GK6zMtUZOW/tNnCWg2Q=
X-Google-Smtp-Source: ABdhPJzCJjXsXf61a5umGMhvg++yZgK/8665DCwX3FN1FNaQ06AfU3jhmwVMLn2rx3vq+V762VO5jg==
X-Received: by 2002:a2e:9907:: with SMTP id v7mr3574403lji.113.1628788734023;
        Thu, 12 Aug 2021 10:18:54 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id a22sm316857lfb.253.2021.08.12.10.18.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 10:18:53 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id u13so11604774lje.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:18:53 -0700 (PDT)
X-Received: by 2002:a2e:557:: with SMTP id 84mr3739225ljf.507.1628788733014;
 Thu, 12 Aug 2021 10:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210812112938.3748c7f5@oasis.local.home>
In-Reply-To: <20210812112938.3748c7f5@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Aug 2021 07:18:37 -1000
X-Gmail-Original-Message-ID: <CAHk-=whHxeUjaNrWOLb0qx=-nibRZzQomwkw9xMPH_aHCf=BWQ@mail.gmail.com>
Message-ID: <CAHk-=whHxeUjaNrWOLb0qx=-nibRZzQomwkw9xMPH_aHCf=BWQ@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fixes and clean ups for v5.14
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

On Thu, Aug 12, 2021 at 5:29 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> - Fix warning for use of "main" variable in osnoise tracer

Honestly, I refuse to pull this kind of inexplicable garbage.

The commit message talks about "some compilers/analyzers" without any
explanation, and the "Link:" thing doesn't link to anything useful
either.

Those compilers/analyzers are clearly complete and utter crap, and my
reaction is that I want a *lot* more explanation why we should care
about other peoples crap.

I do NOT want to see people caring about warnings that make no sense,
certainly not without extensive explanations about why we should care
about broken tools.

Fix the tool. Add a "--Wno-warn-about-stupid-issues" flag to the tool
usage. Don't make pointless changes to the kernel to work around other
peoples garbage.

                    Linus
