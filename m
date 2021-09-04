Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02004009D3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 06:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhIDEr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 00:47:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29508 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229697AbhIDEr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 00:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630730814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JjvuHK+BZictdhPGYezlZpUv4ww/LD4eYVVCYSW7gxc=;
        b=drwmKMvXFMrThJbqeav32VM8QS12kR8Pf00I6g+1kahN5COybRuP4MsGYZfW39uAd7rmc8
        xudhdR5WzN78ugzZKtqrQ3xxiCKni7lZd0iQ+3GXo+ZKzzC2YkXaWoxdKJpfK7WL24CrBa
        ebabQx27kJO62iI3k+50s9IF7SK/C6g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-VB3DB3p3PMSEtaHtAlm6QA-1; Sat, 04 Sep 2021 00:46:53 -0400
X-MC-Unique: VB3DB3p3PMSEtaHtAlm6QA-1
Received: by mail-qv1-f72.google.com with SMTP id l3-20020a056214104300b00366988901acso3166772qvr.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 21:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JjvuHK+BZictdhPGYezlZpUv4ww/LD4eYVVCYSW7gxc=;
        b=SzrDOgSIqUwER8KlA265u6DCMWsrJF9Q21l2QoH/YWhcqIs5aF11YdSHcUcDwb3HXM
         2c/mmwkI1ExcMGetVGS7gd0ExiYgTivHsj/zxCRtDIwv6wV1qGrXMOjiMfMTjOHC3G/W
         OxxsXqvtX40ZfrRtBb+RA6M97HUpKCVYkR26iUyxgmQ9TjwegW6s2pOry7QEjYX7+Pxn
         TkyG9uOSGZfE6P54dFVMbtvlcAyg9tZSkFt+3S5qU5gHDMfjkUtKIPM5Tlj6+sXk2zC/
         LMXO7p6twzJGnGaII/tSOWBaBFtIqUw0wh8vuZf2dn/UBVSZ189e14QDcm5p2+GtesXC
         YDTw==
X-Gm-Message-State: AOAM531OKLTFlu4pE5kw+3crW/+aMl6AeCmRHC2BqgZC+JiT0gAuxRsC
        wMEdO+6nEQBTI2uQ2YEfKJRJzTPsfPabmZNwC5sfvRDiRm6ryAN5KK3vyy8IzV2kVF6xu3Fe+8N
        qtUqw3aL8PUPf6iiKwK+sXrXr
X-Received: by 2002:a0c:ac4a:: with SMTP id m10mr2160234qvb.37.1630730813034;
        Fri, 03 Sep 2021 21:46:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7vY2j5yXZ7Dyyizvp53Rb/7Mb7S0+jamksRSmZvAONhOD/PEzzBjIj5iNBebKuJU4fFSwxw==
X-Received: by 2002:a0c:ac4a:: with SMTP id m10mr2160218qvb.37.1630730812815;
        Fri, 03 Sep 2021 21:46:52 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id x2sm943187qtr.6.2021.09.03.21.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 21:46:52 -0700 (PDT)
Date:   Fri, 3 Sep 2021 21:46:49 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        Andy Lavr <andy.lavr@gmail.com>
Subject: Re: [PATCH v3 0/2] objtool: altinstructions fix and cleanup
Message-ID: <20210904044649.nfknj5ukciim2au7@treble>
References: <20210822225037.54620-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210822225037.54620-1-joe.lawrence@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 06:50:35PM -0400, Joe Lawrence wrote:
> This version won't eat your memory and swap when building the entire
> kernel.  Apologies to Andy who discovered this over the weekend.
> 
> Tested full build and boot w/o problem.  The vmlinux sections, relocs,
> size, etc. all appear to be the same before and after this set.
> External tooling (kpatch-build) is happy, too.
> 
> v3:
> - fix bug introduced in arch_decode_instruction() [andy]
> 
> v2:
> - drop the sec->len update from the first patch [josh]
> - rip out sec->len as suggested [josh]
> 
> 
> Joe Lawrence (2):
>   objtool: make .altinstructions section entry size consistent
>   objtool: remove redundant len value from struct section

Thanks! Queueing up for testing.

-- 
Josh

