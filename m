Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB08336D51F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 11:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbhD1Jz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 05:55:27 -0400
Received: from foss.arm.com ([217.140.110.172]:38510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238658AbhD1JzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 05:55:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40DD81FB;
        Wed, 28 Apr 2021 02:54:39 -0700 (PDT)
Received: from bogus (unknown [10.57.61.96])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44EDC3F70D;
        Wed, 28 Apr 2021 02:54:38 -0700 (PDT)
Date:   Wed, 28 Apr 2021 10:54:32 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Yang Li <yang.lee@linux.alibaba.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, arm@kernel.org
Subject: Re: [PATCH] psci: remove unneeded semicolon
Message-ID: <20210428095432.bmewlodcoficxmhj@bogus>
References: <1612247872-32603-1-git-send-email-yang.lee@linux.alibaba.com>
 <20210428094121.GA6543@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210428094121.GA6543@lpieralisi>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 10:41:30AM +0100, Lorenzo Pieralisi wrote:
> On Tue, Feb 02, 2021 at 02:37:52PM +0800, Yang Li wrote:
> > Eliminate the following coccicheck warning:
> > ./drivers/firmware/psci/psci.c:141:2-3: Unneeded semicolon
> 
> Nit: subject should read "psci: Remove unneeded semicolon"
> 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> > ---
> >  drivers/firmware/psci/psci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Please send a v2 and address it to Mark, me and arm@kernel.org so
> that they can pick it up.
> 

Though I assume they still check arm@kernel.org, soc@kernel.org is new
and more preferred these days. I just checked MAINTAINERS entry to be
sure and I see only soc@kernel.org. So please add soc@kernel.org to the
list, may be it gets quicker attention than the other 😄.

-- 
Regards,
Sudeep
