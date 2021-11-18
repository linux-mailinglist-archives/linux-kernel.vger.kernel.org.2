Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E084555EB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 08:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244042AbhKRHpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 02:45:19 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35940
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243746AbhKRHnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 02:43:18 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 22C774000D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 07:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637221218;
        bh=6O/A/IhU2XeX9QN2oJl3uiU3cJm6GUQ4n07BCEIs3FI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Mjdk6P8uVHfBXLKON+R0N/2qsRDAy823Y/xqrt/58DvEivVDZdFNvFOOfwezNu3E1
         9HIRQ79FJP2/FGY7APXb07toxEIw448N1oC/hpeCi2USjhq5mx8GKTMk/IwvzKRezy
         +O/rRPwMpiym41IoYKOZJvlXbCmWKEm0ZJ8tR2jtMN5KfD6Mjxkki3kkkTaqsAY9rd
         FM/bdqKdR8vs1v6AduNOQSr3joHi8Q4bKpdxtg+kmFDFmk0N/Aas3z2QL5Yg+hIggZ
         A7oFvC0hO4spBZA5MxZIB7KOVrj2SrzFT3jTyk/6NJQPV/y/WU6kJiT3Hxyx1EI12u
         cBdlxFPhcCuGg==
Received: by mail-lf1-f72.google.com with SMTP id b23-20020a0565120b9700b00403a044bfcdso3364754lfv.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 23:40:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6O/A/IhU2XeX9QN2oJl3uiU3cJm6GUQ4n07BCEIs3FI=;
        b=gaS9YH1XDlK5qjqkma8u5SrzMfDQTK9UQY7XKsiRiIGbkFhJ+8RoZjClSJdRnH1Z/N
         KxWv6O5uoUidsl0uXwru6Hq6WmaXgjad3k89G5hw8avNHTocRN65x+yehimvTcXTA1Ka
         eL9JigSotMomZ8DfD3r+TCGAxWHypQlPeEaq3Rc3RCN8sDVOGvdn5tWkKcS2EbqurQMo
         bFR5ZH52LYEAB/tB/VIG1JAWhWAnUmFgnJxOCSxTAwMw789ZQmnclOUNqbdmKyVcxntk
         18IKBlPv3RVGP2UCcjaLSltoQGCn2BjPXg7Uil2fZXrtSdDzzC5Xty60wEV2baiPmU84
         LBQw==
X-Gm-Message-State: AOAM532TLVwxlSmRIyQ2lzPHhlP2SmahFG3t9NZU5VR/8kTKNgokSHU5
        0NBwwG8rd29OCpjHoiq1dBWzB4VD9/0ELGnUBhrj01ul8dvYECZy1M6GbtopSRzAZ6jjo3vr+gG
        PHoewkyKmOkknm5Wbx3uluGis9fFg+CM2IW4Q+Rfvdw==
X-Received: by 2002:a05:651c:2123:: with SMTP id a35mr15191898ljq.174.1637221217411;
        Wed, 17 Nov 2021 23:40:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzYyujL48SlrjMMONApWRnv27oqukk19+pBLjhDOBjnbg/qDDNCUWm7BY38HQ6cjBUqNBMsLg==
X-Received: by 2002:a05:651c:2123:: with SMTP id a35mr15191883ljq.174.1637221217276;
        Wed, 17 Nov 2021 23:40:17 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id r19sm213195lff.207.2021.11.17.23.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 23:40:16 -0800 (PST)
Message-ID: <879d53ad-1819-d556-3403-daf26b08ba41@canonical.com>
Date:   Thu, 18 Nov 2021 08:40:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] nfc: st21nfca: Fix potential buffer overflows in
 EVT_TRANSACTION
Content-Language: en-US
To:     Jordy Zomer <jordy@pwning.systems>, linux-kernel@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
References: <20211117171706.2731410-1-jordy@pwning.systems>
 <20211118070426.2739243-1-jordy@pwning.systems>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211118070426.2739243-1-jordy@pwning.systems>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2021 08:04, Jordy Zomer wrote:
> It appears that there are some buffer overflows in EVT_TRANSACTION.
> This happens because the length parameters that are passed to memcpy
> come directly from skb->data and are not guarded in any way.
> 
> It would be nice if someone can review and test this patch because
> I don't own the hardware :)
> 
> EDIT: Changed the comment styles and removed double newlines
> 

Same comments apply. :)


Best regards,
Krzysztof
