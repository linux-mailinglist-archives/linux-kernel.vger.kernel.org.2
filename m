Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E6234973F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhCYQr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:47:57 -0400
Received: from mail-il1-f181.google.com ([209.85.166.181]:37832 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhCYQr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:47:29 -0400
Received: by mail-il1-f181.google.com with SMTP id z9so2678190ilb.4;
        Thu, 25 Mar 2021 09:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HVnVN03MoHYDxmuTNrFMILoKYIQFoiOcDb3ed6T1M/A=;
        b=t6Axj6Ce5ZYisFhzb/BDCcsyXnQ9M/nrxIS53G0Klw4/S99ETvIed5NZkdxYKZfGsw
         WO/OobNUiUOXoRGdORslbUNnP4X2WTfypTs6dSk8lUxw8LjBXAF59msS+LbkPy4GHPvH
         s+mlYSwPqTgiZFvTjht8ubbwTNNXD1c4DW1T+Z2yLwn/191hXWDNZ+LQvESgfZElqNc0
         zoxRESFFzpuQffiSG4vC+R3HWf+WawpIq5eYoQLJYe5K5+uVCSJ9/MvWeZBD8Llu40jf
         0AbtwdpwywrLFGFw+Dsqh5flPFRa0aBw24sUNBYuIGwk6cyJIUtsDieMOSa/p8Sk2ybt
         thJA==
X-Gm-Message-State: AOAM530c9+ifYI5KI5UsUpxS2agzhBIe5O0zHEuNtlNO4aUVDYrkYx+3
        JtdqJ6i9k4u2hxkiEE1NwiSHIiM5Lw==
X-Google-Smtp-Source: ABdhPJwIxXowAHmdEfZ3GeEk9/iuTGEX0VP/cbilNoFbZSZ9aihbcjBN5V9ibGnMr78n/U/ZEVAZJw==
X-Received: by 2002:a05:6e02:925:: with SMTP id o5mr2552083ilt.307.1616690848259;
        Thu, 25 Mar 2021 09:47:28 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.253])
        by smtp.googlemail.com with ESMTPSA id h13sm2868615ila.82.2021.03.25.09.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 09:47:26 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 2/8] docs: dt: writing-schema: Remove spurious indentation
Date:   Thu, 25 Mar 2021 10:47:07 -0600
Message-Id: <20210325164713.1296407-3-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210325164713.1296407-1-robh@kernel.org>
References: <20210325164713.1296407-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'allOf' and 'properties' have a leading space which causes them to be
indented in the doc output.

Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/writing-schema.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/writing-schema.rst b/Documentation/devicetree/writing-schema.rst
index 16f21e182ff6..03e279d8fd6a 100644
--- a/Documentation/devicetree/writing-schema.rst
+++ b/Documentation/devicetree/writing-schema.rst
@@ -46,12 +46,12 @@ select
   schema. By default without 'select', nodes are matched against their possible
   compatible string values or node name. Most bindings should not need select.
 
- allOf
+allOf
   Optional. A list of other schemas to include. This is used to
   include other schemas the binding conforms to. This may be schemas for a
   particular class of devices such as I2C or SPI controllers.
 
- properties
+properties
   A set of sub-schema defining all the DT properties for the
   binding. The exact schema syntax depends on whether properties are known,
   common properties (e.g. 'interrupts') or are binding/vendor specific properties.
-- 
2.27.0

