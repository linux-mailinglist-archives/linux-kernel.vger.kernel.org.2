Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7773B2033
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 20:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhFWS0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 14:26:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23926 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhFWS0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 14:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624472661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GrJNB3F5Xa+3Y8OXY7VwcTtiFdRpMIB1S8U9GBXw92s=;
        b=ZTi1HOZdEj0zI4aziqgNhdbPEd+nV67mxpcPrQw8WkQ/y1dQ48s8Wl4Ef9+wXh2vJcY+oX
        UJu01tI11QWJVnY6/Qfsooznuowvz8/mnK8iBrNTKCnfy3E/y0Z72yzZiF147LoM1BSWmZ
        WGxIv2Z/kjkgn/8PwGExsCF0pkaBenQ=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-wE1_-AYSPB-15jw6vkh9Ag-1; Wed, 23 Jun 2021 14:24:19 -0400
X-MC-Unique: wE1_-AYSPB-15jw6vkh9Ag-1
Received: by mail-oi1-f198.google.com with SMTP id w125-20020acac6830000b029021ecc100d7bso2265336oif.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 11:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GrJNB3F5Xa+3Y8OXY7VwcTtiFdRpMIB1S8U9GBXw92s=;
        b=ZcOha/WXYebgt2Izy4qaXWgsA1t+SuXMl4Ah5gjqTvgwU5GLFw0Nv2YnIofDRzCJui
         MUHYZgeBGXK73p0MPABGtevKq76G19wG9k5651m4BtligEo8Y9WIizK1dugccj5knmBE
         1+nxyu2y3CBh09h/T35SDuW8qUDQ/FzpSg4KYNNeFbqDdNfwnHiCi0NXAxTdXmmLpDML
         OowqlnMlfXr5HWk9l+Pn9QUZgO9u55AxBzDjXTmcAI3OJsMP+2aoYM9LseqMOXSuJuEt
         8niWN2gMgNttmCFOIXr9+5U+RXK4KuwwEBWrTe7SraxnTOXeOg/A77F4vmgUg4pFbfaS
         IEEQ==
X-Gm-Message-State: AOAM533YnXCfH0owlW8+K7EQao+Xr3h6q7G+JcXVzJPpXrSoMYycro7x
        hZ9ntnJ75lDZ/tjTE/CDyxojOGs2UUgACuHEQrjNuuyccsb44Q6wM9vBOXcaUi4ZhhDEyZkMMtS
        K6sXi2kX1J1Ns6F1dS7N9mXFY
X-Received: by 2002:a9d:1b4f:: with SMTP id l73mr1114572otl.21.1624472659095;
        Wed, 23 Jun 2021 11:24:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzg5ir0u+uONkcYSiNdhPznngImJRhHue1OFRj781vKuQhdCxHokiOVjGkujqp5MU0GiKAItw==
X-Received: by 2002:a9d:1b4f:: with SMTP id l73mr1114558otl.21.1624472658915;
        Wed, 23 Jun 2021 11:24:18 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l24sm105186oii.45.2021.06.23.11.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 11:24:18 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v3 0/7] wrappers for fpga_manager_ops
Date:   Wed, 23 Jun 2021 11:24:02 -0700
Message-Id: <20210623182410.3787784-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

As followup from
https://lore.kernel.org/linux-fpga/06301910-10a1-0e62-45a0-d28ab5a787ed@redhat.com/

Boards should not be required to have noop functions.
So improve or create fpga-mgr wrappers for the fpga_manager_ops.  
Remove the noop functions.
Refactor fpga-mgr to use the wrappers.

write_sg op was not wrapped on purpose.  Its checking / use in
fpga_mgr_buf_load_sg() did not warrant a wrapper.

Changes from

v1:
  commit subject,log

v2:
  rebase to next-20210623

Tom Rix (7):
  fpga-mgr: wrap the write_init() op
  fpga-mgr: make write_complete() op optional
  fpga-mgr: wrap the write() op
  fpga-mgr: wrap the status() op
  fpga-mgr: wrap the state() op
  fpga-mgr: wrap the fpga_remove() op
  fpga-mgr: collect wrappers and change to inline

 drivers/fpga/dfl-fme-mgr.c   |   6 ---
 drivers/fpga/fpga-mgr.c      | 102 +++++++++++++++++++++++------------
 drivers/fpga/stratix10-soc.c |   6 ---
 drivers/fpga/ts73xx-fpga.c   |   6 ---
 drivers/fpga/zynqmp-fpga.c   |   7 ---
 5 files changed, 67 insertions(+), 60 deletions(-)

-- 
2.26.3

