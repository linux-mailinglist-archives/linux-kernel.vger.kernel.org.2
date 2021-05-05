Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BD4373E33
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 17:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhEEPMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 11:12:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:36406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233085AbhEEPMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 11:12:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1C1DEB29F;
        Wed,  5 May 2021 15:11:57 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 05 May 2021 08:11:56 -0700
From:   Davidlohr Bueso <dbueso@suse.de>
To:     Varad Gautam <varad.gautam@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Matthias von Faber <matthias.vonfaber@aox-tech.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ipc/mqueue: Avoid relying on a stack reference past its
 expiry
In-Reply-To: <fe1b29a0-af09-e270-de52-09bacac35d86@suse.com>
References: <20210504155534.17270-1-varad.gautam@suse.com>
 <4959eb8d8c14b00113370ae86dc7c9f5@suse.de>
 <fe1b29a0-af09-e270-de52-09bacac35d86@suse.com>
User-Agent: Roundcube Webmail
Message-ID: <6fbcb0fa502e7574f87213fc29877ed8@suse.de>
X-Sender: dbueso@suse.de
Organization: SUSE Labs
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-05 00:49, Varad Gautam wrote:
> The race here really is about the lifetime of __pipelined_op's `this`
> argument only
> being guaranteed for some duration of the call (ie, until someone sets
> ->state = STATE_READY). It is not about when wake_q addition happens,
> as long as it is
> being fed a valid task_struct.

Again, it's all about ensuring that the READY_STATE is set last, the 
blocked
task has no business returning in the first place, making both races 
(exit and
the one reported here) similar by ending up using bogus memory.

...

> I considered that initially, but given that the race isn't connected
> with wakeup, I
> preferred the current approach which makes this fact explicit by 
> showing what's
> valid/invalid during __pipelined_op.

I understand your point, but this is why I updated the ordering 
comments. Furthermore
there is no reason to decouple the task's refcount with the wake_q_add 
operation, it
just makes the code weird and harder to follow.

Thanks,
Davidlohr
