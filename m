Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7819390626
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 18:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbhEYQFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 12:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbhEYQFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 12:05:46 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9B7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:04:15 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id c15so38806680ljr.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=etyw4lsngOCwaxz3lAVhGn8wpFc4o+0N4m07CszuHys=;
        b=WSWDsTyvfIO3jcXBz7rf/aCap0pJvuYkQeFaAHhGi82/yhI/JbGAzmvpxl7wQTCLxP
         kgCDVKtmyO+cBPm1tNHwAeizaDn/ZxYcVHJjmZLTMKdzwSHCzKrbdRrjDjj8hosTkMaT
         mncIr1itc7WzFkx59meZztEqeeSHvi6YzLHBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=etyw4lsngOCwaxz3lAVhGn8wpFc4o+0N4m07CszuHys=;
        b=XkPSPQtQ3FkMpNIHadVd7AfK+IQlX1sGw3j2q2rlryH1TmXlZxqGu0LLejV21ynCP6
         W0NO3pfuy756rtdg5okZSoGGopeO4k5IUZPLPbDuGEV8TTiXOfDGTACcWob4OoFq3BG8
         CBckoaE3zlsuTAR+JwHMAf6G1IN0b0lBUv+7wcRXd5ovCpsp2vSyaJQItued6rmUXdEE
         VxNTG79BFIkc8/UU87voNMfWhuY03kjHys25rUxKfd75euF1jwmi0O/0WW01z0kYivlJ
         HKDhz6skwVfBEVyC+4/VBNDpDQs8b838rLh9oQzpSIlZUuA6MhrPJmcH6e3Ui6aazLHs
         3sqQ==
X-Gm-Message-State: AOAM530NqfCAFo2RSJTNEvkTmsiWHD0KRlSVsrUqgrKx2iCgtE9HF8Uz
        i1xr6sNvLGBtY8YnJ+fbQmYVwTsSpLCFIF2t8AEAmw==
X-Google-Smtp-Source: ABdhPJzpdi9hkHuHgScJG60EVMPuQ6xED6Vl0PloPs9dBGePF9s1iU2bjO0YKLNK+BMtS8rcsUxshhuvWcJjQui+GQ8=
X-Received: by 2002:a2e:908e:: with SMTP id l14mr21340214ljg.372.1621958653833;
 Tue, 25 May 2021 09:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210517193908.3113-1-sargun@sargun.me> <20210517193908.3113-3-sargun@sargun.me>
In-Reply-To: <20210517193908.3113-3-sargun@sargun.me>
From:   Rodrigo Campos <rodrigo@kinvolk.io>
Date:   Tue, 25 May 2021 18:03:38 +0200
Message-ID: <CACaBj2Y5YsrbFCw1m9U=8S8uJFiPo_c4riitDE5z-re65a-x9g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] seccomp: Refactor notification handler to prepare
 for new semantics
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, containers@lists.linux.dev,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 9:39 PM Sargun Dhillon <sargun@sargun.me> wrote:
>
> This refactors the user notification code to have a do / while loop around
> the completion condition. This has a small change in semantic, in that
> previously we ignored addfd calls upon wakeup if the notification had been
> responded to, but instead with the new change we check for an outstanding
> addfd calls prior to returning to userspace.

I understand why this was a readability improvement on the old
patchset (that included the wait_killable semantics), as it completely
changed the loop. But now we only have the atomic addfd+send reply
that does minimal changes to this part (add a param to a function).

Is it worth changing the semantics?

> Rodrigo Campos also identified a bug that can result in addfd causing
> an early return, when the supervisor didn't actually handle the
> syscall [1].
>
> [1]: https://lore.kernel.org/lkml/20210413160151.3301-1-rodrigo@kinvolk.io/

I was about to resend this, but I'd like to know what others think.

I'm okay with applying any patches to solve the issue (mine linked
there or this one), slightly in favor of mine as the diff is way
simpler to backport (applies to 5.9+ kernels) and I don't see a reason
to change semantics. But no strong opinion.

Opinions?


Best,
Rodrigo
