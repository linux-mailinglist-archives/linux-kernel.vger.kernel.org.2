Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF363AB554
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhFQOGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhFQOGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:06:45 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116E6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 07:04:37 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id m13-20020a17090b068db02901656cc93a75so6150836pjz.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 07:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m08QhGbjsqNMKDfakqlQtcqTK06PXTezleRaulhxGzY=;
        b=lUWkoeD4MiFsevJjayo/38vNE7ZcF3Oxzw/b1Q07FkRc7ABIzvQDeAtOro7WvCfVrO
         +VJiaMYJWwbbZat1lQItgBdYyGP9y7+FW4bSanRqQ+5ocg8rG6DhPe63YNfFFMucSoq/
         1dwu701UdFYBSLnDG01vwkNtz5Ll7cMqNVi2HgAosjZ+h/TcBaznbunrF/ePq5Ki2nas
         mpJ+ADs4ZeMjYHk4HBtHkQ5PHbNQyAOcC6+SzcpJkxox/ri31d301yaoSmcy/5zcJnl+
         iIgVGGd+lg7Rc02efWHJigJQDevZu4jTyPSQoCg626+ngc5b4j9YIYIkqhKSsoy7qgYd
         6C/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m08QhGbjsqNMKDfakqlQtcqTK06PXTezleRaulhxGzY=;
        b=hxSmdM5PgpNPd5LGA3oY3Jm+WpXBXuAJ5KWhQpDFwteu/BA1cPrO1NpK9LNT+NjXJ0
         CP9f+BP3zHYH1Vb+SvntGUY7EBM5OrrYOoqz301Kc9LpIOyu95WNNgmBj+9YIukH4mgq
         Lcs8zT0ed6QXMftXCF+0aixTK+oEATPpBMuTA1Yo2MROuSkUyOSwpaCxPr2wboq+aD4C
         HHRxdkSpN89WRJP8i9Hasxgly/pmZhChtEYS4NWW+kDx1i1xWa9fIFV/szqMgzoCj4C6
         AgQpFoGW78simSELze1dwbqsp2ykOWn8ZFzVVoX9TmMY2yhfEwuSCxB8M/eOEpT1H9sX
         Ol4g==
X-Gm-Message-State: AOAM531C0tve4cpMVkD9jYwz149CjXSiBiKTmgreug6RiBHA8w8H+PKZ
        8+QfmY3p7ln0OGmcbpVXYGE=
X-Google-Smtp-Source: ABdhPJw3GdT62IZuD4bx51NMgvLf/wsXCZbpE/gH+uomRAWk1xAMH0zRsTzXvPIjNue6X91FmIaDAA==
X-Received: by 2002:a17:90b:4b49:: with SMTP id mi9mr16281017pjb.219.1623938676419;
        Thu, 17 Jun 2021 07:04:36 -0700 (PDT)
Received: from localhost ([61.69.135.108])
        by smtp.gmail.com with ESMTPSA id c5sm5652006pfn.144.2021.06.17.07.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 07:04:34 -0700 (PDT)
Date:   Fri, 18 Jun 2021 00:04:31 +1000
From:   Balbir Singh <bsingharora@gmail.com>
To:     Daniel Axtens <dja@axtens.net>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, elver@google.com,
        akpm@linux-foundation.org, andreyknvl@gmail.com,
        linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
        aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH v15 0/4] KASAN core changes for ppc64 radix KASAN
Message-ID: <YMtWb2HJx44HdgQC@balbir-desktop>
References: <20210617093032.103097-1-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617093032.103097-1-dja@axtens.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 07:30:28PM +1000, Daniel Axtens wrote:
> Building on the work of Christophe, Aneesh and Balbir, I've ported
> KASAN to 64-bit Book3S kernels running on the Radix MMU. I've been
> trying this for a while, but we keep having collisions between the
> kasan code in the mm tree and the code I want to put in to the ppc
> tree.
> 
> This series just contains the kasan core changes that we need. These
> can go in via the mm tree. I will then propose the powerpc changes for
> a later cycle. (The most recent RFC for the powerpc changes is in the
> v12 series at
> https://lore.kernel.org/linux-mm/20210615014705.2234866-1-dja@axtens.net/
> )
> 
> v15 applies to next-20210611. There should be no noticeable changes to
> other platforms.
> 
> Changes since v14: Included a bunch of Reviewed-by:s, thanks
> Christophe and Marco. Cleaned up the build time error #ifdefs, thanks
> Christophe.
> 
> Changes since v13: move the MAX_PTR_PER_* definitions out of kasan and
> into pgtable.h. Add a build time error to hopefully prevent any
> confusion about when the new hook is applicable. Thanks Marco and
> Christophe.
> 
> Changes since v12: respond to Marco's review comments - clean up the
> help for ARCH_DISABLE_KASAN_INLINE, and add an arch readiness check to
> the new granule poisioning function. Thanks Marco.
> 
> Daniel Axtens (4):
>   kasan: allow an architecture to disable inline instrumentation
>   kasan: allow architectures to provide an outline readiness check
>   mm: define default MAX_PTRS_PER_* in include/pgtable.h
>   kasan: use MAX_PTRS_PER_* for early shadow tables
> 

The series seems reasonable

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
