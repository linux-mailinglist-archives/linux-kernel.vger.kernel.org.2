Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED163A05C3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 23:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbhFHV0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 17:26:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60919 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234267AbhFHV0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 17:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623187451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V9tvOeij7irPdqtg/4eaarQWu4Ala2EOw38yDUGQMKE=;
        b=RLc+JhQaq9yO+Ymi8CEoEJGmtNgyCaJS1uQg3PAhQRXyF47JF/YT3VUFvMq0oGpvnjJuRe
        7R/Ti2pZ7BcGWKc+se/bzpDk21RUk3IVxU/dBPF/Tt656kHzPh5cpd9yImz+vV5lqMtWtD
        TBk6w3hYMNokMoUjcuY44ZxW12a1FF8=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-Q3Ec9OEePAy1LybFywCIOA-1; Tue, 08 Jun 2021 17:24:10 -0400
X-MC-Unique: Q3Ec9OEePAy1LybFywCIOA-1
Received: by mail-oi1-f199.google.com with SMTP id o10-20020a0568080bcab02901f44e2256b9so1900153oik.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 14:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V9tvOeij7irPdqtg/4eaarQWu4Ala2EOw38yDUGQMKE=;
        b=UMIEoJS2tBtQ3tErVDfpiPy1bNumXFjhF4LhGbgfnqo/U1Mkemm/cEe3u8Gu7RcfSj
         b/rb80DF6Y78OCA2qQUAhLyj1eQbzlfzkArRKdXPuD2eVKkiUFJ8y5IPolsA1rwy2Zy0
         l5lzP2YKOJmUq0Ew8W5OLYqGvjU9W1MzLHLL7iXLVQIOLSP95tDYV+mMJkSyy1zFl1l5
         A+XyxtXspPwnazB2RJTbKWiKrPcUztJok54Eqh0zV6U6hv/EPvsmUHIOFarKjL2aOaS7
         i+KGl522ND/PVMBn9Mz0i0IhG5UOUzJ6EE1j4w6lgza8Cpv7HU6D+U0bhSeaB1e1STt6
         ffQA==
X-Gm-Message-State: AOAM530F5Bsd558sxqiKn7lykdKPWpHmYcidTmuA6VYQbabEyR6daLe6
        o5nonJXGU0Ur+f3C0LggPMwpgipNZjXCDE+JXtJxu0CKg3LBH7jgoe027eEwd5VkjNftkwQd/Ff
        MDfoauG9osZzXqd3nGXJ4/0aM
X-Received: by 2002:a4a:ded3:: with SMTP id w19mr5293607oou.46.1623187449153;
        Tue, 08 Jun 2021 14:24:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUcRpoqPmXEA6scCuFTxzSHKgG4PG3qjyFY5xu7aC63DD0rnFJZyVbbKXaRqPE6V2Ub7Lciw==
X-Received: by 2002:a4a:ded3:: with SMTP id w19mr5293585oou.46.1623187448949;
        Tue, 08 Jun 2021 14:24:08 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x199sm1954310oif.5.2021.06.08.14.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 14:24:08 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, robh+dt@kernel.org, hao.wu@intel.com,
        corbet@lwn.net, fbarrat@linux.ibm.com, ajd@linux.ibm.com,
        bbrezillon@kernel.org, arno@natisbad.org, schalla@marvell.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        gregkh@linuxfoundation.org, Sven.Auhagen@voleatech.de,
        grandmaster@al2klimov.de
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-staging@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH 03/11] Documentation: ocxl.rst: change FPGA indirect article to an
Date:   Tue,  8 Jun 2021 14:23:42 -0700
Message-Id: <20210608212350.3029742-5-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210608212350.3029742-1-trix@redhat.com>
References: <20210608212350.3029742-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Change use of 'a fpga' to 'an fpga'

Signed-off-by: Tom Rix <trix@redhat.com>
---
 Documentation/userspace-api/accelerators/ocxl.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/accelerators/ocxl.rst b/Documentation/userspace-api/accelerators/ocxl.rst
index 14cefc020e2d5..db7570d5e50d1 100644
--- a/Documentation/userspace-api/accelerators/ocxl.rst
+++ b/Documentation/userspace-api/accelerators/ocxl.rst
@@ -6,7 +6,7 @@ OpenCAPI is an interface between processors and accelerators. It aims
 at being low-latency and high-bandwidth. The specification is
 developed by the `OpenCAPI Consortium <http://opencapi.org/>`_.
 
-It allows an accelerator (which could be a FPGA, ASICs, ...) to access
+It allows an accelerator (which could be an FPGA, ASICs, ...) to access
 the host memory coherently, using virtual addresses. An OpenCAPI
 device can also host its own memory, that can be accessed from the
 host.
-- 
2.26.3

