Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14365369291
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 15:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242313AbhDWNAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 09:00:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55255 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230305AbhDWNAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619182813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g7QHyavfTK3+kPt5ZWORxDho6Hk1i3SxHdnTlyHPRrA=;
        b=dpUGYBAgTGQ6XXzA1szy5YkcmPQXv7lLI1x/JiqdYnupioazySzvlaUiuYzLjtX+04xrbR
        lbY1NbwGvlMh+72LcUU13XwYlw7L4cyJlGDy9ey+TTNNjZn0SvRYwgQCf9UDlbIPVLVpfK
        1NJoNXGutcAB4Hu2icrlH/TVSK/2s20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-lY14ZFK7Ob2gaZYktQFCLw-1; Fri, 23 Apr 2021 09:00:11 -0400
X-MC-Unique: lY14ZFK7Ob2gaZYktQFCLw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E1248030A0;
        Fri, 23 Apr 2021 13:00:10 +0000 (UTC)
Received: from treble (ovpn-116-203.rdu2.redhat.com [10.10.116.203])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 01EA160854;
        Fri, 23 Apr 2021 13:00:08 +0000 (UTC)
Date:   Fri, 23 Apr 2021 08:00:06 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sunil Goutham <sgoutham@marvell.com>
Subject: Re: [PATCH 136/190] Revert "net: thunder: fix a potential NULL
 pointer dereference"
Message-ID: <20210423130006.fuh3hljkhkrpcvd3@treble>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-137-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-137-gregkh@linuxfoundation.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:11PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 0b31d98d90f09868dce71319615e19cd1f146fb6.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

+Cc: Sunil Goutham <sgoutham@marvell.com>

The original patch looks correct to me.

> ---
>  drivers/net/ethernet/cavium/thunder/nicvf_main.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> index c33b4e837515..b10608c55db0 100644
> --- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> +++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> @@ -2246,12 +2246,6 @@ static int nicvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	nic->nicvf_rx_mode_wq = alloc_ordered_workqueue("nicvf_rx_mode_wq_VF%d",
>  							WQ_MEM_RECLAIM,
>  							nic->vf_id);
> -	if (!nic->nicvf_rx_mode_wq) {
> -		err = -ENOMEM;
> -		dev_err(dev, "Failed to allocate work queue\n");
> -		goto err_unregister_interrupts;
> -	}
> -
>  	INIT_WORK(&nic->rx_mode_work.work, nicvf_set_rx_mode_task);
>  	spin_lock_init(&nic->rx_mode_wq_lock);
>  
> -- 
> 2.31.1
> 

-- 
Josh

