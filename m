Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF134513BB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 20:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242157AbhKOTz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 14:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239525AbhKOSBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 13:01:12 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6672CC061206;
        Mon, 15 Nov 2021 09:31:09 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u11so15093538plf.3;
        Mon, 15 Nov 2021 09:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vrhTyqgaGZ0E1GS68vf9tIHsXp0CcOc1e5OS9HG0PNQ=;
        b=NRKG7pOotopy79WtuFUCmU+PQSDk/OQJcbh4KYj8ERzqmUo4QNHj2j9O0lGpJW473g
         pnGhqi6DVlIlzugcdjbYjy1ScdNtD7Qpkyoh2Dnt6YHx+57tOhekDcQY2tc89Rw/rnAq
         BuYvwQtwVvkDajWxLLnML+yXMlBa/7jgdY0DzKdP9E4LsgJi/Fdhf1HZG+BJqKy9mv+z
         3rIJ+YIdhBOWzOgX64Rvl0X61J6GAIsNXFrV/MDsed4npeK/4wg8DaVfN3bHm2LZfkjb
         mIgjE5HFtImzFmaub1H33ys+Ge8sar7N81qOvFONFWvIMNFPE65Wb9ObCiOhrnkBMSGY
         H6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vrhTyqgaGZ0E1GS68vf9tIHsXp0CcOc1e5OS9HG0PNQ=;
        b=mQ58ViZZZTCNJ+1t3FA2PwQ2apMZghn0/setr6wMSPUqzionjCeluMxObxe/AHE3Aw
         tdNSpLWJV9a6Ch23WTfopo1eTCcpaJNxaAYLiu/A0PH3slT4k6HDFYECaU0ufBQ+vjTp
         ovjt1v6J9Y8q780mhBN2+UWqhWvWhLDieCpQQvT06k4n0D2VoDUf/WGXLhVU6VT1EBWx
         UmB6T3MS/IV7BFeBXnvroG1wQhfikx6wNQXoSuaqJH3sopZh5qWuDAmGVTNQeS+y+pZ7
         0ismvjTXM0aqRalT0PdwoczyvxUruOb90iUEJ8Jjzq5usWHcLdnGt76s4/q+nBtc5z84
         Kx2Q==
X-Gm-Message-State: AOAM532lrlZP1dOIvFvsWIMzlJc9Ndzr9b+cgpeXzA/zaSLDfj2Z2Qs0
        bZvY+N2P05+32UW9m7qacpGuOlQ5RKI=
X-Google-Smtp-Source: ABdhPJxLzi35zyHuiLGVNveHHMnmDyRR+cL+y3cwcOjiLaHi7UOmM/0+Tsn6EBz3mSy3lkdVIPMvIA==
X-Received: by 2002:a17:902:ecca:b0:141:e920:3b71 with SMTP id a10-20020a170902ecca00b00141e9203b71mr36935076plh.10.1636997468742;
        Mon, 15 Nov 2021 09:31:08 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id mp12sm18927424pjb.39.2021.11.15.09.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 09:31:08 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Cc:     chunkeey@gmail.com, mnhagan88@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jon Mason <jonmason@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: BCM5301X: Fix I2C controller interrupt
Date:   Mon, 15 Nov 2021 09:31:07 -0800
Message-Id: <20211115173107.488905-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211027193730.3941945-1-f.fainelli@gmail.com>
References: <20211027193730.3941945-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 12:37:29 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The I2C interrupt controller line is off by 32 because the datasheet
> describes interrupt inputs into the GIC which are for Shared Peripheral
> Interrupts and are starting at offset 32. The ARM GIC binding expects
> the SPI interrupts to be numbered from 0 relative to the SPI base.
> 
> Fixes: bb097e3e0045 ("ARM: dts: BCM5301X: Add I2C support to the DT")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/fixes, thanks!
--
Florian
