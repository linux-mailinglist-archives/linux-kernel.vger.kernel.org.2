Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D621B313E22
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbhBHSyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbhBHRKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:10:45 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CA7C061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 09:10:02 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id jj19so26089957ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 09:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kIJ7mfcmFlHUgQLcTPFQ53/9j+GTCsFce2rDhXsJWG4=;
        b=hxsUsps8r1meGO0o7PT5vYT9agfimC9ThuX8WidIlL5s1Y53KFsLr+M2Ujsu5jTO9M
         W95V1YWbtPLnseLXJXJJ+fXm0ZPUsexbKKcGSNeNeNeZ1DzvkcWOo0bSqvb1SAV+pwKa
         9soXNGkQgbwzCE/QJgiVnzfPIh6NOWoLEk+oK1MW7WBYtryZZWcNeYTHvgOJ8Zh8iIiG
         GgBIlD1FbbEJ876wU9wuU+KtuSomXFD2TshCjtl0e62qbbHF8IiFbbYwj34TPaR4iaKR
         c3SBKZt1IDz1v6sGzJMKp/eeqHLxOeiVFwunIIhOjXuDAMQnoQOieWurRslD7Z9ZSydw
         g29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kIJ7mfcmFlHUgQLcTPFQ53/9j+GTCsFce2rDhXsJWG4=;
        b=lOdfJoCyT2HuYe3uYp72e8EJWPEn6TbwdHcXS140sCU3ZJavltyyXdWEOFaQsdPBtD
         +npNvnRry++GO7y0N1xEEkzaVieNiJsflaMxCNYUoCzyWW1I2pNldFbT/4qoGsp4MfrJ
         evLQavdRnpMA6Mhz9GtVn+gZRwIDMooS5/Hjnk/FZVEcFxtOECMhA40LwSk4tdEYis+u
         zPvLSiXIevmnmWJKo4fUWiLQERCSFyHxYHFW/NWNsTxLP586IqhLudpwI7IfvzloBDNm
         zpjNmy2yREu6jMfJdeTZwEJ8g66wKRbC3WPGcnTz40N88OVoC9Zvg8dmQ62b/JibSqf0
         MM7Q==
X-Gm-Message-State: AOAM533YZHpTqw0F/NO6HVl56O7DZ7bfVZjGPYAgiFAE9FOM3IKa1hy+
        d0g6nYcII/YDFPLb7/IIr10=
X-Google-Smtp-Source: ABdhPJwgxrrDEwIedaQjaZKdOhOhZq23uVqfRpaMRAPOdUNyKUNce4uoJ25RDsPvc1QIVlg0p6rocg==
X-Received: by 2002:a17:907:98f3:: with SMTP id ke19mr17612229ejc.290.1612804201476;
        Mon, 08 Feb 2021 09:10:01 -0800 (PST)
Received: from yoga-910.localhost (5-12-227-87.residential.rdsnet.ro. [5.12.227.87])
        by smtp.gmail.com with ESMTPSA id m10sm9834479edi.54.2021.02.08.09.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 09:10:00 -0800 (PST)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     laurentiu.tudor@nxp.com, linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 0/3] bus: fsl-mc: minor updates
Date:   Mon,  8 Feb 2021 19:09:46 +0200
Message-Id: <20210208170949.3070898-1-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

This patch set adds a fix on the userspace support of the fsl-mc bus.
Other than that, a missing device type is added and some other commands
to the list of the accepted ones.

Dan Carpenter (1):
  bus: fsl-mc: Fix test for end of loop

Ioana Ciornei (2):
  bus: fsl-mc: add the dpdbg device type
  bus: fsl-mc: list more commands as accepted through the ioctl

 drivers/bus/fsl-mc/fsl-mc-bus.c  |  6 ++++
 drivers/bus/fsl-mc/fsl-mc-uapi.c | 52 +++++++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 1 deletion(-)

-- 
2.30.0

