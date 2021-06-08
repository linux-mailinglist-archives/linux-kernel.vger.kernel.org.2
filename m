Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD163A05B3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 23:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbhFHV0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 17:26:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231760AbhFHVZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 17:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623187444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9WOcYtG36rVjuPEj8K6lgDL7dCdoY9WpL7jwDyU54B8=;
        b=O8G5xREaz1HJ1FdHOHxOGFnwcQ7Cd1aQFI4c7H4d7ZXtA1h/9WsN8wWCvF7RMbtPJLPNEj
        g744MYtLLbru9JWGOwUdhU5ObbYlBqvHA/prNBCuIH2pgNu0cSvBsZn82EsLu2SN42W6Rw
        pcuKvVyGvCqMZYpV6oOVlzRBAe4/ypY=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-73Qc3tWVM3Korp7OVwDxvA-1; Tue, 08 Jun 2021 17:24:02 -0400
X-MC-Unique: 73Qc3tWVM3Korp7OVwDxvA-1
Received: by mail-ot1-f69.google.com with SMTP id m20-20020a0568301e74b02903e419b82f75so7888857otr.23
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 14:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9WOcYtG36rVjuPEj8K6lgDL7dCdoY9WpL7jwDyU54B8=;
        b=IdBjp1qAorXCi/01DaPDDpcnRCY3Odq+dHyR+gcopxE55YLqQsI8X7/2tynULHvBax
         o95/azglJDnk9XJvKVFYsB9If78evmebJ5Wb/mc3avjL7p6AQx9ymK00KHzdMPhdYriR
         TK2j5jzBkFy/bIdEAsi7jUsMK5kQxbgpONs36i9PPmq5dJkZ/UZFb+WZT7jy79fp9cGI
         FnV4X6eHJaERSZlSeaCzVWRScWcXzZHVkbmcPd7pyQdIvoc50XJ9zZu5bnvR+eQZ3YAB
         AfMQHHOMC5y7EHYnGwgxoJLFmpP4fOQQzRenIhE1xzwu9aZzDQHtDPwfF+MtueI4VQZ2
         G7VQ==
X-Gm-Message-State: AOAM530fy8NsWk2nNmBRvKbfdNQlBwy24wZqLtVggBCnxyFkSrnhqZ58
        siRKOCY2zIq/Hmhq8x7+HwsUT08fANldUGoNENWwjSCMaAYi60UAn/+nkPnXSqza8hfXGX+aOKe
        f5w4HQO7JROusHPk2L0DnhG3Y
X-Received: by 2002:aca:4703:: with SMTP id u3mr4203131oia.37.1623187441878;
        Tue, 08 Jun 2021 14:24:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOmes5a6/9rFBo39RJQElGnhgBYJ++iI8VFQf2/yT0UFkGTfCosxrJuI7CS1xqFaTnjT/XLg==
X-Received: by 2002:aca:4703:: with SMTP id u3mr4203117oia.37.1623187441736;
        Tue, 08 Jun 2021 14:24:01 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x199sm1954310oif.5.2021.06.08.14.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 14:24:01 -0700 (PDT)
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
Subject: [PATCH 00/11] fpga: change FPGA indirect article to an
Date:   Tue,  8 Jun 2021 14:23:39 -0700
Message-Id: <20210608212350.3029742-2-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210608212350.3029742-1-trix@redhat.com>
References: <20210608212350.3029742-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A treewide followup of
https://lore.kernel.org/linux-fpga/2faf6ccb-005b-063a-a2a3-e177082c4b3c@silicom.dk/

Change the use of 'a fpga' to 'an fpga'
Ref usage in wiki
https://en.wikipedia.org/wiki/Field-programmable_gate_array
and Intel's 'FPGAs For Dummies'
https://plan.seek.intel.com/PSG_WW_NC_LPCD_FR_2018_FPGAforDummiesbook

Change was mechanical
 !/bin/sh                                                        
 for f in `find . -type f`; do
   sed -i.bak 's/ a fpga/ an fpga/g' $f
   sed -i.bak 's/ A fpga/ An fpga/g' $f
   sed -i.bak 's/ a FPGA/ an FPGA/g' $f
   sed -i.bak 's/ A FPGA/ An FPGA/g' $f
 done


Tom Rix (11):
  dt-bindings: fpga: fpga-region: change FPGA indirect article to an
  Documentation: fpga: dfl: change FPGA indirect article to an
  Documentation: ocxl.rst: change FPGA indirect article to an
  crypto: marvell: cesa: change FPGA indirect article to an
  fpga: change FPGA indirect article to an
  fpga: bridge: change FPGA indirect article to an
  fpga-mgr: change FPGA indirect article to an
  fpga: region: change FPGA indirect article to an
  fpga: of-fpga-region: change FPGA indirect article to an
  fpga: stratix10-soc: change FPGA indirect article to an
  staging: fpgaboot: change FPGA indirect article to an

 .../devicetree/bindings/fpga/fpga-region.txt  | 22 +++++++++----------
 Documentation/fpga/dfl.rst                    |  4 ++--
 .../userspace-api/accelerators/ocxl.rst       |  2 +-
 drivers/crypto/marvell/cesa/cesa.h            |  2 +-
 drivers/fpga/Kconfig                          |  4 ++--
 drivers/fpga/fpga-bridge.c                    | 22 +++++++++----------
 drivers/fpga/fpga-mgr.c                       | 22 +++++++++----------
 drivers/fpga/fpga-region.c                    | 14 ++++++------
 drivers/fpga/of-fpga-region.c                 |  8 +++----
 drivers/fpga/stratix10-soc.c                  |  2 +-
 drivers/staging/gs_fpgaboot/README            |  2 +-
 include/linux/fpga/fpga-bridge.h              |  2 +-
 include/linux/fpga/fpga-mgr.h                 |  2 +-
 13 files changed, 54 insertions(+), 54 deletions(-)

-- 
2.26.3

