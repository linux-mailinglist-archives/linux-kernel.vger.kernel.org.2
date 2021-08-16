Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCA63EDE3F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 21:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhHPTyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhHPTyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:54:00 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F57C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 12:53:28 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id b10so25381500eju.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 12:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=BUgCzb4vho0IWW5yOd/HOeeraEmZuXONPhZCDeDXp/c=;
        b=utzq5M8VyrtAlfDzmdLwJL7n+TnidmEJw+qv2zaoUGTCAwCx57DOrbo84nQJDCKdSj
         wduFZHOPBbIp/S/K8wnhWWoT7BYe0uhZDPM9NLuC1hWOP6zSRISm8mRQ9dABoLIyl+GY
         Ku1N90YN5PqMJKzdK+D0+fGQRjGlSkApWosbFRr7p0pmFdv82pOJwYybcxWL49e2A0YR
         tddA0AWh2bTtmCpv+synUycaQDMGnd4qq28sONbe3cwwOtOEsYdqlsp/eNarwS+9VxNv
         KUg8gpHDLdfiuIOCT8IMfvYFjSabvW+GX2ESe6PmExNXq6xwKYUcoaPK3trdzw7HTRaj
         1IQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BUgCzb4vho0IWW5yOd/HOeeraEmZuXONPhZCDeDXp/c=;
        b=EzxZCjeL0ividpp7R7Dp17zoibdJBxWwf8vYZqIUoBXWudOUaPei+CcjQ0sig3Kp6k
         KvA2d82HjefW44bgDscFCjRRkZor9R2E5vOKRWncxL4A8SYTnDmwM198BIIp4owJL18U
         U5ykgaXIMPCQeso7wY9HQTINs9lnakhsCiQBL96SxiC5LH+TnsWAYw37dLsgfbfsuZFQ
         pm2BmLdzJww6QAuikaY+j6zN/NTifV7bROKsiQTRoS3IIdTwu1wyxTIFg6+Xxi2e8Yag
         xiUujX71CG1giafxr/KehdT4ctTGsmehmU+tzE2PkqknUJaPHm/wCTx3s+dpJE6f1/z2
         EWYw==
X-Gm-Message-State: AOAM530jJkWkx33QHxY6UiGQdGZALJdMGB9wLhSMTGxfcRtbSDJsgASI
        xUcV0hvbSB0CB4/1lG1D/3+llPzUdIo=
X-Google-Smtp-Source: ABdhPJy4Tfyz4lmrTFInZ0OMQYPDASoRI/BS5xJuO+7Jmy/hxskbMK0ykNLnsNW56DHfrvi5H1rJhA==
X-Received: by 2002:a17:907:3f0b:: with SMTP id hq11mr134294ejc.95.1629143606957;
        Mon, 16 Aug 2021 12:53:26 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::4058? ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id k19sm79874ejq.42.2021.08.16.12.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 12:53:26 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] staging: r8188eu: Remove no more used variable and
 function
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210816180540.29734-1-fmdefrancesco@gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <dd30721c-e83f-745e-38cd-251c06ed25c4@gmail.com>
Date:   Mon, 16 Aug 2021 21:52:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210816180540.29734-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/21 8:05 PM, Fabio M. De Francesco wrote:
> Remove the 'sender' pointer to integer. Remove
> __nat25_db_network_lookup_and_replace(). Following the deletion of the
> code related to the NAT25_LOOKUP method, they are no more needed.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> v2: Rebased against latest version of Greg K-H's tree.
> 
>   drivers/staging/r8188eu/core/rtw_br_ext.c | 52 +----------------------
>   1 file changed, 1 insertion(+), 51 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> index 0402f48319c4..ee52f28a1e56 100644
> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> @@ -295,56 +295,6 @@ static void __network_hash_unlink(struct nat25_network_db_entry *ent)
>   	ent->pprev_hash = NULL;
>   }
>   
> -static int __nat25_db_network_lookup_and_replace(struct adapter *priv,
> -				struct sk_buff *skb, unsigned char *networkAddr)
> -{
> -	struct nat25_network_db_entry *db;
> -
> -	spin_lock_bh(&priv->br_ext_lock);
> -
> -	db = priv->nethash[__nat25_network_hash(networkAddr)];
> -	while (db) {
> -		if (!memcmp(db->networkAddr, networkAddr, MAX_NETWORK_ADDR_LEN)) {
> -			if (!__nat25_has_expired(priv, db)) {
> -				/*  replace the destination mac address */
> -				memcpy(skb->data, db->macAddr, ETH_ALEN);
> -				atomic_inc(&db->use_count);
> -
> -				DEBUG_INFO("NAT25: Lookup M:%02x%02x%02x%02x%02x%02x N:%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x"
> -							"%02x%02x%02x%02x%02x%02x\n",
> -					db->macAddr[0],
> -					db->macAddr[1],
> -					db->macAddr[2],
> -					db->macAddr[3],
> -					db->macAddr[4],
> -					db->macAddr[5],
> -					db->networkAddr[0],
> -					db->networkAddr[1],
> -					db->networkAddr[2],
> -					db->networkAddr[3],
> -					db->networkAddr[4],
> -					db->networkAddr[5],
> -					db->networkAddr[6],
> -					db->networkAddr[7],
> -					db->networkAddr[8],
> -					db->networkAddr[9],
> -					db->networkAddr[10],
> -					db->networkAddr[11],
> -					db->networkAddr[12],
> -					db->networkAddr[13],
> -					db->networkAddr[14],
> -					db->networkAddr[15],
> -					db->networkAddr[16]);
> -			}
> -			spin_unlock_bh(&priv->br_ext_lock);
> -			return 1;
> -		}
> -		db = db->next_hash;
> -	}
> -	spin_unlock_bh(&priv->br_ext_lock);
> -	return 0;
> -}
> -
>   static void __nat25_db_network_insert(struct adapter *priv,
>   				unsigned char *macAddr, unsigned char *networkAddr)
>   {
> @@ -493,7 +443,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
>   		/*---------------------------------------------------*/
>   		struct arphdr *arp = (struct arphdr *)(skb->data + ETH_HLEN);
>   		unsigned char *arp_ptr = (unsigned char *)(arp + 1);
> -		unsigned int *sender, *target;
> +		unsigned int *sender;
>   
>   		if (arp->ar_pro != __constant_htons(ETH_P_IP)) {
>   			DEBUG_WARN("NAT25: arp protocol unknown (%4x)!\n", be16_to_cpu(arp->ar_pro));
> 

Acked-by: Michael Straube <straube.linux@gmail.com>
