Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793AA41087C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 21:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbhIRT7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 15:59:35 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:56967 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbhIRT7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 15:59:31 -0400
Received: by mail-io1-f70.google.com with SMTP id z71-20020a6bc94a000000b005d09bfe2668so27622154iof.23
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 12:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ivh/Frp5TC2qWcIkr/BnJSK/kFt1+2bIZQL24hbwT64=;
        b=anrwkpRpF6rVEdLutjth5D/mCTvXyVsdurLDgGhhInOOQ+roACfOAzz8pYzWRKLZkN
         HL4E2ckecF24BtJ/mPo2Z84zdrExYEWKuOkA16AHEKg9cJDUi5a8SnaAB9q4c0bW9vXX
         g3socmve0CP6cghM3hxnUxK4SXXot795le4cX1D73vcf/z4Ou1FM8xHQDMlZwTHLARHL
         KwKezgcyWyVW2RS1WYMAfleUnUXeuymn/8JHK9fdCkZYTGwkf/xWxWihndZsvnM/WDg9
         cQV4QtRRVn0mm8cbq34LqdlpYstM1AYZhsvpE+cnFmzdxdBqK3kE47vgwyRjZQIStP9U
         INbw==
X-Gm-Message-State: AOAM53141ORRz/IXiE4hEW8J2AH330UY1qqvzWv4I1rtm1e/ZWjrj3tc
        c0G9395zdbIVWFlEoyBrLzJXldzYvMZ6wWBKDbEHz5IdZSfl
X-Google-Smtp-Source: ABdhPJzgs6ARQpi5xrqA8t2HeKzas+2uSX6PdE7YGSaYgxMRzN33nmneQgyfAzSK2loGTkvCoPd75fBvS4XdGFR4xW6TboTeWQui
MIME-Version: 1.0
X-Received: by 2002:a6b:610a:: with SMTP id v10mr6389678iob.167.1631995087634;
 Sat, 18 Sep 2021 12:58:07 -0700 (PDT)
Date:   Sat, 18 Sep 2021 12:58:07 -0700
In-Reply-To: <000000000000fe7dd005cc2d77c0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000079478a05cc4a7730@google.com>
Subject: Re: [syzbot] kernel BUG in vmf_insert_pfn_prot
From:   syzbot <syzbot+2d4f8693f438d2bd4bdb@syzkaller.appspotmail.com>
To:     airlied@linux.ie, christian.koenig@amd.com, daniel.vetter@ffwll.ch,
        daniel.vetter@intel.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linaro-mm-sig-owner@lists.linaro.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, sumit.semwal@linaro.org,
        syzkaller-bugs@googlegroups.com, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 8b93d1d7dbd578fd296e70008b29c0f62d09d7cb
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu Aug 12 13:14:10 2021 +0000

    drm/shmem-helper: Switch to vmf_insert_pfn

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1277054f300000
start commit:   9004fd387338 Add linux-next specific files for 20210917
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1177054f300000
console output: https://syzkaller.appspot.com/x/log.txt?x=1677054f300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45d5ac72f31f29f3
dashboard link: https://syzkaller.appspot.com/bug?extid=2d4f8693f438d2bd4bdb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ad5527300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13beef77300000

Reported-by: syzbot+2d4f8693f438d2bd4bdb@syzkaller.appspotmail.com
Fixes: 8b93d1d7dbd5 ("drm/shmem-helper: Switch to vmf_insert_pfn")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
