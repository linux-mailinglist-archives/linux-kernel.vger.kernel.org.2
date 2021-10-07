Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457E2425B0D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 20:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhJGSpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 14:45:13 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:52266
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233848AbhJGSpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:45:11 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4D5353FFEC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 18:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633632196;
        bh=hOkESq7I5LNBU7s+mO5+w8167aI99VR3a+c60NXPYFE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=l2UOuRjivtv0xjmkUtWEUDwZBG6mZbZ1YijmwgqSLnNlZFLzoq/Eexm/9h4EV0vuK
         nKLIlP+nX2oi98P36Tm4hVEs5x10kpa+G6SN5nWpAaZLWzenkxGKn095ihWYtTw4BX
         h98YfoocOpuqKmM50q05KDKD/gcUadkoJ+mbgeZwZLdQsg1oTgKwIzMEu7RTmrJu4/
         BK8dAnA9g2HMvtP8nOp6RDOfvF5j9F/8CSCosPcBp9VSPOS4FUR4e7KIkXY2bwXQol
         7z923U1Jl2aLMuZSAGvboL8xYWDscpPvIsktqy/SGkuZvAj71XAnFp40GNO9HMaql9
         QszC414LDx2CQ==
Received: by mail-ed1-f72.google.com with SMTP id x5-20020a50f185000000b003db0f796903so6750165edl.18
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 11:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hOkESq7I5LNBU7s+mO5+w8167aI99VR3a+c60NXPYFE=;
        b=q2lz+z2HdPIFTAkwZps4g0ctEspibFGWCmZc4Y5pr3pvkhdLA9ooVVFnKv4q44YcuX
         cjNINoDLvXcRlZcHXDAF1hZYomgCeNuxGWV60Mh9KVqzmhwSp2/kF7vDq/I+OoJivL8t
         ROMljSl9QalUMAGY6yeuY5613sKqSteCDReiKs0X1xgZydlaXOCGdfKeNiFdrYvdWTmL
         /LOL40n9VFTiQ3Fip76KmFePq0EeOwtLxO0jNR3FAeT9a62PbfnTIFx/2GpFKScZfnep
         1xPJiMkv3D3uMucOySAQRi1z19uBjzPdZZ/pFRMFptDG006oPuGS4TUfWJf4b+RKj2VP
         VZAQ==
X-Gm-Message-State: AOAM533sPStlzaiEtsMCxcSWyZnP2hfPInBiuJN05k6t5evcyiAK+tsx
        q/SW3pLPW8im/I9guFGJJFVlDY7Qyap1ZGJdDay6nOpmlvk+icBMbekdz2SoG4Ka0sf+g/Bnw3y
        SnNrYjj1d7BfItA0fwTmoEMVkm9uhaCuyTn1hxl2Ecg==
X-Received: by 2002:a50:be82:: with SMTP id b2mr8313236edk.56.1633632196042;
        Thu, 07 Oct 2021 11:43:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyU/NTl7uN5qZEg3rsTBMfEn7OWV3xPVvSHqAIyDf+yJJwxnzYR1iqoUuiidYH2RWxnyoZEKQ==
X-Received: by 2002:a50:be82:: with SMTP id b2mr8313219edk.56.1633632195889;
        Thu, 07 Oct 2021 11:43:15 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-186-13.adslplus.ch. [188.155.186.13])
        by smtp.gmail.com with ESMTPSA id t19sm70612ejb.115.2021.10.07.11.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 11:43:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Dongliang Mu <mudongliangabcd@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prabhakar Kushwaha <prabhakar@freescale.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memory: fsl_ifc: fix leak of irq and nand_irq in fsl_ifc_ctrl_probe
Date:   Thu,  7 Oct 2021 20:42:44 +0200
Message-Id: <163363216363.76978.10999134270437599845.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210925151434.8170-1-mudongliangabcd@gmail.com>
References: <20210925151434.8170-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2021 23:14:32 +0800, Dongliang Mu wrote:
> The error handling code of fsl_ifc_ctrl_probe is problematic. When
> fsl_ifc_ctrl_init fails or request_irq of fsl_ifc_ctrl_dev->irq fails,
> it forgets to free the irq and nand_irq. Meanwhile, if request_irq of
> fsl_ifc_ctrl_dev->nand_irq fails, it will still free nand_irq even if
> the request_irq is not successful.
> 
> Fix this by refactoring the error handling code
> 
> [...]

Applied, thanks!

[1/1] memory: fsl_ifc: fix leak of irq and nand_irq in fsl_ifc_ctrl_probe
      commit: 4ed2f3545c2e5acfbccd7f85fea5b1a82e9862d7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
