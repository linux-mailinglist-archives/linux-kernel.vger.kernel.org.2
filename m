Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE323053DF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 08:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S316697AbhA0BA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389956AbhAZSVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:21:07 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715D0C061573
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:20:26 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id 19so16894971qkh.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3pcCknD/BxtIB8RBkZo8Cp7IF2+vwd74k7zS24kTbR8=;
        b=g4dYrV4PaU2nmFT29+g3Rzm5JnSUd20A1ZWJ6EdcZinlf0+ZNWNonkfVQ6Dp3gXNCM
         iJu2ORFJvR2ymNl1/WjeVn9tUusJv6B/KvgegcBmQ+lLLD9FbefZpf21si64F1aicoOd
         TuRy802BItwrexCICDhtbGPbzg6DJN4LdRpJN7tiwQrpEsyHaBUXEq3AfaOQslLRuF5e
         xmnc145bBdMdUKni1AZrxpkAvtY0ZQoozUmrlJqyHo2l4q/WuLLfAxAj+BFYkFP1drk5
         cjVu7ZEjWMrDw+WqzYGeymS4FdQsB1s+TzvrnDOUgLArhdfwXDigOGQ/NLrHQa+OwxGj
         HAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3pcCknD/BxtIB8RBkZo8Cp7IF2+vwd74k7zS24kTbR8=;
        b=nE/iR4LBKXDuWgcmQk0QzyWanHvNlEY+ltmWj+ixo3beGfSx3IGh1f8Pa7w8BOauQX
         1KaXJVKo1Yok/ko9Kif0gdwCanXAgpk1OPY0jAQzvZZztcX7aazAjsVJFuHiqJZoaytS
         cwEr4qUyrzO6tE+PAf6S0jw5IoKe4Jy7Anzw/MO17MQjMpziNyI0EQ3lfYKWbrudyPh4
         zLs55NDtG8oHxUXpCyH2IVbEVMUAKyXqRkN/oHAD0CwBnYieAf4+51Qw0ctW5cKUvHAn
         Mwkz9Z1rvebl/UCp/hNZ80EZxGPGwStMfXVuwtJT2xU9esJMuiuJMFhPhEmNLnG3OBF5
         m67w==
X-Gm-Message-State: AOAM530BacNMYgALV9L9UgSjRQqEuIFHETRkOwuKzBt7gtK+wHSs2I9D
        DNrX831lPyiS31iAfYwMOBKrOQ==
X-Google-Smtp-Source: ABdhPJyv228KfIjwwkPqso1SD69kZ5ZLPyWizKOSKwm7PPgZ1vF7s3nuEYfyIbVsj4pXarwA8sS6PA==
X-Received: by 2002:a37:bc8:: with SMTP id 191mr7214911qkl.384.1611685225677;
        Tue, 26 Jan 2021 10:20:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id x72sm12135585qka.51.2021.01.26.10.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:20:25 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l4Swy-0078zV-Bj; Tue, 26 Jan 2021 14:20:24 -0400
Date:   Tue, 26 Jan 2021 14:20:24 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "linux-accelerators@lists.ozlabs.org" 
        <linux-accelerators@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "chensihang (A)" <chensihang1@hisilicon.com>
Subject: Re: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Message-ID: <20210126182024.GA4605@ziepe.ca>
References: <1611563696-235269-1-git-send-email-wangzhou1@hisilicon.com>
 <20210125154717.GW4605@ziepe.ca>
 <96b655ade2534a65974a378bb68383ee@hisilicon.com>
 <20210125231619.GY4605@ziepe.ca>
 <5f64a68042c64f37b5cba74028bd2189@hisilicon.com>
 <20210126011304.GZ4605@ziepe.ca>
 <d7fce136c3644755a7aea5794bddf453@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7fce136c3644755a7aea5794bddf453@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 01:26:45AM +0000, Song Bao Hua (Barry Song) wrote:
> > On Mon, Jan 25, 2021 at 11:35:22PM +0000, Song Bao Hua (Barry Song) wrote:
> > 
> > > > On Mon, Jan 25, 2021 at 10:21:14PM +0000, Song Bao Hua (Barry Song) wrote:
> > > > > mlock, while certainly be able to prevent swapping out, it won't
> > > > > be able to stop page moving due to:
> > > > > * memory compaction in alloc_pages()
> > > > > * making huge pages
> > > > > * numa balance
> > > > > * memory compaction in CMA
> > > >
> > > > Enabling those things is a major reason to have SVA device in the
> > > > first place, providing a SW API to turn it all off seems like the
> > > > wrong direction.
> > >
> > > I wouldn't say this is a major reason to have SVA. If we read the
> > > history of SVA and papers, people would think easy programming due
> > > to data struct sharing between cpu and device, and process space
> > > isolation in device would be the major reasons for SVA. SVA also
> > > declares it supports zero-copy while zero-copy doesn't necessarily
> > > depend on SVA.
> > 
> > Once you have to explicitly make system calls to declare memory under
> > IO, you loose all of that.
> > 
> > Since you've asked the app to be explicit about the DMAs it intends to
> > do, there is not really much reason to use SVA for those DMAs anymore.
> 
> Let's see a non-SVA case. We are not using SVA, we can have
> a memory pool by hugetlb or pin, and app can allocate memory
> from this pool, and get stable I/O performance on the memory
> from the pool. But device has its separate page table which
> is not bound with this process, thus lacking the protection
> of process space isolation. Plus, CPU and device are using
> different address.

So you are relying on the platform to do the SVA for the device?

This feels like it goes back to another topic where I felt the SVA
setup uAPI should be shared and not buried into every driver's unique
ioctls.

Having something like this in a shared SVA system is somewhat less
strange.

Jason
