Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD0E31D296
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 23:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhBPW0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 17:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhBPW0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 17:26:12 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F2CC061756;
        Tue, 16 Feb 2021 14:25:31 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id b16so13739452lji.13;
        Tue, 16 Feb 2021 14:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=K98hVeDcDZJxSZfWfbNxqH8J1cAFlmmfibl33bktYFY=;
        b=UPfvyzuIdkAQ9Ywk7shP2hbJY+ignE0bW7f9vkrr66daK+qbwcpwabsiJIxfJbpMNz
         O7VdKdukhL8S+JCuVVoMGLocXH/AiDqMX5CM9VthHxD3jkh1QYL8QC0wWa7CE/As10cw
         dQgyvvKfa6rjtYr+haFeOqnyAbUDQuWatIYIwEMAGAbP8hBgL6AeRSQseVAECL43lror
         IOf+XbwOStJF+lAXVAcc1viIVvkL0LLstL7w+7lbxwZzxbrFfww9K5O+t1vu2TBtjcGp
         INlOn0ZzIzv/HpxciPM9pbPHCMrWIA8dnbHoK271vzIq+cOxPqElQoPOGNpwYUhXEizp
         cUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K98hVeDcDZJxSZfWfbNxqH8J1cAFlmmfibl33bktYFY=;
        b=k82WXllZDGwHSL5CG7a2An4EMYf6AZn9tem4yF7VhmHGNtcUgrRtsWFIsl3J7LXwMM
         gl4lb+4fl+8ChdK8w0vBtQu8m5cNovHAb+XLdq3cl4igYWUADh+lbuvQMYmI3z1xSSWY
         p4i/OmD0NhiVVI9qS/MzizXRypBvzN4w07jlIvvybY11BfOiMP6VU4w+y+1+sbe/RqYi
         22YnbKh/aHDh6XAm3CS/NFcVPJB/Q8ieiJSKoVK6sQ0I6XIxYB6BuAtZ7fEMljPLsHvc
         AtVLRsbehtmpJyA2TBLpSHCbhdVzdtAeMhK1pPPO3/yKF2wDUDr7sGuRolXaw2ecDbT6
         wzNQ==
X-Gm-Message-State: AOAM530g23h+TPOEw8h2kjTuizAtqK/IS+FTiaTlcL4NBUTQ8RfQ6Zx/
        DrN30rAdDJvySnfMhz3BfRE=
X-Google-Smtp-Source: ABdhPJyWNyeY5rVkSELx/u4xd7HRY3mMPtlpggKEB6qcERexs+/KAJbJ1k6iUufraeRbXAsqAXrjKQ==
X-Received: by 2002:a2e:900c:: with SMTP id h12mr13165698ljg.219.1613514330017;
        Tue, 16 Feb 2021 14:25:30 -0800 (PST)
Received: from localhost (crossness-hoof.volia.net. [93.72.107.198])
        by smtp.gmail.com with ESMTPSA id j18sm20971lfe.145.2021.02.16.14.25.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 Feb 2021 14:25:28 -0800 (PST)
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Chen <peter.chen@freescale.com>,
        Daniel Mack <zonque@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: [PATCH 0/5] USB Audio Gadget part 1: misc fixes and improvements
Date:   Wed, 17 Feb 2021 00:24:54 +0200
Message-Id: <1613514299-20668-1-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some bug fixes and improvements to
USB Audio Gadget drivers which I made during
my work on a new UAC features like feedback endpoint
implementation and Volume/Mute controls.

The new UAC features will be sent as a separate
patch set (aka 'part 2') on top of these changes
later this week

Ruslan Bilovol (5):
  usb: gadget: f_uac2: always increase endpoint max_packet_size by one
    audio slot
  usb: gadget: f_uac1: stop playback on function disable
  usb: gadget: f_uac2: validate input parameters
  usb: gadget: f_uac1: validate input parameters
  usb: gadget: f_uac1: disable IN/OUT ep if unused

 drivers/usb/gadget/function/f_uac1.c | 273 ++++++++++++++++++++++++++---------
 drivers/usb/gadget/function/f_uac2.c |  42 +++++-
 2 files changed, 246 insertions(+), 69 deletions(-)

-- 
1.9.1

