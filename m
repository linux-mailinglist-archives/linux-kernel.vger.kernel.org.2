Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB563231E6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 21:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbhBWUKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 15:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhBWUIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 15:08:38 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF7FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 12:07:58 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id j19so13067311lfr.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 12:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZSOkOX9Oxu6C56IMtrgavMTFBcu+oQpWxnCNfiE8JMQ=;
        b=Nto23kYX9z9pr0rqJWVkREriLuGi5QjbafJlYTKAMXySlMtUMuJ/9cKSnsg0+HnHMS
         6VxYTZn2nbxn01akyRVDdZvHrKsqJ3wM5BXEmCasyhJ9bFYPcmB2MxMbKmQmXF8Z97+e
         nX4DgARq+dr7pMrDqiKhxtglFBHYzDB99ciV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZSOkOX9Oxu6C56IMtrgavMTFBcu+oQpWxnCNfiE8JMQ=;
        b=fJ1nowmWtAYWfr+qZ0P6R1poZESQXc+A+Z9kw1QmXSkYoZLYvJ9NzUdJvsHKIZBjyU
         iP4RPL7+ikT84Y0aZ0IIIUgjLmDyr6k3YnETTv79stQQnJkELZc4/y5bq+GCONEd7mcQ
         QJaJoHYm6qT5LnqWqeE+gILELPqukueLljBnDM6/GPIHKvwLZ464+nie7zbjzjWG7amN
         IYqLGth98A1dPF1vEhLw8v1PhE5akjysUt+kb61VxGBPJx3jy47mYfWUp5YwqhfAjDBY
         FWT+UgD5HmcF+m+z73l0dqL27UNofTuqRx01/aYWwFQG3A3ZmBScdw9/4HGVsU1o3WYQ
         E/Fw==
X-Gm-Message-State: AOAM532ravwLGXQ6dr5+lEhaHpyLr8pCMeDylH8kgUfGGRwAJCvztPKi
        cLUONIy4YXtl89fAO4bkYhU363+K540Afw==
X-Google-Smtp-Source: ABdhPJzGhzM3qDycyHFaxOdJGC3Mjosk3AHd6RfDWj9TK7wIc4YubEUrxyfAr8YYXsSXn6ANxIIZiQ==
X-Received: by 2002:a05:6512:2251:: with SMTP id i17mr16655217lfu.566.1614110876582;
        Tue, 23 Feb 2021 12:07:56 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id d7sm2840062lfg.303.2021.02.23.12.07.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 12:07:55 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id o16so59958732ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 12:07:55 -0800 (PST)
X-Received: by 2002:a2e:b525:: with SMTP id z5mr9476761ljm.251.1614110875223;
 Tue, 23 Feb 2021 12:07:55 -0800 (PST)
MIME-Version: 1.0
References: <YDUibKAt5tpA1Hxs@gunter> <CAHk-=wipCbbXswcFvnrGae01H54dY1+XoaL+9YaiU71zGzko3Q@mail.gmail.com>
 <CAHk-=wh8vHL43v7GWK9MWrWitSmOmrEw1B0AJD9CrhBc4FvpxA@mail.gmail.com>
 <CAHk-=wiuoRKa=F3txoVHvnca+H=7gJyL3SFYwd3549v-sa0+QQ@mail.gmail.com>
 <20210223200130.GA8059@lst.de> <CAHk-=wj27tmZBzFRTZTAEPd6eRBzP5xCkQM+1cuSx7vzv8K4=g@mail.gmail.com>
In-Reply-To: <CAHk-=wj27tmZBzFRTZTAEPd6eRBzP5xCkQM+1cuSx7vzv8K4=g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Feb 2021 12:07:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=whudLzx0zmn+xLDmC1su6DF4oMQT6uEgjDEq0RsHRsDwA@mail.gmail.com>
Message-ID: <CAHk-=whudLzx0zmn+xLDmC1su6DF4oMQT6uEgjDEq0RsHRsDwA@mail.gmail.com>
Subject: Re: [GIT PULL] Modules updates for v5.12
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?=EF=BF=BCMiroslav_Benes?= <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 12:03 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This is unacceptably slow. If that symbol trimming takes 30% of the
> whole kernel build time, it needs to be fixed or removed.

I think I'm going to mark TRIM_UNUSED_KSYMS as "depends on BROKEN".
There's no way I can accept that horrible overhead, and the rationale
for that config option is questionable at best, and no distro will
ever enable it anyway since they all accept external modules.

If somebody cares about it, they can fix the horrendous build costs.

                 Linus
