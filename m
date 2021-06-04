Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA94439C0EE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 21:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhFDUBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 16:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhFDUBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 16:01:41 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66678C061767
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 12:59:41 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id k125-20020a3788830000b02903a65618d46cso7315278qkd.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 12:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iozWCMAtYKCt6ZARG1CR093QIL86BP6w5zG4UHfXEaY=;
        b=b/kMgaiP4rlyi9fuWXIOgNTdRw55igKDtzrELiZWocSzKWGap6DizpaWVP+Lfjm+ln
         /cPr3m1S2oel7iIXg+Fk1im2HQZ2fT67rNzIKydVKheLsJS5z0Sf8Z0B0XuEu3tiJKRF
         qIfcfJdTI5zlglUpYLUxdazXc+jaV+Mq6y5HSNYZwrQF+g9FE3xoes7rwLqulvdfgzg4
         xWn2ABcu9/h2szpHEjkSJlWQ3x7adfX2f/3z+4j8fq/yb4kHyqujPx1VhNW2EgQytzMK
         NiROUYq89hZBQ0UzVhNsA1gPWgP5kviimgtGgAwZgHSfdPSTtqeMZ3dQUNuD+625uC/d
         Y2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iozWCMAtYKCt6ZARG1CR093QIL86BP6w5zG4UHfXEaY=;
        b=rFO+roJA8SQxQ+x3fBsxLNkYOUycTr179b8eb4swhJ8kNz5NLd8Uo1tZrrzfFGXLBR
         sL8pA7RwpPFVtJzQhxROhgnauBQgrAiVLZgCEUhfAgxOOSWB6GyoaJLjx+l48jasYmrT
         sWcTjUzo6CEbOA+xN0NZN8aqkBCi3ADH0e50LQAmSZKHg9IevyAWgv8Y0JQ6AvRmfumR
         3VXOQuPXhBfH3eaQCcTyYyHWmlhsewXvoLcXtGlNwJmjb0JwzXe7KGKLdTA54ZKzBLrp
         Y6tVGlME0Oz315sLCrPGPzhoq30engS9ZuPYcOG0o4xG3URfv/BKWUf5on9gzXVEFwP2
         8t2w==
X-Gm-Message-State: AOAM532h0I7Mo+M2kHFt9CfyoMlc1zjR7jameutrXyfhdSHy+zm2TCPW
        96RaByz5tPLAa6FL1xoz4haPMd2Hrdk=
X-Google-Smtp-Source: ABdhPJxOCXfXppSqFV4bTzkHDML8kpyuDCPBL7nXZkg5gEUEj9B5DzrhhwOgM13tbDILoEWyZdZmaQq+gIs=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a05:6214:62a:: with SMTP id
 a10mr6531397qvx.5.1622836780529; Fri, 04 Jun 2021 12:59:40 -0700 (PDT)
Date:   Fri,  4 Jun 2021 19:59:00 +0000
In-Reply-To: <20210604195900.2096121-1-satyat@google.com>
Message-Id: <20210604195900.2096121-11-satyat@google.com>
Mime-Version: 1.0
References: <20210604195900.2096121-1-satyat@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 10/10] block: add WARN_ON_ONCE() to bio_split() for sector alignment
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
been updated to ensure this, so add a WARN_ON_ONCE() if the number of
sectors is not aligned. (bounce.c was not updated since it's legacy code -
any device that enables bounce buffering won't declare inline
encryption support, so bounce.c will never see a bio with an encryption
context).

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index 44205dfb6b60..32f75f31bb5c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1436,6 +1436,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
 
 	BUG_ON(sectors <= 0);
 	BUG_ON(sectors >= bio_sectors(bio));
+	WARN_ON_ONCE(!IS_ALIGNED(sectors, bio_required_sector_alignment(bio)));
 
 	/* Zone append commands cannot be split */
 	if (WARN_ON_ONCE(bio_op(bio) == REQ_OP_ZONE_APPEND))
-- 
2.32.0.rc1.229.g3e70b5a671-goog

