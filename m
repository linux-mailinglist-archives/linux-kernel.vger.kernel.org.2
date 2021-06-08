Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9A13A05DE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 23:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbhFHV03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 17:26:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59858 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234395AbhFHV0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 17:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623187458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9WOcYtG36rVjuPEj8K6lgDL7dCdoY9WpL7jwDyU54B8=;
        b=TGPl/rNVoRI9VyHrcRHHjsahA2kSzcRApQAPAFomQ4DrZ9EgVNIPpOAoGVcKTgT0t2LDQJ
        nOAb8gcS/R6MthKhYo8PwToM6bXOEcfEhUulBJU5KoGeCu83JXWSZ8Pu+d7T/y8V4GGfuK
        z62gW4430SBf2FPonYss5UfxPFux7j0=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-fP_yRVpIMqukRUV8qgP3KA-1; Tue, 08 Jun 2021 17:24:00 -0400
X-MC-Unique: fP_yRVpIMqukRUV8qgP3KA-1
Received: by mail-ot1-f72.google.com with SMTP id v16-20020a0568300910b029032e3cb976e3so14786649ott.14
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 14:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9WOcYtG36rVjuPEj8K6lgDL7dCdoY9WpL7jwDyU54B8=;
        b=FAN0VUYw6weijmQo92HxqoyYlJeJkdTVBjIXSIZtiuezz00NNPhbkPtyyK0DUnwIBh
         X0Lrlut62X/rtCA4QH8HIzUlO+yYokmElJpF8aGIyqYr6GX2wAdeRpt1nZJZUPZExZb5
         VCMitZeC+yt00/ulLzsRyhyD29W3I7U5V/QYs1Mwq1thLVnXJHwXyrjd0Tyst2buqsCc
         c0U5GdjGWgGOxM1i2owDnL61RCy8iK8Y/hICA3i1Aud6rD4TDd8K+haYgdoTJYvu3efk
         YEAhbVFsapH1Z/EoRXcurRq89ya6HnvP9RUCALuwRJadxx558SLq55x3FTl1hZgKbCJb
         a5pA==
X-Gm-Message-State: AOAM53200KCEks5Ns8T8JkNH8SHlGQg5OGWREscHLIOjw6JJM/C/AxVS
        5HtFPSuFm/IMkaVdK9U1p89bnMAqXf4LXF+kt5SxEYxa9FphcgcaaPMjdS728PsvZaWxkxhNAuh
        X8cRLFRNG1odHQS0nAKTkPZ4l
X-Received: by 2002:a54:4091:: with SMTP id i17mr4211787oii.96.1623187439562;
        Tue, 08 Jun 2021 14:23:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/slvYeAdnbZ/SPI7BCq6DWlaOdgzks9roBFKWnERshaA7TkLI+lr32K9zzB6m1V9KMz0o0A==
X-Received: by 2002:a54:4091:: with SMTP id i17mr4211765oii.96.1623187439400;
        Tue, 08 Jun 2021 14:23:59 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x199sm1954310oif.5.2021.06.08.14.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 14:23:59 -0700 (PDT)
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
Date:   Tue,  8 Jun 2021 14:23:38 -0700
Message-Id: <20210608212350.3029742-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
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

