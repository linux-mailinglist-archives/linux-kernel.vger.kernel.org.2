Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40D9357C79
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhDHGUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhDHGUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:20:35 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C41C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 23:20:24 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id i9so1166056qka.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 23:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=+YK8S5Mo/rZbKbyRFAI8qgheI4iNBgcGprTWWKxT3Xs=;
        b=ibKlH86rK64gYyXGVAeO0ewn6CJPIERqnFl8K+8RDkFsUHVOaU5OFHKR4q/+yr8yNY
         fEZdndjtpzahnlaf2NkNbsSvKwPm04TjmDj7Ta26obwlNczVmOsXjSKCAttFAHFmzzJj
         pWt1LZSL/lbjnUkRa5BrFEAu7HF21mfAYk+of8bTtiM09Pyg4wQCEc9/HaNZ+iId6I+q
         7oUm0bVtFfMu5Vuok3Fqvt0fy/9Mf0tRI92Bo/o+6e3TzmbUVh4vAaD5SpBI6DtNcSxI
         mJOHO7/P9Qblynn06+Ou68OvDfwmcK8F5+LjeiQIJqfklMgykK4x93cBb7SwyMsw7dlf
         b22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=+YK8S5Mo/rZbKbyRFAI8qgheI4iNBgcGprTWWKxT3Xs=;
        b=nQK+x2PxGY+vZtWLGKxw+ju7IPRl1echT2kWNcvJ1Qpovz/IWIUvq7qlXzANFUQC8G
         UH9Xru5280/Cthl0XVHyve4Cu7HmJw+3TsP1iNfakNS/OuaWmPS7+WKF/LvX5nsNSjqt
         oBADmgvvpcDJoUTnlbZRSeGblW7jOnrKOMM9JF/oGI4mdWgRTY3nGlWpmsQRJJmF4qMX
         h+xwLNJrNLvjP/DNOWQKeXS2wSxCrwMNmsakBNKMBDdqou6j9JLGg+k5aO5PjfWFY/1O
         Dx2JcWbuMOAs1ENGNqw7ouZikBVnl5wduH1lI1/ZFNGCEOakjKQdCIn0ovECEdLrsWoz
         Ul9A==
X-Gm-Message-State: AOAM533Y8EtbE1BowcEv0lkol1ZXdtcmpbJd2c/t+VFBs0JGSjoAbAOD
        lo2ygGI0cIIh03+CrdNs58f7cpec7NY=
X-Google-Smtp-Source: ABdhPJypY9Tv73D0Y+wnyc9nm9yRRwHDN044agKYv/vNiYYSNDDt+GYQZ7b/47sSEGJoQWWpCAH3eQ==
X-Received: by 2002:a37:9a96:: with SMTP id c144mr6981972qke.221.1617862823753;
        Wed, 07 Apr 2021 23:20:23 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com ([2804:14c:482:7b04::1000])
        by smtp.gmail.com with ESMTPSA id s19sm19698402qks.130.2021.04.07.23.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 23:20:23 -0700 (PDT)
Message-ID: <942acb9b23d87594d0b758cc0daf713be836f8e6.camel@gmail.com>
Subject: Re: [PATCH v2 1/1] powerpc/iommu: Enable remaining IOMMU Pagesizes
 present in LoPAR
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>, brking@linux.vnet.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Apr 2021 03:20:19 -0300
In-Reply-To: <87im4xe3pk.fsf@mpe.ellerman.id.au>
References: <20210407195613.131140-1-leobras.c@gmail.com>
         <87im4xe3pk.fsf@mpe.ellerman.id.au>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michael, thank you for this feedback!
Comments inline:

On Thu, 2021-04-08 at 15:37 +1000, Michael Ellerman wrote:
> Leonardo Bras <leobras.c@gmail.com> writes:
> > According to LoPAR, ibm,query-pe-dma-window output named "IO Page Sizes"
> > will let the OS know all possible pagesizes that can be used for creating a
> > new DDW.
> > 
> > Currently Linux will only try using 3 of the 8 available options:
> > 4K, 64K and 16M. According to LoPAR, Hypervisor may also offer 32M, 64M,
> > 128M, 256M and 16G.
> 
> Do we know of any hardware & hypervisor combination that will actually
> give us bigger pages?
> 
> > Enabling bigger pages would be interesting for direct mapping systems
> > with a lot of RAM, while using less TCE entries.
> > 
> > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > ---
> >  arch/powerpc/platforms/pseries/iommu.c | 49 ++++++++++++++++++++++----
> >  1 file changed, 42 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> > index 9fc5217f0c8e..6cda1c92597d 100644
> > --- a/arch/powerpc/platforms/pseries/iommu.c
> > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > @@ -53,6 +53,20 @@ enum {
> >  	DDW_EXT_QUERY_OUT_SIZE = 2
> >  };
> 
> A comment saying where the values come from would be good.

Sure, I will add the information about LoPAR.

> 
> > +#define QUERY_DDW_PGSIZE_4K	0x01
> > +#define QUERY_DDW_PGSIZE_64K	0x02
> > +#define QUERY_DDW_PGSIZE_16M	0x04
> > +#define QUERY_DDW_PGSIZE_32M	0x08
> > +#define QUERY_DDW_PGSIZE_64M	0x10
> > +#define QUERY_DDW_PGSIZE_128M	0x20
> > +#define QUERY_DDW_PGSIZE_256M	0x40
> > +#define QUERY_DDW_PGSIZE_16G	0x80
> 
> I'm not sure the #defines really gain us much vs just putting the
> literal values in the array below?

My v1 did not use the define approach, what do you think of that?
http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20210322190943.715368-1-leobras.c@gmail.com/

> 
> > +struct iommu_ddw_pagesize {
> > +	u32 mask;
> > +	int shift;
> > +};
> > +
> >  static struct iommu_table_group *iommu_pseries_alloc_group(int node)
> >  {
> >  	struct iommu_table_group *table_group;
> > @@ -1099,6 +1113,31 @@ static void reset_dma_window(struct pci_dev *dev, struct device_node *par_dn)
> >  			 ret);
> >  }
> >  
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > +/* Returns page shift based on "IO Page Sizes" output at ibm,query-pe-dma-window. See LoPAR */
> > +static int iommu_get_page_shift(u32 query_page_size)
> > +{
> > +	const struct iommu_ddw_pagesize ddw_pagesize[] = {
> > +		{ QUERY_DDW_PGSIZE_16G,  __builtin_ctz(SZ_16G)  },
> > +		{ QUERY_DDW_PGSIZE_256M, __builtin_ctz(SZ_256M) },
> > +		{ QUERY_DDW_PGSIZE_128M, __builtin_ctz(SZ_128M) },
> > +		{ QUERY_DDW_PGSIZE_64M,  __builtin_ctz(SZ_64M)  },
> > +		{ QUERY_DDW_PGSIZE_32M,  __builtin_ctz(SZ_32M)  },
> > +		{ QUERY_DDW_PGSIZE_16M,  __builtin_ctz(SZ_16M)  },
> > +		{ QUERY_DDW_PGSIZE_64K,  __builtin_ctz(SZ_64K)  },
> > +		{ QUERY_DDW_PGSIZE_4K,   __builtin_ctz(SZ_4K)   }
> > +	};
> 
> 
> cheers

Best regards,
Leonardo Bras


