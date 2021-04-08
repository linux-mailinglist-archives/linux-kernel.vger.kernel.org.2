Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCF7357CA4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhDHGf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhDHGf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:35:57 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA90C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 23:35:46 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id i9so190217qvo.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 23:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=jPyP0x12pCFmur4fSxPFpC42drbEe8/klrnOBPcUQ9Y=;
        b=TonDbdLoGuzCQYW6VZPTUp4OKlzW+XMz9OnV2DBOK+ri1XyokkDFLmSh+3JEmfT9Lo
         Y4JXAY9xGjvG3szjF+VAdPnPIfCkB4hSq4t2BVi7Dhhy0M7WpOAhdwHqQOr168kDWfAd
         ZehzAz+3nsryGNXn1RulD2P4cXZZbyjF5S90bR8YSS5DaZVOjpS47bywfDHS3Lu+gt3h
         7r05v2hL8vtk08TZCBCfzPkSloSd/cCwI0WmCkX+961kNewZw6McDCSgHazQDA1o3tMj
         j/8tjM580Wl8atMCytj61fTcNYRGYb+fUMaUdE7QN+/XZ0Bdoc9yqqeuuT5n+vNZPNnc
         2jIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=jPyP0x12pCFmur4fSxPFpC42drbEe8/klrnOBPcUQ9Y=;
        b=iKyizQLMVIuPZNfdUs7zaEoRuBhE9ePITM3Xh/1tYksTWx0lN0NBWXo7WsSlW101A5
         rr4HRbYm1kltBr7DduKbEDx8xxTFkA3cQn99VUrr4nMTRHLr1jNl+aTzVXPbcvgK6E73
         TE5gsnSZEAgV/9lNUkoaNAXOMiL9DTGQhSEKDCunj+mvZ6dzKjubWAdigwAWsN5zTLUN
         yfs0OL8VKBdz3XQlfJwVX4XumOs4fvhv1oPQmW5OHUAiuPKFaM5khnzpmBfQHhHbf7Vt
         8qHbEM7y+appgqIRz6LKKSnBQ+satApdy9MoZnT3cMzwU0hJWzPlmoK4cPN058rekM/T
         Tphw==
X-Gm-Message-State: AOAM530bWygsZlV8SnbrpFxZIkN9JnAMTyauu5sRqhYeDIWtf9q7Ccit
        9WRJqw/0kqs28/jViD6ZzQA=
X-Google-Smtp-Source: ABdhPJyC3Sl6smpCYyyOsTthueVG+CAPYVjsM+e2Fz7WoIrMzYOS7cF9nwkCpaxn/6a2UgiGCT8zgw==
X-Received: by 2002:a0c:a9c5:: with SMTP id c5mr7391386qvb.6.1617863746094;
        Wed, 07 Apr 2021 23:35:46 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com ([2804:14c:482:7b04::1000])
        by smtp.gmail.com with ESMTPSA id 14sm292213qkf.119.2021.04.07.23.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 23:35:45 -0700 (PDT)
Message-ID: <eed000bfa26686f616b91a7ac5a54ff8e3f2cbd0.camel@gmail.com>
Subject: Re: [PATCH v2 1/1] powerpc/iommu: Enable remaining IOMMU Pagesizes
 present in LoPAR
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>, brking@linux.vnet.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Apr 2021 03:35:41 -0300
In-Reply-To: <942acb9b23d87594d0b758cc0daf713be836f8e6.camel@gmail.com>
References: <20210407195613.131140-1-leobras.c@gmail.com>
         <87im4xe3pk.fsf@mpe.ellerman.id.au>
         <942acb9b23d87594d0b758cc0daf713be836f8e6.camel@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-04-08 at 03:20 -0300, Leonardo Bras wrote:
> > > +#define QUERY_DDW_PGSIZE_4K	0x01
> > > +#define QUERY_DDW_PGSIZE_64K	0x02
> > > +#define QUERY_DDW_PGSIZE_16M	0x04
> > > +#define QUERY_DDW_PGSIZE_32M	0x08
> > > +#define QUERY_DDW_PGSIZE_64M	0x10
> > > +#define QUERY_DDW_PGSIZE_128M	0x20
> > > +#define QUERY_DDW_PGSIZE_256M	0x40
> > > +#define QUERY_DDW_PGSIZE_16G	0x80
> > 
> > I'm not sure the #defines really gain us much vs just putting the
> > literal values in the array below?
> 
> My v1 did not use the define approach, what do you think of that?
> http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20210322190943.715368-1-leobras.c@gmail.com/
> 
> 
(of course, it would be that without the pageshift defines also, using
the __builtin_ctz() approach suggested by Alexey.)

