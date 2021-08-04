Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC183E0AB5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 01:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbhHDXDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 19:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhHDXDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 19:03:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10603C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 16:03:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id p5so3989438wro.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 16:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j0ujdD2seOYmwOyOkYC6FtXby/xqiK1w3z/QJHZVeUo=;
        b=b/yEue82dvZSn3gcyiX3uZQu7tPbQS8/K2jzvz5ptSWWhySJhNvPbbl3oLTgzLskri
         ZvWwV9fb7UBtmb+NUhcue171Y3oRO727RnGcykXeSM0fnzFyJMwBNd6dvfMejgn2vyvz
         tS4cJ9OnuWL/+ZU+7NtA57xNWnlHkSYEpkGC3+5JdpQEtr9WOm2kB2VVt0FnuykD//TH
         wWSm5/SBlzmIPpYz59QH589mST7CTsL3OZy6N46dI87GGNb75dZZB4QPJwgoaI6KoN7x
         fmN6hraSDCZUtzgsp+YT+Qr1M81XttyalhCkrdTZeVSNRfRREFBRADAl3ZTq6Wfm2stT
         ln/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j0ujdD2seOYmwOyOkYC6FtXby/xqiK1w3z/QJHZVeUo=;
        b=t0DQ5YDnyZahm0+fqZLjxUzNDMn9EfYP/PuVdSoq5J2aSjCEuchBNrmcL/k10RiHLN
         rIWUyjRDw1seVkd+Y3xsP2B87PR6APWTctw1kEXJQRsH0zy1K0A5+3mbKbPRG7jYNA1x
         wDmnWonWBzHkKtSk/ZJVqKp78acTuXoqgQzAtYhbH80f+bpyOiGrV3y0cqmrh1Zon8Mn
         uZmzdYxXGRkVqA3UFgmksczs6omm2K+melNL9x4Tj0g5q5luO6TFvteQOPx84pwXZDXV
         9AAcF90+jHtoySMndz8Z7dQNJBUKoUL8fNXg4jyiTSoU/k1LhkpL0oJrJwgZKwYvBm5i
         ElzA==
X-Gm-Message-State: AOAM5311UGDzXjkuei8z7boP6T2dz47rqoUjiulkpKVoRC8amSLfkpCy
        S1rJjaHAIt6uudwf8WbUnb1wcb6YDAs=
X-Google-Smtp-Source: ABdhPJz62sxNK7jQA5m+oUk+0VWMNex02fpoeW+IFO8pLH/Mt4oh3B9Egvi207Qott+GfE6Yu3RNVQ==
X-Received: by 2002:adf:eb4a:: with SMTP id u10mr1565620wrn.11.1628118206706;
        Wed, 04 Aug 2021 16:03:26 -0700 (PDT)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id l5sm4553393wrc.90.2021.08.04.16.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 16:03:25 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH v2 0/2] Check for endpoints in fwnode->secondary more sensibly
Date:   Thu,  5 Aug 2021 00:03:11 +0100
Message-Id: <20210804230313.78238-1-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all

A while ago I patched fwnode_graph_get_endpoint_by_id() to check for endpoints
against fwnode->secondary if none was found against the primary. It's actually
better to do this in fwnode_graph_get_next_endpoint() instead, since that
function is called by fwnode_graph_get_endpoint_by_id() and also directly called
in a bunch of other places (primarily sensor drivers checking that they have
endpoints connected during probe). This small series just adds the equivalent
functionality to fwnode_graph_get_next_endpoint() and reverts the earlier
commit.

Thanks
Dan

Daniel Scally (2):
  device property: Check fwnode->secondary in
    fwnode_graph_get_next_endpoint()
  Revert "media: device property: Call fwnode_graph_get_endpoint_by_id()
    for fwnode->secondary"

 drivers/base/property.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

-- 
2.25.1

