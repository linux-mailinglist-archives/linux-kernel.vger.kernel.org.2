Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069F63ADAF1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 18:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbhFSQtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 12:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbhFSQtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 12:49:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6414CC061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 09:47:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624121246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q7lis0HM5bATX+CBceMi5uQ2GKYkJP3dGDCc1k+uYQo=;
        b=Apcw83/ctUNF3Vv3Zya1JHa5bHpYdtU/HYr6GTKIwFb8i2pl4BdS+SivYldeb6QhZSH2YB
        Y6cQJSkDaoRHYIqB1Ijk386QM83la2CKx3AljaAovNhxEvPga6NWWPS0po90jc3J9DpEp/
        3t7BmSpmACrQuhdE7mIdGpHJxWCew3cm3/SkgYU7rQSxK9MIVkIDoP6pxMlMtv0LexaZ0b
        uZotgG6XqyNnJpz/6vwcT8BpNjoNi2FXcur7LYbwBdvFONsi08wYMXH/FGk0A7nngSyHxR
        jZedsNHiNqKk/4Oj/wd4ZRbdrZjrICwCqC3mesAmR4rXl9+Cw9kK0gWSCkAhwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624121246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q7lis0HM5bATX+CBceMi5uQ2GKYkJP3dGDCc1k+uYQo=;
        b=4Q1lwhQpzKeFr85B4caSNlZdfPXeoi5hMeoCkGDnma1Mmxn2/0DKpHDagjMSFDlE7D4KjN
        SOC7812k0zjSioBg==
To:     Stephen Boyd <swboyd@chromium.org>,
        Xin He <hexin.op@bytedance.com>, keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugobjects: add missing empty function debug_object_active_state()
In-Reply-To: <CAE-0n51T9ZGADCk6LaKJdnQwPvMCawSvjwUP+AF0hFohAFom0A@mail.gmail.com>
References: <20210617071027.60278-1-hexin.op@bytedance.com> <CAE-0n51T9ZGADCk6LaKJdnQwPvMCawSvjwUP+AF0hFohAFom0A@mail.gmail.com>
Date:   Sat, 19 Jun 2021 18:47:25 +0200
Message-ID: <87wnqpdco2.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18 2021 at 22:03, Stephen Boyd wrote:
> Quoting Xin He (2021-06-17 00:10:27)
>> All other functions are defined for when CONFIG_DEBUG_OBJECTS
>> is not set.
>>
>> Signed-off-by: Xin He <hexin.op@bytedance.com>
>> ---
>>  include/linux/debugobjects.h | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/include/linux/debugobjects.h b/include/linux/debugobjects.h
>> index 8d2dde23e9fb..af0d73d8d29b 100644
>> --- a/include/linux/debugobjects.h
>> +++ b/include/linux/debugobjects.h
>> @@ -99,6 +99,9 @@ static inline void
>>  debug_object_free      (void *addr, const struct debug_obj_descr *descr) { }
>>  static inline void
>>  debug_object_assert_init(void *addr, const struct debug_obj_descr *descr) { }
>> +static inline void
>> +debug_object_active_state(void *addr, const struct debug_obj_descr *descr,
>> +                         unsigned int expect, unsigned int next) { }
>
> I suppose it's a landmine that may go off at some point, but this isn't
> fixing anything that's broken at the moment, correct?

The two users (RCU/i915) have it guarded with RCU/I915 specific config
options which depend on CONFIG_DEBUG_OBJECTS.

I have no problem with the patch per se, but it want's a proper use case.

Thanks,

        tglx



