Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299F135532E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 14:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343734AbhDFMKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 08:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238224AbhDFMKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:10:08 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54316C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 05:09:59 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id f16so16221159ljm.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 05:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Eijh7opZwID4E3qzX/yTt/B8FpJzMJ+jEZ1I1aM/q6s=;
        b=L60fOoUoABs49nsy/jz0aOn+FQm1KND11117yXHCZXZCZXHJMCp5rqhgWZwkY2uPuj
         uTUw1jaqcD3BwAlJ41tA8YvpDuE/Qn/4xQX8PSyEnpGqqcyAbIOfo9XjKFGj3bL028RG
         iPHhu60+ZPZJsXcudSePjSpFA9Q/XbiKY2sEti6+vgmmqzfMDaqSszxMhYyFQ8fB5n37
         ZzWs9L/VGWLk08WQrYeLowymLQoLgehsSjg2W8utAZNbEmxLEcedoZHxFTO67vcDupxS
         jWaGKS4WstB9I/FhvGZACIc8OOucgLyil83YJRbHVpMMLAc3nQSOnK55anfKW2Ji/Yq/
         9BLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Eijh7opZwID4E3qzX/yTt/B8FpJzMJ+jEZ1I1aM/q6s=;
        b=oOcJU0sVoi1AQd2CGC6QepdNk4a/3zM7CZz3sCh6c7CjMXvsErwlPCkqARwoZYrj7F
         +A1sxhgc4Usd04FdzgV1/z4FY4feZciz2jyziI/3mPzIKMiZ+EQijn1wGZEENvhmpOwJ
         K4N6IOyPXOvceKjAM0Qda7ogAuBhs/PC0hFX+eSnOnBvusFsLX/gq6V7bch++deAEzo+
         w+WE8ijvZiqNoQa99QoTuPUwQZ5aTKd/Dd71GsvuMab3NLi7HUYuM7ynPuK5ly6tq+qY
         D6S1WlzDgP867vikx1LnhTYdxBM+2OWqNIvv/cWgeRvy6sq+pSQctN+nRun8K+rW+tHy
         h/8A==
X-Gm-Message-State: AOAM530i4p3gR+PpM1XkYQePcmH2kdPI4EHB1YcD9vNItPY70OhqWT6z
        qccY0FnOr+pVfaUmLN5BSMM=
X-Google-Smtp-Source: ABdhPJxG6YnhVhUoi77Ji1VimECioxTabxcMKqwd5WIU1wH6DBEaY0AyBZT1B30GweFHx5IUa7UMRQ==
X-Received: by 2002:a2e:b4f6:: with SMTP id s22mr18439067ljm.328.1617710997923;
        Tue, 06 Apr 2021 05:09:57 -0700 (PDT)
Received: from zhans ([37.151.32.231])
        by smtp.gmail.com with ESMTPSA id x207sm191922lff.92.2021.04.06.05.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 05:09:57 -0700 (PDT)
Date:   Tue, 6 Apr 2021 18:09:54 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH v2 0/2] staging: rtl8712: rewrite comparisons and remove
 blank lines
Message-ID: <cover.1617710602.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset replaces NULL comparisons with boolean negation and
removes extra blank lines after an open brace.

Changes since v1:
	- more detailed description of the commit

Zhansaya Bagdauletkyzy (2):
  staging: rtl8712: Rewrite NULL comparisons
  staging: rtl8712: Remove extra blank lines

 drivers/staging/rtl8712/rtl871x_io.h   |  1 -
 drivers/staging/rtl8712/rtl871x_mlme.h |  1 -
 drivers/staging/rtl8712/rtl871x_recv.h | 11 +++++------
 drivers/staging/rtl8712/sta_info.h     |  1 -
 4 files changed, 5 insertions(+), 9 deletions(-)

-- 
2.25.1

