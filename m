Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C173DB36C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 08:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbhG3GSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 02:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237404AbhG3GSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:18:46 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A871C061796
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 23:18:41 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id j22-20020a17090a7e96b0290175fc969950so12844953pjl.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 23:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GiuZxc2vIiLi2GqaesW3uMQvAdi+WLEB0SZDBvMyFBc=;
        b=foRUqLVlSjmizeJNocTQye6ZVD67JVkh3FdovVxhNjH/zTyA+gDaWirmQ648Vicltl
         7Wjn9luTlCmJb9MASEjDbju5cJnELhETFLPwR8J/c2PBblG4zzf9ICys3tOj1lBDOKYG
         bUjvulpTDKezUyAzu2oLm8yn4+AuEcevzuiV2NdnaWsEHYgeaghIOTgXdxq6vjd+Kgfx
         GJiB2EXr45j2UvVUOI8S+U+F/bRNeZXrxVYGnyZB1BDy7DPTbWHzW/J2W+66G7hOSW8e
         jGMeFz8BEqXG1keUgJASuuxOF2bhzSkW4y1pxYr7JpmdZeac6eKEdG7GMM8wZ8XpMJg9
         AP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GiuZxc2vIiLi2GqaesW3uMQvAdi+WLEB0SZDBvMyFBc=;
        b=dzhGCqTwv8vJEkduVzSiEs0Fiel6ekRvy/ZnKg0TojCX5KCD/6psAw/m75EhBNCrae
         XzqyQ7QO3EUjJCVkfU2kMh4OvImk4F/Zs5LXJLIAg55HUdb3yasBeEykrDVIKXleAo3+
         QGx0iAIJZVlB1Zi8OHD8VV+ArZZzTTR5zmGEridwZuk7civ0lDHC1I8nmJO5R4XUUtzG
         0E1QcAQSHSuJeGrqi7GWlUyhk+8W3H0TWhbz+VvEp6XgMgvejxdOSMT04PgaxOBXz5Yp
         xTI7B27ArNpYQ2Akcf7JDnJ6M8Q1wY+vtPxF/lC0NUIiM+nYmPykLV1FlPZvvYqgPBkM
         rHNw==
X-Gm-Message-State: AOAM530mpHBp4lg8Bcg66GoKJd1RqAwmIbXccGGp5hi1rmdGT/HaMcuD
        yd6ZxHUn1aFoT+EFthPDN22tyQilbGH/
X-Google-Smtp-Source: ABdhPJxRLZzV90fv+eOS9sQCQta4PC7QWfahHEWOZkvZSOVQpALydjuegoahhKh4WJqZv3fZ2bva2yaJud8+
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:6892:a74:4970:a062])
 (user=kyletso job=sendgmr) by 2002:aa7:8246:0:b029:39a:1e0a:cd48 with SMTP id
 e6-20020aa782460000b029039a1e0acd48mr1408472pfn.14.1627625920974; Thu, 29 Jul
 2021 23:18:40 -0700 (PDT)
Date:   Fri, 30 Jul 2021 14:18:31 +0800
In-Reply-To: <20210730061832.1927936-1-kyletso@google.com>
Message-Id: <20210730061832.1927936-2-kyletso@google.com>
Mime-Version: 1.0
References: <20210730061832.1927936-1-kyletso@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v4 1/2] dt-bindings: connector: Add pd-supported property
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set "pd-unsupported" property if the Type-C connector has no power
delivery support.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
 .../devicetree/bindings/connector/usb-connector.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 92b49bc37939..21ec470117a6 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -111,6 +111,10 @@ properties:
       - 1.5A
       - 3.0A
 
+  pd-unsupported:
+    description: Set this property if the Type-C connector has no power delivery support.
+    type: boolean
+
   # The following are optional properties for "usb-c-connector" with power
   # delivery support.
   source-pdos:
-- 
2.32.0.554.ge1b32706d8-goog

