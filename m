Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438C63C251A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 15:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhGINpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 09:45:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53618 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231704AbhGINp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 09:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625838165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=spNjQtptlEVcvrozmGO/HwieAqlxhlgOeqNnoaP4BpY=;
        b=Tdog0RHJg9yXq4pyHOpmw7wnLh4e8au/BLYmvKGO+d5mFsZlnyq7z9HQTbHsWOXMu4ADVU
        LRdEhjdgFmbeuS69gzt0apKVHgk9CYtQ5JaG1+liSrn7bgFG2aIbPehoQloFynMabQuTho
        vfy6bf+OJXIWPJMpIASOjjts4nw6g7o=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-DZDRDSGRONGrCPMUGXsFAw-1; Fri, 09 Jul 2021 09:42:44 -0400
X-MC-Unique: DZDRDSGRONGrCPMUGXsFAw-1
Received: by mail-oo1-f69.google.com with SMTP id o186-20020a4a2cc30000b029025bea4a7246so2748375ooo.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 06:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=spNjQtptlEVcvrozmGO/HwieAqlxhlgOeqNnoaP4BpY=;
        b=HNjxtXs3YE3Z4a5GoMiCPgwLdeuQxMigc8XTAScEHJj3FV4qFwHBBmq4XUGHf3o4Tt
         CGMYhp3ekZBdPxND3tH4nw/Z7lqXsRqWyMTyfxyHCdwIsaNkgU0F5YLI2wf7rJpXiabE
         6r0R/7ZqaOhQklYhdPHs384pjE2BZLtmUqdZAzQd3db0/bXrNaUAwW1ha1bkWKxnn5Rb
         ihFaCvFhSOpLnuTURYQJ/DcMyxCSGJOhS5D67oEIeyixrgQB9Ufi4LEygNQI/uucY9+z
         Hmjdl0lxrkrBCpOl0KWmvgWFDfw1gEFPrsSCKmLVaaU5dmU4sDVkgJmpfzMrH4huzHqN
         lfwg==
X-Gm-Message-State: AOAM5309q0LW2JYflFkvFYSWsRbo1xk5DKcf2sropzFCfrLc9YtITgwL
        jy97tMadRg9IZAmAJlVxeo5smUwa4n/M/CS8kFsaI/fs1mY/Vv01/7WMKcp0fIpGaf9/D6dMKnZ
        61Z79Qo1W4JU7OxOpmKnr7YkE
X-Received: by 2002:a05:6808:1309:: with SMTP id y9mr8090798oiv.112.1625838163813;
        Fri, 09 Jul 2021 06:42:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/AJPAkUCZeXsxN5RuvbhEljezHAASCYfU2JIHa1+Afjzzn229yEybXEiXgtKE1cfhbxzfzw==
X-Received: by 2002:a05:6808:1309:: with SMTP id y9mr8090778oiv.112.1625838163596;
        Fri, 09 Jul 2021 06:42:43 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j23sm1215948oie.9.2021.07.09.06.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 06:42:43 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, corbet@lwn.net, hao.wu@intel.com
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 0/4] fpga: fpga-mgr: move compat_id from fpga_mgr to dfl
Date:   Fri,  9 Jul 2021 06:42:24 -0700
Message-Id: <20210709134229.2510349-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A followup to
https://lore.kernel.org/linux-fpga/aa06a7ca-eff3-5c0d-f3b0-f1d9ddb74526@redhat.com/
The current storing of compat_id in fpga_manager is dfl specific.
This makes the refactoring of the release()'s complicated because there
is a dfl specific flavor of register().

Keeping the compat_id sysfs abi, each implementation through the new
compat_id_show() fpga_region op can print out whatever value they need
to the sysfs.  Currently only dfl does.

Since there are now two ops for fpga_region, give fpga_region its
own ops table.  Add a wrapper for get_bridges().

Changes from
v1
  Completely written to keep sysfs abi

Tom Rix (4):
  fpga: region: introduce fpga_region_ops
  fpga: region: introduce compat_id_show op
  fpga: dfl: implement the compat_id_show region op
  fpga: remove compat_id from fpga_manager and fpga_region

 Documentation/driver-api/fpga/fpga-region.rst |  6 ++-
 drivers/fpga/dfl-fme-mgr.c                    | 23 ++++++-----
 drivers/fpga/dfl-fme-pr.c                     |  2 +-
 drivers/fpga/dfl-fme-region.c                 | 21 +++++++++-
 drivers/fpga/dfl.h                            | 14 +++++++
 drivers/fpga/fpga-region.c                    | 40 ++++++++++---------
 drivers/fpga/of-fpga-region.c                 |  6 ++-
 include/linux/fpga/fpga-mgr.h                 | 13 ------
 include/linux/fpga/fpga-region.h              | 26 +++++++++---
 9 files changed, 99 insertions(+), 52 deletions(-)

-- 
2.26.3

