Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C07F37607B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhEGGkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:49578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230007AbhEGGkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:40:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E2EB613C2;
        Fri,  7 May 2021 06:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620369563;
        bh=c3d7dymFXiq6stuNWLRIYzL07V5AfPuPEUz1cUVvTi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZBQi6HXFc6xYPZTsJstosCYIiEjKj4RuCtf0r7PAUwEKLU5ZFLEvZNi4e/gydtmXJ
         uactbMNwy9BiAHpyMSOnU5YYOCIp4+jI/CIW7ZGvCeyTFXK2B8KeZ2pSRV8T0U90FB
         2HZmMzwIsd9v1dRxaouTo5gHCKw6dZHsBpyMtyEk=
Date:   Fri, 7 May 2021 08:39:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Anirudh Rayabharam <mail@anirudhrb.com>
Cc:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rapidio: fix unused variable warning in rio_cm.c
Message-ID: <YJTgmXwZyOgFPIHf@kroah.com>
References: <20210506181837.4758-1-mail@anirudhrb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210506181837.4758-1-mail@anirudhrb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 11:48:36PM +0530, Anirudh Rayabharam wrote:
> GCC produces an unused variable warning for 'rc':
> 
> 	drivers/rapidio/rio_cm.c: In function ‘rio_txcq_handler’:
> 	drivers/rapidio/rio_cm.c:673:7: warning: variable ‘rc’ set but
> 	not used [-Wunused-but-set-variable]
> 
> The return value of rio_add_outb_message() is assigned to 'rc' but it
> is never used. Fix this warning by logging an error if 'rc' is non-zero.
> 
> Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> ---
> 
> Changes in v2:
> Log an error instead of just removing 'rc'.
> 
> v1: https://lore.kernel.org/lkml/20210501055018.9244-1-mail@anirudhrb.com/
> 
> ---
>  drivers/rapidio/rio_cm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
> index 50ec53d67a4c..971a36f1a23a 100644
> --- a/drivers/rapidio/rio_cm.c
> +++ b/drivers/rapidio/rio_cm.c
> @@ -677,6 +677,11 @@ static void rio_txcq_handler(struct cm_dev *cm, int slot)
>  			cm->tx_buf[cm->tx_slot] = req->buffer;
>  			rc = rio_add_outb_message(cm->mport, req->rdev, cmbox,
>  						  req->buffer, req->len);
> +			if (rc) {
> +				riocm_error("Failed to add msg to tx queue (err=%d)",
> +						rc);

That's pretty pointless (and no need for {}).

If an error happens, properly recover from it, don't just punt and tell
the user something bad happened and then ignore it.

thanks,

greg k-h
