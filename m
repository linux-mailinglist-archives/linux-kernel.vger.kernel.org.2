Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C32421B36
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 02:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhJEAmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 20:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhJEAmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 20:42:18 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A5CC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 17:40:28 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id y201so23953418oie.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 17:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=twlmdLpCjDHz+27xQowbGFx/HnS32RO/0/zhYrwu5jc=;
        b=SHePYSTfcrqkRCYKDK4A2wTPJO6USO07h5XtUb5VYbBwgIl9NQZqYd/9RK3n/Nxmds
         +XlsOrpXQEip3fTsGTANg7isCBSJ0y7voN6BIdofjC+hEw0i+YolqBdtDxtwJAf+AiXv
         hDXzr/zX/Ehq9gg2q8mSCLHOfVmM//+q8tEfvGnNcsa+xriQRxVSjyMiD+qMCC1OJnQA
         j7BUv37P5BCfNcVTuPzq7MS4Do+x7Nsa3z7w3FlvhwFGNS24HyWOzjxLaMDc07pZisOV
         n8qxSYaA1corlyb16HN7mgK+6XGWFKFeTG5ruOJ/94cfjDb0IiiBymcEtgZFqHtCm6Cf
         BQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=twlmdLpCjDHz+27xQowbGFx/HnS32RO/0/zhYrwu5jc=;
        b=sYcrAyOTnamqp7bTXHuEY9VphGAf6uT9LH0KrUJ0T5/Yqly+Pow34zhhOYKoVottr0
         TWFtoWL/r6jtS3Eu1d71IDNP7Yd7KHVnoSRpU1NCVgv/udeUdvhCh8f559VY6HwOQse2
         oWRc5dQ4SgZNkyMwfcrbX91vxmrxBOgcCO/RKMtzKursFx//cHLfq2lWoANxnabnl6xw
         KaaIXTCBSKbNj1AITGjGjNJKftBHkBSFM+oM6mIUjMps/jWpLnPFzKWd8ylOZCl2UGsG
         xpG3oCBCgmGNS0pxC861piL2gOO1lWuOkZ2CoNtD0L3kiApBqA+rfjIwc0UCnWgtTuwK
         ppgg==
X-Gm-Message-State: AOAM530gldlOyB1Cgx6zIbvzJRpQgixFj4yNyjfg5tqKUGEcm2P0NfmH
        eqc+d6EOoVFGQiIdxzZAuA==
X-Google-Smtp-Source: ABdhPJzdt7qibam/jvY3sK4t2jDT0lMobLyudIZhl7z4tRh9IRf+VuMHCMSdzeElDGG4U+0T0MCh8A==
X-Received: by 2002:a05:6808:a06:: with SMTP id n6mr146076oij.86.1633394427736;
        Mon, 04 Oct 2021 17:40:27 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id x8sm2734163otg.31.2021.10.04.17.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 17:40:26 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from t560.minyard.net (unknown [IPv6:2001:470:b8f6:1b:1ce5:3fb4:8fe9:30d1])
        by serve.minyard.net (Postfix) with ESMTPA id BA92C1800F0;
        Tue,  5 Oct 2021 00:40:25 +0000 (UTC)
From:   minyard@acm.org
To:     openipmi-developer@lists.sourceforge.net
Cc:     Andrew Manley <andrew.manley@sealingtech.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Add support for access through an IPMB bus
Date:   Mon,  4 Oct 2021 19:40:14 -0500
Message-Id: <20211005004019.2670691-1-minyard@acm.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sets lets a devices that is sitting on an IPMB bus talk to
the BMC as a normal system interfaces.

It also adds the ability to message other MCs directly on the IPMB, and
it can receive commands and respond on the IPMB, too.

This is not meant as a replacement for ipmi_dev_int.c.  If you are doing
a full BMC, that's probably a better choice.  These changes are for
devices talking on the IPMB to BMCs or other MCs that might get some
commands to handle.

-corey


