Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1333EC7F1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 09:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbhHOHZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 03:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbhHOHZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 03:25:13 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB89C061764;
        Sun, 15 Aug 2021 00:24:44 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gz13-20020a17090b0ecdb0290178c0e0ce8bso16074835pjb.1;
        Sun, 15 Aug 2021 00:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JJDOH+AsHu2AM+5trq9kiKo9CgyK57KxYI3IwWvbE3M=;
        b=RKVBuxnf6xQR/pSKO2SpOS4Lo6yWbvzYlN2vrYeM3uoUInGkiTdUEcKTamCVloy6Iu
         ZA9Exggoimx2UOW0KErLqGMmY0WkwWINOzzwidewuOoNoGSp8vQ+H965y14rWqUP1szV
         YeHPCkKyFA1Cl9AfjlNiFM2Y66k+g0E5jwTXCdyfpfmn7AZfhiNX69hX4MzurMx1p7UB
         jO1cDfd2BiMw06dGq0kLS6mxxwXvdMt8BI02AdSUlo/GRsgMQr01g81S7i605nNOB+B3
         v4euFQpY/eX/sBO6CwpOVDqdKZaccw1UyGOi8jqbIzdgr94kaIeDcnVnsHAcUIs8sjBR
         qOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JJDOH+AsHu2AM+5trq9kiKo9CgyK57KxYI3IwWvbE3M=;
        b=PIV9MZmkHIhmC3WEB0FWPiYgNwADZ6j47XWy1ccPHjuvQZfcDDtmeANCevBv5WM9iT
         xbjVwkPNK4c65loZ48/dMJL7zga3aCPMHXw8QEMmnxYvc+KUNeBIHxQY5a3Sl/8LeYAx
         8h6FBpEtrIVSgC+cpjM9uTrkC8p8tZhcI1garjshiwY6RHeFDdlpwJ61kFK1MvabfHrE
         8NbApabNzjgiBqpNV/p4u/xKbwD/gg1dXEfWaJyMlJx1qdyxHIdvXa4myJJMw6K0Pv83
         83ch/xikHg4mWomCbMEAtQ5KOuRQbRKJdbBPKySXh4P6Fk7r+oa8zJhAdkL6nIKfxbvn
         wbzQ==
X-Gm-Message-State: AOAM531KVS9U+5VpVxhjROVgtytaiYhzteY4D/R+z8bb3suxnUUpbrTZ
        EAERY+kDmLZ6FpsBPS2/AUA=
X-Google-Smtp-Source: ABdhPJzq7sSAhv3mhPPXmyKVf5x9azgnIMZToYUs9eoJVEO0q/kFfEa3Yd9UMtVPm1x4oAezGGF8aw==
X-Received: by 2002:a17:90b:14b:: with SMTP id em11mr10845400pjb.125.1629012283879;
        Sun, 15 Aug 2021 00:24:43 -0700 (PDT)
Received: from [10.230.32.65] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id 16sm7337825pfu.109.2021.08.15.00.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Aug 2021 00:24:43 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] usb: gadget: bdc: remove unnecessary AND operation
 when get ep maxp
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Pawel Laszczak <pawell@cadence.com>,
        Al Cooper <alcooperx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Eddie Hung <eddie.hung@mediatek.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
References: <1628836253-7432-1-git-send-email-chunfeng.yun@mediatek.com>
 <1628836253-7432-6-git-send-email-chunfeng.yun@mediatek.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e191402f-69e1-2fb5-f5e1-6fd73e8b0699@gmail.com>
Date:   Sun, 15 Aug 2021 09:24:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1628836253-7432-6-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/13/2021 8:30 AM, Chunfeng Yun wrote:
> usb_endpoint_maxp() already returns actual max packet size, no need
> to AND 0x7ff.
> 
> Acked-by: Felipe Balbi <balbi@kernel.org>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
