Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DECF3FCE41
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 22:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240866AbhHaUSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 16:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbhHaUSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 16:18:50 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAEFC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 13:17:55 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id g11so672170qtk.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 13:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=FWX7QDqAeTGxpfWQKLDU6dVUG/9zC9QbXzwdV9LlpIQ=;
        b=dMPYkL5GPKD28AeQdN53eGawFt/7ebRPpsxkOHxlNNFsIl68Xmq20eJjqxScyCQ7M3
         uAFtJOAh4sPISmKcYykXy7YZKyaNdcsO+nbB9oArAPhFDelR7TpxPAt4TXA/2n9+p2dK
         QtasMPC5zbdzyYea7u6Gv1lTWH6z+k9By6AqlVzRjJ0xHsBJXzf6ADo7E0dBvubphtgt
         0tM+oo/wTRAIi2IMSmcyQCVV44AGlNwGQpJt0Qv5qwqClTX+2eP39lLnjZiHlwmznTme
         HJsmsST2gYCTKxpUYdycuoNQVF7fBMwXlDxch7RAfGjPRmfgo1k55SHBYS0IQFE6TLq7
         8kCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FWX7QDqAeTGxpfWQKLDU6dVUG/9zC9QbXzwdV9LlpIQ=;
        b=hDK844alE8fuxqbZKYa5c82ngsTEsjVwCuJR69o5chHpDv/NmqejGBicTvaXnk5n4v
         FgLCfJF1S51mxiKHB2FfJ2gRE79712bnB6WCT1qArQRCSMdkVJ83B9t8MXnkcVMbHW3C
         E0pz6R4l9MuzbAYM/10NUF3JwK309FQTGPbgUxGNRV0WD0UXlwXYXbLZAeaQv8BmQI+t
         0LNXitIgvS9jOzMjGMKeDpkawtTW9mAtdngRkzfgBHl6LkZ+wXxUe0P3oMCYp76YN9Pk
         BtHDegNkoaa/FPqequ18v074OGKAaU60FitYjl1QJQ+UqX+h/etdaDzmrIChO15zxC/2
         6R/w==
X-Gm-Message-State: AOAM5315v23V8MXJhyKQBMoVPv4w0HqyA211un55gKXsB1n94qjtqxMs
        IqwYAqKbB1rDai1YUzY7h2mIiNwS+RQ=
X-Google-Smtp-Source: ABdhPJzD+olKgBw7MHX1YGOOMEPpF6x4Jd7u9DqbrWJvNqYyImvjggUg3ntyPM7R+qxyHusSQEKmgg==
X-Received: by 2002:ac8:7c44:: with SMTP id o4mr4547116qtv.82.1630441074411;
        Tue, 31 Aug 2021 13:17:54 -0700 (PDT)
Received: from ?IPv6:2804:431:c7f1:e948:8e69:9cd6:5512:12f4? ([2804:431:c7f1:e948:8e69:9cd6:5512:12f4])
        by smtp.gmail.com with ESMTPSA id f28sm14501184qkk.10.2021.08.31.13.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:17:54 -0700 (PDT)
Message-ID: <e867b4ddce01adf318bc8837c997ceb64e44c1c5.camel@gmail.com>
Subject: Re: [PATCH v6 00/11] DDW + Indirect Mapping
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To:     David Christensen <drc@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        kernel test robot <lkp@intel.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Tue, 31 Aug 2021 17:18:11 -0300
In-Reply-To: <82ca56ab-6a0a-7cbb-a5e7-facc40f35c3c@linux.vnet.ibm.com>
References: <20210817063929.38701-1-leobras.c@gmail.com>
         <82ca56ab-6a0a-7cbb-a5e7-facc40f35c3c@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

Sorry for the delay, I did not get your mail because I was not CC'd
in your reply (you sent the mail just to the mailing list).

Replies bellow:

On Mon, 2021-08-30 at 10:48 -0700, David Christensen wrote:
> On 8/16/21 11:39 PM, Leonardo Bras wrote:
> > So far it's assumed possible to map the guest RAM 1:1 to the bus,
> > which
> > works with a small number of devices. SRIOV changes it as the user
> > can
> > configure hundreds VFs and since phyp preallocates TCEs and does not
> > allow IOMMU pages bigger than 64K, it has to limit the number of TCEs
> > per a PE to limit waste of physical pages.
> > 
> > As of today, if the assumed direct mapping is not possible, DDW
> > creation
> > is skipped and the default DMA window "ibm,dma-window" is used
> > instead.
> > 
> > Using the DDW instead of the default DMA window may allow to expand
> > the
> > amount of memory that can be DMA-mapped, given the number of pages
> > (TCEs)
> > may stay the same (or increase) and the default DMA window offers
> > only
> > 4k-pages while DDW may offer larger pages (4k, 64k, 16M ...).
> 
> So if I'm reading this correctly, VFIO applications requiring hugepage 
> DMA mappings (e.g. 16M or 2GB) can be supported on an LPAR or DLPAR 
> after this change, is that correct?  

Different DDW IOMMU page sizes were already supported in Linux (4k,
64k, 16M) for a while now, and the remaining page sizes in LoPAR were
enabled in the following patch:
http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20210408201915.174217-1-leobras.c@gmail.com/
(commit 472724111f0f72042deb6a9dcee9578e5398a1a1)

The thing is there are two ways of using DMA:
- Direct DMA, mapping the whole memory space of the host, which
requires a lot of DMA space if the guest memory is huge. This already
supports DDW and allows using the bigger pagesizes.
This happens on device/bus probe.

- Indirect DMA with IOMMU, mapping memory regions on demand, and un-
mapping after use. This requires much less DMA space, but causes an
overhead because an hcall is necessary for mapping and un-mapping.
Before this series, Indirect DMA was only possible with the 'default
DMA window' which allows using only 4k pages. 

This series allow Indirect DMA using DDW when available, which usually
means bigger pagesizes and more TCEs, and so more DMA space.


tl;dr this patchset means you can have more DMA space in Indirect DMA,
because you are using DDW instead of the Default DMA window.

> Any limitations based on processor 
> or pHyp revision levels?

The IOMMU page size will be limited by the sizes offered by processor
and hypervisor. They are announced at  "IO Page Sizes" output of
ibm,query-pe-dma-window, but now the biggest pagesize automatically
selected with commit 472724111f0f72042deb6a9dcee9578e5398a1a1 above
mentioned. 

Hope this helps, please let me know if there is any remaining question.

Best regards,
Leonardo

