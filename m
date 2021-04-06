Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BCE355166
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 12:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245263AbhDFK6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 06:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26500 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245259AbhDFK6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 06:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617706687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aoo4T5OcYVMmIH5rVBArOHDK8SbcOJSOJ1qUYgR/5T8=;
        b=AvnKlSPrT2rbxeIr7hzHPgE1FIFEaIEmuwVwtjzpFDSS7c89SEXHhCcM585T6XgLiWkA93
        MmgNkWfTtvkJispz9eMSEDyNIh47YNDIPqCTeTWfYl3YP0hIGUH8S7xlwgn6Dbn5T+ykvh
        0oqFpWqa9s2D1y17v8/Tv0wqSwWiJnQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-Sl4z2ceSMLai-INDRV5ebA-1; Tue, 06 Apr 2021 06:58:05 -0400
X-MC-Unique: Sl4z2ceSMLai-INDRV5ebA-1
Received: by mail-pl1-f198.google.com with SMTP id m4so797308plx.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 03:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aoo4T5OcYVMmIH5rVBArOHDK8SbcOJSOJ1qUYgR/5T8=;
        b=qJFzsbKp0nrgiye4SXn2TK3vnKFbLigOKzAu3MnP8eXJky+bEG/EpUlJH2e846Roe1
         Vkh3n8672AhQHgKdCnoVB8Zfy/N4gmqFZxbGaMJAp2jUB4rO2dWSj/nSBOu1+hdJdplK
         SnHIzl6G2h+aXpHEP1APHFo+WvBnO1PMRdDdjFgtH8CZ9i/IWT6Rn2GHU0y9yma+dyFd
         XuO7PKlcfg4SCNffa+XS8xOkGr0AYACz+QNnn3gZZR5Plsx5fLqPosX/SBN5G1W6m9oi
         fEh8W05b2nbhwIcY5MITNMbHb28KrVF8E3ocAGGRUFJGPY3EZcjY52g91N0EJailV+VG
         5ppw==
X-Gm-Message-State: AOAM530HTQ3Mb7G9kqeY2TG7Opb3/QbZK73WQ6MCsYBvlkiSLhbxTnhi
        qxjw1VxiWQEd9SgYrKmFgEnNl0A/TMliuEbdWO58Ef3j3VOgOqv08TIA7rF4ASpifojfKQelmpu
        7uvX1CDr2b+YBcpEC7MiowUOB
X-Received: by 2002:a65:6643:: with SMTP id z3mr1474566pgv.387.1617706684311;
        Tue, 06 Apr 2021 03:58:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJya/JAeXp9rFtQDgDn8HW+qGdQS73sx5LoNGY80ZZXhkPwr1QTS3aX8lbQdzfQ4srYGA95yMQ==
X-Received: by 2002:a65:6643:: with SMTP id z3mr1474553pgv.387.1617706684057;
        Tue, 06 Apr 2021 03:58:04 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c6sm19868861pfj.99.2021.04.06.03.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 03:58:03 -0700 (PDT)
Date:   Tue, 6 Apr 2021 18:57:53 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Helge Deller <deller@gmx.de>
Cc:     Gao Xiang <xiang@kernel.org>, linux-parisc@vger.kernel.org,
        Liam Beguin <liambeguin@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parisc: avoid a warning on u8 cast for cmpxchg on u8
 pointers
Message-ID: <20210406105753.GA550515@xiangao.remote.csb>
References: <20210406045929.30331-1-xiang@kernel.org>
 <ee2016b1-926e-93b1-ba92-d5f4975f06c9@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee2016b1-926e-93b1-ba92-d5f4975f06c9@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 12:08:55PM +0200, Helge Deller wrote:
> On 4/6/21 6:59 AM, Gao Xiang wrote:
> > From: Gao Xiang <hsiangkao@redhat.com>
> > 
> > commit b344d6a83d01 ("parisc: add support for cmpxchg on u8 pointers")
> > can generate a sparse warningi ("cast truncates bits from constant
> > value"), which has been reported several times [1] [2] [3].
> > 
> > The original code worked as expected, but anyway, let silence such
> > sparse warning as what others did [4].
> > 
> > [1] https://lore.kernel.org/r/202104061220.nRMBwCXw-lkp@intel.com
> > [2] https://lore.kernel.org/r/202012291914.T5Agcn99-lkp@intel.com
> > [3] https://lore.kernel.org/r/202008210829.KVwn7Xeh%25lkp@intel.com
> > [4] https://lore.kernel.org/r/20210315131512.133720-2-jacopo+renesas@jmondi.org
> > Cc: Liam Beguin <liambeguin@gmail.com>
> > Cc: Helge Deller <deller@gmx.de>
> > Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> 
> applied to the parisc for-next git tree.
> (I fixed up the typo above too)

Thanks all! :)

Thanks,
Gao Xiang

> 
> Thanks!
> Helge
> 
> > ---
> >   arch/parisc/include/asm/cmpxchg.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/parisc/include/asm/cmpxchg.h b/arch/parisc/include/asm/cmpxchg.h
> > index cf5ee9b0b393..84ee232278a6 100644
> > --- a/arch/parisc/include/asm/cmpxchg.h
> > +++ b/arch/parisc/include/asm/cmpxchg.h
> > @@ -72,7 +72,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
> >   #endif
> >   	case 4: return __cmpxchg_u32((unsigned int *)ptr,
> >   				     (unsigned int)old, (unsigned int)new_);
> > -	case 1: return __cmpxchg_u8((u8 *)ptr, (u8)old, (u8)new_);
> > +	case 1: return __cmpxchg_u8((u8 *)ptr, old & 0xff, new_ & 0xff);
> >   	}
> >   	__cmpxchg_called_with_bad_pointer();
> >   	return old;
> > 
> 

