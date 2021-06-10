Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B168D3A2574
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 09:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhFJH3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 03:29:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40897 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhFJH3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:29:13 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lrF5w-0000UJ-H6
        for linux-kernel@vger.kernel.org; Thu, 10 Jun 2021 07:27:16 +0000
Received: by mail-wr1-f70.google.com with SMTP id u20-20020a0560001614b02901115c8f2d89so469594wrb.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 00:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ajbE739OPi+BQZ+lLhI8Xds2mgEo/BkYGjPrTyPTf8=;
        b=jew62Ay2XgIg7SahieAlFsM5s2oovwMLV9LlR+/2I2QFMzo+Y0MgqP9zdmaCcr7/Hr
         QPPN1Lx8umfb2TADzi5GoItLo3Sp37PeaRCZvZLPa65lVIDP8WPtK5jQuPngoJksCJ7E
         zqwrP+ckcU4Gyp7oQT6CmnitbiuQIzAWlUcNyoQlljYCenbHgMw6Nguuri8SqW0fcVyG
         EJVuVrWtGfzOC+qp1qhFN6yD5dLnvB8Ljsd2g+GOyFV3p9A43K8Uo0oCgnlEzdy5L6pt
         7IaHWeUjQHPR6wcTZ6SANOJ+oJ318np5biBgmM2sT4nvKlAdbi38pa7UYDjefl2jTbFz
         pgaw==
X-Gm-Message-State: AOAM532InfvTPwyT2Hzrm8K2IPVFZCaKALrBpJbD2Z6ViQnfWO4+1G8o
        LY8Yk3NSp5gDdamiWtB64iOZYu2W9lnwk8EsfTWKQ53EZf6vBLDfu2+2SMnQXE2hvK82SWWDnRd
        obWA36hQjl1S7bSQmSd9n1RZeO3lxd4o9PJeCyBmG+g==
X-Received: by 2002:a5d:5307:: with SMTP id e7mr3785490wrv.300.1623310036314;
        Thu, 10 Jun 2021 00:27:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJ9aR0j5dgTXE/slePrWfolep108WDooaWXp8vCXJjQJsC7UlWpQTs2FiTSxY8FDFgzpBbcw==
X-Received: by 2002:a5d:5307:: with SMTP id e7mr3785477wrv.300.1623310036201;
        Thu, 10 Jun 2021 00:27:16 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id b10sm1868636wrx.57.2021.06.10.00.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 00:27:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Li Yang <leoyang.li@nxp.com>,
        Dipen Dudhat <Dipen.Dudhat@freescale.com>,
        Prabhakar Kushwaha <prabhakar@freescale.com>,
        linux-kernel@vger.kernel.org, Liu Shuo <b35362@freescale.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [RFT PATCH v2 1/2] memory: fsl_ifc: fix leaking IO mapping on probe failure
Date:   Thu, 10 Jun 2021 09:27:10 +0200
Message-Id: <162331002598.10998.10200143130121848334.b4-ty@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210527154322.81253-1-krzysztof.kozlowski@canonical.com>
References: <20210527154322.81253-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021 11:43:21 -0400, Krzysztof Kozlowski wrote:
> On probe error the driver should unmap the IO memory.  Smatch reports:
> 
>   drivers/memory/fsl_ifc.c:298 fsl_ifc_ctrl_probe() warn: 'fsl_ifc_ctrl_dev->gregs' not released on lines: 298.

Applied, thanks!

[1/2] memory: fsl_ifc: fix leaking IO mapping on probe failure
      commit: 3b132ab67fc7a358fff35e808fa65d4bea452521
[2/2] memory: fsl_ifc: fix leak of private memory on probe failure
      commit: 8e0d09b1232d0538066c40ed4c13086faccbdff6

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
