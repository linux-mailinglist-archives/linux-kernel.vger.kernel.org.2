Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E440400C48
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 19:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237213AbhIDRfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 13:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237170AbhIDRff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 13:35:35 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1454C061757
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 10:34:33 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id d16so3885404ljq.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 10:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1/lHCDC58EpZAP3lSL5HIsZ7t+vVs/gedrU1qbfjC0=;
        b=g5E0A7pKVAwqmS28GONd127aSSuVA2rRCo0KFjrdmCpo6rlWVPKyBE1s+a1I99PChg
         pjdcRsvnYRVw/J0kgR4KTYtC7JHVyybTqboHqN+10p/hmcbHYK/1Q7FFPkYWSLmMWBLR
         6+tIcgDsIrGGM3fiRmY2IlkJv2zcOqPBLJ1BM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1/lHCDC58EpZAP3lSL5HIsZ7t+vVs/gedrU1qbfjC0=;
        b=cnMrPtepFga0Ovj1dA1y2CdHv2rtxdoE6DqLijpxxhTymwXaNRWyY/KsbuhBYY8REo
         vGkZWpDYobeE/Pr3PV7v8oi7an5t2bJyd57GMg1Z2Qv7dSc45axZttg52AACzXr7ldmV
         C9vtjOUfj/7eU6lXFiglWpln5CBoBxd3EQIV+NGZJsgdsOvCZ+tRuipG/2HNyD/i5lZ+
         J/Iv39/1+YLblU82OFOgbrYQMbH7mMupSVjZEW1moLTd9VE02hgA1SbEZBCt+N38IhEL
         pS+VQg7FlfZXyBAW78HJ6JHfkEu0+ojEjM1vJGVsFnXdrXexjcvHeEKRtJXWlHXltbMI
         I5ww==
X-Gm-Message-State: AOAM5315XGzFKS2vZjGYBXwZHvY1TS1hN9VdF9XZ1S9Q4XHR+0x+jSoK
        VBliGFwzqoeTqq6rIQLJR9jHAp3lKw910BWf
X-Google-Smtp-Source: ABdhPJy2U4wWjxVF54rcdjD1B85UXOTQhbrB1x4BXNiODMX7ej0wvQo4n8v6TJ+e2C+uJXYE3C5vYA==
X-Received: by 2002:a2e:8e62:: with SMTP id t2mr3746731ljk.477.1630776871589;
        Sat, 04 Sep 2021 10:34:31 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id s2sm307761ljj.83.2021.09.04.10.34.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Sep 2021 10:34:30 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id x27so4836813lfu.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 10:34:30 -0700 (PDT)
X-Received: by 2002:a05:6512:3987:: with SMTP id j7mr3646341lfu.280.1630776870597;
 Sat, 04 Sep 2021 10:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <aa4aa155-b9b2-9099-b7a2-349d8d9d8fbd@paragon-software.com>
In-Reply-To: <aa4aa155-b9b2-9099-b7a2-349d8d9d8fbd@paragon-software.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Sep 2021 10:34:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whFAkqwGSNXqeN4KfNwXeCzp9-uoy69_mLExEydTajvGw@mail.gmail.com>
Message-ID: <CAHk-=whFAkqwGSNXqeN4KfNwXeCzp9-uoy69_mLExEydTajvGw@mail.gmail.com>
Subject: Re: [GIT PULL] ntfs3: new NTFS driver for 5.15
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 8:19 AM Konstantin Komarov
<almaz.alexandrovich@paragon-software.com> wrote:
>
>   https://github.com/Paragon-Software-Group/linux-ntfs3.git master

Oh, I didn't notice this until now, as I was lining up to actually pull this.

I probably forgot to say this originally:

For github accounts (or really, anything but kernel.org where I can
just trust the account management), I really want the pull request to
be a signed tag, not just a plain branch.

In a perfect world, it would be a PGP signature that I can trace
directly to you through the chain of trust, but I've never actually
required that.

So while I prefer to see a full chain of trust, I realize that isn't
always easy to set up, and so at least I want to see an "identity"
that stays constant so that I can see that pulls come from the same
consistent source that controls that key.

(We've also had situations where the chain of trust just didn't exist
_yet_, but then later on it can be established as a developer ends up
becoming more integral in the community)

Signed tags are easy to use - the hardest part is having any pgp key
setup at all, then git makes using the keys trivial with "git tag -s
.."

              Linus
