Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5020A3DEAF7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbhHCKcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:32:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235229AbhHCKcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627986748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cbPTa2hEWdD7Y8ezaxCFaxMcbtkwVc60EGzp199OkUI=;
        b=IgwI4MQ+9twVZqvHjZPiEqeXmTNhftHHunW/pNyynSa61Gsm7BlYXiZbDU+FQYpuVEmOJ8
        KSJe+yuvi1hfJwOYNAX3l45e1q30sAoW7BnhXZIDKRJC+UgbVkHgStTiOpQZK0fvjyDVuA
        5hpn+PE6GjyFlGTMP0g3M6t5xidBX/I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-n1Xrql6DOGS5C6KKCGc9CA-1; Tue, 03 Aug 2021 06:32:27 -0400
X-MC-Unique: n1Xrql6DOGS5C6KKCGc9CA-1
Received: by mail-wm1-f72.google.com with SMTP id d72-20020a1c1d4b0000b029025164ff3ebfso767793wmd.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 03:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cbPTa2hEWdD7Y8ezaxCFaxMcbtkwVc60EGzp199OkUI=;
        b=ApYph/4cXc2peO9lEfOUgLHkY0NalGsaIlZiOduv8gu9MpwJERWE5bhyS1j734StsM
         9571Y/GriPr60zsMGXqYbQyEPkdz7ZhcvFqfGwqk5G/HaBg9CQAjlNi2HMhBr9mS5dWI
         FMgO4ppW3HJBgT81REmgCjnY0UmrADQiEQ9YIIqRLCYB/vNHE/I5o2efyxvLPh8KIKpL
         B7hCWK77upC2YZFSpxLK9AiVVD31hPfGLoB9NLBNKESV5LeNd0oNEn0we28sI6F27My5
         lNz4zfbbwaHBy3m9I3ybfUEaItIHE3ZVMMSrIFZ0luRWrZqAJOjrWmU6N6kG+1f9QPRy
         oAeQ==
X-Gm-Message-State: AOAM532D+dhr8OHxdaZWSD6MVOaQl0Hzsgi8bi/zR+8lkzOYfmP2jDs3
        K7pl4vxxMRHDGB3iIVRFbwWMjqSwRbg5xcOgxaiOido3TGOEQHPMTHyoR7MBZTkwbEYHkYOUEhi
        bJv7TJ42L6nWdWG1Vq9WCZmY=
X-Received: by 2002:a1c:4487:: with SMTP id r129mr3499611wma.62.1627986745758;
        Tue, 03 Aug 2021 03:32:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiuH6Yxazd1Xa3OEWf5D3y4JCoKEmscKsCBIsfPdBqyBkrM8+JwgVbCHp81+RoANDH5/xcIQ==
X-Received: by 2002:a1c:4487:: with SMTP id r129mr3499602wma.62.1627986745629;
        Tue, 03 Aug 2021 03:32:25 -0700 (PDT)
Received: from localhost ([79.67.181.135])
        by smtp.gmail.com with ESMTPSA id d15sm7442140wri.96.2021.08.03.03.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 03:32:25 -0700 (PDT)
Date:   Tue, 3 Aug 2021 11:32:22 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        penguin-kernel@i-love.sakura.ne.jp, rientjes@google.com,
        llong@redhat.com, neelx@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/oom_kill: show oom eligibility when displaying the
 current memory state of all tasks
Message-ID: <20210803103222.wethf6pj3rh2b2uq@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20210730162002.279678-1-atomlin@redhat.com>
 <YQeR8FTlzrojIbSo@dhcp22.suse.cz>
 <20210802151250.lqn5fu5pioygsry6@ava.usersys.com>
 <YQjq1mXDXcS1CMMO@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQjq1mXDXcS1CMMO@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-08-03 09:05 +0200, Michal Hocko wrote:
> There were some attempts to print oom_score during OOM. E.g.
> http://lkml.kernel.org/r/20190808183247.28206-1-echron@arista.com. That
> one was rejected on the grounds that the number on its own doesn't
> really present any real value. It is really only valuable when comparing
> to other potential oom victims. I have to say I am still worried about
> printing this internal scoring as it should have really been an
> implementation detail but with /proc/<pid>/oom_score this is likely a
> lost battle and I am willing to give up on that front.

Understood.

> I am still not entirely convinced this is worth doing though.
> oom_badness is not a cheap operation. task_lock has to be taken again
> during dump_tasks for each task so the already quite expensive operation
> will be more so. Is this really something we cannot live without?

Fair enough and I now agree, it is unquestionably not worth it.



Kind regards,

-- 
Aaron Tomlin

