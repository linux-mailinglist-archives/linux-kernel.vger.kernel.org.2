Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB0F352E47
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbhDBRaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBRaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:30:18 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98153C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:30:16 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id q3so5814501qkq.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DRNvD2RZwkvfxZeMQahLHViX8Lbm4hnuuu0I+GZK54A=;
        b=MTdGyVvrDep3yoWnXlj9PW8WZwL5t7qwsdbnOchYfmYvMB2HUQkpdBTfNKn6fJKQTY
         2TDVRP82/IV2Fywygt2Dey0ONke+llzbJLktor50u+zzHL+XkfLcgfRMoXqlFyMfyfKy
         YU/lXsmW/fa8KSoomYVtceqARiTNj6oDrKifhrKAYYoJiW6fnUWPwb0g954VBl7vL1/L
         /EXlnc5uw9hmJnyO7a7pyJ/fnqyB4dtjoYXUGOSeXWubo9Fnthk2PLVIYOoIC6iiGe6X
         at5ilZSWTgG/j417bvW0cyiQvdFx3CV08jt3+js+21fwiuL8HPuvWyzh+wQbfeAGzs89
         jS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DRNvD2RZwkvfxZeMQahLHViX8Lbm4hnuuu0I+GZK54A=;
        b=oeRzsPtN5VkiHnWK/Vvd6R1wfMvpR02wMB8hvhTsJiuMDXERRWxvcpd9X6bR9PyDaL
         FqUsbV9iuoY2ZFg+0z2tZI1HcaPb4BmHFznBxuGH5Hl7khJPo0eYX4o8uIWuxrUIDL4J
         HEGA6H9pBqiQ6vyIwUoF1g1KYTEGzPh7NAnZuYLlX6j2kK/SCH7e8t7DPpzR0ydwBCEu
         75hkiRTihZEQurQwdrZyF3jw8A2SwfpdtyNe4tC4uYR43r2tXyjpcGWpC0bb45mm1yB9
         c0SHcdQPcILiH9Ytu9J2dUnK0yr2Gfg+Y/4qPbYDIP+tuehGrYv8sO40gcVI48j9dOD5
         31IQ==
X-Gm-Message-State: AOAM5310lNI3vbgl/n/+ACkwo31dWfe9+0TvJinZ1t/ZzV79CMeoKP9z
        IugPVVfUaGX24Rj1Eqsxuxy2Gw==
X-Google-Smtp-Source: ABdhPJyrSrnm5Q9XdnLTCYqtUFj82QUxNm5rK0YYwf4tJ6SJQd++2gJQRfp7gSQwdsMUzboInWu8iw==
X-Received: by 2002:a05:620a:11a4:: with SMTP id c4mr13818945qkk.313.1617384615843;
        Fri, 02 Apr 2021 10:30:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:8ca7])
        by smtp.gmail.com with ESMTPSA id n140sm7682859qka.124.2021.04.02.10.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:30:15 -0700 (PDT)
Date:   Fri, 2 Apr 2021 13:30:13 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Subject: Re: [External] Re: [RFC PATCH 00/15] Use obj_cgroup APIs to charge
 the LRU pages
Message-ID: <YGdUpZMNNndEV5+9@cmpxchg.org>
References: <20210330101531.82752-1-songmuchun@bytedance.com>
 <CALvZod4xHNmTQMd+zg71s7uyXUHEfwnQ-zqRXSWphwi9RogeNg@mail.gmail.com>
 <YGN0141iu5HTGiNJ@carbon.dhcp.thefacebook.com>
 <YGOYYgWbwiYlKmzV@cmpxchg.org>
 <YGOgth4IUflVE/Me@carbon.dhcp.thefacebook.com>
 <YGSSemLLpiHJHanV@cmpxchg.org>
 <CAMZfGtVYMDt_3CyH1g8d+Sey8J+W2HVY73xwCk_anm3UgHcr0w@mail.gmail.com>
 <CALvZod6EeDeb8S-LT8BgFP=KqUKqGS-EnRTKCy+ajAthMC2Vfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6EeDeb8S-LT8BgFP=KqUKqGS-EnRTKCy+ajAthMC2Vfw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 10:15:45AM -0700, Shakeel Butt wrote:
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

Absolutely. I think it's an important discussion to have.

My only concern is that Muchun's patches fix a regression, which
admittedly has built over a few years, but is a regression nonetheless
that can leave machines in undesirable states and may require reboots.

The sharing and reuse semantics on the other hand have been the same
since the beginning of cgroups. Users have had some time to structure
their requirements around these semantics :-)

If there were a concrete proposal or an RFC on the table for how
sharing and reusing could be implemented, and this proposal would be
in direct conflict with the reparenting patches, I would say let's try
to figure out a way whether the bug could be fixed in a way that is
compatible with such another imminent change.

But we shouldn't hold up a bug fix to start planning a new feature.
