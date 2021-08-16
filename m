Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212AA3ED7CD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 15:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238472AbhHPNmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 09:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbhHPNmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 09:42:49 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B318C05333D
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 06:29:02 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id b10so23278386eju.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 06:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RC1V5xe/NRcvL4rUhNzUeKyyDFkKgwzUwCe/4teWMGI=;
        b=UqDMf56DTErsNFxMUSv48/ZXirgYN6JFk7mqaQjhhyNiD6Kv2Pp38zEkgPQb+wrVNr
         VzL1GSUBzzEr1b/yD0hqWwZootrtBxqNg4uLIWTgQbT+8TOANLofanxJtdrOXsH6y61w
         sg33ZAtuHzMLkwohBnBimz6S7NZQH6+thGSOEZvKALXigounTZWtB6knVGmjFTmZMbl3
         Ro7ez8rMvYBtWZ8ydczcOnqJkEofMd7c7RiEWsbwQBYpnaMa0per6kG44UW8UNQe0CY0
         dsRCTB2KE0Oi5thFrKW6y2ZPmGp7fLLAFJaaEwj7n4QowcCS+ETRIv1aNXuYBmCg+6Vw
         oyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RC1V5xe/NRcvL4rUhNzUeKyyDFkKgwzUwCe/4teWMGI=;
        b=Ht+nItLjisYw4yK7PS/z4PfsUCBWTio6lTkg2Q7d9T17KRKjOVs8KGUKGPZ++WPVx0
         0bOxtHSndB+eXQf07qKZkeruacCVS3u3F33CeBrrB3ObEdrBDb9BfRIo6z8eto/QFryJ
         wrqiEZioPUeURBwhseQB8E7P+9qVW0OnmI9GQEnNCJijLlq6swD0KhYoMptLx6CTv0lD
         dYRH9g8F4EHuEC+MdbJ0ejmuH1N8HC5jhi7jZkrXumFWY0BMAB+qg7CPOYtBHPSPigbq
         ijzmCe7xHfvR5IzfawjMHgzoiDjN6mAFMcefjxJkcNZA0jGMcrsX9z7LoNfYfuJk47h/
         H31w==
X-Gm-Message-State: AOAM5330ZP3OMfYuNU4bFl5C6XKdkisUd5/b3RWe+085uAmJKcl2f5dW
        0UggopuuYQ3aQvnGN/JHbE8UdA==
X-Google-Smtp-Source: ABdhPJzg5Q2yGNtiVPCgYVb9rgz3YWoNA8AxWNsfge0oT4NkacCAAQa/VzZBv0pDYscUroc9QvNbQg==
X-Received: by 2002:a17:907:7896:: with SMTP id ku22mr16781228ejc.166.1629120540739;
        Mon, 16 Aug 2021 06:29:00 -0700 (PDT)
Received: from cephalopod (168.7-181-91.adsl-dyn.isp.belgacom.be. [91.181.7.168])
        by smtp.gmail.com with ESMTPSA id g10sm3689219ejj.44.2021.08.16.06.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 06:29:00 -0700 (PDT)
Date:   Mon, 16 Aug 2021 15:28:58 +0200
From:   Ben Hutchings <ben.hutchings@essensium.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 52/96] net: dsa: microchip: ksz8795: Fix VLAN
 filtering
Message-ID: <20210816132858.GC18930@cephalopod>
References: <20210816125434.948010115@linuxfoundation.org>
 <20210816125436.688497376@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210816125436.688497376@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 03:02:02PM +0200, Greg Kroah-Hartman wrote:
> From: Ben Hutchings <ben.hutchings@mind.be>
> 
> [ Upstream commit 164844135a3f215d3018ee9d6875336beb942413 ]

This will probably work on its own, but it was tested as part of a
series of changes to VLAN handling in the driver.  Since I initially
developed and tested that on top of 5.10-stable, I would prefer to
send you the complete series to apply together.

Ben.

> Currently ksz8_port_vlan_filtering() sets or clears the VLAN Enable
> hardware flag.  That controls discarding of packets with a VID that
> has not been enabled for any port on the switch.
> 
> Since it is a global flag, set the dsa_switch::vlan_filtering_is_global
> flag so that the DSA core understands this can't be controlled per
> port.
> 
> When VLAN filtering is enabled, the switch should also discard packets
> with a VID that's not enabled on the ingress port.  Set or clear each
> external port's VLAN Ingress Filter flag in ksz8_port_vlan_filtering()
> to make that happen.
> 
> Fixes: e66f840c08a2 ("net: dsa: ksz: Add Microchip KSZ8795 DSA driver")
> Signed-off-by: Ben Hutchings <ben.hutchings@mind.be>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/net/dsa/microchip/ksz8795.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
> index 1e101ab56cea..108a14db1f1a 100644
> --- a/drivers/net/dsa/microchip/ksz8795.c
> +++ b/drivers/net/dsa/microchip/ksz8795.c
> @@ -790,8 +790,14 @@ static int ksz8795_port_vlan_filtering(struct dsa_switch *ds, int port,
>  	if (switchdev_trans_ph_prepare(trans))
>  		return 0;
>  
> +	/* Discard packets with VID not enabled on the switch */
>  	ksz_cfg(dev, S_MIRROR_CTRL, SW_VLAN_ENABLE, flag);
>  
> +	/* Discard packets with VID not enabled on the ingress port */
> +	for (port = 0; port < dev->phy_port_cnt; ++port)
> +		ksz_port_cfg(dev, port, REG_PORT_CTRL_2, PORT_INGRESS_FILTER,
> +			     flag);
> +
>  	return 0;
>  }
>  
> @@ -1266,6 +1272,11 @@ static int ksz8795_switch_init(struct ksz_device *dev)
>  	/* set the real number of ports */
>  	dev->ds->num_ports = dev->port_cnt + 1;
>  
> +	/* VLAN filtering is partly controlled by the global VLAN
> +	 * Enable flag
> +	 */
> +	dev->ds->vlan_filtering_is_global = true;
> +
>  	return 0;
>  }
>  
> -- 
> 2.30.2
> 
> 
> 

-- 
Ben Hutchings · Senior Embedded Software Engineer, Essensium-Mind · mind.be
