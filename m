Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2214D34014A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhCRIwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhCRIv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:51:56 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5603C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:51:55 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so4917570wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dghe4e16SoJZePTTMhtOr9zN57JVN2TBb3j+pyrYZnI=;
        b=Vjptvur9A8fg9s/eoxmP7Ulmub4Ep9QpudaaWLCAfYjedBY84hELNAPgRRZ0vclPGq
         bZYj1i5znJ3n1+qkMIS+7EWfc3TkaW8D4he2a11w6PdcXmVc6anyErtgCoZC0dXMY57c
         I5ZwJACiZW1UyCCQrQScKEmBEteBPtaucq4g4YQG40ePt4zrj59kUKQurTyik5BfsKUb
         nWWUGXlabTfxvGDadFuiPy8A5xGQmnBu9dNPBSEmRjvsKkEWakZM9WOYcIMFaWm8YSn5
         fHGD80Ey5Aa2d1C69g3PEKMMC2jqk1AkjJC4n05cvNn9xqqglh9wY+aUZZ8psBc2gh8b
         NiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dghe4e16SoJZePTTMhtOr9zN57JVN2TBb3j+pyrYZnI=;
        b=e8saIOAlWggu4nToLNyJaxi3BJo/DrD5pejxzASVaKZZCIHRZy56+xTjh7tkZFvSVN
         p94AJvviwfxoQHY8C0uBX2lUq5Xd191fzf9EEwiz+mksxNmWGJZCLo3gRcxZ56CxfwCD
         5hZwH5LLJ5CL4Vyph+NSeCZueETkgw/MSJsogwl6wXrYJiKueUAE2wqVCz5Ml3pn+CMj
         D5T4UR2mrri6DT8ipSH/TFgN5VaR68f5ZEvRKKS3wE4SryIaZNRZ+tKEP+hOEFfu+iju
         PgWBINbOB5hazkZganJ8YLcufYXn0fOdh+Im0NkzrgMwRJgYaKQG3/vnGL1dvv7oQfmj
         Tqqw==
X-Gm-Message-State: AOAM533nBVuJS6GqDxdFNdKZeqwb6O4E29HqL605MZc3p+qlzZ+ciZvR
        zezInKVbKXP8NNgkIVB53QXZHg==
X-Google-Smtp-Source: ABdhPJxV4SOmkvtOxdAg2Q9kzeDxw8pQQHQKkfLqG0n/47BzITWxw2YlmX/9vL/ntqDPgzeImTqpeA==
X-Received: by 2002:a05:600c:4f55:: with SMTP id m21mr2506388wmq.11.1616057514464;
        Thu, 18 Mar 2021 01:51:54 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:51:54 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andre Hedrick <andre@linux-ide.org>, Red Hat <alan@redhat.com>,
        linux-ide@vger.kernel.org
Subject: [PATCH 02/15] ata: pata_sil680: Add some missing function parameter docs
Date:   Thu, 18 Mar 2021 08:51:37 +0000
Message-Id: <20210318085150.3131936-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_sil680.c:68: warning: Function parameter or member 'adev' not described in 'sil680_seldev'
 drivers/ata/pata_sil680.c:254: warning: Function parameter or member 'try_mmio' not described in 'sil680_init_chip'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Red Hat <alan@redhat.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_sil680.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 7ab9aea3b6305..43215a664b960 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -57,6 +57,7 @@ static unsigned long sil680_selreg(struct ata_port *ap, int r)
 /**
  *	sil680_seldev		-	return register base
  *	@ap: ATA interface
+ *	@adev: ATA device
  *	@r: config offset
  *
  *	Turn a config register offset into the right address in PCI space
@@ -244,6 +245,7 @@ static struct ata_port_operations sil680_port_ops = {
 /**
  *	sil680_init_chip		-	chip setup
  *	@pdev: PCI device
+ *	@try_mmio: Indicates to caller whether MMIO should be attempted
  *
  *	Perform all the chip setup which must be done both when the device
  *	is powered up on boot and when we resume in case we resumed from RAM.
-- 
2.27.0

