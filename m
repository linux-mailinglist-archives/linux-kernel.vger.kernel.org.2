Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE81424673
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 21:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239144AbhJFTKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 15:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21717 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229564AbhJFTKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 15:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633547294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D1dm0Jsv2mUc+jhdc8qHClKIoNz3UWNx693+PgEldu0=;
        b=HRgjqzsSDo8mRKvkmzMwu8G4wQSFJXZ18uXKMGA7AlTyZdNWDcQSlA8zGoqkmbrMvadU3h
        w3mmcMZ19dWdDzfRvcT3qrLCPCTfd3xrLpux1f0WEThm8jA17jaR2mWsmGsV/fuHT97CIN
        pK1pgzjpO94Y09eXn4R7h8aDBln6XJA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-5VaeTSWQNAC-5QKmmKY1cg-1; Wed, 06 Oct 2021 15:08:12 -0400
X-MC-Unique: 5VaeTSWQNAC-5QKmmKY1cg-1
Received: by mail-wr1-f72.google.com with SMTP id d13-20020adf9b8d000000b00160a94c235aso2825377wrc.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 12:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D1dm0Jsv2mUc+jhdc8qHClKIoNz3UWNx693+PgEldu0=;
        b=dkPQFzU2YyLIj7Hjv9asF7LX8EFst9uqRlHM5uAxrEvBQ5yyVwC2RtyUupUXK4ZEIA
         fuSwL/pazEXoc/0Oc2wKIz6g321aoEO4Pb7wg8bOl+reyEF1iHp3VUMvNXXt7+dL4B4D
         Q2gwncDhrckp1Nqasir/4n4Gevlr5T7NnvVrd5XI/vDfEJGL8kACdfHTwtY4c82wMGr2
         bw5ENYZIF4gjS7RRtV0o/LZgqc651PByw6fihl87LD/Zkz6THgoS0oJg0JCRzxt1/DZn
         2inrXD4ewfQqEb8mKx/yZE1ixseyDgMz4yrj6Kjbf9r9TIl/tYi0Z7vIoOy59b5GcM2c
         1UdQ==
X-Gm-Message-State: AOAM530bevfXN2hSQwdfDqUfc4SUrWgsrix45p/2E6iLkObl1AZaoYZb
        l3nSKcsYAzzrnaigTeDdfYJ6UgWF6MgdTiGo+sdAKoUOIMR+hUQhB8mvxoc+cs9KVEiIXYpW42x
        SdOorLUCvuaowQWzbG/WDuCQ=
X-Received: by 2002:a7b:c7ca:: with SMTP id z10mr26830wmk.143.1633547291477;
        Wed, 06 Oct 2021 12:08:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzW3Vplh1TB3mapUwuNjmaCci2ywucaNaPkBXKlNFfA0xxJLgQjy0Of/3AUsfgwnuRUSg9LQQ==
X-Received: by 2002:a7b:c7ca:: with SMTP id z10mr26813wmk.143.1633547291261;
        Wed, 06 Oct 2021 12:08:11 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id s186sm7171134wme.14.2021.10.06.12.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 12:08:10 -0700 (PDT)
Date:   Wed, 6 Oct 2021 20:08:10 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2] mm/memcg: Remove obsolete memcg_free_kmem()
Message-ID: <20211006190810.ume55n4lugekcm63@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20211005202450.11775-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211005202450.11775-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-10-05 16:24 -0400, Waiman Long wrote:
> Since commit d648bcc7fe65 ("mm: kmem: make memcg_kmem_enabled()
> irreversible"), the only thing memcg_free_kmem() does is to call
> memcg_offline_kmem() when the memcg is still online which can happen when
> online_css() fails due to -ENOMEM. However, the name memcg_free_kmem()
> is confusing and it is more clear and straight forward to call
> memcg_offline_kmem() directly from mem_cgroup_css_free().
> 
> Suggested-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Aaron Tomlin <atomlin@redhat.com>

-- 
Aaron Tomlin

