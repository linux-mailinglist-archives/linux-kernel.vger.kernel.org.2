Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC44430DDCA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbhBCPOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:14:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32672 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233715AbhBCPKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:10:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612364946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xFMItEJSGhts53dvXygZQoUFUOXT6QaMhCLIPm25nIk=;
        b=Be/i8IBrO989v131goNPgk2hCwBcUKDIQRQ/9Wc0JZWJuGTII36HOP85J0XIJOwBxRbFSw
        xXJ1OgmtL/ivgnHiX8ho6SBVAZl2LPB4N7MgtEuxsM7NJzdXlKJW1/bySXiHTx8tr4t+zs
        Vm6z7QvRQ74OCjtm4rWrGJoHJoFUVH0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-6Zpu9ZJaPjqjW2EBFuveiw-1; Wed, 03 Feb 2021 10:09:05 -0500
X-MC-Unique: 6Zpu9ZJaPjqjW2EBFuveiw-1
Received: by mail-qt1-f199.google.com with SMTP id 22so93126qty.14
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 07:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xFMItEJSGhts53dvXygZQoUFUOXT6QaMhCLIPm25nIk=;
        b=q/M7nzX/pzMfN6yD96gE/4lTBFsmRMaLdoI4GfiBGwxKIE2nBRVbcsU7c4ScAQLzrS
         dC4WG+w2jWVaFKdzjm+f331IgaH6eor9a59KBNRSy3zbcH9LANuFDR3uQ9RVAFL1zgyT
         2gVuXVROy+S4Wpi5gq0qCNhM6/R/8X0qZcZNQmkgSmgUh3ktfmIGakxyns0R0VpmFCam
         1cQB24EnhDY4oPI97BiaaYsvRbKDycp9dVJQAt4y9YQMci2FiVrIZJv0Ki1gxnTkIRZH
         D6aS1qvTSlSPidka46svC9ESMTRUW+xoQ1z0KtAUN/eVkqk6vUPYXVMD3IqTZ+uiDBSJ
         RmBQ==
X-Gm-Message-State: AOAM533AHvefngHIEX/cuc6qZgxklZjboekedrOow8sj1QA+QcYOmpuS
        IzBPGlnqRlG4sTrL5/6z+XEm8/kOZomsxhPRxM+lBMnF4jbAUqZxgyOQJEufCrDi7HOiDK0sbX3
        Ti6CSS+fFszwb+zMeytARl6DA
X-Received: by 2002:ac8:7153:: with SMTP id h19mr2941510qtp.118.1612364944479;
        Wed, 03 Feb 2021 07:09:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5+phXNK+dlLHtuYeQZ2ngf5pRTdq92YvDS3xG9FciVBeCOSMZA4rByWnMEoQ/zVwy3Jf9Mg==
X-Received: by 2002:ac8:7153:: with SMTP id h19mr2941489qtp.118.1612364944212;
        Wed, 03 Feb 2021 07:09:04 -0800 (PST)
Received: from loberhel7laptop ([2600:6c64:4e7f:cee0:ccad:a4ca:9a69:d8bc])
        by smtp.gmail.com with ESMTPSA id k14sm1479873qtj.40.2021.02.03.07.09.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 07:09:03 -0800 (PST)
Message-ID: <e7d2a8ddb28dcf4cf4395630d6d0b7a04d89e560.camel@redhat.com>
Subject: Re: [PATCH] block: recalculate segment count for multi-segment
 discard requests correctly
From:   Laurence Oberman <loberman@redhat.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        David Jeffery <djeffery@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 03 Feb 2021 10:08:58 -0500
In-Reply-To: <de50b6b8c867ec1f88df54f92134a99b086da8ac.camel@redhat.com>
References: <20210201164850.391332-1-djeffery@redhat.com>
         <20210202033343.GA165584@T590> <20210202204355.GA31803@redhat>
         <20210203023517.GA948998@T590>
         <BYAPR04MB4965222989DE60A2F198358286B49@BYAPR04MB4965.namprd04.prod.outlook.com>
         <de50b6b8c867ec1f88df54f92134a99b086da8ac.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-02-03 at 08:50 -0500, Laurence Oberman wrote:
> On Wed, 2021-02-03 at 03:15 +0000, Chaitanya Kulkarni wrote:
> > On 2/2/21 18:39, Ming Lei wrote:
> > > +		/* fall through */
> > >  	case REQ_OP_WRITE_ZEROES:
> > > -		return 0;
> > 
> > I don't think returning 1 for write-zeroes is right,
> > did you test this patch with write-zeores enabled controller with
> > the right fs that triggers this behavior ?
> > 
> > 
> 
> I tested the first iteration of the patch fully mounting an XFS file
> system with -o discard and creating and deleting files.
> That was our specific RHEL8 failure we were handling here with
> David's
> first submission.
> 
> I can test his most recent, I have not done that yet.
> Again, please follow up with exactly what you want based against
> David's patch and I can test that.
> 
> Regards
> Laurence 

So if I understand what it is you were wanting I will test this now.

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 808768f6b174..a9bd958c07c4 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -383,6 +383,13 @@ unsigned int blk_recalc_rq_segments(struct request
*rq)
        switch (bio_op(rq->bio)) {
        case REQ_OP_DISCARD:
        case REQ_OP_SECURE_ERASE:
+                if (queue_max_discard_segments(rq->q) > 1) {
+                        struct bio *bio = rq->bio;

+                        for_each_bio(bio)
+                                nr_phys_segs++;
+                        return nr_phys_segs;
+                }
+                /* fall through */
        case REQ_OP_WRITE_ZEROES:
                return 0;
        case REQ_OP_WRITE_SAME:

