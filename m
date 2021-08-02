Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D643DDC0E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbhHBPNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:13:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45929 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234870AbhHBPND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627917174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FlQM01HNtSla1rT64ZaWW6Fmv7bpSqm5nw3CEk/DlHw=;
        b=h/DZQPVsDZTSdIGrSj6m0G27LMSHabo+WuW7xhuKV98DIgKiwRJkcoq1OQGcdw0jEsoWLa
        IF8bouUbrlP45KJoZJL0bBmSP0ykZR2vZKvRptwtmUuRtD7aZIT8sPfxzjvbvgIo4kC+eK
        B29HOb1MV5ILWPZrhkUMDoX2qLR3YQY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-gWlFCY3qOMGP5JyxdurC9g-1; Mon, 02 Aug 2021 11:12:52 -0400
X-MC-Unique: gWlFCY3qOMGP5JyxdurC9g-1
Received: by mail-wm1-f71.google.com with SMTP id g187-20020a1c20c40000b02902458d430db6so2978599wmg.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 08:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FlQM01HNtSla1rT64ZaWW6Fmv7bpSqm5nw3CEk/DlHw=;
        b=ZK8A0c2XjtwYw6c3i8TLon+Q3Ocy6C4+byWSL/mR4Hp/er0zq4VE3PcuG+9h5PpLrM
         jRpi7mOHvaKIGyX6Tg2CzXr9tpJ77N3rAX2fl2dzvxr73MfGWzTp9KE0JsPUxA7eS0Dm
         OFOI87Gnf5889f+ZqH+dWjRwnCef6xOnWT2UXizAITkGRAw9bhB4tRAjzLfLncsIzmK9
         +dZmwgXXrqWcHExsRvxCSR2lPWAO7AUlamB+izg5WNXuYlNsqKNbZ5mIrqKb7+JZ1eYV
         ikOBVk6MMj111BYcMlVUgp7tXwtlAYmfO5vtkm1KLLPJcKrcDbvfIwBiHCDjMg3Ql9hF
         vj3g==
X-Gm-Message-State: AOAM533yuB3BP/O2NvwZtxPMgbDnUlEu8JSXFqEHeHBebaARnb8z9c8F
        4Y6JU9UyYj6Te/s+U2xX2eyoJICYTIcwzeHJoZSonLLOsBAvw1WP9M2WyUx6L17UKjj3V6WDdD4
        cJ39dy4JP1Nt5cDpKXHj5Y8w=
X-Received: by 2002:adf:9d88:: with SMTP id p8mr18813265wre.409.1627917171761;
        Mon, 02 Aug 2021 08:12:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxER3KiFPE1LkWXXA8ZvTD5NMlwB/glpb57kT+jyibKqXepxR3M+pdxJqdmDMjGMOojTxDKGw==
X-Received: by 2002:adf:9d88:: with SMTP id p8mr18813247wre.409.1627917171555;
        Mon, 02 Aug 2021 08:12:51 -0700 (PDT)
Received: from localhost (79-67-181-135.dynamic.dsl.as9105.com. [79.67.181.135])
        by smtp.gmail.com with ESMTPSA id j14sm11695291wru.58.2021.08.02.08.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 08:12:50 -0700 (PDT)
Date:   Mon, 2 Aug 2021 16:12:50 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        penguin-kernel@i-love.sakura.ne.jp, rientjes@google.com,
        llong@redhat.com, neelx@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/oom_kill: show oom eligibility when displaying the
 current memory state of all tasks
Message-ID: <20210802151250.lqn5fu5pioygsry6@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20210730162002.279678-1-atomlin@redhat.com>
 <YQeR8FTlzrojIbSo@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQeR8FTlzrojIbSo@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-08-02 08:34 +0200, Michal Hocko wrote:
> If you really want/need to make any change here then I would propose to
> either add E(eligible)/I(ligible) column without any specifics or
> consistently skip over all tasks which are not eligible.

How about the suggestion made by David i.e. exposing the value returned by
oom_badness(), as if I understand correctly, this would provide a more
complete picture with regard to the rationale used?


Kind regards,

-- 
Aaron Tomlin

