Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF9C3FE9F0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 09:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243369AbhIBHXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 03:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243112AbhIBHXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:23:11 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8439DC061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 00:22:13 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u9so1274595wrg.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 00:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=reply-to:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Sr4JglvdWDBQ2wOTZW6ElZD1OAh7p+s3FJK89qhgiM=;
        b=FS94AIis1HaeP4YWFLvWShRs7pOBIvYRjx0VLv6hM9zDKmreAzv5G5CfG8A6iX29W2
         01ozlnfm6paVlRWetFTsY9E/v+GNNLRVtSwNwt1mJymNKqlW8N7jcS7fMQauEzG2D16y
         +KgcW68JBohppxrdZB/0JOBdxCrW37YMLzm5SjbdSM5R/I3Zo92O9HGMlOA4+ncodUog
         Q884MiVIxhIPuj45jbj554K1MyQkbm4SWLhGU6/7FLQ48yZJbASmWaXZLNCl4VST96iD
         Dcjumy9O6saBzIuzqZIjRA60ReyVtHuT5NtvxMHmzpJ1x39HljOu3SzB7h3BI0Dqto89
         Pf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2Sr4JglvdWDBQ2wOTZW6ElZD1OAh7p+s3FJK89qhgiM=;
        b=gboSwEs0RXMUqAnlaWCns0hwvaDSvUWjyVs+hmwsrK3uTh/EjxycJ0EF9P9QcJGup5
         jl9cja6R3F7eGsxqzfs6pQudfmeZ9tTYNltKfCRkI+/eTuVWeZbQoYLJFDvsswzzgy6P
         ApWpAKLF5HOXcNhVL4hMv0QKekpk9z8L/l6JqBqbCoe4VoZkLlViQaAy3DUXj7ZYYO4+
         Adu7q3t7YtTW1UhdT0wZjHHjO4UkIu7Ei0CtvvEaRwrChbHlfqqVPuGW577T8ja/SD3d
         ClULQm8hLFiF6PHP//ncZ+mAUnALcY7R27vU6w653Gbd1KPu3VCATLN5pCE2rxMs5LAR
         In1Q==
X-Gm-Message-State: AOAM532psdtI5CaPkVsWYBrfQ5+dYb2v2Id3ezzsh4b1Tgxj9Q3TFaaf
        njEovyGdsuZ8rb2yCT0/dCY67Q==
X-Google-Smtp-Source: ABdhPJx1rtSdVuiiyy5iVOmwPt+Um0lx4nMkwJpGQD/JuUD1FLEgHSpCgTfxVv0hcA4cMAUz7kzYFA==
X-Received: by 2002:adf:fb44:: with SMTP id c4mr1892372wrs.179.1630567332137;
        Thu, 02 Sep 2021 00:22:12 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:410:bb00:ad0b:57f0:790e:61f9? ([2a01:e0a:410:bb00:ad0b:57f0:790e:61f9])
        by smtp.gmail.com with ESMTPSA id y11sm1166719wru.0.2021.09.02.00.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 00:22:11 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH] include/uapi/linux/xfrm.h: Fix XFRM_MSG_MAPPING ABI
 breakage
To:     Eugene Syromiatnikov <esyr@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Antony Antony <antony.antony@secunet.com>,
        Christian Langrock <christian.langrock@secunet.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dmitry V. Levin" <ldv@strace.io>, linux-api@vger.kernel.org
References: <20210901153407.GA20446@asgard.redhat.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <ef57d76e-358b-4868-aa31-ac45f67bc813@6wind.com>
Date:   Thu, 2 Sep 2021 09:22:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901153407.GA20446@asgard.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/09/2021 à 17:34, Eugene Syromiatnikov a écrit :
> Commit 2d151d39073a ("xfrm: Add possibility to set the default to block
> if we have no policy") broke ABI by changing the value of the XFRM_MSG_MAPPING
> enum item.  Fix it by placing XFRM_MSG_SETDEFAULT/XFRM_MSG_GETDEFAULT
> to the end of the enum, right before __XFRM_MSG_MAX.
> 
> Fixes: 2d151d39073a ("xfrm: Add possibility to set the default to block if we have no policy")
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
