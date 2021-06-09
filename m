Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846CB3A1760
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237527AbhFIOhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:37:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60776 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232850AbhFIOhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623249338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M7rJIXZOoBsizKD/ExVFHImSCznVlsYup2Ucxq/ePBQ=;
        b=ZVyUH9Yn+trcZXD0vrGhafM2JcI+aeUPBatb5OcWwX6RuAAkh3FgCyEmtJCtu+b9NB2ZNs
        5cAzcb5G/9Ad4dbH8jh5WPivbVlrkzxC/16/BLBn2e3mpbRY5ZHXUuU2O5Jdx2UHRyRR4m
        T7lKxJp9JirEs5SibCduLEFPFGLNa4Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-DkamC2aNP4KRnz0_wOdOSQ-1; Wed, 09 Jun 2021 10:35:36 -0400
X-MC-Unique: DkamC2aNP4KRnz0_wOdOSQ-1
Received: by mail-wr1-f72.google.com with SMTP id n4-20020a5d42040000b0290119fef97609so1015976wrq.18
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 07:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M7rJIXZOoBsizKD/ExVFHImSCznVlsYup2Ucxq/ePBQ=;
        b=fTnhfBzV4I4xaVZ+BD3Rh8J0dIor1AfFl0+HrFeFhQYb9lTimjtcuV3uaVHzB/STDH
         A/7Vk9ieX52WA1brlHGBk5s9hdwqRl5SmVynfxLVZKGCSEW+akIJJk7p+6xGpTDF6ymL
         rTGcBBH8rtWxIu8RfRTTefAoXC2jbCufu5Ib9JRbnF1K8ddXCpByRog3tbNjc8xtJRaG
         PhGMpxA/UtYhbodje1YMIrl/yCyTU2xe0I7dOxP8RZSklLv6v4K3faaHImMoWVhVquII
         n5UuySJ/zp51K1tVGmbOvggRAxi5w34+tdRrYE2ER4bFWhW758FnG0/EYe8gbSJApG4m
         SkNg==
X-Gm-Message-State: AOAM530q6XL72v80zcH3h6rfxa3cnO6Lst0nTHXkoUiFlr/VGX+ITLkC
        w6sDC9flT2F5SvtQa3ReWOxOmX7wcli7jPcBnCYZor1XDj7I3VyfDmHN5l+KeW2ORbnRXKim5By
        9oGZfoI/Afzs/nDzhtbAq8b0=
X-Received: by 2002:a1c:9a8e:: with SMTP id c136mr10007868wme.103.1623249335438;
        Wed, 09 Jun 2021 07:35:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3EdxrYnRuZMFx5h6s9kb+XP30AdOjlQB0mlmCmQ884u95q3AKO1ngW0l8/b7NM5BO6cCO6g==
X-Received: by 2002:a1c:9a8e:: with SMTP id c136mr10007846wme.103.1623249335244;
        Wed, 09 Jun 2021 07:35:35 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id v17sm157730wrp.36.2021.06.09.07.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 07:35:34 -0700 (PDT)
Date:   Wed, 9 Jun 2021 15:35:34 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Waiman Long <llong@redhat.com>, Shakeel Butt <shakeelb@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm/oom_kill: allow oom kill allocating task for
 non-global case
Message-ID: <20210609143534.v65qknfihqimiivd@ava.usersys.com>
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
> Is it possible the only eligible task has been killed and oom reaped
> already?

Yes, I suspect so; and I had a look at the vmcore, the task in the OOM
report is no longer present. Therefore, I suspect the task namely "node"
(i.e. PID 1703345) was OOM killed i.e. a SIGKILL was sent and was granted
access to memory reserves and selected/or choosen by the OOM reaper for
termination; the victim then raised a page fault that triggered yet
another "charge" in the memcg that exceeded the memory limit set on the
container; and since no other task in the memcg had a suitable OOM score
and the allocating task/or victim was "unkillable" i.e. already selected
for termination by the OOM reaper, we got the message: "Out of memory and
no killable processes...".



-- 
Aaron Tomlin

