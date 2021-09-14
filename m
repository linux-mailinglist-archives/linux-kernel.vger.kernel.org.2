Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F195140BB63
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbhINWYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbhINWYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:24:31 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E242C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:23:13 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id g184so670501pgc.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5o8WWIA/LRw/JbdUBqLbwJmD47lNoYQx/n5FXd9wsPk=;
        b=GKBuIqJk1w53+nXErkwbAbXRqmxNA8Z5xQLQ5lNeUtkz24XIsPartUATvHQ7MQ9MQ4
         y2yZvUdTSb2NhK0Zw3owy9ntlUZSN67v9B2JyCYPo6GcARbrtytf+f0SeT2BjaZvypcR
         nAty4F2FbjNpy85uHm1oc5YlLo3WboJ+3W/xHvFSJtxxLN5Bw3QX7vP5C8WWuhfg0mZj
         56ZWbvlx+FrJ6Jg3hjL5srmTLsno4v1oul/dVUMaPgDB6jjnsyKMesI2tGdpP8QQA6RB
         bYz02/M4cNZWOM+jBkkqwl0Yw7+Y28jXTPWmmgDwjU8JeC6dhc4ZtMN9zK0QApXUwmDN
         TnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5o8WWIA/LRw/JbdUBqLbwJmD47lNoYQx/n5FXd9wsPk=;
        b=7TvWXDCtqfWZBjkWb5Wt6asGixzzab58A3zq5+GWVImw+9HZ3Pqlve9KH4Tc55hAx8
         Oi0GgQoQ7Qpcr5ZE/4Q5JJAO23qKoqsgr6jR8iko90raWYgKIAW367+yKI36nKdiqE5U
         OzoFsoq/YmWWaI6kmc1gakbZ5ruWQTbTSPHRzFKBA3xP0YxKaOq5asSL1OUHQP7Y3Yu7
         naNDszKCCYNpZb19QC7aPHU2bJdKbj/51DzoGbQpMsV3O/TM+kt9T9/I7iSfGhXLv/HC
         lCkEA5nTOiqbSB5AGrfi7ngbUNq/5OLFGKU5whIWQDOVseYz68x4jvpq7X6+Nkd+ovi0
         kOtQ==
X-Gm-Message-State: AOAM532+wPk1unDnoIIisQqEJNKj8TOh8PXH7E7vJOs6KJjfepfJoj9q
        lFFVURZez35rbL7NRtd3vAcB85tg7Gw=
X-Google-Smtp-Source: ABdhPJx6Kp2wJUrAP1zzP2XCmzrFrF5+pqTqh0SyLED0c3RBhvQHUHVFd5gsaO/W7cDU1g086Z6vZg==
X-Received: by 2002:a05:6a00:2410:b0:40e:7d8:ad7f with SMTP id z16-20020a056a00241000b0040e07d8ad7fmr7048939pfh.25.1631658192695;
        Tue, 14 Sep 2021 15:23:12 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id v13sm11208285pfm.16.2021.09.14.15.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 15:23:12 -0700 (PDT)
Subject: Re: [PATCH 1/2] soc: bcm: brcmstb: biuctrl: Tune MCP interface for
 72113
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20210914222146.214115-1-f.fainelli@gmail.com>
 <20210914222146.214115-2-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <0533cc7d-f1b7-7558-da05-30dadc0c4321@gmail.com>
Date:   Tue, 14 Sep 2021 15:23:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914222146.214115-2-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/21 3:21 PM, Florian Fainelli wrote:
> 72113 uses a dual core Cortex-A72 CPU complex which requires tuning of
> its bus interface unit the same way that the existing Cortex-A72 based
> systems are tuned.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Meh, this one is a duplicate, I will drop it while applying the other
two patches.
-- 
Florian
