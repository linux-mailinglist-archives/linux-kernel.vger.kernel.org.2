Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2309C35EBA3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 06:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhDNECq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 00:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhDNECo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 00:02:44 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26020C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 21:02:22 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id j7so14526543qtx.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 21:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=POVwkCrg6yix+UmIZ+YtP6huYIADITFECEn16EjiHKI=;
        b=m+Gr+O/rIbQNOpN9GP+Y//FW4roiSNrON74CR2WbHFdtFsJzBTakulrFEOhMwJd4gT
         /8N7Gok3/qye41FOoznjdURNoKawLMKUgHK1SvSs2IfLzVxyILDTk3Y5C8OOHWmIvWPy
         r5uwGzWeU/oyoTFuwTD+AGYRAnifox62W0RaIrMtveDCkIfpYDE9vSmYxthHrbM+af3P
         XCvIdJ12V3EO9JDzdg1W1R6hWbWmqBIKAYhywmT/NVHUR1N7iAw0VVVLVuXv9N+sT8y/
         olUEbETH35TYNM0rQRauStSiqsTERkpWxqjoMHWVfd20PblGaXiNszWf+rY26PJbwU13
         ocfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=POVwkCrg6yix+UmIZ+YtP6huYIADITFECEn16EjiHKI=;
        b=q9qTnrMu0szGSPdJPpGtIFXSwjoKHvuTA2r+KBqG1BHoBvBth6hWfFuZdPjo2gnqwT
         iVzuvjzD1+Hz6rDifsUTpJeoFU5bTUThnGlFeRtN1ZH6VXz5beiOdISV34/KcZYqLY1a
         oKsqQkNlm1fpL3uhQ1gG30qYWdNenY80RDpsw6srz/1a8wUUWL4T6AYqK5Gu0TU7k0t0
         Ij64YAeUOvzPnIyl0xke/11gz6t86lv42FSF94fFyXy2IDbbXNxDanYCMZAd7DfaF178
         nQBuaQRJmPBO9SE0gEEHf5W2sZAQQUhv/Szat0fSzgIgN7d0scQmQb190oMgF9kTS/yY
         LzYg==
X-Gm-Message-State: AOAM530Xgw3pVTBIXqJ36pwVxmhzOJPmScfXVukhFZCF9OFaWzSRrz+i
        waaVNuFQ6oBjfmqjZ/f996U=
X-Google-Smtp-Source: ABdhPJw7+oho2tIdly9x+CNsOmb1yUSLoNxEA949gbbvAWqfCWgYNojOQ2J7Qy+xdSyWxbzUqD+Nkg==
X-Received: by 2002:a05:622a:454:: with SMTP id o20mr33104235qtx.292.1618372941326;
        Tue, 13 Apr 2021 21:02:21 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com ([2804:14c:482:7b04::1000])
        by smtp.gmail.com with ESMTPSA id n143sm4176295qke.45.2021.04.13.21.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 21:02:20 -0700 (PDT)
Message-ID: <fd20f4fae3d4bc1de0e62a25cead4db00bdd8dbd.camel@gmail.com>
Subject: Re: [PATCH v2 1/1] powerpc/iommu: Enable remaining IOMMU Pagesizes
 present in LoPAR
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, brking@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 14 Apr 2021 01:02:16 -0300
In-Reply-To: <20210412222143.GO26583@gate.crashing.org>
References: <20210407195613.131140-1-leobras.c@gmail.com>
         <87im4xe3pk.fsf@mpe.ellerman.id.au>
         <8e1ce7e9-415b-92ea-0437-a4331ed3c7f9@ozlabs.ru>
         <87ft01du50.fsf@mpe.ellerman.id.au>
         <21407a96-5b20-3fae-f1c8-895973b655ef@ozlabs.ru>
         <20210412222143.GO26583@gate.crashing.org>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-04-12 at 17:21 -0500, Segher Boessenkool wrote:
> On Fri, Apr 09, 2021 at 02:36:16PM +1000, Alexey Kardashevskiy wrote:
> > On 08/04/2021 19:04, Michael Ellerman wrote:
> > > > > > +#define QUERY_DDW_PGSIZE_4K	0x01
> > > > > > +#define QUERY_DDW_PGSIZE_64K	0x02
> > > > > > +#define QUERY_DDW_PGSIZE_16M	0x04
> > > > > > +#define QUERY_DDW_PGSIZE_32M	0x08
> > > > > > +#define QUERY_DDW_PGSIZE_64M	0x10
> > > > > > +#define QUERY_DDW_PGSIZE_128M	0x20
> > > > > > +#define QUERY_DDW_PGSIZE_256M	0x40
> > > > > > +#define QUERY_DDW_PGSIZE_16G	0x80
> > > > > 
> > > > > I'm not sure the #defines really gain us much vs just putting the
> > > > > literal values in the array below?
> > > > 
> > > > Then someone says "uuuuu magic values" :) I do not mind either way. 
> > > > Thanks,
> > > 
> > > Yeah that's true. But #defining them doesn't make them less magic, if
> > > you only use them in one place :)
> > 
> > Defining them with "QUERY_DDW" in the names kinda tells where they are 
> > from. Can also grep QEMU using these to see how the other side handles 
> > it. Dunno.
> 
> And *not* defining anything reduces the mental load a lot.  You can add
> a comment at the single spot you use them, explaining what this is, in a
> much better way!
> 
> Comments are *good*.
> 
> 
> Segher

Thanks for the feedback Alexey, Michael and Segher!

I have sent a v3 for this patch. 
http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20210408201915.174217-1-leobras.c@gmail.com/

Please let me know of your feedback in it.

Best regards,
Leonardo Bras

