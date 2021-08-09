Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B743E4F23
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 00:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbhHIW0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 18:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbhHIW0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 18:26:50 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC563C061796
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 15:26:29 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id c23-20020a0568301af7b029050cd611fb72so1104230otd.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 15:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3JoNLp62vjdo8vXgCaNPLV3QzIpcaToJ9w4A3X9RTHE=;
        b=AvYt2iQCQGY3JpTOzHAyRVfLMoOjI8SPsoCc/rpfH5PRPdqKuZ1N+nVtucnojRqP+T
         h+Iy33OhZcOUSyyiHiri6Ng3XEuBmxwh9oYnFOvOBsvn0l88LUQDjOqu8vgRr3iRctLS
         ckPujtdR1JoIFP8nnhaKIDkBm/8fB3eQN1jFtIIO4rCp/qT5MBN/20Yr/9Eml2SFtve6
         rs//Mh+gjscJ/CBeL3HpcJMQ5fQ9tJwJlQa28+gZHq9iwbRhsWMm8ct6g/oxl2tTbeKH
         MocM+qYJ1wnvcHrLEptSwuPNeM5pjVf4s6sKmIOe1iXzNyVI2yxxHaayxX5kNCEnQUak
         Iv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3JoNLp62vjdo8vXgCaNPLV3QzIpcaToJ9w4A3X9RTHE=;
        b=P1GfUB1bTjwgdOY7VWL4aouHZp171BO7vWxukT9NlUFRYQwxtIBqIRnzXmQF3/HdI2
         1t5wdI0ui6tylqM8KeKSXgDHhfKVaVYizZn7XcxQI17yWgamOaCshojMdMhbtfcadJsQ
         h+sfY3N2dIvBu/87V9YRZCoVBDrIwsw4IPdLj5K3enBKFUL+US6aDmJpywB1MszKMtlz
         40rnHYvKl5HP4NW2H94Nk/xEX2VwFpFcqbIE3Kjszn4tkTCB1iUb3xHdo5f64mCXg8C5
         HSxFqEfw0cPQNz+m8Zgq2lqt6dbLAS0JVSSgkxKBDamDukffhKCa7K1ZsBsVN0fWJNy5
         hjBw==
X-Gm-Message-State: AOAM5325F36cv5eucAwWEaKrqNCqowbmIusJ4A2rdCgEEr3AuzeQELJn
        ehhqJz6ihXAn6ZT4+is08oSjRRyHA9UwYuMnYaoveg==
X-Google-Smtp-Source: ABdhPJxshTPGXJiS7SSrGMYcvTnzn9WLMl310xx8BEBrnszTcAbaSm7F+gpU3hHYXD0ur78TSHekwvO19h9+kAZAW6I=
X-Received: by 2002:a9d:76d0:: with SMTP id p16mr18471577otl.241.1628547988711;
 Mon, 09 Aug 2021 15:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210803044607.599629-1-mizhang@google.com> <20210803044607.599629-4-mizhang@google.com>
In-Reply-To: <20210803044607.599629-4-mizhang@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 9 Aug 2021 15:26:17 -0700
Message-ID: <CALMp9eR4AB0O7__VwGNbnm-99Pp7fNssr8XGHpq+6Pwkpo_oAw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] KVM: x86/mmu: Add detailed page size stats
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>,
        Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 2, 2021 at 9:46 PM Mingwei Zhang <mizhang@google.com> wrote:
>
> Existing KVM code tracks the number of large pages regardless of their
> sizes. Therefore, when large page of 1GB (or larger) is adopted, the
> information becomes less useful because lpages counts a mix of 1G and 2M
> pages.
>
> So remove the lpages since it is easy for user space to aggregate the info.
> Instead, provide a comprehensive page stats of all sizes from 4K to 512G.

There is no such thing as a 512GiB page, is there? If this is an
attempt at future-proofing, why not go to 256TiB?
