Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2323445E07D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 19:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237079AbhKYS0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 13:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbhKYSYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 13:24:45 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27244C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 10:13:46 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x6so28797579edr.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 10:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gv+HQYkMF2MUdwH7i5Rls63Sav/Z6H1TGrZ+exMMaZQ=;
        b=TItRyyYyk4ENYxCUQ4Qsl3l6tZLo/FYeFCqpdiBNSGTaisgS2/ZoqSG/jbgW+X7inj
         iq4iqO/R43G4MV2H+P2Wfu6d4eSHT28liGzs2PrK7DA3wxxtZGxPg7gc6oUzfEYJZefq
         EnMeRVfLN7yBg4Vf3gPpuSzCNtdwPuZ69RxxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gv+HQYkMF2MUdwH7i5Rls63Sav/Z6H1TGrZ+exMMaZQ=;
        b=6YcpzEk32RnDUGo2evP4gLYIjg5NwOqPM6+JbiRi6QPeQKq4mNkdEAtgM5rLd50xvS
         w+C+MMdzSCCZtlvXPSIBQYDFb1zYL2OibeHs05HbEmQPUp4vvElEd7gTjuxgipwZeEZY
         PNqkVWJ7DJ43Vbzepuro50sNNxaGp6Fde6T+GYMcZa7NphpHIta86w5O+IDgdyK6Gv60
         hdOL7rUsS1nlKiVzO1m6AdmwYaBIwMPjpIoYtevD1ox+/CacuCKaXhCy0QpJNuvmu5+i
         oPA09hiGDA1I2C31Xtendkc2qpEAMf9bcXQ9xiJVrJ4EqvSAXmkWRc7kuo8zBWYV2zwg
         QAUw==
X-Gm-Message-State: AOAM530bQwPHMzRsiIgKKseD1iS0ZmpPg+N3r0E29Oj4Yh9Iu6crZN4a
        EbDSaVR+vL6e8/0ReJxzJfZmRv+NlQSWXFb6
X-Google-Smtp-Source: ABdhPJyrdPtKob/jMiO/Q7o1NDiX2nloe59D5zrK4hUZPsz+WGrWKD+wjiQAHttat4rYM21a69ObNA==
X-Received: by 2002:a50:998c:: with SMTP id m12mr40785709edb.19.1637864024480;
        Thu, 25 Nov 2021 10:13:44 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id nd22sm2258487ejc.98.2021.11.25.10.13.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 10:13:42 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id l16so13405410wrp.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 10:13:41 -0800 (PST)
X-Received: by 2002:adf:e5c7:: with SMTP id a7mr9078200wrn.318.1637864021623;
 Thu, 25 Nov 2021 10:13:41 -0800 (PST)
MIME-Version: 1.0
References: <20211124192024.2408218-1-catalin.marinas@arm.com>
 <20211124192024.2408218-4-catalin.marinas@arm.com> <YZ6arlsi2L3LVbFO@casper.infradead.org>
 <CAHk-=wgHqjX3kenSk5_bCRM+ZC-tgndBMfbVVsbp0CwJf2DU-w@mail.gmail.com> <YZ9vM91Uj8g36VQC@arm.com>
In-Reply-To: <YZ9vM91Uj8g36VQC@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Nov 2021 10:13:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgUn1vBReeNcZNEObkxPQGhN5EUq5MC94cwF0FaQvd2rQ@mail.gmail.com>
Message-ID: <CAHk-=wgUn1vBReeNcZNEObkxPQGhN5EUq5MC94cwF0FaQvd2rQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: Avoid live-lock in search_ioctl() on hardware
 with sub-page faults
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 3:10 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> For this specific btrfs case, if we want go with tuning the offset based
> on the fault address, we'd need copy_to_user_nofault() (or a new
> function) to be exact.

I really don't see why you harp on the exactness.

I really believe that the fix is to make the read/write probing just
be more aggressive.

Make the read/write probing require that AT LEAST <n> bytes be
readable/writable at the beginning, where 'n' is 'min(len,ALIGN)', and
ALIGN is whatever size that copy_from/to_user_xyz() might require just
because it might do multi-byte accesses.

In fact, make ALIGN be perhaps something reasonable like 512 bytes or
whatever, and then you know you can handle the btrfs "copy a whole
structure and reset if that fails" case too.

Don't require that the fundamental copying routines (and whatever
fixup the code might need) be some kind of byte-precise - it's the
error case that should instead be made stricter.

If the user gave you a range that triggered a pointer color mismatch,
then returning an error is fine, rather than say "we'll do as much as
we can and waste time and effort on being byte-exact too".

Your earlier argument was that it was too expensive to probe things.
That was based on looking at the whole range that migth be MB (or GB)
in size. So just make it check the first <n> bytes, and problem
solved.

                 Linus
