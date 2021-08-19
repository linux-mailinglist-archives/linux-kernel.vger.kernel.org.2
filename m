Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882833F1065
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 04:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbhHSCbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 22:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbhHSCa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 22:30:59 -0400
Received: from mail-vs1-xe62.google.com (mail-vs1-xe62.google.com [IPv6:2607:f8b0:4864:20::e62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90F8C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 19:30:23 -0700 (PDT)
Received: by mail-vs1-xe62.google.com with SMTP id i1so3105193vsk.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 19:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:dkim-signature:from:to:cc:subject:date
         :message-id:in-reply-to:references:content-transfer-encoding;
        bh=hXzPmz8KLvpyfahmOwgomHUNy7g+maz+3agQaePxyqA=;
        b=aesI2HojxBjdY++lg5tCEGISHbRL/1N8mRkUqnZ0CuEe1o3HAmXgeHATdC9owtwDtb
         0Hlhjam4hUsfSEhu9aZccFzMEY/tWBeEC24J340JwvInyy5a4qQFhCu+XRpZFI/Vy9V0
         w3nyygZlyW+B2RGk9eRa+eqvEZihxtmHCXNFLqb18Bp9nHx4KrZ1IVMPpUB3Uq8xSdAt
         o+m/lOIx2PAIsNrLY3Q+dBEELq375sTS/jEBenYJAYLKdlJFK/rB7GGaTp5ABpNrTM5v
         +awMjq+sfcPyDFQ3+1hEmOYnh/VrSkFJ/YsOO+0gFDeC9PVNJ91Y9+nfAs5jPXLJsRO8
         a4bg==
X-Gm-Message-State: AOAM532zNSCw9LdQs1gVIRz5CHnXlPddhlsJIfL+T8ksSKoDacuFJvAd
        yT0Bn7isiBJPGoOh723ApikXxmIYEYZ3WCZdlsGDadoXBlv4
X-Google-Smtp-Source: ABdhPJzsT6bfYYc2z+Zg4LsiBGP+To6x/VdfWMyQHDfVetJDkicisEmEOEuZHR6/hkeqxibggYBcpM3IjSOe
X-Received: by 2002:a67:ed1a:: with SMTP id l26mr11006950vsp.8.1629340223112;
        Wed, 18 Aug 2021 19:30:23 -0700 (PDT)
Received: from smtp.aristanetworks.com (mx.aristanetworks.com. [162.210.129.12])
        by smtp-relay.gmail.com with ESMTPS id t5sm407595vkb.1.2021.08.18.19.30.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Aug 2021 19:30:23 -0700 (PDT)
X-Relaying-Domain: arista.com
Received: from chmeee (unknown [10.95.69.61])
        by smtp.aristanetworks.com (Postfix) with ESMTPS id 3A4BF400D87;
        Wed, 18 Aug 2021 19:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1629340222;
        bh=hXzPmz8KLvpyfahmOwgomHUNy7g+maz+3agQaePxyqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=feTcApMsNLy4k5bb/bwmFxszjAJ4rcSxlKbZErEsyuTiw0nzwIUo6aBl4fVGsxJ/f
         rH+BQg0fHR51UIncdP2IVSt4iBFxln1JQuCAfNu0zz9SvSUDAis6CC9Mn1bUWEx96L
         JIzRMyxJZCPK6oho1oYp724oG1c821zbE8wB2Vs7LHjrEOkNllbMi2dDE5OBsYucpo
         zUKStkygyceN1UHhUY5i3TZHcErS3v4+rAXJo/7+BuQhbNCxfaO+VoX1YZcTeyp+qj
         3DznBOy7NhP77r6n03RR9KiF9bQFgfZyrF1zXbHmtP1FLYDS5es35Mswb3OLUS9DGN
         lb1Xtrck+soPw==
Received: from kevmitch by chmeee with local (Exim 4.94.2)
        (envelope-from <kevmitch@chmeee>)
        id 1mGXoy-002MCp-DP; Wed, 18 Aug 2021 19:30:20 -0700
From:   Kevin Mitchell <kevmitch@arista.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kevin Mitchell <kevmitch@arista.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] lkdtm: remove IDE_CORE_CP crashpoint
Date:   Wed, 18 Aug 2021 19:29:40 -0700
Message-Id: <20210819022940.561875-3-kevmitch@arista.com>
In-Reply-To: <20210819022940.561875-1-kevmitch@arista.com>
References: <20210819022940.561875-1-kevmitch@arista.com>
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the removal of the legacy IDE driver in kb7fb14d3ac63 ("ide: remove
the legacy ide driver"), this crashpoint no longer points to a valid
function.

Signed-off-by: Kevin Mitchell <kevmitch@arista.com>
---
 Documentation/fault-injection/provoke-crashes.rst | 3 +--
 drivers/misc/lkdtm/core.c                         | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/fault-injection/provoke-crashes.rst b/Documentation/fault-injection/provoke-crashes.rst
index 18de17354206..3abe84225613 100644
--- a/Documentation/fault-injection/provoke-crashes.rst
+++ b/Documentation/fault-injection/provoke-crashes.rst
@@ -29,8 +29,7 @@ recur_count
 cpoint_name
 	Where in the kernel to trigger the action. It can be
 	one of INT_HARDWARE_ENTRY, INT_HW_IRQ_EN, INT_TASKLET_ENTRY,
-	FS_DEVRW, MEM_SWAPOUT, TIMERADD, SCSI_QUEUE_RQ,
-	IDE_CORE_CP, or DIRECT
+	FS_DEVRW, MEM_SWAPOUT, TIMERADD, SCSI_QUEUE_RQ, or DIRECT.
 
 cpoint_type
 	Indicates the action to be taken on hitting the crash point.
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 016cb0b150fc..e50e7bfc4674 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -83,7 +83,6 @@ static struct crashpoint crashpoints[] = {
 	CRASHPOINT("MEM_SWAPOUT",	 "shrink_inactive_list"),
 	CRASHPOINT("TIMERADD",		 "hrtimer_start"),
 	CRASHPOINT("SCSI_QUEUE_RQ",	 "scsi_queue_rq"),
-	CRASHPOINT("IDE_CORE_CP",	 "generic_ide_ioctl"),
 #endif
 };
 
-- 
2.32.0

