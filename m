Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DD14324E2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 19:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbhJRRXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 13:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbhJRRXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 13:23:02 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD43C061745
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 10:20:51 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id m20so17128036iol.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 10:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ONRNJRbuBfiJ3JCw8oKU8k4CkuwpYwt18lfZltRmdP4=;
        b=YehyEKALmpCemjfxK9PJn3PQOUoqQ1BEpOKWwSSRVVgNv3wik+5CxUxn4egxpjOVhU
         6qDLqc08mJ25J1ImWrcjrjGhNTO5+E0WFHVX3jaBaypJ++utAlCeTdYttdpzQATEG9dQ
         KosZRmLLqhJTGI8ek3JnatQMF6OJqscw4dr0T5IVCNYDnhG4XYpgIGo/i3NPY1mPsc1X
         spUR1bH5iCXuK3sHX5wPGmGiGtiaKiSfnybmO5pxOGkd1Kf8LFDzWCL6ktahWgue6QyE
         FJs3p8nRVy44SSwoW1z5elY50pfiE+9ykXqPT1+dmqy6JHMd+UVUnvGyVgNsF2qA3o+h
         jWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ONRNJRbuBfiJ3JCw8oKU8k4CkuwpYwt18lfZltRmdP4=;
        b=RWG7R1+7RAlDrVCLrIR8mZv/Gk8aShz4EP9spIh5ilX5TJbgdsV18AGGNCd1RqD9uU
         FNeaH0ZteU3jGZTvOmmeF9xbNTmlE4cNu7HzZH0Ka9K/eRNyvNhQ/vdBlUa0+38YVu0o
         gLSYh3C5J7PWNL0FFp9NAwnhGJ6VdYr22xkP6bCPPa3T84ba1ZaC0gVybEQyNpXRw8O6
         2ejPlxHZVCPRte7CSUnZ0WvrPs3MVTW3/uS7smd7RWX5cvfMndhMqPHEOK3gVZ5mQuOK
         HVoGQ2kDP8UKFFGwExIm/Qat/KL6xk7rKyCMuUAOzBkxDI07LED1Eot7EkdPES12Qcv+
         9qtw==
X-Gm-Message-State: AOAM532QvF22FfTFtJPOcM7lrab3cu9nzsDNIaaLPRhmYL0ae/i1Fn85
        bnpXFWkYbNtVVCG84wmAu49m8w==
X-Google-Smtp-Source: ABdhPJxJpFsGzvUO0vaFr3szQ8U4IzY7lRLrQYfilJHwTw/2XVCnembT2uWtYpWbB0NcyjBml3aCYw==
X-Received: by 2002:a05:6602:199:: with SMTP id m25mr15223847ioo.173.1634577650669;
        Mon, 18 Oct 2021 10:20:50 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b7sm7105844ilq.65.2021.10.18.10.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 10:20:50 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@infradead.org, sunhao.th@gmail.com, hch@lst.de,
        willy@infradead.org, Zqiang <qiang.zhang1211@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: fix incorrect references to disk objects
Date:   Mon, 18 Oct 2021 11:20:48 -0600
Message-Id: <163457764524.392122.9390950005139028238.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211018103422.2043-1-qiang.zhang1211@gmail.com>
References: <20211018103422.2043-1-qiang.zhang1211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021 18:34:22 +0800, Zqiang wrote:
> When adding partitions to the disk, the reference count of the disk
> object is increased. then alloc partition device and called
> device_add(), if the device_add() return error, the reference
> count of the disk object will be reduced twice, at put_device(pdev)
> and put_disk(disk). this leads to the end of the object's life cycle
> prematurely, and trigger following calltrace.
> 
> [...]

Applied, thanks!

[1/1] block: fix incorrect references to disk objects
      commit: 9fbfabfda25d8774c5a08634fdd2da000a924890

Best regards,
-- 
Jens Axboe


