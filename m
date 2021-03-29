Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734E734D513
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 18:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhC2Q0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 12:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbhC2Q0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 12:26:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D760C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 09:26:08 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j7so13510628wrd.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 09:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T74W0nsf8Eu00PANoOWWFVGfSYum6qWwsn0Bw2THZ+s=;
        b=YUIEgiI1qQRI29mfubywR7B14Uyqk60nwvE2KF7gqROs2K/Or1NYVxhiZL1RMZ9LIb
         sxYMJOnaFcJ3QryDjmsfpUP4evW0yxJ3rw8eNH8PHzeO+fHHzIgI/Y0wybDi44c6cS0p
         QD0Yt7+edAu6/oJ0axLyyHLhGCJaiV+68wfh48hVfETIQjrodfMWWyd+Il3hV/R+JQ4o
         cyRYUBscybFXnPjsct6pzbq61epkXDbc8+yQhoNk/cjCgWp2QmhEqfFS91Bxoq0/v6At
         TaRW1iDGlxWbVJKNyQv0AhTpMf6zO8lTwMDtFHfw9Hf03gYJdaNK09LuH1HAz/RAPwuU
         eMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T74W0nsf8Eu00PANoOWWFVGfSYum6qWwsn0Bw2THZ+s=;
        b=VCBec5nzC89Mjfmy1mTI1ybGrbYMRlJJfc144BtdPPLgnlGXEeNCmemEDwfO6X+jSw
         KOQJRuU9LSdZz0lWiOuSq+YCbgFrd8dVFeBCnt4rdm1ht0HEB0v5ne5WWKY/m7TDg+Zd
         WhuE7bshh4fGPED1EAkz7mv75kQYdzA9HvOHVHlHq/L2dPI8ni82697/X9hDsnUfbfc0
         tlhadjbrQz6Ye0IQem/N0LTX9olMdKO/j9/xWFhIJKKru5w+AEASqYQnGQLU/Q9h8vJ1
         P85RBNCab1KK9A4TSuxihB3PRkIjYbijb/xeqz7ERl/7Fo27nu4twG8l69eYSdOHELE0
         xkAA==
X-Gm-Message-State: AOAM532NsTzl2fmtAbWXodzXjebMlU8RFL1v7Q+ygmWrc4J/xjEiVI3l
        UbkdHqwK5mpRU66yNicnD0sT1w==
X-Google-Smtp-Source: ABdhPJyAv1xefDsH4RnBTD3wTIb5bRlvWKvplwmh2Mjf9I5mC7dc85r3sKdv9DNWLYwkDvTL7Er6sg==
X-Received: by 2002:a05:6000:18d2:: with SMTP id w18mr29581974wrq.88.1617035167386;
        Mon, 29 Mar 2021 09:26:07 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id m3sm30135465wme.40.2021.03.29.09.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:26:07 -0700 (PDT)
Date:   Mon, 29 Mar 2021 18:25:48 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Vivek Kumar Gautam <vivek.gautam@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, joro@8bytes.org,
        will.deacon@arm.com, mst@redhat.com, robin.murphy@arm.com,
        eric.auger@redhat.com, alex.williamson@redhat.com,
        kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@intel.com, lorenzo.pieralisi@arm.com,
        shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFC v1 02/15] iommu: Add a simple PASID table library
Message-ID: <YGH/jJPeG9ltT8uu@myrica>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-3-vivek.gautam@arm.com>
 <YD/DU8XNYHlTzTay@myrica>
 <cd030006-2701-206d-5fca-e0e7afff316a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd030006-2701-206d-5fca-e0e7afff316a@arm.com>
X-TUID: 5GTwZm4l3gMS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 06:17:55PM +0530, Vivek Kumar Gautam wrote:
> > Regarding the overall design, I was initially assigning page directories
> > instead of whole PASID tables, which would simplify the driver and host
> > implementation. A major complication, however, is SMMUv3 accesses PASID
> > tables using a guest-physical address, so there is a messy negotiation
> > needed between host and guest when the host needs to allocate PASID
> > tables. Plus vSMMU needs PASID table assignment, so that's what the host
> > driver will implement.
> 
> By assigning the page directories, you mean setting up just the stage-1 page
> table ops, and passing that information to the host using ATTACH_TABLE?

Yes. And we can support nested translation with SMMUv2 that way. But with
SMMUv3 the guest has to manage the whole PASID table.

> Right now when using kvmtool, the struct iommu_pasid_table_config is
> populated with the correct information, and this whole memory is mapped
> between host and guest by creating a mem bank using
> kvm__for_each_mem_bank().
> Did I get you or did I fail terribly in understanding the point you are
> making here?

Makes sense

Thanks,
Jean
