Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015C1343010
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 23:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhCTWg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 18:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhCTWf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 18:35:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC3FC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 15:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tYD1zTXwi92smTfKE8CvJzwKxA3zx83XVMi1r8ITa8c=; b=aapRal+BLYRQmwdJlyGZsEhI+Z
        0CNy7KZphLL1JuoBWMyGNLrctMD3QG71gsGsfKWEr9oe4edAUPb7fgBPiaH6YIVzPiZyD3Qu8q7/i
        JIcryfypVWOLFqBUhKTw0dlmG3IVkCB6jYr6mkGIqpF5biIvHLEQYns5jMvoM4cB66OQoWXEXtG1b
        85FtS6dn2N26kdaFtIc8MgbdrXwiqEYJXh7B7bo7ARJJ6cyfeoSg4XSSXDjXJoQBVgpNGGjVFjf9r
        fx2vDL76/GKGc3WzybQuCxeR+TyRe5MPYlFs32EzkyMIIVxjyjzjynBA3ytGj0Q3LQIK3op+HTE8+
        3t2zBkNw==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNkC7-0024Ww-7Q; Sat, 20 Mar 2021 22:35:44 +0000
Date:   Sat, 20 Mar 2021 15:35:43 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     gregkh@linuxfoundation.org, saravanak@google.com,
        heikki.krogerus@linux.intel.com, rafael.j.wysocki@intel.com,
        lukasz.luba@arm.com, jroedel@suse.de, bgolaszewski@baylibre.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Trivial typo fix
In-Reply-To: <20210320201240.23745-1-unixbhaskar@gmail.com>
Message-ID: <d80e3a8-ed9e-ac54-2522-7ebad255d01a@bombadil.infradead.org>
References: <20210320201240.23745-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210320_153543_289799_E126E8C7 
X-CRM114-Status: GOOD (  12.32  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Sun, 21 Mar 2021, Bhaskar Chowdhury wrote: > s/subsytem/subsystem/
    > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com> Acked-by: Randy
    Dunlap <rdunlap@infradead.org> 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Mar 2021, Bhaskar Chowdhury wrote:

> s/subsytem/subsystem/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> include/linux/device.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/device.h b/include/linux/device.h
> index ba660731bd25..a8ce0dc3b758 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -49,7 +49,7 @@ struct dev_iommu;
> /**
>  * struct subsys_interface - interfaces to device functions
>  * @name:       name of the device function
> - * @subsys:     subsytem of the devices to attach to
> + * @subsys:     subsystem of the devices to attach to
>  * @node:       the list of functions registered at the subsystem
>  * @add_dev:    device hookup to device function handler
>  * @remove_dev: device hookup to device function handler
> --
> 2.26.2
>
>
