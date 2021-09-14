Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E17140AF70
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 15:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhINNoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 09:44:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233332AbhINNoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 09:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631626976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=jewliOMoymG5rXVJn02fxoFBXvIvVLdk8M/V9Z5usRQ=;
        b=CvO8aVNoAWJ48O+56moTWpk+1zJ+8IuByFPOU6Oyd3CWSW0d2abHDr2wfzdITeYDSe/dga
        a6nM49eYFvlkdKPnK5HamBlv/oh/S/NIBrGVz8VUTwrfgM2WRsMr8wq7XdqUjZLjqmHLfd
        9267ghif9PZ1XvdGYqMB+i2Su0CmsK4=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-7DD7Zr2RO5KTuNA9XYOzqg-1; Tue, 14 Sep 2021 09:42:55 -0400
X-MC-Unique: 7DD7Zr2RO5KTuNA9XYOzqg-1
Received: by mail-oi1-f200.google.com with SMTP id s1-20020a05680810c100b00268d4e0d155so8570014ois.15
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 06:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=jewliOMoymG5rXVJn02fxoFBXvIvVLdk8M/V9Z5usRQ=;
        b=4/oPh1zJ5PYNpgDhOkOuUVkhBt4oHGGGlgGedi6CQKV8TOSETmu181UVdQozwo8VMW
         4cbS9Ko/7+HuVqRlT64muL27IgJtgSZBlK6WJYdXfRs0yhUnJ6raefe8OKlwsNtkVnOt
         WwXzToVYMxr3RWBaf1Ymy8Xbgs3xwEOzyEB2rYSma7vvKHZaeF1EuBHyVrx4hRN0epZN
         YvZCqXNrUNLQ/rLV9gBlVEmZIDzhLCL377+7orabweb8CFGd1dXYpvRRpsdjbsrmdVTI
         EkyaU2dWGCZwmh4MS1hI1WsY5PwI0aoEzBvNAKqDvKeEDZ/2EV9bVOZm90n36YgbZ5OI
         JzsA==
X-Gm-Message-State: AOAM530w4Iy+r+MCG47SSRR/C7xBby5wWYSEhgHk9ddoUYoTEWuMimAB
        9C9nE9Sy+4rjsnDOw4/xn+LN4CCz2Vcihzm95hx3Sh2IN3pJ9vrgTSMbE9DVJqLUgc+yZy/VNH/
        jLqXR5VbxAPRLP4FL4Ggb3lOCBjZCjDnOACvD7sZ/
X-Received: by 2002:a4a:b502:: with SMTP id r2mr14102825ooo.70.1631626974982;
        Tue, 14 Sep 2021 06:42:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMIQUlfxqrsC+2bS/iQPITAGVoQjPry2ufHDYgLSd+g2eZ2C36iW//5CotpIeKeoLhwhrTU8SDK9jFyxL97+I=
X-Received: by 2002:a4a:b502:: with SMTP id r2mr14102813ooo.70.1631626974754;
 Tue, 14 Sep 2021 06:42:54 -0700 (PDT)
MIME-Version: 1.0
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Tue, 14 Sep 2021 15:42:43 +0200
Message-ID: <CA+QYu4rSCmGt8Do8_qbi1fyHA8CyuL-vhzTfTKfHVOpyVjYH0A@mail.gmail.com>
Subject: kernel-rt: BUG: sleeping function called from invalid context at mm/vmalloc.c:2664
To:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     CKI Project <cki-project@redhat.com>,
        Xiong Zhou <xzhou@redhat.com>,
        Memory Management <mm-qe@redhat.com>,
        Juri Lelli <jlelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When testing commit "8a084036f2bc - v5.14.2-rt21" from
https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
during "cifsv3.11" test part of xfstests [1] we hit the following
issue:

[13099.772703] BUG: sleeping function called from invalid context at
mm/vmalloc.c:2664
[13099.772709] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid:
613586, name: cifsd
[13099.772712] 1 lock held by cifsd/613586:
[13099.772715]  #0: ffffffffc0eb76d8 (&GlobalMid_Lock){+.+.}-{2:2},
at: cifs_mid_q_entry_release+0x15/0x110 [cifs]
[13099.772816] CPU: 7 PID: 613586 Comm: cifsd Not tainted 5.14.2-rt21 #1
[13099.772820] Hardware name: AMD Pike/Pike, BIOS RPK1506A 09/03/2014
[13099.772822] Call Trace:
[13099.772828]  dump_stack_lvl+0x57/0x72
[13099.772838]  ___might_sleep.cold+0xb6/0xc6
[13099.772845]  vfree+0x3f/0x50
[13099.772852]  put_task_stack+0xcf/0x140
[13099.772858]  __put_task_struct+0x46/0x180
[13099.772862]  cifs_mid_q_entry_release+0xce/0x110 [cifs]
[13099.772944]  cifs_demultiplex_thread+0x797/0xcb0 [cifs]
[13099.773031]  ? mutex_is_locked+0x1/0x20
[13099.773042]  ? _raw_spin_unlock_irqrestore+0x37/0x40
[13099.773050]  ? cifs_handle_standard+0x190/0x190 [cifs]
[13099.773121]  kthread+0x15c/0x180
[13099.773126]  ? set_kthread_struct+0x40/0x40
[13099.773134]  ret_from_fork+0x22/0x30


So far we've hit this problem just once, more logs can be found at [2].


[1] https://gitlab.com/cki-project/kernel-tests/-/tree/main/filesystems/xfs/xfstests
[2] https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefix=datawarehouse-public/2021/09/13/369543188/build_x86_64_redhat%3A1584042034/tests/xfstests_cifsv3_11/

Thank you,
Bruno

