Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E8F3542AB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 16:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241281AbhDEOSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 10:18:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55599 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237537AbhDEOSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 10:18:03 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lTQ3A-0006KN-2G
        for linux-kernel@vger.kernel.org; Mon, 05 Apr 2021 14:17:56 +0000
Received: by mail-wm1-f72.google.com with SMTP id a3so1598313wmm.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 07:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VEUY8j6GwwY9LYVNRBDFe9nrh9WQ2A0mUlbgiGIRVY8=;
        b=EeL/VOvjCkHt9F/267EgsSR5Wg5uldB3xCnoVuvVW0t9Pi7kKV5v5gxKmXNs+ZOl7T
         0tB10o7wBUZ8bERTk574sWFUFBOmjBbgOvQbJ8Y8LvmlT3TgydUsIn6WGw2PlGnrZ7sW
         NePmnT75HVlXvbdvK8AXls+freacvCcHqGRgzZpto5o1hskrVUdTsp6Fh4rrZ9PGQmxM
         Q30wtw0qeQWibEtDCuDSRipX5avKL7HFCCoP7yZaVdp1kCeL+rwldTqq9jsakCfPyGft
         ThtPbcX+v14AusucsQFWFaG5oz9T4h8f6K1oqxszm2g3/eOSemTfSBkEP+oTP8I6u7wY
         tnRw==
X-Gm-Message-State: AOAM530NOLVUw77Fc5q9bpP5b3Dm6G+48ToBRmi/osdJxBD1yUc9V1Dl
        9SN+dijKxka8uknSofld637fldNiQv9bwVm6pl3ppbqOSI/llEG/dRAxtR5+BfevzUWLLN0O9os
        TlIpK4ecfIsMwcRn/YNlpBcSNCsP3SFvdD8clTiIx+A==
X-Received: by 2002:a5d:684d:: with SMTP id o13mr30503372wrw.235.1617632275866;
        Mon, 05 Apr 2021 07:17:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJpC4y+Mv7D5WzFkfsNYGYusWKBiIFcsP7OKSAbcVO8fQa4AYnetwolYmB0sIAzoNSKQesWg==
X-Received: by 2002:a5d:684d:: with SMTP id o13mr30503357wrw.235.1617632275715;
        Mon, 05 Apr 2021 07:17:55 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id u2sm10319094wmc.22.2021.04.05.07.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 07:17:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     krzk@kernel.org, gexueyuan <gexueyuan@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory: pl353: fix macro definition of ecc page_size for arm pl353 static memory controller
Date:   Mon,  5 Apr 2021 16:17:53 +0200
Message-Id: <161763208380.19793.10152389628099577320.b4-ty@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210331031056.5326-1-gexueyuan@gmail.com>
References: <20210331031056.5326-1-gexueyuan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021 11:10:56 +0800, gexueyuan wrote:
>     the macro "PL353_SMC_ECC_MEMCFG_PGSIZE_MASK" should be 0x3,
> according to  the datasheet of pl353 smc

Applied, with fixes in commit msg and adding Fixes tag. Please do not forget
about Fixes tag and start new sentences with capital letter. Thanks.

[1/1] memory: pl353: fix macro definition of ecc page_size for arm pl353 static memory controller
      commit: 25dcca7fedcd4e31cb368ad846bfd738c0c6307c

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
