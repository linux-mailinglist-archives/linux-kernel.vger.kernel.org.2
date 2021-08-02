Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526983DDB82
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhHBOu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:50:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52050 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233925AbhHBOuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627915845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JKF801/nYauGcMfbC5O3GsLvI6SfQQJO7GZapt9n7eY=;
        b=QIpI0I7pELdYy7g3/w+bu/jMSfRcQZms6NdHU2uRxhVmPJ0fkVMUWXqig98su2baVDzsRV
        ri3W56Ge96+bjo02B/7EB7Zh6TdLRa66pROMyQUAZbnt8d2rFQ58nDwHBnL2pmdHMyPsgO
        JweGgBojVSEyt7pLIiEhh85SLEpLqiI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-Tsh70T_pPyOJvdX1u5r7jQ-1; Mon, 02 Aug 2021 10:50:43 -0400
X-MC-Unique: Tsh70T_pPyOJvdX1u5r7jQ-1
Received: by mail-wm1-f69.google.com with SMTP id u14-20020a7bcb0e0000b0290248831d46e4so55307wmj.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 07:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JKF801/nYauGcMfbC5O3GsLvI6SfQQJO7GZapt9n7eY=;
        b=AI4ooY550qnaq+Mibs12538NCpJ2ocwweciFJ+qDUNtgPogLgTph63gYNa2ZbBveHy
         4QxUIFZqkCejxqYSPDbgU2bx2+Nv/+l7f984IyVxi9+MQF6y8He2eoGxwS9x23QjRXOD
         ait7VttMTpBDa8Dpaz2hwrzV0QVmmDXxGH0I0V+DxPREqomZdxg7ebZAK70+Y0J9nS9O
         w9S7G8iLXJCzR7J/RwowQlfeOmkk2hN+dRoWCofj0J92BY1Su7+C4GURuC4QTOAYLIYl
         Iuk4QuiGO8zDdn/36vgAtYqRcpXItZ37PJxlP1rohiUwPFd114b2379F+4qeyA2CjD6K
         Q4Rg==
X-Gm-Message-State: AOAM532Qn4Ct6mODSlPuA8wkCNFG8zSh25/+ZxY59ZL5i++qhJA2UuxJ
        qt1o+U/r8ZzvOKSEj3ZtaG7qYpLEdbtFdoIKHJ+easFaiSu86yZgkpfzPQubiW2EUOR2L7zRGC6
        O/cONaGoeMnncRjcNnm5chVQ=
X-Received: by 2002:a1c:4e12:: with SMTP id g18mr11555793wmh.165.1627915842820;
        Mon, 02 Aug 2021 07:50:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRe8WKPg8hxQ6J9MYGdy56w2042hvGMFgaYmv5rKPDB1BXU0ynn2eaovw/RaGbFMLSeZIZQg==
X-Received: by 2002:a1c:4e12:: with SMTP id g18mr11555780wmh.165.1627915842678;
        Mon, 02 Aug 2021 07:50:42 -0700 (PDT)
Received: from localhost (79-67-181-135.dynamic.dsl.as9105.com. [79.67.181.135])
        by smtp.gmail.com with ESMTPSA id q64sm6982845wma.8.2021.08.02.07.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 07:50:42 -0700 (PDT)
Date:   Mon, 2 Aug 2021 15:50:41 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     David Rientjes <rientjes@google.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
        penguin-kernel@i-love.sakura.ne.jp, llong@redhat.com,
        neelx@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/oom_kill: show oom eligibility when displaying the
 current memory state of all tasks
Message-ID: <20210802145041.w7lqdt77qguwbwag@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20210730162002.279678-1-atomlin@redhat.com>
 <fa6e3682-abae-f656-fec4-178a608face5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa6e3682-abae-f656-fec4-178a608face5@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2021-08-01 20:49 -0700, David Rientjes wrote:
> oom_score_adj is shown already in the tasklist dump, I'm not sure what 
> value this adds.

Fair enough.

> 
> > +	else if (test_bit(MMF_OOM_SKIP, &p->mm->flags)
> > +		return "R";
> > +	else if (in_vfork(p))
> > +		return "V";
> 
> This is going to be racy, we can't show that a task that is emitted as 
> part of the tasklist dump was did not have in_vfork() == true at the time 
> oom_badness() was called.

Yes, this is true.

> Wouldn't it be better to simply print the output of oom_badness() to the 
> tasklist dump instead so we get complete information?

I think this would be acceptable.

> We could simply special case a LONG_MIN return value as -1000 or "min".

Agreed.





Kind regards,

-- 
Aaron Tomlin

