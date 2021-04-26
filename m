Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA8436BA17
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 21:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240485AbhDZTbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 15:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240470AbhDZTbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 15:31:03 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18472C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 12:30:20 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id i24so7523572edy.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 12:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dr87k9ZfKSIjKnHclx7DePEImf+rQ7+qp484Yc2GQDI=;
        b=PPOrCQABnsVUARLGHk3k4EHRz5rL54WAC/3DmqIc9Chmcl13vZveHm9YTgPByu9ISi
         BCM/sigWLiv6oopbIxbMFfnPjXDDtLMM7ucX+DRa10VkRS6dPJUiaf2WgASxfslYX16E
         +bppZXEMf+sV9kNORgUP1nYT3q7/2Za5BgRMgLnxUbuBHvygarfczX+R3rRy0AfqqvgH
         Xitwa51T16WbhvkAvSG4cEktOXnr6XxCEyVTfulx1je4TvHzlBJ10ZT2yTfsjgzv6ePw
         Y9LgkJ4yyVK6FRcD7HdvGU04WKY4YtpvKyRVuqndTXJYPUNTtQ3PWYHDR1yWXuDSDmmy
         jROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dr87k9ZfKSIjKnHclx7DePEImf+rQ7+qp484Yc2GQDI=;
        b=k7G6s1BWpnDNVX8higNgaY+1y+8kRxHGABUxTPgML58w42KsAf5y+WewlC9zmzEQwS
         uYnJFnhtW8iTNlnKZZphXTgYjdueLXZo0zb0Ne2296EHGmXZYKtQCpD3frXyhip6tGlg
         g/XnMEB/w95ObaG534foCwFXsKfkrMw3stJOrDT1FaUnLcqbvpRb2HxddSD80tLOeYiN
         WFDTmXlODBiC4sQg45MvSKBtq3NYxE0Wqv1XzagIFUhmSsnZm52dW4gB6Yke++NtpGpT
         tzTPjJthwZ2euy2YPWrlvFwaD40jLdhP9IIeVcJKsk5CgxLOM/dTStuZnkvsw+lXByx4
         VSsQ==
X-Gm-Message-State: AOAM5304NGafoHHy/SQOD21VKrbzAkPEqOvvV//bFA2xIti/Z8ua9vVP
        3rT57+RDHAwCnWcps68bg+qME+yTtWeyb1gZ
X-Google-Smtp-Source: ABdhPJwEsGiSPn86sUce28FQhOIkZd9EDC808DnlsPjgtQS2kJzYU55xlwjSXiAaAe8rkGOR/w0UhA==
X-Received: by 2002:a05:6402:3514:: with SMTP id b20mr267417edd.348.1619465418825;
        Mon, 26 Apr 2021 12:30:18 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([46.166.143.116])
        by smtp.gmail.com with ESMTPSA id r10sm12090371ejd.112.2021.04.26.12.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 12:30:18 -0700 (PDT)
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthias Maennich <maennich@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mptcp@lists.01.org, netdev@vger.kernel.org
References: <20210424114841.394239-1-masahiroy@kernel.org>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH] kbuild: replace LANG=C with LC_ALL=C
Message-ID: <2f8ccc46-16a1-e0fe-7cb0-0912295153ee@tessares.net>
Date:   Mon, 26 Apr 2021 21:30:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210424114841.394239-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch!

On 24/04/2021 13:48, Masahiro Yamada wrote:
> LANG gives a weak default to each LC_* in case it is not explicitly
> defined. LC_ALL, if set, overrides all other LC_* variables.
> 
>   LANG  <  LC_CTYPE, LC_COLLATE, LC_MONETARY, LC_NUMERIC, ...  <  LC_ALL
> 
> This is why documentation such as [1] suggests to set LC_ALL in build
> scripts to get the deterministic result.
> 
> LANG=C is not strong enough to override LC_* that may be set by end
> users.
> 
> [1]: https://reproducible-builds.org/docs/locales/
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/powerpc/boot/wrapper                          | 2 +-
>  scripts/nsdeps                                     | 2 +-
>  scripts/recordmcount.pl                            | 2 +-
>  scripts/setlocalversion                            | 2 +-
>  scripts/tags.sh                                    | 2 +-
>  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net> (mptcp)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
