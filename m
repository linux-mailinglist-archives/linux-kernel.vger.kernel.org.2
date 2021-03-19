Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E37934235D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhCSR3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:29:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34957 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229949AbhCSR3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616174946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LomUmpcQaVh6N02UFTSsiZ9QqjpSd6FGeimkZw0uTk8=;
        b=cZbpI7yspIHvbMuZ4SGb28JmRk0dcXHHmxZAxeU7kRMDWk3+JmmJLZUIfRUJOMTVWKXe5/
        yH7GVtNhdqfBIFlEH6rx9P5V0SbuEgjfECdFc/n4IbgTowLjN9K8L5ZjJvvEOyxEbStciF
        vdQrHmuVrmiNXwGyfxBZH30ZdBWyNWI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-iHJfUg0VO4qn4vGlZ9zSvQ-1; Fri, 19 Mar 2021 13:29:04 -0400
X-MC-Unique: iHJfUg0VO4qn4vGlZ9zSvQ-1
Received: by mail-ed1-f69.google.com with SMTP id bm8so10035085edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LomUmpcQaVh6N02UFTSsiZ9QqjpSd6FGeimkZw0uTk8=;
        b=bbWXN0PDs+SVmJTmzT+S+ArjA+05kdtCpBsk+5qb8iSZlUuNuz8vZlTYxAo01Zfnnd
         miLItjAeNf/EkzKcpsu0fZSdTfAqFojPUlTQBWSowCQ2PBA9NTQ54S3+FSsARf5H9jY4
         bHr2QesvlvtNT53mXnRrmCJ1vibgNKc0BWbLWrIkB6QRm97NmMxDTnFBb288ZTzTuo3x
         TaGHfkf7fHy+sLXqwrKOXi2l6SnVdmOlSYhB8SxNXuo7Jo0NCAoR/QxpF41g5aTlRWHJ
         XbbZaFmBZu/l6eRwSxzHe3Op/rvTmyuFZk7NUgCWMvszjZgaRRRa3YDthOoOzwVtpAz1
         wHpQ==
X-Gm-Message-State: AOAM533MDoxA8nrdcYYdqMr8Y0QVxAGpgZwysFcIcBhPAUvF1E+U0iuC
        EtHoOWQKy5Aw5hcwMOiaOHRcsBaOs47rQ387eTBK0fmd5gDn2i0Hcu+0GwlJDkyMIyl6PAJYQ0I
        oZOgW3rb45xw58Hr4T2qqGTg=
X-Received: by 2002:a17:906:4705:: with SMTP id y5mr5719793ejq.119.1616174943004;
        Fri, 19 Mar 2021 10:29:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwn1utTL8I0+LkwA8AB1Fh4ktosHgIyrKuoo8t4HMBAku6kx8VKgoV/75izwollowIKwHDMBg==
X-Received: by 2002:a17:906:4705:: with SMTP id y5mr5719783ejq.119.1616174942889;
        Fri, 19 Mar 2021 10:29:02 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id sb4sm4056118ejb.71.2021.03.19.10.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:29:02 -0700 (PDT)
Date:   Fri, 19 Mar 2021 17:29:01 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: try oom if reclaim is unable to make
 forward progress
Message-ID: <20210319172901.cror2u53b7caws3a@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20210315165837.789593-1-atomlin@redhat.com>
 <YFN8wXwJA59w9twA@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFN8wXwJA59w9twA@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Thu 2021-03-18 17:16 +0100, Michal Hocko wrote:
> On Mon 15-03-21 16:58:37, Aaron Tomlin wrote:
> > In the situation where direct reclaim is required to make progress for
> > compaction but no_progress_loops is already over the limit of
> > MAX_RECLAIM_RETRIES consider invoking the oom killer.

Firstly, thank you for your response.

> What is the problem you are trying to fix?

If I understand correctly, in the case of a "costly" order allocation
request that is permitted to repeatedly retry, it is possible to exceed the
maximum reclaim retry threshold as long as "some" progress is being made
even at the highest compaction priority. Furthermore, if the allocator has
a fatal signal pending, this is not considered.

In my opinion, it might be better to just give up straight away or try and
use the OOM killer only in the non-costly order allocation scenario to
assit reclaim. Looking at __alloc_pages_may_oom() the current logic is to
entirely skip the OOM killer for a costly order request, which makes sense.


Regards,

-- 
Aaron Tomlin

