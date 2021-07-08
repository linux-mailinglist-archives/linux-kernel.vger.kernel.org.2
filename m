Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98433C18A1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 19:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhGHRvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 13:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhGHRvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 13:51:09 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B5EC06175F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 10:48:26 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b18so6495806qkc.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 10:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cpa3y006zKcQ4B4rroTm1HtUkWv/v/BjCMFz89RLVQg=;
        b=0MZ0APYfC9ELcGl7AvgIgdc1/tjNSqnNyNCzOqO3+b/lSkqNVNPFuQ9V8X8cPVN1SS
         Wj4QqmvKrOkbuK59711k3CyLWcdeiSlcqF3GLplLK9OXVon3sggzCQHQeTrTrnHTqHy5
         7+BJKcxlookt8/y2a8Bi8fizooY83i5nqmOTlfPXMIXxhDb6t7eSHvY2XK5F9HTJDcup
         DQ6mQTKLFYawjiOtlyaGFN2VLIkzJx4liO/kvCyTgKezg1VO6VlRNuNbQYK4f6A/UC08
         wyUFml9dIRBERDSrtv6hoOWJDF7vf4vVptj68kypERezDvYFhwWQS8emhiWtPInPvgwV
         eTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Cpa3y006zKcQ4B4rroTm1HtUkWv/v/BjCMFz89RLVQg=;
        b=oEgtOLzaQxrWLZaI9xWaAp6UG3ylHLU8T3nR/wF45OE3FRyxphNIJBIXirglBiIak9
         XdIYmGxhQglfAnhQ7TS5hOtRDCPH9B5N339y8Ly54xqPJo3R5WjCs1qOSi7plBDVE85J
         ekUXVTBNyIpdBMkxqeaJXlNAS8+ZoQZY2UQrcXfLrDonsEqWFRZ8a4jgWen5D3EEZbY/
         llJCtCwb70av/IN82eZ4FYE6tCE5k8DnIwiNg9ygrQ74a8jeWI7nFpPvtixpSteXqYgr
         t1Af62RxWkQibDPaAcoDNLgAB/SVWZj9NhWO/4gI0GWi2qcBVVlBM/9fxpiMeWZjWCxz
         eNig==
X-Gm-Message-State: AOAM530M1hjuo5CUcenSshYEkbNp90yAX3dvVXpPYMaZ1+HdGGMREfCt
        C7DC1wiBIsOyBECIOWFzUK/XNg==
X-Google-Smtp-Source: ABdhPJwLAfSqQ3PbvL4Vd4UqFTU4Ks40vdLtYuIGYRthvSUsGnJZKLYe1pBUNobIAnfy2Wei9fyvJQ==
X-Received: by 2002:a37:bbc7:: with SMTP id l190mr33282286qkf.424.1625766505969;
        Thu, 08 Jul 2021 10:48:25 -0700 (PDT)
Received: from iron-maiden.localnet ([50.225.136.98])
        by smtp.gmail.com with ESMTPSA id a201sm1250616qkc.46.2021.07.08.10.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 10:48:25 -0700 (PDT)
From:   Carlos Bilbao <bilbao@vt.edu>
To:     davem@davemloft.net, Joe Perches <joe@perches.com>
Cc:     kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch,
        gregkh@linuxfoundation.org
Subject: [PATCH net-next v2] drivers: ethernet: tulip: Fix indentation of printk
Date:   Thu, 08 Jul 2021 13:48:24 -0400
Message-ID: <4352381.cEBGB3zze1@iron-maiden>
Organization: Virginia Tech
In-Reply-To: <ccf9f07a72c911652d24ceb6c6e925f834f1d338.camel@perches.com>
References: <1884900.usQuhbGJ8B@iron-maiden> <5183009.Sb9uPGUboI@iron-maiden> <ccf9f07a72c911652d24ceb6c6e925f834f1d338.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix indentation of printk that starts at the beginning of the line and does
not have a KERN_<LEVEL>.

Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
---
 drivers/net/ethernet/dec/tulip/de4x5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/dec/tulip/de4x5.c b/drivers/net/ethernet/dec/tulip/de4x5.c
index b125d7faefdf..0d8ddfdd5c09 100644
--- a/drivers/net/ethernet/dec/tulip/de4x5.c
+++ b/drivers/net/ethernet/dec/tulip/de4x5.c
@@ -3169,7 +3169,7 @@ dc2114x_autoconf(struct net_device *dev)
 
     default:
 	lp->tcount++;
-printk("Huh?: media:%02x\n", lp->media);
+	printk(KERN_NOTICE "Huh?: media:%02x\n", lp->media);
 	lp->media = INIT;
 	break;
     }
-- 
2.25.1



