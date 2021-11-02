Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F8E442F1C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 14:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhKBNfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 09:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhKBNfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 09:35:12 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293AAC061767
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 06:32:37 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y26so42912244lfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 06:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z7krw1+bEXcWHm2Lb+RTcgVSyvSKznVV7ccIyQF5Aco=;
        b=YQBy4O+u6TOvEb8OpE1ynDlpzrpCKfWu7ucuEnA4qXrG524vKx+lQdW7LJDpZLRN6Z
         p3eFUhpRSQHIYnMuGIdCOpOqutRBuMQSdLp97iia0juxqmCCpU++cil9rEUFnqMv/Fbn
         VxlmAAwWE5WWJMnuQjt2tBRmjefFk23JfFuZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z7krw1+bEXcWHm2Lb+RTcgVSyvSKznVV7ccIyQF5Aco=;
        b=ozLTVoVsfqHPR4MQUr/n7vjCPys/S4IDD9Yke1YtabzYKRQrSTs3r2P3MrJzY7VqO+
         PV1f7YAkfbgt6NKZbVk41QV4iTxIprz6N3h4OLToVO2jt2JWiqknHsSxwBW3ZWX73wM/
         6t/g0yfhxDrv+HF0Rz4A1PpfNRqC+a0im7U/5yuMWBHtZFAzY525yMzhaLzlVkgNRVt9
         w+HRUyBI9NIp8JaoY1sPdPcFjtvsgQhCUF+u3/OEVZoPJ5RJKSn1mD6Yjt10z4AlEenU
         E3vR+nNF9qA/4QwszxmxnyXqg3L3PSz1WB3U+Soo+khz75XSVDvP2sJgw5Eo/k4XOeUe
         4Rkg==
X-Gm-Message-State: AOAM532PZfJEcbXWq8v0iMcuglT54tcRxNYo97oPFd9OttIwgTxGEfKB
        NK+XECVtDbdWxyiJoTyXhdp8d2N7daV3/Bqj
X-Google-Smtp-Source: ABdhPJwg4G6i+jl5d0RnNcbr0vCbqrK9deYJCfxfe+Bz7VjN/Rl69bX2Sdt890pVxhCJwo/wc2yZtA==
X-Received: by 2002:a05:6512:308e:: with SMTP id z14mr33726646lfd.91.1635859954701;
        Tue, 02 Nov 2021 06:32:34 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id y3sm1538271ljg.47.2021.11.02.06.32.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 06:32:32 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id h11so35004608ljk.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 06:32:29 -0700 (PDT)
X-Received: by 2002:a2e:89d4:: with SMTP id c20mr39805994ljk.191.1635859949564;
 Tue, 02 Nov 2021 06:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211102054237.3307077-1-kuba@kernel.org> <CAHk-=wgdE6=ob5nF60GvRYAG24MKaJBGJf3jPufMe1k_UPBQTA@mail.gmail.com>
 <YYE9Z3wUs9HqcqhV@krava>
In-Reply-To: <YYE9Z3wUs9HqcqhV@krava>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Nov 2021 06:32:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPZM4bN=LUCrMkG3FX808QSLm6Uv6ixm5P350_7c=xUw@mail.gmail.com>
Message-ID: <CAHk-=wgPZM4bN=LUCrMkG3FX808QSLm6Uv6ixm5P350_7c=xUw@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for 5.16
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 6:30 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> ugh, sorry.. I'll send the fix shortly

Well, I turned the "return" into "exit 0" and the end result works for me.

Holler if you think it should be anything else (like a non-zero exit).

                 Linus
