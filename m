Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37BD3EA27F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 11:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbhHLJv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 05:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236473AbhHLJv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 05:51:27 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE91C061765;
        Thu, 12 Aug 2021 02:51:02 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id f91so2772188qva.9;
        Thu, 12 Aug 2021 02:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=htwOi/42dSt1MVAut+eNHPxAK4pGRot7RbkIWoqqfs0=;
        b=OI4C/TjHmNznIdl1nugLFRonui4B/yt0SLYLlU4RaUCykGbJDTfw9h4EbACGlMp5nf
         P06mcFjEkh7aKDQkTndzgvqIBEIduft8l/tO6KKz2atH6cwUrTnzKk4ApAqYeLRxPA9a
         aTOs8z/66j7ixae2+TVdSqebZRl7gqSJmCu0+pfuem+DnLr8zPNLTld2N0bGbcppIjsi
         dNnZmZrM4BEqIH3OJnDx2kdho3rIKkOXjzU2PU559iClDXhxhFOsltaD2hnn0bCPofFG
         FGLQG57Cx/vMhP3NPz3+9ZGp7IXtbYL+xJ79EnX097dShRs7km2cn+zR0ULCVOK7GdAB
         a9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=htwOi/42dSt1MVAut+eNHPxAK4pGRot7RbkIWoqqfs0=;
        b=VeUc1jrxFaYgTapin/nRyViigZ0xz8TUGrYYEDuc5lsml+3la8EjDpp8dT9JoUMynt
         /oQSA8qvGBY/+ZPAdDh0zLb91S2SAz5f7cKwufhjzJU1PyosOm4hK1LiTYJMRlqa2lit
         VQ9vB5CccTwE4xc4NsmzbmIc1tMrn7/BjdmR/YangoYzdo3dXVMv32Qg+t7S0ADGURNm
         cTgnC1DNkKUiqc8RPzJ2BcM0iiktR8IDh9cGBt0csC9Gic1Y1nDAg8xl6DmypN38tbXR
         Div2+MVvED9gwjY19Z7HO5Wuof3Ek/NiMFnkAS4GzJM4veM67FKTGFqGU++DqZ6HyZvb
         KmYA==
X-Gm-Message-State: AOAM533LozuZmJt1FykiOb8ykLwT7rVGquFb8ADw70E0QWWlumsbQ93w
        nBqYFtd2qUFIqkhZaHMfJ8M=
X-Google-Smtp-Source: ABdhPJyoFXgwZp/ypiOQ+eZrhgjZcdKI4XjJMPNoF8x/MxZo+MnToRU/W7UR6BVkfYYesdzKglyoiA==
X-Received: by 2002:a0c:c78f:: with SMTP id k15mr3009456qvj.20.1628761862016;
        Thu, 12 Aug 2021 02:51:02 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id n10sm817684qtk.89.2021.08.12.02.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 02:51:01 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 2/2] Documentation/process/maintainer-pgp-guide: Replace broken link to PGP path finder
Date:   Thu, 12 Aug 2021 09:50:30 +0000
Message-Id: <20210812095030.4704-2-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210812095030.4704-1-sj38.park@gmail.com>
References: <20210812095030.4704-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

PGP pathfinder[1], which is suggested for finding a trust path to
unknown PGP keys by 'maintainer-pgp-guide.rst', is not working now.
This commit replaces it with other available tools.

[1] https://pgp.cs.uu.nl/

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/process/maintainer-pgp-guide.rst | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/Documentation/process/maintainer-pgp-guide.rst b/Documentation/process/maintainer-pgp-guide.rst
index 8f8f1fee92b8..29e7d7b1cd44 100644
--- a/Documentation/process/maintainer-pgp-guide.rst
+++ b/Documentation/process/maintainer-pgp-guide.rst
@@ -944,12 +944,11 @@ have on your keyring::
     uid           [ unknown] Linus Torvalds <torvalds@kernel.org>
     sub   rsa2048 2011-09-20 [E]
 
-Next, open the `PGP pathfinder`_. In the "From" field, paste the key
-fingerprint of Linus Torvalds from the output above. In the "To" field,
-paste the key-id you found via ``gpg --search`` of the unknown key, and
-check the results:
-
-- `Finding paths to Linus`_
+Next, find a trust path from Linus Torvalds to the key-id you found via ``gpg
+--search`` of the unknown key.  For this, you can use several tools including
+https://github.com/mricon/wotmate,
+https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/tree/graphs, and
+https://the.earth.li/~noodles/pathfind.html.
 
 If you get a few decent trust paths, then it's a pretty good indication
 that it is a valid key. You can add it to your keyring from the
@@ -962,6 +961,3 @@ administrators of the PGP Pathfinder service to not be malicious (in
 fact, this goes against :ref:`devs_not_infra`). However, if you
 do not carefully maintain your own web of trust, then it is a marked
 improvement over blindly trusting keyservers.
-
-.. _`PGP pathfinder`: https://pgp.cs.uu.nl/
-.. _`Finding paths to Linus`: https://pgp.cs.uu.nl/paths/79BE3E4300411886/to/C94035C21B4F2AEB.html
-- 
2.17.1

