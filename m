Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7602832A4AB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838461AbhCBKyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379658AbhCBKoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:44:14 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E0EC061788
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 02:43:59 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u16so1321897wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 02:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8fJXMvjxuLDN6bYz0lZym+t1q3/86XVS/pchijcoEVo=;
        b=BSmT+MRdC2Gz86qjV7VPEXzzBopRQ8WplkLVUfh1pECy7yCQRr7+i65WPII2xYcExs
         C3Iopvu1EQmgd87vvjwruLy2aw86vBQNqxt1WhKC/OevwP9WYa4/otAO7y5Bv4Qd6EJH
         Yy0dMKQ3s9AIUfSWWH9cZl8eZ0NHh/bK8aUfuDHbbZ+CmPq8v1KD0zb/BRRCJLsNNzxc
         wwTQ65Hb9JUTEOzIXpI6jflgeKE3ptsWZwYfD/ENTjcLAbsiEyI1zpLPB476q98x3kjn
         3ZHX52999srZNjEzwgqLVWHc5JwOMxMNQsJLtTD9DJGuM61G7xuWpi3oXNeH2VFuiuaG
         j8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8fJXMvjxuLDN6bYz0lZym+t1q3/86XVS/pchijcoEVo=;
        b=ACcn8EICWshMlByn254HCkmQu2gRBqvBySgH/yIoyBmLhKasCmt9ltp5haqFF4xKnw
         mofTHx3XxiqsS/73h0fWa69d8a1ZiryH1cRpdwgKgcOHZPOZfxPJAoK5DXZQx/6owQ5z
         sVcBTOEp7vPdQi0Ub/bgb3uXVc5fiVvh37IBs1kXi68u7bnUZzfboMoBnTWgiETz5a0x
         tfP+wGOqiwspSGcq6POZ5dWqcyieuu5LZ6hvmlwpy5dnbNzN71sDb4v6rZAxfpiQAKQA
         9OamDbFCbvLfL1LAkfxUwif6HBiz4vuKk/5Ogw9zj5SiyZF1Mwg1JLpLQBx2q/SDj5HV
         Mh4Q==
X-Gm-Message-State: AOAM533QoFHtXmwF9TFlbfcKa8B1OeGY5EVCN8aFwVRsnGbswa+F9Ong
        umYMcypEHPwBSw6ACu2xcWcmgdRrwBdFeQ==
X-Google-Smtp-Source: ABdhPJzVmOgttgWE5aqEn9bZKhAUWJarTt1JNgnA3PjQJT6fyIa7wE85W61yCc7ilp3btYLG3uqQiw==
X-Received: by 2002:a5d:4141:: with SMTP id c1mr22150448wrq.248.1614681837978;
        Tue, 02 Mar 2021 02:43:57 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id h20sm2220312wmb.1.2021.03.02.02.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 02:43:57 -0800 (PST)
Date:   Tue, 2 Mar 2021 11:43:36 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, zhangfei.gao@foxmail.com,
        linux-mm@kvack.org
Subject: Re: [PATCH v6 08/12] fork: Clear PASID for new mm
Message-ID: <YD4W2GPg4OUFVWty@myrica>
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-9-git-send-email-fenghua.yu@intel.com>
 <YDYoL/zZ9YaGgwSV@myrica>
 <YDgh53AcQHT+T3L0@otcwcpicx3.sc.intel.com>
 <20210301150011.766e70a3@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301150011.766e70a3@jacob-builder>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 03:00:11PM -0800, Jacob Pan wrote:
> > functionality is not a problem without this patch on x86. But I think
> I feel the reason that x86 doesn't care is that mm->pasid is not used
> unless bind_mm is called.

I think vt-d also maintains the global_svm_list, that tells whether a
PASID is already allocated for the mm. The SMMU driver relies only on
iommu_sva_alloc_pasid() for this.

> For the fork children even mm->pasid is non-zero,
> it has no effect since it is not loaded onto MSRs.
> Perhaps you could also add a check or WARN_ON(!mm->pasid) in load_pasid()?
> 
> > we do need to have this patch in the kernel because PASID is per addr
> > space and two addr spaces shouldn't have the same PASID.
> > 
> Agreed.
> 
> > Who will accept this patch?

It's not clear from get_maintainers.pl, but I guess it should go via
linux-mm. Since the list wasn't cc'd on the original patch, I resent it.

Thanks,
Jean
