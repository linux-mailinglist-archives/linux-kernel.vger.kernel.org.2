Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9214F33A3DB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 10:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbhCNJ0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 05:26:18 -0400
Received: from einhorn-mail-out.in-berlin.de ([217.197.80.21]:52823 "EHLO
        einhorn-mail-out.in-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229495AbhCNJ0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 05:26:13 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from authenticated.user (localhost [127.0.0.1]) by einhorn.in-berlin.de  with ESMTPSA id 12E9KeEg004322
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 14 Mar 2021 10:20:41 +0100
Date:   Sun, 14 Mar 2021 10:20:39 +0100
From:   Stefan Richter <stefanr@s5r6.in-berlin.de>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: Use bitwise instead of arithmetic operator
 for flags
Message-ID: <20210314102039.21bbb75d@kant>
In-Reply-To: <1615273899-88446-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1615273899-88446-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 09 Jiapeng Chong wrote:
> Fix the following coccicheck warnings:
> 
> ./drivers/firewire/core-device.c:973:22-23: WARNING: sum of probable
> bitmasks, consider |.
> 
> ./drivers/firewire/core-device.c:954:22-23: WARNING: sum of probable
> bitmasks, consider |.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/firewire/core-device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
> index 6821698..e04832d 100644
> --- a/drivers/firewire/core-device.c
> +++ b/drivers/firewire/core-device.c
> @@ -951,7 +951,7 @@ static void set_broadcast_channel(struct fw_device *device, int generation)
>  	if (device->bc_implemented == BC_UNKNOWN) {
>  		rcode = fw_run_transaction(card, TCODE_READ_QUADLET_REQUEST,
>  				device->node_id, generation, device->max_speed,
> -				CSR_REGISTER_BASE + CSR_BROADCAST_CHANNEL,
> +				CSR_REGISTER_BASE | CSR_BROADCAST_CHANNEL,
>  				&data, 4);
>  		switch (rcode) {
>  		case RCODE_COMPLETE:
> @@ -970,7 +970,7 @@ static void set_broadcast_channel(struct fw_device *device, int generation)
>  				   BROADCAST_CHANNEL_VALID);
>  		fw_run_transaction(card, TCODE_WRITE_QUADLET_REQUEST,
>  				device->node_id, generation, device->max_speed,
> -				CSR_REGISTER_BASE + CSR_BROADCAST_CHANNEL,
> +				CSR_REGISTER_BASE | CSR_BROADCAST_CHANNEL,
>  				&data, 4);
>  	}
>  }

It's "base address + address offset". The arithmetic operator is correct.
-- 
Stefan Richter
-======--=-= --== -===-
http://arcgraph.de/sr/
