Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09095392A73
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbhE0JS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbhE0JSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:18:25 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40010C061574;
        Thu, 27 May 2021 02:16:53 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id j12so3225834pgh.7;
        Thu, 27 May 2021 02:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oM/r3Cw3PKT/t8DjqyZUTn06Sr3O3TlBwU0pjuFWsyU=;
        b=Pw7en0clhMeNqvu8FTF0V1DFaA+gUv/Oz+dEz9zaAmOdfjHhC96LZajDqywYRupste
         7f4eH99FGVMyCxJcBeW1OHhGaeCoiRu4k7jt01m67emVrK2lgBKZeCQG5hobXZlD8iP9
         wiVzkGuQO7k/Qb/nR6yvNRDUl6HoVxJUKIPzGvejq+Y3RMYd9SUWderJES75G2qLcrIQ
         RWNMIcgGEldsWM1TKhRentYU/tfhZS3YO04IHAwXP31cH3dEinCdAbEHb6mJVevyZGRV
         L95GjRVHu2Z61rTh8O4wbV3gFDjqhvCn4QQTXWUAWhGLmwqnUJv1SdmPi7hBu3gkPfSA
         HKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oM/r3Cw3PKT/t8DjqyZUTn06Sr3O3TlBwU0pjuFWsyU=;
        b=L7U+AFUIpNyOgyD4xydqPK3Y/3B4HYap9DepihrHuAyJyTnkuYQNyuw5JAsqwqvjOr
         PxBGODFsuDUFYF8WP4v9qAp3qrDvmHdxJEoihnHuF1oSjwyr3ndFPomrH+2VIpBLvYDG
         vkIGQAQc9GlMFhzV4piY6wyJzOo3jDpL07UKKg69we9kdnoyTX5uhpn8g4U4PXh1wOFs
         /nwIRC9uEZQoajLGr6r8anDSKCNgrDDzocCk1cIhsr0QKuDlDBzHscyz4Oa6iU+zEQw5
         OFYTTAOEv1XGaWUk8D9jUT+KEVE41IFkv5mc1A2Cl/fD+zKbBx6F5X/sW5kVIeWr0CgF
         PFBg==
X-Gm-Message-State: AOAM530+xNGOQayD1Oax1H/DGtrz/AWrF5KXtNSVEV9mElAjFHnRFL4I
        EuWbgvjeSo2SaI0Bxpg3QR0=
X-Google-Smtp-Source: ABdhPJwU+FVb0K8J8eVlQT5cPRtQrrjf18YtddcKB6WJ4pfWpkKKbYwNErcQkvN+Jep5saZovYcuSA==
X-Received: by 2002:a62:b419:0:b029:2e8:e879:5d1e with SMTP id h25-20020a62b4190000b02902e8e8795d1emr2781534pfn.3.1622107012613;
        Thu, 27 May 2021 02:16:52 -0700 (PDT)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id 126sm1473079pfv.82.2021.05.27.02.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 02:16:51 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v3 00/13] docs: path-lookup: Update pathlookup docs
Date:   Thu, 27 May 2021 17:16:05 +0800
Message-Id: <20210527091618.287093-1-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Path lookup is a very complex subject in VFS. The path-lookup
document provides a very detailed guidance to help people understand
how path lookup works in the kernel. This document was originally
written based on three lwn articles five years ago. As times goes by,
some of the content is outdated. This patchset is intended to update
the document to make it more relevant to current codebase.


---
v1: https://lore.kernel.org/lkml/20210126072443.33066-1-foxhlchen@gmail.com/
v2: https://lore.kernel.org/lkml/20210316054727.25655-1-foxhlchen@gmail.com/
 - Fix problems in v1 reviewed by Neil:
   1. In Patch 01 and 02 rewrite a new paragrah to describe step_into()
   2. In Patch 01 instead of changing it to traverse_mounts, remove follow_managed()
   3. In Patch 03 re-telling the story rather than adding notes
   4. In Patch 04 do_open() should be outside of loop, fix it and fix other problems
      in following paragrah
   5. In Patch 07 use "drop out of RCU-walk"
   6. In Patch 08 "latter" should be "later", fix it and restructure the next paragrah
      removing "Finally"
v3:
 - Fix problems in v2 according to Neil's review:
   1. Fix minor problems in Patch 1,2,3,8,9,11,12
   2. In Patch 4 remove redundant paragraph, condense information, and
make the paragraph connection more smooth.
   3. In Patch 10 Fix WALK_NOFOLLOW, WALK_MORE descriptions and
document WALK_TRAILING

 - As suggested by Matthew Wilcox and Jonathan Corbet, remove ``...`` literals of function names in this patchset. I put this in a standalone Patch(Patch 13), because automarkup extension doesn't work on my side. You can choose to take it or not take it.


To help review, I've put a compiled html version here:
http://linux-docs.54fox.com/linux_docs/filesystems/path-lookup-v3.html
and highlight changes using hypothesis:
https://hyp.is/go?url=http%3A%2F%2Flinux-docs.54fox.com%2Flinux_docs%2Ffilesystems%2Fpath-lookup-v3.html&group=__world__


Fox Chen (13):
  docs: path-lookup: update follow_managed() part
  docs: path-lookup: update path_to_nameidata() part
  docs: path-lookup: update path_mountpoint() part
  docs: path-lookup: update do_last() part
  docs: path-lookup: remove filename_mountpoint
  docs: path-lookup: Add macro name to symlink limit description
  docs: path-lookup: i_op->follow_link replaced with i_op->get_link
  docs: path-lookup: update i_op->put_link and cookie description
  docs: path-lookup: no get_link()
  docs: path-lookup: update WALK_GET, WALK_PUT desc
  docs: path-lookup: update get_link() ->follow_link description
  docs: path-lookup: update symlink description
  docs: path-lookup: use bare function() rather than literals

 Documentation/filesystems/path-lookup.rst | 194 ++++++++++------------
 1 file changed, 85 insertions(+), 109 deletions(-)

-- 
2.31.1

