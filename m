Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB16308E31
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 21:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbhA2ULh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 15:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbhA2UIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 15:08:49 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC936C06178A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 12:08:08 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id w14so6927194pfi.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 12:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iZplRB5Tg2q+M4+quDwz0eaDBOJ49cnkS/1+zENpun0=;
        b=cYB8/12zS1BJtO20+Y1r1Fdo7iI/xRvjCckA5Is6Syvhd0KnoTgQm1gRoL4TJ84xHE
         BDcV1jRprMQb/zKJYxlcCEIxpJ7DXqX/D0I/A11QJ3l2w/2ijTRB0DALmsI1K4u4ZUj6
         m88M9j8n4HfBBmp/o/UENK1J42wkPK2gJ9dp+kdoyG/nP7sLMG/6SIs9l+TCg61ACW6D
         Ln+kRUgv0G22y7QhkcRSa8Wu2IVWHVkjc/n5iaXnB1lqOu+9hE3288BTim2dAsI36H3k
         eRxTrunTp1j6UpD5w6Wb/4ZyDijEOYmCevEsauxiC486JFpREXUck+G6xfFpOYlZibYm
         2GLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iZplRB5Tg2q+M4+quDwz0eaDBOJ49cnkS/1+zENpun0=;
        b=odL34q8gimthBa4EQCVM96QMljuSIHlLyIzdijdT+Iwo5sIZk5YiNPJigrTXq9XvT1
         sKDqb1k8ps8PRx37368QQt7WkHPDZLYctbvbODdfH2batEDxAal0kwgN3zmP+ACiY91T
         fQ7trCi/YeWY4iOKvc+d2Hhb9jHNNZRxA5xe+If21pstHfMJrSi/jkidEkVFfSV2pJ5a
         srl/xBz4B9WHC7t/20/C/IWjvM54d2TQcssji4jEkoisWUlP9V08cz+Ljh85cWJdCUh+
         esFj7FLMzJaisunvpl7HFtoa4ZjnatmPyxGt72D3p9ZcH4Ja6ZBxwuxPtR3YIvfEn0Ox
         rCrg==
X-Gm-Message-State: AOAM532QOKNOiQxhT7R1/kjg1DXMPLEMDwyP9yLCoOQcHIgVhBIPRW4Q
        B1u+fBKi4w5HRE947EhZaUo7d4SLfmSXODAoCl2Sag==
X-Google-Smtp-Source: ABdhPJyL1WHwunX/u0+Q/xOKqwiTA6zHsySWAjUUgYE9BA8k8r8MySwCQAbPorHv5HZcD4S60LV17SpSF78YeSabwM4=
X-Received: by 2002:a63:c84a:: with SMTP id l10mr6382452pgi.159.1611950888032;
 Fri, 29 Jan 2021 12:08:08 -0800 (PST)
MIME-Version: 1.0
References: <20210129022555.2411999-1-dlatypov@google.com>
In-Reply-To: <20210129022555.2411999-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 29 Jan 2021 12:07:56 -0800
Message-ID: <CAFd5g44DrzNdDZnaHYAHt48c6+gNPpGwULYxaF=ENGWmMUomLg@mail.gmail.com>
Subject: Re: [PATCH] kunit: don't show `1 == 1` in failed assertion messages
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 6:26 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently, given something (fairly dystopian) like
> > KUNIT_EXPECT_EQ(test, 2 + 2, 5)
>
> KUnit will prints a failure message like this.
> >  Expected 2 + 2 == 5, but
> >      2 + 2 == 4
> >      5 == 5
>
> With this patch, the output just becomes
> >  Expected 2 + 2 == 5, but
> >      2 + 2 == 4
>
> This patch is slightly hacky, but it's quite common* to compare an
> expression to a literal integer value, so this can make KUnit less
> chatty in many cases. (This patch also fixes variants like
> KUNIT_EXPECT_GT, LE, et al.).
>
> It also allocates an additional string briefly, but given this only
> happens on test failures, it doesn't seem too bad a tradeoff.
> Also, in most cases it'll realize the lengths are unequal and bail out
> before the allocation.
>
> We could save the result of the formatted string to avoid wasting this
> extra work, but it felt cleaner to leave it as-is.
>
> Edge case: for something silly and unrealistic like
> > KUNIT_EXPECT_EQ(test, 4, 5);
>
> It'll generate this message with a trailing "but"
> >  Expected 2 + 2 == 5, but
> >  <next line of normal output>
>
> It didn't feel worth adding a check up-front to see if both sides are
> literals to handle this better.
>
> *A quick grep suggests 100+ comparisons to an integer literal as the
> right hand side.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

I don't feel very strongly about this either way. In any case:

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
