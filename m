Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5234379EDC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 06:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhEKE4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 00:56:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230169AbhEKE4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 00:56:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D02BA6191D;
        Tue, 11 May 2021 04:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620708927;
        bh=RIFK/PTnpqzjwd06ZD8D2fdlb5wl0fYV98WQSJOC/xU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zii1JXNdixeez4YLjpqpbbdSkNJFFIdcglffWdF3PVwGhDc8HZWcJOyw9F9dZ0etH
         YOqpoYP2zHXO/IfU0O+EhlQVeejzqE60Bz5+e7jps/NTquO5SUrz12Sc2vnypf6Izn
         r2Dm2FcZzPPl31IQfO6qlTeRqjoZevypY3JRTtPIBoI0LgaH5LpiBIMWVEIb1kugXt
         Xe9cHqedTX6g3lFWXY4r6iiyQOKCijOGJNurpokbIImFN5rNh4NVA4tgfHYrAVPpEc
         7iBp6408YNc+sjnwimIIjFvD3+mTZWAKXnJh+54vrmQQUfcCroARAjXiERTcgfCMkx
         66ZnVZZNgk1Pg==
Date:   Tue, 11 May 2021 07:55:23 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kael_w@yeah.net
Subject: Re: [PATCH] RDMA: Remove unnecessary struct declaration
Message-ID: <YJoOO+WMuy9x9Ets@unreal>
References: <20210510062843.15707-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510062843.15707-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 02:28:42PM +0800, Wan Jiabing wrote:
> The declaration of struct ib_grh is uncessary here,
> because it is defined at line 766.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  include/rdma/ib_verbs.h | 1 -
>  1 file changed, 1 deletion(-)
> 

I'm pretty sure that my ROB is not needed, but anyway.

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

Thanks
