Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984C5424048
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238917AbhJFOm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238226AbhJFOmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:42:24 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A11AC061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 07:40:32 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r18so9572750wrg.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 07:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gku8jh/LusJKxFogN/q+7zVWzHmbr2yqxQ543eiL0W8=;
        b=fa2qnf1k0a0TumWPD+2eV91QJRozZPiLAQHfrlIA8yEFjFszSYffEKO+RcnTvCAVXy
         Ma8A15lWqaBrU6iV56mt4S6+qK/fOpBaPWzWVcYLHVPEd2jOGgbDk6sTQoZIpvcuJV8M
         YC+WWXTLZTi/OKxo3IYkJoTu1kGbNFumX5J0pzu2KF0xsSmDyAgegxTifyc/p2bLwzK6
         Y7Cv1O1MY0cvcuPOGhvsTpT9FW1UVsZi3uN31vP+KzBjK6Se8aOXPhpA0aGWTj3w0he0
         xUwjyiX2xhlKiRjxC/hc+AMrHu+W+24X0NvX2leN4Sv/a1rZ0TlRJSarMxSZWSnNDFUf
         9UIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gku8jh/LusJKxFogN/q+7zVWzHmbr2yqxQ543eiL0W8=;
        b=rgAfH+c+NRkOr0JPKffr/7Vl9lsMPYbyK/5BTKQyItzlcnQoEvwtDQZLVV0JT/OAeY
         E2FrjgUGSg7rSyGYWbepITgch3NpX/4hQQifmredGe2LX2ENP9vn6ivzBvUmZi9NagdR
         PCjD6hhtoEq8LaQg0Upe2+H5+9o0fIcHVf8pgzSnrkdYk/L75ILzf7U+cwzO1e9dzzPt
         bzYPs8DAS8BewJaf/XqhJrgiMJzhr0EBxnTZ1Z2gS3OqirMBu6UgZlDJgN1yp3fACR7w
         kMaVI/VXxnEAiWESBiD5NESljYXIREqzyeOpiu/AL7XS6FEOooRS4tFVxR5QtCtUhW/q
         1z7A==
X-Gm-Message-State: AOAM530qsJ1E15XE1vBF59kwahP/RVANRzoeVS3wYJYjLOdO2odCGrjB
        zMoZJVeyFiWOFqerClF8PSU=
X-Google-Smtp-Source: ABdhPJyhiW/hc5HQTSr5Cvq+l34Eyr0Ro4hZljcZSOhVfjGPgdf5kD0JZyK2fNZewiFGFsTsrmmthQ==
X-Received: by 2002:adf:97d0:: with SMTP id t16mr25398151wrb.124.1633531231037;
        Wed, 06 Oct 2021 07:40:31 -0700 (PDT)
Received: from localhost.localdomain ([197.49.35.129])
        by smtp.gmail.com with ESMTPSA id d8sm22497907wrv.80.2021.10.06.07.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 07:40:30 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
To:     sohaib.amhmd@gmail.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Fix typo in testing/sysfs-bus-rapidio
Date:   Wed,  6 Oct 2021 16:40:27 +0200
Message-Id: <20211006144028.130078-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove repeated world: "that that owns"

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-rapidio | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-rapidio b/Documentation/ABI/testing/sysfs-bus-rapidio
index f8b6728dac10..9e8fbff99b75 100644
--- a/Documentation/ABI/testing/sysfs-bus-rapidio
+++ b/Documentation/ABI/testing/sysfs-bus-rapidio
@@ -95,7 +95,7 @@ Contact:	Matt Porter <mporter@kernel.crashing.org>,
 		Alexandre Bounine <alexandre.bounine@idt.com>
 Description:
 		(RO) returns name of previous device (switch) on the path to the
-		device that that owns this attribute
+		device that owns this attribute
 
 What:		/sys/bus/rapidio/devices/<nn>:<d>:<iiii>/modalias
 Date:		Jul, 2013
-- 
2.25.1

