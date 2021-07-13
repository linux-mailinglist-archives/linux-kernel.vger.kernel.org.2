Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438213C7792
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 21:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhGMUBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 16:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhGMUBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 16:01:31 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F6DC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 12:58:40 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i5so22617656lfe.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 12:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TWXBE2VTCTk8wXZw3+DTQo1Bqc43JUhOeaoaUlFV+Nc=;
        b=CFLfq9mQRVkeFIKtgFF6xB2WiQ9NQrHUnQOWV71uF7wmQW5l56yFzqBI/QKSEB0fAO
         IBnW3YCqIH/MbEqpR808nvZ5Qt43jaa4L4ufGnklJMzM1B4hTIBoOSazC2IUH5uxrFRX
         aFaWThc9dEEHS0FmSKHSRoB2b/sZ966XYzfPNdLohMF+868XBsPix02KoYd6mpe5nA0k
         qn+3E3o4E3f0i/wu+A/0WsQgXVf/L59GLDtHzwXkBuEUh3JI1Befsy3YnMoSTRPWwkdf
         iITminZwtodHn6oAyMhg2KH6iB3WGsO0Vs3mbjrGq4k+RI+zKHcdXrCpbP7zPhZ7SvcW
         +Qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TWXBE2VTCTk8wXZw3+DTQo1Bqc43JUhOeaoaUlFV+Nc=;
        b=d9X3OBu9fMQA0zo6yC9xRQjcyf8xHgjWDrLJBy29mcisLkfMfv3gP7lWu9mILUBgLQ
         +Lvf+3BtZ4t0TD71I7BtRTBJxtKX2GXAESKkuP4bc8o2XkgkBa+IPjzehwRnCyxzBTQD
         urRGBdd3DvUpctVWe6zTIgEjTOOjAS2afUlXDlC6LM9hJtWhReNshuE9EncvG1iSWgcG
         aMewNI9q4Rki5LToQ/cxK1Um2fSNRCi5XwtGUZGEJ78DKU6aLSJASFkhxOZZwrQvj9Bz
         pl34ZOtQ5WTqxZWdrzW/8yuRDrjccSzHcOsYVJutADj8Jbhlf4lTdIBB/BcYQhJQfsaz
         3H6w==
X-Gm-Message-State: AOAM5302m/MFuvMxLmp8ifowbUSEUZsIYZYXYeHgqxRNzFUP/AucYL0v
        kDM+qTTQef1D8yy/RXuFizg=
X-Google-Smtp-Source: ABdhPJzPocR6Xm91gfYTrEpIRN0lYXtOUuDZvjfrxLf4SQHcUiHLSdvjpOwZUNMAojsUbs7g2CMAHA==
X-Received: by 2002:ac2:4e69:: with SMTP id y9mr4783834lfs.593.1626206318841;
        Tue, 13 Jul 2021 12:58:38 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id o18sm28073ljc.25.2021.07.13.12.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 12:58:38 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 13 Jul 2021 21:58:35 +0200
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [mm/vmalloc] 5c1f4e690e:
 BUG:sleeping_function_called_from_invalid_context_at_mm/page_alloc.c
Message-ID: <20210713195835.GA21685@pc638.lan>
References: <20210713142414.GA28943@xsang-OptiPlex-9020>
 <CAHk-=wiDif7SvA5DOWj9ssDuYHC4ujUFPd7ad-ydhY-WMLb-kQ@mail.gmail.com>
 <YO3a7erVd2yXdaAK@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YO3a7erVd2yXdaAK@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 07:26:53PM +0100, Matthew Wilcox wrote:
> On Tue, Jul 13, 2021 at 11:19:29AM -0700, Linus Torvalds wrote:
> > Does anybody see what the problem is there?
> > 
> > There's an odd report _after_ the warning:
> > 
> > [  131.345319] raw_local_irq_restore() called with IRQs enabled
> > [  131.366561] RIP: 0010:warn_bogus_irq_restore+0x1d/0x20
> > [  131.433334]  __alloc_pages_bulk+0xbb8/0xf20
> 
> That's the key -- __alloc_pages_bulk has interrupts disabled and then
> page_owner allocates memory for the stack dump.  Mel has a fix; I think
> we're just waiting for it to hit your tree.
> 
I was thinking about how we came to the step when a sleeping check is fired
somewhere deep in the "page-bulk" allocator. If vmalloc was invoked from
non-sleepin context we would see it earlier, at least in alloc_vmap_area().

I think, the bulk allocator disables interrupts and does some sleeping
things.

Matthew, Could you please point to the fix?

--
Vlad Rezki
