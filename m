Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA64C30A629
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbhBALGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:06:14 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:43768 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbhBALFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:05:53 -0500
Received: by mail-il1-f197.google.com with SMTP id b4so13271575ilj.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 03:05:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=hJQOQRKY0dVzOCXS/HKD2cAkQX1ygeAUzi8IeN/ekfU=;
        b=Bw+zgQUMhRoY1Jlm8p2H5Kia/LRrV0wWwRpLQMUaEw43srSt/an7hq703RYt7Otw6Q
         lgG09xMVZg+bWkRt5BYegZykrOff7mShlgy7kkJDmaZtF8TYeisUm4A7DyFJzjlRaNfY
         nmYJd3NE9nkjOHvDfqhbOCiRxqYpHYKi7+8A4zZtSA6X+qimAcEDS3rCAstWS0sw1Ptg
         SzxhnDEWHcGYos96kXFKwo2uiTYkiwDaOFRpEtwo4sZZTMGxMMVasniQGyZGWGCucs65
         u75hPNdHYAXtOTuOizaJJaNQdHOqmuilgxjDxoz5UaMcIiyELZ6P8uWuec7dMtq1aaWD
         dKkQ==
X-Gm-Message-State: AOAM531n8TLMXQXjuvVdRstmS8CBXy3EInwyDnZowjX4YHuaibfo9dHm
        DxqjJGx0MHQHGX7k1biI6gVsgNEqjw1jOVFeSv6tpbLImIwh
X-Google-Smtp-Source: ABdhPJwI+EmkHMf0DTBwZMv5lgn2W6hnUt+rnGz3MNckYJhYDzOi15MKNkcfu1h/ZfOviGJPwwoWL3CW+LUd3q6ZMDe78S2nwatp
MIME-Version: 1.0
X-Received: by 2002:a6b:b7d3:: with SMTP id h202mr5653934iof.97.1612177512858;
 Mon, 01 Feb 2021 03:05:12 -0800 (PST)
Date:   Mon, 01 Feb 2021 03:05:12 -0800
In-Reply-To: <4151792.1612177504@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f80b3205ba445357@google.com>
Subject: Re: Re: KASAN: use-after-free Read in rxrpc_send_data_packet
From:   syzbot <syzbot+174de899852504e4a74a@syzkaller.appspotmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     dhowells@redhat.com, hdanton@sina.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git 7ef09ba11b33e371c9a8510c1f56e40aa0862c65

This crash does not have a reproducer. I cannot test it.

>
