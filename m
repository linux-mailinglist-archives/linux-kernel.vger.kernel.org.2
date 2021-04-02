Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6223528E4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbhDBJfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbhDBJfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:35:40 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F251C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 02:35:40 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id y2so2297721plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 02:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vzsll8xm6IiKjDMVW+o/pjkDPKy52BSlu05WlFxYDWg=;
        b=lw0EoYhqJhGX8SPEFLmOV2btucFVHF3pktGUDsEVTFu3pt8yUUSZy7cAvgaDfvR/wP
         xtR2oXP0UxmsNz/e5J3oep5W8dky162AggYzpXTzzKtQm3bJaYAImta+BhNk61Eyz0/m
         Ci5SAKFD8IQ195z/q5IuGYbvBPQEs80uw1YRlncD+f12QbzmlFkWouVVfb230H7sce/9
         lsoC7fM2LzKkqEanro9zNu8535k78ZvoJDFBaKECHuYAzzZn868JmoDfcY2cUJqp1pKa
         aIK9xso8t7epicH4BMctN8ad18wNKnie27XxBdMW06Bo6dZEiPCDarJn1TfiPi7Y2hf5
         pWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vzsll8xm6IiKjDMVW+o/pjkDPKy52BSlu05WlFxYDWg=;
        b=UQ33/2ckYLQCx+oezlECWu8Ztn9kx69+DFbou3vZg7/AWaJnNJUlByboCFe19NEj6q
         6zbMOxAfaIdixZP15SYbIQzY/OWxZnW+1sjuStGvzm9ID8d6FcfV5l5ps0X8D0rua0Jv
         5V5b56jinFWR7vXbO9TUNB8VyJ61AdRpw6tKICqrBZ6bQSKbGuwHsxaWnyYolFWnpg/g
         goYDqyplS2ccHJ/v9pKEVBhG9KW0qMbm7ntgcNUkTtT8mV6FTMFmxTg6DfECUZ9dNOeC
         siLnFgpzhF9mW2hK+M0zU4c6o1Y8DAfLqv0IB2pA0MVyIlpGwhBRlBep6ezVI544cE1r
         Y2og==
X-Gm-Message-State: AOAM530LfeACTLBc2Mff8c2VHWdt1EWnSifa5E66rgZoAqtP6yRwJDcy
        ++vYBSSzLf9sjSJdY7RlEIvT6+BPgsjclwHJvNYusg==
X-Google-Smtp-Source: ABdhPJxtHQje2ABPOvATkPWo/tuEsAUSHxdTmSX3fcinRyWYKyVYdH8MLsgXx00XcN2QGccrBXldJbWqUGGpXAQL0MI=
X-Received: by 2002:a17:90b:100e:: with SMTP id gm14mr13135037pjb.217.1617356139684;
 Fri, 02 Apr 2021 02:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210205221808.1966010-1-dlatypov@google.com>
In-Reply-To: <20210205221808.1966010-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 2 Apr 2021 02:35:28 -0700
Message-ID: <CAFd5g44PL+DrN6+0bw-oYQCjCSR-f4Y0=QZL9DsSO-3hKLsFzw@mail.gmail.com>
Subject: Re: [PATCH] kunit: make KUNIT_EXPECT_STREQ() quote values, don't
 print literals
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

On Fri, Feb 5, 2021 at 2:18 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Before:
> >  Expected str == "world", but
> >      str == hello
> >      "world" == world
>
> After:
> >  Expected str == "world", but
> >      str == "hello"
> <we don't need to tell the user that "world" == "world">
>
> Note: like the literal ellision for integers, this doesn't handle the
> case of
>   KUNIT_EXPECT_STREQ(test, "hello", "world")
> since we don't expect it to realistically happen in checked in tests.
> (If you really wanted a test to fail, KUNIT_FAIL("msg") exists)
>
> In that case, you'd get:
> >  Expected "hello" == "world", but
> <output for next failure>
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
