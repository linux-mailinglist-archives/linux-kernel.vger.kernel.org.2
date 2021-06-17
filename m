Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15093ABE53
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 23:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhFQVqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 17:46:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22661 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229816AbhFQVp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 17:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623966230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MlLxBerkc0wbd/PrLv0vX1VgkFRCc2je/OciFMlOjyA=;
        b=Ze/gvG/9mY+X3xJ8nOKIbTSqB+w1m0hPy0I6tduiOZyUq01WLIENK1kSAzB8kBasI32G0w
        Oh3TM4gjqkC/+4tFbs659yOj24omgTvfs7KVcwwQsBP5gcOVrjHaqaGmgyF2ugQ4OxJpSl
        3g9fropOiotq2CU6mwkGclawV/LVQtA=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-KVVbNhLZNkG83PX2_Uk3gQ-1; Thu, 17 Jun 2021 17:43:48 -0400
X-MC-Unique: KVVbNhLZNkG83PX2_Uk3gQ-1
Received: by mail-oo1-f71.google.com with SMTP id l13-20020a4aa78d0000b0290245c8f11ac2so4654608oom.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 14:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MlLxBerkc0wbd/PrLv0vX1VgkFRCc2je/OciFMlOjyA=;
        b=c/PKrOt4+dUONUw39p8813DKq/y7uoKScrlBy+m/Z+N6COBFyeIZ7ltGeanqVwDBTQ
         Ml3daw5Zi23iLrUIAcd/r1BL+dVOWbtG/tYqMVJQ1pCqIW/YM8n9xttQksiPO/x/W9Wm
         1TjFezZlOODvBQ0BPCPc02y+JXqClShfizr7CtiwE1P9SeV2Eq3iJ0zZnbzzJCaHIhrk
         qNLvVI+PcrRxZL7IJw5Pap+O7lJY8ILFlCYbt7d1vfpGZP70580Ubpne2fq4lZdADWJm
         1ShGPMNj8PKfbyhOdTc1TrnXKh7LICvxca63KK5gupeLXCSBT2bZ4sMyzmAuuLwm1YXd
         gb0Q==
X-Gm-Message-State: AOAM530q2838t5rQl9FA53ZFXl5E4r4zENXG8gMHOuh1zmiBZjU4z/iY
        ulQiURe2dR+tSy3sb5zdZ9s8CZFtCJyJQwRSx83hqYk0BgW8sZBpUkQ106GWYorWde5sLNPzIHS
        c1xcHjTO/CmrQ/J6cXL3KfOxf
X-Received: by 2002:a05:6830:457:: with SMTP id d23mr6421838otc.64.1623966228053;
        Thu, 17 Jun 2021 14:43:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGayZam6nkZ0qX2VuWDLBn+si2kfPLo3x2dTs1url8XI6YXfGZrEJCga9jX4cKZEscVvGfEw==
X-Received: by 2002:a05:6830:457:: with SMTP id d23mr6421828otc.64.1623966227830;
        Thu, 17 Jun 2021 14:43:47 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 15sm1366313oij.26.2021.06.17.14.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:43:47 -0700 (PDT)
From:   trix@redhat.com
To:     arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 0/1] bug: mark generic BUG() as unreachable
Date:   Thu, 17 Jun 2021 14:43:26 -0700
Message-Id: <20210617214328.3501174-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

This is a followup patch discussed here
https://lore.kernel.org/lkml/162375813191.653958.11993495571264748407.stgit@warthog.procyon.org.uk/

Arches that defined BUG() were reviewed either by inspection or
by cross building the fs/afs/dir.c reproducer, all lotm.

There was no change to the assembly for the ppc64 reproducer.

Tom Rix (1):
  bug: mark generic BUG() as unreachable

 include/asm-generic/bug.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.26.3

