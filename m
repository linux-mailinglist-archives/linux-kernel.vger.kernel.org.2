Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBFC31A827
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 00:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhBLW54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 17:57:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47777 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231364AbhBLW5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 17:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613170537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=G72Pl8nG1WLDLDMTHNp9dVrAvZnBb4S9mwEK85oZBnU=;
        b=TDCDyD45f3h54IXcQ6jsT2Zh+ecWboRMwxOMKjTgEh9aU3eSxjucUh9lIEgje9adi9wRLc
        BObJuqfzDbwVzmv5Pj2IwTz/nypEes3xl/fGaW/2NapVS0szVanCS4I1T0TVhWj4z6uCti
        csMItH2IuiAl3c8cv+qN3DMSSYl/RNU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-Cf8JFmqTNkS5iaQ8kakvJQ-1; Fri, 12 Feb 2021 17:55:36 -0500
X-MC-Unique: Cf8JFmqTNkS5iaQ8kakvJQ-1
Received: by mail-qv1-f71.google.com with SMTP id d26so674399qve.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 14:55:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G72Pl8nG1WLDLDMTHNp9dVrAvZnBb4S9mwEK85oZBnU=;
        b=ltMxlkkHosUGYkp4ANtiAUwDd9X3VsBuAVEq0oHhTN9gJq3RarsA1JP59cGf7O3w3x
         oKshnhweZweb7gnvHc2wLpeOdZDmR14TtSMiRLZrL3wH3TnPgAtQp6vF7ioMunwqIRpp
         D073Yl8rakrfAXWugVl6J9bk40MxncZlumIjHhf3xtx//cxWvKUn22qHdsgTd+gH8nlY
         QulgUcx0WP2lTXZ2XL4SUZdRJWCN7d0FyVV0TuyaXBD82TAboFsxYHu2Peeu6W0Aip10
         ZR+3/V9GgT53LT187KIN3l7ljco1PBA4oswwRoeN56qMcTErH3gEFAxj6uf4dOdxVQzz
         xDvw==
X-Gm-Message-State: AOAM533NOINA/hW9prrq99CwIQu9OacclJojFBR5Db0FXiuVvJpPjUYR
        /cZr0QQrK3a8BSnAbPrZDmd576Tf1bvNfukihTTjSspgh2g0WV1jAnLz3cSAnV2lnkzBgyUa9Kk
        REAgmzDrTyjl+6alw+bXT9KNM2eVVM0qHYsL7PZ047q6aVSt2R7bl9dGtUJOmb+1NjDNGIDVIjg
        ==
X-Received: by 2002:a05:620a:6d7:: with SMTP id 23mr4804418qky.460.1613170535485;
        Fri, 12 Feb 2021 14:55:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwE+QsEbqcrRC9IoR3ljGZ6jq7YUJQ2UPD/pUUaZOGnETy33kOG0P09d6AUoAEKE5KsAUSAcA==
X-Received: by 2002:a05:620a:6d7:: with SMTP id 23mr4804404qky.460.1613170535223;
        Fri, 12 Feb 2021 14:55:35 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id x34sm5930438qtd.15.2021.02.12.14.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 14:55:34 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] docs: filesystem: Update smaps vm flag list to latest
Date:   Fri, 12 Feb 2021 17:55:33 -0500
Message-Id: <20210212225533.12589-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've missed a few documentation when adding new VM_* flags.  Add the missing
pieces so they'll be in sync now.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 Documentation/filesystems/proc.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 533c79e8d2cd..3296f940111c 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -538,7 +538,9 @@ encoded manner. The codes are the following:
     ac    area is accountable
     nr    swap space is not reserved for the area
     ht    area uses huge tlb pages
+    sf    synchronous page fault
     ar    architecture specific flag
+    wf    wipe on fork
     dd    do not include area into core dump
     sd    soft dirty flag
     mm    mixed map area
@@ -546,6 +548,9 @@ encoded manner. The codes are the following:
     nh    no huge page advise flag
     mg    mergable advise flag
     bt    arm64 BTI guarded page
+    mt    arm64 MTE tagged memory
+    um    userfaultfd missing tracking
+    uw    userfaultfd wr-protect tracking
     ==    =======================================
 
 Note that there is no guarantee that every flag and associated mnemonic will
-- 
2.26.2

