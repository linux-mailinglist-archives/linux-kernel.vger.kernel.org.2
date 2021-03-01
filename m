Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12922327DA6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 12:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbhCALxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 06:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbhCALv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 06:51:29 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467CDC0617A7;
        Mon,  1 Mar 2021 03:50:09 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id k9so5083841lfo.12;
        Mon, 01 Mar 2021 03:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IJw3CqmSaFhjDn+unuI553Asu7wtLovHtuTDpDOVdxg=;
        b=K+kbu6Hsyu3ePz5h8PJqozV1BiHoeSTUdyxe8PJtVAu89+Mzrti5AkjGOsh4RDXgK0
         hJbh/PwK+f0ucFTc8rym4KZ+4q/fTyvmWxsbUj0xiNRRWrJp0WZqpsgUtPTJbss6lNGp
         n2a7X23CPHG2ioXzn+4rNe4GCP52boQOObHphX5H1CiR+Q+e90TUrZDKqQ2vDKKmcgyf
         Tm0f/2nWymzF9tZSHvroPGUEhhLDslYrWd8EJTlsMQlGKTO+P+9AMaa9FRH1ywmYqeJX
         oc3CEJuQIWajhWn+DGRAf4RN6hkNvbCvCfrBLbGULmnJR5OHqhQlHRmMJcWcDb1fx/R5
         Vt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IJw3CqmSaFhjDn+unuI553Asu7wtLovHtuTDpDOVdxg=;
        b=bVD7TCvXSar164CCzT52oVEocYzwLusH9aNjiGC22IbwK5ITfj1EGObZ6405Hl2g2A
         6TEWidMLbPHWjRjgRNQ6ADeBCqp79BxOe36HjYc25KuHhwLP4i2Gp/soJuWt2H0y5xnK
         vpgC6b/cKGRxw2KSfCUR+lwM3YPD3cbKmzxu6dQaQF2KvyoWcxXjtZy16fuZAfNHzNoH
         L57l+HnTCt2Y4o+/cafM5y79UC3YJj3P24zXx0FFMtZKYnpxfYSOzXmQ9VygH7JhRovE
         YVrVH5EklWkT6eZMWI+2tZxjogAWlPSrlmsM9oWbzE6B2/By0bcTgPfFGgl45d2dVnMm
         36XA==
X-Gm-Message-State: AOAM5307pA0O8ugi44KmaZQ5e920uDj32q2ZaK7wQ2ht1XNOXdRseyDy
        ijOn5BH76PoXpaAmBNBOuLU=
X-Google-Smtp-Source: ABdhPJwvASMVwP/2cXSmPprKTDdiBe0Wl8YD5eGj8rM32l7wrqr1t76z9T2UGFkaVSeYnCcqrNcggw==
X-Received: by 2002:a05:6512:b0d:: with SMTP id w13mr5255900lfu.500.1614599407824;
        Mon, 01 Mar 2021 03:50:07 -0800 (PST)
Received: from localhost (crossness-hoof.volia.net. [93.72.107.198])
        by smtp.gmail.com with ESMTPSA id z14sm2275447lfh.296.2021.03.01.03.50.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 Mar 2021 03:50:06 -0800 (PST)
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: [PATCH v2 0/5] USB Audio Gadget part 1: misc fixes and improvements
Date:   Mon,  1 Mar 2021 13:49:30 +0200
Message-Id: <1614599375-8803-1-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some bug fixes and improvements to
USB Audio Gadget drivers which I made during
my work on a new UAC features like feedback endpoint
implementation and Volume/Mute controls.

That's nice bugfixes/improvements that I expect get
applied faster than coming new features thus sent them
as 'part 1'

The new UAC features will be sent as a separate
patch set (aka 'part 2')

v2: fixed possible NULL-ptr issue with input parameters
    validation

Ruslan Bilovol (5):
  usb: gadget: f_uac2: always increase endpoint max_packet_size by one
    audio slot
  usb: gadget: f_uac1: stop playback on function disable
  usb: gadget: f_uac2: validate input parameters
  usb: gadget: f_uac1: validate input parameters
  usb: gadget: f_uac1: disable IN/OUT ep if unused

 drivers/usb/gadget/function/f_uac1.c | 273 ++++++++++++++++++++++++++---------
 drivers/usb/gadget/function/f_uac2.c |  41 +++++-
 2 files changed, 245 insertions(+), 69 deletions(-)

-- 
1.9.1

