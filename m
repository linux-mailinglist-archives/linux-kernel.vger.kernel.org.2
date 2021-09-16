Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F42240EBF3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 23:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhIPVGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 17:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbhIPVGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 17:06:24 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D362C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 14:05:03 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id b15so5257406lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 14:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=23HNxgixZz7HROjNjlGvcSmaUCblTGeHOsIAJ8Co38s=;
        b=iDY2xncG8BV1STCUKqiHq9fAWVQ7uxUoGme0MVCBxmh0aeyhBCf4QisYop1+EzjZiX
         JjchHn4ne/4IhtARj18LA568/XiZdt4l6zVCrqpGkeQYafx6Xgb/1KqQuyA8PxpRWTqf
         sXWiyC06t52sI02f1Xa+skdlNHN06dBwScnhizH1tsPyTfWgY/UUXu7kblbx0w8Q8sS5
         KfcoSjEAUHx19x0avJSMHFmkBTMRzcoYeqTeWG7To6tj9p3zVZJzTHliHZq8KrNPzm/J
         G6vVuoVisa4WrkOoXs4o9llycKGwVEY80vsvzzkEyvL2IFokW+c+/NVjnuuXol2J2kNi
         jFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=23HNxgixZz7HROjNjlGvcSmaUCblTGeHOsIAJ8Co38s=;
        b=zrOe9K4tDm9tjb3gekry8ISMNUvDb1+NwdS84AbD6VaobkboxHXAWfjbkbvBPw2qjM
         QeoeHXwZA96m2l1B8lPULy/9zB+og8+LlC0d+vAWsEPPvss4napRb6oTQAp1JX2gWZIt
         QEIO19KvrhR4tdHc6Apb0da6FtxWLxR7+kw4Ul3xeOH7yQtwg5Hnnsd0JP37E5Zpkx2T
         pRsHQREm9Bg8mnnMe/OfaZDBTGjJnJa8fv2D1kVSXtcz4Da0kq4zP55KWknQeKK5CYCJ
         cTGqHc0GMc7tZegFXGgq3GKt82Xrg3TgnmU0jYgejFufgVwXixmIER9AXuR5Pd1i/nXj
         Zlow==
X-Gm-Message-State: AOAM532B/TD98i4CTyVLhUZjSVAZkJaIPnk/Q01y4rhrgekRRZ6E4hq4
        07OQjD5QcOJX1lN/A2V4zrLda3z/vDR8wdIjz95VoA==
X-Google-Smtp-Source: ABdhPJy2MhLJVak4fVGGClbNu8ki6/UdSBfbyC5LLDi2KCOHNV5eRMb85bbEIUmQfPma5wYrcd4boLOFNgfq/5O9DPA=
X-Received: by 2002:a2e:9ed9:: with SMTP id h25mr6435874ljk.40.1631826301732;
 Thu, 16 Sep 2021 14:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whiFC8Az2wD5_DCeysw+DV4srAj3sCbVP4asPPEJbOpqQ@mail.gmail.com>
 <64b88941-9ec0-8552-d05d-6503497f6f9d@MichaelLarabel.com> <CAHk-=wgcPrGW1=A9XetuUZv_QHf1p7znUUGbm7UCcawbboxRCQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgcPrGW1=A9XetuUZv_QHf1p7znUUGbm7UCcawbboxRCQ@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 16 Sep 2021 14:04:50 -0700
Message-ID: <CALvZod73acr3zhbGzzQ8YyNGhTOe-6NhUNH6Z6O6FbD+oFoAmw@mail.gmail.com>
Subject: Re: memcg: infrastructure to flush memcg stats
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Feng Tang <feng.tang@intel.com>,
        Michael Larabel <Michael@michaellarabel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 1:45 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So the kernel test robot complained about this commit back when it was
> in the -mm tree:
>
>   https://lore.kernel.org/all/20210726022421.GB21872@xsang-OptiPlex-9020/
>
> but I never really saw anything else about it, and left it alone.
>
> However, now Michael Larabel (of phoronix) points to this commit too,
> and says it regresses several of his benchmarks too.
>
> Shakeel, are you looking at this? Based on previous experience,
> Michael is great at running benchmarks on patches that you come up
> with.
>

Yes, I am actively looking into this and the discussion is happening
at https://lore.kernel.org/all/20210905124439.GA15026@xsang-OptiPlex-9020/T/#u

I would definitely take up with Michael on helping with running the benchmarks.

We know the source of the regression which is queue_work() in
__mod_memcg_lruvec_state(). Previously we were doing atomic addition
up the memcg tree. I have to come up with an approach to reduce the
calls to queue_work() in that path.

thanks,
Shakeel
