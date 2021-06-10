Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393A83A2573
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 09:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhFJH3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 03:29:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40893 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhFJH3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:29:12 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lrF5v-0000UA-Vz
        for linux-kernel@vger.kernel.org; Thu, 10 Jun 2021 07:27:16 +0000
Received: by mail-wr1-f71.google.com with SMTP id r17-20020a5d52d10000b0290119976473fcso460193wrv.15
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 00:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fTOdYztHGax6sYftx+TrBNeuOAueU3PeXK4xtH+0vXE=;
        b=UOFgQqQKI0TKpZVUz0DsCcy105Rz0qx5DibgApuOEjnDt3hxRs1dOnSFCBjTLSzSUD
         Lwc+xlwb/HG/MJ/zFjhq88FkdDtGtlGSCSBl1ngcRzZGJEdumfoUkUiBBs4Z6s7V3rVF
         0zXFeTarDlqLzvkUeMudrzcMfgKTImUDXtci2/YbV6oJOWAqmJxuaU0Ilof2zB5GxN/e
         B17eylLGFYtonSPaDRXQyw/hv1+dyjw4WoFQxmFh4JId95SCfcdt4osXX3W43CZncZ8n
         ghNgbMjl7+aK93bZQGb2Ut9DlULwOsmTD5KnrJukd3s9yF51/JVTwgSL34wZLSvXKKbJ
         SEgA==
X-Gm-Message-State: AOAM5338si9NFG2UDOYKWVx7t1H1HP/yJHXWcyj3VF8jKQZOZJDIYZ/d
        5ZNUTkgqLP52SZjp7jgO0ItC2n4ep3uIubVmmXK0OL1Q+ObwicdTWfb29GBJw8zhF1dK5L6xp7q
        82HlKZGsnv2+0qF2MzAb+Q8502kWpSDLGRduXxgOPYg==
X-Received: by 2002:a05:600c:4f44:: with SMTP id m4mr3597202wmq.91.1623310035438;
        Thu, 10 Jun 2021 00:27:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsuxsB+zakKEculdhLhfpxLID7n7eZVQ9X6EZmvVZqqmAY10NJsVOcTH83Cx07T1wuXCUIoA==
X-Received: by 2002:a05:600c:4f44:: with SMTP id m4mr3597194wmq.91.1623310035328;
        Thu, 10 Jun 2021 00:27:15 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id b10sm1868636wrx.57.2021.06.10.00.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 00:27:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Aneesh V <aneesh@ti.com>
Subject: Re: [RFC PATCH] memory: emif: remove unused frequency and voltage notifiers
Date:   Thu, 10 Jun 2021 09:27:09 +0200
Message-Id: <162331002598.10998.5385076435904723873.b4-ty@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210527154101.80556-1-krzysztof.kozlowski@canonical.com>
References: <20210527154101.80556-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021 11:41:01 -0400, Krzysztof Kozlowski wrote:
> The driver defined several functions related to handling of frequency
> and voltage changes:
>  - freq_post_notify_handling
>  - freq_pre_notify_handling
>  - volt_notify_handling
> 
> All these are static, not used inside the driver or outside, and marked
> with comment: "TODO: voltage notify handling should be hooked up to
> regulator framework as soon as the necessary support is available in
> mainline kernel. This function is un-used right now.".
> 
> [...]

Applied, thanks!

[1/1] memory: emif: remove unused frequency and voltage notifiers
      commit: 729a611e6f53da00ed62a181f2d5d2bcf22d74d1

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
