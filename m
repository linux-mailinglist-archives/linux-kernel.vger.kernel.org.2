Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A0840EE46
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 02:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241567AbhIQAE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 20:04:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49543 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229842AbhIQAEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 20:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631837012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lXg7b67tonaDwOcYQzrzVEci7F/ax354VR4+gAw8iYI=;
        b=Ff3M2R5Cpeus88jnibeiXvj0Ly5fjiDma0DYeLfyU6UFMGGDQVhqOVoyxIQ1/77IvrZOmu
        sPCeg1I+NIX+Ry5Ec6wLEfMkJMwEiQfDmZ3Rp9WA16OAaRxd4n0tsL2gLjK0eClHGEjPil
        URICuQDt5ZUVftGsujqmeurIXCH1GbU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-tsy3v-vqMSiiHwYjbrrndw-1; Thu, 16 Sep 2021 20:03:32 -0400
X-MC-Unique: tsy3v-vqMSiiHwYjbrrndw-1
Received: by mail-qv1-f69.google.com with SMTP id r18-20020a056214069200b0037a291a6081so79462171qvz.18
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 17:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lXg7b67tonaDwOcYQzrzVEci7F/ax354VR4+gAw8iYI=;
        b=qFMhGervwRBErkamDAhsDJS1IJkeK5OXTWRB8jq9IF1mG+3jPhvdLrLDNEkKXQUlC8
         nx/AP4RPr2dlDY0AQcl8UaEUR8a7HfoPkF3fUbUFGCXCNdgqIQvKPYJhMISu7cY3C1nm
         qucmWZb8coG36bdCyDfpdnVINzfxQnQWZbCEWwZG2v2fvqms+ealy/yOE8yNhlhUktBk
         VSgb83/ZmKVCC9O5S6HH5I5NBjQDaLpOwhX3fNycGFWaycERnM/FnzBboO+R4AxZJoDg
         mEt1wrTbdCuutL47PIfhi3CgKhb/i6wVUvOW1Q+xNqglOyfT56o9gdCf2jSWDoW/0+CD
         hXCQ==
X-Gm-Message-State: AOAM530NZJaCie2Z/r2IhDggLWGsx2fL14a7UZCCeTILJmdukK6Z1+YT
        ciHQcITytDbxJULMtPqp56bm8eZlW6qHBWdd3rqCyopZOn+FClR6GPR/nwFGK6xR+WYJr/FNqDf
        mX1SsrzKzAsI5ZY50fIsBOFfN
X-Received: by 2002:a05:622a:1654:: with SMTP id y20mr7636919qtj.261.1631837011124;
        Thu, 16 Sep 2021 17:03:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5HqNXcmWu8ASICsYZLOr7H/ZB2oG46qRxR0r/3NUlV8Qz8QHL68CNahUKalxm+iOB5UCrrw==
X-Received: by 2002:a05:622a:1654:: with SMTP id y20mr7636908qtj.261.1631837010898;
        Thu, 16 Sep 2021 17:03:30 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d35a])
        by smtp.gmail.com with ESMTPSA id d12sm3547474qka.60.2021.09.16.17.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 17:03:30 -0700 (PDT)
Date:   Thu, 16 Sep 2021 20:03:28 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH] mm/hugetlb: Drop __unmap_hugepage_range definition from
 hugetlb.h
Message-ID: <YUPbUEjhvPL/VArw@t490s>
References: <20210916212816.86838-1-peterx@redhat.com>
 <b99f88db-edeb-fab1-803e-5e083594bec8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b99f88db-edeb-fab1-803e-5e083594bec8@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 03:57:38PM -0700, John Hubbard wrote:
> On 9/16/21 14:28, Peter Xu wrote:
> > Drop it in the header since it's only used in hugetlb.c.
> 
> Hi Peter,

Hi, John,

> 
> Tiny documentation tweak: could the above line please be changed to
> something approximately like this:
> 
> "Remove __unmap_hugepage_range() from the header file, because it is
> only used in the .c file."
> 
> ?

Sure thing.

> 
> Because: "drop it in" is so close to "drop it into" (which means, "add
> it to"), that it's actually reading a lot like the opposite of what you
> intend to say.
> 
> > 
> > Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   include/linux/hugetlb.h | 10 ----------
> >   mm/hugetlb.c            |  6 +++---
> >   2 files changed, 3 insertions(+), 13 deletions(-)
> 
> 
> The change itself looks accurate for the current top of tree, so:
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Thanks!

-- 
Peter Xu

