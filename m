Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A8D397AF9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 22:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbhFAUHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 16:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbhFAUHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 16:07:13 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CD7C061756
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 13:05:27 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r1so256080pgk.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 13:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=unxYYUIJtzBYSX4MANGuQqbleLprmVLiT5PFu/4IgM8=;
        b=I4Y2WG6Fm0u56jprweWhvuUHM1OeSnYiQyyVI2kWvbTGhM22BtdsOkQBPkjs31huYB
         Mmzi/aCBh+wLAEaOlC30D+9T8IItdg638U/Poy1jQVG4vIMrqd8BLVayZfriNqFUWcoK
         KKhO7ietySBL41WRLIdm0WigKvuKY7tnkbb2lafcRFNZbvEQ5r8N3pzoBH/JPoX3Ux1R
         bpcyWADATVqSHOW07R3fQYLATcL1Tfsfeb4Ry3toczn+qmm4tgYpcLnmw3MtV+oJ2vHI
         fXqk6QJsgD7g04fmJW9t3TY/4eT4k167TNOJX05Q7kUErUl6ewk72PRaenwmnUS1x6+0
         Og5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=unxYYUIJtzBYSX4MANGuQqbleLprmVLiT5PFu/4IgM8=;
        b=BhNLeZwxmcnDeXma+LK9JyOatbkVjxrlaWJggV8wPjn3dnHnClNDy/kGFZf3r/S5DN
         um/KauORVf5ZlnpYQNmL0ew5Lot5ppd/1DF8lmmoPsLNyJk1aND2j4j/YpeeqshCwfvU
         CaUmOIYgqpxzhbWx82QtcYTaiqYlBIa7Zt7xkY2az/H/4ybGX4wQJHvFCt3TLcLhHpQx
         McMYpDgk25qweNOgHTM7oe/wrEJvnzEoSfrS2R4h/6LMLOZ8ZDl8IQfSdbQb99TqWQvs
         CCS/3UkMShZih+bXkowgpB9lJNzJUxEsIAd6mmMPrxZROJHuHX20v41vumTmWEYgbi22
         WTRA==
X-Gm-Message-State: AOAM5328P/6muE9KJ09EJq7QYSavV/OOOtzvKNXHQyv4NLolt9rel1tR
        Vjs5TJYSm8Cv4JgBHa/vi/8=
X-Google-Smtp-Source: ABdhPJwxegWvJ6SacBtxU7EltgrnbygfeJpMF1B4eYwaVNQ9R7wOaR6qDVUnnGdIsdi4HMskObkOyg==
X-Received: by 2002:a63:1559:: with SMTP id 25mr30519910pgv.384.1622577926897;
        Tue, 01 Jun 2021 13:05:26 -0700 (PDT)
Received: from ojas ([2405:204:130c:d068:69c0:20e2:ff2e:7df0])
        by smtp.gmail.com with ESMTPSA id z19sm2747045pjq.11.2021.06.01.13.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 13:05:26 -0700 (PDT)
Date:   Wed, 2 Jun 2021 01:35:13 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     nsaenz@kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        dan.carpenter@oracle.com, phil@raspberrypi.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: staging: vc04_services: Need suggestions on trying to fix sparse
 warning in vchiq_arm.c
Message-ID: <20210601200513.GA10204@ojas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I was trying to address the following TODO item in
"drivers/staging/vc04_services/interface/TODO" and would love some comments and
suggestions on this:

>  14) Clean up Sparse warnings from __user annotations. See
>  vchiq_irq_queue_bulk_tx_rx(). Ensure that the address of "&waiter->bulk_waiter"
>  is never disclosed to userspace.

More specifically, I was looking at ways to fix the following sparse warning:

	drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1001:26:

	warning: incorrect type in assignment (different address spaces)
	expected void *[assigned] userdata
	got void [noderef] __user *userdata

From my understanding, the issue seems to be that the (void *)userdata local
variable in vchiq_irq_queue_bulk_tx_rx() can be assigned a (void __user *) or a
(struct bulk_waiter *). This makes the assignment tricky since it can either be
a userspace pointer or a kernel pointer.

Right now, we are just ignoring the sparse warning which is essentially
resulting in the __user attribute being lost when we assign args->userdata to
userdata. This can be dangerous as it might result in illegal access of
userspace memory, without any sparse warning, down the line. 

Further, this issue seems to boil down to the fact that the (void *)userdata
field in struct vchiq_bulk (in vc04_services/interface/vchiq_arm/vchiq_core.h)
can, again, either be a (stuct bulk_waiter *) or a (void __user *). To fix this,
I was playing with the idea of modifying this userdata field of struct
vchiq_bulk to be something like the following:

	diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h 
	b/ drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h

	--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
	+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h

	@@ -227,10 +227,16 @@ enum vchiq_bulk_dir {
	 
	 typedef void (*vchiq_userdata_term)(void *userdata);
	 
	+struct vchiq_userdata_or_waiter {
	+		void __user *userdata;
	+		struct bulk_waiter *bulk_waiter;
	+               
	+};
	+
	 struct vchiq_bulk {
			short mode;
			short dir;
	-		void *userdata;
	+		struct vchiq_userdata_or_waiter *userdata_or_waiter;
			dma_addr_t data;
			int size;
			void *remote_data;

I was then planning on modifying all the code that works with
vchiq_bulk->userdata accordingly. I believe this can help us overcome the sparse
warnings, as well as preserve the __user attribute in cases when the userspace
pointer does get assigned here. 

However, since I'm not very familiar with the codebase, I just wanted to confirm
if this is an acceptable workaround and to make sure I'm not breaking anything
or overlooked anything here. I noticed that we also want to make sure that 
bulk_waiter's address is not exposed to userspace. Will it be possible to provide
some pointers on how/where this might happen, so I can see if I can try to extend 
this patch to avoid that.

I would love to hear you suggestions and thoughts on this.

PS: I'm new here so please do correct me incase I missed anything.

Regards,
Ojaswin
