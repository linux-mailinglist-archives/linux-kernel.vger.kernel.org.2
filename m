Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B253339FAE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 18:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbhCMR54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 12:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbhCMR5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 12:57:21 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973C0C061574;
        Sat, 13 Mar 2021 09:57:21 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id v14so10994675pgq.2;
        Sat, 13 Mar 2021 09:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tNrwUPATbnpYxTOxZCSdNs9TAkFF9tgeDMtlCQ/obR4=;
        b=lIuCUO3FIxDWRD9+W8WM7bGEDs0eW2GNXFm0lCMHrIhYn/opegmgsrpBd+JW793kGM
         4sGz1A0S/VsuMhOz1bwjVrTBaRIQ216gOwikkAN7cQxDN7hB0Cl+wbIwURan2lviuKQ0
         XAGrll7qzOMOTPZSrBJJvcvObFASi/vXcVxlqDs9gYeTrVhrgyJgLa5EGEBEdmTms6F3
         x0blS9Sy8VasvAWBDi5L3RnqRvQvRM9k5eEY7sYtvJxRW2KouxP2Bbi051a9hRhdBGUF
         rW9OjhV0QnzZziSqWMWf6P6GUoCJOPwDiGXZs81F3TYKqlbqot0JTeoGbIF4O4Wqcjir
         RT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tNrwUPATbnpYxTOxZCSdNs9TAkFF9tgeDMtlCQ/obR4=;
        b=t3Vff/aNBWhTc8gwk8tcWttoM82iCgDOsPy+AAICrS+gGKyqvmTdkM5/d6Q/9yDyhC
         2trHSsPqZFeCbQdeMZy51UnMgWaFqH+Q+T0lQmvPRTB2OfT/QvL91R4zmroWPTWoaq/a
         QYtw2hfwNaXzMaNMqtxKP4ao0nJrbb6xdDIWPRvhRWCuyq5PJKdiaXsuaPG5ZvyHsZ3l
         DROM4o9ta7EduUv3O7JP/8w+wN7atd73F0eouelUkqov1T38chPECfss8M8mHFUzOj0O
         3UpdhcAM+ZXpNdJVDt2RwIir0iTqyQmuciMWhFayJ+VB9/EgKaVNWzAZnsU3pzSKq6m5
         Ddrg==
X-Gm-Message-State: AOAM532QvVvm5Il8rtg36W/JBGLKRZnZU1MKifnLb5GAqwfLrn9oYGET
        ZuA9npAC8T6MMiMzxabWXljq/rJYE4M=
X-Google-Smtp-Source: ABdhPJzLCMNnG0i92dYm9VECUG64xzc6lZUdOTNdlNZcsqmWdvV8BitUZPQisuAfPM0uyNc8lzQPqg==
X-Received: by 2002:aa7:8e43:0:b029:1ed:447c:f1d4 with SMTP id d3-20020aa78e430000b02901ed447cf1d4mr3586563pfr.16.1615658241201;
        Sat, 13 Mar 2021 09:57:21 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z2sm9323786pfq.198.2021.03.13.09.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 09:57:20 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>
Subject: Re: [PATCH Broadcom/stblinux 1/2] dt-bindings: power: bcm-pmb: add BCM63138 binding
Date:   Sat, 13 Mar 2021 09:57:19 -0800
Message-Id: <20210313175719.3844276-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210114175339.19920-1-zajec5@gmail.com>
References: <20210114175339.19920-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 18:53:38 +0100, Rafał Miłecki <zajec5@gmail.com> wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> PMB can be also found on bcm63xx chipsets. It uses difference device
> addresses so a new binding is required.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---

Applied to drivers/next, thanks!
--
Florian
