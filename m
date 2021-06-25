Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26F33B4A26
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 23:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhFYV3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 17:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhFYV3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 17:29:37 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9792AC061767
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 14:27:16 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x16so8420061pfa.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 14:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xRxE71rC/IWPeumP7C1MZE8K9Wv2pifNDPEqkqJ42DQ=;
        b=fRwIMlDaWV0fntevPeIwqIuwZA9SOE+D3GJyYH4A5O3MEchBAxYKHVqyzp+eXW4VT6
         wkaJlszvY8HnkF2duefyJC1I3qVf+p1ig/BgstcUWTRUVWul6Oo3rP7bs9ApaUaWR57a
         i1sqycmWuqiX4+9R/GcLQAbrcWSMKP3JcKrGbbxKYF74XMqLPxckIlosyP1sfnD5unHM
         G4t5VwXQ0Z91lF1lVVeeYJGmplujg8vw5ac9Uczs83849SpRl9uKdLtYz6IAxTGck7vD
         yGl4xBs5TFy7nkqOqJEwPi/srgDSom6k7oU2oYvhoXlul5zFOmjkXkOvhoEoTQXSC1dN
         Xxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xRxE71rC/IWPeumP7C1MZE8K9Wv2pifNDPEqkqJ42DQ=;
        b=mf94EkLfJ6LUZhIE7TuBX8FoA+nXqHw1YWiWrt0kFj3tHtjhKSdvrczB0GmgTB1gCh
         Va0b3W2q0fpPM/wVnJpSPef8uCQTNslsAK7RTNqlfZRXRLE1zVHe1LZWELTA8SwHh6In
         lYMvY9EylHi+7ak2qLKKmzhpQskZIy4TRTenBupmyVWLG0yBkgxhpNGht68Apjyb01QZ
         H91YkTuR5640jmClbynYHqUSZ0FMQbUCDWZbhCOF6a1jTXl6J2Hx+BvhR1cMxN5Rze1Q
         rh7Cxhdhm/+gcIy17Th2EeK4c4wm5FA/NJozvkNZOgycaeBpywHc6Zb6gPvwtELwNZfE
         UF+A==
X-Gm-Message-State: AOAM532pDxMPVqOW43LK3JF+hg6EyXzgSUXnRJE5UYo6G4pfF6CwUl6u
        HR+rwLmh70wL/rSLxVXwaQc/LFqCAFuvdh+XsJ5vQw==
X-Google-Smtp-Source: ABdhPJwCGwSk6BZTuRmUOtwJhakAAFLWcIBXw8yjzjt+AT3O/BJZ7dHeP6UboGbcWP27Q9QqLf2aHP6UNR6pscUXNeo=
X-Received: by 2002:a63:d0d:: with SMTP id c13mr11573133pgl.384.1624656435782;
 Fri, 25 Jun 2021 14:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623824363.git.mchehab+huawei@kernel.org> <6fde409079959a95b62b9b2692503608d7ff0dbd.1623824363.git.mchehab+huawei@kernel.org>
In-Reply-To: <6fde409079959a95b62b9b2692503608d7ff0dbd.1623824363.git.mchehab+huawei@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 25 Jun 2021 14:27:04 -0700
Message-ID: <CAFd5g443AK+vxaupGiBQC5wB-5PG+5vV11y1NjevUh8don+VJQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/29] docs: dev-tools: kunit: avoid using ReST
 :doc:`foo` markup
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 11:27 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> The :doc:`foo` tag is auto-generated via automarkup.py.
> So, use the filename at the sources, instead of :doc:`foo`.
>
> Reviewed-by: David Gow <davidgow@google.com>
> Acked-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Hi, can you please rebase and resend your patch on top of

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=kunit-fixes
