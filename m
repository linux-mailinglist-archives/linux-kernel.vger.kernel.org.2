Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBA143989F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbhJYOeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbhJYOe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:34:27 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE8BC061746
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:32:05 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m22so9917684wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IIGRvhXmp/ODidkCDs+qSECALH/6ezkCoaRxNQbD8+M=;
        b=PuA9ttglf9ol8ctfnt2c1N7mXBmSb7L2A0tTnjH70sDRFU5XpU+WY9UPb0Y7pVjknG
         Ici7wgBsyKjTxQiVO0KvRxrC5a3JkeNJfjv6pyXoakHiiyemnQQXZcEjvJg46RUth5Ym
         eCWWxxhhJozVftBqn2f5DqfMjBRCoTAURCin9JIW/el1MKvkSnHjRY95fInzg4UB/7aX
         jzuPZr+a83uwEsCAQEo3eIVUMZIdobsNFT6czFmAn9tGclc4uKQA21MIrqAtO8BdhW/w
         oqrfIWRGR5eIsR0vH/9rvi0oyLb550TML9i860qOBWMUTPMQOVgwuj84T4U925afc5IK
         QGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IIGRvhXmp/ODidkCDs+qSECALH/6ezkCoaRxNQbD8+M=;
        b=ADr4PpTTcXpzS1IouJawJKPgW5FYECPxm+Z+bWE4HC1FBpg1npOVDvEEmuWeXQLyvU
         Gj4aycY1IVrtsPoc3kOWvd4flywlnTaV1wvdFzwlZEf/VCf/tnlG1KLHu+MWULPDiLBz
         cYyHe4x8pLCNmSCfxUb5hygLIzLOB6c4Tcy3qIhwCOgKYtodf0UHkPza+uPWRX5vb6CI
         Ptp24eyg0FMRy7VVbxlO4ofTC4mTizr3rlKhilhTgb87B388so3HyZA2rcyoupMBrjch
         Qkx5lQpCpoaqtL5KPRXAdPsl5jpue6kTf8AfUpNjlN+GM1KOgyo4ZbyKq9AdUMxjgmp9
         aR5g==
X-Gm-Message-State: AOAM531BzDJKzGFBpqR+6ia4FiCA07thAIYT8fk5mkTi/3X0KI8h9CIG
        kD35rIPO6uTuQDoSAC4J3e8=
X-Google-Smtp-Source: ABdhPJxeSMHkprsiBO0a8tVDkozdP5fElEXvnQrPcy4zvyEYPgDM1j6mikQ1YNf8nJchkLecYi88Gg==
X-Received: by 2002:adf:c78d:: with SMTP id l13mr23111243wrg.134.1635172323900;
        Mon, 25 Oct 2021 07:32:03 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id x8sm13011500wrr.53.2021.10.25.07.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:32:03 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 0/8] staging: vt6655: Rename channel, init and power tables
Date:   Mon, 25 Oct 2021 15:31:26 +0100
Message-Id: <cover.1635171518.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set renames global arrays of settings for AL2230 and AL7320
transceivers so they adhere to the kernel coding style. It includes removal 
of the Hungarian notation and changing variable names to use snake case.

Karolina Drobnik (8):
  staging: vt6655: Rename `dwAL2230ChannelTable0` array
  staging: vt6655: Rename `dwAL2230ChannelTable1` array
  staging: vt6655: Rename `dwAL7230ChannelTable0` array
  staging: vt6655: Rename `dwAL7230ChannelTable1` array
  staging: vt6655: Rename `dwAL7230ChannelTable2` array
  staging: vt6655: Rename `dwAL7230InitTableAMode` array
  staging: vt6655: Rename `dwAL2230PowerTable` array
  staging: vt6655: Rename `dwAL7230InitTable` array

 drivers/staging/vt6655/rf.c | 76 ++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

-- 
2.30.2

