Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36083C8B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 21:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240177AbhGNT1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 15:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhGNT1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 15:27:48 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7325AC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 12:24:56 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id a2so3540480pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 12:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=N+JKQJqwCl0d6bUKiCh0PgpItsPMqUhVfYdVbCoV6oQ=;
        b=MINw0efaLc4wJ0CtFKxIpr9crzGyoIWHvKyAgHMOHiEaLA38w6/psshHzlCRXKKiIV
         ENLi5dHSoAqVy8qEbg887PK4YQlUD35rqAyvuEbwWK5mJ+ZMRIyGPODT0I8eFhfAkv9F
         /V+bPuffgS6OgQiryLJBN/b5WMr1dWwLV1IKPd5Jj9/bdXAMUqQcPong+g9yxwgWdnDK
         7MIpswHhqVOCiXYvOsz/dLaD0npb/WiTgWNUm0Dp5vYVgwq59i/dt7j/h51JlvmO78K+
         xdHm012kB8M3gYgTIEBl+KS3/8ErGG4iQ0auG96vmR6MYo6pBE/Ikyv9iTkLTNwF3YX+
         0C6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=N+JKQJqwCl0d6bUKiCh0PgpItsPMqUhVfYdVbCoV6oQ=;
        b=Ug3lwBR0CAGzYXk/rFC7CelmohE8xtY90zJflBqZMQLiwu90CCryglTN61l5bcLO1Y
         ZQiKiHUnGA146FMuwrU5sALrIiFBq7pmsIo/m8X/wNsxS/wooPGfSeQ8SZPdI/G1QGFk
         wtrFAc4irpEq4TmfT+7+J0qRud+ATpYxKDrnN1fkalw+tixufEenJYvQuh9Jlv+rr8g7
         NLCD56XwFxiHyDkcFnyoO9fFxtsWPNSY6QpNxborZwFWgB/T5d0BC9bAtRuGbv6BvxRh
         I+zy+1DY379zmyGB08rQ1IBLrKKb670DbVwyA/JcGTV9gcqr4lyR/MfPQe2ey5/o4YHe
         iFkA==
X-Gm-Message-State: AOAM531gGS9Ec7iGXFW8GDf+JQDOwtP3PdFO+5GcbV7ql723qp+qpgTY
        pjL1xY/bXH/nnlgtzyAAVak=
X-Google-Smtp-Source: ABdhPJzF83cjPp09lpMg1ZcXTznOOTKxL4kSSVgzF9In5JrWzPIbWNFh5lLTX+GfZItdJ9nCriUk+Q==
X-Received: by 2002:a63:5d52:: with SMTP id o18mr11120911pgm.440.1626290695918;
        Wed, 14 Jul 2021 12:24:55 -0700 (PDT)
Received: from ?IPv6:2804:14c:482:92eb:ffdf:6b35:b94d:258? ([2804:14c:482:92eb:ffdf:6b35:b94d:258])
        by smtp.gmail.com with ESMTPSA id o3sm6548755pjp.27.2021.07.14.12.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 12:24:55 -0700 (PDT)
Message-ID: <3951d2c425daa7b05e209a6fc8a550c2fca1645f.camel@gmail.com>
Subject: Re: [PATCH v4 10/11] powerpc/pseries/iommu: Make use of DDW for
 indirect mapping
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 14 Jul 2021 16:25:08 -0300
In-Reply-To: <2e88a275-3379-6f14-3c93-d2919bee2142@ozlabs.ru>
References: <20210430163145.146984-1-leobras.c@gmail.com>
         <20210430163145.146984-11-leobras.c@gmail.com>
         <95ac11e9-a709-e0a2-9690-ef13c4a2cd43@ozlabs.ru>
         <5b8676140f495dbbe3e28ce261e449b885dbae66.camel@gmail.com>
         <2e88a275-3379-6f14-3c93-d2919bee2142@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-07-14 at 18:38 +1000, Alexey Kardashevskiy wrote:
