Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6867C348DE5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCYKWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhCYKWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:22:00 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF231C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 03:21:59 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v4so1667346wrp.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 03:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2bl+T//9tmIfvggnKu8W5/72RtiA3Lc/gNcBZ4TaNT0=;
        b=HDBMmQHjxhDfBDa8NUpbssXQOf02VdhzwNOvL6z/sjlS/ob6nTDjDFdk7Rx19nR1hs
         SQS1m7CNqJDQUJQrPvFOlRsKplOR4HvnzIgwuwJzay62ap35JEwN/qhpACoPzMAWxfWI
         XO4MYnlDxfTay5ZNPPLBaE8XvkwnoB0y15l1GoemjCgivvxfYqd4SqDye10bL/U1sDgq
         2q58EeYToO3fsZktwBu5V51IOdt2ibMB1IaBNKKSb4cr+C+as3JCUfzbgdL92Xba3w9V
         ql45gXFLeCm10iNBjvSTa/BEbpZQtQ6N4qHGai0lWRLpSVaztsL2TRhlDZbX05OJR9Pk
         EKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2bl+T//9tmIfvggnKu8W5/72RtiA3Lc/gNcBZ4TaNT0=;
        b=BUQ6U3ciYZ331+I4eM5mHCFbzP0/vsPCEsbGtsTQpDfPuYQWAJv35524PUgB0fdnTN
         hEFiC0aMUUTU7exV0kucss56aj0b5OIIj2TA9doXoEoNwLHzx/21G1vJWs55RT89goWb
         24N1rKeG7Dcz2FL3YFU4jiGF3SDiuIgseu0ReXxYlB1DY8JNDXUI2f0K2tP4Iht7Ru7n
         MayKARTBOwBLW8bYBG7EloqYt8Hql1s4+npq7+7zMvYWYos3G6mMl0qSCZUnpThQfcal
         D9GcVzTzYc/APKEGs33h8gfbzELOLmWgwRXBu1pTIr1SdXtFEBkJw7XGNiImJNsO+8FE
         fHcg==
X-Gm-Message-State: AOAM531/mRwrPa+qFaOg2Qy8m1z/6z2RDWuPKGEO1TrCIBQ8jYngk4im
        iJzsn4EhDBxifryo2Rarv8jmSA==
X-Google-Smtp-Source: ABdhPJxdNpCXhheQbUGXl/BE6FBzNDPbXq78nFO9owhDJs9Gl4Mz6+SKSrv2in7tl4ijY3NP8j4Dxw==
X-Received: by 2002:a05:6000:12c5:: with SMTP id l5mr7958343wrx.208.1616667718538;
        Thu, 25 Mar 2021 03:21:58 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id g15sm5458756wmq.31.2021.03.25.03.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 03:21:58 -0700 (PDT)
Date:   Thu, 25 Mar 2021 11:21:40 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YFxkNEz3THJKzW0b@myrica>
References: <20210318172234.3e8c34f7@jacob-builder>
 <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com>
 <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
 <YFhiMLR35WWMW/Hu@myrica>
 <20210324100246.4e6b8aa1@jacob-builder>
 <20210324170338.GM2356281@nvidia.com>
 <20210324151230.466fd47a@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324151230.466fd47a@jacob-builder>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 03:12:30PM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Wed, 24 Mar 2021 14:03:38 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Wed, Mar 24, 2021 at 10:02:46AM -0700, Jacob Pan wrote:
> > > > Also wondering about device driver allocating auxiliary domains for
> > > > their private use, to do iommu_map/unmap on private PASIDs (a clean
> > > > replacement to super SVA, for example). Would that go through the
> > > > same path as /dev/ioasid and use the cgroup of current task?  
> > >
> > > For the in-kernel private use, I don't think we should restrict based on
> > > cgroup, since there is no affinity to user processes. I also think the
> > > PASID allocation should just use kernel API instead of /dev/ioasid. Why
> > > would user space need to know the actual PASID # for device private
> > > domains? Maybe I missed your idea?  
> > 
> > There is not much in the kernel that isn't triggered by a process, I
> > would be careful about the idea that there is a class of users that
> > can consume a cgroup controlled resource without being inside the
> > cgroup.
> > 
> > We've got into trouble before overlooking this and with something
> > greenfield like PASID it would be best built in to the API to prevent
> > a mistake. eg accepting a cgroup or process input to the allocator.
> > 
> Make sense. But I think we only allow charging the current cgroup, how about
> I add the following to ioasid_alloc():
> 
> 	misc_cg = get_current_misc_cg();
> 	ret = misc_cg_try_charge(MISC_CG_RES_IOASID, misc_cg, 1);
> 	if (ret) {
> 		put_misc_cg(misc_cg);
> 		return ret;
> 	}

Does that allow PASID allocation during driver probe, in kernel_init or
modprobe context?

Thanks,
Jean

