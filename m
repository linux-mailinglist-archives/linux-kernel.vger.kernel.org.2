Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2D83DB4EE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 10:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbhG3IMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 04:12:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52554 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhG3IMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 04:12:44 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 02DFC1FDB8;
        Fri, 30 Jul 2021 08:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627632759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+339LBJ9PxJVX12IlhGrAQaGOlRtRXO0GLukTqdTFyE=;
        b=slCzJsYdkeU2B359I5tZk58MMBfUptrkBeH04UaINMgtWdaQS4Iz4HWILCW1xATEL5UdwB
        qrMS4Arl8a37FjSC9/OCeHNwSZUVXonXS3+yw5SJSOPaaPUuT0mCfrizxU29n9VzOoiskO
        Eh+tj0PMPllM5ib6kZjTXKWsl/z4OCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627632759;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+339LBJ9PxJVX12IlhGrAQaGOlRtRXO0GLukTqdTFyE=;
        b=+LpZlHaPyhTPNxAiz9rHxmFyTQgpsDc5hA/NMDa+aO73ZmMJInqdYSEnQ302ZBU3mLSSGz
        DeimzStQ1LTtgkAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D9E02134AE;
        Fri, 30 Jul 2021 08:12:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id XbdrNHa0A2FODQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Fri, 30 Jul 2021 08:12:38 +0000
Subject: Re: [PATCH 3/3] mm: mmap_lock: add ip to mmap_lock tracepoints
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Gang Li <ligang.bdlg@bytedance.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
References: <20210729092853.38242-1-ligang.bdlg@bytedance.com>
 <CAJHvVcjBH+Vry8v5T0FWyFWWDY6_AqSxZcVQxXRm=LR8v=ML-Q@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <34dcbcac-7794-c067-3d71-7a1404c41b6c@suse.cz>
Date:   Fri, 30 Jul 2021 10:12:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAJHvVcjBH+Vry8v5T0FWyFWWDY6_AqSxZcVQxXRm=LR8v=ML-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/21 7:33 PM, Axel Rasmussen wrote:
> Not a strong objection, but I think this can be achieved already using either:
> 
> - The "stacktrace" feature which histogram triggers support
> (https://www.kernel.org/doc/html/latest/trace/histogram.html)
> - bpftrace's kstack/ustack feature
> (https://github.com/iovisor/bpftrace/blob/master/docs/tutorial_one_liners.md#lesson-9-profile-on-cpu-kernel-stacks)
> 
> I haven't tried it out myself, but I suspect you could construct a
> synthetic event
> (https://www.kernel.org/doc/html/latest/trace/histogram.html#synthetic-events)
> which adds in the stack trace, then it ought to function a lot like it
> would with this patch.
> 
> Then again, it's not like this change is huge by any means. So, if you
> find this more convenient than those alternatives, you can take:
> 
> Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
> 
> It's possible Steven or Tom have a more strong opinion on this though. ;)

I generally dislike tracepoints with an ip. Often you then find out it's not
enough to distinguish what you need (due to some commonly shared wrapper doing
the call) and you need more of the backtrace anyway.
