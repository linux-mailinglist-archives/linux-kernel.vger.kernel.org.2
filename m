Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9D73C60A7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 18:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhGLQe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 12:34:56 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:54973 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbhGLQe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:34:56 -0400
Received: by mail-io1-f69.google.com with SMTP id m14-20020a5d898e0000b02904f7957d92b5so12163895iol.21
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 09:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=g1EnsL14HF8LdZjkBNd6tkp4dBn0hH7K4Mtz8YY7q50=;
        b=CF3XWRSi/8qi4Wh1ohnGsgmZeh7vfUHFDpr4BEgsC87kWBc9QAIe4DCDaeyCdwl/3k
         vQJRutpjvEiGBNkEqCCeSiyPMd8DBfRM03UfPlNTsYYhhEf9FBqHyyemT4YXMuTKzOpS
         XqlHXJ37dCfn/idvPibWLNMKadAxjp/N2QNBssa0HTOwME1ZGgyZwujkmeLpWZOQpeP4
         5za6VbPywwcRuqmfW0LNI9/TygRTDxLe4KoEwKBbpKILtYjW9l+nLikWqymx5NoHGarY
         Psv2G4Y8VJyDob+icUBoQnrQyHgzbAOwu1l7DfRQulO8FmNJkbLDYTWq94zAYKQDzdhB
         mBjA==
X-Gm-Message-State: AOAM531gRm49TF3lONkYKy/RIGJ0MV+vmHX+4ITpX7sAMjTo2rJ/lx4v
        Q6LeYEjn5H/WH5z3JOBYMJQt65fgneYJH6A9o4sGrnh4u63q
X-Google-Smtp-Source: ABdhPJx1HhlhyKyd/XTamXxBtDH5sKiC6WYruOEUPDeaHoqYYaVScDTEIO+gdoCm1CaNZ7P/F+GIzgfdUW5rTygF+IPU2D3pshZS
MIME-Version: 1.0
X-Received: by 2002:a02:9f89:: with SMTP id a9mr13383499jam.51.1626107527446;
 Mon, 12 Jul 2021 09:32:07 -0700 (PDT)
Date:   Mon, 12 Jul 2021 09:32:07 -0700
In-Reply-To: <20210712161445.GA321728@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a429705c6efa94c@google.com>
Subject: Re: [syzbot] WARNING in do_proc_control/usb_submit_urb
From:   syzbot <syzbot+72af3105289dcb4c055b@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mathias.nyman@linux.intel.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+72af3105289dcb4c055b@syzkaller.appspotmail.com

Tested on:

commit:         ee268dee Add linux-next specific files for 20210707
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=59e1e3bbc3afca75
dashboard link: https://syzkaller.appspot.com/bug?extid=72af3105289dcb4c055b
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14b945d8300000

Note: testing is done by a robot and is best-effort only.
