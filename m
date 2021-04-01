Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE44D35203D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 22:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbhDAUDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 16:03:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45358 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbhDAUDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 16:03:04 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lS1Zs-00055Y-Kt
        for linux-kernel@vger.kernel.org; Thu, 01 Apr 2021 17:57:56 +0000
Received: by mail-wr1-f69.google.com with SMTP id j4so3113527wru.20
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 10:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=reVaJRYcfZ9SQGDKGvJMLjraCPqUETQ/gdCZ6pn2GEA=;
        b=jG0+HI5RwNRKWn/qGyT77rSXssIcJUIhMYn398GgvTFxBdBftORV44H+AQ4tuHJZak
         NGQ3/Y8q/tjoZLOebZ0KvN38DgXbzWsfOmV9VU8UJUkUc0dQNsuLJnkZwitbW87yydXj
         BXIBBLZd6j1pG9oDwyZSMovFqQfyjn3ATBI6PccAa4cj590QDRsSYRMbzDQtpHp7dXAK
         FQw0zNRvFc860AJpRgQkYcRGxG9+yd0PNYJvAnZm/LXh3MgvDBqgxOKk47YmMple6xjv
         O4Qb6tIDQMwu8iO0IWcJnYcE+PjXekm4O1qh4+euJx7guAraSPqtAKDC7qiauvil6msa
         l0Bw==
X-Gm-Message-State: AOAM532e1iVbfOEnW+H4Q8PR3APak2DBeRE7IjTVfz/0TCJMbUJEDvuF
        O85AcJdba8q3RHCqH8J5rUBbb65Tc7jcYPMUEXoh2gWbzaQf2DsTKpY28bdeEVeJowZwytrjb0E
        ko3lEiHmb4sYtb5ysbB4xCtVQkgumXDRFxJjvFmxK1g==
X-Received: by 2002:adf:ba87:: with SMTP id p7mr11279729wrg.298.1617299876449;
        Thu, 01 Apr 2021 10:57:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw58DyZ+b1zm76scn0+xZLlYZsGMec7AwPe4uNl8XDWKzxgPyAShzE5AoParw/39EKDt1NO3A==
X-Received: by 2002:adf:ba87:: with SMTP id p7mr11279721wrg.298.1617299876365;
        Thu, 01 Apr 2021 10:57:56 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id l8sm11095443wrx.83.2021.04.01.10.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 10:57:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Qiheng Lin <linqiheng@huawei.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] memory: fsl-corenet-cf: Remove redundant dev_err call in ccf_probe()
Date:   Thu,  1 Apr 2021 19:57:54 +0200
Message-Id: <161729985964.13281.7088965998639622367.b4-ty@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210331093244.3238-1-linqiheng@huawei.com>
References: <20210331093244.3238-1-linqiheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021 17:32:44 +0800, Qiheng Lin wrote:
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.

Applied, thanks!

[1/1] memory: fsl-corenet-cf: Remove redundant dev_err call in ccf_probe()
      commit: b11a188aef6d19fe3ca505831d9c627ef683476f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
