Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0855E40FA47
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243166AbhIQOiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 10:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243092AbhIQOh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:37:57 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EF6C061766
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 07:36:35 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id m4so10512355ilj.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 07:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o0d9ENKOVye+QJLjqmO0qleTfZvpM7VavMc2OJ5jdbg=;
        b=P5L9ocytth7pEfd0Icoj1B0iikx/Zuj+Wk2wt37PE5q+dmwO/lEQykdVWm9qdGbPeN
         glQmmG4aGC8NgEnsJkBBo3t/5WmPGyrPFL/KRUnYqs8DdenTO+Aom+Sx9CA8GKqka18x
         9JxQFcoe7dVEEfDMKb6dyJW2Z6jTp6ccgUhxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o0d9ENKOVye+QJLjqmO0qleTfZvpM7VavMc2OJ5jdbg=;
        b=gN9r4cz4zN3ulaGigiwhPVfBNbsF6va4F9IhFihw6vaRUVLn9QX1FF/A55iFRd04Lk
         JoVaZ12Vk+kdZuhn1Q+A2ZH1ag44vJ1VJ0vw9sPYHhk5AKYIZthQZLQdVurAN2umEMIv
         yu+5OX8+fTz8kwi807EM+Ni8934U+2RzQebSle7VY8+EP648X2Do+41X5U/hjOljs1vk
         hSapPCIDrGWpH9mx8kcfUKvpCzfjGE1XsEcrI3T/pnYKSS5IOzwc4oYyFrIFGGX/+XHJ
         vO5Syol58muwaQjN6tO5rQnDJOaq05DdWPT+Uyzh1/MSx/aoY2Z9RjdeVkceF0dQ9Hdy
         +G0A==
X-Gm-Message-State: AOAM532JlCnqTwqPZOseRX7GuHeHs+Qc3FQZdYJZgUMteDg9CrU2rC2g
        c/A0t9ETeNcVHaikTyOz/R0YnpTuFQx1xg==
X-Google-Smtp-Source: ABdhPJxo8w68hWjXhRb6AglNFZKsNDQRb7lM37cT8b7QEg4XWfH6k7yI/Hj4jVBe4FA6U3VJ3zrQOg==
X-Received: by 2002:a92:7f0a:: with SMTP id a10mr8635619ild.22.1631889394342;
        Fri, 17 Sep 2021 07:36:34 -0700 (PDT)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id s10sm3670691iom.40.2021.09.17.07.36.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 07:36:33 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id d18so109555iof.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 07:36:33 -0700 (PDT)
X-Received: by 2002:a6b:3f02:: with SMTP id m2mr8713467ioa.136.1631889392707;
 Fri, 17 Sep 2021 07:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210916154253.2731609-1-daniel.thompson@linaro.org>
 <CAD=FV=Xri+J2=iQzCHLxB+ksT41V6Rexp+BXWi6Fe7=jq3oTFg@mail.gmail.com> <20210917081816.kkyvqbdptnyke5jp@maple.lan>
In-Reply-To: <20210917081816.kkyvqbdptnyke5jp@maple.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 Sep 2021 07:36:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X1B=+5BtXt=x09uKszYRAzGLEF8dr3ad-2Jp9qRy-_hA@mail.gmail.com>
Message-ID: <CAD=FV=X1B=+5BtXt=x09uKszYRAzGLEF8dr3ad-2Jp9qRy-_hA@mail.gmail.com>
Subject: Re: [PATCH] kdb: Adopt scheduler's task clasification
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        jing yangyang <jing.yangyang@zte.com.cn>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 17, 2021 at 1:18 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> > Worth having a "Fixes" for the patch that introduced the warning?
>
> I'm never sure how useful Fixes: that point to the dawn of time
> actually are.

I was just thinking of:

Fixes: 2f064a59a11f ("sched: Change task_struct::state")

I know that the logic was still wrong before that patch, but before
that patch at least there was no Warning reported.

-Doug
