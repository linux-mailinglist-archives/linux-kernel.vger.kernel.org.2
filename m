Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E8C347536
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbhCXJ66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbhCXJ6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:58:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7FCC0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 02:58:31 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo813308wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 02:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=21lx1XKTgIyEE/5VMZ8Qm6fLn097QzloxjnfqNNT1ZQ=;
        b=IskXKKJt0n34jbY6p0Qq2XnJ3B2KYreze8cG9V12QxYKHqjR1+sMwqd1XwbzUSp4ZD
         5OVtuN4oN/u0fC1Lzk6+7syNkfwboqjlLvBQAheeMJtKkJPWfMZAEvyoB+onjTtNIM4x
         uiDRR9tSDGxpp2cidX9yS5na7MD8H8tVxQurQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=21lx1XKTgIyEE/5VMZ8Qm6fLn097QzloxjnfqNNT1ZQ=;
        b=TOyTpWOx9GqHeVtGc+3DWmDjWICoHQEWk3CJFVMpwXC/uv1HWFF7KxcuWxsPN7FY8J
         jwr8qISwlW3kr1GbEwpK4qt6Ok0QRp3ZxMaeTFe4d+lzf0qVCLMJhu/xKsgj6UPdTp27
         1+iC312R/TiSiNaqBpK2kI01Vx+Y91a8Pzn4Rge74UbGbRkQsLb3c5zSu0mEVfOWHqy3
         6S1GRNzJrBF1AZ4beTcGAv6qrPdAVa7IrkDei71FU3SQ+DknhpZIwzlDy/DSCKHL57Ds
         alY/VOu/le2EY1lhtgpEQuoq7un2IMCkUDNiFdETuh4mAP43F/VeqQuOkqZqOFQB8Wl4
         Ao8g==
X-Gm-Message-State: AOAM533T6pNxHwpOKgoXkOj5rzhnFStzDSNBF8c9Cp2AyKGBJ9NdC6Vx
        R1Kb0IAleaQAdL2bl7QiD6MxqjkSYC9jFpg2
X-Google-Smtp-Source: ABdhPJwZIBgLGHXn/QNIGKntkctRuF7sTo3S5PNdweokZQ6ttJuFqd/ULSxIfXm5SgSCIgWZXGgd0Q==
X-Received: by 2002:a7b:cb89:: with SMTP id m9mr2084820wmi.27.1616579910680;
        Wed, 24 Mar 2021 02:58:30 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 9sm1719104wmf.13.2021.03.24.02.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 02:58:30 -0700 (PDT)
Date:   Wed, 24 Mar 2021 10:58:28 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
Message-ID: <YFsNRIUYrwVQanVF@phenom.ffwll.local>
Mail-Followup-To: Thomas =?iso-8859-1?Q?Hellstr=F6m_=28Intel=29?= <thomas_os@shipmail.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20210321184529.59006-1-thomas_os@shipmail.org>
 <20210321184529.59006-2-thomas_os@shipmail.org>
 <ec99146c7abc35d16b245816aba3e9d14862e624.camel@intel.com>
 <c2239da2-c514-2c88-c671-918909cdba6b@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2239da2-c514-2c88-c671-918909cdba6b@shipmail.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 09:42:18PM +0100, Thomas Hellström (Intel) wrote:
> 
> On 3/23/21 8:52 PM, Williams, Dan J wrote:
> > On Sun, 2021-03-21 at 19:45 +0100, Thomas Hellström (Intel) wrote:
> > > TTM sets up huge page-table-entries both to system- and device
> > > memory,
> > > and we don't want gup to assume there are always valid backing struct
> > > pages for these. For PTEs this is handled by setting the pte_special
> > > bit,
> > > but for the huge PUDs and PMDs, we have neither pmd_special nor
> > > pud_special. Normally, huge TTM entries are identified by looking at
> > > vma_is_special_huge(), but fast gup can't do that, so as an
> > > alternative
> > > define _devmap entries for which there are no backing dev_pagemap as
> > > special, update documentation and make huge TTM entries _devmap,
> > > after
> > > verifying that there is no backing dev_pagemap.
> > Please do not abuse p{m,u}d_devmap like this. I'm in the process of
> > removing get_devpagemap() from the gup-fast path [1]. Instead there
> > should be space for p{m,u}d_special in the page table entries (at least
> > for x86-64). So the fix is to remove that old assumption that huge
> > pages can never be special.
> > 
> > [1]:
> > http://lore.kernel.org/r/161604050866.1463742.7759521510383551055.stgit@dwillia2-desk3.amr.corp.intel.com
> > 
> Hmm, yes with that patch it will obviously not work as intended.
> 
> Given that, I think we'll need to disable the TTM huge pages for now until
> we can sort out and agree on using a page table entry bit.

Yeah :-/

I think going full pud/pmd_mkspecial should then also mesh well with
Jason's request to wrap it all up into a vmf_insert_* helper, so at least
it would all look rather pretty in the end.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
