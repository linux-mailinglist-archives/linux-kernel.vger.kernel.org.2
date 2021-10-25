Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1404398FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbhJYOtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:49:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27963 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230128AbhJYOtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635173221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a04ZZ47w9GDaq75LG4zCPiOumcv3w3XC0Cv2Llat4co=;
        b=CSso1VUN8jxdaSkZzcBAnaCfFj+JhRKlrxjdOFzVev1qLtc1odu1jwmhalwY5GvIjorz7Z
        VLbmUvciT3Nsg9O+t3xY0FEpOoGx2nO9u2WySwibqT8CLl7M/ekZSsZuOBd54G9+dO6HwS
        ACd6oSsKS8Zkh5xa0NsbiXwU2N1qN7E=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-DsfbvXawO-iIKmnPZsN8DQ-1; Mon, 25 Oct 2021 10:47:00 -0400
X-MC-Unique: DsfbvXawO-iIKmnPZsN8DQ-1
Received: by mail-oo1-f72.google.com with SMTP id e3-20020a4ada03000000b002b85240388dso2662552oou.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a04ZZ47w9GDaq75LG4zCPiOumcv3w3XC0Cv2Llat4co=;
        b=IYx7mE75v9/3p+NZnn+61mqEF5n7C92NTSqGbj0Nx4SekkkPHehtU4TIT3+OlWw2h8
         4m0zjCBIaytJThLmGp0MI33qETTlTW/wrkso3ATDJ+AEbKLfyDhF8Dny64ras+wnWYe9
         ltN9ttzkZaPvDZs8uCYRGFmD6EKi98vAWzw3+gJn4hoh6dn3drG4WtMbL21S3pOPizkk
         /pXRwtPMoTpql/7NxG3TVJ6PIoI9Qu6GzxBynM8SAlNHqkU8TWbyVdN7zTD9CfCC0omg
         pACeDHV0QzWrdXSJaGx5/NU6uscqxl4AMX50HhPXLdgLr3yVnV8NV9P/chaD0o+bjqMV
         KSuw==
X-Gm-Message-State: AOAM530SJRxsSEHbg1iCm9g6uz5pLK9EpwykdSJHYsB5DX9t7EUw15/3
        B+LVX/rNVfjJU8xDxy8n+izsHgj9hv+LxEt26QB8n3LOQzVpFvU2rO5MUM6G5gylXMY1K3MthGN
        pjVmgBq97RaoQ+VWJWBvIC9/I
X-Received: by 2002:aca:1712:: with SMTP id j18mr12613178oii.33.1635173219036;
        Mon, 25 Oct 2021 07:46:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymyzDJ1i9wuWhjI3nQJ4fvlw4EXWqCBZOSAt7ogRl6LfyMXYwLYXDsFoMD6v5Gfami9VQnvg==
X-Received: by 2002:aca:1712:: with SMTP id j18mr12613158oii.33.1635173218761;
        Mon, 25 Oct 2021 07:46:58 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id h91sm3542420otb.38.2021.10.25.07.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:46:58 -0700 (PDT)
Date:   Mon, 25 Oct 2021 07:46:56 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Rob Landley <rob@landley.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Commit 0d989ac2c90b broke my x86-64 build.
Message-ID: <20211025144656.fqqneysf72wwxp3m@treble>
References: <53f767cd-9160-1015-d1b8-0230b5566574@landley.net>
 <CAK7LNAQFEi=4nky4nxRA8s+ODaf89Wa5kwDhe9dppKWX0UiFJA@mail.gmail.com>
 <20211024192742.uo62mbqb6hmhafjs@treble>
 <66ed460c-ac48-2b5a-e8e4-07613cf69ab0@landley.net>
 <YXZzIUqdWW9wwlpr@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YXZzIUqdWW9wwlpr@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 11:04:33AM +0200, Peter Zijlstra wrote:
> On Sun, Oct 24, 2021 at 09:51:45PM -0500, Rob Landley wrote:
> > > Unfortunately I think CONFIG_STACK_VALIDATION is no longer optional on
> > > x86-64 these days, because of static calls and retpolines.
> > 
> > Does it need stack validation, or just a frame unwinder?
> 
> static_calls rely on objtool to find all "call __SCT*" instructions and
> write their location in a .static_call_sites section.
> 
> The having of static calls is not optional on x86_64, and I have zero
> interest in trying to work out what not having static_call() does, or to
> maintain that option.

What I meant was, make STATIC_CALL_INLINE optional.  Then it would use
out-of-line static calls which should just work, no?

-- 
Josh

