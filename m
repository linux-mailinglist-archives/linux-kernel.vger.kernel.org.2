Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E6333C73F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 20:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbhCOT6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 15:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbhCOT6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 15:58:38 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0443C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 12:58:37 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id b130so32945007qkc.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 12:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VK5S+oSgiV0TZNNcHVL0AldOZUISji+pEY94URSguVg=;
        b=dvK5DJv4JP3JHtuV36BZYzPrDZfs70qvAKpcfAQJpzw1FsITXe53QTlWt3G+dSDT49
         b5W8G5J32MF8Sr4TsyjChslhch1VRsGFCUASxC1QxyeBjPKqtFRx5bGsfJr96oD0Z93i
         l3WyHNFglk6eAaEWRiwpBmCGG+ap4INLoNIkvo0SslP8uzclu5TuoFx78sM7BQcmpdj7
         bGlrlS203GqsXm9tfl1uYAdD4J9VOYLMtWwF/oMinQ+1xZ3i4D0uh5MdwIa0PHPufo6A
         GG4nwDFemYQt9nDj8qR9s38L9vb32i5K5rCW2rzFWr7/YVJaZfJkj8QTVQ0MDX3OUATA
         D7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VK5S+oSgiV0TZNNcHVL0AldOZUISji+pEY94URSguVg=;
        b=fmTSwTaggndoAepfmaxlDkgPj5AbF757zaRfPfVu6zJj/diH+e2tIJRmcmjoz8zu7/
         b6qu0kw/d5sty88DZ+tkw6UwpHOEzw/uqe4FDIrt5UZK0YajyvcEkxM7eobJARm0G8ND
         e0GON8Rw0TDnHpcOvnWo5z/PGKjlbpbFbp/FY7S2T56FWD218qEwDilrbAOIyNVOXqTp
         CJKqxfk6aikB6sB33SU7KPbLiV3xAWV8HFCLn2JUjaa1TB5pacO6TitFWcT6bQlR+Jme
         NXqlbnNss4CYaU1daO9cPi92O/H6DhZfB/FFldFgKX5tLjdYKTBtLaJRRumPBrWCw8Hc
         U+EA==
X-Gm-Message-State: AOAM533wsK4P3uRFC+z48WWmICIro4WFGQPusIpgOTgDsq/9g9xkhhD5
        G8D7JY1Oe6LP9fqvKCgt0jY=
X-Google-Smtp-Source: ABdhPJzth58/vJKgaljjF5AMmE7St+2w6/erB2To+UsmQYc4C4qn8ac0UG7MJdxSTUVFgJzMpzWWHw==
X-Received: by 2002:a05:620a:164c:: with SMTP id c12mr28462667qko.285.1615838316923;
        Mon, 15 Mar 2021 12:58:36 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:74e5:7488:fd7b:4bf2])
        by smtp.googlemail.com with ESMTPSA id z6sm11706877qtv.69.2021.03.15.12.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 12:58:36 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Tong Zhang <ztong0001@gmail.com>
Subject: [PATCH v2] staging: comedi: cb_pcidas64: fix request_irq() warn
Date:   Mon, 15 Mar 2021 15:58:12 -0400
Message-Id: <20210315195814.4692-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <858341a6-c105-1440-aa4d-ea0217f2ec89@mev.co.uk>
References: <858341a6-c105-1440-aa4d-ea0217f2ec89@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() wont accept a name which contains slash so we need to
repalce it with something else -- otherwise it will trigger a warning
and the entry in /proc/irq/ will not be created
since the .name might be used by userspace and we don't want to break
userspace, so we are changing the parameters passed to request_irq()

[    1.565966] name 'pci-das6402/16'
[    1.566149] WARNING: CPU: 0 PID: 184 at fs/proc/generic.c:180 __xlate_proc_name+0x93/0xb0
[    1.568923] RIP: 0010:__xlate_proc_name+0x93/0xb0
[    1.574200] Call Trace:
[    1.574722]  proc_mkdir+0x18/0x20
[    1.576629]  request_threaded_irq+0xfe/0x160
[    1.576859]  auto_attach+0x60a/0xc40 [cb_pcidas64]

Suggested-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
v2: revert changes to .name field so that we dont break userspace

 drivers/staging/comedi/drivers/cb_pcidas64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/cb_pcidas64.c b/drivers/staging/comedi/drivers/cb_pcidas64.c
index fa987bb0e7cd..6d3ba399a7f0 100644
--- a/drivers/staging/comedi/drivers/cb_pcidas64.c
+++ b/drivers/staging/comedi/drivers/cb_pcidas64.c
@@ -4035,7 +4035,7 @@ static int auto_attach(struct comedi_device *dev,
 	init_stc_registers(dev);
 
 	retval = request_irq(pcidev->irq, handle_interrupt, IRQF_SHARED,
-			     dev->board_name, dev);
+			     "cb_pcidas64", dev);
 	if (retval) {
 		dev_dbg(dev->class_dev, "unable to allocate irq %u\n",
 			pcidev->irq);
-- 
2.25.1

