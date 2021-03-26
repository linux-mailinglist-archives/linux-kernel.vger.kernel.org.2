Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9BB34A669
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 12:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhCZLXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 07:23:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23834 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229882AbhCZLW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 07:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616757779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=170aP5yspNLVYsVCQJ6t8wrVkNIt5w9MEL3rQNGkYMY=;
        b=EeVl45fXhNsouZBTN3GKtq7xk+Xc1QBQ98JwQC/POLLEx7UTIX7Cs3StyN2MBAIXGf3OSP
        4Zn0F727/9jOTQX2Mv0Ml4UUDYcpijFL6IG/D4IFU/0vt36jDu3uf7jeqMWhEVV4OJS24i
        RbL+mz1RmiRvuHSjxTSQLXORPPTKJUs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-Tk4Y_CAVMseLWBtB-m7D2g-1; Fri, 26 Mar 2021 07:22:56 -0400
X-MC-Unique: Tk4Y_CAVMseLWBtB-m7D2g-1
Received: by mail-wm1-f72.google.com with SMTP id f9so524459wml.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 04:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=170aP5yspNLVYsVCQJ6t8wrVkNIt5w9MEL3rQNGkYMY=;
        b=EwNODzoudOSSw9/81wse4Ov6j9pmOQRAR4N+zU7VZ3O3pUBTWYT8lWOLuX2mpviTQ8
         n6hJMx6UnzCvdvKG/2XxmbMMqi4KWno+Rf8Ao37pEeAuTTFLjOBvqLCTxsHIBWt67btS
         eLclNWmxHd3cTqZfnVSj+bCMavy6JFnxHryAh6UXNe4UFiv6xgCZFhJj46L/lHA33fQz
         2wdKzBorbunM5eOndbNBv++60yovTkIVxqKhcWT+nLKOmWiOisrWbAMkWSu4bGL7YgIb
         u/IUB/x1VXMmyz9zITg2LYJlBCc/ehg/jddJ41z0HZKBncyb0wjg9ILiI02GLZ1Cu6X0
         rRyg==
X-Gm-Message-State: AOAM531oI1QvE+we9QuyNAqvmHxSGmLfFDtLBRNeNUCU/tyFVt/GPSaT
        8WKfRlskAYOsuBF3zJw6greZJgZkAYpIAH2H/1L5JDx6zWDceC9lppHJWyWZuMfTrSnoDCFlpDm
        AY0sa5U7231mW99WMHpk8ANo=
X-Received: by 2002:a05:600c:358c:: with SMTP id p12mr12839423wmq.159.1616757775749;
        Fri, 26 Mar 2021 04:22:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKTIzA4x9VSUDtFDJCM/zLZSZ2xYIS4HRY/EwCmVLuHPBc0STeCDUbT6Q+3AHFzl5Ez5wxSQ==
X-Received: by 2002:a05:600c:358c:: with SMTP id p12mr12839410wmq.159.1616757775548;
        Fri, 26 Mar 2021 04:22:55 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id k12sm12442530wrx.7.2021.03.26.04.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 04:22:55 -0700 (PDT)
Date:   Fri, 26 Mar 2021 11:22:54 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/page_alloc: try oom if reclaim is unable to make
 forward progress
Message-ID: <20210326112254.jy5jkiwtgj3pqkt2@ava.usersys.com>
References: <20210315165837.789593-1-atomlin@redhat.com>
 <YFN8wXwJA59w9twA@dhcp22.suse.cz>
 <20210319172901.cror2u53b7caws3a@ava.usersys.com>
 <YFh10eSTKY5lbE9u@dhcp22.suse.cz>
 <20210325210159.r565fvfitoqeuykp@ava.usersys.com>
 <YF2YTNnyzWNHfrEg@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YF2YTNnyzWNHfrEg@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Fri 2021-03-26 09:16 +0100, Michal Hocko wrote:
> The oom killer is never triggered for costly allocation request.

Yes - I agree. Looking at __alloc_pages_may_oom() I can see for a costly
order allocation request the OOM killer is explicitly not used.
If I understand correctly, the patch I proposed was for the following
scenarios:

  1.    The costly order allocation request to fail when
        "some" progress is made (i.e. order-0) and the last
        compaction request was "skipped"

  2.    A non-costly order allocation request that is
        unable to make any progress and failed over the
        maximum reclaim retry count in a row and the last
        known compaction result was skipped to consider
        using the OOM killer for assistance

> Both reclaim and compaction maintain their own retries counters as they
> are targeting a different operation. Although the compaction really
> depends on the reclaim to do some progress.

Yes. Looking at should_compact_retry() if the last known compaction result
was skipped i.e. suggesting there was not enough order-0 pages to support
compaction, so assistance is needed from reclaim
(see __compaction_suitable()).

I noticed that the value of compaction_retries, compact_result and
compact_priority was 0, COMPACT_SKIPPED and 1 i.e. COMPACT_PRIO_SYNC_LIGHT,
respectively.

> OK, this sound unexpected as it indicates that the reclaim is able to
> make a forward progress but compaction doesn't want to give up and keeps
> retrying. Are you able to reproduce this or could you find out which
> specific condition keeps compaction retrying? I would expect that it is
> one of the 3 conditions before the max_retries is checked.

Unfortunately, I have been told it is not entirely reproducible.
I suspect it is the following in should_compact_retry() - as I indicated
above the last known value stored in compaction_retries was 0:


        if (order > PAGE_ALLOC_COSTLY_ORDER)
                max_retries /= 4;
        if (*compaction_retries <= max_retries) {
                ret = true;
                goto out;
        }




Kind regards,

-- 
Aaron Tomlin

