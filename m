Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798A740B7F9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhINTY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhINTY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:24:56 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41512C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:23:38 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id h1so577665ljl.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MksPKoYjM/imU+nl2QL35mUz25jyBK7PTam+Hlr9pyQ=;
        b=UW2ue8wNXEX1C/1qFEZFUTiSvZ6KSJF4/Uf60EQGU0HArRv54vUBQbi6AQkPVbOuGW
         /r97ae8WB7IloNkTMkxNxukeXobM4t5h8wmq/pul6FEwa/Bfx3yeb+HccYUGA3LjQwDr
         qEqwqshxcu9Wv2Kv72/vIR8bl+lqtBa5jUoSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MksPKoYjM/imU+nl2QL35mUz25jyBK7PTam+Hlr9pyQ=;
        b=o85jVJams/52qmsoXqYkcgG1XkE25ekWt33pyPr2gsnsdTHgEnEpIgX60dSF2Fu0bT
         Nvf4BW3yqTKwZX/jC04lSuqjnjTDGGOtald2a5zCgEHGwrKGlg+4yotV3h7M2MZLvgkP
         9GiCQUmC9FoU7yWgpXxksnWhyoprQK6MBhSL9BWGb3CLN93Tj/fpUXOGbmWU5zKmQf6L
         wv+xx5BdmBs6f/NYcsxAI44VRt+j9ph9fFT1U99mVaifv0wA819FLurVcGwDKehFm0TP
         t7Nvp/ZKLXql4MKYAZG0Uf7C2vN9/PsSmlsp0M4B5xH6MZFafz0cPpwJRslGAx2KEl++
         2hgA==
X-Gm-Message-State: AOAM533Fd1YiIt1eGnqJZVlX8msud8kLuuXB37xC+141Z1AVwS3mr6My
        7n1EuEikT6O5X4stVNyS0GoTENSq9DFReI70FhU=
X-Google-Smtp-Source: ABdhPJy/qmRecV2TlwbM8XR9VSRYCnc+F28+8ffMBK7M5xKOvYi717olpSus1Zf2gd4kT69fLUpshQ==
X-Received: by 2002:a2e:a782:: with SMTP id c2mr16753341ljf.381.1631647416359;
        Tue, 14 Sep 2021 12:23:36 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id q18sm1438156ljm.50.2021.09.14.12.23.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 12:23:35 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id l11so755898lfe.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:23:35 -0700 (PDT)
X-Received: by 2002:a05:6512:94e:: with SMTP id u14mr8470908lft.173.1631647415452;
 Tue, 14 Sep 2021 12:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210914105620.677b90e5@oasis.local.home> <CAHk-=wj9k4LZTz+svCxLYs5Y1=+yKrbAUArH1+ghyG3OLd8VVg@mail.gmail.com>
 <20210914145953.189f15dc@oasis.local.home> <CAHk-=whfA=k0CP_cYzCn3Wt7De-OJQbJbOKsvowuYnxKCAavSg@mail.gmail.com>
In-Reply-To: <CAHk-=whfA=k0CP_cYzCn3Wt7De-OJQbJbOKsvowuYnxKCAavSg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Sep 2021 12:23:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5tJ_+sKKnkzc6nxpfEvvbUG2Yg3zF-vVfUfZD=PFy7Q@mail.gmail.com>
Message-ID: <CAHk-=wg5tJ_+sKKnkzc6nxpfEvvbUG2Yg3zF-vVfUfZD=PFy7Q@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fixes to bootconfig memory management
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:05 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ok, can you send me that NULL ptr check as one separate thing?

Actually, never mind. I'll just do the automated replacement, it will
fix that NULL pointer thing too.

            Linus
