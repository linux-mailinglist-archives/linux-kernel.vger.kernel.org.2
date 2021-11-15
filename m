Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF0A452649
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 03:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343785AbhKPCEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 21:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239921AbhKOSFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 13:05:03 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB47DC110F0B;
        Mon, 15 Nov 2021 09:32:36 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id b11so14995384pld.12;
        Mon, 15 Nov 2021 09:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qbERs27MjXejNyi1gRtSSGpv4Ff7qN0thceJ4/krT68=;
        b=HzjkGKqpWug7RhxGAjY65fYLKyGMH+SOCgW0SV4Slie0FzBmvGRKHlbHnsG/CSyRJy
         6Ojk/Um61OhVxcsy0v3eSilWmkz8ynbArpaHS+bMqhrD7JwgKR7UmE9f98zYv2Fw4ame
         HSKiyY3ZoSFZsL8eMfc0AeJkK8DM1I7DLNf57OhuE5GltAeEJQWsNe0AqslipfW4mzFC
         RKYaIQ96OhuYdfV5ba+jdPIpBovFMQWN16uMyyvbjIH0OSdC/WTe8nUzg2UmDlUq8wt4
         jza1UawelPwCXlHtE0bhMx706j2zRo8PoyKT16dyrPCJEd+WDZ7LCl+TNm3i31Oj//zH
         fZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qbERs27MjXejNyi1gRtSSGpv4Ff7qN0thceJ4/krT68=;
        b=wf8stzISMqHCesaCLfEttZq9Z5ulI3WtnrFU2gE6HXmBzwL0aObDhxUK4KBQmjwmvA
         ocGNPs9YF8ZcSUEO/YvA4TrY98/2WBeaVSYdWjoYzHCh9lI6cmFWhLYNyx254su6ERHH
         n4M0TOfNOYSgaiGkO5uIUt0rHqWhddxLNmYFwOc8CTX3hWUPOMeUJPqrovdnhnEQgr7q
         YvUIBnQIIekM8YfXh4AzPVrCR6Zaxp63cvp0qe0W5/HjJkYHQiLxrX75tVqVXXCDEnQw
         ysCM+RQBBNCUyiqTbwbG8iupH9NXTuY+2hrr8KI4gaWIzGrJpDlZsz4wYPeEJOMHSY7x
         hLDw==
X-Gm-Message-State: AOAM533tWZiEh6FaK/cx9wWl6uxXZT/QwARxVQRC00tnVXShY+LNUjze
        jPd8ILJhdidVkbbWLMpn8pzSRFGKZDU=
X-Google-Smtp-Source: ABdhPJy7BQqw41VHuwGWDJOHuitIP4kayqgb/jRtEWU19j6LALQSNeJaDVavh22AT+JBZ+qEtNwNvw==
X-Received: by 2002:a17:902:d2c1:b0:141:f710:922 with SMTP id n1-20020a170902d2c100b00141f7100922mr1080860plc.7.1636997556268;
        Mon, 15 Nov 2021 09:32:36 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s2sm21064524pjs.56.2021.11.15.09.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 09:32:35 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: bcm2711: Fix PCIe interrupts
Date:   Mon, 15 Nov 2021 09:32:34 -0800
Message-Id: <20211115173234.489160-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211029210927.36800-1-f.fainelli@gmail.com>
References: <20211029210927.36800-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2021 14:09:26 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The PCIe host bridge has two interrupt lines, one that goes towards it
> PCIE_INTR2 second level interrupt controller and one for its MSI second
> level interrupt controller. The first interrupt line is not currently
> managed by the driver, which is why it was not a functional problem.
> 
> The interrupt-map property was also only listing the PCI_INTA interrupts
> when there are also the INTB, C and D.
> 
> Reported-by: Jim Quinlan <jim2101024@gmail.com>
> Fixes: d5c8dc0d4c88 ("ARM: dts: bcm2711: Enable PCIe controller")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/fixes, thanks!
--
Florian
