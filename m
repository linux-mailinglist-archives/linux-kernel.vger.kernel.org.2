Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED713EE67D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 08:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbhHQGNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 02:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbhHQGNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 02:13:10 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72C0C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 23:12:37 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id x1so2854967qtw.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 23:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=G5q2kw4t+Ye13oI9DBMvvqvug6wc8CKiiXAR6p+W89I=;
        b=BBCXvOXw4li2gIL9kkbvJ5ZcdZ+itbeWzg1qIECAHIFLOfIX2XSQzcKwfXQTU/IqWt
         0btORgGye8PrIQUXPygvdchbdYCaQyo1Q4GcGhYSSzziVV8bTFIgxygtUDIcpe2aDVp4
         Ov2YFEmfPew8Zm21hM8gN6zOq6CR4/7HL5YLQuJcHgHM4TBgJSCHH3D6NtnqekbbjINL
         6TCJgs9NbqCw9HqgEa8hR4bHgGT7MSpU8rwwB+Gwu8dsD7lWtUre0X0uyZyzW4gI7gR0
         M6mjWK2nRH6HVtCKI9chJv5JQUDsjo2GIvvXVjANDGjxbPFQyV+cUAD/Eg6sWgk7wfkM
         8W0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=G5q2kw4t+Ye13oI9DBMvvqvug6wc8CKiiXAR6p+W89I=;
        b=f8Tra22WS8Y+UnFlqeXuClJ5rFTkaXHRV2CbZcLPxV7HZB+KMN29T7oaWqqNPMSO1G
         Y8cX9bga5m3RZ624cHcYHl8vU8fzsUbfb51lNFH02AwXUZ1tM7DBacvfbahlAinEhD9h
         DYpUFE26xTdPLMgDkUsueiQ28Cs+BNFo9CxIwT0tNAAsA2Kf3AH2o2nWZ70CUqLTuTF1
         XfD3m4uF2AmyIcaSbU0cxwFnHfas3s1LhSa8d5MEQitvjSZ1XySp7CGv3r1e0TYO3qQJ
         6mIzCPAHgPQWZev+nzK5vEqUvYo3WkSJMK3q/W2BlBeGUOIREVXnPIfgGZxCFGKSdza/
         bdxA==
X-Gm-Message-State: AOAM532+y0d60zhN7CLZUos6woXecUu0v9BhMQCrRtNQ9lmBc1pMd9CR
        Okm990i4YI4PAZDVDSoTxM8=
X-Google-Smtp-Source: ABdhPJyol1AUFCOLYakvjk8k/FnQSFqpYVx52TWd46ga3LUw/FtBCvvKbLt20uNE3CMvS+SRsEfk+Q==
X-Received: by 2002:a05:622a:612:: with SMTP id z18mr1635720qta.330.1629180756978;
        Mon, 16 Aug 2021 23:12:36 -0700 (PDT)
Received: from ?IPv6:2804:431:c7f0:30b2:5c9e:50:88f3:269a? ([2804:431:c7f0:30b2:5c9e:50:88f3:269a])
        by smtp.gmail.com with ESMTPSA id w6sm750513qkf.95.2021.08.16.23.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 23:12:36 -0700 (PDT)
Message-ID: <f9f7bcd75d534ebde7cc83c4138176da4680e30f.camel@gmail.com>
Subject: Re: [PATCH v5 08/11] powerpc/pseries/iommu: Update
 remove_dma_window() to accept property name
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        kernel test robot <lkp@intel.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Tue, 17 Aug 2021 03:12:38 -0300
In-Reply-To: <2653ee3e582ba181651e4842821e64d3323fa566.camel@gmail.com>
References: <20210716082755.428187-1-leobras.c@gmail.com>
         <20210716082755.428187-9-leobras.c@gmail.com>
         <8dbd08fb-375c-9f21-f8ab-bec163b157bf@linux.ibm.com>
         <2653ee3e582ba181651e4842821e64d3323fa566.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-08-17 at 02:59 -0300, Leonardo Brás wrote:
> Hello Fred, thanks for the feedback!
> 
> On Tue, 2021-07-20 at 19:51 +0200, Frederic Barrat wrote:
> > 
> > 
> > On 16/07/2021 10:27, Leonardo Bras wrote:
> > > Update remove_dma_window() so it can be used to remove DDW with a
> > > given
> > > property name.
> > > 
> > > This enables the creation of new property names for DDW, so we
> > > can
> > > have different usage for it, like indirect mapping.
> > > 
> > > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > > Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > ---
> > >   arch/powerpc/platforms/pseries/iommu.c | 21 +++++++++++--------
> > > --
> > >   1 file changed, 11 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/platforms/pseries/iommu.c
> > > b/arch/powerpc/platforms/pseries/iommu.c
> > > index 108c3dcca686..17c6f4706e76 100644
> > > --- a/arch/powerpc/platforms/pseries/iommu.c
> > > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > > @@ -830,31 +830,32 @@ static void remove_dma_window(struct
> > > device_node *np, u32 *ddw_avail,
> > >                         np, ret,
> > > ddw_avail[DDW_REMOVE_PE_DMA_WIN],
> > > liobn);
> > >   }
> > >   
> > > -static void remove_ddw(struct device_node *np, bool remove_prop)
> > > +static int remove_ddw(struct device_node *np, bool remove_prop,
> > > const char *win_name)
> > >   {
> > 
> > 
> > Why switch to returning an int? None of the callers check it.
> 
> IIRC, in a previous version it did make sense, which is not the case
> anymore. I will revert this.
> 
> Thanks!

Oh, sorry about that, it is in fact still needed:

It will make sense in patch v5 10/11:
On iommu_reconfig_notifier(), if (action == OF_RECONFIG_DETACH_NODE),
we need to remove a DDW if it exists.

As there may be different window names, it tests for DIRECT64_PROPNAME,
and if it's not found, it tests for DMA64_PROPNAME.

This approach will skip scanning for DMA64_PROPNAME if
DIRECT64_PROPNAME was found, as both may not exist in the same node.
But for this approach to work we need remove_ddw() to return error if
the property is not found.

Does it make sense? or should I just test for both?

Best regards,
Leonardo Bras



