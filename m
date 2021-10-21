Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9C743689E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 19:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhJURFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 13:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhJURFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 13:05:38 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B1FC061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 10:03:21 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so1001009pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 10:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dTcg4nnP3Q8OPOldUBNlJ77tCd6O60oSXI5JUaJbrOw=;
        b=eW1MZxI1OmRUonS9v1rnZyRZSTC93O+t4454bYQxxN7sTvn0gzcyFi6nR0qXvK+4i4
         ZkvHDpSMKZdH0IBFm9GsdJJkj+iDsEKWm5Xf/0sD2bDbWvHj+sIVH7sSu7kpTC2CY72U
         acruMO4FPGAcQz5J7GuxKRVt/F5ICDOn9khtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dTcg4nnP3Q8OPOldUBNlJ77tCd6O60oSXI5JUaJbrOw=;
        b=r+3YqZCKxSQJCgerC6vpQ7dXWBYuz/Ia1WFmLP1wqz8VkpZjM054icHCLKGHV3BAx1
         zRytvmV10YMSVNE9Kv04zb40kuDdmKD7xZPkNRaDuBUq3U7SLlRH6NTvhm4f4O51LXsG
         YWxzzZuKsqsZmbLWPPQJzoC2EfldAmvQr4CbEw3Ss/U8TWUeGQMN4858/HjEJah6GpWd
         8l/kNXeyjNTu+geQ12s8I7Or3gOLhyB2OUaXeqUKUUjSPwrnrZUHo7kUDu2gZvo7askD
         54VTPqphM4PTAWgse6BF9dmDRdXjJm/CIjgxsfkxX1IaMoI/ItxGpnWpJD57sVJqv1lx
         tEfQ==
X-Gm-Message-State: AOAM532X1SmXdjDen1+TyQjAyR8CmzuB5VZTIZnoTiacKL2V1I6ZuVzP
        MEUBJZC2xqkdHTa0SeWsvh2gYQ==
X-Google-Smtp-Source: ABdhPJxZPJROdmRol0REI+7u9He1qjFMzOPLeVcePBcrcnWgEUcZVclthczh6pTD+jqh26sdf0mjdg==
X-Received: by 2002:a17:90b:1c8f:: with SMTP id oo15mr8220645pjb.87.1634835800642;
        Thu, 21 Oct 2021 10:03:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id pc3sm6654862pjb.2.2021.10.21.10.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 10:03:20 -0700 (PDT)
Date:   Thu, 21 Oct 2021 10:03:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] nouveau/svm: Use kvcalloc() instead of kvzalloc()
Message-ID: <202110211002.CB975695@keescook>
References: <20210928222513.GA294575@embeddedor>
 <CACO55tsD98dNzw8fP=CiKLsdbnn2Vg78+wTRM90kutHtv1RZ5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACO55tsD98dNzw8fP=CiKLsdbnn2Vg78+wTRM90kutHtv1RZ5A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 05:28:47AM +0200, Karol Herbst wrote:
> Lack of documentation inside Linux here is a bit annoying, but do I
> understand it correctly, that the main (and probably only) difference
> is that kvcalloc checks whether the multiplication overflows and
> returns NULL in this case?

That's correct. :)

> On Wed, Sep 29, 2021 at 12:21 AM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> > Use 2-factor argument form kvcalloc() instead of kvzalloc().
> >
> > Link: https://github.com/KSPP/linux/issues/162
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

> > ---
> >  drivers/gpu/drm/nouveau/nouveau_svm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
> > index b0c3422cb01f..1a896a24288a 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> > @@ -992,7 +992,7 @@ nouveau_svm_fault_buffer_ctor(struct nouveau_svm *svm, s32 oclass, int id)
> >         if (ret)
> >                 return ret;
> >
> > -       buffer->fault = kvzalloc(sizeof(*buffer->fault) * buffer->entries, GFP_KERNEL);
> > +       buffer->fault = kvcalloc(sizeof(*buffer->fault), buffer->entries, GFP_KERNEL);
> >         if (!buffer->fault)
> >                 return -ENOMEM;
> >
> > --
> > 2.27.0
> >
> 

-- 
Kees Cook
