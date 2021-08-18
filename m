Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4E83EF959
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 06:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbhHREbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 00:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237354AbhHREbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 00:31:13 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63204C061796
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 21:30:39 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id qe12-20020a17090b4f8c00b00179321cbae7so1510551pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 21:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a0LOe5TP/MBO2wNeDbghMruuMrb9dKCIPmMRCLEki+o=;
        b=eDN/L6WuO3TyTi0qDmqtH9D45GKtl3b2ANmz/AMyOyEVKFYG/4Yuyy0Gh7FDbN5bWe
         WBNYwmuDJ+LaXEImCFGYICnkvJLJFiWev+0DLPABDkQXJptxMHh8soPhf4P4IpwnQnV4
         X0ypgxMF7PN/NHuYeGGKeNdYkajLrqlMYFBRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a0LOe5TP/MBO2wNeDbghMruuMrb9dKCIPmMRCLEki+o=;
        b=qCn2ZT/Nl2GsyjQQ/VumYkjeHQlmy8M+I7WYPVVF28gY2D/DO1r4h/4cwUV806NUzK
         m90NUVxQmHiinH2B9G2tY4h1Ls4NVfTh0jmWEGkp+ganeaDqEbl+e9YO1nOjm+hK4IlZ
         +omtG360etxXZcLmXpgiqI4I+r5Ol7Y9/mJcTbNsyttBbQCBeIn6KGG3R6DlRrIKHsKo
         VSTuqBPxmr9Ir7EtEPY64sKTdhkvxGSIEyytbGOPkPGLcsNFUx1PpIavjYVTHkXEcJH9
         qBNwAuc/Hj2C0iQo6TrsIWwyq1+KoRstWhAQf48MyIcqv/sw/7bQI13nYY2iWba4RhxS
         Q8vw==
X-Gm-Message-State: AOAM532WTClV/wDFKTfek2C+mRAsvfpG9Udm6b6WxTLgz9qxmZvM29h9
        LYcASmjQhwG3vna1/Ay6S7DqVw==
X-Google-Smtp-Source: ABdhPJwsaTtZYXKiN4quxJ4tzCQha7i8BPchElKOd3en3ff3OSk7pG/77Ovg0c9R34pvM4YsriVjhA==
X-Received: by 2002:a17:903:4101:b029:12d:6318:6226 with SMTP id r1-20020a1709034101b029012d63186226mr5601156pld.8.1629261038930;
        Tue, 17 Aug 2021 21:30:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y5sm4998163pgs.27.2021.08.17.21.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 21:30:38 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] USB: EHCI: Add register array bounds to HCS ports
Date:   Tue, 17 Aug 2021 21:30:32 -0700
Message-Id: <20210818043035.1308062-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=714; h=from:subject; bh=gAZBA/dZMYNBvc+aJ1p1+ilMGGcRI9fgz97TIxYfSJw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHIzp9ZEAsN6oHOIuutYwg2OQxH7kmBw4WprGR96W TR5ELHSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyM6QAKCRCJcvTf3G3AJlWDD/ 0ZnrXjglcHMcCrFnazmWm3XRbajDPcRWtyCYemldv5kCEDC7Yhxrz8ouoLpM1TIUPfGk9S1kKqNwZU ttqIU9//EVeda2hrcDCV6RuuuOFhdMDU9SRpjwNYbuC46Qr1HoLlhBf5CGEwodNZ2nmCbkzpUXGAU0 ru10H2fLTIYtj3LWG71+bqhbPpu+R6MiTS1mw+G4z6aR+FFBgN3XAJFhML+nIst54zd/ilkhIJMDBN jJPDUXUvlVSiduNap3Wu5oCs/4WcLcj/a6BZ+QaiJTzB0S8NBPdI/RALe6QUscMjda6PCN0HBQ76tD Jjz2ZErujVzW60ugo5EXVsLRNrPE4NfcPS0oIlFjuBsIky9jXTFwEosm16e9u/RI907TYK+5UsEbx/ AGwsZ9aRF6Sd+hdWyaq3o6813KedX4tfhq0JPMVHF16VzNqEDP3MFwDaOkN2AhBPcbknlLvlrZTGCd XIrbW3IVJLYIUp7WKV4HOgXpQKRjWjSDgs4Z5l01G/+67Vk+q3DWZQd1ngBSN9h+YODdiKhXc9CHwT evJo1DkjGAxp9X+MfbeWzt1msdEnQBSulZpce5UN5U7buH+YLftsxHN/x3omJw7sBw+B4eagLsNxOh eBB1nwNxR1MfQn9rezy3pzi8lTunkDWeckdxixa5rmq5rf0TunEMXaJdEttA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is cleaning up some of the remaining things to be able to apply
-Warray-bounds and -Wzero-length-bounds globally. Only after doing my
own version of the port_status patch did I find Arnd's earlier
patches, including for the weird Broadcom stuff[1].

Anyway, here's what I got. :) No binary differences.

-Kees

[1] https://lore.kernel.org/lkml/20200527134320.869042-1-arnd@arndb.de/#t

Kees Cook (2):
  USB: EHCI: Add register array bounds to HCS ports
  USB: EHCI: Add alias for Broadcom INSNREG

 drivers/usb/host/ehci-brcm.c | 11 +++++------
 include/linux/usb/ehci_def.h | 38 ++++++++++++++++++++++++------------
 2 files changed, 31 insertions(+), 18 deletions(-)

-- 
2.30.2

