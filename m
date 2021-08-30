Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEAE3FB1A4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 09:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbhH3HLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 03:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbhH3HLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 03:11:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AC4C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 00:10:15 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u16so20970364wrn.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 00:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b7XgklqB8Vn+B2YoCcgc/2VGbqHKZvTCvhUGQR7Kyng=;
        b=A19cEXqlQMRFb+jqfANOK/viqfpKJ+hehCInuILpSUt+d7JCq7KGwzISB0t6IM4sLI
         0orQRYHCH1LwMj9QEO0Yar+yQagoxwI3wQoF6JA/XMd0fA14rOv51H/gPSsmKaO97kLu
         3bSFtN9gHl6rC43IhuNXRs3WMvJ2DcNHvJoVSU5zl4fFS9pH6Ssf1xWSYVijfBjMOvIy
         hNjxYrr+qfEyTSrAh1ay5aXmeY61N4Q1X6cPr+PUwwChjihShCXNNVWnvMZkPS13YJmx
         VwG4MonA2t7dolh0wJqAXTzpRERFgDRZK6uP0wzp6j1gRQNSMlShOmZb3L3lU2CmYTIE
         lS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b7XgklqB8Vn+B2YoCcgc/2VGbqHKZvTCvhUGQR7Kyng=;
        b=lw9qjPAV36nhUgmZoTWcO2JVUs2iWfcQgR96KWFZ3JOLVO6wIZgqvQNdVGWGhdga9Y
         HU5owG06qAh5ki4uhb2Lb/LMvXlxNXCinvnx7vzlap8HQMT+gZ49C8P+ciVsZdShzc1c
         77LG+tpkRD7mfHpfK7ex0Q4GETTAiXeBPTeOIGokt16HjVcd2nCu1UdHQD9m56SinM8p
         +SVZ/lf4xRN1Dikw7pgtoDONQnaZQ2W8ZKe7ZSWDj+K1S8DxEvByPIUzPasHZ7u0hrBp
         10YObaDqA0cailg+/DdCLdFkg42qofkgipwex4ROTavUQB+3URkP5uZgEtW8xoXTB/tv
         WDHQ==
X-Gm-Message-State: AOAM533QdA3Xx5s/a6LffS8bcA63wkTFCccCMueKwFArPCR8AsrVzOvO
        h1lwercsGwD84ggYrz/cMwc=
X-Google-Smtp-Source: ABdhPJwaet6WvxSmY+LhhHoWOgdBrAHShvs6Eyg13ez8tuJ1nN61/7K0kkxHz7V7v6B8RzBjq7EAVw==
X-Received: by 2002:adf:8006:: with SMTP id 6mr24618832wrk.38.1630307413876;
        Mon, 30 Aug 2021 00:10:13 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id k25sm15397466wrd.42.2021.08.30.00.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 00:10:13 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 0/3] staging: rtl8723bs: remove lockdep warning
Date:   Mon, 30 Aug 2021 09:09:22 +0200
Message-Id: <cover.1630307025.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchseries removes a lockdep warning that turned out to
be a false positive.

All "lockable" queues in the driver are initialized by
a single function. This confuses lockdep which puts all
locks in the same unexistent class.

Fixed it by doing the initalization of queues in place.

Done a small code cleaning and removed the no more
used function.

Tested-on: Lenovo ideapad Miix 300-10IBY

Fabio Aiuto (3):
  staging: rtl8723bs: unwrap initialization of queues
  staging: rtl8723bs: remove unnecessary parentheses
  staging: rtl8723bs: remove unused _rtw_init_queue() function

 drivers/staging/rtl8723bs/core/rtw_ap.c       |  3 +-
 drivers/staging/rtl8723bs/core/rtw_cmd.c      |  3 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c     |  6 ++--
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 12 ++++---
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c  | 15 ++++++---
 drivers/staging/rtl8723bs/core/rtw_xmit.c     | 33 ++++++++++++-------
 .../staging/rtl8723bs/hal/rtl8723bs_recv.c    |  6 ++--
 .../staging/rtl8723bs/os_dep/osdep_service.c  |  7 ----
 8 files changed, 52 insertions(+), 33 deletions(-)

-- 
2.20.1

