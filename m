Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283253B0998
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhFVP4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbhFVP4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:56:15 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BC1C061756
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:53:58 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id o5so18807932iob.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uDOOz7CrZ9gkU8joR8mG9wvpIFsLuCmb5gkXvkTbNx4=;
        b=larp1gH6LLvQuhDjorYmFdNvfyPgcQIE25q0djLLAo5HQsbYLADB67Zyautet9o0Es
         L80lI8COTBYV/F3o05vyePkIqMcbGdz5mGK0bhhYkxIt4Igk3x+d2IB91OdZK//H3wHG
         2Bna/Pa/buAvxoSh0sGG0JjJ3Ny7HZvEpq7119IYxqcdz2pDfWIVdh6SZd/mI4GCeEGf
         mhssPhJ69pGcdfEKhCG6IVRmwRsYx9ByO7dbt8ByUvC+00albk9IUYMPwXntbQaPusIs
         yldFP2oZQL2+VZibRZ+Na7fhtSJU68gBfEdpyDI0hq0Xpvz7SnM5TyFLlELkd1pMZ2hB
         jxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uDOOz7CrZ9gkU8joR8mG9wvpIFsLuCmb5gkXvkTbNx4=;
        b=L71/h9C5nRaD7EvPj8MWRR+mq5XrMItVw2kJCrCvLRfIffXbJE+iLV6edDCHc2Btba
         J4a9PG5A+d2pzj95LePGRdOi6OB3oW1Iele2B33EdkahQG0Wlr0SLyUUrcHOmVkAeigp
         mea8Gb8Ix2K+eNB7W9kOgk/UUWNG5b6dBOd3uTcwjx+8kNRageARdk6hrGPh5sDfeTJ6
         1iiii7F5NymHW6qfTdybZbke4YhzvwJ63A6kBCLX0zVOjdgl/WEYOh4R6yjIXRwp3HgV
         X2HOyqKCFDHH1jW9aSkWY65NNa7QKCKk3PA2mNjeWMK4ZmXqyooySsYmlyGKjH8k/sxa
         16EQ==
X-Gm-Message-State: AOAM530cjBfsKLgd4WgBcXmChrtKcHgREndUpGfyoZ5JIJIxL/+9xtwO
        IDZowJHWdItrdNNq6CdByzQ=
X-Google-Smtp-Source: ABdhPJxf/6sMUiu2f9sZO3YdItnt3YwbpJrw0apYAO2E3TKoEaeSayspearG7gaJ/19Q9n0ZUBXsyg==
X-Received: by 2002:a02:5d0a:: with SMTP id w10mr4576618jaa.82.1624377237762;
        Tue, 22 Jun 2021 08:53:57 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id m13sm7965687iob.35.2021.06.22.08.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 08:53:57 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id BC31227C005A;
        Tue, 22 Jun 2021 11:53:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 22 Jun 2021 11:53:56 -0400
X-ME-Sender: <xms:lAfSYPSSbTZnmDHJhEzoYEws5t_Puyz-9HjYz3F33Omsn6s3sjJI3A>
    <xme:lAfSYAzmlPcddKvi2-KDdMsJdQyh_LBNy-tnZs0W4e5Es5oGO_ifcydNopsnsrIZL
    GyN_yrAJsNR07sZXg>
X-ME-Received: <xmr:lAfSYE0ThaMrEv2EpBu25HyWt422vJDyykPkgfSj3cvF0E8K6CxkP-zc36g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeguddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:lAfSYPDR3wTq2tuvN5p4fjSIosBpEE7dJLe9S7w-tG3Mznct4nO1Zw>
    <xmx:lAfSYIjHbQ-Lz8k9TQP-AvdbuBo_zKccITa0BenrFMVmvpPLgt9j2w>
    <xmx:lAfSYDrBSJWR6pmkK7Oy54jXPeM_VJ8AE5WAS6jh8nQiGk2IA37qJQ>
    <xmx:lAfSYEgLdLaCuWGLPdK5bCYSsjkRZpHknh5aU6CWeHdOCP2-_X9NOw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jun 2021 11:53:56 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC 1/2] irqchip/gic-v3-its: Free collections if its domain initialization fails
Date:   Tue, 22 Jun 2021 23:53:12 +0800
Message-Id: <20210622155313.3819952-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210622155313.3819952-1-boqun.feng@gmail.com>
References: <20210622155313.3819952-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ITS collections are allocated before its_init_domain() called in
its_init(), therefore if its_init_domain() fails, the collections need
to be freed. This fixes a potential memory leak.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 2e6923c2c8a8..1916ac5d6371 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2931,6 +2931,12 @@ static int its_alloc_collections(struct its_node *its)
 	return 0;
 }
 
+static void its_free_collections(struct its_node *its)
+{
+	if (its)
+		kfree(its->collections);
+}
+
 static struct page *its_allocate_pending_table(gfp_t gfp_flags)
 {
 	struct page *pend_page;
@@ -5090,7 +5096,7 @@ static int __init its_probe_one(struct resource *res,
 
 	err = its_init_domain(handle, its);
 	if (err)
-		goto out_free_tables;
+		goto out_free_collections;
 
 	raw_spin_lock(&its_lock);
 	list_add(&its->entry, &its_nodes);
@@ -5098,6 +5104,8 @@ static int __init its_probe_one(struct resource *res,
 
 	return 0;
 
+out_free_collections:
+	its_free_collections(its);
 out_free_tables:
 	its_free_tables(its);
 out_free_cmd:
-- 
2.30.2

