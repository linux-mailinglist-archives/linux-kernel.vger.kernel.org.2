Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3419937F813
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 14:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbhEMMjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 08:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbhEMMjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 08:39:42 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8849BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:38:29 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 10so21751302pfl.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6yM/wopgJf4+n6fWiQONoFUEzOPSr/VKODj2KnuocMc=;
        b=hA41ma5HOAxSYREyye75mEk/+G6y2z0v1vyBPxka2TGH2ITkZhkX/5aKDgYlsuLCFE
         ZtEL47wW4rIkbyqBl00kYxlVgXJwU909L6yB+bLuy05sZVnpTNoDyPjT+yi/3WxuW5LV
         ViQ+v8wZjHBkbOlIsUrrgcBlfub+8bOas1v4wKSX97cbLgieIifYul7q1VGZnLFENCVG
         Xgjaql5iN2IY8g1UtA3vLhVCNX+iNIgX+lJDII1YZvRYF/HiNtOgBxGbURBEWm1f4l5Z
         X1hT8ECKkmDZUZ9/24rNpIiXNimRCx9O+Fiog4/LGrhazeU0U3vwHq5lv4gurei7VGTM
         CUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6yM/wopgJf4+n6fWiQONoFUEzOPSr/VKODj2KnuocMc=;
        b=jD33/XAkNPDhvloMrnRaZugr3wNmXZzNwiSEpx071LmU54vvvTMgrFPOm2CQELXiWI
         eyPhfn5fv6Kce/mSkCMRK0QeLUcdAe2jWDLJxtHoCDVjisnbyCSTacCX2mXQOeuc4wCe
         7R48wPogO6FNIK63zFS1tkVFkDBWVTLS5TXwRo8ETSsAgujC44Hx+RM2S1E3+kuX+ojR
         TqQVGK8Azcf/W7nSliTa+XV4ovHmRdZbj9jyfD8bS9sfTzgPDducOuf+msFHzXwN9B1G
         2BHIt/1umKUIQl+zZ1I8jy1Xpdh4ApdO5GR+AMZt70sF4DD86pBQf6ia+PSDQE7AWP1S
         BrwQ==
X-Gm-Message-State: AOAM531LpCl2AypHfZcrWoUJc1/+bQNNQiiIE8S02gvL9LWpiVbqaBZh
        +7TZPWiWt5Mnv2ooL6OCc9c=
X-Google-Smtp-Source: ABdhPJyyWrCYqFhvtFa+uKcMKzQjnMcbzHn1vcTqJuKjL/hACzbbodsf0WrGU+6ydTrcOxXwtaUTvw==
X-Received: by 2002:a63:4a44:: with SMTP id j4mr40868160pgl.283.1620909509064;
        Thu, 13 May 2021 05:38:29 -0700 (PDT)
Received: from hyeyoo ([121.135.181.35])
        by smtp.gmail.com with ESMTPSA id t19sm2148448pgv.75.2021.05.13.05.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:38:28 -0700 (PDT)
Date:   Thu, 13 May 2021 21:38:22 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mm, slub: change run-time assertion in
 kmalloc_index() to compile-time
Message-ID: <20210513123822.GA776220@hyeyoo>
References: <20210511173448.GA54466@hyeyoo>
 <20210512195227.245000695c9014242e9a00e5@linux-foundation.org>
 <20210513031220.GA133011@hyeyoo>
 <20210512204024.401ff3de38649d7d0f5a45e8@linux-foundation.org>
 <20210513062809.GA319973@hyeyoo>
 <a36ab9a1-f07a-42ca-bb11-5bd0c70660bb@suse.cz>
 <YJ0ACtMpasnoZdUp@elver.google.com>
 <20210513120339.GA772931@hyeyoo>
 <CANpmjNP9AQ2PH9wtZbZ3bT=0YAqnaPpxAN0LgrjBO_PhzG5tjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNP9AQ2PH9wtZbZ3bT=0YAqnaPpxAN0LgrjBO_PhzG5tjQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 02:29:13PM +0200, Marco Elver wrote:
> On Thu, 13 May 2021 at 14:03, Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> > On Thu, May 13, 2021 at 12:31:38PM +0200, Marco Elver wrote:
> [...]
> > what about checking size it on top of kmalloc_index? because by definition of
> > KMALLOC_SHIFT_HIGH, it's not always 25. it can be less than 25. for some
> > situations.
> >
> > below is what I suggested beofre. for just reference:
> 
> This doesn't solve the problem. We want the compiler to complain
> whenever kmalloc_index() is used with non-constant in normal code.

in the beginning, I thought kmalloc_index is called only from kmalloc.
but if kmalloc_index is called from other place, I think it should
correctly check its size. that's what kmalloc_index should do.

or... should it be solved as another patch?
