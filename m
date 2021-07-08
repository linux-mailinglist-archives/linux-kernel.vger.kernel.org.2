Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38DD3C1959
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 20:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhGHSrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 14:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhGHSrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 14:47:06 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741DEC061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 11:44:24 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id c28so17634300lfp.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 11:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H90Copkue5w9iSGNVPGNAw4Flq6Q55TWkIAdrELCwBM=;
        b=HE5O8LXKCYXmH5RUxvGLH0utBqVBpLQX5Kf2DIhBzYmckquTD2CtnsEicVLDaWZLpc
         5YmOIWhkCu4PgVgf074nK1bz76AdI+h1P29IgsltIWF3Y5QNolavzbcwt7gmupgQM07Q
         i03U7ZtUn1Qe0zcSQgt+se4ZC7u48LjoEYOww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H90Copkue5w9iSGNVPGNAw4Flq6Q55TWkIAdrELCwBM=;
        b=aE3PZVq0XoEsJ5oJW7uEq1NDyoG8X5CE39xX5HByNau/YCeTv/387VUmm69L+etJnH
         K+tzg3PsHbd2bVLRTY5neehyYH25UGPAp8k/1537Xj7Q81gQaKerSfZyRDVFfegovf20
         BCUjGjzRelxXA909+wi2KLiZDp4C4YQIuhR5r7/lXpL33J2l1WILNnE+DbK0MKPq27ep
         IWinBPcaYkIP/2QIaNtq32qcIOoFAY+LY8GePCAig2f4you2+FCLkmHMI4j5vNLR7g3x
         M2BtTaoDoRr1Y0ZwGZXwFJZr1eKzcwN80xTmibFDob2jcZe4RhI7cDrs2y94Nb4G7DGw
         aqcw==
X-Gm-Message-State: AOAM530tkh+UKGHnL2Jw8R6FIaOa2EbwWa90z0eyfTjWRgMdFGSIkJyZ
        JP0/DTovdg9rfeNWm50DfGoNEVJRhKJ9fHRA+9M=
X-Google-Smtp-Source: ABdhPJxP06Ooo1VFbqmpAD493JIruFY3GnwCPkPkIZWOKU/K0L32U3EYKNomwzAovWFhzyzme02E7Q==
X-Received: by 2002:a05:6512:3ca8:: with SMTP id h40mr25544692lfv.302.1625769862549;
        Thu, 08 Jul 2021 11:44:22 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id f23sm318826ljn.98.2021.07.08.11.44.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 11:44:22 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 8so6466156lfp.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 11:44:22 -0700 (PDT)
X-Received: by 2002:a05:6512:3585:: with SMTP id m5mr24770812lfr.253.1625769861582;
 Thu, 08 Jul 2021 11:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wirhF8G1XniAfxzJXCYUnuAx23Q1WLi_n4+HGsUXv72KQ@mail.gmail.com>
 <20210708103301.2109330-1-legion@kernel.org>
In-Reply-To: <20210708103301.2109330-1-legion@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Jul 2021 11:44:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=whdEAjawjUSeJ+DV25ARdAhbiW_HZM65ZgJx7M94rvLkg@mail.gmail.com>
Message-ID: <CAHk-=whdEAjawjUSeJ+DV25ARdAhbiW_HZM65ZgJx7M94rvLkg@mail.gmail.com>
Subject: Re: [PATCH v2] Fix UCOUNT_RLIMIT_SIGPENDING counter leak
To:     Alexey Gladkov <legion@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 8, 2021 at 3:34 AM Alexey Gladkov <legion@kernel.org> wrote:
>
> We must properly handle an errors when we increase the rlimit counter
> and the ucounts reference counter. We have to this with RCU protection
> to prevent possible use-after-free that could occur due to concurrent
> put_cred_rcu().

Thanks, LGTM. Applied,

            Linus
