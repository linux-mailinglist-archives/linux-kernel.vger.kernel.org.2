Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704C03660C9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 22:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbhDTUW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 16:22:26 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.89]:42461 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233619AbhDTUWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 16:22:24 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 08F694010B666
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 15:12:42 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id YwjhlhVhRb8LyYwjhljPKx; Tue, 20 Apr 2021 15:12:42 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/R9UkJuQ7YZGJkQ6UXFLC3+p4h+sEMyvizG4Bj6L9D8=; b=LlurlvvrXyOUM81IDErArZVs6L
        jkyS0Wgk5C0o55yNenmsNkTXksQt1RKo1WiAlRUBZTAu+hDrJx4ikyVkYyiAKFOf1uEsdwH/kOtYN
        IruJL51clkIk3sOk5jbmONXlchRrgf6eHYFlrEKx4u/HjiEs2FOJ3/oH4Gjt3YIJ0VC7TnVYjmFXe
        LRPNQdFFKsA/6ok866hSBAiKimomVjdMY1aF86bS8SZrotp+02o47Ab6YL6Jadr4zCgNfZtC4S7/Q
        EPknCKDA77cHV11SRkTIs/WNKz/VuG33RieF2ZHOHFqKsgqy5DiEqQOkD+bOR15ib46Myy0vrIZ1t
        uFBmI58w==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:48968 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lYwjf-002k6w-HY; Tue, 20 Apr 2021 15:12:39 -0500
Subject: Re: [PATCH][next] firewire: core: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210305074223.GA123031@embeddedor>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <69b103b8-1955-ce79-57ec-0e9eca48ba6c@embeddedor.com>
Date:   Tue, 20 Apr 2021 15:12:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210305074223.GA123031@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lYwjf-002k6w-HY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:48968
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 82
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Friendly ping: who can take this, please?

Thanks
--
Gustavo

On 3/5/21 01:42, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a fallthrough pseudo-keyword.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/firewire/core-topology.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
> index ec68ed27b0a5..b63d55f5ebd3 100644
> --- a/drivers/firewire/core-topology.c
> +++ b/drivers/firewire/core-topology.c
> @@ -58,6 +58,7 @@ static u32 *count_ports(u32 *sid, int *total_port_count, int *child_port_count)
>  		case SELFID_PORT_PARENT:
>  		case SELFID_PORT_NCONN:
>  			(*total_port_count)++;
> +			fallthrough;
>  		case SELFID_PORT_NONE:
>  			break;
>  		}
> 
