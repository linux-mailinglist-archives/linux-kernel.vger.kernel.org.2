Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5004835EE48
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 09:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349637AbhDNHWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242024AbhDNHWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:22:08 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC0CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 00:21:46 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id a85so12697826pfa.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 00:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=5M6lZDHmRsVmI9+ZaAWTX2wcWhrGZNQhEEI4YOQh3oU=;
        b=ChZh3Dl2or1rhHPDot1lrzwIiiA6KRu5T1fe5TnRdZP5sdWQ14awGLuWyEw5GtNYm4
         V38HkjKYWV5ciOTEdLjKikOttbjRK6dxcOeh2IrCdhAqqdFee2wFDXKSl9ALq41aY+2I
         EqCkqrrx9GR6A2hy0LWanqayxplsLvtQ7ZIeqt+dvzthLBdXqAFeiOXoOwSWiWpCga4B
         4ywq953KplFvQnvTey7m3Gx5ztx5H10uGjZ+VBo4Xh5vO8iVBrDErqo2KQeLQtnrof+u
         eqCeRFAKm16/9rBSd43uMkTrJIliNYPkjKb3zL7BkZadoJPAD1sZc4q3WV+2zmuxYHhR
         a+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=5M6lZDHmRsVmI9+ZaAWTX2wcWhrGZNQhEEI4YOQh3oU=;
        b=PESQA2YHgKUWLdyEBalzwEDA/xocBZFwomiEL/x++9NOPWU6oi7p8J7cZcYzevHZvc
         8slHfgn0l277RV9tg60nnoqSIOTK3LyPbb9TzqTSgyMlt+1YJd+vPhLl99mf0EYG0rQ3
         HpOu9gLQS5YIrLM+RMT+P2REB7mhuIkVGqLgmXxJzzwuGWZLIZA/ECT883cV1YRaDRO/
         f8fPRx/TRGVyfYygeJB1O2feV8Qst7q1xOreOziUqn+MwivpphUkkDTC/ZJuZDDu4atp
         vlqHgD38fho1N1kr39e5L3MhlxmsfjOXSIym89IrCZtfkNS8GtS/meNPpNr4whe4IbN3
         LIYQ==
X-Gm-Message-State: AOAM530dFa4w/fiv541MqsOQwyXJ0MbHHN8XbaC0jnA2UqFHAbQAj/Xi
        Jy7CDGH/bAifkouQo1RIonM5HDRJACjLTw==
X-Google-Smtp-Source: ABdhPJxMkFmo2SO2Tj4yN8plu5ZWoTd/3WUhDlACHik/MxUw4iQ8KvISpyA9PKdHD6F1FUkGmR6W5w==
X-Received: by 2002:a63:c4f:: with SMTP id 15mr35326894pgm.379.1618384905996;
        Wed, 14 Apr 2021 00:21:45 -0700 (PDT)
Received: from kali ([103.141.87.253])
        by smtp.gmail.com with ESMTPSA id c2sm13931755pfo.53.2021.04.14.00.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 00:21:45 -0700 (PDT)
Date:   Wed, 14 Apr 2021 12:51:35 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v6 0/2] staging: rtl8192e: Clean up patchset for style issues
 in rtl819x_HTProc.c
Message-ID: <cover.1618383684.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v5:- Rebased these patches and dropped 2/3 and made this
a patchset of 2.
[PATCH v5 1/2]:- No changes.
[PATCH V5 2/2]:- No changes.

Changes from v4:-
[PATCH v4 1/2]:- No changes.
[PATCH V4 2/2]:- Removed casts and parentheses.

Changes from v3:- Changed subject line to match prefix on the patches.
[PATCH v3 1/2]:- No changes.
[PATCH V3 2/2]:- No changes.

Changes from v2:-
[PATCH v2 1/2]:- Modified subject description. Changes has been made in
v3.
[PATCH v2 2/2]:- Rectified spelling mistake in subject description.
Changes has been made in v3.

Changes from v1:-
[PATCH 1/2]:- Removed unnecessary parentheses around boolean expression.
Changes has been made in v2.
[PATCH 2/2]:- No changes.

Mitali Borkar (2):
  staging: rtl8192e: remove parentheses around boolean expression
  staging: rtl8192e: remove casts and parentheses

 drivers/staging/rtl8192e/rtl819x_HTProc.c     | 14 +--
 1 file changed, 5 insertions(+), 9 deletions(-)

-- 
2.30.2

