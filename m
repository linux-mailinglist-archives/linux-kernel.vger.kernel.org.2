Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BA833328E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 01:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhCJApd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 19:45:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27341 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229775AbhCJApQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 19:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615337115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=W98fuu229Cun2sqDqrjOiHtCzvQ3USdusEfS/X1ze5s=;
        b=cPz+DEEiaCLzrziiX0u6WdDtegg7uyJNOXs1Tk257he5zXJZp7657X0/sztl5iZzZSIf+3
        DTHyfMSWTU7Qz4Kjbj1SbKLuJcSKUvZe+86qmfKlJJ4z6Y9IKhXCH258pBZmymNGLpjdlI
        NPkXHeV4kM8BxyKG7RFwjGAiQcIcUrs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-w1aKF8PcPOqNYbR1v7FeKQ-1; Tue, 09 Mar 2021 19:45:13 -0500
X-MC-Unique: w1aKF8PcPOqNYbR1v7FeKQ-1
Received: by mail-qt1-f198.google.com with SMTP id m8so9694063qtp.14
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 16:45:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W98fuu229Cun2sqDqrjOiHtCzvQ3USdusEfS/X1ze5s=;
        b=daF/CdxnolY/blGZqSMGCz9CRchT47U8eOtCooZZCtZoJFHjMrf0moBQ81LhnwH3+z
         bxbpo2T8bp3+lqa2pwt+nThOFXQO5RhZ0WOv4iPGH4PhKGz5OTKg6OFgJriV7SwwkyGZ
         LSvtAkCEHFrtCfdIzNKnhs6AhbENKJPB63MOjim8kUF2VX5/iS8UDV1O1simymbRRN6e
         R8inz9GYlzdpA5b2FketcN53VimJ8DM37kkm1vTB7dyreRICdbq186fvA+MghiNoqo/s
         W9ixklLWLT655gbTvRtq8syNv9SROBa+E4dxLfz1CWBfqUnwxXqgsDo/2nchUVbC7pnB
         +nAg==
X-Gm-Message-State: AOAM532wtGqPYGKRZjoKitkyrIORxIr/nnbJ5R1csgsDBp0LfIPSJrZE
        HS1BwBNnsOJ+FsRn7ORLSz6tdXILU3b1MO3xhSdlO9eaaoNUZyDZIQxx1onnj4NHiFYh9T4isFg
        KS+ZCL6YFsRMEawNF5j7cCgpP
X-Received: by 2002:a37:7985:: with SMTP id u127mr350153qkc.333.1615337113323;
        Tue, 09 Mar 2021 16:45:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQmVhJtqSjUci8fVJ8o5WZ7jjvrbupE5H7DdcgunffLV1/oC/SbCBDMPCDN2MW56G7CoQWWw==
X-Received: by 2002:a37:7985:: with SMTP id u127mr350131qkc.333.1615337113047;
        Tue, 09 Mar 2021 16:45:13 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id b27sm11418173qkl.102.2021.03.09.16.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 16:45:12 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 0/5] userfaultfd/selftests: A few cleanups
Date:   Tue,  9 Mar 2021 19:45:06 -0500
Message-Id: <20210310004511.51996-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on v5.12-rc2-mmots-2021-03-08-21-54.=0D
=0D
I wanted to cleanup userfaultfd.c fault handling for a long time. If it's n=
ot=0D
cleaned, when the new code grows the file it'll also grow the size that nee=
ds=0D
to be cleaned...  This is my attempt to cleanup the userfaultfd selftest on=
=0D
fault handling, to use an err() macro instead of either fprintf() or perror=
()=0D
then another exit() call.=0D
=0D
The huge cleanup is done in the last patch.  The first 4 patches are some o=
ther=0D
standalone cleanups for the same file, so I put them together.=0D
=0D
Please review, thanks.=0D
=0D
Peter Xu (5):=0D
  userfaultfd/selftests: Use user mode only=0D
  userfaultfd/selftests: Remove the time() check on delayed uffd=0D
  userfaultfd/selftests: Dropping VERIFY check in locking_thread=0D
  userfaultfd/selftests: Only dump counts if mode enabled=0D
  userfaultfd/selftests: Unify error handling=0D
=0D
 tools/testing/selftests/vm/userfaultfd.c | 742 +++++++----------------=0D
 1 file changed, 235 insertions(+), 507 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

