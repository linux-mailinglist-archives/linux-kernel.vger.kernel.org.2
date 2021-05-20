Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD5438A001
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhETIl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:41:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231208AbhETIl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:41:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7023860E09;
        Thu, 20 May 2021 08:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621500036;
        bh=9lMFE/wOwBjZrwNwRhEMmXbUPibX8C5KbGbXR7vX1Ik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JDVbF+LV3KbT3feNmZ7ctQnbsm8METdwil3rB9cebi2S08lFMi88QvAi7DZKh9l8c
         Vp40W+3XgSse8WpKibMC6iA2Yg91S/GUGJlvA4Z4VFp2Vb8JAqRkH8BgavRjd9lpdJ
         XFQNWaYdqeKtf1rKoeITxKJw2RaWZKdVAmqZclbtUx04K8OvZ13WvDWJW9kUFPwWMm
         +iL4XPqNf8Tycw5XeSgRHZdG12yv1Dr+AWKuYakSq69IDB3L2qMtahkBLcExss+2Hm
         /6vQIg67Ou81VCyhkmXhAeUOuPiU1x6Zu1DobmGjJM2bB1Jk6Zo9s7i+8kAr6r/RtK
         j6495jlX4l1Iw==
Date:   Thu, 20 May 2021 16:40:24 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Pratik Shinde <pratikshinde320@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>, Gao Xiang <xiang@kernel.org>,
        linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH -next] erofs: fix error return code in
 erofs_read_superblock()
Message-ID: <20210520084023.GA5720@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20210519141657.3062715-1-weiyongjun1@huawei.com>
 <20210520053226.GB1955@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210520053226.GB1955@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yongjun and Dan,

On Thu, May 20, 2021 at 08:32:26AM +0300, Dan Carpenter wrote:
> On Wed, May 19, 2021 at 02:16:57PM +0000, Wei Yongjun wrote:
> > 'ret' will be overwritten to 0 if erofs_sb_has_sb_chksum() return true,
> > thus 0 will return in some error handling cases. Fix to return negative
> > error code -EINVAL instead of 0.
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> 
> You need to add Fixes tags to bug fix patches and you need to ensure
> that the authors of the Fixes commit are CC'd so they can review your
> fix.  get_maintainer.pl will add the author automatically, but normally
> I like to put them in the To header to make sure they see it.
> 
> Fixes: b858a4844cfb ("erofs: support superblock checksum")

The commit and the tag look good to me (sorry for a bit delay on this),

Fixes: b858a4844cfb ("erofs: support superblock checksum")
Cc: stable <stable@vger.kernel.org> # 5.5+
Reviewed-by: Gao Xiang <xiang@kernel.org>

(will apply to dev-test for a while and then to -next.)

Thanks,
Gao Xiang

