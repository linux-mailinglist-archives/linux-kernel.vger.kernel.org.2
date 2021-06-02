Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54F0399133
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 19:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhFBROq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 13:14:46 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:43584 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhFBROp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 13:14:45 -0400
Received: by mail-pg1-f172.google.com with SMTP id e22so2772702pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 10:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RMQ4zkN3UjhpVnRb+6Z5gguZ7ZmItZ+EG9/DteNvdzU=;
        b=XaAr9HUu/4UGuz2abpnUvpTxMtpc1MNCv4DAkdZhcbjxxniLgdUb2gJjNnWAqkn4CY
         cqBxpEeKQlGf5Qj2h/IaTjcprp/xtv62qM5QHjkSlKJpXEzE/IvE8iNHUeGUqYhNVMSG
         Hm8U6of7mFwP/og/De6P8RQRQRhWCLlCayP3nS0iHWfL/PwTxf+5uxtkXtM01pIVseVt
         NOCJcNFMAzjhH8pp1WYO0EIQ6ifpcaXtj5UocnOLG02EneGb7D1+C1mzYsymblr4ok90
         D/B7UVafMrnhLwxjAnX7hq5l/9fUsaV1DsaTLdIHOkXkcBYkNuaMf0zud01tjfSwpx4g
         HNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RMQ4zkN3UjhpVnRb+6Z5gguZ7ZmItZ+EG9/DteNvdzU=;
        b=p4sAeRBJP2GsbmSs9KTKTEw0N/Ad5dBatoDI41XZUefgmSAsLCDjw3AGlxg8c4Mi6O
         um85Mb3/qq+xYLBFVniHBnk+KtFnqXf90mrPsEmI4RTQyjqga/i4Se4oDvnUin5tRJBx
         KxfQP+i/aHhzeuM3Oj5L14FPLVEv0G1DxhRI3U9gPYHyBfdHJERmghyvdC4cVegRKsOn
         CF1bTOPKdrnuvZyjkzLez7BOpwIEPHEgIiAMDpbtW+VK1k9DoIEgjIhG3HuJC5/YHd0n
         AYPRZovVU9DVk3soYup3VAiF3+y49tb0SHhiLjYcjMpjXVdtX8SdAEfMLm+h43LnTDcS
         ouaQ==
X-Gm-Message-State: AOAM532OjIcBy0SB5kqvKGGR0jd7EdFqJHSjvQIQN0FO9MCMHJMmGxWQ
        LeTPYvf7ZEEasjxIKHMmujY9Cg==
X-Google-Smtp-Source: ABdhPJx7aZRYWPxgyaLsb3rWTFhgpWgBVnEhABLHSWLlsqW3wSa01vLh8FLdwM6U0GFJVL7rrTGFuQ==
X-Received: by 2002:aa7:8426:0:b029:2e9:bc0e:5c3f with SMTP id q6-20020aa784260000b02902e9bc0e5c3fmr20166593pfn.22.1622653921969;
        Wed, 02 Jun 2021 10:12:01 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id w1sm195010pfi.162.2021.06.02.10.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 10:12:01 -0700 (PDT)
Date:   Wed, 2 Jun 2021 17:11:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 3/4] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Message-ID: <YLe73YcUeXBaLwHr@google.com>
References: <cover.1620186182.git.jpoimboe@redhat.com>
 <5ba93cdbf35ab40264a9265fc24575a9b2f813b3.1620186182.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ba93cdbf35ab40264a9265fc24575a9b2f813b3.1620186182.git.jpoimboe@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021, Josh Poimboeuf wrote:
> The x86 uaccess code uses barrier_nospec() in various places to prevent
> speculative dereferencing of user-controlled pointers (which might be
> combined with further gadgets or CPU bugs to leak data).
> 
> There are some issues with the current implementation:
> 
> - The barrier_nospec() in copy_from_user() was inadvertently removed
>   with: 4b842e4e25b1 ("x86: get rid of small constant size cases in
>   raw_copy_{to,from}_user()")

Mostly out of curiosity, wasn't copy_{from,to}_user() flawed even before that
patch?  Non-constant sizes would go straight to copy_user_generic(), and even if
string ops are used and strings are magically not vulnerable, small sizes would
skip to normal loads/stores in _copy_short_string when using
copy_user_enhanced_fast_string().
