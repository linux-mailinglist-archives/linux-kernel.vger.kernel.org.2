Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2418F346B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhCWVmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbhCWVk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:40:27 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901D7C061764
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:40:20 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z1so25271034edb.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xbM+pkWttWJw3aoNGALv/dpWM5bJzbmiCuEzJQfd8Tc=;
        b=EbHjxRr1/BTiARm35XNlMULaCXph2aEWFX8Ke9Ve2a1i/Yve7Rf/vc/fLqkhY9Eyb8
         xyZdmau/0KSSS0HXsdwISz9dGamYxsCww3Q4ZeDDGMRgc/iKEGLJri4fKk3NE4ZGVx3O
         TIu+Mu7XBJ570u9nKxLekaMPAqO54knRb2YKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xbM+pkWttWJw3aoNGALv/dpWM5bJzbmiCuEzJQfd8Tc=;
        b=cWZpZBH1Kc+Yd87Bj6wV19uCG3O6Mu4BpjbaUlgWYZiE75qFmp3q8QIAhktmme+B+4
         xZVyW+U0B75Kk0BjxThxqpBiq7kqoeXosXXWWfiBhIzUmMbPmtUChkLn6NrY2SbYh+IQ
         T02nWQL6OLzlo/V5U4otRLkCFMR7Xy6MT51YyF7isxv7I9ys9hAYXql/LTjkwm+8O+qQ
         ivddGazkRUSZmDVBehrdkw/DC8mqRC6tckbO0tpf5t1JtrRuI42bSomsspV3E+5XoeYQ
         RbPJkNs70x+49OsTCL2qFr+KVQrjZCEvdCayP9PblfSjiXAGlMh7ZgDcYvdniHpohL1I
         f+bQ==
X-Gm-Message-State: AOAM531hqlW6wQuG3oSpB5D7/TekoJQ7PQ1efkutFdBmm99PKHlN2TdN
        xb10TiSd5vMAiirtatv3TjcJnQgDOAqP8Q==
X-Google-Smtp-Source: ABdhPJyXj/JFgkhBShNxtLyk1T7ODD+VvQMcv/El2wSxH6zLD6CgJiGnQn1ExUH+cyhOItCLogb8mA==
X-Received: by 2002:aa7:c916:: with SMTP id b22mr6718045edt.299.1616535619090;
        Tue, 23 Mar 2021 14:40:19 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id h22sm97eji.80.2021.03.23.14.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 14:40:18 -0700 (PDT)
Subject: Re: [PATCH net-next] hinic: avoid gcc -Wrestrict warning
To:     Arnd Bergmann <arnd@kernel.org>, Bin Luo <luobin9@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210323125611.1905563-1-arnd@kernel.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <2c81e5fe-14d4-aefc-58d3-b32a14615881@rasmusvillemoes.dk>
Date:   Tue, 23 Mar 2021 22:40:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210323125611.1905563-1-arnd@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2021 13.56, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With extra warnings enabled, gcc complains that snprintf should not
> take the same buffer as source and destination:
> 
> drivers/net/ethernet/huawei/hinic/hinic_ethtool.c: In function 'hinic_set_settings_to_hw':
> drivers/net/ethernet/huawei/hinic/hinic_ethtool.c:480:9: error: 'snprintf' argument 4 overlaps destination object 'set_link_str' [-Werror=restrict]
>   480 |   err = snprintf(set_link_str, SET_LINK_STR_MAX_LEN,
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   481 |           "%sspeed %d ", set_link_str, speed);
>       |           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/huawei/hinic/hinic_ethtool.c:464:7: note: destination object referenced by 'restrict'-qualified argument 1 was declared here
>   464 |  char set_link_str[SET_LINK_STR_MAX_LEN] = {0};
> 
> Rewrite this to remember the offset of the previous printf output
> instead.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/huawei/hinic/hinic_ethtool.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c b/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
> index c340d9acba80..74aefc8fc4d8 100644
> --- a/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
> +++ b/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
> @@ -464,7 +464,7 @@ static int hinic_set_settings_to_hw(struct hinic_dev *nic_dev,
>  	char set_link_str[SET_LINK_STR_MAX_LEN] = {0};
>  	struct net_device *netdev = nic_dev->netdev;
>  	enum nic_speed_level speed_level = 0;
> -	int err;
> +	int err, off;
>  
>  	err = snprintf(set_link_str, SET_LINK_STR_MAX_LEN, "%s",
>  		       (set_settings & HILINK_LINK_SET_AUTONEG) ?
> @@ -475,10 +475,11 @@ static int hinic_set_settings_to_hw(struct hinic_dev *nic_dev,
>  		return -EFAULT;
>  	}
>  
> +	off = err;
>  	if (set_settings & HILINK_LINK_SET_SPEED) {
>  		speed_level = hinic_ethtool_to_hw_speed_level(speed);
> -		err = snprintf(set_link_str, SET_LINK_STR_MAX_LEN,
> -			       "%sspeed %d ", set_link_str, speed);
> +		err = snprintf(set_link_str + off, SET_LINK_STR_MAX_LEN - off,
> +			       "speed %d ", speed);
>  		if (err <= 0 || err >= SET_LINK_STR_MAX_LEN) {

This is broken, the second snprintf has no longer overflown if "err >=
SET_LINK_STR_MAX_LEN", but if "err >= SET_LINK_STR_MAX_LEN - off". (The
existing err <= 0 check is also bogus, but that's a different story).

But, I think these conversions where you use snprintf are all broken,
it's only a matter of time before gcc or another static analyzer also
learns a
"Wusing-return-value-from-snprintf-as-index-to-output-buffer-is-fragile-because,you-know,snprintf-semantics..."
and then we'd have to revisit all these. You should in general, when
building a string by repeatedly printf'ing to a local buffer, use the
"len += scnprintf()" pattern. That doesn't easily provide a "have we
overflown at some point" so is not directly applicable here, but all the
more reason to start making use of seq_buf to wrap a local char buffer
in a nice abstraction that lets you seq_buf_printf() and ask
seq_buf_has_overflowed().

Rasmus
