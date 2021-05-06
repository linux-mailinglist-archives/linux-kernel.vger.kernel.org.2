Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66942375D33
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 00:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhEFWcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 18:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhEFWcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 18:32:05 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C31C061761
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 15:31:06 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id c11so10027321lfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 15:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=htNAnGunm2mFYSv2XzhlQsCDD0LeBwjAb0MYMtun6cM=;
        b=BORPcZuE9+rrQQNFUoJnt6f4FpTDIRpdNZeTdxMdbIECzBdY5oiwCD0JpZedlSNZ+7
         bix+fDrgKkNKxnNlizSFTjxEzgqSzLtT6D02CJDWAGt9oBFGQ4VHrgxc6tYB6CmAeE2+
         8YQ9a8BVm4oo8k7TJnGL+6WsOCsGhg6VQJj04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=htNAnGunm2mFYSv2XzhlQsCDD0LeBwjAb0MYMtun6cM=;
        b=KOdlSUopHF74IWa3vpFxKLZPFL4ZJkjyis+Acn4N6L2t+nLS6gCZ7nIRedrmMKs7r9
         3fJYOurAiqK7wU1IWFrHfVf9VVhSoBI1WZVFnqEQsDAUy15hYVZCTIN/6BKLlDVy5EeM
         O+7JzbnaurIo+NG15uAys7xITSV/VBo8lzOCroj+VlF2EkoDhARHvXo6VGXfEhZ3USKa
         Q0XGNlGAMBS8/AdorO4VcUf5fT2h8ncnmuu4Dzv9xyMXHva4FFQy1yeMdKYMrrAWn7rL
         Jp1/Kl1sxfutfvZfgfZz4a7S55yAr8JH7OZyPHZcSLmXdDnOn7GoJ9nqlExAOxLvy4gN
         Pn2Q==
X-Gm-Message-State: AOAM531rPQtfVNryAlaE/VbYCmPtwUxGSi0VqLYgETVAN1wcXWgXLRmH
        DmEn42m5hRhTvb15PqQpTUhPPKoucJur0HSA
X-Google-Smtp-Source: ABdhPJxPpcYuQ0rUu2y1lconZIw05zEJUetqVxwIAWo+kugcbpa/euYzzoimBkDQ6plKFvjHMuAtWg==
X-Received: by 2002:a19:48d5:: with SMTP id v204mr4419663lfa.341.1620340263064;
        Thu, 06 May 2021 15:31:03 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id e26sm1339076ljl.81.2021.05.06.15.31.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 15:31:02 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id z13so10080978lft.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 15:31:02 -0700 (PDT)
X-Received: by 2002:a05:6512:1095:: with SMTP id j21mr4272160lfg.40.1620340261797;
 Thu, 06 May 2021 15:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <YJBHiRiCGzojk25U@phenom.ffwll.local>
In-Reply-To: <YJBHiRiCGzojk25U@phenom.ffwll.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 May 2021 15:30:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwgOPQ+4Eaf0GD5P_GveE6vUHsKxAT=pMsjk1v_kh4ig@mail.gmail.com>
Message-ID: <CAHk-=wiwgOPQ+4Eaf0GD5P_GveE6vUHsKxAT=pMsjk1v_kh4ig@mail.gmail.com>
Subject: Re: [PULL] topic/iomem-mmap-vs-gup
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ You had a really odd Reply-to on this one ]

On Mon, May 3, 2021 at 12:15 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> Anyway here's a small pull for you to ponder, now that the big ones are
> all through.

Well, _now_ I'm all caught up. Knock wood. Anyway, time to look at it:

> Follow-up to my pull from last merge window: kvm and vfio lost their
> very unsafe use of follow_pfn, this appropriately marks up the very
> last user for some userptr-as-buffer use-cases in media. There was
> some resistance to outright removing it, maybe we can do this in a few
> releases.

Hmm. So this looks mostly ok to me, although I think the change to the
nommu case is pretty ridiculous.

On nommu, unsafe_follow_pfn() should just be a wrapper around
follow_pfn(). There's no races when you can't remap anything. No?

Do the two media cases even work on nommu?

Finally - did you intend fo this to be a real pull request? Because
the email read to me like "think about this and tell me what you
think" rather than "please pull"..

And I have now fulfilled that "think about and tell me" part ;)

              Linus
