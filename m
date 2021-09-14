Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFCC40B5F1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 19:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhINRdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 13:33:53 -0400
Received: from gateway31.websitewelcome.com ([192.185.144.94]:22954 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230019AbhINRdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 13:33:46 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 1AF36FC113
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:32:27 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id QCIEmDg0PMGeEQCIFmJnFz; Tue, 14 Sep 2021 12:32:27 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3sP6jXMNnxu6PJJC0Lvm+qOKW0f/dGtu/4FvN9Uf7iM=; b=g8Az3FMGHjcUQunQDfThX3OfVx
        fI2MMchUpam/fzYsvIrUYzq3Ilrjsmjg+DZnyr7STqsjSE6Itbo44efKDrBR8yt4YU+riVw7lErnt
        dR21PRArQDvU37USJICiFK8IoldkWyUV2C51+PhJihApbCnlTysBXPUGldNdXyzWcDPxzCuk9viYi
        UOojkNYveJSd6GoERVUQOiaJEmTP0yFJ40vkx0Lblpafjwsw7qDE6uzkZbODbs5AN85CZa5jizmRL
        nSBET8eexfyAaLddgskzpeW2PpEoY/fqAQxhOK8cuFH/FuHeLymn32wmV6yeWV3dneeYdtffFwStn
        a3ziMzJw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:34626 helo=[192.168.15.9])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1mQCIE-0035SF-A2; Tue, 14 Sep 2021 12:32:26 -0500
Subject: Re: [PATCH][next] ath11k: Replace one-element array with
 flexible-array member
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210823172159.GA25800@embeddedor>
 <6e8229a1-187c-cd69-ad1c-018737e5e455@embeddedor.com>
 <87r1dr1vpf.fsf@codeaurora.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <36d4e936-527d-e6ff-8f6a-e06fcb275327@embeddedor.com>
Date:   Tue, 14 Sep 2021 12:36:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87r1dr1vpf.fsf@codeaurora.org>
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
X-Exim-ID: 1mQCIE-0035SF-A2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.9]) [187.162.31.110]:34626
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/21 02:07, Kalle Valo wrote:
> "Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:
> 
>> I wonder if you can take this patch, please.
> 
> This is in my queue, please do not take ath11k patches.

Great, and sure thing. :)

Thanks
--
Gustavo
