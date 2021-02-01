Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128C830AAE2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhBAPQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhBAPQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:16:31 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF1EC0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 07:15:50 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o5so3311673wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 07:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iCud/oZ0jp00VRdDLSDWa/VPzMcKe48VJwPVpyKJcE8=;
        b=bljmv40viwV5v57+TtBOFwGAaz54F5a9tDXB2PSZe5+LMS1pOd9d8QiRNcEEtmVfmT
         pdNUcTuIXIUH3CaAc+wpyhYC5hKvmCSEj3iNLAZHozaqd/vHgd82MB0cpAg+LE90lF16
         4P26uy+BK3EEMlaZGLfJlDisoXkiQ0huHLkrVAmKcmxDHmxRD8LzSGmdL2Cr3wzW5T7M
         zg97INgmlfCsvWBOEZA+9NcyNVwamwDVUFyds+AxAL8QQh5KBvfc3PUTwvICN//HHTDZ
         qkNaJJ1NQUcUnxMsjuP69oEL1TAKNDjTmwV8/PCUe7VrMoqb6akq/NuC0JNy5Wkan48Y
         G81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iCud/oZ0jp00VRdDLSDWa/VPzMcKe48VJwPVpyKJcE8=;
        b=QlrEACqfWWrjHGWZopwKXI8pHHdsOPczTlF2L3KJhszmoh+Stp5YyToYp1MtaX0hEt
         va4wvMfJMCL2DVseTmiL4to9pj9qpKyVt40sLFqTpQvQQzSsReRK/afGEzXj2mAm4YSp
         bkseLXUdv48wkhxnyhNvZLXocH7ylXf57Jx7tJwcWva8LxH3qt4uZgfkd2VxmRz7gwjA
         bwKG0bWMdlg+Mwk2NlbnybsBkuLngKG0lm2dLgukhbCHrePuu0+CgDCI3+YApxlDMyLN
         G7zxGIYhE5V1LLWbIU3OEh9Th33MHtcDXAdI7WCrNRCGXmEa9RBsIJ/owx8Kyb+yXV8/
         5tJg==
X-Gm-Message-State: AOAM5320QfWdHSPjRePCoCvqn9peYM0s9l9YHGzfsQPGJF7mPgrqA/XU
        WiGvuotP2kiRvdDOdk7dpgWI2w==
X-Google-Smtp-Source: ABdhPJxyP1BG+oDXc31HY7CW5MYwKqTaLbVBSjGD3rpSrDcbzKlD5YRXlGtJCbFbmp87GaK0VAFutQ==
X-Received: by 2002:a7b:c8c3:: with SMTP id f3mr15569794wml.110.1612192549227;
        Mon, 01 Feb 2021 07:15:49 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y11sm26855292wrh.16.2021.02.01.07.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 07:15:48 -0800 (PST)
Date:   Mon, 1 Feb 2021 16:15:29 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Keqian Zhu <zhukeqian1@huawei.com>
Cc:     Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, will@kernel.org,
        joro@8bytes.org, maz@kernel.org, robin.murphy@arm.com,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        nicoleotsuka@gmail.com, vivek.gautam@arm.com, yi.l.liu@intel.com,
        zhangfei.gao@linaro.org
Subject: Re: [PATCH v13 03/15] iommu/arm-smmu-v3: Maintain a SID->device
 structure
Message-ID: <YBgbESEyReLV124Z@myrica>
References: <20201118112151.25412-1-eric.auger@redhat.com>
 <20201118112151.25412-4-eric.auger@redhat.com>
 <a5cc1635-b69b-50a6-404a-5bf667296669@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5cc1635-b69b-50a6-404a-5bf667296669@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 08:26:41PM +0800, Keqian Zhu wrote:
> > +static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
> > +				  struct arm_smmu_master *master)
> > +{
> > +	int i;
> > +	int ret = 0;
> > +	struct arm_smmu_stream *new_stream, *cur_stream;
> > +	struct rb_node **new_node, *parent_node = NULL;
> > +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
> > +
> > +	master->streams = kcalloc(fwspec->num_ids,
> > +				  sizeof(struct arm_smmu_stream), GFP_KERNEL);
> > +	if (!master->streams)
> > +		return -ENOMEM;
> > +	master->num_streams = fwspec->num_ids;
> This is not roll-backed when fail.

No need, the caller frees master

> > +
> > +	mutex_lock(&smmu->streams_mutex);
> > +	for (i = 0; i < fwspec->num_ids && !ret; i++) {
> Check ret at here, makes it hard to decide the start index of rollback.
> 
> If we fail at here, then start index is (i-2).
> If we fail in the loop, then start index is (i-1).
> 
[...]
> > +	if (ret) {
> > +		for (; i > 0; i--)
> should be (i >= 0)?
> And the start index seems not correct.

Indeed, this whole bit is wrong. I'll fix it while resending the IOPF
series.

Thanks,
Jean

