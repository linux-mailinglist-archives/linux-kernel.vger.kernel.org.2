Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F823F8D00
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 19:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243196AbhHZR1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 13:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhHZR1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 13:27:11 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7387DC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 10:26:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id x11so8067029ejv.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 10:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jE7DamTNtM9yVeZiZkcNIYqg+6bAnPLAukyz2XQ5Wis=;
        b=mszcHJtkElXz7RAmjoO61YPQcPvCladR7zf8yBVf42gyMYZWPCZ2x7VkPpuag8Yzs8
         PaBtnpOyjI+Igih79l2EQZFwid7oGxUGJeU0PhNzK8Mm8FtEQtg24uBUhNIUAftw/g+i
         z/FZ4QqK9a/j3rbiloyhVRhUng5IwUwo9l0cDf20//evvxdGU0oMpBAY6XFlYuCf82Aj
         fE8j4Clf4t01DHE03yB1K4caY0EerdvcermNfUwlPczjMtY6m187rZBkBk8QzTVR24Rl
         o+U+I/MVk2oFDTzZ6h66k9579/86DqGc/G277XGr17lUzSTGXDECOqLMKMerDh+EVuB0
         j1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jE7DamTNtM9yVeZiZkcNIYqg+6bAnPLAukyz2XQ5Wis=;
        b=G9+s/+49dVrfkE2YalwdMZWfn8JDd7WX7/7fGdQ0vXpno0PoGMh3YhEolnH2N0iVGX
         B7nWoPwrzRy8iTxBA4j7Ef0oSxBFuJUMMrQKyGyaeGIOY0IeigJCqiU+wE1PnF5iO/cy
         Y2KBP2QrJwrxDF69LFrqaAJkpqCRi4pNz/WYFBwJiyyUkHXDaOf78esNB62UE2N8Ubi7
         g5S7kPruEvrt1hdYiQH+ScLA1FwBINz4Kv9yJ4CAYi5VpCEIRvuqpo46G1cZM1biF+6Y
         tMPQ6b6UYxgz2RqT5tFJQDQMeuR/mPsaDrHGf0WwhBAGVaBXJbAT0tjnZrRxVrPVgUPv
         8iMw==
X-Gm-Message-State: AOAM531a2+y0vJ4dFsyV7PagpzaEPbob7c5DATniYfi+a47ceRtIKBmG
        bzscCvAbDws0Kyy7h7FZrjI=
X-Google-Smtp-Source: ABdhPJyasEgfR0ftrGXNvT3OziNyemY97gHEb3ZKKyEXEI9t0Qq0gG4iNYE1AGc4ethcbGJR7htoSQ==
X-Received: by 2002:a17:906:660b:: with SMTP id b11mr5284103ejp.427.1629998782083;
        Thu, 26 Aug 2021 10:26:22 -0700 (PDT)
Received: from agape.jhs ([5.171.80.9])
        by smtp.gmail.com with ESMTPSA id s20sm1639041ejx.82.2021.08.26.10.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 10:26:21 -0700 (PDT)
Date:   Thu, 26 Aug 2021 19:26:19 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Wenlong Zhang <yixiaonn@gmail.com>
Cc:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, insafonov@gmail.com, cyruscyliu@gmail.com,
        yajin@vm-kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8723bs: prevent ->ssid overflow in
 rtw_wx_set_scan()
Message-ID: <20210826172618.GB1423@agape.jhs>
References: <20210826154622.55361-1-yixiaonn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826154622.55361-1-yixiaonn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Welong,

(Added commit reference)

On Thu, Aug 26, 2021 at 11:46:22PM +0800, Wenlong Zhang wrote:
> Commit 74b6b20df8cf ("staging: rtl8188eu: prevent ->ssid overflow in rtw_wx_set_scan()")
> fixed up the staging driver rtl8188eu by adding another check 
> to prevent writing beyond the end of the ->ssid[] array.
> 
> Resolve this by properly fixing up the rtl8723bs driver's version of
> rtw_wx_set_scan() 
> 
> Reported-by: Wenlong Zhang(iLifetruth) <yixiaonn@gmail.com>
> Fixes: 74b6b20df8cf ("staging: rtl8188eu: prevent ->ssid overflow in rtw_wx_set_scan()")
> 
> Signed-off-by: Wenlong Zhang <yixiaonn@gmail.com>
> 
> ---
>  drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> index 902ac8169948..6fc1020cea11 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> @@ -1351,9 +1351,9 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
>  
>  					sec_len = *(pos++); len -= 1;
>  
> -					if (sec_len > 0 && sec_len <= len) {
> +					if (sec_len > 0 && sec_len <= len && sec_len <= 32) {
>  						ssid[ssid_index].SsidLength = sec_len;
> -						memcpy(ssid[ssid_index].Ssid, pos, ssid[ssid_index].SsidLength);
> +						memcpy(ssid[ssid_index].Ssid, pos, sec_len);
>  						/* DBG_871X("%s COMBO_SCAN with specific ssid:%s, %d\n", __func__ */
>  						/* 	, ssid[ssid_index].Ssid, ssid[ssid_index].SsidLength); */
>  						ssid_index++;
> -- 
> 2.15.0
> 

today the patch which removes wext handlers has been accepted
(commit 174ac41a7aafb31041cba3fe54ccd89b9daeef5d)
in staging-testing so maybe rtw_wx_set_scan is going to disappear.

thank you,

fabio
