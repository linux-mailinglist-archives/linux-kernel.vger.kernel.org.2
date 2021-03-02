Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B353332AD56
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382043AbhCBVpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581336AbhCBSug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:50:36 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90A8C061D7D
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 10:49:43 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id c19so2525496pjq.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 10:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ICT+rzXe6Uf7SYTOFwtfIOL39YlZQ7S1ZDWq8wbgKdw=;
        b=ls2q8gqX0V96FwSbFWk52WiMJyp+XvHetFkLhAkPpRym9jxonqOVaO8b+u2RFcpKE9
         dyggFIiZhdRX+hkFHWZkyj4ZqSqiR3/MrFOTvvJYeVF/RcWC39tC9ccobE9Ml+IBloZl
         Xa046p7c7N/sJt4/YyAwknUjv0hf2k1I+iBFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ICT+rzXe6Uf7SYTOFwtfIOL39YlZQ7S1ZDWq8wbgKdw=;
        b=EQpPE4jtQzYMxKsErzma/WXH1QNn/hRCW2/XEd8VJWJw9mTRirPDK53iHky+Ww/6Cq
         5nTn+ebaBkJz3Kye7bPBUgFvrJardbqTs0lSW+1v1axZsZxcnJaA85bYmHX9zrhC2IdE
         +74y3Tp7YMvLuo4r12w90B9kameakQk2CIEcoFEk8vYlrspVowDNdxTUvMryUC5FocMQ
         MWYxzTbD9/F5wvfq4KfcvAUP3dzA8Q7+WgZ2qs8SUtfc1xg7OnY4MvOurmm4xyCc/2cB
         nflp/rFCHSk4slhnOLIp9IMexDqa//IdXNwZ6nVc2BXQV2f7i0Fgy9VEnlb2BbP5YR+C
         zANA==
X-Gm-Message-State: AOAM530F/E00ikUTDXevnoDghLAuwb59F4jieKLjDtbyw/z+n+uv5Ogo
        D7DHMptCC0DfJnFkCFSaCV2yOg==
X-Google-Smtp-Source: ABdhPJyUbr688nxLCQmvjUglkPWkLxdMy+8VrCxK/FGD23O7xIN2l+BsuOGpwYr0DvUCTB9bk7sDfg==
X-Received: by 2002:a17:90b:4c8c:: with SMTP id my12mr5618286pjb.29.1614710983315;
        Tue, 02 Mar 2021 10:49:43 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:9c83:cccc:4c1:7b17])
        by smtp.gmail.com with ESMTPSA id 140sm21800839pfv.83.2021.03.02.10.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 10:49:42 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v2 0/1] Bluetooth: Suspend improvements
Date:   Tue,  2 Mar 2021 10:49:35 -0800
Message-Id: <20210302184936.619740-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marcel (and linux bluetooth),

Here are a few suspend improvements based on user reports we saw on
ChromeOS and feedback from Hans de Goede on the mailing list.

I have tested this using our ChromeOS suspend/resume automated tests
(full SRHealth test coverage and some suspend resume stress tests).

Thanks
Abhishek


Changes in v2:
* Removed hci_dev_lock from hci_cc_set_event_filter since flags are
  set/cleared atomically

Abhishek Pandit-Subedi (1):
  Bluetooth: Remove unneeded commands for suspend

 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_event.c   | 24 ++++++++++++++++++++
 net/bluetooth/hci_request.c | 44 +++++++++++++++++++++++--------------
 3 files changed, 52 insertions(+), 17 deletions(-)

-- 
2.30.1.766.gb4fecdf3b7-goog

