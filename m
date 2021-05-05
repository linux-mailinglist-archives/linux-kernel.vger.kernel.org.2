Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BF7373694
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 10:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhEEIr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 04:47:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32319 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231430AbhEEIry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 04:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620204417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6w0Bb3Czs0gInUDdwXdHMW1FO2dptIM9rJNDSEArh34=;
        b=Hyskt2HXDzf9mJ4C7lrysiO3AWyuT1NIm3DM0AgheSFZVi2tddkUZsZOCculGfmC8Mqv6l
        4UPK2YswgbKUbhjkq3mraTiY+99+EscEWx2T8HThf4n/6HBmdYKSEINXDbnzDEY/tz+80l
        jF1hHxw2qQJjG3cfgQQVFsHLv049vwk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-gvhEjeE1NAaPGBU99XZX9g-1; Wed, 05 May 2021 04:46:54 -0400
X-MC-Unique: gvhEjeE1NAaPGBU99XZX9g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DE378049CB;
        Wed,  5 May 2021 08:46:53 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-112-137.ams2.redhat.com [10.36.112.137])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FE045B4A6;
        Wed,  5 May 2021 08:46:51 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <andi@firstfloor.org>,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH] sched: Work around undefined behavior in sched class
 checking
References: <20210505033945.1282851-1-ak@linux.intel.com>
        <YJI/OwoflyY2IXvf@hirez.programming.kicks-ass.net>
Date:   Wed, 05 May 2021 10:47:07 +0200
In-Reply-To: <YJI/OwoflyY2IXvf@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Wed, 5 May 2021 08:46:19 +0200")
Message-ID: <875yzxh8j8.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra:

> On Tue, May 04, 2021 at 08:39:45PM -0700, Andi Kleen wrote:
>> From: Andi Kleen <andi@firstfloor.org>
>> 
>> The scheduler initialization code checks that the scheduling
>> classes are consecutive in memory by comparing the end
>> addresses with the next address.
>> 
>> Technically in ISO C comparing symbol addresseses outside different objects
>> is undefined. With LTO gcc 10 tries to exploits this and creates an
>> unconditional BUG_ON in the scheduler initialization, resulting
>> in a boot hang.
>> 
>> Use RELOC_HIDE to make this work. This hides the symbols from gcc,
>> so the optimizer won't make these assumption. I also split
>> the BUG_ONs in multiple.
>
> Urgh, that insanity again :/ Can't we pretty please get a GCC flag to
> disable that?

Context:

  <https://lore.kernel.org/lkml/20210505033945.1282851-1-ak@linux.intel.com/>

Obviously, GCC doesn't do this in general.  Would you please provide a
minimal test case?

Thanks,
Florian

