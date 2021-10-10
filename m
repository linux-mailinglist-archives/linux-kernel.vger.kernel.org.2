Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F09042829B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 19:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhJJRU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 13:20:57 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33704
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231144AbhJJRU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 13:20:56 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AAE2E3FFEE
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 17:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633886336;
        bh=4qntQH6iTVpY2LlsjZficLjwmHfD3YcYFwNAdv68/mo=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=iB6QNWE73oao3wOJHt5CczYwkUiP1SwNqftNBNjOMVodIUgaiQlTkL0iAsIYuCGId
         Eqkg7oeBXFz1KmbFU0BQX4B5g7LNxhrCF8A9ZHrAETTTfsyH96Ao9LkFMtT+O+gmD+
         2Bv9ifqJj/xe2RS9VV+pd/Igj6FGNJIpSddSa66ir+Ph/Gnm3t6mtP4apdH85lRrFt
         uaXWOjMlDgjTid9GFgzf7acehacCITl/ebjjrW6xNqXKvjgTX0mqDXYdquJ6y0Qg8/
         t/nsUuziunniB6UMMskgDo1LrGBDJ1P1+SulKj1OcXhDtzw1mU2uzTNQuDHSpoWAWw
         yivGJozg9AHkA==
Received: by mail-ed1-f71.google.com with SMTP id 14-20020a508e4e000000b003d84544f33eso13714017edx.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 10:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4qntQH6iTVpY2LlsjZficLjwmHfD3YcYFwNAdv68/mo=;
        b=5hU0YRetFaGuVEQdT5BnjOlsu7M/kc4eOwivyj92xLaVggJ3Pr/EXiiaO+6GZPetHz
         t2kv1gChk6i0EABXEclHv2yAh0bX/17yTPTdtvbDIovFXTPgTaMf9ncbq3I3A7DxrZhH
         MN9ZJt6W1OcxhFy+MjHTqYc9vbmqxBG+VSMMr9cjTqfLgNFUf1mD9xLwvffm7v/OPFse
         u30S2SmSOUNJlMOeglZWG1EJhZEcWr73tkPqktPzjxac0cL8yBxP9hxvbbPr3ViIq6RO
         L2kliB9h+QNAYtZgPXqITWDvr0bDrbwRnK0lhTqyj8/yqYUeENofonZbz8vadGIZd6oo
         7U1w==
X-Gm-Message-State: AOAM530u9sSNWJkKYaX/82PvuQJlqCXK2JefWZfkTz8f28zHKSW4/uvd
        QwGETj7sbkPmISLu5gggly/nTXWS1o6gUlqAq4HdAvdGQ6k8RyWD7FupwByFH4/HMLIjB9bTJFf
        25sNzuYVoQ01F5sQySgwByKDYELArGhO+BwcsTsM/iA==
X-Received: by 2002:a17:906:4a09:: with SMTP id w9mr18305480eju.419.1633886336076;
        Sun, 10 Oct 2021 10:18:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzR3op9vPfBpT/Rur3yAGyVqNTQAFkiXYhxIGK/aJsucDUphDJMtt0Mbk2Xsc0fWr/HMgUcmQ==
X-Received: by 2002:a17:906:4a09:: with SMTP id w9mr18305471eju.419.1633886335878;
        Sun, 10 Oct 2021 10:18:55 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x14sm2952429edd.25.2021.10.10.10.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 10:18:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH] soc: samsung: pm_domains: drop unused is_off field
Date:   Sun, 10 Oct 2021 19:18:53 +0200
Message-Id: <163388632924.9226.9866323662921764229.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211008075253.67961-1-krzysztof.kozlowski@canonical.com>
References: <20211008075253.67961-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Oct 2021 09:52:53 +0200, Krzysztof Kozlowski wrote:
> The 'is_off' member of internal state structure 'exynos_pm_domain' is
> not used anymore.
> 
> 

Applied, thanks!

[1/1] soc: samsung: pm_domains: drop unused is_off field
      commit: 178d6c1b83e5244b866d90071246b3b0135c3f7d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
