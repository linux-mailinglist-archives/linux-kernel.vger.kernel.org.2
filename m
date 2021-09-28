Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D493641AD26
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240189AbhI1Kkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:40:47 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:53064
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240177AbhI1Kkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:40:46 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A24B44019A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 10:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632825546;
        bh=ivKPINsxHhuMLTbuAYFI96pQ5Hl0fcGGP5tJTIK5G/Y=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=myIeBKIYPOc3dGf5XhaEq5DtdPauBAJQI9vxBPXFwz1wGHIl+/hK/dRnOuEdWiZDb
         3VzVk918APPwLx71yd/fqWzfl7SPQYq6gVBh9NnmiLS7nqT+WXBojrvDNmBEZLcY8I
         76oJTDm2PQAPvcANb83TxbR7qFXlA9BM9e8252x1m6QxoUKXv6UZ7zelyZV0vARYiQ
         gUzbPCiwWADO2HqsJ4Wm9OSuABSikD7qDZ+lPfxNU+ufLqmdnK6A21DQVM6MDdd8et
         drvTHUJNcpdRoG1kzwhOQv/O0wf+A18hcJwF+6mJeV6lQLV7HVzBUdf+TFbd3tKOXD
         CUfs7zokt+2dQ==
Received: by mail-lf1-f70.google.com with SMTP id g9-20020a0565123b8900b003f33a027130so18888144lfv.18
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 03:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ivKPINsxHhuMLTbuAYFI96pQ5Hl0fcGGP5tJTIK5G/Y=;
        b=vbJ+aGSV/8Y16dEywuf3Iqp6fd9zzu0ZaaWUAoTjak32WZGNcLciGs8itoHtw7A199
         li0a0ICfzUYOg5tlahLIxuF3YNLspM6N0kOCwbto80xvbR51HNFbvCrIBgXvyrsa8ub9
         h3pHGb78OCHiP/4zFly4p4V9OTdQJ01Gj/xTBlGwAF/RXTGWk+640Y6UlMyY3080i7Y4
         JHvmFBKukaUUXTAgotiu7Lqq+2dGFRCZMSNK1P30Vj6i0JEUltAPIx7yULypS3xM/AnW
         WGskw0Bx4b6VY2ky2cidNXGhE7kSH2UxNnV5WoMntHfQlLXT8pSwcl/1rgRAt1jD1Zum
         m7lQ==
X-Gm-Message-State: AOAM531SplONpYYjcBeFUX/81vzGoRG69MHQ+PZHhL4Gv3ZvYqkedTHg
        fJnz8Qv5y9GshmCFHeVz0kttq0V6uhwlGc+3FkyQtcdqEM4GjP05YPp8GgaKiCYvTsnFw79VBHQ
        5j+CpC3II1WG80u4XrZf0DmT0k51bv5YUi6u5rNUEPA==
X-Received: by 2002:a2e:9e03:: with SMTP id e3mr5013809ljk.278.1632825545986;
        Tue, 28 Sep 2021 03:39:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxuAYZshvl7TpiVeCuaqx5L7VwDkdBKHM/wshS+YVoCc09h2vlkjMDabUci7TaG9DFdHzx8Q==
X-Received: by 2002:a2e:9e03:: with SMTP id e3mr5013796ljk.278.1632825545816;
        Tue, 28 Sep 2021 03:39:05 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q5sm1887551lfn.277.2021.09.28.03.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 03:39:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory: samsung: describe drivers in KConfig
Date:   Tue, 28 Sep 2021 12:39:03 +0200
Message-Id: <163282553904.34918.6284506509137865249.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210924133406.112174-1-krzysztof.kozlowski@canonical.com>
References: <20210924133406.112174-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2021 15:34:06 +0200, Krzysztof Kozlowski wrote:
> Rephrase the Kconfig option and make it clear it applies only to Samsung
> SoC.
> 
> 

Applied, thanks!

[1/1] memory: samsung: describe drivers in KConfig
      commit: 6b20a5d173cd5647f0bb1ac8796264b70c377d79

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
