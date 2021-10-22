Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27AD437081
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 05:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhJVDhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 23:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbhJVDho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 23:37:44 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E899CC061766
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 20:35:27 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id u5so65587ljo.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 20:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BqT2MNgCMvC56gM6epqF9SynfFWqpGi6ijMkvCKV6ok=;
        b=g723SQX6OS2aWzvqRjNGS8WOBk/fIGq4kYG2gc5mdB+aBXLC2sSPkNxwRTN0hLZwl+
         ABpshxvj8GOZE3IRklzpBL+yToj0FOLQTTw2GCaMsdDL+PilAW87F4LgGipPQRS8RvdS
         Fi6ljfqBb3Qwomd3jixWG5AnCmHnDXWdUJuJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BqT2MNgCMvC56gM6epqF9SynfFWqpGi6ijMkvCKV6ok=;
        b=msS+M3ypKTiTJHQb5gDzlomMhBAXbvUYz4Z0vRuKkhwbVG1IEQfDhOmxowP9eawwJc
         eWZv+K5ut7vekqg4kXMCzvakwroyWGyJaU18c5mD1zVEBw9yu0sNF1V18VbSFfb4f0si
         SPoQdJi4QCxYj0177R6haUsl7cqlQOpUFbGD1MiXavQHF2lXMcRq5sJSlbfcn/laaKyS
         IROpo/FAm0mepBP3jQh6T7y3VLLmf5X9elUJAUYVpnSx03aXBq9bwzXGvakO+fEPV+to
         Av43Z53AeWtqaE2ZMDGISrs++JLUUiJbrneezyJytswirywpqVSGq0WfUyN71Kq787Zc
         qjww==
X-Gm-Message-State: AOAM532BQBV2dpAkH/P4f1ROGf+9MX9cWbyMActWRlvlHoUlVeEg7EvM
        c3FAuNvT6oNV9MCcMeniocOg32we38SJhu4H
X-Google-Smtp-Source: ABdhPJwSDF6bNLWh+opqvOSKxCv2czCFjUgRWA3nA8MoAp5G7BqgPMnUvjk9Z5U3/sW4AhssaFSKYQ==
X-Received: by 2002:a2e:870b:: with SMTP id m11mr10338946lji.92.1634873726019;
        Thu, 21 Oct 2021 20:35:26 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id i1sm606977lfr.287.2021.10.21.20.35.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 20:35:24 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id r6so1870385ljg.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 20:35:24 -0700 (PDT)
X-Received: by 2002:a2e:a4b6:: with SMTP id g22mr3044840ljm.191.1634873724423;
 Thu, 21 Oct 2021 20:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <877de6e589.fsf@disp2133>
In-Reply-To: <877de6e589.fsf@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Oct 2021 17:35:08 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjAj+wgHXqkcGuQR9xo3C2G569TB2i5PmFLyK6BAkr2_w@mail.gmail.com>
Message-ID: <CAHk-=wjAj+wgHXqkcGuQR9xo3C2G569TB2i5PmFLyK6BAkr2_w@mail.gmail.com>
Subject: Re: [GIT PULL] ucount fixes for v5.15
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Rune Kleveland <rune.kleveland@infomedia.dk>,
        Yu Zhao <yuzhao@google.com>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Antoine Martin <antoine@nagafix.co.uk>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 6:04 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>  kernel/cred.c                | 9 ++++-----
>  security/keys/process_keys.c | 8 ++++++++
>  2 files changed, 12 insertions(+), 5 deletions(-)

That's not remotely the right diffstat.

What's going on?

The shortlog was correct, and I pulled the branch, because everything
else looked ok, but that diffstat in the pull request was some
complete fantasy.

If I were to guess, I think the diffstat may be everything _but_ that
first ("ucounts: Fix signal ucount refcounting") fix. I just don't see
how/why you'd get that as part of the pull request.

                  Linus

                     Linus
