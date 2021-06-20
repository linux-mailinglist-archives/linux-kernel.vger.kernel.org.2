Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E0F3ADE1C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 13:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhFTLTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 07:19:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbhFTLTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 07:19:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FB9F6108E;
        Sun, 20 Jun 2021 11:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624187847;
        bh=OfUiVNmBFTHlrsfW6CzlrHT/dZVKq3gESxQTYa6X/WY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i2ZZhgWRRC+5tj5S8vgp2GEx3lnCTHSrIFOckDydhZ/zi115ukcX6jOyTWF+WkTx/
         95tna5wknOSf3FkZXvkbpuHG9xsHocZYpFtajSTFeoXS5at8ziNxiDGerw9t5o5Nyb
         NY8ou0pqspqxQvQT5Xz9R3R37NFKhUyZHYhMbDBAiXBLx1NND+9ZQXdqwiZhA35r0y
         An2kCwRin5WZ1fSQe3idUA7TMoDcP2oTm1lh03mDD6PrlfH5g3RM8SGjeLyq8uIVDz
         UCAzVnHkvGTXwHNxNDzqiFdBgpc+AtfPIa2mXHrakRyuYY4Eqa17D1V1XKER16apyX
         Lz2C+vQ7c3/uA==
Date:   Sun, 20 Jun 2021 16:47:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v2] soundwire: bus: Make sdw_nwrite() data pointer
 argument const
Message-ID: <YM8jwosKEbNlVXkp@vkoul-mobl>
References: <20210616145901.29402-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616145901.29402-1-rf@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-06-21, 15:59, Richard Fitzgerald wrote:
> Idiomatically, write functions should take const pointers to the
> data buffer, as they don't change the data. They are also likely
> to be called from functions that receive a const data pointer.
> 
> Internally the pointer is passed to function/structs shared with
> the read functions, requiring a cast, but this is an implementation
> detail that should be hidden by the public API.

Applied, thanks

-- 
~Vinod
