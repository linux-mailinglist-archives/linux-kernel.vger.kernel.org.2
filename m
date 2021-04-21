Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F2D366BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241246AbhDUNHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:07:47 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:42601 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbhDUNFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:05:50 -0400
Received: by mail-oi1-f180.google.com with SMTP id n140so42300024oig.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 06:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LPKiX7VSpKxG540R9ms/jNFsPJZtAQrNlGGHbcOxTSI=;
        b=jSffUJpeauKbLhC2ECfRISXbvc+oYYie9Oi3six8a2r0bKWkxqHjK3yeCXChm5pyLm
         tN0AIFR29y8azS9QDvwwoxtmJRIhI4j++iC+m131v5r5cke4b1NUjHVUprxlSM/iEmhl
         SmSsIQxtj5+x3U9v4/kML+tNmGF0QxYuD3XKVNp9FNOSa45KVoB49r6LF9WPCtrOysMz
         hAzon9pjv5fD/1CCgWoJL7MLEy5eSAgKFnTH/e8kghXBodzSAA1941aLAFCW6oIWox1n
         Acgq8Z3nKh2pOkyGFedyK6tShXIJ9Dimv1rvLJ9cROtohebvaVLe1VBaPTVoOX0thzZF
         ihSA==
X-Gm-Message-State: AOAM530hRaMvExnKvkanI+lQeFIc2HIh6ICZpOAHR3GrZYa4ZTeMuSEr
        OhEhbS8Hp4s87YMu40qDwg==
X-Google-Smtp-Source: ABdhPJwyP7/9QRD3ytKxi6R6frhY1kfEtoATaqT4P7IyD2MGCsEKNPO9bM2VbVNReg5XjdxSiSXqWw==
X-Received: by 2002:aca:d693:: with SMTP id n141mr6609168oig.107.1619010316711;
        Wed, 21 Apr 2021 06:05:16 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a65sm438007oob.27.2021.04.21.06.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 06:05:15 -0700 (PDT)
Received: (nullmailer pid 984585 invoked by uid 1000);
        Wed, 21 Apr 2021 13:05:14 -0000
Date:   Wed, 21 Apr 2021 08:05:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] of: linux/of.h: fix kernel-doc warnings
Message-ID: <20210421130514.GA984119@robh.at.kernel.org>
References: <20210417061244.2262-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417061244.2262-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2021 23:12:44 -0700, Randy Dunlap wrote:
> Correct kernel-doc notation warnings:
> 
> ../include/linux/of.h:1211: warning: Function parameter or member 'output' not described in 'of_property_read_string_index'
> ../include/linux/of.h:1211: warning: Excess function parameter 'out_string' description in 'of_property_read_string_index'
> ../include/linux/of.h:1477: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Overlay support
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  include/linux/of.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks!
