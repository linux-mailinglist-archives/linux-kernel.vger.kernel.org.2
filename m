Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC0A399456
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 22:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhFBUNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 16:13:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49093 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229618AbhFBUNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 16:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622664678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CSRmX+FDS/GxrreH9xxeE/g9PuIN/GIv3cCKatjn/Mc=;
        b=g8sZvC/uA913o1xahaZNnGUA2vQSl4G9i6vKuDw8WVPluR4kWL8oV5LgwUamtFEXe+wrjw
        TINvi3u6ZD1SGO4ju3pY/MPvyAVPLp3CwskBTEg5mTJJWnbE1PaPYCN+mydG7Ypy3h98B8
        VLtQTOzxnkhxF0uNSFvvoGKxy6ZuCkQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-GwOK6_qMMTa3fLpphKtr8g-1; Wed, 02 Jun 2021 16:11:17 -0400
X-MC-Unique: GwOK6_qMMTa3fLpphKtr8g-1
Received: by mail-qv1-f72.google.com with SMTP id n12-20020a0c8c0c0000b02901edb8963d4dso2653710qvb.18
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 13:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CSRmX+FDS/GxrreH9xxeE/g9PuIN/GIv3cCKatjn/Mc=;
        b=SFUOs81TKT/IPW6CSdKXaXNIYw4uhTZAh06h+fiivLW0gOwZ522tdM4nt48Tb6XPON
         1SBOiIVeQ86u353X2SYqwhZ8E61vYdLLOB30276DmS6Lofgqk0RyMZl8LlJTuIp7rbPY
         hfQ856L7mw6XBdvCcGHnFEFOwVxbGxtaJR7cU/EQoPp3GHkMmWEZcigjkSs3e526B3CK
         LsVxkDBtPeRXdMyTIm4VRfWBKUlPgoWQ7akfcZ4jBTy0AZHuufQtI/oazzQ27aEAVmWg
         4jDmrQTAn9S5ndSnhPk16h/17JfFtDc9PSwKLkvLb4XQiETaj5HQ2AFvlmd6yGWGSKrI
         mJjw==
X-Gm-Message-State: AOAM532IbvwMpVdQCt7q8v8YYag+xOKjLZNWV6ExMHavwsSVevIG1Afa
        R3XDVWN4VSWsiw53LMSb5iaKSGsqf5DYMaioVEusAFvN0ZzupatgTU2lyjs3lS79boBwnsQznwh
        c0LeS5o29J8y8ewo96asigsrz
X-Received: by 2002:a05:6214:e4d:: with SMTP id o13mr17043947qvc.19.1622664676727;
        Wed, 02 Jun 2021 13:11:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZjZ8rrlikpx3dQU20EhYB/9CMwwnljiy3i6TbaDxe5BRTF53qkmMSwvadPyohzcS97aHnYw==
X-Received: by 2002:a05:6214:e4d:: with SMTP id o13mr17043927qvc.19.1622664676532;
        Wed, 02 Jun 2021 13:11:16 -0700 (PDT)
Received: from treble ([68.52.236.68])
        by smtp.gmail.com with ESMTPSA id h3sm531880qkk.82.2021.06.02.13.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 13:11:16 -0700 (PDT)
Date:   Wed, 2 Jun 2021 15:11:13 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
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
Message-ID: <20210602201113.gsuw7km3lkupg6r7@treble>
References: <cover.1620186182.git.jpoimboe@redhat.com>
 <5ba93cdbf35ab40264a9265fc24575a9b2f813b3.1620186182.git.jpoimboe@redhat.com>
 <YLe73YcUeXBaLwHr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YLe73YcUeXBaLwHr@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 05:11:57PM +0000, Sean Christopherson wrote:
> On Tue, May 04, 2021, Josh Poimboeuf wrote:
> > The x86 uaccess code uses barrier_nospec() in various places to prevent
> > speculative dereferencing of user-controlled pointers (which might be
> > combined with further gadgets or CPU bugs to leak data).
> > 
> > There are some issues with the current implementation:
> > 
> > - The barrier_nospec() in copy_from_user() was inadvertently removed
> >   with: 4b842e4e25b1 ("x86: get rid of small constant size cases in
> >   raw_copy_{to,from}_user()")
> 
> Mostly out of curiosity, wasn't copy_{from,to}_user() flawed even before that
> patch?  Non-constant sizes would go straight to copy_user_generic(), and even if
> string ops are used and strings are magically not vulnerable, small sizes would
> skip to normal loads/stores in _copy_short_string when using
> copy_user_enhanced_fast_string().

Yes, it appears so.

-- 
Josh

