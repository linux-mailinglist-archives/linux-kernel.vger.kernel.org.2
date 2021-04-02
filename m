Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D9E35259E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 05:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbhDBDPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 23:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbhDBDPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 23:15:04 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A38DC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 20:15:02 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id q5so2781062pfh.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 20:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SRRgjqZ34MTVBuBEV7ju4Pgz+uX9gggPAvm+h647JYY=;
        b=WpiIjAFAa3LDUSlegmsWYXaJG3Lxq8FnfJDhFAUa85YVy6u2c6LSRBhrYOYeSsrVCF
         IQHD3TSclXT/gOIDAxyTHmP8FjI6ahotRY+OcekK6gn5i/SpVsReSQApGguzpjfIkTbk
         fY6mDvLRcdvTE3tLNfJ7tx6nM9MrOskCPfxYfW1siddrR/tI/szYM72WFHCu5yw4pWnb
         NeKY99YBgNYIKUkXS7UUNlvw6i+cScau0KtRPoNJoWsQKwuqB76YRpcFQw+SXf7HrzFG
         Hz6PKdu+SOae/I0oRF+PZCdR5klqKOXXBwlJ+7WAvcQL7qdmhsn+uS2ycAY2r0ZF7Fl0
         5eVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SRRgjqZ34MTVBuBEV7ju4Pgz+uX9gggPAvm+h647JYY=;
        b=L/XeS8at4iutrOVQPD5vV1N6oduFJuaqKs2fu2To1S0Ji1T+L9vSaFuzRxh9aduVgI
         Ref3gAD+45Ve3gFyygKGO30BPuKmq4CWtQUMhG1Jj6pewh9KCt8vQ5Tp6txwMurDsww1
         pIB4De0bolsz30ltMhq7HFpYvE8Rpz5m+D4kZgky6E9a5y3j5rQiTc+LexIx7n/vkqat
         o+TZqupPAhJ9dhGTWGQp+emfSjRsyfbBAZzm/c8qUMP1akF1XOUg+NcZczYp1TYc9x7h
         WT31IBvOs2IgdtF7CndREYqQyk2HSYNmiYMwYBo2mshCQ1g0FfnxGcFDrXN41wZhL9+g
         7+tg==
X-Gm-Message-State: AOAM532np4xGQ74yZ8WbduU13JOYKTqFt/uQy4V/aI4hpmYfcIoICxtQ
        +0BBHGTufSavBZZxxlB2TCArBtnSHZAWNaz2BE3QxQ==
X-Google-Smtp-Source: ABdhPJwUSy91Vwe8jJkU7IgBm5OUh9KKtZUxJ0Dpr43MIzjX77rXi40U2hmN1yMab/PFdcSre+4AJeMslM+E25chegw=
X-Received: by 2002:aa7:9e5b:0:b029:1f1:5ba4:57a2 with SMTP id
 z27-20020aa79e5b0000b02901f15ba457a2mr10220791pfq.59.1617333302040; Thu, 01
 Apr 2021 20:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210330101531.82752-1-songmuchun@bytedance.com>
 <CALvZod4xHNmTQMd+zg71s7uyXUHEfwnQ-zqRXSWphwi9RogeNg@mail.gmail.com>
 <YGN0141iu5HTGiNJ@carbon.dhcp.thefacebook.com> <YGOYYgWbwiYlKmzV@cmpxchg.org>
 <YGOgth4IUflVE/Me@carbon.dhcp.thefacebook.com> <YGSSemLLpiHJHanV@cmpxchg.org>
 <CAMZfGtVYMDt_3CyH1g8d+Sey8J+W2HVY73xwCk_anm3UgHcr0w@mail.gmail.com> <CALvZod6EeDeb8S-LT8BgFP=KqUKqGS-EnRTKCy+ajAthMC2Vfw@mail.gmail.com>
In-Reply-To: <CALvZod6EeDeb8S-LT8BgFP=KqUKqGS-EnRTKCy+ajAthMC2Vfw@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 2 Apr 2021 11:14:23 +0800
Message-ID: <CAMZfGtVdbu96msmft8k8+uGh4-ttYR4zyyZU_yRSpBU_vxhAcg@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 00/15] Use obj_cgroup APIs to charge
 the LRU pages
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 2, 2021 at 1:15 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Thu, Apr 1, 2021 at 9:08 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> [...]
> > > The zombie issue is a pretty urgent concern that has caused several
> > > production emergencies now. It needs a fix sooner rather than later.
> >
> > Thank you very much for clarifying the problem for me. I do agree
> > with you. This issue should be fixed ASAP. Using objcg is a good
> > choice. Dying objcg should not be a problem. Because the size of
> > objcg is so small compared to memcg.
> >
>
> Just wanted to say out loud that yes this patchset will reduce the
> memcg zombie issue but this is not the final destination. We should
> continue the discussions on sharing/reusing scenarios.

Yeah. Reducing the zombie memcg is not the final destination.
But it is an optimization. OK. The discussions about sharing/reusing
is also welcome.

>
> Muchun, can you please also CC Hugh Dickins and Alex Shi in the next
> version of your patchset?

No problem. I will cc Alex Shi in the next version.
