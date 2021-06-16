Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331093AA57A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 22:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbhFPUng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 16:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbhFPUne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 16:43:34 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0301C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 13:41:27 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 13-20020a17090a08cdb029016eed209ca4so2516830pjn.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 13:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EaW36aS0LZ9CAqId572i5w3m3upUdOksh819Ks70U0g=;
        b=lMJtojEXFzt+xeR14MF92js03x8z8Q7rWqizAgoanKuYcxI3FVwwsbPUKWwOnTVVKh
         YUJ5YMf89NH+2+hF7ZF+Td8mszi+lksmv/LLh35uVLY+Ap+kHOmhC71YVdxwxYzI0+Z9
         j1Rc+OSNBJ2jHCso1S0HuUJuh4dad6v4RnQ6xTGQHwLtmJYfsITGdPn5F4/qvfZ5Yci5
         3ILL7yqWytCA5W9Yo6DiAN0cOsEImijO9cnsHUWs4WDL5Q34tjawkDeMC/GzCEOMByHF
         qvf69GzpIAXtEF2o7MFhn5Jeu6FsaVIPvvS0SZGhBkQrUzIB3wEtB51Vq86+RTGMucfK
         fnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EaW36aS0LZ9CAqId572i5w3m3upUdOksh819Ks70U0g=;
        b=DsCuUwpK2kkQWxz11YLBmwaODH3KYx5Ien09KrRR/vpl2pZh78nayj/900pa06n3Lm
         Qy/TtHaGyo7ZZPSI6RBHQRrtqYY6PmoptdLzk2e8cglhP50AnkdpfTbl6WE3RjoZzXAA
         TBwa6K70hy5F/8JTraG/xtzqK5xv5p7UWXdb+KOHU9PxvWSp0FWCMPJK8W3rFvRiltvO
         i339v+OuI1z7sF9HGmKs9tj5/jidGJmv3JJ13NErBMxEe58cSq3X9U5skSuLtOJJEaMo
         S2voiOE1Aiw2/9MbZMBh8iwQwotyGCi6QnJkIXi7wtLDlZ4BNlf6FZ9CHijNIGiPHSWo
         VEJg==
X-Gm-Message-State: AOAM5336xvSRiUr4vo3H0UbmPsk2GX4curJoIkrj4wmY7BYMgNPhT8bp
        SUJop0bSanHbEQEebfDNKQkHxuzSVRziCDxXX7neAQ==
X-Google-Smtp-Source: ABdhPJx/UgOcFxUlYkmPEi5myAegdBUbKzdywmlbCw8qICwsGbIH9vkSLK1wT1Io4bXPG25WLwso7akMudlNBaq/M9c=
X-Received: by 2002:a17:902:d3c3:b029:101:af83:cb1f with SMTP id
 w3-20020a170902d3c3b0290101af83cb1fmr1319442plb.80.1623876087067; Wed, 16 Jun
 2021 13:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210522044241.2763088-1-davidgow@google.com> <20210522044241.2763088-3-davidgow@google.com>
In-Reply-To: <20210522044241.2763088-3-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 16 Jun 2021 13:41:16 -0700
Message-ID: <CAFd5g46jOwV5iZretZEHOuxTbSvNxan-VSiN7genAXkhgbksAg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] kunit: Remove the unused all_tests.config
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 9:43 PM David Gow <davidgow@google.com> wrote:
>
> This isn't used anywhere. While it's possible that people were manually
> referencing it, the new default config (in default.config in the same
> path) provides equivalent functionality.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
