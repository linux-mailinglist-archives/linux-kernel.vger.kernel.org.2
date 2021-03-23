Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDD0346645
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhCWR0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhCWRZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:25:41 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2573BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:25:41 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 15so26732412ljj.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EWdPct9cnLJsI959oK8DsHeHnHswNFLX0BJgKrbG4+g=;
        b=aA4B8rBGrnJNMFum2qZ7SSYyJVSoErc0024LO2diJI7yElMidscSDuKODkJ1yYHIE4
         SyvbH7YtKx6jVynFc6BLJmFciPFYWJr5FNAFUmXuQG3dnyeIxG1PE9uvCKsd7ogUPOZf
         wpJQF+yf73A103SKtMRun38UBNilYgEyaUjRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EWdPct9cnLJsI959oK8DsHeHnHswNFLX0BJgKrbG4+g=;
        b=fWz78rYk0kuA/Pu+dEBe8c7wSkvJx/Tfq4RfBia/SoxxrSOSGr+pWOCdFyXqd9xAoY
         Hu10p7+HfRStCDLAiccygWi9D5qo4wqeTeJHTecKHNpzMLIGuI5irA3fKGaeHMVcMIvP
         9hp3N8zHZ7S0qZZga76BnhGrJKyc00ComnxjRiTiKFV4vO/AnoO0AKBvXJ59AQdEL65/
         uZwjvamOePR4YsZn0f8VeflpSKRXE+kyEhdDujbgbMP/rPsu0HnkYUzUn6LWHKqMFh/N
         kNxqw98vGVewkRvqjIaxCjN1FWE4R2fslAnyXWel3iwd79Qjg0BNoRK7X3ShfzHTz0Fy
         M/eg==
X-Gm-Message-State: AOAM532nvW5rHTasqI+LTOHZ6ZusJCAmJ7t1Vkf8X5SGhbkL/z3koy0y
        hLokgytMExaovpYYQVFVDfWDZEbeeSF+9B8mKlNJRg==
X-Google-Smtp-Source: ABdhPJy3UjHPGBYeVxg3ixK7Te1OIpI5Z0XaZM9/eD5lfjSb/5bUKza6knwrjWvqyinaK0afPuMDAASodMokarlTtQA=
X-Received: by 2002:a2e:9793:: with SMTP id y19mr3649338lji.374.1616520339246;
 Tue, 23 Mar 2021 10:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210318051726.2488-1-sargun@sargun.me>
In-Reply-To: <20210318051726.2488-1-sargun@sargun.me>
From:   Rodrigo Campos <rodrigo@kinvolk.io>
Date:   Tue, 23 Mar 2021 18:25:03 +0100
Message-ID: <CACaBj2bxYks-6zOwfzDq_0B0UqgxTY74psp4PCz78jbxqhKVJQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Handle seccomp notification preemption
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>,
        Tycho Andersen <tycho@tycho.pizza>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 6:17 AM Sargun Dhillon <sargun@sargun.me> wrote:
> Changes since v1[1]:
>  * Fix some documentation
>  * Add Rata's patches to allow for direct return from addfd
>
> [1]: https://lore.kernel.org/lkml/20210220090502.7202-1-sargun@sargun.me/
> [2]: https://lore.kernel.org/lkml/202012011322.26DCBC64F2@keescook/
>
> Rodrigo Campos (1):
>   seccomp: Support atomic "addfd + send reply"
>
> Sargun Dhillon (4):
>   seccomp: Refactor notification handler to prepare for new semantics
>   seccomp: Add wait_killable semantic to seccomp user notifier
>   selftests/seccomp: Add test for wait killable notifier
>   selftests/seccomp: Add test for atomic addfd+send

Friendly ping. Any review comments on these patches? :)
