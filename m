Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EFE3D069A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 04:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhGUB0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 21:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhGUB0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 21:26:04 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CFAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 19:06:40 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so129365pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 19:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K5SBha3zR6HnIGPpTHePt7MeaM9Z7zyuvBLYdC04w6M=;
        b=F/V3TL3EIkA+1SPfKpp4W3wIkSZjEdimZxQlJZaxKweBLdvt7CsRSJQ/QxgTsA08vP
         Ff3IblbrLlK/KFckX65genz9i8/AG0pZbUyer9R18KnioTwNWwM1jYwvtopwKZrLRC2f
         OLQRbQcEpEOhmsaN3Ex9d/9KCXsOKFY5qanZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K5SBha3zR6HnIGPpTHePt7MeaM9Z7zyuvBLYdC04w6M=;
        b=Xro8jatE8oKRFpNywuk0faQMrae9oa326RFZvdgpdBV3LPtfzFk/VVZ5iRY5qzNYi5
         3XuyRUpLMueFwD6nlffQEL3asgtONm19hTJQR90FPiGb46cs8VKyq/ZcSBTa3kDNXhom
         ZEILdEkfyuG5Dz+4O8Fy0gEVgeHtEWN3IzDreCLxOwa7yNSnrCjFgW5IJY7sAOrq8Y+t
         UPaItoV6nhL469SYJ9+Agl3zenfqoZyKxscM6OwfHCykkKPoiulDzBcX/XTvrGtogaiM
         YoJi+aimImLaeQl98pnJVYS9pP614MZf91h2UX9rEBfEPr/DqF0hlYKhzFR8Joh7XrGJ
         psfw==
X-Gm-Message-State: AOAM533ijPLmFQcLqXQUA3jgfzX5SYeI7Xro5CGhVfEjZ2enjHlcT+0O
        1XoC+f9pxT8NSKIUZhDoKWV/sw==
X-Google-Smtp-Source: ABdhPJwo6hl98vCtoCJtqUlnEf/MD/LBM1QEly8wtPd1ZqxMrJU4eNKrvrWI9kd/HRAIwvTyhyDIQQ==
X-Received: by 2002:a17:90a:1704:: with SMTP id z4mr1378336pjd.213.1626833199843;
        Tue, 20 Jul 2021 19:06:39 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:808c:1a13:1159:8184])
        by smtp.gmail.com with ESMTPSA id m18sm25367726pfd.42.2021.07.20.19.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 19:06:39 -0700 (PDT)
Date:   Wed, 21 Jul 2021 11:06:34 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Will Deacon <will@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCHv2 3/4] arm64: do not use dummy vcpu_is_preempted()
Message-ID: <YPeBKqIS+OTrVKBO@google.com>
References: <20210709043713.887098-1-senozhatsky@chromium.org>
 <20210709043713.887098-4-senozhatsky@chromium.org>
 <875yxf356w.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yxf356w.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/07/12 16:47), Marc Zyngier wrote:
> >  #include <asm/qspinlock.h>
> >  #include <asm/qrwlock.h>
> > +#include <asm/paravirt.h>
> >  
> >  /* See include/linux/spinlock.h */
> >  #define smp_mb__after_spinlock()	smp_mb()
> >  
> > -/*
> > - * Changing this will break osq_lock() thanks to the call inside
> > - * smp_cond_load_relaxed().
> > - *
> > - * See:
> > - * https://lore.kernel.org/lkml/20200110100612.GC2827@hirez.programming.kicks-ass.net
> > - */
> 
> Why are you deleting this? Please explain your reasoning in the commit
> message. It seems to me that it still makes complete sense when
> CONFIG_PARAVIRT is not defined.

You are right. I'll move it to !PARAVIRT #else-branch.
