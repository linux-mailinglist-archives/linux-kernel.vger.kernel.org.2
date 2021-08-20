Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B153F24F6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 04:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbhHTCt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 22:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237636AbhHTCt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 22:49:58 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF55C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 19:49:21 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d5so6390428qtd.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 19:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LavvvFG+/VWmsfKchesDD9nAqBZFVJWxsg7nQ7rHqRM=;
        b=ZyOVOXddVzS20gMkSzEofQ+rakCMaCmpjv3y1E2c/rjfVyBBDfLFFvvhNAUx6clEh2
         8eUvn3CpIgc5de/kt5srn5ndVr+21VoMGhl2KLnV2uGyFTPICxWbL01yjJ4n5Azyol9j
         uSAvYaEZv0aK+w0VTIavWPlImW11ivpcI/A65/aamjudKnp3FJavC6VPMNv8BD2XHfsS
         w5rBsdOC8ziKyzTtr3Mik8f7W5GFmbAH6sPNoQob/flpc8+azELGygdPM7gt9PcA6+HL
         +r+7rk4fo6ghtbe0js/f4ZbgUizWTCckaIQivLJfmENei94/mN0ZHXtwouXYdk4hG2Ss
         7E4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LavvvFG+/VWmsfKchesDD9nAqBZFVJWxsg7nQ7rHqRM=;
        b=UExlZtv2eU49dT32TSaQr3ONHUO98vAS7dvYCLipO2KWSbeH60eKAMN0liYygvuLkH
         9oTwG0eeaDZJTqU+7tzoJzbFroyp+RsC9D8HIM765Kt3e3IaXImGFJC5tLD/QfhtcmWY
         MCwCHYRPLb/bvtg3R54mcccWWPiwNWw9t5tXVnW6vBw1sUNVGeSYVaOXZM4jFVAg6LWc
         OK6BFDE8UTrhcHjI0dl7FEi1ufrtPOhSn4GMKMIloFoXyDN6D/VD5k8Et3FkmsjgU5oP
         xfhOemQ8k7f01CQ3Dd502QCqoNeE5fWVUuJselfi5PhwJSVlpgXGFesndm0iMUNghDAq
         nftQ==
X-Gm-Message-State: AOAM5333mOwPTvK3qUmPvTnVAabrLB6xrBnNBBHr/Ng8e1j5dJYCkbuH
        W1RVK0O3RhoBD0j217y5s5V/7Y0rmbE=
X-Google-Smtp-Source: ABdhPJzzzprAAUL+AN13Sa5wgzLdwdedt+qOOHoPCRfYFoAiJJJ0SfKXNdDpTO9EG+HI2HuAefm2/A==
X-Received: by 2002:ac8:53d6:: with SMTP id c22mr8870860qtq.38.1629427760206;
        Thu, 19 Aug 2021 19:49:20 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 75sm2505262qko.100.2021.08.19.19.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 19:49:19 -0700 (PDT)
From:   jing yangyang <cgel.zte@gmail.com>
X-Google-Original-From: jing yangyang <jing.yangyang@zte.com.cn>
To:     Geoff Levand <geoff@infradead.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ps3: remove unneeded semicolon
Date:   Thu, 19 Aug 2021 19:49:01 -0700
Message-Id: <01647102607ce9640c9f27786d976109a3c4ea7e.1629197153.git.jing.yangyang@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:

./arch/powerpc/platforms/ps3/system-bus.c:606:2-3: Unneeded semicolon
./arch/powerpc/platforms/ps3/system-bus.c:765:2-3: Unneeded semicolon

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
---
 arch/powerpc/platforms/ps3/system-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index c8b50fe..b637bf2 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -603,7 +603,7 @@ static dma_addr_t ps3_ioc0_map_page(struct device *_dev, struct page *page,
 	default:
 		/* not happned */
 		BUG();
-	};
+	}
 	result = ps3_dma_map(dev->d_region, (unsigned long)ptr, size,
 			     &bus_addr, iopte_flag);
 
@@ -762,7 +762,7 @@ int ps3_system_bus_device_register(struct ps3_system_bus_device *dev)
 		break;
 	default:
 		BUG();
-	};
+	}
 
 	dev->core.of_node = NULL;
 	set_dev_node(&dev->core, 0);
-- 
1.8.3.1


