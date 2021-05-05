Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A65E3746A3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 19:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240960AbhEERWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 13:22:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:56280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239001AbhEERKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 13:10:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 099E9AF3D;
        Wed,  5 May 2021 17:09:26 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 05 May 2021 10:09:25 -0700
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
In-Reply-To: <a6c7f3e5cfaf16e7912f350a93f7c69e@suse.de>
References: <20210504155534.17270-1-varad.gautam@suse.com>
 <4959eb8d8c14b00113370ae86dc7c9f5@suse.de>
 <fe1b29a0-af09-e270-de52-09bacac35d86@suse.com>
 <6fbcb0fa502e7574f87213fc29877ed8@suse.de>
 <5abf8348-b1fc-fecb-d130-6d45b84ee081@suse.com>
 <a6c7f3e5cfaf16e7912f350a93f7c69e@suse.de>
User-Agent: Roundcube Webmail
Message-ID: <0b1da1311f1d9f60ae3cf3f037c2bfe3@suse.de>
X-Sender: dbueso@suse.de
Organization: SUSE Labs
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-05 09:24, Davidlohr Bueso wrote:
> On 2021-05-05 08:36, Varad Gautam wrote:
>> If you're still unconvinced, I'll send out a v2 w/ wake_q_add called 
>> before
>> smp_store_release.
> 
> Yeah, please send a v2, I believe this is the right way to fix the 
> issue.

Also, it would be good to add:

Cc: <stable@vger.kernel.org> # 5.6

Thanks,
Davidlohr
