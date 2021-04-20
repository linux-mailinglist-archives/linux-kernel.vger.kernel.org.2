Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49D036610F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 22:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhDTUi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 16:38:27 -0400
Received: from gateway20.websitewelcome.com ([192.185.65.13]:30715 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233769AbhDTUi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 16:38:26 -0400
X-Greylist: delayed 802 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Apr 2021 16:38:26 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 0507940105D0D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 15:05:21 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id YwnFlOLFvMGeEYwnFll2HL; Tue, 20 Apr 2021 15:16:21 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dO192Ur5dBsN1rnDcOwr4ME0frgDG8HEFMRgM8bBOG8=; b=phM8fOXcn16yNvjEmnPbVG9Ejb
        mYBqe/giIHvV7r+/Ki3Rcj9+W6S7KTjG+qL3r3KlXNhqlngzG9H40lTDDSbg0dBoy1bWCtCVz1zIT
        mQ2RDBQ8Q497kuqc0ggCQOkEZhwGrPsLCM/sKj/sHxYN8Nt5GVrK/zHOVWzvUQN5CkGLV8hMFPvuy
        0zaKRzffGcDlQicoYcnkgxZ8qscUdKO3ndrTk6QPW8B7ZHDhPvKPUmJvWuyafxYwlWRZ48T8Ian3N
        xpnVFfoYk42WIYnhdj6uOu8Yh95uwPCIyV2HxveButSpDEAvDqHFVAZNiHwXYyM4/yGh57KQ5QalD
        QjmOpTRQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:48996 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lYwnE-002pkK-M2; Tue, 20 Apr 2021 15:16:20 -0500
Subject: Re: [PATCH 071/141] braille_console: Fix fall-through warnings for
 Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <a0be16871b77956d75ea2f877da2fa5fba3e64ac.1605896059.git.gustavoars@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <f7e58552-309f-ef96-7ac8-3cb692c979d1@embeddedor.com>
Date:   Tue, 20 Apr 2021 15:16:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <a0be16871b77956d75ea2f877da2fa5fba3e64ac.1605896059.git.gustavoars@kernel.org>
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
X-Exim-ID: 1lYwnE-002pkK-M2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:48996
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 115
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

On 11/20/20 12:34, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/accessibility/braille/braille_console.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
> index 9861302cc7db..359bead4b280 100644
> --- a/drivers/accessibility/braille/braille_console.c
> +++ b/drivers/accessibility/braille/braille_console.c
> @@ -246,6 +246,7 @@ static int keyboard_notifier_call(struct notifier_block *blk,
>  				beep(440);
>  		}
>  	}
> +		break;
>  	case KBD_UNBOUND_KEYCODE:
>  	case KBD_UNICODE:
>  	case KBD_KEYSYM:
> 
