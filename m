Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78754502BB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbhKOKrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 05:47:01 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45310 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237639AbhKOKqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:46:55 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3FBF91FD65;
        Mon, 15 Nov 2021 10:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636973039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=833FoBJroEwcf8aYlUSW0H0gnUbGPYrGy9snOMHf4J8=;
        b=fPpzRQr+zYuM8VmbNGhoOhu7lL01rGVkgWJH/kp8xewBxwsOinG+OEFiKiU9p9qhsCxaGe
        Uw5uNYTSEL0vgzoJKmA6IE358CPonxsdvj27ho6rCSjkrPZhk56FKZpYm3BoI9cSHGtY8D
        IMZdj59SHXmFkuufqOvj82KeAoEPRDc=
Received: from suse.cz (mhocko.udp.ovpn2.prg.suse.de [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 588C6A3B83;
        Mon, 15 Nov 2021 10:43:58 +0000 (UTC)
Date:   Mon, 15 Nov 2021 11:43:57 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, thuth@redhat.com,
        frankja@linux.ibm.com, borntraeger@de.ibm.com,
        Ulrich.Weigand@de.ibm.com, david@redhat.com, ultrachin@163.com,
        akpm@linux-foundation.org, vbabka@suse.cz, brookxu.cn@gmail.com,
        xiaoggchen@tencent.com, linuszeng@tencent.com, yihuilu@tencent.com,
        daniel.m.jordan@oracle.com, axboe@kernel.dk, legion@kernel.org,
        peterz@infradead.org, aarcange@redhat.com, christian@brauner.io,
        tglx@linutronix.de
Subject: Re: [RFC v1 2/4] kernel/fork.c: implement new process_mmput_async
 syscall
Message-ID: <YZI57bFLvBptKkYj@dhcp22.suse.cz>
References: <20211111095008.264412-1-imbrenda@linux.ibm.com>
 <20211111095008.264412-4-imbrenda@linux.ibm.com>
 <874k8ixzx0.fsf@email.froward.int.ebiederm.org>
 <20211112103439.441b4c12@p-imbrenda>
 <87v90xv2uu.fsf@email.froward.int.ebiederm.org>
 <20211112175309.7e0fe52a@p-imbrenda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112175309.7e0fe52a@p-imbrenda>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 12-11-21 17:53:09, Claudio Imbrenda wrote:
[...]
> Of course, but this also means that it's not possible to stop the OOM
> killer while the teardown is in progress,

Blocking the OOM killer and depend on the userspace to make a forward
progress is not acceptable solution.
-- 
Michal Hocko
SUSE Labs
