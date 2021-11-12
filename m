Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FB544E470
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 11:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbhKLKSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 05:18:44 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35258 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbhKLKSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 05:18:43 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 51409218B8;
        Fri, 12 Nov 2021 10:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636712152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=64DGNgNkV9O62ggKgIwdNVIPe762Yddi4NRbefxXFbg=;
        b=ZHEaa/iBgPCpEIxTmAJlxtFwIfeoSEv8YhOtFYT2/ymMrhOO0ON66hH4tzJwIR4zp1jfbB
        bDnfAdhhGQRu6fkv+i1UA2aMeWHJuID0LNHD8wVlpNE5FarxIq2NYGi/LL/Zaqr3c1gdrL
        UuV9OwIuvqVgVaTrCNnTv+rVtmpwW2E=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CCD2AA3B8D;
        Fri, 12 Nov 2021 10:15:51 +0000 (UTC)
Date:   Fri, 12 Nov 2021 11:15:51 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, thuth@redhat.com,
        frankja@linux.ibm.com, borntraeger@de.ibm.com,
        Ulrich.Weigand@de.ibm.com, heiko.carstens@de.ibm.com,
        david@redhat.com, ultrachin@163.com, akpm@linux-foundation.org,
        vbabka@suse.cz, brookxu.cn@gmail.com, xiaoggchen@tencent.com,
        linuszeng@tencent.com, yihuilu@tencent.com,
        daniel.m.jordan@oracle.com, axboe@kernel.dk, legion@kernel.org,
        peterz@infradead.org, aarcange@redhat.com, christian@brauner.io,
        ebiederm@xmission.com, tglx@linutronix.de
Subject: Re: [RFC v1 0/4] Two alternatives for mm async teardown
Message-ID: <YY4+1y4+B7s7beJ2@dhcp22.suse.cz>
References: <20211111095008.264412-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111095008.264412-1-imbrenda@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-11-21 10:50:03, Claudio Imbrenda wrote:
> This RFC series proposes two possible ways for enabling asynchronous mm
> teardown.

It would be great to describe an intended usecase here and also explain
why the existing features do not allow the required functionality.

Please also make sure to cc linux-api when adding a new user visible
interface or changing a visible behavior of existing one.

E.g. why cannot you simply create a process outside of the thread group
yet share the mm with your task. Once the other process exits which you
can detect then you just exit that process and do the finall clean up
from that context?

> The first approach, in patch 1, is simply to provide an arch hook in
> exit_mm. This has no functional change for archs that don't explicitly
> use the hook, and leaves the hard part to arch code (including
> accounting, if any).

This is just too vague but I have to say I am not really a fan of hooks
that considerably change the existing behavior.

> The second approach, in patches 2 to 4, adds a new syscall to allow an
> mm to be asynchronously torn down in the context of another process
> (similarly to how process_mrelease works). It also adds an OOM notifier
> to prevent the OOM killer from killing processes while the teardown is
> in progress.

I have to say I do not like oom notifier part at all. You can have
different sources of the OOM (memcg, cpusets or global oom). It is
impossible to tell those appart in the notifier. Not to mention that
memcg oom is explicitly avoiding notifiers altogether.

-- 
Michal Hocko
SUSE Labs
