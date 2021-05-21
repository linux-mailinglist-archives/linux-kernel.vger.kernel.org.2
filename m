Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F5038CE06
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 21:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbhEUTPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 15:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbhEUTPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 15:15:31 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49268C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 12:14:08 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id b26so15190213lfq.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 12:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5oPa6Xr9eac0PsBORLiu0TlT5LtjJE1rGnKDOXc4+iM=;
        b=FZM+cOW+NzUZku+HiAJITJowouhCBpkNsWURcM63zHo2NSoOToXTS3DZjhq2R6Wjav
         E2ermU9AUDzbpNaDUiC4sB+BRQM4xTB/aYH5SKsrbtsY5gtjMvevNm2yYe08TETvQXH1
         0gwA/O1z7JgbtoM0VV+IHuQLgu9VlpQAuWOBI1N7jVp7Gpl0gZNACxp8cr33F1tVebC+
         Bf+OYwEcZELBHbLtemvz/LWeYxZMfYY26CujM6Gy6zI4wtBFI/U3LpAbuTvavII8TgUm
         idj2MxIqFX91k6blfy+u/YZOLK9mX2SAohMIUL63YpWIU/AoTHx40DEw0W9GOzJuxX6g
         mnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5oPa6Xr9eac0PsBORLiu0TlT5LtjJE1rGnKDOXc4+iM=;
        b=iIyq98XJAt5R11XkoEB+2XC7iuUPF0W+xAaqZ6A5FJR+EDE81WwBdacYVBUaWaxWWi
         1DuUee43dCk/g6wjoT/DPbp8AgjThkqAd69uKmYgMT2x24qeCfKRBvh2m3vBM6IBVfN2
         pDv7rRliV7jlzTTiJSzzLs85fPSYAt9v5dzYYM/o9QGSH7guXr+hNJQLq75ooqtAaAwt
         WmO55AY5XaeS2zlcIfkbT26Hhq8FCaHHITVkMdztKtWxCkMpjAsRR4zx4K/c1Y75LKi5
         A2olvVaJ+sGUzp9v1WiShfQcYwPdd8IMRhwzS5BZ4DxKqYYNBIumZJ5pPW9pvjs/4uTv
         bkSg==
X-Gm-Message-State: AOAM531NXpwnTjzE7py2QouZ0izCUtLjnc2CHE5tp/aoFRfMpTb+7oEC
        RhO9L8w+wBcmkZhFPpwnbodtT+KnT1pHiUkS52s7jw==
X-Google-Smtp-Source: ABdhPJzljfo8EYXnQbOzQP0KViedCYWcKCDa8fpsepH7kKBan8/VjwxkEx2EQgztB54zdcBHuBWJfkDWZWrtedKqq38=
X-Received: by 2002:ac2:520a:: with SMTP id a10mr3184843lfl.180.1621624446406;
 Fri, 21 May 2021 12:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210520183614.1227046-1-posk@google.com> <CAEWA0a72SvpcuN4ov=98T3uWtExPCr7BQePOgjkqD1ofWKEASw@mail.gmail.com>
In-Reply-To: <CAEWA0a72SvpcuN4ov=98T3uWtExPCr7BQePOgjkqD1ofWKEASw@mail.gmail.com>
From:   Peter Oskolkov <posk@google.com>
Date:   Fri, 21 May 2021 12:13:55 -0700
Message-ID: <CAPNVh5d54HNYqVSGG==ozA7YjGdmkisg2M+wsYmdgGx2-p3Oog@mail.gmail.com>
Subject: Re: [RFC PATCH v0.1 0/9] UMCG early preview/RFC patchset
To:     Andrei Vagin <avagin@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jim Newsome <jnewsome@torproject.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 11:44 AM Andrei Vagin <avagin@google.com> wrote:
>
>
>
> On Thu, May 20, 2021 at 11:36 AM Peter Oskolkov <posk@google.com> wrote:
>>
>> As indicated earlier in the FUTEX_SWAP patchset:
>>
>> https://lore.kernel.org/lkml/20200722234538.166697-1-posk@posk.io/
>
>
> Hi Peter,
>
> Do you have benchmark results? How fast is it compared with futex_swap and the google switchto?

Hi Andrei,

I did not run benchmarks on the same machine/kernel, but umcg_swap
between "core" tasks (your use case for gVisor) should be somewhat
faster than futex_swap, as there is no reading from the userspace and
no futex hash lookup/dequeue ops; umcg_swap should be slower than
switchto_switch because umcg_swap does go through ttwu+schedule, which
switchto_switch bypasses.

I expect that if UMCG is merged in a form similar to what I posted, we
will explore how to make UMCG context switches faster in later
patches.

Thanks,
Peter

>
> Thanks,
> Andrei
