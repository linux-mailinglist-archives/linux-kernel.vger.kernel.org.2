Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5013CD014
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 11:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbhGSI1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 04:27:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235844AbhGSI1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 04:27:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE1BA600CD;
        Mon, 19 Jul 2021 09:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626685679;
        bh=od5XSDQTfWU6h3EBK31swNvCr2oAj09MRWLUd2Bmnk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jtQXNI4SmLk8EtT5ECK7dKulrmM27pE6h63WGyxaR8Zhvmv3AptHX4KRl98JRmYhe
         HXR3DKCvblTMrhg+ZmnL+GmB2q3l9rrTWyjz4E5Cm5HZngF7KQJp1EiYwTguPwAB/j
         koLO92gxFUnUzu26HblHWuQOSG5oQu2t0LrrTS5NLTLZuIWZel2X9pOLkH57LHxGRx
         LWv4Yy3Ke3k/6jk2tuUbzqlvudtBqSMgd6W0wUZh3EK23eC3jmAyV2O6ZXDA9eLL6F
         MJrVkaLMT98XhmlWbWORhGQxvay7vs+ybFoyINZRkQ14E6eneZ/X/1olMf+HUdCNTE
         LtJqIr02RyIHw==
Date:   Mon, 19 Jul 2021 10:07:54 +0100
From:   Will Deacon <will@kernel.org>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] iommu/amd: Convert from atomic_t to refcount_t on
 device_state->count
Message-ID: <20210719090754.GB6221@willie-the-truck>
References: <1626674437-56007-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626674437-56007-1-git-send-email-xiyuyang19@fudan.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 02:00:37PM +0800, Xiyu Yang wrote:
> refcount_t type and corresponding API can protect refcounters from
> accidental underflow and overflow and further use-after-free situations.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
>  drivers/iommu/amd/iommu_v2.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Can pasid_state::count be converted similarly?

Will
