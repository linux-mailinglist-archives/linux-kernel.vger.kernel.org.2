Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F0C3CFE8C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 18:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240387AbhGTPVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 11:21:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22436 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237091AbhGTPRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 11:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626796623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Lwb/S+J+gslC2Y28b3P4zMlQmindrrr+LZzI9LinPc=;
        b=d4CcEfZiGWpfbK9ozp9WthWqFQvygaQBuevq37gyEfkY8LhowDSn9UaG2prDgPAdRKC3+0
        mvHA/Jl8qfwwPSRwPceWcpL1Qc1ZLj+vX3T9J9v1wtTukQFemdD7H9abSejGaQRQVIhd3O
        7/+Y00B1TFvWPhai32WwndmtqWWX/Lg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-J4Yrp6weMsiyRnwpi_gq1w-1; Tue, 20 Jul 2021 11:57:01 -0400
X-MC-Unique: J4Yrp6weMsiyRnwpi_gq1w-1
Received: by mail-qt1-f199.google.com with SMTP id e7-20020ac84e470000b029025ca4fbcc12so12471541qtw.18
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 08:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Lwb/S+J+gslC2Y28b3P4zMlQmindrrr+LZzI9LinPc=;
        b=WjWIQcKuZqbiINchTZsa1j7Xb6MxthmBxnqNHXzZeqYImsPcjW+XkYAu90Bywqqb3i
         tJ3xmbxDeRE1j/IEeOYhRgPl6L5oWxyfOZOdOzKR+nCkYDE0ss5xwY1eFWLN3BSRZ/Wc
         UJRUER4a1Sd6d1VBQq9qaKdm7izUmbB3/hLnt2VCtKuIXKub9SiyrQ+0neTiihoAEmxC
         2EtSxLCi8cLUEzSH/CnpwKiwjFLiExb68beSXwpPtt1nlUENVjS5h08R55oj3GECvElu
         HSJK4qOFbONc6YE/RPyHckC2f94WPXHPbm3F91xl6ch1Ql8jRi0l5MDaJZEeL5GHuH0F
         nREA==
X-Gm-Message-State: AOAM5323UnbJ95Rz/4dEUbKXMFn3yJf5R+jbDNCvIM5R6rZFH9g0bqZh
        qmmBzmlMCfFx1HneWTYszajd+5zdTSaQA8LePwi0szU0ElOASi/hjkEDnyAUzPmuFE0Y9H8ogDV
        4JEFrvII0p6/2PG6yYYFtLkrQ
X-Received: by 2002:ac8:5ac3:: with SMTP id d3mr27100968qtd.257.1626796621457;
        Tue, 20 Jul 2021 08:57:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwE0JZxI8C6H+JP4haDAXSMgAMN5qTlpp01szfWOjLU+DL8S7l+xGlXl6hHUCHSo3cqzozHRQ==
X-Received: by 2002:ac8:5ac3:: with SMTP id d3mr27100943qtd.257.1626796621218;
        Tue, 20 Jul 2021 08:57:01 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id 74sm5298585qkh.42.2021.07.20.08.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 08:57:00 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Igor Raits <igor@gooddata.com>, peterx@redhat.com,
        Hillf Danton <hdanton@sina.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH stable 5.10.y 0/2] mm/thp: Fix uffd-wp with fork(); crash on pmd migration entry on fork
Date:   Tue, 20 Jul 2021 11:56:55 -0400
Message-Id: <20210720155657.499127-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <796cbb7-5a1c-1ba0-dde5-479aba8224f2@google.com>
References: <796cbb7-5a1c-1ba0-dde5-479aba8224f2@google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In summary, this series should be needed for 5.10/5.12/5.13. This is the 5.=
10.y=0D
backport of the series.  Patch 1 is a dependency of patch 2, while patch 2=
=0D
should be the real fix.=0D
=0D
There's a minor conflict on patch 2 when cherry pick due to not having the =
new=0D
helper called page_needs_cow_for_dma().  It's also mentioned at the entry o=
f=0D
patch 2.=0D
=0D
This series should be able to fix a rare race that mentioned in thread:=0D
=0D
https://lore.kernel.org/linux-mm/796cbb7-5a1c-1ba0-dde5-479aba8224f2@google=
.com/=0D
=0D
This fact wasn't discovered when the fix got proposed and merged, because t=
he=0D
fix was originally about uffd-wp and its fork event.  However it turns out =
that=0D
the problematic commit b569a1760782f3d is also causing crashing on fork() o=
f=0D
pmd migration entries which is even more severe than the original uffd-wp=0D
problem.=0D
=0D
Stable kernels at least on 5.12.y has the crash reproduced, and it's possib=
le=0D
5.13.y and 5.10.y could hit it due to having the problematic commit=0D
b569a1760782f3d but lacking of the uffd-wp fix patch (8f34f1eac382, which i=
s=0D
also patch 2 of this series).=0D
=0D
The pmd entry crash problem was reported by Igor Raits <igor@gooddata.com> =
and=0D
debugged by Hugh Dickins <hughd@google.com>.=0D
=0D
Please review, thanks.=0D
=0D
Peter Xu (2):=0D
  mm/thp: simplify copying of huge zero page pmd when fork=0D
  mm/userfaultfd: fix uffd-wp special cases for fork()=0D
=0D
 include/linux/huge_mm.h |  2 +-=0D
 include/linux/swapops.h |  2 ++=0D
 mm/huge_memory.c        | 36 +++++++++++++++++-------------------=0D
 mm/memory.c             | 25 +++++++++++++------------=0D
 4 files changed, 33 insertions(+), 32 deletions(-)=0D
=0D
-- =0D
2.31.1=0D
=0D

