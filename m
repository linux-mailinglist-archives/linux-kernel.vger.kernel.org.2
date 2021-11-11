Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8832F44DE26
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 23:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbhKKXCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 18:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbhKKXCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 18:02:46 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B904C061767
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 14:59:56 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id n12so8039188lfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 14:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5D3+4vJF30PnckXaBwwWrlTwdIUWKxzS4vTsfPc8j0o=;
        b=J6EayESLNmMLm+bc+qFM6+QK9dseJHiwJiSt9baF/ify2YbXjSf8dA5d0PAANCtBOZ
         EKqoZTX9ZI6RNKYH8gkWuUOhT/cy1q7QHkV821rFCovm5m0SsE4H9JuMCKZB8LyK+6Tm
         P17xBqI21hEG9tIWnia3OVm/bzGh88eGB1qg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5D3+4vJF30PnckXaBwwWrlTwdIUWKxzS4vTsfPc8j0o=;
        b=2n/+39HKWIeSLajcAI1sW3IVl1Jxwd+UsMuAt+SScsU7GJdVxfPqlK13ggUxoQ9+f1
         nEDP31JQSbyWTwW6gIfr8MK2ZJHqyyWWk3bY3dkARlSbLUB1/nJY1BpwL439TZU8oI4C
         CaGFHjYXXvuMCQB15QLMt1lIB/jCJlLURiVvehbY2kDnjz27YshgPR81y9laHkVLpx+g
         0axzC0eevQmViBiMb9rOsm0SbfqTxaXuSSnnPrf8/v196EBnO7XMfF9xjUggi/j29Fl3
         Ub0cW0Udo9k9LZIBttQ3k3tM1E1R+R++WSCrx4HHEYA3bGMqrEQNQwic3Itc+p4Qo0r6
         aFNw==
X-Gm-Message-State: AOAM530BwPlrUISd1XV1ArEqjhReA8IiMmrhMAjPqQ1fFwjmMvAfGYmC
        koFjzlUBUscFdV/IwUZbohfXixxkqHPT50O8
X-Google-Smtp-Source: ABdhPJw3GrxNXnNrVwbMlHFVyjVyzVEry2Jj1xsuBrWBenZRKAWEqbdAAAL8IV0aI3qsGx6pV66LtQ==
X-Received: by 2002:a05:6512:3682:: with SMTP id d2mr10010846lfs.442.1636671593683;
        Thu, 11 Nov 2021 14:59:53 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id p16sm395258lfa.266.2021.11.11.14.59.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 14:59:52 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id 207so14834190ljf.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 14:59:52 -0800 (PST)
X-Received: by 2002:a2e:530b:: with SMTP id h11mr10485841ljb.95.1636671592076;
 Thu, 11 Nov 2021 14:59:52 -0800 (PST)
MIME-Version: 1.0
References: <20211109013058.22224-1-nickrterrell@gmail.com> <471E6457-AF14-4E84-9197-BF30C3DCFFEB@fb.com>
In-Reply-To: <471E6457-AF14-4E84-9197-BF30C3DCFFEB@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 Nov 2021 14:59:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg3Bqbn=V5kbd-5Rz9xzC_hNyOpNLPPTavZ1Zhdz1dt=w@mail.gmail.com>
Message-ID: <CAHk-=wg3Bqbn=V5kbd-5Rz9xzC_hNyOpNLPPTavZ1Zhdz1dt=w@mail.gmail.com>
Subject: Re: [GIT PULL] zstd changes for v5.16
To:     Nick Terrell <terrelln@fb.com>
Cc:     Nick Terrell <nickrterrell@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "squashfs-devel@lists.sourceforge.net" 
        <squashfs-devel@lists.sourceforge.net>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Yann Collet <cyan@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Sterba <dsterba@suse.cz>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Felix Handte <felixh@fb.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Paul Jones <paul@pauljones.id.au>,
        Tom Seewald <tseewald@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Jean-Denis Girard <jd.girard@sysnux.pf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 10:47 AM Nick Terrell <terrelln@fb.com> wrote:
>
> I just wanted to make sure that you=E2=80=99ve received my pull request. =
I=E2=80=99m a newbie
> here, so I want to make sure I=E2=80=99m not making a stupid mistake that=
 means you=E2=80=99ve
> missed my message. I=E2=80=99d hate for this PR to not even be considered=
 for merging
> in this window because of some mistake I=E2=80=99ve made.

Oh, it's in my queue, but it's basically at the end of my queue
because I will need to take a much deeper look into what's going on.

It's not just that you're a new source of pulls, it's also that this
is a big change and completely changes the organization of the zlib
stuff. So every time I look at my list of pending pulls, this always
ends up being "I'll do all the normal ones first".

So it's not lost, but this is the kind of pull that I tend to do when
my queues have emptied. Which they haven't done yet..

               Linus
