Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40F5435DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhJUJV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 05:21:57 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:44254
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231320AbhJUJV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:21:56 -0400
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CD93C3FFE2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 09:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634807979;
        bh=/HhisqVm7ErOFfWC76qHpvI3z/SiF8V4VeJo7KglsS4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=bhnnia1v4hyhShqI2/oEnNwGHMSZDzlGHbx0pXZTsgvvJTi+2KG3qBNarScG+jPpY
         Md980FtoUC5nFpRwYg5fcSoP9dM4nRRv5kYMQ9ayZ2HmRskvZYDpR4b4ThEqFWSl+M
         3r62gitibWOAYgWk+QdumqYQaNetw4rNEEusffLaDKoniNvopsEZO6YhEh6GEgEeVp
         8Oozkbb6Kjj9NpipSt7TC/OU46XYMZakz32It1jUQjx84iVJK8w5EzjAj3eSl6CQzD
         b0lTR8oC+05Z3P4y6hpnJKIAeHySjDzUSu6G6jwqOfYekj1H1v4vC6fCWv+JWiR8zq
         U/aN8edEZnbCg==
Received: by mail-lj1-f197.google.com with SMTP id 136-20020a2e098e000000b002110b902242so2559172ljj.20
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 02:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/HhisqVm7ErOFfWC76qHpvI3z/SiF8V4VeJo7KglsS4=;
        b=db2KrMJxrksI4si1A9flZ2SHfnBAszkWUT9DCjaQIu8YBsEuZSDiG3RGdOqZ4jDBny
         ZBewHlFXJmHRO0oPP0OA87tiNoITnjqLBdnI6vhy7fFOP0W/QY8o7GBobR/Id82tOD0P
         wxUR8B9ixcLLH6oydJJjngf7nUPG07tssYTF4RNnd766XnZ5FivfEQ90yFHY8Zctdu0X
         1pt67s5uAWw+Fx3mRXJtV2bAN3TC0fuVLA+IZOVo5GWYLRU9O1YJMVUZC40f7+sSddyJ
         e5Z3drGNUUmuvXa0NSmpVzykADurcI6FI8lTCIm/uRdUbjtqcmGi2heldzTb6U2/0mB8
         FLEw==
X-Gm-Message-State: AOAM530NtV9zYN55QsHszRnl8uQdWsGPcgboJfNjB640gitGH66CrFqN
        UXckxm/Kw8EkkVozDOsvLwA9JQKLIkaffOahe8uf/W1/+prahvBA0x9DFauY3p4FV8tKE+rnpEk
        v2tfXpluPz0QvmB7Bud1v8PJ7SOdGWa4GeR9Be19kMg==
X-Received: by 2002:a2e:b690:: with SMTP id l16mr4659204ljo.112.1634807979277;
        Thu, 21 Oct 2021 02:19:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdzRKJjtYj2xHphNZ4bIpTswp0KtXkQNgkEirsg/0cvp1UuxKjql3APB0/TtZWJcS+F+gEnA==
X-Received: by 2002:a2e:b690:: with SMTP id l16mr4659192ljo.112.1634807979122;
        Thu, 21 Oct 2021 02:19:39 -0700 (PDT)
Received: from kozik-lap.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id r15sm106713ljp.88.2021.10.21.02.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 02:19:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Nicolas Chauvet <kwizart@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] memory: tegra20-emc: Add runtime dependency on devfreq governor module
Date:   Thu, 21 Oct 2021 11:19:36 +0200
Message-Id: <163480797353.116816.12374753555350703241.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019231524.888-1-digetx@gmail.com>
References: <20211019231524.888-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 02:15:24 +0300, Dmitry Osipenko wrote:
> Tegra20 EMC driver uses simple devfreq governor. Add simple devfreq
> governor to the list of the Tegra20 EMC driver module softdeps to allow
> userspace initramfs tools like dracut to automatically pull the devfreq
> module into ramfs image together with the EMC module.
> 
> 

Applied, thanks!

[1/1] memory: tegra20-emc: Add runtime dependency on devfreq governor module
      commit: 14b43c20c283de36131da0cb44f3170b9ffa7630

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
