Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D773A2B60
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 14:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhFJMZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 08:25:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46001 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230130AbhFJMZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 08:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623327807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k3ZsCUUFI0x3gcU4BiStSbLUQmPZdLJKXVyrciTNj1w=;
        b=Um8nuXS5/ATis/XaB4oVqNDkjtp4sosVKokfk5aVmF8rAm5d9BALScXie+BIAnejlB99Nz
        3qt1K2PUYEY8TUvY/AupXn2xsBXYkLRHDWPq5+H6D7+ePmpdTriMLOt1LSnyRNy77Plmsm
        N/t6HDVOjJ1c99NAxhjrDzfpzddvfZU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-qtVmBQzQPIuD7QurY0fZuA-1; Thu, 10 Jun 2021 08:23:26 -0400
X-MC-Unique: qtVmBQzQPIuD7QurY0fZuA-1
Received: by mail-wr1-f69.google.com with SMTP id h10-20020a5d688a0000b0290119c2ce2499so794622wru.19
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 05:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k3ZsCUUFI0x3gcU4BiStSbLUQmPZdLJKXVyrciTNj1w=;
        b=QdVob4MoNSTasEtKSVSxrlgx3aTyGdbXcfsenZnkFZpe+iDJewzmaFHsyWigCkDnpJ
         jF7xgZdacrodMApVEL+m8br3d7/WsqkwWeyScob8U4TH9YxXByFj4a9Y36zH1N1Um0kk
         JZMnqcGnvaKiROf2LIHkRveL2TyLspHPVxcKmsUh8nhofagTNRvvV/KW5iLdQRXwTjyT
         8Bjbs/bf97LJ0z4B6nEeXAg+uERS7jJZpCr/skW+THmhMbteaJ50h0FjqTINV0MijkqK
         nJtq2SzadfRFhV0HDFiu7Xd5Qn9OzNLWSDMPJUI/tvOnmn3KYQ65ytRo8SoxsYHip+sX
         Cs5Q==
X-Gm-Message-State: AOAM5337PfWmBMcY80N14nylD4x4f3e4ec6jWxpEILFrbBILr4Vi7NIw
        26dlq8wOmftvrMbcgTHQMWTp0taV7n2AD0CFxrvP/I8E8wmBsA22Z/ejVrixa3ze8YTACHr3srD
        4VnDmeWN54Y5UfDI21XrojNw=
X-Received: by 2002:a1c:98d0:: with SMTP id a199mr14932330wme.22.1623327804933;
        Thu, 10 Jun 2021 05:23:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLBOWhy739yhKr41MwPncysH3eK0v8XABzjqjEi2LNax5ipEJ+oI8jGaCj5PihtPVu26t8JQ==
X-Received: by 2002:a1c:98d0:: with SMTP id a199mr14932315wme.22.1623327804761;
        Thu, 10 Jun 2021 05:23:24 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id o17sm3206320wrp.47.2021.06.10.05.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 05:23:24 -0700 (PDT)
Date:   Thu, 10 Jun 2021 13:23:23 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Waiman Long <llong@redhat.com>, Shakeel Butt <shakeelb@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm/oom_kill: allow oom kill allocating task for
 non-global case
Message-ID: <20210610122323.6geriip66jjmdstj@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <CALvZod4eUoquGTQ5AsWgbWTQyqtCNNwb-9+fRw_ZPavH-r9dbA@mail.gmail.com>
 <dc7f54eb-933e-5bbb-7959-815dfbfcc836@redhat.com>
 <YL5tqdw+iWLLavxV@dhcp22.suse.cz>
 <6d23ce58-4c4b-116a-6d74-c2cf4947492b@redhat.com>
 <YL51Tp/3jVHUrpuj@dhcp22.suse.cz>
 <YL57rLFwAo7EpYeH@dhcp22.suse.cz>
 <353d012f-e8d4-c54c-b33e-54737e1a0115@redhat.com>
 <YL8MjSteKeO7w0il@dhcp22.suse.cz>
 <20210609143534.v65qknfihqimiivd@ava.usersys.com>
 <YMHivM+0DRYXzAD0@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YMHivM+0DRYXzAD0@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-06-10 12:00 +0200, Michal Hocko wrote:
> If that was the case then the allocating (charging) task would not hit
> the oom path at all

Yes, you are correct. I was looking at another version of the source code.
I does not make sense to consider the OOM code path at all, in this
context. The allocating task is selected/or marked as an "OOM vicitm" after
SIGKILL is sent (see __oom_kill_process()).

> What do you mean by allocating task being unkillable?

Please disregard this statement, as per the above.
Anyhow, I think we should exclude tasks that have MMF_OOM_SKIP applied in
dump_tasks() as it could be misleading.


-- 
Aaron Tomlin

