Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6EA3FE555
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 00:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242045AbhIAWNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 18:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239808AbhIAWNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 18:13:14 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0138C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 15:12:16 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bq28so2161052lfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 15:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E+Fyv92PXA9gzok5ITdHGOFJ4zvWuLPttWT0sXiwbuY=;
        b=P/zjsvYhVimH53GVm3VRIHavK0TzTVWZ3S20XWcHZtI3Ok6nbwmxVVjZuG29EQHbXA
         a/J+j8WiV8ej5TNHY6GACl2uRX6tD1/4jLPNEy98S0vxmJ8i9j3QShEiwZfLwVTPKqEI
         C40i+OSOLwUfQzOZKEjYmMOYnz11oqk48f+7Z4ToliRvyCPPwEBey2ViEWt7JWwKSYAl
         85sQ7ANblqrrYaoAFH0grmD9PNRkhjPyIGlBuTnOxZUsQMsOeEAcBaA6s/JbwMKmBaIu
         E6DqdD1G9TOV7SxqtbH3tiFkbA54oeHs1EPYdetmP4YNbnUjpv+5EmxWyEduLcU79B4a
         Iing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E+Fyv92PXA9gzok5ITdHGOFJ4zvWuLPttWT0sXiwbuY=;
        b=KxQYmEiUJ4vxqMvRZuiMuncgDNAQkld8T0CwzwAdZPwndOFPbR3X5V2XGKkyal5dUT
         h6maWVIyoGNUSTsBIYGOxgCmVjZq8cwzH+Sxoe0BTsUfYTtBJFnUXmPdlAyN4jPDzQkQ
         jp61J/zucSo0utn3YvWW9M3SxIOIygMbjiQfJ8w3lw2ujCFjpT7BWMU+m3sjol3Z4104
         sctBToJ8boW2G8SSn9XC5+eZ1xWkx/R12GDasnzndt0cqtiELiA/F9LlvkJBowSz4d1M
         r7E/laYUUYv0/UWue3XPGLo561qpvHthbrwT+IvXatJtPBzQRYkslWlI4kWguH2Kdl+k
         1dMw==
X-Gm-Message-State: AOAM531bz/0ndUXaxcprCcsfQhi0JsWOiNy2MFmIgc0UOjMlc7rgN9wU
        wUd9vA3bLIit5rDcwYKN/IbfMmIlafP5EHpagzgx3Q==
X-Google-Smtp-Source: ABdhPJw+dCMd39zqq9Qpu8A85lu5ZdzynczxT9xWlHKMOvrCsrRBBwqsLI5/Ugo+E+qf5lGRCOfCq2yu0xk9f8m+mvk=
X-Received: by 2002:a05:6512:1084:: with SMTP id j4mr36628lfg.113.1630534335106;
 Wed, 01 Sep 2021 15:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210831224510.703253-1-saravanak@google.com> <YS8cncQxUZDRuhUG@kroah.com>
 <CAGETcx8d0KR3BeLxa6eKr_QkNgg=+dcq18tAu2A5M6W9pMFOHw@mail.gmail.com>
 <YS8oOWjFe4yQ1Q/v@kroah.com> <CAGETcx8B-9GJr_wCRLqH=eBKY+f=Cd+LGWfM+GQGt6HzOj1TdQ@mail.gmail.com>
In-Reply-To: <CAGETcx8B-9GJr_wCRLqH=eBKY+f=Cd+LGWfM+GQGt6HzOj1TdQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 2 Sep 2021 00:11:38 +0200
Message-ID: <CAPDyKFrfe8joPPiUqkRv9BHmewwphWQshZzpBPbQiZ53z1CZow@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: fw_devlink: Don't create device links for
 devices not on a bus
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> fw_devlink trying to interpret DT dependencies can sometimes end up in
> this situation for some uncommon cases. But it's not helping [1] or
> [2], so for now let's drop this patch. I'll come back to this if I
> need this to fix any real issue.

Just to be clear, the issue is really there, with the psci power
domain, for example.

I am working with an ARM vendor on a platform that has a child node
below the common soc node and which child node is a consumer of the
psci power domain provider node. We fail to get the ->sync_state() to
be called, for reasons that have been explained by now, I think.

The reason for explaining the problem with a superficial example was
to try to easier point out the problem.

That said, I would certainly appreciate your help to get this fixed,
in one way or the other.

>
> -Saravana

Kind regards
Uffe
