Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383C7418406
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 20:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhIYStG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 14:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhIYStF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 14:49:05 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3B7C061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 11:47:29 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z24so56436252lfu.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 11:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wgoRC94vJTmojEIb0BaRJLpkMpsX8zbbXi4qGB6Db6c=;
        b=eqDFmco1g9n0DNfQq4ygRAzUbZ2f059wEGshhTn3gE8J4vno32mQ/LiIN+tQFbQU1R
         VjNLj6p+qNn51JUF/EclA4sakOUD6akRDJSy8oRUDnjhkSF7CyH7O90g0sllAY+FxcJo
         XeU+EjW+KH1CF9RqP1xUCSEmLbTgd7T2/rBsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wgoRC94vJTmojEIb0BaRJLpkMpsX8zbbXi4qGB6Db6c=;
        b=xwRwV22geFpByLlsHipAEN+eHeHypbPCAkLzOscVMAQB2RtwblOV1Gqymktx/B0Hg5
         rq+bEe0Mcw1U7ZqvLRiCo/P5w/UDs/9R5NnKwLSpkaj2KgrGrn/0jDhmV1JN8KGQLZwh
         YPW3omn5VA+/Eduibbk9wmq4jec6AZWiWt7vu3W6lIXsh222Q1X7w2TxDo3HbztFzVPv
         B9fcQzWLI96Nla3h1MWtEwZYjbjTuywSO+pqLx8xtyRg1H7X85/P+0AOmJuyekzUlQwr
         AzhQMiKY0Q+GjatyPCxu5Xd0avDElcMnRWyBP8KlwdiBUdQSkqsl5ZsyCA0MBy18oVKn
         LVVg==
X-Gm-Message-State: AOAM532X5qVmCVXPq151RLkk+sdYw7s8ehL5xz5ln/JiAbi6clz63mFQ
        6Bk9lJAPtKZME47GUGhAJs7vn5dwJLvDOBmx
X-Google-Smtp-Source: ABdhPJxk8swRjuBc3A3IVu9bq2kHNDDB67blJgPr9krmSYCHNzMpuVB0l3uFSmMyh85Pag8HEMU29A==
X-Received: by 2002:a05:6512:b8f:: with SMTP id b15mr15880104lfv.655.1632595647630;
        Sat, 25 Sep 2021 11:47:27 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id f3sm1094469lfk.229.2021.09.25.11.47.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Sep 2021 11:47:25 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id m3so55920986lfu.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 11:47:24 -0700 (PDT)
X-Received: by 2002:a05:6512:984:: with SMTP id w4mr14706163lft.141.1632595644582;
 Sat, 25 Sep 2021 11:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <PNZPR01MB4415600ACD3C8D9944F15058B8A59@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PNZPR01MB4415600ACD3C8D9944F15058B8A59@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 Sep 2021 11:47:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgML11x9afCvmg9yhVm9wi5mvnjBvmX+i7OfMA0Vd4FWA@mail.gmail.com>
Message-ID: <CAHk-=wgML11x9afCvmg9yhVm9wi5mvnjBvmX+i7OfMA0Vd4FWA@mail.gmail.com>
Subject: Re: [PATCH] Urgent bug fix causing Apple SSDs to not work.
To:     Aditya Garg <gargaditya08@live.com>
Cc:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "james.smart@broadcom.com" <james.smart@broadcom.com>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trivial@kernel.org" <trivial@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 9:02 PM Aditya Garg <gargaditya08@live.com> wrote:
>
> From: Aditya Garg <gargaditya08@live.com>
> Date: Fri, 24 Sep 2021 15:36:45 +0530
> Subject: [PATCH] Revert nvme to 5.14.5 to fix incompatibility arised in Apple SSDs.
> Fixes: e7006de6c238 (nvme: code command_id with a genctr for use-after-free validation)

I think we need to hear more about the problem than just revert a
commit like this randomly. That commit has already been picked up for
-stable,

What are the exact symptoms, and which Apple SSD is this?

I do find this:

  https://lore.kernel.org/all/cjJiSFV77WM51ciS8EuBcdeBcv9T83PUB-Kw3yi8PuC_LwrrUUnQ3w5RC1PbKvSYE72KryXp3wOJhv4Ov_WWIe2gKWOOo5uwuUjbbFA8HDM=@protonmail.com/

which instead of a revert has an actual patch. Can you try that one?

Keith Busch replied to that one, saying that the Apple SSD might not
be spec compliant, but hey, what else is new? If we start demanding
that hardware comply with specs, we'd have to scrap the whole notion
of working in the real world. Plus it would be very hypocritical of
us, since we ignore all specs when we deem them too limiting (whether
they be language specs, POSIX OS specs, or whatever).

           Linus
