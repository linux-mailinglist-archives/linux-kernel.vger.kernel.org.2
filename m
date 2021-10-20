Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423554350FF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 19:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhJTRMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 13:12:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50638 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230336AbhJTRMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 13:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634749802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EDDSu21c2DDtVcs1j05La3urw7/DHvQkavRYGt1gbjU=;
        b=ecMqCDLwhDeCzrdRks0w62+G8jqPymlY7aTRfmJBGZkBMoFhkAZe820zQRLw4gHevlC0E9
        8s6UK3tujLEJUOxpSQIGWfBMv9kaPnxP8bQ4MG+IBxgrBfNs0Yyun8jikXVLE5TXLNoL4W
        sqb5lKEiJ7h1wszRthO07AQ6wtAMvEU=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-q3pCt02gOZ6_3WCFTysUdw-1; Wed, 20 Oct 2021 13:10:01 -0400
X-MC-Unique: q3pCt02gOZ6_3WCFTysUdw-1
Received: by mail-oo1-f70.google.com with SMTP id g11-20020a4a924b000000b002b76277c71bso3471924ooh.22
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 10:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EDDSu21c2DDtVcs1j05La3urw7/DHvQkavRYGt1gbjU=;
        b=moEVhd+wXetI31EuS6besTzXDYz6sMBFJKVKDYtE2i8R1F1pL0Vp4iP0281VouNGEp
         UwVuaU+2WAgKTs1ETjfIKsFHZUGqGmgT8oR+EozhAXkqzsKra+8bYFNZRslO1KAVUu19
         Hy/ego6J1QAxGhDfJcNSWGGeo9T9bUZY8RNHG/7E2RWEKspI7z/P1rAWDNMS5nC0JIk6
         7EE5YXf4y4jGVDWiq9DKNgaFEpLiAwliHq4+ZIdKfAy1S/vzVWz1jXeLfvOG8r0xn0RV
         zMGBFnPRBNjXaHnwLFrCGmbDSKulKxVc2edWmTbt6bQdKt8x4qZPg2pxQ1B/Gxjtm4oj
         J1Qg==
X-Gm-Message-State: AOAM530XmVObHT/mCv70BL8/oRfLi4V5eBszCsziiLVlTvtOCwqe3Fj/
        dxrCpc6ya06knESvV7c0Fpssv3WCX20f5aHnzbLtmwHmbXCm5CEmUhdtZVxT1VSCArvsAz4MYih
        uEHqmBoWp0VarPhZj3wdKeoLd
X-Received: by 2002:a05:6808:bc6:: with SMTP id o6mr528557oik.33.1634749800232;
        Wed, 20 Oct 2021 10:10:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsOOoYTmsd+892eISaPosYjQR+k3T8Apr/pPX0C2UDd0FwJn17PQW63f9XvVXLsuEybA7bSQ==
X-Received: by 2002:a05:6808:bc6:: with SMTP id o6mr528541oik.33.1634749800050;
        Wed, 20 Oct 2021 10:10:00 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id 187sm535011oig.19.2021.10.20.10.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 10:09:59 -0700 (PDT)
Date:   Wed, 20 Oct 2021 10:09:56 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH v2 08/14] x86/retpoline: Create a retpoline thunk array
Message-ID: <20211020170956.g67xcsvvdkuqg3qa@treble>
References: <20211020104442.021802560@infradead.org>
 <20211020105842.981215247@infradead.org>
 <20211020155750.3u74bkcp66leeyed@treble>
 <f33b9c4e-08c1-f88d-4873-82050a944010@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f33b9c4e-08c1-f88d-4873-82050a944010@citrix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 05:46:39PM +0100, Andrew Cooper wrote:
> On 20/10/2021 16:57, Josh Poimboeuf wrote:
> > On Wed, Oct 20, 2021 at 12:44:50PM +0200, Peter Zijlstra wrote:
> >> Stick all the retpolines in a single symbol and have the individual
> >> thunks as inner labels, this should guarantee thunk order and layout.
> > How so?
> >
> > Just wondering what the purpose of the array is.  It doesn't seem to be
> > referenced anywhere.
> 
> The array property is what makes:
> 
> > +	reg = (target - &__x86_indirect_thunk_rax) /
> > +	      (&__x86_indirect_thunk_rcx - &__x86_indirect_thunk_rax);
> 
> safe in the next path.

The thunks were already 32-byte aligned.  I don't see how slapping a few
unused symbols around them does anything.

-- 
Josh

