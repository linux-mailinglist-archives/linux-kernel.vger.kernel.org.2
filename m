Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF28349742
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhCYQsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:48:00 -0400
Received: from mail-il1-f182.google.com ([209.85.166.182]:33466 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhCYQrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:47:32 -0400
Received: by mail-il1-f182.google.com with SMTP id u10so2733854ilb.0;
        Thu, 25 Mar 2021 09:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WsN7Xqa0H0sw8FyvyboT6y25R/zqs9xa7Bq93vO2pFM=;
        b=m0vchpT8M6/4ID1oOxKCSRruHlMfar9Y2E7b1sE7HUoO5B+7MnfeTjRoFpzn0rfS56
         4z8wG4pa3YJaXm3jKzKyTeBH6hUWQYv7jvVNS0xrtSBkCjz3u6Am9GSG02fxbpc6OivD
         xCWM4YGJglV+cRyizqNxr5gCMSH0CFCcKUwRVqLZF0jv6Kz+9BUIptfnweN+aRZLCA71
         KdGJhesIrQYSc6qIR5AoVs2PMuDSsw+nteMe2Z/Wj+3SLxzUt5yMpn8FfrYLoeJHLUL9
         VwZxlbY3FIP5jN8Hi8xgsmOEHxYrQgXQt9SkPW0f+et0rQT6oqvfgJxB/0kBKvpM7HHF
         5ERg==
X-Gm-Message-State: AOAM532+7rr0ptHqDcKbJMIE/plpabPsCrnkRoE3LPnuzU7MGNuI+7Bm
        e2AGThXK8NNAIGJPJrqZa+yAAcsM4w==
X-Google-Smtp-Source: ABdhPJw7dgqG6kxlM6R5kJFIL5cMsPaoOck+8hTcMos1uAWQsrLc/kZugE8VcjgNEYIpNaOw83F9EA==
X-Received: by 2002:a92:b703:: with SMTP id k3mr7597536ili.185.1616690851216;
        Thu, 25 Mar 2021 09:47:31 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.253])
        by smtp.googlemail.com with ESMTPSA id h13sm2868615ila.82.2021.03.25.09.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 09:47:29 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 3/8] docs: dt: writing-schema: Include the example schema in the doc build
Date:   Thu, 25 Mar 2021 10:47:08 -0600
Message-Id: <20210325164713.1296407-4-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210325164713.1296407-1-robh@kernel.org>
References: <20210325164713.1296407-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example-schema.yaml file serves as documentation, so let's include it
from writing-schema.rst.

Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/writing-schema.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/writing-schema.rst b/Documentation/devicetree/writing-schema.rst
index 03e279d8fd6a..be14dbed6081 100644
--- a/Documentation/devicetree/writing-schema.rst
+++ b/Documentation/devicetree/writing-schema.rst
@@ -8,6 +8,8 @@ written in a JSON compatible subset of YAML. YAML is used instead of JSON as it
 is considered more human readable and has some advantages such as allowing
 comments (Prefixed with '#').
 
+Also see :ref:`example-schema`.
+
 Schema Contents
 ---------------
 
@@ -170,3 +172,12 @@ json-schema Resources
 `JSON-Schema Specifications <http://json-schema.org/>`_
 
 `Using JSON Schema Book <http://usingjsonschema.com/>`_
+
+.. _example-schema:
+
+Annotated Example Schema
+------------------------
+
+Also available as a separate file: :download:`example-schema.yaml`
+
+.. literalinclude:: example-schema.yaml
-- 
2.27.0

