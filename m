Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E556349BA1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 22:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhCYV1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 17:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhCYV1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 17:27:24 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD8FC061760
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:27:23 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id o27so4904296pgb.14
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VeqQSH4BAMfamuR0TIVDu2q/mURjw8ysmtF95aAYc5g=;
        b=iIB/QotjWVxSDIpkUJeHf+48IT7EqDCP7QaLJh6PM3Hv3F8UcFt/7c1mQhoByWDg5w
         B2UHGD+Tl9Jx/foLXk869SWCL5TI84wfOoQSFaRrWF8nQOV3EMqGDt+FmZ/tEnUhSPDn
         dgB6JKaUs1NSogJqeqWeQkD6m8ftwSRvlxURDFlo1NDdyLDvyE5DXiI5J53iDrAptWQS
         OV/7OVzexzU9nL3RGuwfSIuKvdbmnYl+8c2s29BlAUm6jjERXmfoRskDwEwnjldkUvM1
         2w/0N6UamJghZiBZyvA5CCsmECbqiSwczQZsiXPOHg+gUaSDmxCwJsP2uznjv7L2nkS5
         UwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VeqQSH4BAMfamuR0TIVDu2q/mURjw8ysmtF95aAYc5g=;
        b=L4BbEn57tLhZ3dPtihWfU206TmF+FQWgnhfmC6/JcxkE5akCyHPGGD5j6WrnUUycAp
         CcC+Prec+kBazwOUXRjJrUwvwsPs2vdgra9KeKTVGH9w6MswWhrZT5SSk485pncnVhT8
         2/6PkYescP3F0pmMMbzJeY4bhLQO7VHw9INzGfusk8jVtz+zuHEWboHbFplM9DsRqTVx
         J4rChOIIRJa4xLqyt2CaSOpKFOjBb4vPKr0S3qBWFpLFyVl/Vsuzob0zGOjuNGp+ILCh
         VM+nAiFkVtCUKUf5hJFLq0gbskrxMFqM9T/k+7ogOBfcr8F+nPjSm80Z9wWNgMXUA+Mz
         V1VA==
X-Gm-Message-State: AOAM532sC1lbpcoxojItZ5aiWqjNyzLoMyhmcjTruB/HVS+WxZqBkGnP
        EkU4UsRBC03MQIGRpsJgLFzQV/1JDJ0=
X-Google-Smtp-Source: ABdhPJx8aHEdvXlb3UgvsOScmw6EfBXxYY/yM5TkRR0f5jYmkvclrzvTBWVREz+Lt00OU3rQNPW32DXzrfk=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a63:c84a:: with SMTP id l10mr9146122pgi.159.1616707642540;
 Thu, 25 Mar 2021 14:27:22 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:26:09 +0000
In-Reply-To: <20210325212609.492188-1-satyat@google.com>
Message-Id: <20210325212609.492188-9-satyat@google.com>
Mime-Version: 1.0
References: <20210325212609.492188-1-satyat@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 8/8] block: add WARN() in bio_split() for sector alignment
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of sectors passed to bio_split() should be aligned to
bio_required_sector_alignment(). All callers (other than bounce.c) have
been updated to ensure this, so add a WARN() if the number of sectors is
not aligned. (bounce.c was not updated since it's legacy code that
won't interact with inline encryption).

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index 26b7f721cda8..cb348f134a15 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1458,6 +1458,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
 
 	BUG_ON(sectors <= 0);
 	BUG_ON(sectors >= bio_sectors(bio));
+	WARN_ON(!IS_ALIGNED(sectors, bio_required_sector_alignment(bio)));
 
 	/* Zone append commands cannot be split */
 	if (WARN_ON_ONCE(bio_op(bio) == REQ_OP_ZONE_APPEND))
-- 
2.31.0.291.g576ba9dcdaf-goog

