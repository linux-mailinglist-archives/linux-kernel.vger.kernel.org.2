Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F4D3EDD50
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 20:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhHPStC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 14:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhHPStC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 14:49:02 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1315EC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:48:30 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id h17so28654152ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OzlvgX+vzoKG9kFQ3t7nTob1GcVIUZUb5mhb/Lw1pbk=;
        b=A4/F8buHBcpAMd5F4iRPkUCMj5lF37ejNIIT+yn1E2XV1N92gAotdFTTptGAFxYGIV
         IWf8vgijoSuvHrmNjtKunvk97CgbinIZhUcnlhVZyoB7+FWcw0QKx8TvPfXxmNM8y5Xu
         /NUOlCNPCWuyR09XWEC89V1xqu2hFhzDbhJ4EWfA+Eb1Tee10/zfpBACkWfMVsayoc8p
         CZsx8AYSoQZYrnJ6Yfb3O2w41+newOQ5jnXj5sSWMHdgJL0wJzhuarI1c43pmWydhGbL
         2yB0iw4sk3S5lejQnTD4RSF4wrI5rFIbiwxsAfNAWw9f/59IrtYspzvx7gJFyHT+WBr0
         J82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OzlvgX+vzoKG9kFQ3t7nTob1GcVIUZUb5mhb/Lw1pbk=;
        b=WYgVdt0LGQSubZb0uRkdRiGSF8U/1YiEnz7cHyaauodr63bS0ner5F7v64sJtp5AKc
         6CbVNVL8kwGTzCiywt/FR8NYSAv4POetziVrjV+duSTB09gtaUc2VVJ6h/aJvOCoc/Rz
         8sCOya6paj/fhMU2kKvzjT3vLtfO+mLJPbWfazNJ72Rg9MBnpAfKv8BQOC5Kkb87cFju
         HPLuv20LESyKsXHB3tEu9KdB8Q39xz20mXLNe9a9/o+5fKVa6le44kTMPia3/UlIaOUM
         aPuZMGWu2nd2rdirWPqapZM+/0var+H+/fSPcN7sVOYeRQXyZtO8Y7LupQvVhleqgBUz
         Gd5g==
X-Gm-Message-State: AOAM532IqvytZIFWuhOPmVI2aRlDNbJ/tA0fcSHgzPixmXGzLz7KPibP
        4txhLMwyevh8OI1UO6Ind/FelgNnOG/ORXLjkXOHJ94u71fi5g==
X-Google-Smtp-Source: ABdhPJxnVC840kww9UQlPEhQnmFzybH+lt9007MbD+7AZA3tYzu/scfjY98h/lPTrkTltW+7PJzVtTgg8vK+vq+jrxY=
X-Received: by 2002:a2e:8109:: with SMTP id d9mr37188ljg.495.1629139708138;
 Mon, 16 Aug 2021 11:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210814235625.1780033-1-nathan@kernel.org>
In-Reply-To: <20210814235625.1780033-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 16 Aug 2021 11:48:16 -0700
Message-ID: <CAKwvOdkVP42MeA7j=ppjJD4-jgC0pcTo6xbPhsOT5mT2DBPW3w@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8192u: Fix bitwise vs logical operator in TranslateRxSignalStuff819xUsb()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2021 at 4:58 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> clang warns:
>
> drivers/staging/rtl8192u/r8192U_core.c:4268:20: warning: bitwise and of
> boolean expressions; did you mean logical and? [-Wbool-operation-and]
>         bpacket_toself =  bpacket_match_bssid &
>                           ^~~~~~~~~~~~~~~~~~~~~
>                                               &&
> 1 warning generated.
>
> Replace the bitwise AND with a logical one to clear up the warning, as
> that is clearly what was intended.
>
> Fixes: 8fc8598e61f6 ("Staging: Added Realtek rtl8192u driver to staging")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/staging/rtl8192u/r8192U_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> index db26edeccea6..b6698656fc01 100644
> --- a/drivers/staging/rtl8192u/r8192U_core.c
> +++ b/drivers/staging/rtl8192u/r8192U_core.c
> @@ -4265,7 +4265,7 @@ static void TranslateRxSignalStuff819xUsb(struct sk_buff *skb,
>         bpacket_match_bssid = (type != IEEE80211_FTYPE_CTL) &&
>                                (ether_addr_equal(priv->ieee80211->current_network.bssid,  (fc & IEEE80211_FCTL_TODS) ? hdr->addr1 : (fc & IEEE80211_FCTL_FROMDS) ? hdr->addr2 : hdr->addr3))
>                                && (!pstats->bHwError) && (!pstats->bCRC) && (!pstats->bICV);
> -       bpacket_toself =  bpacket_match_bssid &
> +       bpacket_toself =  bpacket_match_bssid &&
>                           (ether_addr_equal(praddr, priv->ieee80211->dev->dev_addr));
>
>         if (WLAN_FC_GET_FRAMETYPE(fc) == IEEE80211_STYPE_BEACON)
>
> base-commit: 0bd35146642bdc56f1b87d75f047b1c92bd2bd39
> --
> 2.33.0.rc2
>


-- 
Thanks,
~Nick Desaulniers
