Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48F740E526
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 19:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345036AbhIPRIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:08:25 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:58930
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348302AbhIPRC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:02:26 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2B02240268
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 17:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631811665;
        bh=lLXS8SFA70byjSU3I64mTO8msYqwn7AgM4mAM+qQNUI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=EiMANJGyqPqOICENXpfb8BGcJBgTi/NtaTQuguWhBiYwdhEr2aOMQHiA64vc6mHAE
         Ztdp6nBAo4pkjAOn51dKmur4WFYTFvElcVeTMI91gBImmJEq5dVUH+PVvdgyWzYiWu
         Mo8oKHT0nKx46XoiQoDQboqBbfRS0rXYFW1x/7czyk6H70mZ4R396His+OMSI4uCqZ
         pV+Y0Yi7EiZvuA4JNGLKi9fG39Woh+eXAW4wFMBX9R0FSQfA2Yj2DB6SivLTBAKNr8
         knx1sY6g7IHrNiGG+IoY5laC0tjoy6olayFlDIKVclp6UnbJYl3eLcBL6wgGDtKDrY
         o05R0OZwSxY5Q==
Received: by mail-wr1-f70.google.com with SMTP id r15-20020adfce8f000000b0015df1098ccbso2688429wrn.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 10:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lLXS8SFA70byjSU3I64mTO8msYqwn7AgM4mAM+qQNUI=;
        b=nf4DMWHHmC5XMgRxCDstbyE7PdSbJvb9k1HvKFZNkVdW08oTTM8OUtx5kI6R6SEN75
         7TTTWc1o4j3H5AfX8AAhwyJiykHpvowEpBxGNQOLlGpj4s628smxMlyzjzRm3TrhELU+
         mslwhz5s9DBN6av12rClHZNwZrHb3Ch+YHvi4CflLpcnjhR8V0xvdahN47xNINzquV1C
         TqUaDbSqWSPMRg2vImu7GwmyReCYXXl2ifOUh10rUdANM55h5u2W7pz6OyzFKRxnYicV
         FhVfTzkFa8wtPxLcfbMX+h6KsJk3qVUNpsfNIn4lHiuHE2cZUwtHkBRARj5HjlrfDIuQ
         ZtBg==
X-Gm-Message-State: AOAM533g+Thl5D3mslz2oIVfHLYPq8PS3rXO1MMbQxri6aTy1dsTZ7xL
        ilMAbRA4+0vAOLeoIYf5ysL5blvpUd0QyJyA4EGt1b8GfTok352yC/f9948WgRERcOPmCVc7D63
        7XeAnv8Tut//vpHKUY6aJl+/r+x4d9/3gF/K4MS5orA==
X-Received: by 2002:a7b:cb45:: with SMTP id v5mr10586905wmj.184.1631811664918;
        Thu, 16 Sep 2021 10:01:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzt5lXb+YNan5B6bORK/XGxU+ZwX6sYN8W5zZeYQ3pwinhzCdxezQJk1xFkFHMOVrBMZRQ8NQ==
X-Received: by 2002:a7b:cb45:: with SMTP id v5mr10586873wmj.184.1631811664581;
        Thu, 16 Sep 2021 10:01:04 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id q7sm4062646wrr.10.2021.09.16.10.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 10:01:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Matan Ziv-Av <matan@svgalib.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 2/2] acpi: pnp: remove duplicated BRI0A49 and BDP3336 entries
Date:   Thu, 16 Sep 2021 19:00:54 +0200
Message-Id: <20210916170054.136790-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916170054.136790-1-krzysztof.kozlowski@canonical.com>
References: <20210916170054.136790-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BRI0A49 and BDP3336 are already on the list.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/acpi/acpi_pnp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
index 8f2dc176bb41..ffdcfcd4a10d 100644
--- a/drivers/acpi/acpi_pnp.c
+++ b/drivers/acpi/acpi_pnp.c
@@ -156,8 +156,6 @@ static const struct acpi_device_id acpi_pnp_device_ids[] = {
 	{"BRI0A49"},		/* Boca Complete Ofc Communicator 14.4 Data-FAX */
 	{"BRI1400"},		/* Boca Research 33,600 ACF Modem */
 	{"BRI3400"},		/* Boca 33.6 Kbps Internal FD34FSVD */
-	{"BRI0A49"},		/* Boca 33.6 Kbps Internal FD34FSVD */
-	{"BDP3336"},		/* Best Data Products Inc. Smart One 336F PnP Modem */
 	{"CPI4050"},		/* Computer Peripherals Inc. EuroViVa CommCenter-33.6 SP PnP */
 	{"CTL3001"},		/* Creative Labs Phone Blaster 28.8 DSVD PnP Voice */
 	{"CTL3011"},		/* Creative Labs Modem Blaster 28.8 DSVD PnP Voice */
-- 
2.30.2

