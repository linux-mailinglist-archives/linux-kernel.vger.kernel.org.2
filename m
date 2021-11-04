Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0AE7445968
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 19:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbhKDSNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 14:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbhKDSNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 14:13:51 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C1AC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 11:11:13 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d12so10155385lfv.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 11:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nf0H9x5iC2UijIAft5liiq6zHCoI2VPB3p3SeysRKEk=;
        b=Uwu8a58w2K2ozIztcp+NlMX1tiXHAgLmZSW0tAlxr4RT7mZUZhwi9KscudA5wVqhBQ
         VsQJjUy7lLJrCJt2TPhk0RPqqZlqt+D2WmNlO5+F1nEfD+sjD4Y3323mu1LQlMflp7TZ
         DJe1bcPkA1lE7zcYzWvaIaphlXfZZUXqsukwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nf0H9x5iC2UijIAft5liiq6zHCoI2VPB3p3SeysRKEk=;
        b=JdDkxPvSEiDG4kD/p4U+W7EQh1F7xQCELJ8Neo4jyZLdBmUFcEdk0BPeeur27twMtf
         Q7DgW2GlKOarfPbnBHT+4k5FLVSj+hmOZ2wvEYznCInf3nNW/UFuRNQgD4aWhqIjnKZW
         4GfU87EyKzKiMtf9r1ZZ8aDHD5QgAxJSqlnwztwW8LfhTmGjq4Xk5iJVwPds5u8TCO5L
         Kw0/smIcdL36JQv6p+WTUbeySBM0njeFH7yEgEZtmSeYbGSU9YsL6cacQqaToDQNLrgl
         7sMj/Tzee/bgXHJexOnxeiSU88CjjxOOB3ATl3eCqB/hi/K5Gj5N5BLP+CxJvQbkOoR9
         UGSw==
X-Gm-Message-State: AOAM533TN+ss1um/luTBrxTHJjBwTMXTOL/u8SbPmnf0V8Bcz+DyhjIG
        V59w1i2HHCiguVgzSquofnvDSRlud4dDkGat
X-Google-Smtp-Source: ABdhPJx9bW2yRryYxJjCxyDnusBzsi6Tpk60AFWpSMJFpa0HtvbouYonUjkc96ZK3m02tV2X6Pr85Q==
X-Received: by 2002:a05:6512:ace:: with SMTP id n14mr48126488lfu.460.1636049470966;
        Thu, 04 Nov 2021 11:11:10 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id u9sm545175lfo.87.2021.11.04.11.11.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 11:11:10 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id d12so10155200lfv.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 11:11:10 -0700 (PDT)
X-Received: by 2002:ac2:4e15:: with SMTP id e21mr50379940lfr.655.1636049469724;
 Thu, 04 Nov 2021 11:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <YYPrNkweZahTdAbA@8bytes.org>
In-Reply-To: <YYPrNkweZahTdAbA@8bytes.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Nov 2021 11:10:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whX_ygSHr02mhWXO38kddFE_t7ntBHf_sehz=asFfzFKA@mail.gmail.com>
Message-ID: <CAHk-=whX_ygSHr02mhWXO38kddFE_t7ntBHf_sehz=asFfzFKA@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v5.16
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021 at 7:16 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> there is a merge conflict this time between the IOMMU tree and FPU
> changes which came from the tip tree. My conflict resolution is
> attached.

The conflict is trivial, no worries. But as I was resolving it, I
looked at that PASID_DISABLED define..

That too seems to be stale and unused since commit 9bfecd058339
("x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and remove
update_pasid()")

I left it alone because I didn't want to do any extra development in
the merge commit itself, but it looks to me like there's some room for
more cleanips. No?

              Linus
