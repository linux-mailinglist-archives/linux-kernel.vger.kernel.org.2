Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3EF354928
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 01:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbhDEXOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 19:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbhDEXOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 19:14:00 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5B1C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 16:13:53 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 7so13144707qka.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 16:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oY9AEHqMCoctA85AChPKxlTTwqq5V8ksN6WFesdYeHM=;
        b=SPE2oLxix0ZnxE10qCqINgJc8Ncpd4gIloyEunLq07fnxspwS+9sqwRSnsr/P0mpKV
         QRzQUhfmHGXXQO7NrE2twBpRcVECM2vnTmGi4rBYW80eb3qLiSN1X09SAM21337HbF40
         8/UACXQ34wfjiQWXws7DZNxpf6Yi/+TRHV/bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oY9AEHqMCoctA85AChPKxlTTwqq5V8ksN6WFesdYeHM=;
        b=kg+ezSwIlag5HtW2m2OAbL+zzDyCp9XQ0LxlARabcHQCsxqS4OPegS/UMyHdnvu6BU
         7mmoZ0JbvP5iyuNaXb1E+nsZYJ98AAwQdayJJK9BoeCwoVAHnOJKh0kpFZSDdBTFxxOF
         ojn5+CDUU75hCBVA0qhuReVbQSROx89d2tke0u1MpdScCdNtf7fpy9a8OdnsdfyqmKkO
         JovejaR/9Ets4k/thH5w5/IIbptbB97saIEjxfo4xiTUf6KfeChSaezaWHddXvZIbdHY
         o+WyG7nGwB6InlQfOOe1u3Uc2qAyhhXewdMudWPYXK4goZ3W/liRordfFO0/6J75OCwx
         nHrA==
X-Gm-Message-State: AOAM532tCUzIMK1Wb1AOAuZUq7oqOZrAb1KwPeyw9QPJS+KpSqeaSncF
        7L+1+MuoXrbxzmvCWj5PgHdZ/A==
X-Google-Smtp-Source: ABdhPJwyGo4QG+wg2pQsoVa5tL2+SgxR3n93EHzX1oJNog5PTiePblgDmjkdHHKviHB91pxQcFs8lQ==
X-Received: by 2002:a05:620a:440a:: with SMTP id v10mr26128060qkp.357.1617664432401;
        Mon, 05 Apr 2021 16:13:52 -0700 (PDT)
Received: from grundler-glapstation.lan ([70.134.62.80])
        by smtp.gmail.com with ESMTPSA id b17sm13151650qtp.73.2021.04.05.16.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 16:13:51 -0700 (PDT)
From:   Grant Grundler <grundler@chromium.org>
To:     Oliver Neukum <oneukum@suse.com>, Jakub Kicinski <kuba@kernel.org>
Cc:     Roland Dreier <roland@kernel.org>, nic_swsd <nic_swsd@realtek.com>,
        netdev <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Grant Grundler <grundler@chromium.org>
Subject: [PATCH net-next v4 0/4] usbnet: speed reporting for devices without MDIO
Date:   Mon,  5 Apr 2021 16:13:40 -0700
Message-Id: <20210405231344.1403025-1-grundler@chromium.org>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces support for USB network devices that report
speed as a part of their protocol, not emulating an MII to be accessed
over MDIO.

v2: rebased on recent upstream changes
v3: incorporated hints on naming and comments
v4: fix misplaced hunks; reword some commit messages;
    add same change for cdc_ether
v4-repost: added "net-next" to subject and Andrew Lunn's Reviewed-by

I'm reposting Oliver Neukum's <oneukum@suse.com> patch series with
fix ups for "misplaced hunks" (landed in the wrong patches).
Please fixup the "author" if "git am" fails to attribute the
patches 1-3 (of 4) to Oliver.

I've tested v4 series with "5.12-rc3+" kernel on Intel NUC6i5SYB
and + Sabrent NT-S25G. Google Pixelbook Go (chromeos-4.4 kernel)
+ Alpha Network AUE2500C were connected directly to the NT-S25G
to get 2.5Gbps link rate:
# ethtool enx002427880815
Settings for enx002427880815:
        Supported ports: [  ]
        Supported link modes:   Not reported
        Supported pause frame use: No
        Supports auto-negotiation: No
        Supported FEC modes: Not reported
        Advertised link modes:  Not reported
        Advertised pause frame use: No
        Advertised auto-negotiation: No
        Advertised FEC modes: Not reported
        Speed: 2500Mb/s
        Duplex: Half
        Auto-negotiation: off
        Port: Twisted Pair
        PHYAD: 0
        Transceiver: internal
        MDI-X: Unknown
        Current message level: 0x00000007 (7)
                               drv probe link
        Link detected: yes


"Duplex" is a lie since we get no information about it.

I expect "Auto-Negotiation" is always true for cdc_ncm and
cdc_ether devices and perhaps someone knows offhand how
to have ethtool report "true" instead.

But this is good step in the right direction.

base-commit: 1c273e10bc0cc7efb933e0ca10e260cdfc9f0b8c
