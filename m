Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4014164AB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241766AbhIWRzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:55:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44264 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241666AbhIWRzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632419613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RS0FxJMCL0LEUVuvmecsuU2aJmt73QuvVpe2GY5Tuh8=;
        b=DQB4lkCdNPvlZnrtiapavPb185zXSEXePbRAc7Wtbcxw/eTsL/tbX4q7XuETKx2SPJb/yL
        GRB6BmDaScgpq+qB02HobqF0Kwwp+FktxcF5jqjymB4YyhSURXH9f8fSMiwlrgvV9Q79Eb
        zmzECoBzRtS0sH7kSlI3nKOKJplZqOw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-ag9sWM3vPvaBBZ0qnte8yg-1; Thu, 23 Sep 2021 13:53:32 -0400
X-MC-Unique: ag9sWM3vPvaBBZ0qnte8yg-1
Received: by mail-qk1-f198.google.com with SMTP id w2-20020a3794020000b02903b54f40b442so21880891qkd.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 10:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RS0FxJMCL0LEUVuvmecsuU2aJmt73QuvVpe2GY5Tuh8=;
        b=DYqnYRTaHYVgL7iW3+qEnzyOJrdENJu71aiUPf0A51B9wZrmBs34JoUQ2EVINhgaKx
         MiOLIccCfPJAxMrdWmafOc49/1NaxY2Qycqpv0vDbyHObHr3OGKIslxvSmIA24lZiMJR
         CI3i/VEAvN/pBqIQiu8sRnQE5+m5OFxEyy+COuA3SUZ2LT3rRzgbowTEXIi01DlUjdPc
         HBtYlwDQ8DPlfT4AcY87CWwSiLjyZSn2NqZ55AECACsg+TRCrfS/lOGiVJFvwS6VMRuW
         YR4u6nhQKYIhy9j9qUwu1VVzbuaOawhQROeWXqEfUrgLFV6HlZxnF53fYuVOdM9Tie2u
         szJw==
X-Gm-Message-State: AOAM530jcnptCvoKNThi/92YnC+EVY3Oue8lWhXlEBr+AqCQBvU3ZtOR
        eI3KFFBDh4m9TkBXugM9zB8Zxqm7ZdGwbJxzMbJ4K2RRSFuzjSfq6ri+ADj8x/15PmDfQ5MFRG9
        OXQKncsIiOncCmjKjz9BHFsp/
X-Received: by 2002:a05:620a:430c:: with SMTP id u12mr6262357qko.439.1632419611411;
        Thu, 23 Sep 2021 10:53:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycdT/Imqydo2OHV1Pc54wGIoPIGTdOX4/eQnsDbwI+amv/w1r6uej2BSU72J/DBcZSvW8FHw==
X-Received: by 2002:a05:620a:430c:: with SMTP id u12mr6262327qko.439.1632419611106;
        Thu, 23 Sep 2021 10:53:31 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id a8sm3605614qtx.39.2021.09.23.10.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 10:53:30 -0700 (PDT)
Date:   Thu, 23 Sep 2021 13:53:28 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Detecting uffd-wp vma more efficiently
Message-ID: <YUy/GKdVvB16ePF/@t490s>
References: <20210922175156.130228-1-peterx@redhat.com>
 <CAJHvVch3g_UY-akMdu0O9413iCb1H83DLhR1Am8WnfUyV=s1=g@mail.gmail.com>
 <YUueOUfoamxOvEyO@t490s>
 <24224366-293a-879-95db-f69abcb0cb70@google.com>
 <YUu/6lWX92WLUzpt@t490s>
 <472a3497-ba70-ac6b-5828-bc5c4c93e9ab@google.com>
 <YUvj9r3Y954pYPnf@xz-m1.local>
 <CAJHvVcg=oQBcuFjT_RO-_0VMtmyTzkzmUaUv0-zX42CnRWbBAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcg=oQBcuFjT_RO-_0VMtmyTzkzmUaUv0-zX42CnRWbBAg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 09:47:42AM -0700, Axel Rasmussen wrote:
> My thinking there was a THP collapse bug was really just based on
> speculation, not a real reproducer, so it's very possible my
> speculation was wrong. It will take some more thinking and reading to
> convince myself one way or the other. :) Thanks to you and Hugh for
> all the details.
> 
> I'd prefer not to add this fix "just in case", if it isn't a real
> problem, as it seems like it may confuse future readers of the code.

It's not "just in case" to me - IMHO it's theoretically causing more false
positives as I used to mention, at least that's my understanding so far. So if
the theory is correct it'll 100% happen when khugepaged merged some
minor-registered regions.

Uffd-wp could have many false positives like this if we don't support swap - at
last we decided to fully support swap then we removed all the false positives
regarding swapping.  I think it's similar here, but khugepaged should trigger
much less frequently on the false positives upon uffd-minor, than swapping upon
uffd-wp.

But yes, there's definitely no rush on thinking or anything - it'll never hurt
to think more. And more importantly, verify it with some test program would be
great; after all theoretically it'll just work like a charm to me.

> 
> I'll send out a patch for it if / when I manage to build a real
> reproducer. Or, in the meantime, some of my Google colleagues are
> testing this code via their live migration implementation, so if there
> is a bug here there's a good chance we'll find it that way too.

Sounds like a good plan.

Thanks,

-- 
Peter Xu

