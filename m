Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CD63706D0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 12:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhEAKYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 06:24:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231819AbhEAKYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 06:24:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D0E4613C6;
        Sat,  1 May 2021 10:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619864612;
        bh=ZQ5/Bd9dgaWBN1kInWuLHSCQJfYNRchdvGct/JB3d3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n7OtcFmn7uZbMMZgIoz71UxbAOtt1ZlsZyTtBaRbiHUcMSACrg3Y0aH1KQ/7XTbXj
         ZU5N2gQ5WVzR70B0qq79PD9xZVUYG/MbQjr2RHiineUfACMcSOtcL3Yl93x8kQrLeG
         AJISZopmfGvCq8I681FMERnyZcgJ+oym+OyqZEzE=
Date:   Sat, 1 May 2021 12:23:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Anirudh Rayabharam <mail@anirudhrb.com>
Cc:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rapidio: remove unused variable in rio_cm.c
Message-ID: <YI0sIoDv6H+aSyNE@kroah.com>
References: <20210501055018.9244-1-mail@anirudhrb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210501055018.9244-1-mail@anirudhrb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2021 at 11:20:17AM +0530, Anirudh Rayabharam wrote:
> Remove unused variable 'rc' to fix gcc warning:
> 
> 	drivers/rapidio/rio_cm.c: In function ‘rio_txcq_handler’:
> 	drivers/rapidio/rio_cm.c:673:7: warning: variable ‘rc’ set but
> 	not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> ---
>  drivers/rapidio/rio_cm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
> index 50ec53d67a4c..545693bd86a3 100644
> --- a/drivers/rapidio/rio_cm.c
> +++ b/drivers/rapidio/rio_cm.c
> @@ -670,12 +670,11 @@ static void rio_txcq_handler(struct cm_dev *cm, int slot)
>  	 */
>  	if (!list_empty(&cm->tx_reqs) && (cm->tx_cnt < RIOCM_TX_RING_SIZE)) {
>  		struct tx_req *req, *_req;
> -		int rc;
>  
>  		list_for_each_entry_safe(req, _req, &cm->tx_reqs, node) {
>  			list_del(&req->node);
>  			cm->tx_buf[cm->tx_slot] = req->buffer;
> -			rc = rio_add_outb_message(cm->mport, req->rdev, cmbox,
> +			rio_add_outb_message(cm->mport, req->rdev, cmbox,
>  						  req->buffer, req->len);

Why not handle the potential error sent here?

thanks,

greg k-h
