Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E263A7D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhFOLx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57483 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229557AbhFOLxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623757911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BF7n2UuNgLsoB3IPYKLpL2scAhDvByYXMdJbqiB7sPM=;
        b=OFXesDDnFpcc+SW8FukOZ5yn+FdPJI9s3n8otd3sMc7Yc8/cn3uVnmAZYcVKqarObIYZFx
        uiq5AVyJTdtP90f3GREmunM3kIAc8ChYxBW1z/wFRX27DB9YFJGoC7ht3D4ucKKqL+DpQu
        t89nr9/tJ6fzyzxLIk/A0/QHUEiIXuo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-EHhw5em0NTa41gGG0bGJnA-1; Tue, 15 Jun 2021 07:51:49 -0400
X-MC-Unique: EHhw5em0NTa41gGG0bGJnA-1
Received: by mail-wr1-f70.google.com with SMTP id x9-20020a5d49090000b0290118d8746e06so8530583wrq.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BF7n2UuNgLsoB3IPYKLpL2scAhDvByYXMdJbqiB7sPM=;
        b=JWCJGCwfchRXzGavxlz8bS5yIwQz5Dh0qVPXSVmkxc8m+gfOLZkb2h4PE6VaF+JkHH
         zk7G5RUIOAWzuU9jQ28VdjtlIzGf0UIgGFdkgZXqKb3bf0AMj8jFv1rBD85YPf2QLEaS
         QY3VrUbW1xb+ELy2/88ZtnwYsw0Q9RTGzAYi9g59WzsxVBxJcf7pajv2bbXiP0uhRoh6
         aQD5z5YH66LNlxN25jWmJIptnJLe7Dx3CxaIgFc5ko54OcXn9ncYRkgO4lAA6MOwB1Wu
         Ykkn3wXU7MlQ/cKqCZCmiwHXaJhQVMC8py6uUNbRvaP7lduJCWyrx/LAXiJ1tlTxgdnW
         87cQ==
X-Gm-Message-State: AOAM533GL54VR0ielVCOwTRwi7yxqHUUY3CgR9jeZxdaLPTXty9Vy0T+
        VilLEEmll5nIY8iuZQvMa/aHdLkBHOgLnN1AnP76VXdUeS6S1ydfqdIslLnCgQ/6LEg/WMGNKzP
        myNSQHT4NHdYrn0juzONIBA8=
X-Received: by 2002:a5d:528d:: with SMTP id c13mr24933430wrv.343.1623757908660;
        Tue, 15 Jun 2021 04:51:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfrXdXPcUnrA3LY/bXhSZrn+yM5Dpd1VpfejXuXn6BQ50zJcqr17XLR/nC4m+K03sHwlFpPQ==
X-Received: by 2002:a5d:528d:: with SMTP id c13mr24933416wrv.343.1623757908490;
        Tue, 15 Jun 2021 04:51:48 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id w8sm19698515wre.70.2021.06.15.04.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 04:51:48 -0700 (PDT)
Date:   Tue, 15 Jun 2021 12:51:47 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        penguin-kernel@i-love.sakura.ne.jp, llong@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/oom_kill: show oom eligibility when displaying the
 current memory state of all tasks
Message-ID: <20210615115147.gp3w5bcjoaarvyse@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20210612204634.1102472-1-atomlin@redhat.com>
 <YMb6w/bGdhJvOy6j@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YMb6w/bGdhJvOy6j@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-06-14 08:44 +0200, Michal Hocko wrote:
> Well, I have to say that I have a bit hard time understand the problem
> statement here. First of all you are very likely basing your observation
> on an old kernel which is missing a fix which should make the situation
> impossible IIRC. You should be focusing on a justification why the new
> information is helpful for the current tree.

Michal,

Not exactly.

See oom_reap_task(). Let's assume an OOM event occurred within the context
of a memcg and 'memory.oom.group' was not set. If I understand correctly,
once all attempts to OOM reap the specified task were "unsuccessful" then
MMF_OOM_SKIP is applied; and, the assumption is it will be terminated
shorty due to the pending fatal signal (see __oom_kill_process()) i.e. a
SIGKILL is sent to the "victim" before the OOM reaper is notified. Now
assuming the above task did not exited yet, another task, in the same
memcg, could also trigger an OOM event.  Therefore, when showing potential
OOM victims the task above with MMF_OOM_SKIP set, will indeed be displayed.

I understanding the point on OOM_SCORE_ADJ_MIN. This can be easily
identified and is clear to the viewer. However, the same cannot be stated
for MMF_OOM_SKIP.

So, if we prefer to display rather than exclude such tasks, in my opinion
having a flag/or marker of some description might prove useful to avoid any
misunderstanding.

> This should provide an example of the output with a clarification of the
> meaning.

Fair enough.




Kind regards,

-- 
Aaron Tomlin

