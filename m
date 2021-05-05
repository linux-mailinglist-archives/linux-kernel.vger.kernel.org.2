Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9003374694
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 19:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240528AbhEERVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 13:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238510AbhEERGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 13:06:06 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E147C03460F
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 09:41:23 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u20so3290261lja.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 09:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p632O3naoBU5t+ePrqWjzhzt+/y4X0wDsqF7Yp7JTAE=;
        b=VOga867tf8qZ51Av7HLXkufDjR8oYKWWmLnjl2OZ9OdARtwdCHgrNlP7a69Dr6yTpK
         LsJEaDKpuDZVKLKxp/E6IMxHhBqE5bE4RsUzpaJwdQplak51pLcp/I2gUKIG4lheJANN
         qGPXLL0eidHOiXAlkWp2KAvD+0vRLemkfw114BiuUtvREAaHsc1nQmEhaCzLXiwQv21T
         Vz0wW6X7AufSlpyZ/rSTXD0H72u8l7j3/gPRnVHDoD65NK0qksnVb6O1rtnKah2vRKM+
         MXWH2vXW++jRf1XQTqjVM+SsiSW9TKiKjQquJRaa5wmumkXb9QLUuYx5oQ01Ct8Ka0rN
         43pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p632O3naoBU5t+ePrqWjzhzt+/y4X0wDsqF7Yp7JTAE=;
        b=mSLBNrMAKYCncn5ZXL92SmxNPkuPLHhja0dMNzOuYAWZ+5IgctW913LVHPdTItLg/F
         L6SoW3Eh/6jz0I/1t/oy1uFakOIuWmXfAd08IWgDh02TkJzoHAJq1z20zcXDFZaYYEOS
         Gxrixh6XpVC2Z1o05/60U0aYI/+bVg39kp9WwOX0e5J3Fz0nyoVDlhQ2uoHYewADeqd+
         IsDEObq8fLASEOpWgEt3PFAU+OzUk+HdyJKVs6MfxW13F0hh8lTljnDddzf3YAX4IKK1
         CPAcQGGUc/OC/pS4GlYlXknX77+SxKPuG9lxcjYOWq4ftv+MNevTf6OD8mUWgpuTZY6k
         gatg==
X-Gm-Message-State: AOAM533AjUdoXTgrZLdSycbl2ghgYdcbX+ZJcZRTNjuS19tEbR9L7Dke
        tJrCvA4Bpt97kh4VRHU2Sqpq8MNX31BgK6ypQnzyZw==
X-Google-Smtp-Source: ABdhPJzIGZ3A8EZHTtPpsfgFlHqg1GfFjk7TOSg1IAtTE8PkfS4MOkFrq+AlGG3a8Zp7yYs3lNRBp7bt7VZh4kDc1bY=
X-Received: by 2002:a2e:8e3a:: with SMTP id r26mr14162031ljk.244.1620232881373;
 Wed, 05 May 2021 09:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210505033945.1282851-1-ak@linux.intel.com> <YJI/OwoflyY2IXvf@hirez.programming.kicks-ass.net>
 <875yzxh8j8.fsf@oldenburg.str.redhat.com> <20210505143916.GS4032392@tassilo.jf.intel.com>
In-Reply-To: <20210505143916.GS4032392@tassilo.jf.intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 5 May 2021 09:41:09 -0700
Message-ID: <CAKwvOdneTkwm1xmte2SxwR=pcp3vi320kQuQHtVNVbnqLbcP3Q@mail.gmail.com>
Subject: Re: [PATCH] sched: Work around undefined behavior in sched class checking
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 7:39 AM Andi Kleen <ak@linux.intel.com> wrote:
>
> >  Would you please provide a
> > minimal test case?
>
> You can only reproduce it with a LTO build because it needs knowledge
> between different translation units for this specific case.
>
> But gcc will totally do the optimization even without LTO if it can
> prove the same inside a single TU.

It would be helpful to isolate a test case that doesn't rely on LTO,
if possible.
-- 
Thanks,
~Nick Desaulniers
