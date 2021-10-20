Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81644354DE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 22:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhJTVCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 17:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhJTVCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:02:05 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF7BC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 13:59:50 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 145so138819ljj.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 13:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EnZ7A4UY0agSb3uPzL7oS5C1nA2sCieTMDvuWezVe+o=;
        b=F68BRTp7O6n1sLMNjgzTKzxAQ78hA2eYWZtToD7NV1YJmUiqZIJBdU1Atz2ecebTw+
         FNSlEI2d91M+oau+7PVQSTO9izFnR0F4dHD9oOIYqpaEk1uy9fkgWkTDydjwjA8O0LwV
         DTGELX5LFrSynCm5TqUjl2SQaHi0jxXK+tg1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EnZ7A4UY0agSb3uPzL7oS5C1nA2sCieTMDvuWezVe+o=;
        b=yXPRkgRAxN4EXO4ehUw7Qn8EJs3+oGXqMBDH6n5dOxWmSRPJ/0Q1Wnx5E4t3COqq8y
         jpIKYdnAreIQbS1WAc1WAA/MEi9ZkJN1jXEn5ljDbnbgViKocTs+oMbif0QF2uqK8X+Z
         GGwZQLcOXTC6vJsSTPl5cevKJPXg60e1TZloDdeSLdZakioverrF26U/zsNVYrtF0IfY
         yW43QxSf6sGQt1A1x+i5vcVB9Ykg1N5loxswU00bPbhaJ481vHc8lU8zm0c++wPVg6kS
         ErcS0FSB2BQhO5S2JXIC+arzhiVjIPGdfmUqzVosCkem3fXvcY2EpX8EJwfjf6ePKGTK
         L+Pw==
X-Gm-Message-State: AOAM533fzS2zysgAW9FXRPV1LR3W5MknTF91RkBtjuhgVEM9pUAAWkNo
        Cr9Zj2MruwxTKSuXR+iZu6E9NeaqouWKM3HInfI=
X-Google-Smtp-Source: ABdhPJy+dGKJCMlKU1OJzf7XAkc1TVjgDBIqq0nGAwGeFH4Cp9DqVHn4so2x1UAwyB1P0Bcfc8dxiA==
X-Received: by 2002:a2e:9641:: with SMTP id z1mr1574172ljh.66.1634763588792;
        Wed, 20 Oct 2021 13:59:48 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id k14sm329779ljh.125.2021.10.20.13.59.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 13:59:48 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id g8so421894ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 13:59:47 -0700 (PDT)
X-Received: by 2002:a2e:a407:: with SMTP id p7mr1544717ljn.68.1634763587705;
 Wed, 20 Oct 2021 13:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211019091344.65629198@gandalf.local.home> <CAHk-=wjvGRtwMHDJ9VR8197+_rVveqE73Uv-MMFbvuUEbWKNtQ@mail.gmail.com>
 <20211020121727.57f46a15@gandalf.local.home>
In-Reply-To: <20211020121727.57f46a15@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Oct 2021 10:59:28 -1000
X-Gmail-Original-Message-ID: <CAHk-=whr2M-jzyv9B8Co0V0TMvCpnH24fWYwxXrN9YeGKicoVw@mail.gmail.com>
Message-ID: <CAHk-=whr2M-jzyv9B8Co0V0TMvCpnH24fWYwxXrN9YeGKicoVw@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fix to recursion protection for 5.15
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 6:17 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Oh, and I have a perl script that also adds "Cc"s. That could have done it
> as well. :-/

That sounds like the likely culprit.

I think doing a simple

   decode("MIME-Header", $cc)

should do it, but I'm not a perl person.

           Linus
