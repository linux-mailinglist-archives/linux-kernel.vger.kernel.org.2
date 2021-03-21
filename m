Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04D234317A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 06:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhCUFud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 01:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhCUFuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 01:50:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68DBC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 22:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ADuYMBPpkte2ps5T45vIAIbddFgYXtwsn562Mtz/fh8=; b=Sf61kHtMeHdfPA1xhUMpYytohV
        7jp9NwrFQuSQ3FUvgiKZfo8fqpN+fc7hD2/XkYHuDpBeeBKrMGEC6d1mxQDXm7E6Q6VLTA98sXqzp
        N6lVJZLFTpUa4tIcttUSW6Gz2UnXdn71VElxmKCJu9lLfncXVymTrakI8A3zjVcHIuYbZvu1ck42Z
        bBuLgdAb5eOXq14ZeB82rAsuWcjX+aEchF9SIhS8J3zZ26J9W+in3MVmCsSsPh4b0pprYAGysbqdw
        b6XUAmnc5LDmMoU0SvNOfj4Gcw/aXrTGOk2cZLauyxFyvaMWDNpKGyEqxfhrHqtcSIiXQgrej3D/U
        lwpGRjdA==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNqyV-002Ba6-AG; Sun, 21 Mar 2021 05:50:08 +0000
Date:   Sat, 20 Mar 2021 22:50:07 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     nsaenzjulienne@suse.de, gregkh@linuxfoundation.org,
        jacopo@jmondi.org, dave.stevenson@raspberrypi.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vchiq: Typo fixes
In-Reply-To: <20210321043629.585758-1-unixbhaskar@gmail.com>
Message-ID: <ee355953-3b45-405a-c0a5-95febb83a24c@bombadil.infradead.org>
References: <20210321043629.585758-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210320_225007_374817_E38FB371 
X-CRM114-Status: GOOD (  10.94  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Sun, 21 Mar 2021, Bhaskar Chowdhury wrote: > > s/sepecific/specific/
    > s/comonent/component/ > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
    Acked-by: Randy Dunlap <rdunlap@infradead.org> 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/sepecific/specific/
> s/comonent/component/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> index 9097bcbd67d8..06bca7be5203 100644
> --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> @@ -432,7 +432,7 @@ buffer_from_host(struct vchiq_mmal_instance *instance,
> 	m.u.buffer_from_host.buffer_header.pts = MMAL_TIME_UNKNOWN;
> 	m.u.buffer_from_host.buffer_header.dts = MMAL_TIME_UNKNOWN;
>
> -	/* clear buffer type sepecific data */
> +	/* clear buffer type specific data */
> 	memset(&m.u.buffer_from_host.buffer_header_type_specific, 0,
> 	       sizeof(m.u.buffer_from_host.buffer_header_type_specific));
>
> @@ -927,7 +927,7 @@ static int port_info_get(struct vchiq_mmal_instance *instance,
> 	return ret;
> }
>
> -/* create comonent on vc */
> +/* create component on vc */
> static int create_component(struct vchiq_mmal_instance *instance,
> 			    struct vchiq_mmal_component *component,
> 			    const char *name)
> --
> 2.31.0
>
>
