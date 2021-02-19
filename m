Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA0731F6AA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 10:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhBSJnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 04:43:31 -0500
Received: from smtp-42ad.mail.infomaniak.ch ([84.16.66.173]:50767 "EHLO
        smtp-42ad.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229546AbhBSJn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 04:43:28 -0500
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Dhmp77220zMqZdF;
        Fri, 19 Feb 2021 10:42:39 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Dhmp7189Tzlh8T7;
        Fri, 19 Feb 2021 10:42:39 +0100 (CET)
Subject: Re: [PATCH 17/18] certs: Fix blacklist flag type confusion
To:     David Howells <dhowells@redhat.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ca631011-08c2-d44d-cce9-436a6a08405f@digikod.net>
 <160751619550.1238376.2380930476046994051.stgit@warthog.procyon.org.uk>
 <160751606428.1238376.14935502103503420781.stgit@warthog.procyon.org.uk>
 <2031808.1613665474@warthog.procyon.org.uk>
 <2106667.1613688936@warthog.procyon.org.uk>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <394233f3-6298-f719-4e1e-c2964841a653@digikod.net>
Date:   Fri, 19 Feb 2021 10:43:42 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <2106667.1613688936@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/02/2021 23:55, David Howells wrote:
> Mickaël Salaün <mic@digikod.net> wrote:
> 
>>> Can I transfer your acks from:
>>>
>>> 	https://lore.kernel.org/lkml/20210121155513.539519-5-mic@digikod.net/
>>>
>>> to here?
>>
>> No, the current thread contains an old version with an error in the
>> patch for ima_mok_init(). Please take the last series (fixing this
>> patch) that I rebased on your next branch:
>> https://lore.kernel.org/keyrings/20210210120410.471693-1-mic@digikod.net/
> 
> Is there a quick fix for the error?  If I replace your patches I'll probably
> have to withdraw my pull request for this cycle.

I think you just replied to the wrong thread. You have the correct
commit(s) in your tree here:
-
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=keys-fixes&id=a03da41508b177da59780d759af16207a00686bb
-
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=keys-next&id=4993e1f9479a4161fd7d93e2b8b30b438f00cb0f
-
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=keys-misc&id=508f44ffefbf879fbb82fdbc8bf1e6023b85158a

For all of these you can add my Reviewed-by or Acked-by.

Thanks!

> 
> David
> 
