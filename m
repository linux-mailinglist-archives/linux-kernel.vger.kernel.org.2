Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9A634BCC2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 17:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhC1PKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 11:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231131AbhC1PJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 11:09:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B79F361942;
        Sun, 28 Mar 2021 15:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616944197;
        bh=g9C2EhJKfVyGbLCoeubeo7Tdn9zadBq1c5n9n9qcnxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lncTz5h1q+7BVNXEizEHrZGW/yiQYoLimekC7ZK+51js+Bifih2yHpy7kD7g+8Ip3
         AUTzKyWs2zhZpd5DT8AmDVNuKo+BfXcWW62rRZfeTjOkUA5aivh5zNv4AhGJX59WtF
         0fhCUseY0WZZ+ZaGeUHdM7AOItse+oi8w11KFlm4=
Date:   Sun, 28 Mar 2021 17:09:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hui Tang <tanghui20@huawei.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, xuzaibo@huawei.com,
        wangzhou1@hisilicon.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: hisilicon - check if debugfs opened
Message-ID: <YGCcQnFHXEMW9Jz/@kroah.com>
References: <1616833980-11006-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616833980-11006-1-git-send-email-tanghui20@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2021 at 04:33:00PM +0800, Hui Tang wrote:
> 'xx_debugfs_init' check if debugfs opened.
> 
> Signed-off-by: Hui Tang <tanghui20@huawei.com>
> ---
>  drivers/crypto/hisilicon/hpre/hpre_main.c | 5 ++++-
>  drivers/crypto/hisilicon/qm.c             | 3 +++
>  drivers/crypto/hisilicon/sec2/sec_main.c  | 5 ++++-
>  drivers/crypto/hisilicon/zip/zip_main.c   | 3 +++
>  4 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
> index c7ab06d..f2605c4 100644
> --- a/drivers/crypto/hisilicon/hpre/hpre_main.c
> +++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
> @@ -779,6 +779,9 @@ static int hpre_debugfs_init(struct hisi_qm *qm)
>  	struct device *dev = &qm->pdev->dev;
>  	int ret;
>  
> +	if (!debugfs_initialized())
> +		return -ENOENT;

Why?  What does this help with?  Why does the code care if debugfs is
running or not?

thanks,

greg k-h
