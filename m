Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F7C3399B3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 23:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbhCLWeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 17:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbhCLWd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 17:33:59 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6332C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 14:33:58 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id p21so47665526lfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 14:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RQaKSaXRDk2dow6GE4dZrjzMFheNvIzIVvUar1V2SM4=;
        b=OTt71XsEpC/pKlsjwBjnLn8uF5DCiDV/zbeeqviLlLatpOPf6Rvn1DGCn/OwZCjRxp
         oghMa0MBAd9dtHBDc0tlO6fCcJiWpCSpjX83phe5pTvnevFqRwTwjg1WHCdIBxjxU8Pm
         8wMSAAPhwMJyaFNplzUVXZgT6rIrcgFUJYgcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RQaKSaXRDk2dow6GE4dZrjzMFheNvIzIVvUar1V2SM4=;
        b=OhnwWJ5KJS1BXucSeP2EWpNnatam1iBvacljpNBZQKAULexurk2dyk6vQNSv2ql3Dn
         n0RMDUFQDtHgtzqysKVTcH05s80IGTAO92veOwIHTPx48sB8u2iJC+i94oavW89P5GQq
         +zVqbQTtRXXpOHYb6b1JeIW7R0o3R6eiBS3GqjXmbZu9+YpedJlwSj1FwGUJOKJNfehW
         fs4J8xndlt2dJBYcHTaxbDCZDmbVRJzc4dvIRgfr68Fur7ZxJf/ExJDiHiVdw0RwkvmG
         b18nkWiANL54ucoVBP/tcI2jJOMWQ7YOB8ws+cVHSQSS1W0VNuy/2RVI9iagrmh0/+UY
         2fZg==
X-Gm-Message-State: AOAM533XVea3bBTJSa4poIiUcN+ZzfyulSw7v+V8IWrRXhnQneo8foCt
        L9Y46G+UZthFfvb/4rSZnkQUNS5FUB7VRw==
X-Google-Smtp-Source: ABdhPJwT2JTJa8bWpypJu+pB/KGbC0UJrjz+VdW8O8w5AknXaYv3+1Td/i0WmC3hRfZ3etY/YGrbKw==
X-Received: by 2002:a19:d61a:: with SMTP id n26mr771124lfg.383.1615588435798;
        Fri, 12 Mar 2021 14:33:55 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id t11sm1867969lfc.100.2021.03.12.14.33.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 14:33:55 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id f26so9241006ljp.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 14:33:54 -0800 (PST)
X-Received: by 2002:a2e:5c84:: with SMTP id q126mr3527133ljb.61.1615588434541;
 Fri, 12 Mar 2021 14:33:54 -0800 (PST)
MIME-Version: 1.0
References: <m1lfasf44s.fsf@fess.ebiederm.org>
In-Reply-To: <m1lfasf44s.fsf@fess.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Mar 2021 14:33:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=whw8w_a727dqokA3AsifsMQ2=qZYt1Go8+KCTKczxxSWQ@mail.gmail.com>
Message-ID: <CAHk-=whw8w_a727dqokA3AsifsMQ2=qZYt1Go8+KCTKczxxSWQ@mail.gmail.com>
Subject: Re: [GIT PULL] userns regression fix for v5.12-rc3
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 1:34 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Please pull the for-v5.12-rc3 branch from the git tree.
>
> Removing the ambiguity broke userspace so please revert the change:
> It turns out that there are in fact userspace implementations that
> care and this recent change caused a regression.
>
> https://github.com/containers/buildah/issues/3071

Pulled.

But please cc the kernel mailing list (or something like that) for
these things, so that you get the pr-tracker-bot reply automatically.

Perhaps you don't care about the pr-tracker-bot that much, but even
aside from that, I just like the pulls to be cc'd on the lists, if
only as "documentation".

(Plus since I've gotten used to seeing the pr-tracker-bot
confirmations, I then get antsy and wondering if something is wrong
with the bot when it doesn't respond fully when I push things out,
which is how I noticed this one).

              Linus
