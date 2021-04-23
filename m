Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EE9369298
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 15:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242541AbhDWNBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 09:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhDWNBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:01:45 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82148C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 06:01:08 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id e7so57282659edu.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 06:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2rHamcAk69i1heErTD043nvHWdBaYcGMYqk0SxlLX3w=;
        b=AI4OF1eHAcLvyWD6iouxBu3wzPXbE7lqxD/nvUDlUK6sCGPvqEiURU18cQsgP60E9B
         79XpQibjTf/FlzQDqoN1m5Xox0apvDhFykYVGLADrOrtndSOh4jcTHehoSL6CP5+tm3A
         K0hA7VUPU7KcWWquu+KenypCJDq2PzLWPT13f3BEr3icJCOt6wvTHM2Vbdp3dw0p4ELx
         dJMs/UerJVfhV13oS+6JAVOptYzHzjOwPt3NZPtEdroHfd5ogVdtz78kjCWB/KMlKxrO
         UeVaHJ8m1HYcZ0RhK4C8RpAYQU5X1LCldsFsS/aQlKYGbqWoMuPE27tWoUwBkuhT49t9
         nruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2rHamcAk69i1heErTD043nvHWdBaYcGMYqk0SxlLX3w=;
        b=t/WUwsADUIHn7GmN/+cMnt0lpkP8P9f2YtuwD2F91V6mU/F/c9epUGSsmLauYVla5l
         X4f5wQnMOxqhmL5ICPM1aaYhXLIgL6E3gWO0zGIvMlUfRWCNecicrtdVlUMnBR1C8JB5
         n6244RtgWZBkpRKS81Gg2u3iGihUVuVc90XnRa5Se8HUK0Ep6FoCA9107/eMh5D7rDO5
         R/FB8dFwydXNllQk0D0t77VaxjJ13jqRJdhJchKZBnslTlkPIl7eHM4VvaH4lR9YDvxG
         Xj8FhW2qj9rfiSVNpSlqovO2F5sZ63+0YV6g3ZYhABsaN0/QUmxlu1uPbNHbwiZDpg5b
         NfQQ==
X-Gm-Message-State: AOAM531kbNmXfaHmDBTpmFegOymchWnGpPFtNni8dRxK1ypR4d8qAELA
        KBGbUlJOtJ7Xgy5csoj0iF/Xsg==
X-Google-Smtp-Source: ABdhPJyDrw4UO6yanfUyRpsU9b8VpZWr1Al+SSF6+YcbsniqaahON/TAvV32FxXYlw+iumrp6+ExVg==
X-Received: by 2002:a05:6402:4d1:: with SMTP id n17mr4292611edw.118.1619182867214;
        Fri, 23 Apr 2021 06:01:07 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id d14sm4537418edc.11.2021.04.23.06.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 06:01:06 -0700 (PDT)
Date:   Fri, 23 Apr 2021 15:00:48 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     eric.auger@redhat.com, alex.williamson@redhat.com,
        eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org,
        jiangkunkun@huawei.com, joro@8bytes.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        lushenming@huawei.com, maz@kernel.org, robin.murphy@arm.com,
        tn@semihalf.com, vivek.gautam@arm.com, vsethi@nvidia.com,
        wangxingang5@huawei.com, will@kernel.org, zhangfei.gao@linaro.org,
        zhukeqian1@huawei.com, vdumpa@nvidia.com
Subject: Re: [PATCH v14 00/13] SMMUv3 Nested Stage Setup (IOMMU part)
Message-ID: <YILFAJ50aqvkQaT/@myrica>
References: <f99d8af1-425b-f1d5-83db-20e32b856143@redhat.com>
 <1619103878-6664-1-git-send-email-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619103878-6664-1-git-send-email-sumitg@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

On Thu, Apr 22, 2021 at 08:34:38PM +0530, Sumit Gupta wrote:
> Had to revert patch "mm: notify remote TLBs when dirtying a PTE".

Did that patch cause any issue, or is it just not needed on your system?
It fixes an hypothetical problem with the way ATS is implemented. Maybe I
actually observed it on an old software model, I don't remember. Either
way it's unlikely to go upstream but I'd like to know if I should drop it
from my tree.

Thanks,
Jean
