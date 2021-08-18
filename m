Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4543F0EA3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 01:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbhHRXcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 19:32:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234860AbhHRXcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 19:32:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB84D610D2;
        Wed, 18 Aug 2021 23:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629329524;
        bh=92kdq27t3ep5Hl3CuE79QJIJv2tMQV5f2MwnOw6G9JA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Zcii3h2FvPs7aZiU5Yl8FCf9QQ15f1cbmEqGhphc5VGNoAaNUg4JDqO8DkAXVlo4b
         rkOqTpRVTZQvVqxHvfncXdWIv7hHKtPyKwiTX4Sm2dTucGGck1odMUA73zyW/rViXF
         KdM3rRTroNWX44eFpcWiHJ/uCaoqimTc585TZz39UExVtHVXyYAJkyhbQzpfA05x02
         ADa2bjnUqYRA+JyG2Ohzanfe6yMIOI9oMUqLxU0Qt0itWTdrzQxSJphZsc+JovndrP
         5x7Hg3ers9jwZ5Iv14bgfKOu6UQLhwLIBlAtOimypL7dhY9PoJLgOyfdjYEXmqpHAN
         GPhUo8/1CKw0g==
Subject: Re: [PATCH][next] staging: r8188eu: Fix fall-through warnings for
 Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210818221418.GA311735@embeddedor>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <b5136c4b-5fe3-43e6-e893-fe74b2ba913f@kernel.org>
Date:   Wed, 18 Aug 2021 16:32:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818221418.GA311735@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/2021 3:14 PM, Gustavo A. R. Silva wrote:
> Fix the following fallthrough warnings:
> 
> drivers/staging/r8188eu/core/rtw_mlme_ext.c:1498:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> drivers/staging/r8188eu/core/rtw_wlan_util.c:1113:4: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> drivers/staging/r8188eu/core/rtw_wlan_util.c:1147:4: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> drivers/staging/r8188eu/core/rtw_wlan_util.c:1405:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> 
> This helps with the ongoing efforts to globally enable
> -Wimplicit-fallthrough for Clang.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

One small comment below.

> ---
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c  | 1 +
>   drivers/staging/r8188eu/core/rtw_wlan_util.c | 3 +++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> index 61b239651e1a..590a4572c23f 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> @@ -1495,6 +1495,7 @@ unsigned int OnAssocRsp(struct adapter *padapter, struct recv_frame *precv_frame
>   			break;
>   		case _ERPINFO_IE_:
>   			ERP_IE_handler(padapter, pIE);
> +			break;
>   		default:
>   			break;
>   		}
> diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
> index cddacf023fa6..e0ce2b796abe 100644
> --- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
> +++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
> @@ -1110,6 +1110,7 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
>   			case _RSN_IE_2_:
>   				if (!memcmp((pIE->data + 8), RSN_TKIP_CIPHER, 4))
>   					return true;
> +				break;
>   			default:
>   				break;
>   			}
> @@ -1144,6 +1145,7 @@ unsigned int should_forbid_n_rate(struct adapter *padapter)
>   				if  ((!memcmp((pIE->data + 8), RSN_CIPHER_SUITE_CCMP, 4))  ||
>   				     (!memcmp((pIE->data + 12), RSN_CIPHER_SUITE_CCMP, 4)))
>   					return false;
> +				break;
>   			default:
>   				break;
>   			}
> @@ -1401,6 +1403,7 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
>   			} else {
>   				break;
>   			}
> +			break;

Would it be better to just remove the else branch at the same time? As 
far as I can tell, there is no reason to have it.

>   
>   		default:
>   			break;
> 

