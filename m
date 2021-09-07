Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B259402E3E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 20:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345771AbhIGSQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 14:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244207AbhIGSQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 14:16:24 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB11CC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 11:15:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z2so21238094lft.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 11:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wm79qTaMpN7nT2BwS0Vub5W7d+vMXYOezw7ENLjvPw4=;
        b=WN5rZrFXucPapyb/KqoBksMp9uvr/+xNwe3CsvSgYkcIcsTosMQOClJf/8RJ8rTYv7
         gV8Hf+0EiES1rwv/bMWHOI8O+qCs1Lqj0/KIyaGhudeC1VrHUGGCI7VKHV37AWNMA3hi
         +RqI3so67ZL/hrYkyIFCo9Yxxvx0mYekCLweE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wm79qTaMpN7nT2BwS0Vub5W7d+vMXYOezw7ENLjvPw4=;
        b=jkvv2k4MNKoYxi6OaDoXZ0QKV3cg/JMoeNcVkNYqKGgkN2PiF1h07/ak+khFQ0tW9F
         ANxXl4p1ZI1brgaek/fkfrl0DWVUcni42SeddzJ3GsX4FzPjWZ6OSyq4LUYJD5mRnwsm
         HTvpUyyXUD7NsikihDKH93HwriWs5oNmMPM5+R61+pLhoEync1KpLDefK+rcohspwSZD
         03r/CzhuoNpIDSbXGr4SroEv8JhTKkeFg5CvDWnOoSNEBvusWUCpqfV63sDbAGb834EG
         CBNTtqDu4uTdYy4vCWyleM0FQqXFABzprVKMESME7u3Ym1PhleHlRhYbZsIRIsmEDLQH
         61ag==
X-Gm-Message-State: AOAM532zbGc0uhTo67ijU6L9hSyQzixn/INZneZoueRmFXJAgG0jH0ds
        gx49TlN14xC4ADXutwCkWECTmOKCf/T3sQN2YhE=
X-Google-Smtp-Source: ABdhPJx6dW/cMfAYv6DocaqdKlJ5ZcgPsXodywRDdRXeNhKVAKO/aK9O2WtS1bkZLKr3GyGmc5xZsQ==
X-Received: by 2002:a05:6512:c11:: with SMTP id z17mr14139516lfu.590.1631038515626;
        Tue, 07 Sep 2021 11:15:15 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id v12sm1071692lft.226.2021.09.07.11.15.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 11:15:13 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id d16so13217ljq.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 11:15:13 -0700 (PDT)
X-Received: by 2002:a2e:8107:: with SMTP id d7mr16316158ljg.68.1631038512458;
 Tue, 07 Sep 2021 11:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210907153736.GF17617@xsang-OptiPlex-9020>
In-Reply-To: <20210907153736.GF17617@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 11:14:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=4TJ3yN0+qpzDPJcH3KFkVsHcHO1FJjKHjaPTx8UCdQ@mail.gmail.com>
Message-ID: <CAHk-=wh=4TJ3yN0+qpzDPJcH3KFkVsHcHO1FJjKHjaPTx8UCdQ@mail.gmail.com>
Subject: Re: [mm/gup] 9857a17f20: kernel_BUG_at_include/linux/pagemap.h
To:     kernel test robot <oliver.sang@intel.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 8:20 AM kernel test robot <oliver.sang@intel.com> wrote:
>
> FYI, we noticed the following commit (built with clang-14):
>
> commit: 9857a17f206f ("mm/gup: remove try_get_page(), call try_get_compound_head() directly")
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
> [  143.908513][ T3260] kernel BUG at include/linux/pagemap.h:223!

Ahh, well, yes.

That commit is clearly buggy, in that the try_get_compound_head() code
really doesn't work at all for us.

__page_cache_add_speculative() is not at all the same as
try_get_page(), and I should have caught on to this as I applied it. I
just read the explanation, and it sounded believable, but it was
entirely wrong.

try_get_page() is literally about that "page ref overflow" case, but
try_get_compound_head() uses page_cache_add_speculative() which has
different logic and has those extra "this only works in RCU context"
logic.

So that commit was completely bogus, and the "lack of maintenance" was
not lack of maintenance at all, it was all about entirely different
semantics.

Reverted.

                 Linus
