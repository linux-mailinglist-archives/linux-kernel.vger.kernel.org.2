Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D54B44729C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 12:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbhKGLCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 06:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbhKGLCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 06:02:40 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374D5C061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 02:59:58 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id r80so2201755pgr.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 02:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xmO6JGv32KvIT5oWuDTcUFHaPvWy5R9o0/z7qyegj4k=;
        b=cqiy6hTm44DObw30CSG85teBGXtw82SwNFPI6PEIQ7pkM16YywPH+5DtpS3abcpdHq
         rDaUJNEH7EHMaM4KWl3JUIcy5EJpc9W/S63t0z4uBJr17EuWZxs0rU5RfK+RBJrRCHXw
         rn9fWF+9K+V+bqD6nGKDKBfZ+XGj3If6quNR/sOnhdZlxjtS841Y8dK1I6GTYUe+pcMA
         7Qa2mogmcMNvVhcY9HMgKE+uRwq5M54Jxsz6B8F+ptoJKrRcvMTLKTymNfK2rO+lZVKa
         /AceaEOr1Maqw5KXlT18+yJnL5glZKIF1d1nIOnGSqzKqHiTkKaS9DjBkPHfMizvfqbX
         RbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xmO6JGv32KvIT5oWuDTcUFHaPvWy5R9o0/z7qyegj4k=;
        b=B/60qMYdKOfOICvfdOWbiyXCwVGlJXVWArmLfOhnUs8zeZcnFJ+pviRJ2GgOv0OmA8
         TbI/Ll4T9X0O22pYkcVyaOump1mRiougHalblRxm1QkHeM4lAcHNhthB89C5AE4NTtrw
         VazHCYoJzmirGn6BUBh8GrwXeAC8HIG9/WLfcI02oqDkxJz9La1mODGLBHN0I1qG8mMT
         c7mqiUVi8UXtUPKzjbL5KcwKEFLrs2OynPa2xyk+5E02kDgJ8Z2BEeiUBzxpaj2+4IF9
         mn1oLeiwEmr7BnkfS1lug/0YIEx2TvBKymtPY4EWpRrLOi6WLGMicaYqhJN7shz4KPVO
         vdUg==
X-Gm-Message-State: AOAM531t+o342/qijn5f1CUc4xw3iM6z/W/o+hbYuSamGal2oVJri6z1
        P6aGr6peQbQRcqlHnRNfW5UhG3ES6hPueQ==
X-Google-Smtp-Source: ABdhPJxvFnJCJx903LihBXnroEoCO8c75rdX19HfNTriwGMDbEpW6MzfaJq/BTjq7zu8xKECtGaW5g==
X-Received: by 2002:aa7:9597:0:b0:49f:b04e:e669 with SMTP id z23-20020aa79597000000b0049fb04ee669mr9067619pfj.62.1636282797644;
        Sun, 07 Nov 2021 02:59:57 -0800 (PST)
Received: from localhost.localdomain ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id t11sm9781838pgi.73.2021.11.07.02.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 02:59:57 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sidong Yang <realwakka@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: print rf69 debug message more detail
Date:   Sun,  7 Nov 2021 10:59:47 +0000
Message-Id: <20211107105947.21928-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pi433 failed for rf69 configuration, Debug message should help for
finding which value is incorrect. But it's hard to know because it just
prints "illegal value". This patch make print message more detail.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 drivers/staging/pi433/rf69.c | 38 ++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 7d86bb8be245..dc047bcdf44b 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -113,7 +113,7 @@ int rf69_set_mode(struct spi_device *spi, enum mode mode)
 	};
 
 	if (unlikely(mode >= ARRAY_SIZE(mode_map))) {
-		dev_dbg(&spi->dev, "set: illegal input param");
+		dev_dbg(&spi->dev, "set: illegal mode %u", mode);
 		return -EINVAL;
 	}
 
