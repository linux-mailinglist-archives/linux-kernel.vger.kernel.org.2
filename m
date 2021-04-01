Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C401F352056
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 22:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbhDAUFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 16:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbhDAUFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 16:05:10 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687EFC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 13:05:10 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id i19so2372783qtv.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 13:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJIfyCCxoJ1oRrXpStAL174OJkuWIck/NN2407gpF6A=;
        b=Al+lBo76+4pP3lg8KL5KV05Kkzd5oSl9yZbI0d9YiyfrCx42/zyCTy+/FfwcO5JHPf
         fz7F9K4W58cyG99bBoA5u4vpDoc5Rghu9YO49v9+joDJZKU82Uxql4PBW/83uNH6Sm8a
         57IcgcMLXSy6h87zvnErm83bNXNVwpGqyyOBZEccXVGux1qFPoAp+27iEY89EzGliD92
         HLFaYTkhZq55FxniNUHUTA2VNDjJfboYQP0QnGNtSiI+T1Ji1lmoyYTes4t2Fm5c8dyz
         B0TDEIyKQoymSdyS8u8KU4QHR6cw5pR0M4jNOj4cC4IIDv6cEJOIQd75aV7BGNSizcP0
         E63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJIfyCCxoJ1oRrXpStAL174OJkuWIck/NN2407gpF6A=;
        b=PlYvhPPezjxdgOPcrigvhYWR/zB0XcvLQN8d4ip9XdMnaJdue9+B+NoIYjXbYIaksE
         6453DPgq9gBojpS1O+r7JgbNzLtE4q4fFTKjtCO4Yxid+pVoiuvHc6wm2ZsSemfKniWV
         F6XOxK/AJ47imcQEvfnsyVaU129ryI1f3MaOWVdLkn0jycq8HM5fW7BoL7a0J2mVzktq
         ff5UCHE5B1QlCkVza4cJ8iWmdZB+c7l2M2ecAbnJVFWAxEXZWsPv3kmYSCiRrVTWOgcX
         wkGitHQ5YEExGQAUBOEiOUTSN8DL1faECLONsNn5KrTa3dk2qW4ur/xf2UgkVCQo0zDv
         9nhQ==
X-Gm-Message-State: AOAM531TgokW0Ymle3XhnK5RlPDGvCTyRzIbjOZEuIXrkl5nEBD1laiD
        ATY6rLYzgEoCF1Ahtab4njXAE13rdLFKh0HFFElkwg==
X-Google-Smtp-Source: ABdhPJysEsnw00J777772ETYEKmlBIugUHCoAcTlBnA5MijBujeZj3Yh4tTh2kN5DATCGxlTTX9UhROsMkTj1weJ+RE=
X-Received: by 2002:a05:622a:114:: with SMTP id u20mr8550700qtw.317.1617307509318;
 Thu, 01 Apr 2021 13:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210401131012.395311786@infradead.org> <20210401133917.231259659@infradead.org>
In-Reply-To: <20210401133917.231259659@infradead.org>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 1 Apr 2021 13:04:58 -0700
Message-ID: <CABk29NtHj47DXiFBkJpG748bj2HSG09BCb-h5fXUatFMWn2qCQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] sched: Trivial core scheduling cookie management
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/*
> + * sched_core_update_cookie - Common helper to update a task's core cookie. This
> + * updates the selected cookie field.
> + * @p: The task whose cookie should be updated.
> + * @cookie: The new cookie.
> + * @cookie_type: The cookie field to which the cookie corresponds.

No cookie_type in this patch (or cookie fields). Also might want to
call out that the caller is responsible for put'ing the return value.
