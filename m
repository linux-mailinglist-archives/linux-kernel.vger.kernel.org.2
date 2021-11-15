Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD734451425
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 21:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349065AbhKOUBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 15:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237799AbhKOSCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 13:02:50 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00455C0431AD;
        Mon, 15 Nov 2021 09:31:17 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id b13so15106726plg.2;
        Mon, 15 Nov 2021 09:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XqTFG+vsj+Rkt2pztu9H78SObf/C0oEBoB7W2hlhRbs=;
        b=HhO+TbpkeiRVIqlQ2RPYQKYqJgibry8lm1oAVIwI2MyjAZwG4JZwaLiE6G8X9q3l7W
         9zPtUWKcGpDZ0SDvq2kUG/grvzxV6hSINTGpCCZ6Rkbd/wubk2qvZ+RDh162/M/IJUbn
         qz/tOJOyM4cg0nb5aMBCZ7+LJGn7xI7vnT7lJg+IYj+1Lq/VemFUgczXhpdrzLJLO/l+
         T4y7w+xwXLQdgXgYCs6PLyU5uPZXu/m4VDCkY1QirezGPJCgfeoEG5kGL1MxPByUXTsM
         myKLaLBjjNojLET4ekWHUMXjpBkWxbn/HHWA6VOVcP0xUUEB/x9McNfmduyM7T0c0k1i
         Orhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XqTFG+vsj+Rkt2pztu9H78SObf/C0oEBoB7W2hlhRbs=;
        b=kJqw+HvLCDNJenW02Vzfcb7VRtWxRTAF6douOyZEfGa5vnOOSFS42lq24KLSs/7l7t
         QgqJ/L6/KkbbvzYfE6JsVmOV/8CpWZGLidKC1GXH8bVO9EGJg7Mbeq5pLtAzedOjnTzT
         MbAv6P4MjphfFjxk7ji7lwZqdhikzgLbuq7mxCNpbx117Oag9jwp3Er+EnnxtWRhVZ4w
         z86ARDjxQ+qY3Cc6BD1km1dR+uIZ3gbkJKvM7oABEJrM6f5ybfhQetGGPRy+JgdOHtvb
         N+Gw9bhAjIlkTPDUbTzngOh83qivYUK3UDGuErDbm/01uR+YHRKwgcxkPfDkHkIr4U7U
         aiXg==
X-Gm-Message-State: AOAM532Fk/6RoXVTBMKubykUizLurEh+3Aww15ZrPHRDx9DPjmm1EeWP
        pe2OuSL5GzFT2aeyMUDJunY=
X-Google-Smtp-Source: ABdhPJyUdN0SQXZ7BxKs6nIbwzXDQPkcHjX+rKqvlDOAWdG4CnKPTo6t9lez/yiNgwsPapjC/AbOqA==
X-Received: by 2002:a17:902:934c:b0:13d:c685:229b with SMTP id g12-20020a170902934c00b0013dc685229bmr36797166plp.25.1636997477425;
        Mon, 15 Nov 2021 09:31:17 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y32sm17949306pfa.145.2021.11.15.09.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 09:31:16 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Cc:     chunkeey@gmail.com, arinc.unal@arinc9.com, mnhagan88@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: BCM5301X: Add interrupt properties to GPIO node
Date:   Mon, 15 Nov 2021 09:31:15 -0800
Message-Id: <20211115173115.489017-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211028164654.4014646-1-f.fainelli@gmail.com>
References: <20211028164654.4014646-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021 09:46:53 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The GPIO controller is also an interrupt controller provider and is
> currently missing the appropriate 'interrupt-controller' and
> '#interrupt-cells' properties to denote that.
> 
> Fixes: fb026d3de33b ("ARM: BCM5301X: Add Broadcom's bus-axi to the DTS file")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/fixes, thanks!
--
Florian
