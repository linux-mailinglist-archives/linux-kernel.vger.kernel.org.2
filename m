Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4555139C63C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 08:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhFEG0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 02:26:55 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:45594 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhFEG0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 02:26:53 -0400
Received: by mail-pf1-f178.google.com with SMTP id d16so8990295pfn.12;
        Fri, 04 Jun 2021 23:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1f90Mva9ReuDNqMb7g12jTb4T/8wcPfWg+nhhZqJDgk=;
        b=UH2iDKtFrxKudw2KauZVehAyPEQhI8UT78skAhfpIen5K+PIgy1HAj557zAFkuqYfD
         4zhcLZK7PMHgc8VCCRNgiIdxpiLujqjBvX9uUHSmLLtimdZmh+Ik7ooqUXSmgKbdPr0e
         ChK3iwtHyoVjgqVdEFVqthnNOCHl4ClWtDy2ZN+Z8J78CJ25ZitVn/aG2/rZODRp9oc3
         f/wHBASftFLPm18DB0R2NpvkiqStjG5aG8UnPpLkU//g/5n/Afk+20HjYWCpFi2v4QY8
         NPosp2GHASBBlPglxidVN2xdvfY4qPC/rY5U4cfLhVoSoco+FGi1SyvvOx05uPYSqCYN
         +8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1f90Mva9ReuDNqMb7g12jTb4T/8wcPfWg+nhhZqJDgk=;
        b=bpvaF5B+IbsXNjAQhzGEwXohrskF7BIQlT4NsrD54mFWjzdcp9mke3rjnegj3xbOuB
         E1P58Cc/9ZH+aHIuEvZurInYbS7v1z+uMDASSKhq6tPr+TEAtflVwqHdZ8/CjrVQ5Meo
         Lq4cle92wvurHbqFEyJVbKW//esjGFYOHHG/FlwEvrjmY1+teG89PaRBvUb0tywtH9Ed
         zmzEjVJm54Y20G1XRt8LHbbOXx9z6sd9K72n20U4N1Sa18GjxHsv6fv45XZkGM9J5xrr
         zuf+jxyNTt6Qe1BT5M4HQB9VCOqNpEtSSyDuHSW+dUrGiqkaqNpVwqeEHOC/c2BFU/Kx
         dm7A==
X-Gm-Message-State: AOAM533buAIawhgWkAaCgbzQCPVn4HPRv5AxYnOYF5P1AFC0Uci/9bNc
        ALKqFdDs6yBAx7qXXrpBZM4=
X-Google-Smtp-Source: ABdhPJy3+ehugYWHZX8thcdb3tHhsPT7Hx7G9ltjWt/CtRZhbgPUCCSZZMKjVMQBMxkMZGx2OPsNoA==
X-Received: by 2002:a65:4985:: with SMTP id r5mr1479067pgs.122.1622874232165;
        Fri, 04 Jun 2021 23:23:52 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id v14sm2800870pgo.89.2021.06.04.23.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 23:23:51 -0700 (PDT)
From:   xieqinick@gmail.com
To:     robh+dt@kernel.org, narmstrong@baylibre.com, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nick@khadas.com, artem@khadas.com
Subject: [PATCH 1/6] arm64: dts: meson: vim3: add serial aliases
Date:   Sat,  5 Jun 2021 14:23:08 +0800
Message-Id: <20210605062313.418343-2-xieqinick@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210605062313.418343-1-xieqinick@gmail.com>
References: <20210605062313.418343-1-xieqinick@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Xie <nick@khadas.com>

Add serial aliases for Khadas VIM3/3L.

Signed-off-by: Nick Xie <nick@khadas.com>
---
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 66d67524b031..4686ea7abe0b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -13,6 +13,10 @@
 / {
 	aliases {
 		serial0 = &uart_AO;
+		serial1 = &uart_A;
+		serial2 = &uart_B;
+		serial3 = &uart_C;
+		serial4 = &uart_AO_B;
 		ethernet0 = &ethmac;
 		rtc0 = &rtc;
 		rtc1 = &vrtc;
-- 
2.25.1

