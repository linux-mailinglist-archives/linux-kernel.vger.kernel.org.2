Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B6839E8FE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 23:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhFGVTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 17:19:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30600 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230359AbhFGVTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 17:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623100670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dohUA8RCeDZydOVy8aFiF2oJKRXDAPHwnSuvVV684WU=;
        b=X/XCRRi0EbADjCdbJsqqU8e8GotIUZXzh6osmcHPsLXS2E5ubmV78mRl8vgXCl7CVkSCme
        3JX++ANo16kbeSJABa51TSUFSE7U4hjmiRdy/XeW/lE2UdtVhIOcVh/qgyNdJaBeCIWAEY
        aJVXiJ5/zXOUuCmQ22XAIpRbdU31oTY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-HGrk-L_FPHafEY03u4hgbw-1; Mon, 07 Jun 2021 17:17:49 -0400
X-MC-Unique: HGrk-L_FPHafEY03u4hgbw-1
Received: by mail-wr1-f70.google.com with SMTP id x9-20020a5d49090000b0290118d8746e06so8396341wrq.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 14:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dohUA8RCeDZydOVy8aFiF2oJKRXDAPHwnSuvVV684WU=;
        b=d/fcHl2zfmtfQdXNWGywSR9z/uYy1GOqcoaTn/Xkvw4Dv2w6sgKma7pDlZXaKeUBIa
         Pgg6r4VduWzgj3R9t9J6i8UeAw8Y7aHbJWpa4Hp7Nt9FdvZU4LknfLXafXt1A9DK+uZR
         CSbMNiUiVcG9Gylwxed9qqeQmU/xHFnci5FGA4D6hIMP1ND9iiY0H8BVfQKFAP0IQ2Iu
         sfRZDjA4TrK08GayCTQO+8GbsWf3StYDLWX0xoTWh6I9dNFI5bNDC4b9SzVZXDftUjTB
         sm6BRUJY4T2qxJPEr5QfqnfcYdwNUdBEgtayt0e3EC1jXaSFiULNR6tllB1ed1+tCMmH
         uyig==
X-Gm-Message-State: AOAM530A2punPKFbKCTC8IdAZTPjVNkmczZG5ntLP67WHxb3glKi3Jhn
        CjSfhblM0nCCh8qnjdnl1VzJkHK5QeZrX7Ybj8mjAaoPWnaKn9ZjQgZWEUMxzwHP6wnAEj69L01
        YVEsxPdA5mnqX/JS9RaZohL0=
X-Received: by 2002:adf:a503:: with SMTP id i3mr19151878wrb.334.1623100668297;
        Mon, 07 Jun 2021 14:17:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOM1m3XdKCQPa4Wc1inRlTNUQJkAuNUqBejh8q9mDu7ZlYc/bUjJLCXAAeRgOv6JzSm2lmyA==
X-Received: by 2002:adf:a503:: with SMTP id i3mr19151872wrb.334.1623100668129;
        Mon, 07 Jun 2021 14:17:48 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id m23sm16133510wmc.29.2021.06.07.14.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 14:17:47 -0700 (PDT)
Date:   Mon, 7 Jun 2021 22:17:47 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        llong@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/oom_kill: allow oom kill allocating task for
 non-global case
Message-ID: <20210607211747.raco7udwu4dbut3i@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20210607163103.632681-1-atomlin@redhat.com>
 <YL5tBQ3utMzUkHF3@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YL5tBQ3utMzUkHF3@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-06-07 21:01 +0200, Michal Hocko wrote:
> On Mon 07-06-21 17:31:03, Aaron Tomlin wrote:
> This is a global oom policy not a memcg specific one so a historical
> behavior would change. So I do not think we can change that.

I see. Fair enough.


-- 
Aaron Tomlin

