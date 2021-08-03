Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A103E3DE6F7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 09:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbhHCHGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 03:06:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60686 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbhHCHGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 03:06:11 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C47C921DEB;
        Tue,  3 Aug 2021 07:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627974359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HXoSXB6BHd2s7Z7Nu01Vf6RqwUphqbW5sKmtUSQV2Do=;
        b=Ja/yJ8npNDs0v7SpPu7OzzCUszBh7T903Yyt+8EqKv2o/z7b/4+PO7UOISQrhGJ/wRo+x4
        cXXEPU0ICaeucRezdCMumTcsDLF67mJrJCDIbCweya7oUFl7/dKlO7iUeqDyYAbD1el64m
        eIZFOY7UaGmvcIyXV2XXlOkM+tX5ZRk=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 68A84A3BCB;
        Tue,  3 Aug 2021 07:05:59 +0000 (UTC)
Date:   Tue, 3 Aug 2021 09:05:58 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        penguin-kernel@i-love.sakura.ne.jp, rientjes@google.com,
        llong@redhat.com, neelx@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/oom_kill: show oom eligibility when displaying the
 current memory state of all tasks
Message-ID: <YQjq1mXDXcS1CMMO@dhcp22.suse.cz>
References: <20210730162002.279678-1-atomlin@redhat.com>
 <YQeR8FTlzrojIbSo@dhcp22.suse.cz>
 <20210802151250.lqn5fu5pioygsry6@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802151250.lqn5fu5pioygsry6@ava.usersys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02-08-21 16:12:50, Aaron Tomlin wrote:
> On Mon 2021-08-02 08:34 +0200, Michal Hocko wrote:
> > If you really want/need to make any change here then I would propose to
> > either add E(eligible)/I(ligible) column without any specifics or
> > consistently skip over all tasks which are not eligible.
> 
> How about the suggestion made by David i.e. exposing the value returned by
> oom_badness(), as if I understand correctly, this would provide a more
> complete picture with regard to the rationale used?

There were some attempts to print oom_score during OOM. E.g.
http://lkml.kernel.org/r/20190808183247.28206-1-echron@arista.com. That
one was rejected on the grounds that the number on its own doesn't
really present any real value. It is really only valuable when comparing
to other potential oom victims. I have to say I am still worried about
printing this internal scoring as it should have really been an
implementation detail but with /proc/<pid>/oom_score this is likely a
lost battle and I am willing to give up on that front.

I am still not entirely convinced this is worth doing though.
oom_badness is not a cheap operation. task_lock has to be taken again
during dump_tasks for each task so the already quite expensive operation
will be more so. Is this really something we cannot live without?
-- 
Michal Hocko
SUSE Labs
