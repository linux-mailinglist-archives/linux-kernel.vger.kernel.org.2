Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5633F218E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 22:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbhHSU1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 16:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbhHSU1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 16:27:45 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC39CC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 13:27:08 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id s3so13481446ljp.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 13:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/83TwebHHmJL69BFYr+1IWSB3TySC/r6MxW9uBWi/+g=;
        b=GQgrFd++dvqTy4n5ah1wmwLwveJavsfRGF/U0Ay5sHyCYL1tB9CedHiNL2eAlmd9TM
         YJ63LGPPToxzqCDQ07+z65M5TC1Wm/Ki3CYnhRCk9K/n/2fnJQPOFh+gCyYg8ufVOn/l
         6uHMY+7AZsU5JxYbXbeetp/lTvDYSp0eJhx+ahZ7jmKAqLnaKqYFxmeqF0UW+Xf+Dz5j
         sWDaZ/zt455CjeftzazWfFULzFzpBZ0gjHhw0+uuqXLtDyjAMDOasmBO/Vrp9zbVVGxC
         wF8sfEbkojmtlfU7T0rzQq92xjoXFBCppMAHDhZxxcPtRujQ9gVTP6az/rXUdY5XzNiW
         2B1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/83TwebHHmJL69BFYr+1IWSB3TySC/r6MxW9uBWi/+g=;
        b=RHJP8vOOz3x+a7o0B6N5e+LbjiPpiuHgifUWszlKKRE36n2mT6A1bUywuqeUHbkQVy
         ByYtMefvixAcYQ1+OgSsNLuV3dHV7nBAgzJObWjYM0mQemPLprDQwvldgvpFk7ALOdU+
         2AL3ymlvUPG9UM7obL0XBlbEp5US4sDC4aTDcS9yC5xHhkdCc7eKDNtAEbIYO2JHiVf0
         IEG6RgXpy/4pYwAsHFKQn4n1LNWn213CQRlr2397Mg12qh7RM4GinjBj6wV0KKNdVJ7K
         HsI3KcJn//9R2SM9TclV3g3Jh5KercwTQDDGj5aN7jgBmu624NnpZiAUhEeofIyMsRRB
         sKfw==
X-Gm-Message-State: AOAM532UpOqAlFU4jcNO+OEO42yFEOwv9rOgYSct0StNbGgsA+hfjDus
        UNqUJzIpQTvXmAk8M69wif0LKflftg8FfNB9571GKTstpezvhg==
X-Google-Smtp-Source: ABdhPJyJe/iQ+7dE7nyV5tFW1yLwKEiBMozZ6YdY/f+OAsNOk7C3HNdIM8l4WWObanUcbS/GC2B7N0lC8aLUVnO1YhM=
X-Received: by 2002:a2e:7103:: with SMTP id m3mr13430013ljc.122.1629404826894;
 Thu, 19 Aug 2021 13:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210819163056.GA9764@haolee.github.io>
In-Reply-To: <20210819163056.GA9764@haolee.github.io>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 19 Aug 2021 13:26:55 -0700
Message-ID: <CALvZod5m3PE1vBEaW+FoiByYHGJZiDF5TR-33dGXpH7BNNcvWw@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: consistent update to pgdeactivate and pgactivate
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 9:31 AM Hao Lee <haolee.swjtu@gmail.com> wrote:
>
> After the commit 912c05720f00 ("mm: vmscan: consistent update to
> pgrefill"), pgrefill is consistent with pgscan and pgsteal. Only under
> global reclaim, are they updated at system level. Apart from that,
> pgdeactivate is often used together with pgrefill to measure the
> deactivation efficiency and pgactivate is used together with
> pgscan to measure the reclaim efficiency. It's also necessary to
> make pgdeactivate and pgactivate consistent with this rule.
>
> Signed-off-by: Hao Lee <haolee@didiglobal.com>

pgactivate and pgdeactivate are also updated in code paths other than
memory reclaim like mark_page_accessed() or madvise(COLD). Wouldn't
that impact your analysis of these metrics as well?
