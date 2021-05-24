Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDD638E811
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 15:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhEXNwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 09:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbhEXNwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 09:52:40 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65369C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 06:51:12 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q15so20131923pgg.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 06:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kqGP5YDfLqC7BOTyOowLlRvP4iahKUX3sBcrSvGeSxg=;
        b=bOU5PR7ndXGJMpjlv0h/UDJTk9D3/yN9bzIkstWdC5zR/tI+6940H+q9s+JeKxGkSM
         VsoGZToq0Ieb3k+SRxc3URgs2x1WAUWMASfeFaAn1yP5i7cd5Fa8G8pd7uOZ26zAf2Au
         6GSnnLkkImEOCgCYkKzqoOH7Ow1tc89HyJNulGfhnobiS4g2CCR4MpYmKPucN2twxAPG
         AHojaTUPkLq4vFB6tneBhKj24kfJpbIjc6MDNtd8o0Cw6DFSl46tS4h8XfE4omFbfIl2
         ZhMnLSWx2TZSUKwBdskP5IN8e0m+XDZUkTVqfXNwtjABMW1LAlVd04jBvS9Qj5BgaLK2
         srNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kqGP5YDfLqC7BOTyOowLlRvP4iahKUX3sBcrSvGeSxg=;
        b=XtEssLplQSYG+NmfHEx4SlHxJkokpZOjMktLpjL0OUY5FydgEtRiMPYNsPnSGgbR3B
         1DOZ1IIe4UjiX2QxT2pXDVFozv6sIYknU7tN/DK1WI7JLfiYO626hZhewXJhZULjN/II
         1K8PDPSzGOuzTaVg51Wwixf/4y132HOvBhRgk4sAC3P4y6uGxqcDV+63rM6nEcanQFlC
         vFqgAVXxPasioJIkPIGFNCTP8lHTcr4PtWvLGAPEBPFfCZb3yUPLIAFGsOQl1IMa2RY0
         gq0xSj4jrs8kiDXsWnPLdR2SBDGCOHF8r7Xs8IVX58KvKh+J0LClzauXjTu/TCXfI4MZ
         c/kw==
X-Gm-Message-State: AOAM5318Lg6AdP0+LmJBN4lUFLfEnohQWlrxHME3XbmQ9m3jmgnwaApX
        PFrqwWNPAnLtAVw4WX3HGJY=
X-Google-Smtp-Source: ABdhPJy5xN27Q2qcI63Y5MrM5mkQQRABU75LRMVS0Ms/y9lkvrdvOhgSIAA3yenK7NO1grIKy8yG9w==
X-Received: by 2002:aa7:9a0e:0:b029:2dc:70d1:2224 with SMTP id w14-20020aa79a0e0000b02902dc70d12224mr24931034pfj.1.1621864271784;
        Mon, 24 May 2021 06:51:11 -0700 (PDT)
Received: from fedora.. ([49.36.218.98])
        by smtp.googlemail.com with ESMTPSA id z9sm8638106pji.47.2021.05.24.06.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 06:51:11 -0700 (PDT)
From:   Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        straube.linux@gmail.com, fabioaiuto83@gmail.com
Cc:     Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging: rtl8723bs: fix indents in rtw_wlan_util.c
Date:   Mon, 24 May 2021 19:21:02 +0530
Message-Id: <20210524135105.5550-1-chouhan.shreyansh630@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series aims to solve all indent related issues for the file
core/rtw_wlan_util.c.

The first two patches fix the follwing issues reported by checkpatch.pl:

WARNING: Too many leading tabs - consider code refactoring
#887: FILE: rtw_wlan_util.c:887:
+                                               if ((edca[j] >> 16) > (edca[i] >> 16))

WARNING: Too many leading tabs - consider code refactoring
#1528: FILE: rtw_wlan_util.c:1528:
+                                               if (pIE->data[5] & RT_HT_CAP_USE_92SE)

WARNING: Too many leading tabs - consider code refactoring
#1536: FILE: rtw_wlan_util.c:1536:
+                                               if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_BCUT)

WARNING: Too many leading tabs - consider code refactoring
#1539: FILE: rtw_wlan_util.c:1539:
+                                               if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_CCUT)


The last patch fixes the follwing issues reported by checkpatch.pl:

WARNING: suspect code indent for conditional statements (8, 24)
#1257: FILE: rtw_wlan_util.c:1257:
+       if (p && len > 0) {
+                       pht_cap = (struct ieee80211_ht_cap *)(p + 2);

WARNING: suspect code indent for conditional statements (8, 24)
#1260: FILE: rtw_wlan_util.c:1260:
+       } else {
+                       ht_cap_info = 0;

WARNING: suspect code indent for conditional statements (8, 24)
#1265: FILE: rtw_wlan_util.c:1265:
+       if (p && len > 0) {
+                       pht_info = (struct HT_info_element *)(p + 2);

WARNING: suspect code indent for conditional statements (8, 24)
#1268: FILE: rtw_wlan_util.c:1268:
+       } else {
+                       ht_info_infos_0 = 0;

WARNING: suspect code indent for conditional statements (8, 24)
#1271: FILE: rtw_wlan_util.c:1271:
+       if (ht_cap_info != cur_network->BcnInfo.ht_cap_info ||
[...]
+                       {

WARNING: suspect code indent for conditional statements (8, 24)
#1284: FILE: rtw_wlan_util.c:1284:
+       if (p) {
+                       bcn_channel = *(p + 2);

WARNING: suspect code indent for conditional statements (8, 24)
#1295: FILE: rtw_wlan_util.c:1295:
+       if (bcn_channel != Adapter->mlmeextpriv.cur_channel)
+                       goto _mismatch;

Shreyansh Chouhan (3):
  staging: rtl8723bs: refactor to reduce indents
  staging: rtl8723bs: remove unnecessary braces from conditionals
  staging: rtl8723bs: fix suspect indents

 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 161 +++++++++---------
 1 file changed, 82 insertions(+), 79 deletions(-)

-- 
2.31.1

