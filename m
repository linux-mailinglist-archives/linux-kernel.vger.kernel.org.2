Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F6B3F4111
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 21:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhHVTI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 15:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhHVTIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 15:08:52 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD9CC061575;
        Sun, 22 Aug 2021 12:08:11 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id qe12-20020a17090b4f8c00b00179321cbae7so10667741pjb.2;
        Sun, 22 Aug 2021 12:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OLJNoKkWV+HRX+RHUKmR2ouc9DN10iA4tGdE8s1TbQ0=;
        b=EI4o8aTNO2xT7FKtU/faGMG6cljPKBROny0nDZpSWMmEEreCQLecRxjENOZscY+TwW
         LKsi8sO3D2UcLCZnJOc8LYzMzcpnDr561RAiADig8CqGBdmYDTNXb3dSyo5ovn3dt+aQ
         kIF1Q0NISks/sCl+gxHXUcIEm9660L5iyAWsIyT++Uo5wquVh7nwoa45+n/FTmC9Pdb2
         RTMaAEtAc5jH3joPaINfaRXiPqWB2/3sB8IeUMLX3r/WmHDsNisuhewg6TPNFaP+vjsf
         ozSLxKmKOn2bwvVJ/RDvdViadT1P60xnsYG0X/q3cZnKkla+lsVproJ7195tZgaYzj3y
         mULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OLJNoKkWV+HRX+RHUKmR2ouc9DN10iA4tGdE8s1TbQ0=;
        b=Ebg3vNkJhgeZKLJ6XdKRGC9ahFmc5vV/F6d9tF5nRwJeN3L+8V8A5xRpxQ59tN+a9X
         ajoMBqMXa/uuprprMvbv2l6NEpE7sWJkfWHiv75YTJi36+Bn27DMrll/UEA1WD+MYL7i
         V4IPJE7H7cC0z2lWHpJA4gGwV+IoCbmsdmE7cmi8j21oVmTXKp9RbiroQx1d/af/17AV
         BpeSps/rkAcONJ0XWqcNscelofom8P04clEM0LDEb2YWB091vCxFLFhjGSGnPMylIoqM
         iDTqlTbmDGcb5dfzMUFtFDbbEYXoP1o8AJbsxhBCwaOfHV7KBcC/JavKPKRjUUs3KOz7
         CHfw==
X-Gm-Message-State: AOAM531fKfb/x0w/yWoDlq42mYFovOu8YNY0dIVRwBIFFDzi8sGwAkqM
        EgeqV9TGJt9U3nkQES3pmf4=
X-Google-Smtp-Source: ABdhPJz2ly/E/3S88Cibhj563lMhxvOm+rm5n7I5tasXODSTriKwd0INM95F99cABI1N8qaKK3ip4g==
X-Received: by 2002:a17:902:aa43:b029:12d:242f:32eb with SMTP id c3-20020a170902aa43b029012d242f32ebmr25403566plr.66.1629659290606;
        Sun, 22 Aug 2021 12:08:10 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s1sm11700030pjz.36.2021.08.22.12.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 12:08:10 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Matthew Hagan <mnhagan88@gmail.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sam Ravnborg <sam@ravnborg.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 4/5] ARM: dts: NSP: Add DT files for Meraki MX65 series
Date:   Sun, 22 Aug 2021 12:08:00 -0700
Message-Id: <20210822190800.3714263-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806204446.2981299-5-mnhagan88@gmail.com>
References: <20210806204446.2981299-1-mnhagan88@gmail.com> <20210806204446.2981299-5-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Aug 2021 21:44:35 +0100, Matthew Hagan <mnhagan88@gmail.com> wrote:
> MX65 & MX65W Hardware info:
>   - CPU: Broadcom BCM58625 Cortex A9 @ 1200Mhz
>   - RAM: 2 GB (4 x 4Gb SK Hynix H5TC4G83CFR)
>   - Storage: 1 GB (Micron MT29F8G08ABACA)
>   - Networking: BCM58625 switch (2x 1GbE ports)
>     2x Qualcomm QCA8337 switches (10x 1GbE ports total)
>   - PSE: Broadcom BCM59111KMLG connected to LAN ports 11 & 12
>   - USB: 1x USB2.0
>   - Serial: Internal header
>   - WLAN(MX65W Only): 2x Broadcom BCM43520KMLG on the PCI bus.
> 
> Note that a driver and firmware image for the BCM59111 PSE has been
> released under GPL, but this is not present in the kernel.
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/master, thanks!
--
Florian
