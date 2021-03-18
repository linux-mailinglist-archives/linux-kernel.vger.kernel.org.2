Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE15340FCA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 22:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhCRV2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 17:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhCRV1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 17:27:36 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D12C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 14:27:35 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v8so1948648plz.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 14:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dbJ4tu0h2vfoq5iEJyv9eBMmHHIseIpXprgJl8iJhoU=;
        b=hrxzCDgYaqrTpyC7RhpNufMokxP+WsITJYO5fQlSQA5Jp5rA4ymV6vYAHVpLuz1ZFK
         cyEaJxDUeU3I0W9Mly7jHqjk9uOizXul73LUJLaPDx2FbvSVs8qA0KWKFVMv7N0kklfn
         GoAXJtReybfqlKwh5myjGv+CNEq7s2he7RIszIY83DkPi9wkKG6gBAmXWEQbk6cDOYZK
         TMUiiZZeKoK1qmSYuUxT2dGBLTbuFTEbQDzOf8U8PSoor7WBQT31WfitypyWeSGKjclA
         VSLnyLpOQuH9MkI0zPMc6z3jRNGlHJzG7XIXITFtj8I4wLz2Bl79M0CVXVGqqXf33ISB
         CoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dbJ4tu0h2vfoq5iEJyv9eBMmHHIseIpXprgJl8iJhoU=;
        b=gjtoiPCvOMSGIzvqO/tEnZ78JN1EkV9Vej4oVIsfZ4mEU3dlOl7HF3SlhRi+HK3L9p
         XzLF7i9Q66gnBBRwPJb8bsaSuFRMgwvjnq3IwXlOrmigH4YK5B0hFxN6LqAt41ILkHx5
         iXdCOMIdpQKQOu44X7nr/UbGFP0rONPwCQ4q9jmtzsDK38cZ5xNY6R+yVatI/zm8s4U0
         qI+TudEX3AZm3CwG8/EIyrhJGpSD0VwG9pCyR/Byvm58bVH+Dz7zhImHuPFTniPOOUO2
         mRAnvlZAaW5s3pzhOIh1q6MMkncKebLkgcdTjEJjwaWKGpv+FHnuHvM4xvnh66cbFiDq
         lnbg==
X-Gm-Message-State: AOAM532O/3zzdvquC1hmS4NhiKWW6v2XIISALa7SNa9WYmrg1so75t7U
        IAzl7sFmV+W/4/HNEuUtVkP8d2pe6Sqfyssaqs4hlg==
X-Google-Smtp-Source: ABdhPJy9j3X2ul9CXpfJuYjxYK4sS2lUaXNeTmcRcxjq10tEczdsEry9ruv+vRp/MwEQwcravOMjxZqh5cKYnjOe0oE=
X-Received: by 2002:a17:90a:f489:: with SMTP id bx9mr6141115pjb.80.1616102854950;
 Thu, 18 Mar 2021 14:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210312095526.197739-1-johannes@sipsolutions.net> <20210312104627.927fb4c7d36f.Idb980393c41c2129ee592de4ed71e7a5518212f9@changeid>
In-Reply-To: <20210312104627.927fb4c7d36f.Idb980393c41c2129ee592de4ed71e7a5518212f9@changeid>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 18 Mar 2021 14:27:24 -0700
Message-ID: <CAFd5g47uR=HxjVET3uygeND8tFsZtfkgsS-PjMagbcagPMTBEg@mail.gmail.com>
Subject: Re: [PATCH 4/6] um: split up CONFIG_GCOV
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 1:56 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> It's not always desirable to collect coverage data for the
> entire kernel, so split off CONFIG_GCOV_BASE. This option
> only enables linking with coverage options, and compiles a
> single file (reboot.c) with them as well to force gcov to
> be linked into the kernel binary. That way, modules also
> work.
>
> To use this new option properly, one needs to manually add
> '-fprofile-arcs -ftest-coverage' to the compiler options
> of some object(s) or subdir(s) to collect coverage data at
> the desired places.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Hey, thanks for doing this! I was looking into this a few weeks ago
and root caused part of the issue in GCC and in the kernel, but I did
not have a fix put together.

Anyway, most of the patches make sense to me, but I am not able to
apply this patch on torvalds/master. Do you mind sending a rebase so I
can test it?

Thanks!
