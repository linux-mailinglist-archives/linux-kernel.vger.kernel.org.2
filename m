Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718F93E13AD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 13:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbhHELSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 07:18:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232896AbhHELSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 07:18:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01ED2600EF;
        Thu,  5 Aug 2021 11:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628162269;
        bh=AsV/wDbpXC+UOCKSfs8l5fzQWjjqdm3HA4mMajue9/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jcAzjAPrg3YBlPkj1H7r6YAfJXoCH1Ndh5cB22qa4K4rV3uuq5NbbafmcItCgLpO7
         YgEAAt/Yk2A07O9Y3RqHm8KPmqL0S+EgcwGr27LI9ajPA3QbCaFdcOypiy7fu7vMTw
         TwHj1njGqqru3KEW8Iqwc/5ks7zg9IP2YPOuYd8E=
Date:   Thu, 5 Aug 2021 13:17:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jhih-Ming Huang <fbihjmeric@gmail.com>
Cc:     fabioaiuto83@gmail.com, ross.schm.dev@gmail.com,
        maqianga@uniontech.com, marcocesati@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v7] rtw_security: fix cast to restricted __le32
Message-ID: <YQvI2z/W+Crfb4CE@kroah.com>
References: <YOIGbc2ymnWrThVK@kroah.com>
 <20210801155152.242089-1-fbihjmeric@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210801155152.242089-1-fbihjmeric@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2021 at 11:51:52PM +0800, Jhih-Ming Huang wrote:
> This patch fixes the sparse warning of fix cast to restricted __le32.
> 
> There was a change for replacing private CRC-32 routines with in kernel
> ones.
> However, the author used le32_to_cpu to convert crc32_le(), and we
> should use cpu_to_le32.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jhih-Ming Huang <fbihjmeric@gmail.com>
> ---
>  changes from v6:
>    using get_unaligned_le32 to get the value and comparing it with crc,
>    instead of using memcmp with raw pointers.
> 
>  drivers/staging/rtl8723bs/core/rtw_security.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)

Does not apply to the tree :(
