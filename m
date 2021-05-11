Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156CF379D53
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 05:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhEKDEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 23:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhEKDEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 23:04:54 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E830C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 20:03:49 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s22so14740566pgk.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 20:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZDmXg4/mFr8nEo1HcwOFLGcCWD9FSJhKIPyfBmQ2tHQ=;
        b=QOYCuBvjXc2TwsM8hl5FMeSRYIKC0ziDeouJIj+twlVTNDRnK34t0OFaYyRoaZ3Aj1
         uWHohMqHmfXbN1FacVnhLSD4UWeqe98e8/0VhCHxKA3CPt/cB5VsG743LT8x1rt1rYMN
         3fE7798kdebLz5rivkhiOsXuAv0+fZWmvq33p6oYOIgU+DzTUS5W9UpmU/FdcIOv/Dx1
         uHbguGbGtLq3b481wcJ6YANByVMbgVdtnqBJPwPZzdSNU+Qen0kQfozgOQ+3tNzduGaJ
         pXr0w6jEwEu7rFQx6aXa0bhSfJT1RlR0vPf0v8O5fFesp1HuzWfL4TwxReISYJ6zSB/a
         uPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZDmXg4/mFr8nEo1HcwOFLGcCWD9FSJhKIPyfBmQ2tHQ=;
        b=FCFXjcMzCWUuJG0eyRvr+gRnsyD+CZDtqUwFLcJ3Q0O7DVe461DzAywrsiOlPHwtKZ
         lb3yAbO4Yrlg1g28Csz6yiX2uUv2dbwxNQsOLS2vmKDf4yy+ReOTlPUELkdakNGGr0jB
         G2c58OQfH/9b2WZLJmNoC0jLJ6/HPhyUyGY3sFB+OwIFAJnD966L1fHQ+Cn4mnSmEXUt
         qVMTB/f5FOzJEMM38pE+VCYqWX92D9AKLdN9+VnPnj9ZSM96f5BohDk2EizC2gwv0neO
         vrHpVJufAgMjaJGhUuVdzDAf2c9xH40T0Gq29B7psxQTMDXtuEfLbrosya0pJrGQG/ZD
         iSJQ==
X-Gm-Message-State: AOAM533RvxnrF9xaClW1IdsCTFpYpnC6r7Hu8HCcyPDOGyXYXne826mH
        a2+OSn3/1EIE8Bms4AgOrdo=
X-Google-Smtp-Source: ABdhPJyNuOQR82+mfoGzHANMYhlrLf7Dj3j+I0LB1Mrf+dIRKeyv++Qxs6BoCFjbgtcK9PHGovkjWQ==
X-Received: by 2002:a63:e1d:: with SMTP id d29mr29331179pgl.175.1620702228975;
        Mon, 10 May 2021 20:03:48 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
        by smtp.gmail.com with ESMTPSA id k21sm1642639pgb.56.2021.05.10.20.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 20:03:48 -0700 (PDT)
Date:   Tue, 11 May 2021 12:03:43 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: kmalloc_index: make compiler break when size is
 not supported
Message-ID: <20210511030343.GB98904@hyeyoo>
References: <20210508221328.7338-1-42.hyeyoo@gmail.com>
 <YJccjBMBiwLqFrB8@casper.infradead.org>
 <CAB=+i9QyxOu_1QDfX5QA=pOxxnRURPnwd2Y0EbhoO1u0e=irBA@mail.gmail.com>
 <c305ec02-a7d6-dd0c-bfee-e5b571d9ca9a@suse.cz>
 <20210510135857.GA3594@hyeyoo>
 <9d0ffe49-a2e2-6c81-377b-4c8d2147dff8@suse.cz>
 <20210510150230.GA74915@hyeyoo>
 <YJlUyc8t7MoGTFTe@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJlUyc8t7MoGTFTe@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 04:44:09PM +0100, Matthew Wilcox wrote:
> On Tue, May 11, 2021 at 12:02:30AM +0900, Hyeonggon Yoo wrote:
> > @@ -382,8 +385,8 @@ static __always_inline unsigned int kmalloc_index(size_t size)
> >  	if (size <=  8 * 1024 * 1024) return 23;
> >  	if (size <=  16 * 1024 * 1024) return 24;
> >  	if (size <=  32 * 1024 * 1024) return 25;
> > -	if (size <=  64 * 1024 * 1024) return 26;
> > -	BUG();
> > +
> > +	BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
> 
> we're being encouraged to use static_assert() these days.
> https://en.cppreference.com/w/c/language/_Static_assert
> 

can you tell me difference between static_assert and BUILD_BUG_ON?
it seems that mm subsystem does not make use of it now.
