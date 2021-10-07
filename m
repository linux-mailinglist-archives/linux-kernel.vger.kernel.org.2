Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917B8425B0C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 20:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243706AbhJGSpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 14:45:11 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:38626
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233837AbhJGSpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:45:10 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 75A4440015
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 18:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633632195;
        bh=qYzfFN55GO79I6m4fOM3zQoOFUEQ/APBEhL5dczQP24=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=S2lV8qOeGwVuQzlpNutjxJuGdlV4LJ7Lnm7QNJDQ+nGpaq7QlGODIhbDbszdvmO0U
         T1xRQuexkKkcKKnnDfQbe1Dqq2GbV6F1Nj1t/34RLQKLfLyK+xILboFBgJ+YlWTyDN
         zz811iFpItuBSnunQwJKmnKRjaVDzjCJZvRDkBvyFrcHD+tk/XOtDMOz1QuHEeh1rr
         d/OMyn5OMoqnzA26+5qY5tGVgRZ5GxBvioyI2DDT4Eid4q3hzPFvdgxV+EmXSP6OPU
         RHcVnHBAK2Ld0xnxq+T8F8YnWHnV+sVybywYw6/ifQHERcDKm/b/bBx3iLIOa0fWw4
         85Royrd5VZ29g==
Received: by mail-ed1-f70.google.com with SMTP id z6-20020a50cd06000000b003d2c2e38f1fso6810691edi.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 11:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qYzfFN55GO79I6m4fOM3zQoOFUEQ/APBEhL5dczQP24=;
        b=En24JAoQW1dKew/4l+OtriMrWQJMekHNHGSbkGriTEDeb2jO1CLsVC32rfKFOUkk/U
         7dnAhKUdqoqHHYioMAI5vh8Cr5T94S+Cz29nO+ablxpC6hOLUMEPUjv25NVIKx+YjZYX
         zHLnFRTnj3HrGg7i3N2NWeX8MBdtxBiO/yWLCd/ni2ZvBiM+U3YxPMTIVKduljLXtFDv
         kKDWnHxqWAfffn01QC87vgI7gYY5ssdkbiwGWvdp0GMElaCmEdOYc4x8qNh0TEMw3sED
         okMpdiaiVcz12e5AkIgS1TqMYnKM8+/xJ/2EuUOCsHojRB6kFcdxIQOMEOk7BFURnLFC
         LTwg==
X-Gm-Message-State: AOAM531asNw3+qfRisAv6gDLPTs3TMymtrFoFQvzzm20WYO9IlRtLfYI
        9MUl7vC3ec6WG1/BhTXO/aq286cFcpicAwXWJ0BrnSu52/rXyEAMypZJklYlrhDc9jPttoLXSWd
        Qgle5TxH0Kv2uG8TCXXewQKiz0YxOMzPge1wirLAS2A==
X-Received: by 2002:a17:907:1044:: with SMTP id oy4mr7540975ejb.308.1633632194959;
        Thu, 07 Oct 2021 11:43:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyloHK1TeegukHGfBmrAhUlxA6oaELOAawkz3d4AeF0wd7eUlsyBq1wj82116phZyrgKCh3LA==
X-Received: by 2002:a17:907:1044:: with SMTP id oy4mr7540961ejb.308.1633632194826;
        Thu, 07 Oct 2021 11:43:14 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-186-13.adslplus.ch. [188.155.186.13])
        by smtp.gmail.com with ESMTPSA id t19sm70612ejb.115.2021.10.07.11.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 11:43:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] memory: RENESAS_RPCIF should select RESET_CONTROLLER
Date:   Thu,  7 Oct 2021 20:42:43 +0200
Message-Id: <163363216362.76978.3560357195646181957.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <e443aa66d146da5646b7ebece8876545b8621063.1633447756.git.geert+renesas@glider.be>
References: <e443aa66d146da5646b7ebece8876545b8621063.1633447756.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2021 17:29:22 +0200, Geert Uytterhoeven wrote:
> The Renesas RPC-IF driver calls devm_reset_control_get_exclusive(),
> which returns -ENOTSUPP if CONFIG_RESET_CONTROLLER is not enabled.
> 
> 

Applied, thanks!

[1/1] memory: RENESAS_RPCIF should select RESET_CONTROLLER
      commit: 4a26df8e60e534110f37e23c068f25f2f523bb83

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
