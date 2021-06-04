Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311DC39B46E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 09:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhFDH6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 03:58:49 -0400
Received: from smtprelay0245.hostedemail.com ([216.40.44.245]:57952 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229958AbhFDH6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 03:58:48 -0400
Received: from omf02.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 7ADCD182251AE;
        Fri,  4 Jun 2021 07:57:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 4569E1D42F9;
        Fri,  4 Jun 2021 07:57:01 +0000 (UTC)
Message-ID: <3556ef50697435a04d8bbbc4a9201f3a2323476d.camel@perches.com>
Subject: Re: [PATCH] uacce: add print information if not enable sva
From:   Joe Perches <joe@perches.com>
To:     Kai Ye <yekai13@huawei.com>, gregkh@linuxfoundation.org,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangfei.gao@linaro.org,
        wangzhou1@hisilicon.com
Date:   Fri, 04 Jun 2021 00:57:00 -0700
In-Reply-To: <1622792769-28017-1-git-send-email-yekai13@huawei.com>
References: <1622792769-28017-1-git-send-email-yekai13@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.10
X-Stat-Signature: amr4ij5i7epmhpq4nz9kqcxkmemmooiy
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 4569E1D42F9
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+s71xQa1j6FN3QsfJ9EBLVIRaRT/RVrIA=
X-HE-Tag: 1622793421-873518
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-06-04 at 15:46 +0800, Kai Ye wrote:
> Add print information necessary if user not enable sva.
[]
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
[]
> @@ -387,15 +387,22 @@ static void uacce_release(struct device *dev)
>  
> 
>  static unsigned int uacce_enable_sva(struct device *parent, unsigned int flags)
>  {
> +	int ret;
[]
> +	ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_IOPF);
> +	if (ret) {
> +		dev_err(parent, "failed to enable IOPF feature! ret = %d\n", ret);

Perhaps use %pe, ERR_PTR(ret) to get descriptive error output

> +		dev_err(parent, "failed to enable SVA feature! ret = %d\n", ret);

here too


