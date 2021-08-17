Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7802B3EE66E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 08:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbhHQGA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 02:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238049AbhHQGA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 02:00:27 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92026C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 22:59:54 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j1so30380587pjv.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 22:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=GJ9GWlYCg4+zVJoMtI5zY2C8xGVLbc9EYOIpcL2yt3Y=;
        b=UQlE8xgdpvA4wdKffS3YBXWJ8ocFkMACZe4tOyzgzln8OS8FQBZlh4g430d8UyULhd
         ojYsujBq4d/9DevFVrqXeUyBuarYvGEMLD0g/ZQ9TdaDiMnY9zkG/vvAH0X9ZT1fxi8G
         It+8sQg6DLektNkUOsKr4qcAI6yh9qaVKUbhjKFU+OPrQcn/z0LWL5NJeSp2Axmeuq7w
         CecG7Iro6Yu6YvyIu/r3hfZ+IFBez5nbEGtsdjyFC6UZ1hE2N4tkdjTiFLStvC7uDeY/
         VxabWm3X1hrQqDf1WtKRu5xRRS169nfmRns76PmSOwJI55HAXjjupy3brLTqF9nlW4NZ
         Jz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=GJ9GWlYCg4+zVJoMtI5zY2C8xGVLbc9EYOIpcL2yt3Y=;
        b=Cn55af0E5NomJD5DmQ7Yg2ArJLohSMsTxoJKvcl/eHzEejT32Rqy1UfExJbURfPnwD
         nv+TDMBYZ10ln/WM+10gjlE9oOWb1NBH1FInXk/qQrlf+tTsjdkac2cU17gH4BSFkuyz
         rXCekMmbFmyPNlJ4csEH1fgNepcg7npyd4sx5uB4P4gZyUSSZ/lj4vcD5Wi3fLvfmfhB
         bcd/CX/E1fs6mVafbMMu1Mt2gB3hL1bTbSpFZxvuRCuW40QI6AMDgwRtC/r91keabsC8
         rwSo+3UANAAZxQB3y2LiGUisyyhEEo+Bzyv8n2Hq4ymPamK+7SG/0SNYygTVfT3w2Q4q
         Ddcg==
X-Gm-Message-State: AOAM531t9ExdIed+7YKXxy4WZ8uXHIOobv/dt4WkzHW0Oocirh4bdQ1j
        6ySknwXoiD7S6raJkuoijGc=
X-Google-Smtp-Source: ABdhPJypZ0emOG909fZ+yC9uG8mlssu39sEfIPJw28MDurTAagsbzlP0+ZhR3OmyJWM1hBvPVaGcBA==
X-Received: by 2002:a17:90a:d784:: with SMTP id z4mr221009pju.73.1629179994153;
        Mon, 16 Aug 2021 22:59:54 -0700 (PDT)
Received: from ?IPv6:2804:431:c7f0:30b2:5c9e:50:88f3:269a? ([2804:431:c7f0:30b2:5c9e:50:88f3:269a])
        by smtp.gmail.com with ESMTPSA id m194sm1093489pfd.58.2021.08.16.22.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 22:59:53 -0700 (PDT)
Message-ID: <25299f8dc62953996a43c3d654937d51ea8b1d9c.camel@gmail.com>
Subject: Re: [PATCH v5 10/11] powerpc/pseries/iommu: Make use of DDW for
 indirect mapping
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        kernel test robot <lkp@intel.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Tue, 17 Aug 2021 02:59:55 -0300
In-Reply-To: <75c84c0b-46b3-2600-c186-257aec05c645@ozlabs.ru>
References: <20210716082755.428187-1-leobras.c@gmail.com>
         <20210716082755.428187-11-leobras.c@gmail.com>
         <b98f696a-ed64-4c9e-ccb6-549ae8bc7fd6@linux.ibm.com>
         <8dfb28d5-b654-746c-03d8-aeee3d438240@ozlabs.ru>
         <994051df-73b3-4dad-76aa-1a03d9afaf6d@linux.ibm.com>
         <75c84c0b-46b3-2600-c186-257aec05c645@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey, Fred:

On Fri, 2021-07-23 at 15:34 +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 22/07/2021 01:04, Frederic Barrat wrote:
> > 
> > 
> > On 21/07/2021 05:32, Alexey Kardashevskiy wrote:
> > > > > +        struct iommu_table *newtbl;
> > > > > +        int i;
> > > > > +
> > > > > +        for (i = 0; i < ARRAY_SIZE(pci->phb->mem_resources);
> > > > > i++) {
> > > > > +            const unsigned long mask = IORESOURCE_MEM_64 | 
> > > > > IORESOURCE_MEM;
> > > > > +
> > > > > +            /* Look for MMIO32 */
> > > > > +            if ((pci->phb->mem_resources[i].flags & mask) ==
> > > > > IORESOURCE_MEM)
> > > > > +                break;
> > > > > +        }
> > > > > +
> > > > > +        if (i == ARRAY_SIZE(pci->phb->mem_resources))
> > > > > +            goto out_del_list;
> > > > 
> > > > 
> > > > So we exit and do nothing if there's no MMIO32 bar?
> > > > Isn't the intent just to figure out the MMIO32 area to reserve
> > > > it 
> > > > when init'ing the table? In which case we could default to 0,0
> > > > 
> > > > I'm actually not clear why we are reserving this area on
> > > > pseries.
> > > 
> > > 
> > > 
> > > If we do not reserve it, then the iommu code will allocate DMA
> > > pages 
> > > from there and these addresses are MMIO32 from the kernel pov at 
> > > least. I saw crashes when (I think) a device tried DMAing to the
> > > top 
> > > 2GB of the bus space which happened to be a some other device's
> > > BAR.
> > 
> > 
> > hmmm... then figuring out the correct range needs more work. We
> > could 
> > have more than one MMIO32 bar. And they don't have to be adjacent. 
> 
> They all have to be within the MMIO32 window of a PHB and we reserve
> the 
> entire window here.
> 
> > I 
> > don't see that we are reserving any range on the initial table
> > though 
> > (on pseries).
> True, we did not need to, as the hypervisor always took care of DMA
> and 
> MMIO32 regions to not overlap.
> 
> And in this series we do not (strictly speaking) need this either as 
> phyp never allocates more than one window dynamically and that only 
> window is always the second one starting from 0x800.0000.0000.0000.
> It 
> is probably my mistake that KVM allows a new window to start from 0 -
> PAPR did not prohibit this explicitly.
> 
> And for the KVM case, we do not need to remove the default window as
> KVM 
> can pretty much always allocate as many TCE as the VM wants. But we 
> still allow removing the default window and creating a huge one
> instead 
> at 0x0 as this way we can allow 1:1 for every single PCI device even
> if 
> it only allows 48 (or similar but less than 64bit) DMA. Hope this
> makes 
> sense. Thanks,
> 
> 

Thank you for this discussion, I got to learn a lot!

If I got this, no further change will be necessary, is that correct?

I am testing a v6, and I intend to send it soon.

