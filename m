Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EAB3FFA0F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 07:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbhICF6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 01:58:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25171 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233634AbhICF6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 01:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630648621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bDvgsokZwzrcNUaLieJR18ZGVjKpNWnq/qMS3t3kGKI=;
        b=BYW/psdTAmDXMGYl4RM2KFT5ZznNaxNxeNCrteeDEIhZnx28qdoBdUtVPRY4yYjzR5WuHR
        dpWT0lRSB7FV6w5wsyNA9sIzSuPvcvD85N1cKhW4iFjSwdUrGrOpJ9Z3tn2TBxzbMz2zpu
        22BLrpWKbuHKrC7GCpGvFYj24Ey0vMo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-dZwVb6pJOZiFzLuBQGYpYQ-1; Fri, 03 Sep 2021 01:55:46 -0400
X-MC-Unique: dZwVb6pJOZiFzLuBQGYpYQ-1
Received: by mail-qk1-f200.google.com with SMTP id t18-20020a05620a0b1200b003f8729fdd04so5267219qkg.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 22:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bDvgsokZwzrcNUaLieJR18ZGVjKpNWnq/qMS3t3kGKI=;
        b=uPH9VEp4nPJHscLKZO+2GbcjFWhV+dm276WSaNe7f2nTcv+ISqB0X97plf06SEDOuS
         YCA3VLPes4eCfF6HWxKG7YgHaQUY0qbQa4bsw5u2tNtyrA3kmY23Uz9avEEvISWhoLE+
         uOPjVetBW4SZl0Jm5Q3/EilBQJRpbQmoMxusJMwjFGfhN0/bwu6x6jVqB9FjAfmnFJoR
         9yVR6oFmsjoZFR3ko3lIn/Xun/9br1rnhU1Q7sugoM1cyyNLxLvKg785hwtLPkdc5qF3
         i9sTB9Zqq8GSqHaqkJBKqF8H85SF+pSMrjljalasephWQcjlKQGkYvhRZ5pt27XhlwCm
         2yfA==
X-Gm-Message-State: AOAM533Do1OWP61xbtQ7fDMMDuQYvWdYnL4vC05Nch6ICS0Z6Qc/SPtF
        IUgeHm4A9PEYjbgHShhAyPsq0CgRQ3MQxtwaHZDwcusYCuSn6R/JPkdPtKdpnhvFBanYrKxFT1/
        9YdinLrRg8Qfi0aVXxHLwa8dh
X-Received: by 2002:ad4:47cc:: with SMTP id p12mr1967392qvw.16.1630648545823;
        Thu, 02 Sep 2021 22:55:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2rfokB35RHoytkOenvkXEQNhy0zoJ+Ni5jGU5Fpr4Gqpd31z62no5fBtGg9o+rq+iUgaKgw==
X-Received: by 2002:ad4:47cc:: with SMTP id p12mr1967372qvw.16.1630648545652;
        Thu, 02 Sep 2021 22:55:45 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::d])
        by smtp.gmail.com with ESMTPSA id x23sm3180733qkn.29.2021.09.02.22.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 22:55:45 -0700 (PDT)
Date:   Thu, 2 Sep 2021 22:55:41 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/4] vmlinux.lds.h: Split .static_call_sites from
 .static_call_tramp_key
Message-ID: <20210903055541.b3dk5yqwkslklvsa@treble>
References: <20210901233757.2571878-1-keescook@chromium.org>
 <20210901233757.2571878-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210901233757.2571878-3-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 04:37:55PM -0700, Kees Cook wrote:
> These two sections are ro_after_init and .rodata respectively. While
> they will ultimately become read-only, there's no reason to confuse
> their macro names.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

