Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2924037A6BD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 14:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhEKMc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:32:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51017 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhEKMcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:32:51 -0400
Received: from mail-vs1-f72.google.com ([209.85.217.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lgRY7-0002Jf-TH
        for linux-kernel@vger.kernel.org; Tue, 11 May 2021 12:31:43 +0000
Received: by mail-vs1-f72.google.com with SMTP id z7-20020a67ca070000b0290220c083d3acso9570173vsk.21
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 05:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k1bRU1o0XDKDOSL5Zk+c6E3Lv3V2GRqSbTlCU06mzmM=;
        b=aUtEJ6MgUjwXASmDzmC8nAWYHfqosG2mK9Cb3mRQeQDeeZthv+YDW0+diQdMp9ehUi
         RaRsBwCibF1Gx//o8yBZziUE32DCghTm76aZRWspr0JOw7Z7nkh9kfKuqFg70eFLppnp
         mUNuqLMZNYydYBfoCoA8BpQzg0yQVa8urxe79y9/pjAxF/eiaEAqp19+jlo8w/fhS8nM
         OlCmfS2H0yHOSnDMq/+V/46FVwT0D5fywpzuItlE60IWsgAGFA0V9zciXtz3rTwqbe/9
         AkqNAa/IzCGJmxwlNKj1h4N+94Xk6Ln2CSwWQNWOHcy+R40yoGWxq/ytmF1VrcBhMvwF
         C1sg==
X-Gm-Message-State: AOAM531rnJoSZP9msAKmP/ZYNc+xzmDyTOZytZBcSkGKwZvL5XwsEdpY
        7f/hEjcrYEdKMHI/5xVKjAJ0gI81BEIHS7UhwFt+zdsgLvILxp2uf7C4Cxl5WlAKezWDin3JDLS
        IoueZtzfWgf/E2fu2Zs+HHaz8aW30eX24BLsaMQ8pAg==
X-Received: by 2002:a67:bb19:: with SMTP id m25mr24697723vsn.20.1620736302566;
        Tue, 11 May 2021 05:31:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzheT2iWzozwWSQif58RwPbtpuK69eVOhz1J56oNWfzG1tL43SxUWwiNyfpGIsjEGLNBRuFHQ==
X-Received: by 2002:a67:bb19:: with SMTP id m25mr24697700vsn.20.1620736302391;
        Tue, 11 May 2021 05:31:42 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.2])
        by smtp.gmail.com with ESMTPSA id q22sm20199uao.13.2021.05.11.05.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 05:31:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-samsung-soc@vger.kernel.org,
        Wan Jiabing <wanjiabing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kael_w@yeah.net
Subject: Re: [PATCH] arm: mach-s3c: Remove unnecessary break
Date:   Tue, 11 May 2021 08:31:33 -0400
Message-Id: <162073626992.10946.11784853350682538315.b4-ty@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409064920.1096367-1-wanjiabing@vivo.com>
References: <20210409064920.1096367-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Apr 2021 14:49:20 +0800, Wan Jiabing wrote:
> There is a return above the break.
> The break here is unnecessary. Remove it.

Applied, thanks!

[1/1] arm: mach-s3c: Remove unnecessary break
      commit: 0de0b04c83430ee913c9683369b7059e04e106cb

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
