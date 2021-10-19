Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48D1433BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbhJSQKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhJSQKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:10:21 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE38C06161C;
        Tue, 19 Oct 2021 09:08:09 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s136so16584060pgs.4;
        Tue, 19 Oct 2021 09:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zr+o8+2I8YgXkkcApyW2mSSE7dHyClTE/F88JDv1clg=;
        b=RbCpu12OTtcY/UYvjg1nelzlL20X+SuiQjELR5hZnH3a0s0sQ9B7iCP1OVDjRx+E3X
         Z/JvZj2ZulzM6rywpwJlSpaIm6VclgVHZph4hDG5tx55ai3ecrdSjzommBa25Vnkbk3y
         iQFzZ19l54CGIRXnxECezx/HSacIbIdTP1b7PH6VoKHSOLif1GWBeuuZS+RNUX/PLMxP
         VnhP6YtYknwneBqi1ffvpww732ax0auSi5qmwTT9qlCaeN03g6BxroVBijuN1IcQxKi+
         ETH+laAwA7RK/DXCXEeyhMQ0w8eIaM2lijyGcoMfXfeM4Szpa4GUBSHMegDCFW/xpwlU
         CGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zr+o8+2I8YgXkkcApyW2mSSE7dHyClTE/F88JDv1clg=;
        b=zcK+Se5OnXr25rfaeh0JIBDyWRzq83UUuAR9YTvf4Vfc5TQIa+BRKpN6rk6hsqEMdB
         UgFPEDqSJDfWrIDcG4Snr6bAsuJqN7DwLIdjvwnYzBJr1rHcEIZi5mpmu6ThubbsL27N
         y2Dt97bydO5ohQyMIpS0ENpuUdLcb50mqCCN6zxmumC9ybXSBggUrA9uAiQ+xTHUsx9V
         s/+8IRJf3tvz3T9gHjfNOUAEohqT6Kq87F5lZEW0u6hc0K78iyhlzYvk1sECwwx8eAaD
         lSJs5/FIfWvW40r90S1ve/8hpeoFG7bknW//LP4ZUfQleZZgt+f2K1awcwvrK6oOXUw+
         F1ig==
X-Gm-Message-State: AOAM531l/8gYpAyD9M5kUilY+hIb0IUWRGU1JxQe3Sz/moanfsIXdH53
        OGx3KEXMwHH/KJvm2QrBm6fGJZskuGA=
X-Google-Smtp-Source: ABdhPJzlR9xS50qB/mgd43+iiAAnCjWsFsLHgOl+XDRJtNtDKG17m2HWFYxviEbU7ujhFBSW/XdEEA==
X-Received: by 2002:a63:7d09:: with SMTP id y9mr4843526pgc.180.1634659688200;
        Tue, 19 Oct 2021 09:08:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id q9sm12566573pfj.88.2021.10.19.09.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 09:08:07 -0700 (PDT)
Subject: Re: [PATCH v3 11/23] MAINTAINERS: update brcm,unimac-mdio.yaml
 reference
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-kernel@vger.kernel.org
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
 <16b1368230352f3ec136d98766090a2161f84f9f.1634630486.git.mchehab+huawei@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f85e1b15-f3e7-60f6-8b09-f19b530ea682@gmail.com>
Date:   Tue, 19 Oct 2021 09:08:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <16b1368230352f3ec136d98766090a2161f84f9f.1634630486.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/21 1:04 AM, Mauro Carvalho Chehab wrote:
> Changeset 5d1c5594b646 ("dt-bindings: net: brcm,unimac-mdio: convert to the json-schema")
> renamed: Documentation/devicetree/bindings/net/brcm,unimac-mdio.txt
> to: Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: 5d1c5594b646 ("dt-bindings: net: brcm,unimac-mdio: convert to the json-schema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!
-- 
Florian
