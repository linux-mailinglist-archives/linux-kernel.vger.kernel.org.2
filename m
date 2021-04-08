Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13EA9358EF8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 23:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhDHVIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 17:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhDHVIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 17:08:43 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91979C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 14:08:31 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so5419505pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 14:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Msl/P5VBYmBqV6Je6mPsZC+dtOoZ7h1wBoVZ4hCXTAY=;
        b=Hx5KN+AorF5YmOMYSHbs/eiVrwVX6X6RM9TTiUUn5DsEoI48Yi6MoFcbVBte/jQgJk
         5ppcin/Gwf6b8GouLBaQN6L5XVWasopRr2Ga9EwTW+k8EDt7lzOkmbyDGK2tsUv+6hoT
         eKWYBQSyIqQ3c9Utsh8UCAhova9TzHeZiRJJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Msl/P5VBYmBqV6Je6mPsZC+dtOoZ7h1wBoVZ4hCXTAY=;
        b=KaQAVkGlUUP05JJ15TPueHu84XIeobC2CIEwLT9dH4MevWJ/c44o+BTvMVi6xZiVn+
         sdqDTwgAjHItVLUk8fS0JKqibrOeXPjbIiFopjaX4AkRj4a02Qi3gxuE7p+TYm08iAOn
         z/I6EOQpkxyfRzC7Ahg2ow5AuSzYzXIfByC47tW5YmE7k7opOPHWlb/AF8bzllxUMIXO
         vonx9XqGqpSLJVSxRhZr5HgRRO9/0ieDssoaiRzeaaCKEfOJ5n9La3exMIl0BEogpYy9
         ZHGGy0RLPi5HxpMAqYxdukyWl2qLMUAY4ubwX6lrMYBRK89PvNSsY5G6UBEUKP2yUcht
         mCgg==
X-Gm-Message-State: AOAM5327hzCcXsAVVTK71knYZIxTLqTaiz2EyJyjPihQM+XlVWGrqUuK
        S6IpnlTIOaiAJno2sUbApZIn4Q==
X-Google-Smtp-Source: ABdhPJwSEusdv0hrks2wsrAQufkPNUFsfXPcCszU/2eeTr7cyteb1yMJ0MYQ+LgMq4M0wC5uVJ+ySA==
X-Received: by 2002:a17:90a:314:: with SMTP id 20mr10681376pje.72.1617916111083;
        Thu, 08 Apr 2021 14:08:31 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:44c3:3248:e7f5:1bbd])
        by smtp.gmail.com with ESMTPSA id m1sm279503pjk.24.2021.04.08.14.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 14:08:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <161791154751.3790633.14778133079958701015@swboyd.mtv.corp.google.com>
References: <20210331030520.3816265-1-swboyd@chromium.org> <20210331030520.3816265-4-swboyd@chromium.org> <YG27p1AhiOKJOm+y@alley> <161786283299.3790633.9395579294249054249@swboyd.mtv.corp.google.com> <YG7XQK1FCofMZsqM@alley> <161791154751.3790633.14778133079958701015@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH v3 03/12] dump_stack: Add vmlinux build ID to stack traces
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Date:   Thu, 08 Apr 2021 14:08:28 -0700
Message-ID: <161791610893.3790633.1523539584166901628@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2021-04-08 12:52:27)
>=20
> Can you try this patch for x86? I'll dig up some hardware in the meantime.
>=20

It works for me backported to this 5.10 kernel running on this x86
device I found. I'll wait for you to confirm and then send the next
round.

 CPU: 0 PID: 2719 Comm: bash Not tainted 5.10.27 #1 301c09d6713f73cc8761e0e=
c7c4a50f354819757
 Hardware name: Google Grunt/Grunt, BIOS Google_Grunt.11031.115.0 11/15/2019
 RIP: 0010:lkdtm_WARNING+0x13/0x17 [lkdtm bf9f9188770187b40e576292363651839=
854180c]
 Code: c7 15 ae 71 c0 31 c0 e8 b1 f9 f6 c9 0f 1f 44 00 00 55 48 89 e5 0f 0b=
 0f 1f 44 00 00 55 48 89 e5 ff 05 f3 7d 00 00 75 02 5d c3 <0f> 0b eb fa 0f =
1f 44 00 00 55 48 89 e5 8b 35 dc 7d 00 00 ff c6 89
 RSP: 0018:ffffb296c1757dc0 EFLAGS: 00010202
 RAX: 0000000000000026 RBX: ffffffffc071a060 RCX: 5d63534cda001100
 RDX: ffff8e5faac22cf8 RSI: ffff8e5faac12e08 RDI: ffffffffc071a060
 RBP: ffffb296c1757dc0 R08: 0000000000000000 R09: ffffb296c1757ba0
 R10: 00000000ffffdfff R11: ffffffffc071722e R12: 0000000000000008
 R13: ffff8e5fa615f000 R14: ffffffffffffffea R15: ffffffffc071a819
 FS:  00007ee3373f2740(0000) GS:ffff8e5faac00000(0000) knlGS:00000000000000=
00
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000058d943914918 CR3: 000000000f0a0000 CR4: 00000000001506f0
 Call Trace:
  direct_entry+0x107/0x113 [lkdtm bf9f9188770187b40e576292363651839854180c]
  full_proxy_write+0x5b/0x78
  vfs_write+0x145/0x40d
  ksys_write+0x7e/0xde
  do_syscall_64+0x43/0x55
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0033:0x7ee3372cb7f4
 Code: 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48=
 8d 05 31 40 0c 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff =
ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
 RSP: 002b:00007ffe1c6db648 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
 RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007ee3372cb7f4
 RDX: 0000000000000008 RSI: 000058d944343c60 RDI: 0000000000000001
 RBP: 00007ffe1c6db670 R08: 000000000000000a R09: 00007ee3373f2740
 R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000008
 R13: 000058d944343c60 R14: 00007ee33738b5c0 R15: 00007ee3373865c0
