Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46563ABE67
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 23:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhFQV4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 17:56:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229816AbhFQV4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 17:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623966866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oq9kffVK8f1Sa0DR5BkzICWYZziNXpt3UUdoQe11Qgo=;
        b=eoXdI0Doe1X3nj+DfVRMLC4KKt4UtQ7EBGyZInytzstwosE4NnjK4yq6hKuOZaBIMTNhS2
        DbK6/zY5L6vZ1tS2dzcmgA4uXIGevfGk7fNNpI+5k57fK7jktb7GuKm5Joj1JPjq8NXDP0
        anbazkRqrcAO4zMJ4v+jJVpixoCZiec=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-UvrrMC2GPi218wC9aJUcXQ-1; Thu, 17 Jun 2021 17:54:25 -0400
X-MC-Unique: UvrrMC2GPi218wC9aJUcXQ-1
Received: by mail-oo1-f72.google.com with SMTP id n13-20020a4ae1cd0000b029024af40d0cc4so4673604oot.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 14:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oq9kffVK8f1Sa0DR5BkzICWYZziNXpt3UUdoQe11Qgo=;
        b=Mw+4YZe5bCAh0or+SEMRw5XEgvIjGCERmtZJzO0s5qX5HVeVub25T70VLC1de/L74P
         XAP4Il4RVcRoK6kgx6q47GvRUM28fuhOAwsMN9KsVbCwCteB638KGVUCVP6FMqFxg6Mq
         7rU9kaqK2VGHRl2YAxOVrJ4nxttUfF9/lzRA7334efr6ensoBpKiQpMZTNiKvM4g5UfL
         ZDEsA22LujoDcsiAOaPxfyS35fT6bHUv/mcdr3EPWuisBYAuxn830N/2uP8zpvmA8bl9
         qq9NKKaIY0azEEViN/hqWwaVvB+wfP3d3Udnk5XfgIfCtEkiOyqJqDRPzkC/9mqFk9Gg
         7HFw==
X-Gm-Message-State: AOAM530+all3huFsmYpT0dbiPaiLbsN/W3vDPpjkSoIdptWk4XjtNbdJ
        OdMAcaVCiUF9DFKsXOiMiML83bqmc/usngeTYPvUin1wXi9mc14DfC5A90rbZwPEGbYFe696hdK
        ZgxjGOFsV6Zo3KeQCOi4Z7RVG
X-Received: by 2002:aca:ab4c:: with SMTP id u73mr4958315oie.26.1623966864511;
        Thu, 17 Jun 2021 14:54:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo7BwMtFjeIYDSFNCTepqIb+7Z7yOe/HtmPkjlgbgsZe5nw6U0ZtyUF9gTPIhaoCEL7PLD9w==
X-Received: by 2002:aca:ab4c:: with SMTP id u73mr4958310oie.26.1623966864411;
        Thu, 17 Jun 2021 14:54:24 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q11sm1414494ooc.27.2021.06.17.14.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:54:24 -0700 (PDT)
From:   trix@redhat.com
To:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, kuba@kernel.org
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] ice: change return type of ice_ptp_request_ts() to s8
Date:   Thu, 17 Jun 2021 14:54:19 -0700
Message-Id: <20210617215419.3502075-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A gcc 10.3.1 compile error
ice_ptp.h:149:1: error: return type defaults to
  'int' [-Werror=return-type]
  149 | ice_ptp_request_ts(struct ice_ptp_tx *tx, ...
      | ^~~~~~~~~~~~~~~~~~

This stub's return needs to match the decl for
CONFIG_PTP_I588_CLOCK, which matches its use in
ice_txrt.c

Change the implicit int return to s8.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 41e14f98f0e66..d01507eba0364 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -145,7 +145,7 @@ static inline int ice_get_ptp_clock_index(struct ice_pf *pf)
 	return -1;
 }
 
-static inline
+static inline s8
 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb)
 {
 	return -1;
-- 
2.26.3

