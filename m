Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E7E3F9AA8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 16:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245263AbhH0OLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 10:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbhH0OLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 10:11:23 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC80FC061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 07:10:34 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b7so8676574iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 07:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=rrJMTcBJng7lg5+SYeFOOrr3iU5VlkOZnQpM2Ssl+hQ=;
        b=oVatR1qDsx2892HhBb+8XxxPXjxCNF6FBamsG+Z1leyWQpucAiUcA8mC7J2HpqNAgw
         MqUQnzTht9L8TKigieacD8a1mjenTQb02uvQ/FDnuFrwdono+sStwj3XPNT0XBP5PZus
         OEb2uGxrkjUW89z/R41/YeTS+HFCwrGK2Qhi4KGJ5XLRbk4ZQ3GJmi3gdoqCkJC0uVvU
         mg3sfjGENmHU14Y6wdWHBFyJI+vGsLYwX8xrkkC7OoD1q/vCrup1Ycj/n2nebl+EaTIX
         sjGTeLIDagyx4d6SOSfavzNTgCH6HQjWpOHnmuLIRbfbbNgjuS/S7oBF+R06e2Iv/QYi
         qoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=rrJMTcBJng7lg5+SYeFOOrr3iU5VlkOZnQpM2Ssl+hQ=;
        b=FY4qYRezvxpA/1r8cdrhYey7zwannXtJ86KT0ttfGZ0pf1UI22bIDGHqkkXOwXjAwg
         QFo7hMB+utI8s+sVPK8bvrko18OKHfvmFURpneclHJeGIAGPX1gsKWfBNAGbAjpzA5da
         oPMG8gjnBX36qGh0wNDrjv3mY5aKg7Q/NzVhWkaJrGEGGR5SOuJT1lgFLiPS+RAJz9TB
         MnvSKJELINAnf0cTIartRfDAr1N/U1FXVgBlELa6emH8pjXH8c7T9eFEZB/X5fySZq2I
         wcedaAeYJVVebGe6OcycVcRbgvS+IgifdrD1Ex2qPcNpsNwGujcDh0a7+fTvh7I/XUhd
         QtbA==
X-Gm-Message-State: AOAM531xFnvcbrTHiSe4Qo7vhuCAkxNhzHuWjly6CgFJGa0ZxTv+cY7w
        N/c6ERlnVKMOj2WbkyWCIk+mwOHCE9o5aA==
X-Google-Smtp-Source: ABdhPJx8uZ6KLSWLiaVTzdcF+CbRkbzecbW/I0NEw5CCcQQmsWp9AEHqNOuk2nEze21vyoYUbNF4iA==
X-Received: by 2002:a02:6a55:: with SMTP id m21mr8501409jaf.74.1630073423420;
        Fri, 27 Aug 2021 07:10:23 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id g11sm3457252iom.46.2021.08.27.07.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 07:10:23 -0700 (PDT)
To:     linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: Wanted: CDROM maintainer
Message-ID: <22d59432-1b8e-0125-96e9-51b041fe3536@kernel.dk>
Date:   Fri, 27 Aug 2021 08:10:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Back in 1998, if I recall correctly, Erik Andersen posted on lkml that
he was looking for someone to take over development and maintainership
of the cdrom drivers. I responded to that, and ended up maintaining and
continuing the development of that part of the kernel. Outside of
working on that part of the stack, it eventually led to diving further
down the rabbit hole and into the general block IO stack. In many ways,
it kick started by career in kernel development.

These days I've got a lot on my plate, and areas like cdrom have been
neglected as a result. This obviously isn't an area of hot development
these days, but even so it still needs someone that cares for the code
and is available to review and merge patches in a timely fashion. I
haven't been able to do so for quite a while.

In the spirit of passing on the baton, I think we're way overdue for
some new blood in this area. With the recent removal of the old parallel
IDE code, the old atapi cdrom driver is gone. Hence there are really two
parts to this these days:

1) drivers/scsi/sr.c - the SCSI cdrom driver. My suggestion would be to
   fold this in with general SCSI maintainership, as that's really where
   that belongs.

2) drivers/cdrom/cdrom.c - the uniform cdrom layer. This is really the
   meat of it. sr is a consumer, and so is the paride cdrom driver and
   the sega dreamcast cdrom driver.

If you have any interest and experience with cdrom/dvd and mmc/atapi, I
would love to hear from you. Let's find a new good home for this code.

-- 
Jens Axboe