> >           for (i = 0; i <
> > > > ARRAY_SIZE(pci->phb->mem_resources);
> > > > i++) {
> > > > +                       const unsigned long mask =
> > > > IORESOURCE_MEM_64
> > > > > IORESOURCE_MEM;
> > > > +
> > > > +                       /* Look for MMIO32 */
> > > > +                       if ((pci->phb->mem_resources[i].flags &
> > > > mask)
> > > > == IORESOURCE_MEM)
> > > > +                               break;
> > > 
> > > What if there is no IORESOURCE_MEM? pci->phb-
> > > >mem_resources[i].start
> > > below will have garbage.
> > 
> > 
> > 
> > Yeah, that makes sense. I will add this lines after 'for':
> > 
> > if (i == ARRAY_SIZE(pci->phb->mem_resources)) {
> >   iommu_tce_table_put(newtbl);
> >   goto out_del_list;
> > }
> > 
> > What do you think?
> 
> 
> Move this and that "for" before iommu_pseries_alloc_table() so you
> won't 
> need to free if there is no IORESOURCE_MEM.

Done!

> 
> 
> > 
> > 
> > > 
> > > 
> > > > +               }
> > > > +
> > > > +               _iommu_table_setparms(newtbl, pci->phb->bus-
> > > > >number,
> > > > create.liobn, win_addr,
> > > > +                                     1UL << len, page_shift,
> > > > 0,
> > > > &iommu_table_lpar_multi_ops);
> > > > +               iommu_init_table(newtbl, pci->phb->node, pci-
> > > > >phb-
> > > > > mem_resources[i].start,
> > > > +                                pci->phb-
> > > > >mem_resources[i].end);
> > > > +
> > > > +               if (default_win_removed)
> > > > +                       iommu_tce_table_put(tbl);
> > > 
> > > 
> > > iommu_tce_table_put() should have been called when the window was
> > > removed.
> > > 
> > > Also after some thinking - what happens if there were 2 devices
> > > in the
> > > PE and one requested 64bit DMA? This will only update
> > > set_iommu_table_base() for the 64bit one but not for the other.
> > > 
> > > I think the right thing to do is:
> > > 
> > > 1. check if table[0] is in use, if yes => fail (which this does
> > > already)
> > > 
> > > 2. remove default dma window but keep the iommu_table struct with
> > > one
> > > change - set it_size to 0 (and free it_map) so the 32bit device
> > > won't
> > > look at a stale structure and think there is some window
> > > (imaginery
> > > situation for phyp but easy to recreate in qemu).
> > > 
> > > 3. use table[1] for newly created indirect DDW window.
> > > 
> > > 4. change get_iommu_table_base() to return a usable table (or may
> > > be
> > > not
> > > needed?).
> > > 
> > > If this sounds reasonable (does it?),
> > 
> > Looks ok, I will try your suggestion.
> > I was not aware of how pci->table_group->tables[] worked, so I
> > replaced
> > pci->table_group->tables[0] with the new tbl, while moving the
> > older in
> > pci->table_group->tables[1].
> 
> 
> pci->table_group->tables[0] is window#0 at @0.
> pci->table_group->tables[1] is window#1 at 0x0800.0000.0000.0000.
> That 
> is all :)
> 
> pseries does not use tables[1] but powernv does (by VFIO only
> though).

Thanks! This helped a lot!

> 
> 
> > (4) get_iommu_table_base() does not seem to need update, as it
> > returns
> > the tlb set by set_iommu_table_base() which is already called in
> > the
> > !direct_mapping path in current patch.
> 
> Sounds right.
> 
> > 
> > >   the question is now if you have
> > > time to do that and the hardware to test that, or I'll have to
> > > finish
> > > the work :)
> > 
> > Sorry, for some reason part of this got lost in Evolution mail
> > client.
> > 
> > If possible, I do want to finish this work, and I am talking to IBM
> > Virt people in order to get testing HW.
> 
> 
> Even I struggle to find a powervm machine :)

> 
> > > 
> > > 
> > > > +               else
> > > > +                       pci->table_group->tables[1] = tbl;
> > > 
> > > 
> > > What is this for?
> > 
> > I was thinking of adding the older table to pci->table_group-
> > >tables[1]
> > while keeping the newer table on pci->table_group->tables[0].
> > This did work, but I think your suggestion may work better.
> > 
> > Best regards,
> > Leonardo Bras
> > 
> > 
> 


Thanks a lot for reviewing Alexey!
I will send a v5 soon.
Best regards,

Leonardo Bras

