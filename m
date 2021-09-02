Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE9F3FF545
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 23:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345768AbhIBVF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 17:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbhIBVFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 17:05:55 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D568C061575;
        Thu,  2 Sep 2021 14:04:56 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l3so2241589pji.5;
        Thu, 02 Sep 2021 14:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=idJuIcevWkqCRRn4+icscBWsB2SnJKWNGgO1oxC6Tc0=;
        b=HN5adWYYIpI2LVvWr6lnonO4zJlEjQKD9RBaqjmuoRrtbY2vsMiYqLx7x0f7Kqte0Y
         dsr4SFxUQ43+5n+HuxAQnOON+r9AQu/VNoZ146G6yzzx477X05kV+Kotu5Ww8/CQfptN
         OckYeOVp1fi6UipsI7GRhLBsPhw86bm/nVntdQFYatoqiJ9Puhrmi6k9aVduyyO/sleZ
         Jsj3WBFHJyc08NhtwT2Xw/PqrpifEzcne8tRGHxX1SiH+jylGro77EXl73fxmHPa5PMh
         SMIvVQzZl8rW9HtJexGPCU8u6hSaCa9HV3dv5TXtURj5+dyyKoxRdNbRvfHUeAgqfUsh
         9q0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=idJuIcevWkqCRRn4+icscBWsB2SnJKWNGgO1oxC6Tc0=;
        b=Nwq8/FnhrSeTrK25cw06j4jkIyDMicHK+LIPQbdjlXoIXLXKC0h8KOq0aq0hixMSYw
         F8yYObYHMFz+gmg5u0Fkgj5swyB5cYKJcK+nfQV6NgGdVHqLFtdvAoriDjn9e1ivKdsd
         qsW491a8r6XXUx/UYzJ/UYn2rzfrIZCmGQFrvfgEcXXwpOUQxbDkr/Ibk/T9c+yQLkZD
         7PlVCMqCI7MIErlv5aEq0acrtdPAc3TM34RflLXfzyqnxK6umItf0HIj7Zbq1/FEC28q
         pxAKHw2V2CM2uN/ARICeRESe+bRVSzQarQZnZS8vHGVw7fDq3MN+J1t0HsNVMQSjrpNo
         ryeA==
X-Gm-Message-State: AOAM532kcVfeN0BFDVWskzef+8JfCji2i00h6FzUx8MILt1hedkL5pGS
        1SNVcSIzkCjKpsE2RTLPcPQ=
X-Google-Smtp-Source: ABdhPJx1U+TwaPyWVd/XGRdcuucmF9VhgxJohkTd0Uy9fqQSVpJECKcBTm4ARInlpH12Jfm7la9PVQ==
X-Received: by 2002:a17:902:714a:b0:139:25b:3996 with SMTP id u10-20020a170902714a00b00139025b3996mr4657043plm.25.1630616696068;
        Thu, 02 Sep 2021 14:04:56 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o14sm2635527pjp.1.2021.09.02.14.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 14:04:55 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Matthew Hagan <mnhagan88@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] ARM: dts: NSP: Add bcm958623hr board name to dts
Date:   Thu,  2 Sep 2021 14:04:54 -0700
Message-Id: <20210902210454.3102738-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210829223752.2748091-1-mnhagan88@gmail.com>
References: <20210829223752.2748091-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2021 22:37:47 +0000, Matthew Hagan <mnhagan88@gmail.com> wrote:
> This board was previously added to
> Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
> however the dts file was not updated to reflect this change. This patch
> corrects bcm958623hr.dts by adding the board name to the compatible.
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
