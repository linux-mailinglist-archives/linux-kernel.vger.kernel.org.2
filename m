Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DC1433953
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 16:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhJSO44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 10:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhJSO4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:56:55 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64275C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 07:54:41 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y12so15020694eda.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 07:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p8WCCnGWa29x2/KunWHwcjm82Vw3dcAhuVE+3OJhddw=;
        b=rU5vioG1bMFpSpuNxlfrRNAmnyB/zWyFYgYnrVbDtevPy/kYno3fOlryVFFCm17/ah
         ctHSyOqJg4vN14m3j0VjK+xfznSAc6PFHb66PthDVifzsJ7m3gH16wZOj/2OAx2V9Adg
         UAiK0PSV3AL/IBDlh1I0vMStcfLxnKW2TJXNI/DPVmMvkVcMFSK8q9gTOuxlabGVESFK
         ScrSNYsKA9fpN4RfTB/7PsDUtiMJ6kTz2Gm85mH3CjFXTTUD9edEhRJFq6QZGvEbV21x
         wpWQN1CavsjWqK9GP4aMwcpuxggAOa1SetoXyu1qMBvStvdZm1DmeO+kot7xoxPDKZmD
         HqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p8WCCnGWa29x2/KunWHwcjm82Vw3dcAhuVE+3OJhddw=;
        b=6zopLpWcFXmD9H35rn+j4GTfNBSoZbrm/MERwKMw1WLovXoI5vlUQJqM8a5kSxkwBB
         rWmTu1h0NTc3Ih8C+ZEmOkT7Hv4R8yrL4oYvKQ+O9GMHvEd4+Eg0rKjPIsxnT7XjU5uI
         +dFJC/MTwxdvH/f7OrFpSmOxF5lEh7eQ21w48ANMpEk8Q2T+h8H2hsoSnscuaSgs6p7g
         LKab0ZlBZil8100uP8eZH9tT8dfO2bGcucF+5WQfi2GIzVZohUAi4k+H7SbMamaE6Yxy
         SItASwGyQ1wFs2tR9HDO+VV/aT0DgIzMvx9VBM66d+de6hmU4YWudcNKseSd5dlqMhDE
         Ca8A==
X-Gm-Message-State: AOAM530kqzBfLypqpaLU1fNw1XSqYaRK2BWJKOosBuerN+aMSVYf95b0
        SobDZETzK7LvxAcAmuhBzxC6fAZ/ui5Q31/j2Gk6
X-Google-Smtp-Source: ABdhPJwAbxoeGs0mbCBHBjXTOn1yFExp0cgb99yx3IdluFYlp9BKuUWx279YFfFYR0f5mulARyCVEG4/C/IK9Cz3ldw=
X-Received: by 2002:a17:907:629b:: with SMTP id nd27mr37148924ejc.24.1634655210383;
 Tue, 19 Oct 2021 07:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211016072351.237745-1-cuigaosheng1@huawei.com>
 <20211016072351.237745-3-cuigaosheng1@huawei.com> <5543735.DvuYhMxLoT@x2>
In-Reply-To: <5543735.DvuYhMxLoT@x2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Oct 2021 10:53:19 -0400
Message-ID: <CAHC9VhTtyQKVkWbBy9DTYiZzZCcMspfruPzx3Kf5ZgD4UzsX0g@mail.gmail.com>
Subject: Re: [PATCH -next, v3 2/2] audit: return early if the rule has a lower priority
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Eric Paris <eparis@redhat.com>, rgb@redhat.com,
        linux-audit@redhat.com, wangweiyang2@huawei.com,
        linux-kernel@vger.kernel.org,
        Gaosheng Cui <cuigaosheng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 10:51 AM Steve Grubb <sgrubb@redhat.com> wrote:
> Just wondering something... If the first thing we do is to decide to return,
> should we have called the function in the first place? I wonder if this test
> should be used to break out of the rule iteration loops so that we don't keep
> calling only to return ?

Patches are welcome ... ;)

-- 
paul moore
www.paul-moore.com
