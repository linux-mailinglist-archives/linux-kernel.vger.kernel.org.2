Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639EF39F298
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 11:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFHJlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 05:41:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54829 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbhFHJlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 05:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623145193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9LlW99M3AUTZm+NlelDfggWF0/pPvt2/vMj5NeCrGTM=;
        b=Nv9RQfFW0OlIE0okbxoYubPT6Rf7fyjNQ/MqcUyOJ0RztUAGWgjl4iFGQBA3BH7q8POIK4
        PRF7ctvlrc7O7gGbAUf7u4QIs6q0d/r9yYddIASKoXgQYi19FmPtsP8XXA1BF/px3CCBFi
        Lful9PJW2GBw25gzsBMYO5DTU0536F4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-KSeVcUuzNDy35M0-ILw-og-1; Tue, 08 Jun 2021 05:39:51 -0400
X-MC-Unique: KSeVcUuzNDy35M0-ILw-og-1
Received: by mail-wr1-f71.google.com with SMTP id e9-20020a5d6d090000b0290119e91be97dso951351wrq.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 02:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9LlW99M3AUTZm+NlelDfggWF0/pPvt2/vMj5NeCrGTM=;
        b=XO0YNjsFLAvP1heHP2fXCs/F60WPPN9AAMXtcxB6En1zrwECEXAvAjZ2BnD3vrfZgA
         vOWppnXlAr0kHpOnc4xtFWipWVm9dSa9/clp18xnE1s3znDkzcf164pjj/dVlmwgCgNb
         2pmgVjPYPNbyf32Cent1KEfB+cmB4qE+0rHZpsfpXA9FM2tEwSMOGJ23rp65LqJgBXxX
         UpZdUtYksQSIiy/s4NjW0f6wuT7lNdU5+uZJdC9Oh9zFiHl2DeugErZ6Of0ww13rWr1r
         vR+CebLDYGJH3eTLhIFJYvuGgc7UGxSBkOQ/malIj9xVipQAQKtJP24ZXJLtAnYmWuev
         XOvQ==
X-Gm-Message-State: AOAM532JJRb2avTgUtSaAdkasqGV0Bux1f/oB6dBlbH7tHTpPWRqUfL1
        tTzYCyQU9epIPscqrgF/IUtoGFTWAqZ5xl35EfYMibMqJ4HLL/qt+CgnEGsyU5n738p3/2jiMX/
        tPK0Q80/REhKA64DUPROorxg=
X-Received: by 2002:a05:600c:354f:: with SMTP id i15mr1628693wmq.131.1623145190486;
        Tue, 08 Jun 2021 02:39:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzngI3VjMKc7cvpd9cz6cCLbAhO3CLKRxkuY/0NW1czdH/+MMSM5D+Gpmg2fYjW6vD+Mjj0Fg==
X-Received: by 2002:a05:600c:354f:: with SMTP id i15mr1628684wmq.131.1623145190355;
        Tue, 08 Jun 2021 02:39:50 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id q11sm18832988wrx.80.2021.06.08.02.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 02:39:49 -0700 (PDT)
Date:   Tue, 8 Jun 2021 10:39:49 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Waiman Long <llong@redhat.com>, Shakeel Butt <shakeelb@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm/oom_kill: allow oom kill allocating task for
 non-global case
Message-ID: <20210608093949.szz3e6ucpf7mztxr@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20210607163103.632681-1-atomlin@redhat.com>
 <c16893a9-35e2-7625-d7f3-83488f874040@redhat.com>
 <CALvZod4eUoquGTQ5AsWgbWTQyqtCNNwb-9+fRw_ZPavH-r9dbA@mail.gmail.com>
 <dc7f54eb-933e-5bbb-7959-815dfbfcc836@redhat.com>
 <YL5tqdw+iWLLavxV@dhcp22.suse.cz>
 <6d23ce58-4c4b-116a-6d74-c2cf4947492b@redhat.com>
 <YL51Tp/3jVHUrpuj@dhcp22.suse.cz>
 <YL57rLFwAo7EpYeH@dhcp22.suse.cz>
 <353d012f-e8d4-c54c-b33e-54737e1a0115@redhat.com>
 <YL8MjSteKeO7w0il@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YL8MjSteKeO7w0il@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-06-08 08:22 +0200, Michal Hocko wrote:
> You are saying that there are other OOM kills going on.

Yes.

> Are they all for the same memcg?

No.

> Is it possible the only eligible task has been killed and oom reaped
> already?

Unfortunately, as mentioned by Waiman, no other task is suitable for
"selection" due to the OOM score (i.e. OOM_SCORE_ADJ_MIN;) that said, I
need access to the vmcore to check i.e. mm.flags - I'll get back to you as
soon as I can.


Kind regards,

-- 
Aaron Tomlin

