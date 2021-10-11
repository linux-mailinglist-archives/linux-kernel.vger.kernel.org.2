Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC7A4287B3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 09:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbhJKHep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 03:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbhJKHen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 03:34:43 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154EEC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 00:32:44 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id np13so12589311pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 00:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WmIH+gyLv1IEII2jV9ccpTyXH9cYgsrJ11N5wI46Cwk=;
        b=XSShNGiojyLlUovr7IKaqfRGJpRi3a1nfwsAdlxge9m12kC+OTSVuy1GLR6B7pozzZ
         2Rl6iMtuYWwkXbqErdqkCOJvgE8zZW/XFtcUZKKla8tOsX9oy/ysuNGtrIBm3LPm/3pj
         ljSQ4C42U4hH0U4gjFtNtkTqGLjSJwRigBLVFxv/19xbaoD3RShtJVW0p7gSvxgnLDCH
         8G1/J3WaWfZzg4blcTzvQSK09T4S0dE44kil/HQRxDmBVrYquEjoCJ5Zn9o63MRSDq+H
         5Eg4UMBXurLYyREnHl+Gk3MdPR2OuJOUg6yEOzOwMX4+vKeO6Z4gkSCoUoJ9TwGaD9fX
         dYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WmIH+gyLv1IEII2jV9ccpTyXH9cYgsrJ11N5wI46Cwk=;
        b=oAQ4YyrRWk+x6KSYVKJ4T0kF1RzZVPAzP75fW+tIlF9ip7ldnE68Lm7OE5/ETc7D73
         3ztFG0QOFcxsLQBNbldeAUSZApwOLrRUxq3VnuoNCdqBi/6XWahtc6iaOjw7wYU80vrN
         T6zmMuUjalgr5JIBCVMAFzP9MpmhAbLfFqJ+glXYW4hXOVT+d1j8Q3gT6HsEjbT6T9KU
         J103+i+vgLz0oBhv0drAkW4VBjC4I4ZIPKzuBCUsUl/20CgjOXBH8QHUqPbdGkYgSu30
         clfKZ69mHLmSY+wskXCucb9/vG/wR9QqhLw3guG7d/EQdaNXCLsfMRIEhN2x7R8wJOb4
         No5A==
X-Gm-Message-State: AOAM532XlaARQ3wLwxsr6C1g2W8IDiDiiY8GJu7IjNa/Cjonl90d0Wc5
        SQSsqIl9k12grps4wQs0Jjk=
X-Google-Smtp-Source: ABdhPJwVxRo9L4WpR4bARb+c1V+ea9O4L7NYFH2LqqvoQwP7QQE3Eju3POdetRvdkZn3Jow/cKvrJA==
X-Received: by 2002:a17:90a:6b01:: with SMTP id v1mr29200238pjj.6.1633937563671;
        Mon, 11 Oct 2021 00:32:43 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (24.151.64.34.bc.googleusercontent.com. [34.64.151.24])
        by smtp.gmail.com with ESMTPSA id k13sm7207015pfc.197.2021.10.11.00.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 00:32:43 -0700 (PDT)
Date:   Mon, 11 Oct 2021 07:32:39 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm, slub: Use prefetchw instead of prefetch
Message-ID: <20211011073239.GA63896@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20211008133602.4963-1-42.hyeyoo@gmail.com>
 <alpine.DEB.2.22.394.2110110919050.130815@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2110110919050.130815@gentwo.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 09:20:36AM +0200, Christoph Lameter wrote:
> On Fri, 8 Oct 2021, Hyeonggon Yoo wrote:
> 
> > It's certain that an object will be not only read, but also
> > written after allocation.
> 
> get_freepointer is used in multiple code path not only in allocation. It
> is for example used when scanning through a freelist.
> 
> With this change all objects get needlessly dirtied and the cross cpu
> cache contention is increased.

I didn't touch get_freepointer and there's
only one caller of prefetch_freepointer.

My change was not adding additional prefetch on get_freepointer,
but changing existing prefetch into prefetchw.

The prefetch was introcued by commit 0ad9500e16fe ("slub: prefetch next
freelist pointer in slab_alloc()") that you ACKed in 2011.

Do you think removeing existing prefetch is better than changing it
from prefetch to prefetchw?
