Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C04A34B8E1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 19:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhC0S2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 14:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhC0S2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 14:28:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA94C0613B2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 11:28:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v6so14109947ybk.9
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 11:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VH7MRJ1vre+Uw1HlQjSKaTYIPCkbY8m60uQBpBYbP/s=;
        b=tVzi/HsyDPBzK7b7D5sSI8+qnAkLGdESie3uAVLPGJt6/ztfkg+KaTU7GXxsbtVM0e
         aoQFq5SZf5cQbqBByv3HJOIzh5PChg7I//fvfEsIq+KNTnTBXgezXJLFWLBqifBls6R8
         w0fcmk0OteSKmRa9a4FP7lZ52C4ptaDvXtvS6+wKelEGiO0rU+Gye7tqcXkRZvPvx0ow
         Fbtta1OoBk7KrcDkvw/1iknFUsDgWnTx5wlQIooV8LumqkMV5nGEfl1tpKnOL7tHjDiw
         Ya6DC2bklP9D1FtJKGI0MdxNV5P10X5z/cLuoiNUDTEI2T30vWth3lQKinCTqPAGKSUF
         netg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VH7MRJ1vre+Uw1HlQjSKaTYIPCkbY8m60uQBpBYbP/s=;
        b=gTz2NtBhU+cjDO/UFQulAtMEkMq9B82PLexCKY9nH00YWygWA23F6Cg+1BhQ+hkbU+
         Lpgfh7XQ4uJ416dDS+dJUkrC2u9Mishm1DGi984eIKsjgIQsX/N34Wyqp6YojUeKXvGr
         PFCFor1hDDUSs38rI2nK2PTIE8iOoSXjrHCiONn+ASUHe+ponjdEV2j8MP+/34IpY8Cq
         Yxu62Htrzj/nuf0MsiBxXV7mCx9TiwqkI8DGlMt9VwkZpzC7C0ohFmKfzzHkdnZECya8
         y737MT1mZbYLBw/OqdJOypQFOYdkNdm/VggFtqPK+7OJdBuJUfs1epCZJEtFRRAxCm3E
         Jxcg==
X-Gm-Message-State: AOAM530OeOCcTMag3ptSsjZfsXFMaPOhlpkYSZmacifhWtYt/WDiSVlO
        W5saaEIdUbw9iUPEHN7IVpnYuuPuA2o=
X-Google-Smtp-Source: ABdhPJzqiOHaN95+QvY5fjzMHXmrr8NFemuU9fTBYIFot5Owdjy6/dB6B0qJTck+ZJg22AzQew9lc3qrH9A=
X-Received: from raychi.tao.corp.google.com ([2401:fa00:fc:202:493c:e5b:69c:54cb])
 (user=raychi job=sendgmr) by 2002:a25:384e:: with SMTP id f75mr27889080yba.462.1616869693895;
 Sat, 27 Mar 2021 11:28:13 -0700 (PDT)
Date:   Sun, 28 Mar 2021 02:28:07 +0800
Message-Id: <20210327182809.1814480-1-raychi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH 0/2] modify power_supply usage in dwc3
From:   Ray Chi <raychi@google.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kyletso@google.com, badhri@google.com, Ray Chi <raychi@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the power_supply usage in dwc3 is wrong.
In addition, there is a build error when CONFIG_POWER_SUPPLY
is not enabled. Therefore, these patches will fix the
problems.

Ray Chi (2):
  usb: dwc3: gadget: modify the scale in vbus_draw callback
  power: supply: Fix build error when CONFIG_POWER_SUPPLY is not
    enabled.

 drivers/usb/dwc3/gadget.c    | 2 +-
 include/linux/power_supply.h | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.31.0.291.g576ba9dcdaf-goog

