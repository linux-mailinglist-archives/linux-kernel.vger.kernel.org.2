Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C4B35754D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 21:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355802AbhDGT6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 15:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhDGT6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 15:58:42 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF84C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 12:58:32 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id x11so20017513qkp.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 12:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=6fZ/ViiD+pHeXtQLFjb/Z7oHK2Q9bzwQJTyo6w74m6I=;
        b=oF0cJJlib378/ESJnMtKadOGiybdFVACJjzQfsNJalMkV4wHfu79umMG3ZsEGQ/zxw
         MSaGgy3Zmvj0ydbPI7/T3XsBqAP8y1etoI75nRNhBb5VL2TVNgbkhUusskyJ/BYql5lF
         xhVlI94jTfPARboVGM0L7+fdVxwXIR9L7ospIDPPdHFHIR3hLKlTwZRgACKqiake75YT
         B/xg/kS6qqkyvBhVxylHQOlr+5mu1WsttXrl0OdaNnIFTrlj6qV/kTrI7XaidLVcOUVc
         Xoy/jr7EWAIOkFmSib2A/ofJ1JQJ3XZ+BOGvfA2anjLQ/H+3+J8bfSuc1hWcVjmS2jdS
         EhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=6fZ/ViiD+pHeXtQLFjb/Z7oHK2Q9bzwQJTyo6w74m6I=;
        b=O0fNh1FVG+B8ZDfoUYPyKjjEws8a78CHtXWN9O9Eh3v+t91znJ7F8/exyZl2XxUVDE
         WIakZGTSlTpy2jrY4xfcbeyh8SqwG07HfJqHI/aWkLpSes15/36+7z2Q5JXazPT+x3DA
         IzraLRcoetVR5+4mSSMtJfpnaBqcC2NgOE5q/y/Fgeef16M34mLVnFh7ber9ZcPbX1vM
         dSQJHs7xejt7c2A1Ah088FdaIqD475JuRH6PrmlQEEY6xi/9MR2xY/wr200HB1wADvgp
         mQUmkFyTtEhmQDVUTaiZQerSJDrZashhdTIEFvzrWZ5FLrZ1Iw89diISDoHI7Hh0yM9n
         4mqQ==
X-Gm-Message-State: AOAM533flsP8uGCjUTF2oQl1wGEdGY3M7D/YmxyZdZ1WpwEGmOQZXOYL
        agjJozx7F/6tLuAEbZF/bELDpSgMars=
X-Google-Smtp-Source: ABdhPJyIv9lgQmEv8xFsxtKio+OVUdiYh2xUaxUzN9jf15s0SD4mozHeNa0kXvnguVRWV2ozvXVqtQ==
X-Received: by 2002:ae9:e518:: with SMTP id w24mr4878314qkf.78.1617825512109;
        Wed, 07 Apr 2021 12:58:32 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com ([2804:14c:482:7b04::1000])
        by smtp.gmail.com with ESMTPSA id j10sm17781787qti.94.2021.04.07.12.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 12:58:31 -0700 (PDT)
Message-ID: <1af8c4ed38981332bcd8ffcf003d70c4a6f766ef.camel@gmail.com>
Subject: Re: [PATCH 1/1] powerpc/iommu: Enable remaining IOMMU Pagesizes
 present in LoPAR
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Joel Stanley <joel@jms.id.au>, brking@linux.vnet.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 07 Apr 2021 16:58:27 -0300
In-Reply-To: <2088f84c-08fb-fecc-f5d4-5735357dc296@ozlabs.ru>
References: <20210322190943.715368-1-leobras.c@gmail.com>
         <2088f84c-08fb-fecc-f5d4-5735357dc296@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexey,

On Tue, 2021-03-23 at 18:41 +1100, Alexey Kardashevskiy wrote:
[...]
> > +#define IOMMU_PAGE_SHIFT_16G	34
> > +#define IOMMU_PAGE_SHIFT_256M	28
> > +#define IOMMU_PAGE_SHIFT_128M	27
> > +#define IOMMU_PAGE_SHIFT_64M	26
> > +#define IOMMU_PAGE_SHIFT_32M	25
> > +#define IOMMU_PAGE_SHIFT_16M	24
> > +#define IOMMU_PAGE_SHIFT_64K	16
> 
> 
> These are not very descriptive, these are just normal shifts, could be 
> as simple as __builtin_ctz(SZ_4K) (gcc will optimize this) and so on.
> 
> OTOH the PAPR page sizes need macros as they are the ones which are 
> weird and screaming for macros.
> 
> I'd steal/rework spapr_page_mask_to_query_mask() from QEMU. Thanks,
> 

Thanks for this feedback!
I just sent a v2 applying your suggestions.

Best regards,
Leonardo Bras


