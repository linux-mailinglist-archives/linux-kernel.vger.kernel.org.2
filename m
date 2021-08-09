Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F843E472B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 16:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbhHIOGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 10:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbhHIOGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:06:23 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C83C061796
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 07:06:03 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i10-20020a05600c354ab029025a0f317abfso14768254wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 07:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=lNSeB72xwfEDG7NSCSN7DcWJa7Xwkv52vfkg5maE5iQ=;
        b=OpRfMH6izgVEDg7K2VDH5oaZAsJl/S1Sah7pHgP0QqMr5GYj5pgsGeQ8HjJSp28jaT
         QKKRbUXb6QbfFhJdVKKMZaWQ2Z2jUgVw3f5wv5DQEW+1pBgDJ2ALKUW+Zc1d/qRSQjg/
         kO38gj/jrcNyIzqgQLQuIsKIgc/tUt89Uu5AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=lNSeB72xwfEDG7NSCSN7DcWJa7Xwkv52vfkg5maE5iQ=;
        b=ogLUUpVTodO68azETOusV4/KeA/+xz8sRghT0bYLLleGBPaWnmEJ/2ay/C87/uBwth
         jXo/mXnduerveX/7N7jMYA74nSUMZ/qrWCREovRd76+z9jmFSSBp1M5UXSndCTIC9q+A
         m7ua8VPpB1Xb1FdJGOPnsH62zYErbDjsujVYPLoLVVnZqxtZMZCzTbGOuHSab8LAC/R2
         d4kzzv22htLXF5LcnKXTK30NgCiIq5sOzwaVMiON6onVLhww9XLbmIPLhnBZW7HCX5f/
         MrHkEZU74sP1u1yJtD2g+afzYV7+RlaRSg8auQVu2t0YI9ofqC9i5TU43vfuRkHwCtJ+
         KM8A==
X-Gm-Message-State: AOAM532vSA4ipFj6radPiZhZP+OeA3DYBhQLQPA4lBlh/RVmUuXuSwhP
        4dFl9panBcuP0A5/A+kshSVnLQ==
X-Google-Smtp-Source: ABdhPJxtN7hvGNB1+/RtoxcA9RAkOM8/syk57Da6EYadLpJdvS+VEMTr6VCyqxOUp3pKgRGhV2cUyw==
X-Received: by 2002:a1c:43c1:: with SMTP id q184mr33027913wma.173.1628517961710;
        Mon, 09 Aug 2021 07:06:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id e25sm6423516wra.90.2021.08.09.07.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 07:06:01 -0700 (PDT)
Date:   Mon, 9 Aug 2021 16:05:59 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     DRI <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Matt Roper <matthew.d.roper@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the drm-intel
 tree
Message-ID: <YRE2RwQ6XlUqbgmn@phenom.ffwll.local>
Mail-Followup-To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        DRI <dri-devel@lists.freedesktop.org>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Matt Roper <matthew.d.roper@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210715141854.1ad4a956@canb.auug.org.au>
 <162823181614.15830.10618174106053255881@jlahtine-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162823181614.15830.10618174106053255881@jlahtine-mobl.ger.corp.intel.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 09:36:56AM +0300, Joonas Lahtinen wrote:
> Hi Matt,
> 
> Always use the dim tooling when applying patches, it will do the right
> thing with regards to adding the S-o-b.

fd.o server rejects any pushes that haven't been done by dim, so how did
this get through? Matt, can you pls figure out and type up the patch to
plug that hole?

Thanks, Daniel

> 
> Regards, Joonas
> 
> Quoting Stephen Rothwell (2021-07-15 07:18:54)
> > Hi all,
> > 
> > Commit
> > 
> >   db47fe727e1f ("drm/i915/step: s/<platform>_revid_tbl/<platform>_revids")
> > 
> > is missing a Signed-off-by from its committer.
> > 
> > -- 
> > Cheers,
> > Stephen Rothwell

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
