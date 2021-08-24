Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F793F690F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 20:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhHXS1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 14:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhHXS1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:27:33 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A31C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 11:26:49 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id r9so47475305lfn.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 11:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qmh74cK/fKKYlnQIEMxmE3fRPyy9EeyGsyNOi20k3fE=;
        b=AuYIqRWW5Gcs2BY+Yzc+3uSi8UFsEH0E9t26aJ0dmGyJqmYDtfj6HiP8QlQBFwPNaD
         8C1tCdCACpYUF2UhKt+/W9chQfUpM2uKiQRD9nWlXkiuv5+1R5nSpj0kK4XsZMzHJqSg
         QKeP+49MEEsVl8cQ/juKRhOBxK3gTxq/V0btY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qmh74cK/fKKYlnQIEMxmE3fRPyy9EeyGsyNOi20k3fE=;
        b=QWLN1j+wBsah1EmlNuf2KMsGpqtpQfT4baAUw8au6D45t9AIaBjZ9AeYX4afmG32Jg
         nUYbJ9RMWRqmjqko9DUdQ/dRcm67gC5ViFzPtMuE2Lzl9vB31s7TRvaur4bwHAuIjORp
         hR/niH1EgzBS5HyKaHRdi6k5TCJV8qB9v3m/LBXCqLlJ04cI2ZaPZnckmk9MI6D1xExu
         JK/35fGzlkFLTcTw6kW27w1KZQDGEM/DK76ud2YbbVIx+LFZXaNBzPIaXLDK+nvvAAIX
         TWXU9sjnDR8kc1qgKXGhV3JDnd94R/jrojHzX+GNEYECMUAJF1amH1KKHXP5KdgEqjHY
         qKVQ==
X-Gm-Message-State: AOAM533wK1sBIOy/2C43y040JWl/baCDuEqEiXG3WLn7Knp8uZLNvs6B
        eC0Ag21w8dQzpW74SkL/JdCnrNHOJI3qy79+
X-Google-Smtp-Source: ABdhPJyIY35FbEaMiAa4LgFFqmav8iynor7XCcVUn4+mp9qbFF7tuuev/d3YTIursq0jmU4FSi8ZXQ==
X-Received: by 2002:a19:c207:: with SMTP id l7mr16000730lfc.604.1629829607418;
        Tue, 24 Aug 2021 11:26:47 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id o6sm1820670lfu.98.2021.08.24.11.26.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 11:26:46 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id y34so47382579lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 11:26:46 -0700 (PDT)
X-Received: by 2002:a05:6512:104b:: with SMTP id c11mr25943148lfb.201.1629829606492;
 Tue, 24 Aug 2021 11:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
 <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <1957060.1629820467@warthog.procyon.org.uk> <YSUy2WwO9cuokkW0@casper.infradead.org>
In-Reply-To: <YSUy2WwO9cuokkW0@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Aug 2021 11:26:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
Message-ID: <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
Subject: Re: [GIT PULL] Memory folios for v5.15
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 11:17 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> If the only thing standing between this patch and the merge is
> s/folio/ream/g,

I really don't think that helps. All the book-binding analogies are
only confusing.

If anything, I'd make things more explicit. Stupid and
straightforward. Maybe just "struct head_page" or something like that.
Name it by what it *is*, not by analogies.

None of this cute/clever stuff. I think making it obvious and
descriptive would be the much better approach, not some clever "book
binders call a collection of pages XYZ".

             Linus
