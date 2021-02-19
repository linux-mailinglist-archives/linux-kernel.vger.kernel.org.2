Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D54831FA3A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 15:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhBSOBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 09:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBSOBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 09:01:49 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59614C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 06:01:09 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id g24so3954425qts.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 06:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uy9+p8EYLZ+2upxXdnXYCqgGljKcN5wTbKwGZwnqinY=;
        b=I5flSyH/gLTP7kfpLHlSgh5tXtA+Jh1EsK+6uIgyy09vUXp0IZUoyofNXle2UG8+9x
         6bQcZMjTHGSnCjsIADBeVZNPoafr3TSU4gbVUKm8tx7gxct5TAh1oqibAjgx2ny24Qlv
         nA8b7dO5wJoNvKGJUaq5YdpKB1knNz20AuCjHXqPKjX/HXDnk9GUA8KprUxsiW5TqfOU
         9o+5AHrQgpJl5wOCAeVJMcNlnBgpfbhD2hv2/vQ80bpHkUbm4gdpFUasgTAZI9JejzbF
         hWMAig8ep9wZI5JeASo7p/0n5GOB7qV6LVTspTVmRmVoA3TvIzBilhfwzcUDD73XF8lP
         SRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uy9+p8EYLZ+2upxXdnXYCqgGljKcN5wTbKwGZwnqinY=;
        b=iM4FdNtVl7U5CLgnPIuJE1Ln9en+ortt77lmNS5CcKKWjDZSfvXa/xOpZtozNHBuTQ
         5rsSboPYTBgWlFySuluqO1/Of3k6DMWdao9qWoTpGjSAguJEF/c07qcBAD1LS0y6o5s4
         D9DvEKIvlYcR7Fz8YPLhnRZzshGsYfmv71F3+TFHR3BOA4Yqm8YUvFUMOZEZpqPqTlU+
         Kab5OQGdMdO8YThqQAvxWcan7h5abkUAFrrBhDvPBvOcTnNtoa7BreAKTsSZwrQYLdmg
         rvnxeNgo9VgtTozftMsSf7qt5DHUUgsD8Pb0fSwYhuo4FpoB7DZgjZh1zZ8+87qGvDtt
         1mHQ==
X-Gm-Message-State: AOAM5336pN3JUEKAxbH7pZGMAAF+qCeQw3ecjVt6P91Vzrl7AvmO6UDe
        aQd4ii8d6wNM/6qWfT0+fzdU4kYsyLkZYD5a
X-Google-Smtp-Source: ABdhPJwvDnWgEME/UBp5mpDqS0tmSE99XXBjYe+mDgcmjGaB5orYQxdcs7Ze95f3nVqD5XVW9Zc5qg==
X-Received: by 2002:a05:622a:306:: with SMTP id q6mr8969998qtw.15.1613743266418;
        Fri, 19 Feb 2021 06:01:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id 14sm5338161qtx.84.2021.02.19.06.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 06:01:05 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lD6LB-00CPnQ-2t; Fri, 19 Feb 2021 10:01:05 -0400
Date:   Fri, 19 Feb 2021 10:01:05 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, bskeggs@redhat.com,
        akpm@linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
        dri-devel@lists.freedesktop.org, jhubbard@nvidia.com,
        rcampbell@nvidia.com, jglisse@redhat.com, daniel@ffwll.ch
Subject: Re: [PATCH v2 1/4] hmm: Device exclusive memory access
Message-ID: <20210219140105.GE2643399@ziepe.ca>
References: <20210219020750.16444-1-apopple@nvidia.com>
 <20210219020750.16444-2-apopple@nvidia.com>
 <20210219094741.GA641389@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219094741.GA641389@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 09:47:41AM +0000, Christoph Hellwig wrote:

> > diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> > index 866a0fa104c4..5d28ff6d4d80 100644
> > +++ b/include/linux/hmm.h
> > @@ -109,6 +109,10 @@ struct hmm_range {
> >   */
> >  int hmm_range_fault(struct hmm_range *range);
> >  
> > +int hmm_exclusive_range(struct mm_struct *mm, unsigned long start,
> > +			unsigned long end, struct page **pages);
> > +vm_fault_t hmm_remove_exclusive_entry(struct vm_fault *vmf);
> 
> Can we avoid the hmm naming for new code (we should probably also kill
> it off for the existing code)?

Yes please, I'd prefer it if hmm.c was just the special page walker
and not a grab bag of unrelated things

Is there is a more natural place to put this in the mm for this idea?

Jason