@@ -143,7 +143,7 @@ int rf69_set_modulation(struct spi_device *spi, enum modulation modulation)
 	};
 
 	if (unlikely(modulation >= ARRAY_SIZE(modulation_map))) {
-		dev_dbg(&spi->dev, "set: illegal input param");
+		dev_dbg(&spi->dev, "set: illegal modulation %u", modulation);
 		return -EINVAL;
 	}
 
@@ -191,7 +191,7 @@ int rf69_set_modulation_shaping(struct spi_device *spi,
 						   MASK_DATAMODUL_MODULATION_SHAPE,
 						   DATAMODUL_MODULATION_SHAPE_0_3);
 		default:
-			dev_dbg(&spi->dev, "set: illegal input param");
+			dev_dbg(&spi->dev, "set: illegal mod shaping for FSK %u", mod_shaping);
 			return -EINVAL;
 		}
 	case OOK:
@@ -209,7 +209,7 @@ int rf69_set_modulation_shaping(struct spi_device *spi,
 						   MASK_DATAMODUL_MODULATION_SHAPE,
 						   DATAMODUL_MODULATION_SHAPE_2BR);
 		default:
-			dev_dbg(&spi->dev, "set: illegal input param");
+			dev_dbg(&spi->dev, "set: illegal mod shaping for OOK %u", mod_shaping);
 			return -EINVAL;
 		}
 	default:
@@ -392,7 +392,7 @@ int rf69_set_output_power_level(struct spi_device *spi, u8 power_level)
 	return rf69_read_mod_write(spi, REG_PALEVEL, MASK_PALEVEL_OUTPUT_POWER,
 				   power_level);
 failed:
-	dev_dbg(&spi->dev, "set: illegal input param");
+	dev_dbg(&spi->dev, "set: illegal power level %u", power_level);
 	return -EINVAL;
 }
 
@@ -417,7 +417,7 @@ int rf69_set_pa_ramp(struct spi_device *spi, enum pa_ramp pa_ramp)
 	};
 
 	if (unlikely(pa_ramp >= ARRAY_SIZE(pa_ramp_map))) {
-		dev_dbg(&spi->dev, "set: illegal input param");
+		dev_dbg(&spi->dev, "set: illegal pa_ramp %u", pa_ramp);
 		return -EINVAL;
 	}
 
@@ -433,7 +433,7 @@ int rf69_set_antenna_impedance(struct spi_device *spi,
 	case two_hundred_ohm:
 		return rf69_set_bit(spi, REG_LNA, MASK_LNA_ZIN);
 	default:
-		dev_dbg(&spi->dev, "set: illegal input param");
+		dev_dbg(&spi->dev, "set: illegal antenna impedance %u", antenna_impedance);
 		return -EINVAL;
 	}
 }
@@ -451,7 +451,7 @@ int rf69_set_lna_gain(struct spi_device *spi, enum lna_gain lna_gain)
 	};
 
 	if (unlikely(lna_gain >= ARRAY_SIZE(lna_gain_map))) {
-		dev_dbg(&spi->dev, "set: illegal input param");
+		dev_dbg(&spi->dev, "set: illegal lna gain %u", lna_gain);
 		return -EINVAL;
 	}
 
