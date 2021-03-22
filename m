Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A170343643
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 02:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhCVBbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 21:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhCVBao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 21:30:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFEDC061574;
        Sun, 21 Mar 2021 18:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=sXUZLoJVX4sCvpUh0ekiyuiCeNNupNFY5blFIrTKsSE=; b=gHJ1D81QDSHHUsXsyeiFZKqfhM
        RXDLZ/nyPsBNeP96W0yRbyfuZ2V39qcyE/SLJnrWOhc3Xl4TMVM5Gr6erAOxR5n7qBMviG7fxR88A
        oaMrhTdCwGZrtTqwDvQ03k0pUFnZT1Mub7BnE5mFsEz9BSeB807s6zspWmKC9at59onaW9gdQ4xU0
        sA9fYgalYxBY3pthHDolWz9wxaTCvn9LZ85tM9WXv2MAHy0uRU1BorL539H/tnY0kIM1nxwEXZKCw
        CYS7npmCHp6zyYWVLvIOTbw3NUHW3s2pIf+S/fM67CB87s2f4P2sKONrhEMuVBZJfq0yc+Vhf2tZL
        Qslgi03A==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lO9Ox-00AfJR-PY; Mon, 22 Mar 2021 01:30:40 +0000
Subject: Re: [PATCH] Bluetooth: hci_qca: Mundane typo fix
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210322010051.483622-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b1867efb-afcc-1f9e-fbab-75a7793a2649@infradead.org>
Date:   Sun, 21 Mar 2021 18:30:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322010051.483622-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/21 6:00 PM, Bhaskar Chowdhury wrote:
> 
> s/packat/packet/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  drivers/bluetooth/hci_qca.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index de36af63e182..f2eee9112e41 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1066,7 +1066,7 @@ static void qca_controller_memdump(struct work_struct *work)
>  		 * packets in the buffer.
>  		 */
>  		/* For QCA6390, controller does not lost packets but

		                                    lose

> -		 * sequence number field of packat sometimes has error
> +		 * sequence number field of packet sometimes has error
>  		 * bits, so skip this checking for missing packet.
>  		 */
>  		while ((seq_no > qca_memdump->current_seq_no + 1) &&
> --

As Ingo said, please try to fix more than one thing at a time.

-- 
~Randy
