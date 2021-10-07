Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CB8425B11
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 20:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243782AbhJGSpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 14:45:20 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:52290
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243725AbhJGSpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:45:13 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 89F9E3FFEC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 18:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633632198;
        bh=ptxZJ8VNZrNpirAGT41r1c4NveVYb2EiW6bFIw3Tqoc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=CdV9d4Q0arxsKxI0b7VQQtCFjkYfa5UqiQ+t+vuWZQEyYQ99pSNv+MVXsrhnl7QQo
         lLvTtmBbLGLkLerOxVT3Axi5VPq57/nE2YtuVNIrxaZpurHR+RjE61jaWdfW7dl4Pa
         h9DHftAT/yKJBPQo3Ipfjjg3XUr4MK2QOpiAsXmdhPKPcwrtI82sNb+qsbnA/M/Fmi
         ayllTxfAYfEBFvUXh93eKUGhGC6/9WdCaIcVeyWUiq67tgia/9qZfwYct6ZKb06ZXF
         p/U+a9MxEmLIsQwkh6HXym1MZdxZvw0PPy85PIhWBIVUf4eEkeqz6T0iceRZDR7587
         AkXOUZ1oF0A+g==
Received: by mail-ed1-f69.google.com with SMTP id r11-20020aa7cfcb000000b003d4fbd652b9so4741177edy.14
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 11:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ptxZJ8VNZrNpirAGT41r1c4NveVYb2EiW6bFIw3Tqoc=;
        b=5BHACLTW1kYTnhZ2i4ht2bN4ZuwNwaOO1bbNk1XNz4PbBs6IHCO0xZHdWt2u2O4gxh
         WHKmgvLzcK3mCOPfh3IPzy1J7IvEk8ZqmUSZt2V7jxpTsJ/m0YK7FraSWAzCAsJcWKBV
         JLNCdQ0lAIXtMiuDE/fAIUYVujKXdS1/SdQ/Sb1h1TDTujfIA7mB38cyAlmDccQC3zN7
         whkeIVHxm2YMa01qx7R29l+792DZn2haS+QLuYBEDVaTc/vTEZ2JjUfT8PHpPRhsS5L9
         fn5x30Vhx+kDWbNMt656+9S3KongysLFuV7VS5IonEBKnuJEPKi/S7QRantgh0xjQs9l
         PGNQ==
X-Gm-Message-State: AOAM533I62FbPVMhKeahYSGshvy7mulhTYHIDlPqrRAE7qy0dADq47CL
        kCT8QideRMp28nVhA1B8JkY0KoZtKfhcNokypJoUEfB3xu5ULta5GaZASgcTwxiFsW1q05B4KMw
        MsjY7Sm+XuU7wW0oQtZ7Ba7D0NhrAUChtcvImeFcZQg==
X-Received: by 2002:a50:e08c:: with SMTP id f12mr8346828edl.178.1633632198329;
        Thu, 07 Oct 2021 11:43:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqBk+3H/3Ehaw/Ez5UgF30KaaOiCloLHyhpj2coChIm44e5d0hod35eSnVULWrl9lMHAxk0w==
X-Received: by 2002:a50:e08c:: with SMTP id f12mr8346818edl.178.1633632198222;
        Thu, 07 Oct 2021 11:43:18 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-186-13.adslplus.ch. [188.155.186.13])
        by smtp.gmail.com with ESMTPSA id t19sm70612ejb.115.2021.10.07.11.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 11:43:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        mperttunen@nvidia.com
Subject: Re: [PATCH -next v2] memory: tegra186-emc: Fix error return code in tegra186_emc_probe()
Date:   Thu,  7 Oct 2021 20:42:46 +0200
Message-Id: <163363216362.76978.14525648587170770072.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210928021545.3774677-1-yangyingliang@huawei.com>
References: <20210928021545.3774677-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2021 10:15:45 +0800, Yang Yingliang wrote:
> Return the error code when command fails.
> 
> 

Applied, thanks!

[1/1] memory: tegra186-emc: Fix error return code in tegra186_emc_probe()
      commit: 982ca19a09ac0365ad1409f919da43596d2a2276

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
