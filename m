Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04BF41D918
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 13:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350610AbhI3LxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 07:53:16 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35080
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350526AbhI3LxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 07:53:11 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8D4A9402CF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633002688;
        bh=c93db0R9/mEQ2t9/8HFE8jep51S83CFD2tq3hjVTTR0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=rTdja7Oj9YwK84+Y8jBOXtpTW6HbE4DwcGmom0oKv2zSzF3HmE5X0qcQMfOgd8w+K
         06laiR9ZYvxZJMTeIPVDgzAavyjzJKejHNgr4Bs/UsCNpBNwuazg7THE+v0ttVrtAc
         NXi6ZH8xvB7er0LUlZoHi+iNSxNk88nbzQxq+nTx8VuHXTuw8lfUjf/2uQcISYHd4k
         +rUJuggI48abY9JO/OTa8aIfTO2jENyduiZ9SU0+YuCcQqD2+JftdFeIiJTxPNI2CA
         kdMWKqVWlOhvHAoNzPIGmLVV0Ekbi/s28OzGxBINFfPXVHCtCUZw4gLfNlYd8R77ZZ
         NTJavHk2YuzOw==
Received: by mail-lf1-f69.google.com with SMTP id o4-20020a056512230400b003fc39bb96c7so5388118lfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 04:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c93db0R9/mEQ2t9/8HFE8jep51S83CFD2tq3hjVTTR0=;
        b=70ue+pLbcQCy4saT4mKyil68YDQxJ16woiNiPOe5rFFt4tOHyEHe+ruTh8RVWBYPri
         DjCOp6ncampY9uB4VXYlIVU1RVuLrFdEKrDtR5dfMoTqHMRI43Q8lLNzIiwxAwyho/1P
         SwNW8tJRLVwkDBkHRFy274diZQJsJzvjU97VAyUKnfozErV8hdTVNRcowBQgqC5TEkBd
         aWgEnA17VN02L2Ofze9J7dH+yUpZuyhBnOGnetBppQJ20JDDBzWgtTlEu3PafG/Tdgq6
         Or6DSYb8XkO5PfcCW9p+8elnTTzoxwFnhAzKOgVFDZKo2IJt85OND+x2TvnJG+EY7iLm
         VuVA==
X-Gm-Message-State: AOAM530L3ycF8DL01qAx6v2H1doBBBsh2tj1dueTkTqd0adMC1kuko0a
        PBjatqCdpu3czOOmVsy8MczTpT4oP1ulruWhkCzB4GHYCZ12TDs7xKbiyCCuYJxeWRBer+0w8Zn
        FX9Hk52XRrUvYOht4BZ+ht7ntr/qJWuMbK73pZBV+zw==
X-Received: by 2002:ac2:484e:: with SMTP id 14mr5584588lfy.140.1633002687542;
        Thu, 30 Sep 2021 04:51:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzs6sdvKFybL6ByKYj+yLvLqJsrPx1jmtaMBZgl/1ZCHRbnmCmECCOE9LEYm5UiMVpfWHFRrw==
X-Received: by 2002:ac2:484e:: with SMTP id 14mr5584571lfy.140.1633002687367;
        Thu, 30 Sep 2021 04:51:27 -0700 (PDT)
Received: from localhost.localdomain ([193.178.187.25])
        by smtp.gmail.com with ESMTPSA id q30sm346400lfb.108.2021.09.30.04.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 04:51:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Markus Mayer <mmayer@broadcom.com>,
        "moderated list:BROADCOM STB DPFE DRIVER" 
        <linux-arm-kernel@lists.infradead.org>,
        "maintainer:BROADCOM STB DPFE DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH] memory: Allow building Broadcom STB DPFE as module
Date:   Thu, 30 Sep 2021 13:50:50 +0200
Message-Id: <163300264748.179315.16980536721607111405.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210924031459.8911-1-f.fainelli@gmail.com>
References: <20210924031459.8911-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021 20:14:59 -0700, Florian Fainelli wrote:
> Allow building the Broadcom STB DPFE driver as a module, it is already a
> platform driver proper with all of the resource releasing device
> managed.
> 
> 

Applied, thanks!

[1/1] memory: Allow building Broadcom STB DPFE as module
      commit: 13f995ceb4e0d669e293aedaaaea07e7b8a5792a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
