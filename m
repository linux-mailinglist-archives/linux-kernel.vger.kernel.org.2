Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218873E86BA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 01:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbhHJXvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 19:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbhHJXvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:51:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5487C061798
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:50:52 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x12so334979wrr.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s+bMuS4HbgN+glrMlQoSd0LVvTGOtjG5gRbIUrhqhfo=;
        b=KcQsg6MBeDXHJtvOGXl0M+cHo2Wn35FjWDjLr0pknPf6TcX92rbT9UC3aW+YNcojas
         /S5ilm+c8n0X4keJfm2aOiYrjVIOYgQfsaEX9dtTjVhYQLaRC31tuVaei6Lhp9dohLip
         SoI9lUEk/a++Tk3d/L9oAXy6CMqNjUEVfY7cl2t6iwdkGJLEHn5YVYh6VGHwoMG4IzHZ
         q2pPgSW95zzfBzLMnxDS4qrr6yHPYTRMNICJXLhM26TLQzHWVFkzor0YCIegVwvqWW9p
         ObohON9pjcl4HkxlLrHUGFyXnarO9GassizWZ7o/QNj0iYPBErYbqQ6rFkMr/dA5fWkl
         gyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s+bMuS4HbgN+glrMlQoSd0LVvTGOtjG5gRbIUrhqhfo=;
        b=gugizJ8aA3Hh6kEPxOfokXrjrs5K0n20ecwcSW+fEXq9Hd9QZyC+kDKd+h35n4NJS6
         CYErH+cppd63jG0DaUUxc+LW/MxmyEK41EFvytBRP0Mo9gFI5agDdPf5xsWJGk2em0/m
         yH7Jm/fMmCOv4aQR3d0fFitSci/B+W+3Seb9ELrm2FErmXxQ22NdMJcvVjDrysWaI2xI
         3lXzk14Akpw46S7H6QcTF3HgjDEyeL0WWHcjrsSEIM69o2DFPdMoBbCXLFcLlRtXhC5Q
         RJLLFC0EHaTH1bW5sePqrzC2xKv9wHAJMzu/h7j3Qrdlc0yNMvGqFdAsks7L8UUkNKX/
         1AjQ==
X-Gm-Message-State: AOAM5309CEYAUskROBgnPcZrVQipOgPlnFBFMdvo+ExxvaKRfWPYPGvY
        r9AusQIO8CM0puevZSNqerehaQ==
X-Google-Smtp-Source: ABdhPJxVslqn6dltSqdxLcrvBvTFItD0DXs7WgjMTCXszRyG/1WlSp2MXZYsdmpw5KmAWDoAdDcsgg==
X-Received: by 2002:a5d:54c4:: with SMTP id x4mr12173137wrv.83.1628639451336;
        Tue, 10 Aug 2021 16:50:51 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id p14sm13881220wro.3.2021.08.10.16.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 16:50:50 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] staging: r8188eu: remove unused label from recv_indicatepkt_reorder
Date:   Wed, 11 Aug 2021 00:50:42 +0100
Message-Id: <20210810235047.177883-4-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810235047.177883-1-phil@philpotter.co.uk>
References: <20210810235047.177883-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused goto label from recv_indicatepkt_reorder function in
core/rtw_recv.c

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 08aea680312c..f0a042467386 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1801,8 +1801,6 @@ static int recv_indicatepkt_reorder(struct adapter *padapter, struct recv_frame
 		_cancel_timer_ex(&preorder_ctrl->reordering_ctrl_timer);
 	}
 
-_success_exit:
-
 	return _SUCCESS;
 
 _err_exit:
-- 
2.31.1

