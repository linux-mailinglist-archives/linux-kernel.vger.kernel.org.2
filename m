Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C9B3F5369
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 00:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhHWWin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 18:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhHWWik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 18:38:40 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D81C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:37:57 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id me10so11820484ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HOYcVK/PupAyTSKG1WTjWKuz7jMiHsuJ9l66S9C5qRA=;
        b=JAwss7mvORNTFGBLkoY9g43fQPYGr3ycyfLGXxfn7xE3u9LJd0Om8h7ZBOEYwZlnxJ
         zl5q6w9qBVc9TafdeCB9vyJIfF//IC3ZDe2L3q3SmXwTObtLYR39ya+tDed2/ojL77EB
         SUP7QkeaygGjtgPZ5xwX3xSo2GBiFb0WLRTah2JOS0v9y1L4y8jkTiuDHQdOnDfgRM4n
         HcSTzVbzum+xll2CKCRcIM9/AAEZwIaq0vlH5STVg9lo/3wJR7aJqi9uPzjDKhdPrygE
         LpYtpkUYW4WyWWPDwaZRdtKvn5q6zKiw5k2nxlXDWvhO40BCY/ys2Lja6N5Eo63pvc7R
         cU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HOYcVK/PupAyTSKG1WTjWKuz7jMiHsuJ9l66S9C5qRA=;
        b=FzXNj9R3nPLxbEJIARhf9By80Y89iDwpM8QpVUJb5nRJeMb2COtSzDE9wwFu38EL1X
         99Vqcay2UR9nRV8bnytRMRx7tC59vj6lUi7fvcHpF03bwFpkMhPxLZ0mmKnixt62xwks
         rS2sv1a/JolL5D2FxtZpoShzf5faEsBAItSBgsSIl1z5dVN6/3CRLO1Fznu5uVXVXYCi
         j+/nxwARp8vIrVY+OFBim0IJpICXmRdKj0OkY4tzvu8Kpa10X45FT3mbUzBuBPd/I9dR
         fNq2xjAf3O0NLBlSgYlZmP3dS7TKNuR+hg11oE2amHOllsh8DDJAECyhb382BC1+vwFv
         5cqQ==
X-Gm-Message-State: AOAM532YEf5paL9RcFdyXblVd+EroaD9s9B3IOdZclolpTo2+j8LnsQU
        s8fzO1BEv3GH43cFxYBsc/o=
X-Google-Smtp-Source: ABdhPJzY4IP/gXljzfMWbFVxvhGjRPLlCusx5kZeSANDKiketNr4ICaOl80ARKH8Qmwvrp8ibJxNRQ==
X-Received: by 2002:a17:906:38db:: with SMTP id r27mr38758558ejd.338.1629758275713;
        Mon, 23 Aug 2021 15:37:55 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id p23sm10375326edw.94.2021.08.23.15.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 15:37:55 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 0/2] staging: r8188eu: Use new usb_control_msg_recv/send() 
Date:   Tue, 24 Aug 2021 00:37:49 +0200
Message-Id: <20210823223751.25104-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace usb_control_msg() with the new usb_control_msg_recv() and
usb_control_msg_send() API of USB Core in usbctrl_vendorreq().

Remove camelcase and the unneded initial 'p' (for pointer?) from 
the pIo_buf variable and from the pintfhdl and pdata arguments of 
usbctrl_vendorreq().

Fabio M. De Francesco (2):
  staging: r8188eu: Use usb_control_msg_recv/send() in
    usbctrl_vendorreq()
  staging: r8188eu: Make some clean-ups in usbctrl_vendorreq()

 drivers/staging/r8188eu/hal/usb_ops_linux.c | 47 ++++++++++-----------
 1 file changed, 23 insertions(+), 24 deletions(-)

-- 
2.32.0

