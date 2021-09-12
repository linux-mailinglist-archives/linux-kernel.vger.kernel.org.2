Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3D2407CFA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 13:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbhILLHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 07:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhILLH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 07:07:29 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F61C061574;
        Sun, 12 Sep 2021 04:06:15 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ho42so14239337ejc.9;
        Sun, 12 Sep 2021 04:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+UfvEOtjioQWVktblVI2sPPJ7S0UBV4zPEFt3Z3OQXY=;
        b=frhV4LAWf9blX1seYqBEofLsAVHvcOQT7iErgMHfbETtDR/T/N39c/zbTpTtURygmU
         AgTqoCbuwc8ISTOxYYWeXDmyalW3ncRI+dk5WfOo3xh4pfGKccDlzTQTnxbu1q68KoiR
         7qwQqvuG3y9+2HlCGmnVdIOpnusV6193+gLJqJqRls7bndQPOngKgJqjoi2NYkCA/q6f
         ucFllwf4HKSz8PyZ5Lg4lGrP80a3cRRq5VYMW4YrcZ1csgxfKXqCJ/b6KB1a/ky3W1Nl
         /ZOrC8Us94IBXRJtgN784uU0XSJUzzpaYbsdvUQXnEBR/qxeWyLUGZ4/O5NGHyS8fqXt
         i2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+UfvEOtjioQWVktblVI2sPPJ7S0UBV4zPEFt3Z3OQXY=;
        b=moKE/P6B6PfLBYiR45oQGqpLqCAXgBnlVn6bDwKctop2hqwjDKMa6CXtF9d0ApgjaR
         QuV4cwelNa3cu3/WnAwr4mJVnOordeX97o+nZL+RDjxF/6CnKnjYVKumaBdA/+Hk+bMv
         I1V5xPScCnAUgCliS+vuWkoeH4+YQ8pazNb0i1RuCdAhNNwez3OJvcPL3Xq6/uXxw5EF
         57Sb2qewxWLVDUjwHabCV/6Qegw14xDy1hEGKxvJ3E/cIlnT0J7BPBAhBqcUpy8vMV4i
         nnPU8ChcJPkz/pcJQfZkZIIhi+kjq7mq3Dh0QdXjo1h70Qf7rCKP3WjgAawk7WStvay6
         4oXQ==
X-Gm-Message-State: AOAM530WcNjRPOS642ND8W/+wkvnAqcsrApFf8Hmj0sNHxmht/pKO4Lm
        XK7Ze26Jqhf5Nydt9Mg1EOY=
X-Google-Smtp-Source: ABdhPJwA70G4zPgJLn91RREzrTaIS11B6bqrc+7+AsrjTWlGVR/0BbmUEtQq/6WGwdtzr/4Wuv6VNA==
X-Received: by 2002:a17:907:7f29:: with SMTP id qf41mr7208272ejc.211.1631444773806;
        Sun, 12 Sep 2021 04:06:13 -0700 (PDT)
Received: from localhost.localdomain (151-22-179-94.pool.ukrtel.net. [94.179.22.151])
        by smtp.gmail.com with ESMTPSA id qx18sm1896216ejb.75.2021.09.12.04.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 04:06:13 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     pauk.denis@gmail.com, Bernhard Seibold <mail@bernhard-seibold.de>,
        =?UTF-8?q?P=C3=A4r=20Ekholm?= <pehlm@pekholm.org>,
        to.eivind@gmail.com, "Artem S . Tashkinov" <aros@gmx.com>,
        Vittorio Roberto Alfieri <me@rebtoor.com>,
        Sahan Fernando <sahan.h.fernando@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] hwmon: (nct6775) Support access via Asus WMI
Date:   Sun, 12 Sep 2021 14:05:55 +0300
Message-Id: <20210912110557.41346-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support accessing the NCT677x via Asus WMI functions.

On mainboards that support this way of accessing the chip,
the driver will usually not work without this option since
in these mainboards, ACPI will mark the I/O port as used.

@Andy Shevchenko, I have left type of sioreg, in other places
sioreg has same integer type, should I change all occurrences
of usage?
@Guenter Roeck, I have left nct6775_*_set_back() call without
changes as its always called from platform specific callbacks.

Could you please review?

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Co-developed-by: Bernhard Seibold <mail@bernhard-seibold.de>
Signed-off-by: Bernhard Seibold <mail@bernhard-seibold.de>
Tested-by: Pär Ekholm <pehlm@pekholm.org>
Tested-by: <to.eivind@gmail.com>
Tested-by: Artem S. Tashkinov <aros@gmx.com>
Tested-by: Vittorio Roberto Alfieri <me@rebtoor.com>
Tested-by: Sahan Fernando <sahan.h.fernando@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>

---
Changes in v3:
  - Remove unrequired type conversions.
  - Make function declarations one line.
  - Use nct6775 function pointers in struct nct6775_data instead direct calls.

Changes in v2:
  - Split changes to separate patches.
  - Limit WMI usage by DMI_BOARD_NAME in checked ASUS motherboards.
  - Rearrange code for directly use struct nct6775_sio_data in superio_*()
    functions.


Denis Pauk (2):
  hwmon: (nct6775) Use sio_data in superio_*().
  hwmon: (nct6775) Support access via Asus WMI

 drivers/hwmon/nct6775.c | 687 ++++++++++++++++++++++++++--------------
 1 file changed, 450 insertions(+), 237 deletions(-)

-- 
2.33.0

