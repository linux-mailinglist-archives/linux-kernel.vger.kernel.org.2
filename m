Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC37F34D244
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 16:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhC2OSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 10:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhC2OSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:18:11 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591B0C061756
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 07:18:11 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id e14so4460418plj.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 07:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkWm2uoX5PGUd0zTaPdRUkrT9tpPWJ/vjLUkOrtu204=;
        b=UA30wCfs5nO+qxQceTlHPRwZMSd8MOIfNshtSoUs7cBBtGOsLJtJ662UUZGduUhTUD
         PAr4/XYr2pRzFmO06086UJ+zaQpL/YHNKVQeSscCUpBXPKffbStpwoHxFYtK6/P7DSEZ
         ZSYkfb+/+VYBx6/7WX+uPwWXJBohiyAWsz6iFXUKyjG33X9LDEbQdV+NbdeLl0Q5cD3N
         q710mocMdyU0q3Umyx8CzkC48QhnOpj3lEVxMyePPGLNFZ/EOMwl8VxhQLWCWRuOKwEA
         lqGLf9A2ZWwUrAnjTn965VZ52V6tZ/TnNmJTTep5zRT0nzzS+HlVJjZQ3j8hHC1b3pd8
         7Mow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkWm2uoX5PGUd0zTaPdRUkrT9tpPWJ/vjLUkOrtu204=;
        b=OD0yWrKtNYltjZNEy3QNBEz6uERxG+7X7BeM695nRMzNBIQUYmtyGzCyAuWF6dHvIt
         D0K5jmJDu8DZo2AkuvDVonjqkACuPwYsQ4Kqphhg+u4nomZPF7VhdxIwkt1bLxFvrrY0
         p4ptKggSM1xZZbylu0xlI8d6oLD1KOiJxmoDx7yYmt1zZvQiVjrxi4zQkggk9kEfiVTw
         XmuceU0Kgsii1GwHKIPrYrBNnUJL2+qZyyfvCcCJbuIvXf9pLHuGCN3Y1PR0KIcLP8qh
         qbrzBDYh6b5f7evUVfq1yE1i0vRI7DDvlA2wXl5DE/I2ASelCD9cU2J4wNiEDNdT8ZmO
         nibg==
X-Gm-Message-State: AOAM5309ydLaamXaC7H5oRJ2tk4we9UxzMz2HvcnU2btnPwbLwohlHSH
        mPxQvMNoY+Y3hOINQ7EBCgdxutBUGSZR+y/naljDQA==
X-Google-Smtp-Source: ABdhPJwRl43yxX2wogTr17ggEWSJRHuhBCv1opItQmAerLNpbYmDuMsp+DH3dlo7xrZ4+tbHg5yIahu6UX1G5IoPJlA=
X-Received: by 2002:a17:902:7404:b029:e4:503b:f83d with SMTP id
 g4-20020a1709027404b02900e4503bf83dmr28417127pll.35.1617027490669; Mon, 29
 Mar 2021 07:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210329082416.40b7f449@canb.auug.org.au>
In-Reply-To: <20210329082416.40b7f449@canb.auug.org.au>
From:   Mark Yacoub <markyacoub@google.com>
Date:   Mon, 29 Mar 2021 10:17:59 -0400
Message-ID: <CAC0gqY5+tcmNOoRrjiNMsffWbrQEF_pwjvne-oP+sGbr+84suA@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the amdgpu tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

oh this sucks. I'll look into my config and fix it. Thanks Stephen for
bringing it to my attention!

On Sun, Mar 28, 2021 at 5:24 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commit
>
>   0ea5088407fa ("drm/amdgpu: Ensure that the modifier requested is supported by plane.")
>
> is missing a Signed-off-by from its author.
>
> The author is "Mark Yacoub <markyacoub@google.com>", but the SOB is
> "default avatarMark Yacoub <markyacoub@chromium.org>" :-(
>
> --
> Cheers,
> Stephen Rothwell
