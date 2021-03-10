Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB05334B80
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhCJWXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:23:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52262 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230499AbhCJWXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:23:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615414984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4+4lOSq3vIhecnbI3KNZCHHzBpOut6f3fq9Jok/tPms=;
        b=Ozy1MgcZOoW3RhBYShIAHpZ/6nywJrlRpXOcnlHv8VJqE055RImraIjoQX6DPfZ09b43Jq
        d+IVwvKfHbQQEKMxNh7ZQe2XLXfTkxbxgDxJ3b1oCirgpnJ4l4UeOfUXDCrCUsFV93ASJt
        LZ9ek5KeWsRDzNiCIxlfySdyg1r7gvQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-vFegCmokMPytaieQ_d7QQg-1; Wed, 10 Mar 2021 17:23:02 -0500
X-MC-Unique: vFegCmokMPytaieQ_d7QQg-1
Received: by mail-qv1-f69.google.com with SMTP id iy2so13745984qvb.22
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:23:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4+4lOSq3vIhecnbI3KNZCHHzBpOut6f3fq9Jok/tPms=;
        b=S6DKXepJZxZvglnn3fOFeLj9dyp+zlufpTF7EmwzvOnI55ps59X6TrXyoAw8Oj93vr
         at0r0FB4lmbIZ2Rkg/4ealYOK0ZVluYHb0y7fjOTb0nW/SyFMk5t6iBI0VhiVFCt9+CD
         bVo2HMyjHHVUneAwtuR0DIm0Dbdo9xp4nsoZCMBcTal7VOnk2hHDm7PORvqi2I8v9p1G
         SzPa3JSXTbn37+UXqOAnLm4x9QhWK+43hpVzjkiYX6s3kr3gx+QrdsxuH/PpWV43UtiR
         flqSMUBGDl+4cB0uaDq4+l1HY8YegojBISQKUji93YIvlCqI2ScpZVnCBjTIkOYkskl3
         nBgQ==
X-Gm-Message-State: AOAM531sgY8oJ0Uvy0nMq4R7UNYstlpWUn+dRlIZlpQ3f/+3ZSyZMLCn
        awXFAkRpeS94QldVyZ4DuEdRIHXUgJ3GYjTdV9SypRiIKVAK+OZ7k1jiY4LvaTIM2cHwuGZFMkw
        8ZOhsFJKAOWYGEYOrzqiH4X2L
X-Received: by 2002:a05:620a:1206:: with SMTP id u6mr4695977qkj.173.1615414982369;
        Wed, 10 Mar 2021 14:23:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxrZ0MoZVzbfqM3VCqFGsolarRmIxVHVTf2hN+KL5gwkEMk9jF3alEwbNLQH1X5ZoTmSNCufQ==
X-Received: by 2002:a05:620a:1206:: with SMTP id u6mr4695953qkj.173.1615414982107;
        Wed, 10 Mar 2021 14:23:02 -0800 (PST)
Received: from xz-x1.redhat.com ([142.126.89.138])
        by smtp.gmail.com with ESMTPSA id e18sm451364qtr.52.2021.03.10.14.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:23:01 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-man@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v3 0/4] man2: udpate mm/userfaultfd manpages to latest
Date:   Wed, 10 Mar 2021 17:22:56 -0500
Message-Id: <20210310222300.200054-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:=0D
- Don't use "Currently", instead add "(since x.y)" mark where proper [Alex]=
=0D
- Always use semantic newlines across the whole patchset [Alex]=0D
- Use quote when possible, rather than escapes [Alex]=0D
- Fix one missing replacement of ".BR" -> ".B" [Alex]=0D
- Some other trivial rephrases here and there when fixing up above=0D
=0D
v2 changes:=0D
- Fix wordings as suggested [MikeR]=0D
- convert ".BR" to ".B" where proper for the patchset [Alex]=0D
- rearrange a few lines in the last two patches where they got messed up=0D
- document more things, e.g. UFFDIO_COPY_MODE_WP; and also on how to resolv=
e a=0D
  wr-protect page fault.=0D
=0D
There're two features missing in current manpage, namely:=0D
=0D
  (1) Userfaultfd Thread-ID feature=0D
  (2) Userfaultfd write protect mode=0D
=0D
There's also a 3rd one which was just contributed from Axel - Axel, I think=
 it=0D
would be great if you can add that part too, probably after the whole=0D
hugetlbfs/shmem minor mode reaches the linux master branch.=0D
=0D
Please review, thanks.=0D
=0D
Peter Xu (4):=0D
  userfaultfd.2: Add UFFD_FEATURE_THREAD_ID docs=0D
  userfaultfd.2: Add write-protect mode=0D
  ioctl_userfaultfd.2: Add UFFD_FEATURE_THREAD_ID docs=0D
  ioctl_userfaultfd.2: Add write-protect mode docs=0D
=0D
 man2/ioctl_userfaultfd.2 |  86 ++++++++++++++++++++++++++++-=0D
 man2/userfaultfd.2       | 116 ++++++++++++++++++++++++++++++++++++++-=0D
 2 files changed, 197 insertions(+), 5 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

