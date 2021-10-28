Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B528B43DE64
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 12:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhJ1KGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 06:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1KGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 06:06:46 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116D8C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 03:04:20 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id v10so3696260pjr.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 03:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AXByAcZfSa6g97iJNKRbFJhmVHGD98OKiOfrtE0WZ9I=;
        b=Q+iHCWzYopN6uoNjIEin9SZJLMGXs/IM4fsJjefBHVrAgiumeYbIa2Os4Sl6SmX3wV
         DTXcKFLb7w8fxHHJNcTeX2BIcfwZ38AoHs7JRsGrlF/pwDpiGatPtFLb7KVevzKQUfFY
         +dHKTlYsytWvocvzaQ1O8EFpl+lPZA6x1sv0sEtTgKMdRikgnE3PCvXbRRhh9paSdkJD
         EJ0wvWQCLFiK9D9zdB0tvpyo3u7LVJ8OPPLPSp0kCEx35H358oz318Vl7etkXxt4A4Z2
         l0JYaRFttJKwbnN7JFSwTMOWpYId8IYCbfdKbGhdIkElAGFHwQDIFjVnqPQaXKdL47Vx
         56MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AXByAcZfSa6g97iJNKRbFJhmVHGD98OKiOfrtE0WZ9I=;
        b=YUZUTsGT+rZacSKQoP9EtwXV2oLkn0GO5AuWx4im0IOx2QhViAcgwzYUh+hKfRes0W
         C3Mngqa2VZHdA6JCX79mvwnEp4xlv9eP+rotyMdC9b2PU9QKzJwrIFTXM2JLbhDe5tJr
         jU/IJS/futh+X84KP+Qcp0wI7hy4FETazVZFG8vpne4lkoqOP56St6QbrfWw8DaofkHK
         EX0gFTQpWFCzH58S/MzQGuUMPgea0mv3pZfr4ZfeK+/2oenFV1SlZ8n0D4mTYl1Av5LM
         n0KLi8AhxkKESwVXdB1Bi28nd/G3LJcmtbj4YDqtoUyq+BbIOIGxchfEJvfPeqwBI7CB
         bzHQ==
X-Gm-Message-State: AOAM531q8WEb4K3TEjP9i3oehiiLU4bWBlptQKbRZ+8m2COhNn+DRXtr
        ardfxMpD8eHgNoaPHuLSr2k0Qrmb36E=
X-Google-Smtp-Source: ABdhPJzx2r84z7FRgLjwMv+WefGTjKpfog2RI4hJ77samploRENL+kYshO1kzc5N3K0nBVc71vUTsg==
X-Received: by 2002:a17:90b:3e87:: with SMTP id rj7mr11704753pjb.88.1635415459602;
        Thu, 28 Oct 2021 03:04:19 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (125.91.64.34.bc.googleusercontent.com. [34.64.91.125])
        by smtp.gmail.com with ESMTPSA id s18sm3061999pfk.160.2021.10.28.03.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 03:04:19 -0700 (PDT)
Date:   Thu, 28 Oct 2021 10:04:14 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Do we really need SLOB nowdays?
Message-ID: <20211028100414.GA2928@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20211017042852.GA3050@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <20211017133618.GA7989@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <20211017135708.GA8442@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <YWw1n6y/AGED14HD@casper.infradead.org>
 <CAB=+i9Tor-tmZuB8YjATT_rv68nnF2W_TvMvyGp55AGaSyKynw@mail.gmail.com>
 <alpine.DEB.2.22.394.2110251016260.3145@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2110251016260.3145@gentwo.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 10:17:08AM +0200, Christoph Lameter wrote:
> On Mon, 18 Oct 2021, Hyeonggon Yoo wrote:
> 
> > > Better for what use case?  SLOB is for machines with 1-16MB of RAM.
> > >
> >
> > 1~16M is smaller than I thought. Hmm... I'm going to see how it works on
> > tiny configuration. Thank you Matthew!
> 
> Is there any reference where we can see such a configuration? Sure it does
> not work with SLUB too?

I thought why Matthew said "SLOB is for machines with 1-16MB of RAM"
is because if memory is so low, then it is sensitive to memory usage.

(But I still have doubt if we can run linux on machines like that.)
