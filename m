Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67610400CAF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 20:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237405AbhIDSqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 14:46:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43126 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237380AbhIDSqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 14:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630781135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XjthgrevUBZJ832z2lXXWto4HUwNpTuWMITMN6nK1VY=;
        b=FWhaJpqGbsXhHeZ9AMdkgee07Tf6CFLxWJPd6j8XdxOKAFoeDL3DG9tkTfsxLpREEtYlNN
        B4TQrclNA3uU35wM5o/DLRm/V7SM0ztswlpT+cpVkyoW8dhv2K0r4AcZcjATkqXtgmKt3+
        Y85DYrL+Ja4LAfJ1AJenAZgB4c++i9o=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-Vqa7qsqqM0WFxsPR47m3dA-1; Sat, 04 Sep 2021 14:45:34 -0400
X-MC-Unique: Vqa7qsqqM0WFxsPR47m3dA-1
Received: by mail-ot1-f70.google.com with SMTP id w35-20020a056830412300b0051bae474534so1460175ott.21
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 11:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XjthgrevUBZJ832z2lXXWto4HUwNpTuWMITMN6nK1VY=;
        b=aMhiTnijMrl20XPA1u5jLhjkgRo55UBHETX1SsgVV4W6uKtfg+Rnklo0LsAsQoIBZZ
         7Z2gQW8afHfn/9uQ4HRhGeld8AR+GlfeyZIgwhEZAhmjeic9EZ268crfxJO0lTpN4Sic
         gTbuFky9wR/bwa5fm1bm1bHXl/6bj5gEEQWhCltagUSRd3x43WbSToMDKH7vb8+4MjQf
         4mxqzh1WmrR9NNFUHT1bXI2Z8aL6txDkKoyjAiiR6qvM5Bcqh3N8B4HhSK6FS9/cdVIk
         V2i5ZiPpF4s70vRivQXpnO/jHVoWrlM+71A5+SSfPMrD9+Cd6F4yGprTqGQ1Qtn2BGIm
         2ilw==
X-Gm-Message-State: AOAM533uShsBN06qOPxNTws/EqEvip+7TBDH7Las+yQ4n3MHVnHuZley
        Jj9Ni8W0uB0ZqmbIsaDv9OYyNy/WaAt16p3C3i3uDvJKhVHmXdBUW/c2/0AyDaKU8CqLMbgQLvp
        xDfPlacqhtiQplROy0wymIE8x
X-Received: by 2002:a9d:7f07:: with SMTP id j7mr4457117otq.84.1630781133858;
        Sat, 04 Sep 2021 11:45:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwd+0Ndb1obwV/jkLARxO2aOSiCZgjjZqUYWuMzun/6W9DJNXLkpCgI9oURFGhqzgg3dVG8bw==
X-Received: by 2002:a9d:7f07:: with SMTP id j7mr4457104otq.84.1630781133660;
        Sat, 04 Sep 2021 11:45:33 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id c3sm598416oiy.30.2021.09.04.11.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 11:45:33 -0700 (PDT)
Date:   Sat, 4 Sep 2021 11:45:30 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/13] kbuild: store the objtool command in *.cmd files
Message-ID: <20210904184530.k6nwfesugx2su2hy@treble>
References: <20210831074004.3195284-1-masahiroy@kernel.org>
 <20210831074004.3195284-4-masahiroy@kernel.org>
 <20210904180434.qkdbs27i5f2vtoxv@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210904180434.qkdbs27i5f2vtoxv@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2021 at 11:04:37AM -0700, Josh Poimboeuf wrote:
> On Tue, Aug 31, 2021 at 04:39:54PM +0900, Masahiro Yamada wrote:
> > objtool_dep includes include/config/{ORC_UNWINDER,STACK_VALIDATION}
> > so that all the objects are rebuilt when any of CONFIG_ORC_UNWINDER
> > and CONFIG_STACK_VALIDATION is toggled.
> > 
> > As you can see in 'objtool_args', there are more CONFIG options
> > that affect the objtool command line.
> > 
> > Adding more and more include/config/* is ugly and unmaintainable.
> > 
> > Another issue is that non-standard objects are needlessly rebuilt.
> > Objects specified as OBJECT_FILES_NON_STANDARD is not processed by
> > objtool, but they are rebuilt anyway when CONFIG_ORC_UNWINDER or
> > CONFIG_STACK_VALIDATION is toggled. This is not a big deal, but
> > better to fix.
> > 
> > A cleaner and more precise fix is to include the objtool command in
> > *.cmd files so any command change is naturally detected by if_change.
> 
> Nice improvement, thanks!
> 
> s/CONFIG_ORC_UNWINDER/CONFIG_UNWINDER_ORC/g
> 
> And yes, this means the original ORC unwinder dependency didn't
> work:
> 
> > -objtool_dep = $(objtool_obj)					\
> > -	      $(wildcard include/config/ORC_UNWINDER		\
> > -			 include/config/STACK_VALIDATION)

With the typos fixed, and this dependency bug mentioned in the commit
log:

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

