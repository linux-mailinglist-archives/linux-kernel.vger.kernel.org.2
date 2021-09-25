Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B56418088
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 10:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbhIYIuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 04:50:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232496AbhIYIuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 04:50:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26F9F610C7;
        Sat, 25 Sep 2021 08:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632559718;
        bh=kOALjrE3Ed1eIL1NVXTgg6iiD9N0Q2UyVPeE+gNnpKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p1kbrigw7fqRPqBFcGlkoRWr0j17YkMLqQ7snlckfnrO8BI4RQWGbfMPzKgtrzV4n
         1fW5zFYyCbpRC6gNoOBZh1Y0vTUg8tWgw0xnN0ouXfAe2QeV+y/iDnizKuS9hTAc1r
         S4a55eHJWXJYBgYtgn2zUwCNSdRaNlEvPjbwvXXI=
Date:   Sat, 25 Sep 2021 10:48:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Yujia Qiao <rapiz@foxmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] staging: vt6655: replace camel case
 b_short_slot_time instead of bShortSlotTime.
Message-ID: <YU7iYvVrZNmrkh0F@kroah.com>
References: <20210925083350.13996-1-tomm.merciai@gmail.com>
 <20210925083350.13996-2-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210925083350.13996-2-tomm.merciai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2021 at 10:33:42AM +0200, Tommaso Merciai wrote:
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> ---
> Changes since v3:
>  - Fix patch changelog.

I see nothing "fixed" here :(

