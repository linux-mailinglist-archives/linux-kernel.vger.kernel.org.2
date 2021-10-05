Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437464223A2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbhJEKg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:36:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232723AbhJEKgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:36:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B79261131;
        Tue,  5 Oct 2021 10:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633430105;
        bh=tPRSe+sMGLMk0DEatVSdVYaqyhvvz0YMaXtWMarFKAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uxPZayo3ns80cG6GBoZnUYwBGG0P4nH/VwSvtxVE5aAyzZqd2hA2UM6B1t1tqRluB
         kYHmmPOCFhM8lWxYtpdiD3Dw+fAM+8uIlKbN8V8pdblrCH/fGTXtDliHcnoFsXF1Gw
         zKPQPrD/bPSAoX/bb2PgqO+JvQuAmq/wXf8nYunPutvl52Vt5F13KwDHiFTaZdS5lN
         7iyl0DcMtzubUGz9X5I3OTmsS0NYRiVUkA2QCQkLTV35AltcAWD/akKmsEUs71wVJR
         +dONcCwUHO1Ryo7Zck1dtw2hcsrorcY9gBoT3Zv3e/121OVGiE1ACu3t4BkePxJx7y
         myL+d6MzeKd8A==
Date:   Tue, 5 Oct 2021 16:05:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "A, Rashmi" <rashmi.a@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon <kishon@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        Mark Gross <mgross@linux.intel.com>,
        "kris.pan@linux.intel.com" <kris.pan@linux.intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>,
        "Srikandan, Nandhini" <nandhini.srikandan@intel.com>
Subject: Re: [PATCH v2 0/4] Add support of eMMC PHY for Intel Thunder Bay
Message-ID: <YVwqVRkwAYnoJR6x@matsya>
References: <20210829182443.30802-1-rashmi.a@intel.com>
 <CAPDyKFq2VQ=khYnmfsQGPPcpRnxyATVSpwKSZ4MTbKn64rthVA@mail.gmail.com>
 <DM6PR11MB306560AE06F83FC56B9F89988CAE9@DM6PR11MB3065.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB306560AE06F83FC56B9F89988CAE9@DM6PR11MB3065.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-10-21, 06:04, A, Rashmi wrote:

> Applied patch1 and patch2 for next, thus leaving the phy changes in
> patch3 and patch 4 for Kishon/Vinod to pick up.
> 
> Thanks and kind regards
> Uffe
> 
> 
> Thanks Uffe, 
> Hi Kishon/Vinod,  
> 	Please let me know if you have any comments

Need ack from Rob on binding patch

-- 
~Vinod
