Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8899D326923
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 22:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhBZVGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 16:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhBZVGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 16:06:50 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11809C061756
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:06:10 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id o63so6950899pgo.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yvXG077daJU6YKmJEh5vf6RSoJYeHMnEiVy+ciL3dZw=;
        b=v+lyrEIhvM2RoELrx4WSpKrFldfnEnnubFNueDvBWmOB4ljdeK1vHN2XQ3SAqLZbLr
         56nsTTa6S7+NU/ghxzwBbTHh4sf2NZx/DPkLgzneKHPvax+/AfU+cq5+lhdigNd/xFdb
         4OZ8++FobRu8QnfwuSMJnoQ9BvZlj3VtgAUU6vBygdgnb+5sfHiFnDyjl1dHRIzmhOxc
         k20/MfU4F3s4G52QWKcIwVwxWdGSZbCkz7/vfHKiVlGsSH9DwyBf+N5M6rB4vfk+s0MO
         Mri/ZmfijbA4158GysuTf843FEDqMgCTEM+W4EV+UAvUyN78epmV9pO3GOSVlE+Lnw5x
         v67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yvXG077daJU6YKmJEh5vf6RSoJYeHMnEiVy+ciL3dZw=;
        b=TCp8/9jumc8ZPGZ9utpPss7MM+03D+Vkw2gSuwcZlFLBqY0gq//SCegGtUesgnHfab
         9gwzEG128PKFcw2Z7wO+FSCSIQUK1DvkNnJ6KI2iVTqXBKQ8PUSgyDrQK09IUPq2O1cf
         pnR3GxKwBPWUZEdu4Mrbur/JlnL9Y1T0vDkWKEJb07wVvMMXYB/J6k8NNl+UMVkR/xrW
         8J38u7I8gJKN/5RzWeJSxxpNGed0WHBBaOYBFsRNuHQEMm/r53HM+kSmaRjiUMeu+JXf
         qtfNDNDrZDbKb8KreqwdMLzJUKjd7Rgrf4Dnue9AECdANrjc6KVr99KbCwCdgiUEj3Zg
         SoHQ==
X-Gm-Message-State: AOAM532QYnO9Wm8Azyci0zFguYa+Ak07IbPtdCkitx7ufEVI4oYOKqWr
        6UkoAnCfSxCmG3sLiQoXqDV/pAiubqyJ4vhJ7xcthA==
X-Google-Smtp-Source: ABdhPJzY6R0ydSSn6upRS+o2TR+UM6INNbm7O5j7v7e3+DL10exfal8ujruHzSDVABPTMqXrQaGLuXUpsRu82ayEjOA=
X-Received: by 2002:a63:fa4d:: with SMTP id g13mr4481140pgk.201.1614373569051;
 Fri, 26 Feb 2021 13:06:09 -0800 (PST)
MIME-Version: 1.0
References: <20210226205410.nnwstno5xrsb5ci3@smtp.gmail.com>
In-Reply-To: <20210226205410.nnwstno5xrsb5ci3@smtp.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 26 Feb 2021 13:05:57 -0800
Message-ID: <CAFd5g47ebZFOA6myhJHykt=nG5SwgJmuVAjr=CSkeO06iNg5AA@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix checkpatch warning
To:     Lucas Pires Stankus <lucas.p.stankus@gmail.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 12:54 PM Lucas Pires Stankus
<lucas.p.stankus@gmail.com> wrote:
>
> Tidy up code by fixing the following checkpatch warnings:
> CHECK: Alignment should match open parenthesis
> CHECK: Lines should not end with a '('
>
> Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
