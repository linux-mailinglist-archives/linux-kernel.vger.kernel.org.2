Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC78936FE42
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 18:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhD3QG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 12:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhD3QG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 12:06:56 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63FAC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 09:06:06 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id z1so4813432qvo.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 09:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=8hYtxi64V1mhi8QsQ5htTW8jmecZVLPmLCwquHL22Tw=;
        b=E6nwfFAI3gwoxb+PvQ/8U+QW42DZNzp+xZ1z2HZG17eqf/r6cFwnnBU2lTtuncVyQ+
         lUHe8yMRb1MPusGrB4c3WdeuPxTzZpvdecnC1HYW4jEfcC6g+BcXbZU6oWHqWpk5n1ps
         Mu3bx+9JCD+6mt9T5omedGO4RVKVlM2C8w855tfp9IWY5/tE6ZzNY5XTsnLogB9fHej6
         0alH6W5QSSxFbeTuoTajz7wvgoDFSYgfI9Mi8joltxM0SquHI7+/PV1pIwJ3aROw+sy4
         V4xnTHqQwkJX4vTBWM6o+87VISGAEazEc9u2WRDxvFDwM6HbkpEahjh1X0rBx2JkUDqJ
         KIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=8hYtxi64V1mhi8QsQ5htTW8jmecZVLPmLCwquHL22Tw=;
        b=OEl3wgPWCWo+TF8CXNR7ZdMZM7PSfmiXqoTJPsQEa85PkMQXAzrA6OAfLnYxl2uPDv
         ettLxdtE99Y9D9BVLW0zm9y2LZQ4VywrquiPY9OvtyD+AkN3c80QVBfWKEwMGRqn+4Xq
         d15h50SFJ0AYiIkp/ayVv6MnvB4vAGa+zApbSigKQPsNlckaPZqIi207tJdk9Lw97xxT
         IJHgAvNSC/C5EtyWr4ulhlk7Tl8ujdNrRUE6bwXyZwrahjY12jMqxbNg7eG9OIIYshTe
         qO29KyNyLp9YcLwQX/4SYSEE+ja5f6W6HKjliGojAkvmfw7hKK+cq5s5UX97NrLB0Ckg
         BAsw==
X-Gm-Message-State: AOAM532my0amk+KvjuWTzE8sfOhBzt15zHAnH83lBCeCYZQXxlbHESnK
        YrnnlTsbE7l8czxL6R6Bi/Q=
X-Google-Smtp-Source: ABdhPJxHSs8owWgK8zrhVpSlxpYzoLYqNVvITNk1JUZpDh85XHpvYAfflo+pnnsij29Aifc8MwFheA==
X-Received: by 2002:ad4:4c49:: with SMTP id cs9mr6018203qvb.43.1619798766073;
        Fri, 30 Apr 2021 09:06:06 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com ([2804:14c:482:7b04::1001])
        by smtp.gmail.com with ESMTPSA id e28sm2672882qtg.24.2021.04.30.09.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 09:06:05 -0700 (PDT)
Message-ID: <63235a71f8bf8f3a44815b7bb6241d3a822e1be7.camel@gmail.com>
Subject: Re: [PATCH v3 06/11] powerpc/pseries/iommu: Add
 ddw_property_create() and refactor enable_ddw()
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Fri, 30 Apr 2021 13:05:59 -0300
In-Reply-To: <e214f457-fcf0-c9ff-4574-93ed20298119@ozlabs.ru>
References: <20210422070721.463912-1-leobras.c@gmail.com>
         <20210422070721.463912-7-leobras.c@gmail.com>
         <e214f457-fcf0-c9ff-4574-93ed20298119@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-04-23 at 19:04 +1000, Alexey Kardashevskiy wrote:
> 
> > +	win64->name = kstrdup(propname, GFP_KERNEL);
> > +	ddwprop = kzalloc(sizeof(*ddwprop), GFP_KERNEL);
> > +	win64->value = ddwprop;
> > +	win64->length = sizeof(*ddwprop);
> > +	if (!win64->name || !win64->value) {
> > +		kfree(win64);
> > +		kfree(win64->name);
> > +		kfree(win64->value);
> 
> 
> Wrong order.
> 

Right! Sorry about that. 
Changed for next version!

> > 
> > 
> > +out_del_win:
> 
> 
> (I would not bother but since I am commenting on the patch)
> 
> nit: the new name is not that much better than the old 
> "out_clear_window:" ("out_remove_win" would be a bit better) and it does 
> make reviewing a little bit harder. Thanks,

Replaced by out_remove_win
Thanks!




