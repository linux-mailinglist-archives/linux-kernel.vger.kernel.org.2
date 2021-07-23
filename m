Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0301F3D3B4A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 15:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbhGWM6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41483 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233365AbhGWM6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627047533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CNrCnNEi8YU3NjpLXktV8L2vGTneNrqBq6dOtm+we8Y=;
        b=Qy0B92iPgcK/7NmNJRybTWm1a/mREHNEqGztBeLYGrEmHmZPqs02aPcfcPFLcVcFPmnQlg
        6I/wQ8kAwhN65FhCrc6/NbXGKWZAx5Jb6vYC2L5Oq16MlwT0lO+kD/p897YCLNvHrrIXNd
        xiXCe3ZX63ioDFtGcCwsXcko0inBSxU=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597-hcCZl3VeOnSnrZA8GhJwzg-1; Fri, 23 Jul 2021 09:38:49 -0400
X-MC-Unique: hcCZl3VeOnSnrZA8GhJwzg-1
Received: by mail-io1-f70.google.com with SMTP id z21-20020a5d84d50000b02904e00bb129f0so1671959ior.18
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 06:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CNrCnNEi8YU3NjpLXktV8L2vGTneNrqBq6dOtm+we8Y=;
        b=jOCtGC8FfcxJaDFDM+RwG4j7TgzJCnxKnzoTEQXqgwAq9Hy6loeh5P9pOQuPmZGSN+
         uzymZzYCJk0OxS44BskMEH5jJY5H3bZjICk/K/vRVz+3Hftgl/q4BXe9y+bOFRfpFEv8
         KBFdFEkIhoxTKcNdBLFFjYHSsnLeI6ONSRsS5wIwhGBJARiDeKjdZhY7ddQMIRMF8qxg
         zLRy/TEkApDnD1Xw7rwAP+zHTuv6ihNQzOSnNyeQtu/uSuxGkkCqkLXjIl1yjGnbd5Jp
         EJrE1RTk6NPYtDf6eJuC0JxtBQCHWwJQsURcvz6E5UWq3u6VH5yW8bC5RNgpCEIwiygr
         ir5A==
X-Gm-Message-State: AOAM5323BTco6Wh5+Tks5AJ42/ymJuNXxbVebn9JrKvHxl+bXABi3R0c
        +NnOCE7sByPU2OPm8uokrF3nuHJX2g5lAki4ii5gBMIQm0t1bdGSo/Z9f8cU8U1XVBCvQ3sSuMw
        I1FNnPGQ0t8Y+wlavfLCSP6fV
X-Received: by 2002:a02:cd0a:: with SMTP id g10mr4243225jaq.18.1627047529244;
        Fri, 23 Jul 2021 06:38:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwek83fSduz7V8CLkiqtAngLuJBjs5iDFj4SG3DhS5HRyk7g8pS0JfJqY3+Yo29wQu7Wx0j/g==
X-Received: by 2002:a02:cd0a:: with SMTP id g10mr4243213jaq.18.1627047529098;
        Fri, 23 Jul 2021 06:38:49 -0700 (PDT)
Received: from gator ([204.16.59.133])
        by smtp.gmail.com with ESMTPSA id p8sm11466441iol.49.2021.07.23.06.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 06:38:48 -0700 (PDT)
Date:   Fri, 23 Jul 2021 15:38:45 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Srivatsa Vaddagiri <vatsa@codeaurora.org>,
        Shanker R Donthineni <sdonthineni@nvidia.com>,
        will@kernel.org
Subject: Re: [PATCH 10/16] KVM: arm64: Add some documentation for the MMIO
 guard feature
Message-ID: <20210723133845.jwp3ljkfnupgv36i@gator>
References: <20210715163159.1480168-1-maz@kernel.org>
 <20210715163159.1480168-11-maz@kernel.org>
 <20210721211743.hb2cxghhwl2y22yh@gator>
 <60d8e9e95ee4640cf3b457c53cb4cc7a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60d8e9e95ee4640cf3b457c53cb4cc7a@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 02:30:13PM +0100, Marc Zyngier wrote:
...
> > > +
> > > +    ==============    ========
> > > ======================================
> > > +    Function ID:      (uint32)    0xC6000004
> > > +    Arguments:        (uint64)    The base of the PG-sized IPA range
> > > +                                  that is allowed to be accessed as
> > > +				  MMIO. Must aligned to the PG size (r1)
> > 
> > align
> 
> Hmmm. Ugly mix of tab and spaces. I have no idea what the norm
> is here, so I'll just put spaces. I'm sure someone will let me
> know if I'm wrong! ;-)

Actually, my comment wasn't regarding the alignment of the text. I was
commenting that we should change 'aligned' to 'align' in the text. (Sorry,
that was indeed ambiguous.) Hmm, it might be better to just add 'be', i.e.
'be aligned'.

I'm not sure what to do about the tab/space mixing, but keeping it
consistent is good enough for me.

Thanks,
drew

