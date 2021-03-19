Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98526341545
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 07:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbhCSGQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 02:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbhCSGQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 02:16:07 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BCBC06174A;
        Thu, 18 Mar 2021 23:16:07 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gb6so4152317pjb.0;
        Thu, 18 Mar 2021 23:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9BaMMGzOpHD0VDxT5SymHo185nk+L06zmdo5u2GYgc8=;
        b=ZzDg1uOEAWm8QJJ9nHn9MQEN4TCJbb7AtqP+HTGbkuCr6JpTx3Ls93Glc7sYZgyDM1
         Z9W2q0+5OdbzUiFBDGzAhjciaBSqV0/Y9vV0jrEU1lyNyL024GFdGIT1lmbJYzO7JB02
         mnRMpdl5rPa8b23/C8lxn+vrI5RQtS/zJRe3HG2JNURrFuyjBahhcKBANaWe0ELN/mcO
         vU59VgkBzUwe/ivY9yiMbz0zJK21dwA/hpLqHieK659yvyYQPimmzap5a0EqKPifRHto
         F3ND/KtPUopDxZlC3tw7EhO5MtowTjMNEOAvTbRJjknJeCeuD/YVUnxHQi2qP9Ss1aF/
         +2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9BaMMGzOpHD0VDxT5SymHo185nk+L06zmdo5u2GYgc8=;
        b=lMWhFwI1iOuTgvjtFZrJf5qcxbOwTcPzVQKKloe3DojLQRy4PdZctkpvnjPXyObw2L
         MpPKWj7DXtTAMSR8voxPsOYAm0N96Z9t9BhCPGz9ZezOuP5La+EH7QLsPc2Mk5LdiFO2
         Dn0S/rkETGUJYUwbdgRa33YpcdEinsNxDM3cUOxj49eRnDJ1O1EsOrQKzEXMyBCFzQ2i
         WF6YcjBBTuB2Q5kyZsezFthOjKZ8H9MBv7bwL9swlUOzOjs1Xfy3obfr4+OmlDJ+3yhe
         oxAk2NZMv2q0YHiiyOoF6hjJJhu+6rnqb/8mRJ1RBBXqTQNP/I3akz54wbKLAANbrPBH
         fOvw==
X-Gm-Message-State: AOAM530gB+IkI5FeVaf+tft7P3Q5zL5kon7V2QX/sFkysPeAqTxEGSgg
        yirWItFKzcMY10doo2yBTp8=
X-Google-Smtp-Source: ABdhPJzD7StJBrcMqBQbYIw3n/bPA9damAKDDp5QGqq0S2PqehVBrjHorFuWRg+dNvnyR2/gNyfa5Q==
X-Received: by 2002:a17:902:e98c:b029:e5:defc:ccf8 with SMTP id f12-20020a170902e98cb02900e5defcccf8mr13099782plb.20.1616134566704;
        Thu, 18 Mar 2021 23:16:06 -0700 (PDT)
Received: from lenovo.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id o1sm4223103pjp.4.2021.03.18.23.16.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Mar 2021 23:16:06 -0700 (PDT)
From:   Orson Zhai <orsonzhai@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, haidong.yao@unisoc.com,
        Orson Zhai <orson.zhai@unisoc.com>
Subject: [PATCH v3 0/3] Fixes & a new supplementary feature to SPRD mailbox driver
Date:   Fri, 19 Mar 2021 14:15:34 +0800
Message-Id: <1616134537-27966-1-git-send-email-orsonzhai@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Orson Zhai <orson.zhai@unisoc.com>


Fix a real problem for SPRD's mailbox driver in patch 1/3.
Add supplementary inbox support for newly added sc9863a in patch 3/3 and
change dt bindings yaml accordingly in patch 2/3.

Changes Log:
V3:
- Add Reviewed-by tag from Baolin for driver code.
- Change interrupt-names syntax in dt-bindings according to Rob's comment.

V2:
- Change patches order. (Yaml go to the head of dirver)
- Remove unnecessary initializing refcnt to zero. 
- Add fix of possible crash caused by NULL of chan->cl. (Actually move from
  changes to sprd-mailbox.c of patch v1)
- Remove unnecessary "inline" for do_inbox_isr().
- Fix yaml errors from Rob's robot checking.
- Add sc9863a compatible string for real supplementary inbox usage. (sc9860
  is not supported by supp-inbox)
- Add more details to supp-inbox in commit messages.

Orson Zhai (3):
  mailbox: sprd: Introduce refcnt when clients requests/free channels
  mailbox: sprd: Add supplementary inbox support
  dt-bindings: mailbox: Add interrupt-names to SPRD mailbox

 .../devicetree/bindings/mailbox/sprd-mailbox.yaml  |  13 +-
 drivers/mailbox/sprd-mailbox.c                     | 135 ++++++++++++++++-----
 2 files changed, 113 insertions(+), 35 deletions(-)

-- 
2.7.4

