Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F25310B16
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 13:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhBEMbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 07:31:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:39796 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232113AbhBEM1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:27:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612528010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vYOlJfz4MRDQGmCqhAtQi7wi5oI/P8Mw1UvNqrHm8E0=;
        b=gCgDjCyxpmReMfSVikQlsXK9p/ptvbWTTpp5h/Inwu6i5zPsIu0LyvvKvQSPmG+taOFdkC
        cSG4ai313F9G5rEys0ZeZCVUQQm7T1fqCJMgfxwozJLvpZqDDtWEn/5WChundIbLbamMY7
        M5EeXa2PyTjLU1F5L1nvQL2cHlh0uaM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 77411ACBA;
        Fri,  5 Feb 2021 12:26:50 +0000 (UTC)
Date:   Fri, 5 Feb 2021 13:26:49 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Possible deny of service with memfd_create()
Message-ID: <YB05iR9fkaDDll9Y@dhcp22.suse.cz>
References: <e7e6231d-8cf9-80a6-7459-5fec9ee547ba@amd.com>
 <YBwrGNS+Q4JMpuom@dhcp22.suse.cz>
 <alpine.LSU.2.11.2102041627040.2796@eggly.anvils>
 <762ad377-ac21-6d8d-d792-492ba7f6c000@amd.com>
 <YB0i3a6fIhWG7zCP@dhcp22.suse.cz>
 <3597e38e-ace7-104c-dcc8-59471e11dcfe@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3597e38e-ace7-104c-dcc8-59471e11dcfe@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 05-02-21 11:57:09, Christian König wrote:
> Am 05.02.21 um 11:50 schrieb Michal Hocko:
> > On Fri 05-02-21 08:54:31, Christian König wrote:
> > > Am 05.02.21 um 01:32 schrieb Hugh Dickins:
> > > > On Thu, 4 Feb 2021, Michal Hocko wrote:
[...]
> > > > > The only existing protection right now is to use memoery cgroup
> > > > > controller because the tmpfs memory is accounted to the process which
> > > > > faults the memory in (or write to the file).
> > > Agreed, but having to rely on cgroup is not really satisfying when you have
> > > to maintain a hardened server.
> > Yes I do recognize the pain. The only other way to mitigate the risk is
> > to disallow the syscall to untrusted users in a hardened environment.
> > You should be very strict in tmpfs usage there already.
> > 
> 
> Well it is perfectly valid for a process to use as much memory as it wants,
> the problem is that we are not holding the process accountable for it.
> 
> As I said we have similar problems with GPU drivers and I think we just need
> a way to do this.
> 
> Let me think about it a bit, maybe we can somehow use the file owner for
> this.

There are some land mines on the way to watch for. The most obvious one
would be to not double account populated file with its mapping. Those
two might live in separate processes. So you would need a rmap walk just
to evaluate oom_badness. Also you need to consider files which are not
open anymore or they have been passed through to another process. And
then the question is what to do about them. Killing their owner doesn't
help anything because the file is still left behind.  I do expect you
will learn more problems on the way but I definitely do not want to
discourage you from this endeavor.
-- 
Michal Hocko
SUSE Labs
