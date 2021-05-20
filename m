Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9003538AF1F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243148AbhETMvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242844AbhETMvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:51:08 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA853C05BD06
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:13:57 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id z130so9048236wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HefggEHf7zIqO68mLmuGAWftWOR6tbdm8bqGl0kS8s8=;
        b=qWBghSDtDiiyBXXGtYCY4r3qbtUj/h5c+L8ZmGK/v+RT1MtsLLWekGZ2gVxQo/O90/
         1P+v/5hPbipkz2mjiD6z+kLQW4X65aNfS5oFItxMZtdMQmBSSbT2bVCdhQVysMQxbpbb
         NEux7V4hFDGUFtt8qX4mK0Uf2K9gtsAU8e7phTzjAwqW+eBVWQrfSf2C0HEhlr0BPPPw
         3/SYVYakzWyD/apTGqbvHT2V1U7UgbnPl2BPgTXX8CfIEhwjb7l+9dN+n2IlaDhE8DbE
         UfpRKyxtOtLzX1nuDXEaZ5+tz9X32asu+TzaP7z7hfrioO2E7NtF/7XEqTVwIOKMMboM
         2T0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HefggEHf7zIqO68mLmuGAWftWOR6tbdm8bqGl0kS8s8=;
        b=H/GU2D3jZeZGNo8wjutZNe1s/rPsMuHYtLNoXuORmFfcxqWob8OmYwnqUimIagv4+5
         Eft2cmAKIyNXG8pKDsffl9rXuG1nsrLFD7vaT/Xcevyk5Y8HJKoctNrKOmb7leV08IqQ
         j4Rn1uNRIfYJnSEEoACZpAIyJrTP92hIEyFVvxvGmzyIwEIQckkiikhDL8/abx2kRpvt
         tEBsHhclFQ9vf8rmKpY6pu9ZFfwlHwx/u5W0OyJRAwxFWIyDbWmJ4AWBFkfdHRnzp9mY
         GdursUlhrvvvUPhWqmYMGO/2HJ8qwjmR57nrMJhYeiqWsPcSpZsyFnVQ0NYch5OCorh+
         Agtw==
X-Gm-Message-State: AOAM533+BlH6BhLqLWtxWFfjZevaiVBisdIbpSwOr2W7Fc/TMyNf82V/
        AdhA9bhp4UxSGw/g9YOPf8l/dg==
X-Google-Smtp-Source: ABdhPJyFvkAv5u0Kd6rsBDj7OrAeglbpdcrcFpKPGnPPkVXvu0BUAHHRKoLsR6uq6DzrowAayYSlWg==
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr2585626wmg.146.1621512836453;
        Thu, 20 May 2021 05:13:56 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id 61sm3393704wrm.52.2021.05.20.05.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:13:56 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "cs.c" <support.linux@omnikey.com>
Subject: [PATCH 01/16] char: pcmcia: cm4000_cs: Remove unused variable 'tmp'
Date:   Thu, 20 May 2021 13:13:32 +0100
Message-Id: <20210520121347.3467794-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121347.3467794-1-lee.jones@linaro.org>
References: <20210520121347.3467794-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/char/pcmcia/cm4000_cs.c: In function ‘cmm_write’:
 drivers/char/pcmcia/cm4000_cs.c:1053:16: warning: variable ‘tmp’ set but not used [-Wunused-but-set-variable]

Cc: Harald Welte <laforge@gnumonks.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "cs.c" <support.linux@omnikey.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/char/pcmcia/cm4000_cs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index 89681f07bc787..9ec25735425d6 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -1050,7 +1050,6 @@ static ssize_t cmm_write(struct file *filp, const char __user *buf,
 	struct cm4000_dev *dev = filp->private_data;
 	unsigned int iobase = dev->p_dev->resource[0]->start;
 	unsigned short s;
-	unsigned char tmp;
 	unsigned char infolen;
 	unsigned char sendT0;
 	unsigned short nsend;
@@ -1148,7 +1147,7 @@ static ssize_t cmm_write(struct file *filp, const char __user *buf,
 	set_cardparameter(dev);
 
 	/* dummy read, reset flag procedure received */
-	tmp = inb(REG_FLAGS1(iobase));
+	inb(REG_FLAGS1(iobase));
 
 	dev->flags1 = 0x20	/* T_Active */
 	    | (sendT0)
-- 
2.31.1