@@ -466,14 +466,14 @@ static int rf69_set_bandwidth_intern(struct spi_device *spi, u8 reg,
 
 	// check value for mantisse and exponent
 	if (exponent > 7) {
-		dev_dbg(&spi->dev, "set: illegal input param");
+		dev_dbg(&spi->dev, "set: illegal bandwidth exponent %u", exponent);
 		return -EINVAL;
 	}
 
 	if ((mantisse != mantisse16) &&
 	    (mantisse != mantisse20) &&
 	    (mantisse != mantisse24)) {
-		dev_dbg(&spi->dev, "set: illegal input param");
+		dev_dbg(&spi->dev, "set: illegal bandwidth mantisse %u", mantisse);
 		return -EINVAL;
 	}
 
@@ -531,7 +531,7 @@ int rf69_set_ook_threshold_dec(struct spi_device *spi,
 	};
 
 	if (unlikely(threshold_decrement >= ARRAY_SIZE(td_map))) {
-		dev_dbg(&spi->dev, "set: illegal input param");
+		dev_dbg(&spi->dev, "set: illegal OOK threshold decrement %u", threshold_decrement);
 		return -EINVAL;
 	}
 
@@ -578,7 +578,7 @@ int rf69_set_dio_mapping(struct spi_device *spi, u8 dio_number, u8 value)
 		dio_addr = REG_DIOMAPPING2;
 		break;
 	default:
-	dev_dbg(&spi->dev, "set: illegal input param");
+		dev_dbg(&spi->dev, "set: illegal dio number %u", dio_number);
 		return -EINVAL;
 	}
 
@@ -681,7 +681,7 @@ int rf69_set_fifo_fill_condition(struct spi_device *spi,
 		return rf69_clear_bit(spi, REG_SYNC_CONFIG,
 				      MASK_SYNC_CONFIG_FIFO_FILL_CONDITION);
 	default:
-		dev_dbg(&spi->dev, "set: illegal input param");
+		dev_dbg(&spi->dev, "set: illegal fifo fill condition %u", fifo_fill_condition);
 		return -EINVAL;
 	}
 }
@@ -690,7 +690,7 @@ int rf69_set_sync_size(struct spi_device *spi, u8 sync_size)
 {
 	// check input value
 	if (sync_size > 0x07) {
-		dev_dbg(&spi->dev, "set: illegal input param");
+		dev_dbg(&spi->dev, "set: illegal sync size %u", sync_size);
 		return -EINVAL;
 	}
 
@@ -727,7 +727,7 @@ int rf69_set_packet_format(struct spi_device *spi,
 		return rf69_clear_bit(spi, REG_PACKETCONFIG1,
 				      MASK_PACKETCONFIG1_PACKET_FORMAT_VARIABLE);
 	default:
-		dev_dbg(&spi->dev, "set: illegal input param");
+		dev_dbg(&spi->dev, "set: illegal packet format %u", packet_format);
 		return -EINVAL;
 	}
 }
@@ -753,7 +753,7 @@ int rf69_set_address_filtering(struct spi_device *spi,
 	};
 
 	if (unlikely(address_filtering >= ARRAY_SIZE(af_map))) {
-		dev_dbg(&spi->dev, "set: illegal input param");
+		dev_dbg(&spi->dev, "set: illegal address filtering %u", address_filtering);
 		return -EINVAL;
 	}
 
@@ -788,7 +788,7 @@ int rf69_set_tx_start_condition(struct spi_device *spi,
 		return rf69_set_bit(spi, REG_FIFO_THRESH,
 				    MASK_FIFO_THRESH_TXSTART);
 	default:
-		dev_dbg(&spi->dev, "set: illegal input param");
+		dev_dbg(&spi->dev, "set: illegal tx start condition %u", tx_start_condition);
 		return -EINVAL;
 	}
 }
@@ -799,7 +799,7 @@ int rf69_set_fifo_threshold(struct spi_device *spi, u8 threshold)
 
 	/* check input value */
 	if (threshold & 0x80) {
-		dev_dbg(&spi->dev, "set: illegal input param");
+		dev_dbg(&spi->dev, "set: illegal fifo threshold %u", threshold);
 		return -EINVAL;
 	}
 
@@ -826,7 +826,7 @@ int rf69_set_dagc(struct spi_device *spi, enum dagc dagc)
 	};
 
 	if (unlikely(dagc >= ARRAY_SIZE(dagc_map))) {
-		dev_dbg(&spi->dev, "set: illegal input param");
+		dev_dbg(&spi->dev, "set: illegal dagc %u", dagc);
 		return -EINVAL;
 	}
 
-- 
2.20.1

