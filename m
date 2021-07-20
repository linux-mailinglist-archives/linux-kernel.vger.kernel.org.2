Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A037E3D021B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 21:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhGTSjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 14:39:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231439AbhGTSik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 14:38:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84A5760FF2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 19:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626808758;
        bh=ekEnSV9ZmSGhjal9qG0LZOxeTSsU1nfka+A/MMmR0FI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y6iDVoaZdLsFSpqS+YFuA77dTYi0rgbFroI6RNmfjGWwcXi5GvRXzuSlrjF6h+lcz
         levlSVSSthqeqeGyk53aGUqlQBORn59plSqPbc2XgaHd6ZqovLlBcA0zGWxTzv7zev
         hDZJiqvRFaSRDMoSHhx+cPVr8Ud99WBYBPyHaUQFMvD5f+kzjRYktkp4uglro7jXp1
         4kjOn6vnOWHT9PLK/iJs+3zthi0P8bTJn+Go6+IYqnlsjqinQzuX5BAEEbojualcKF
         5AJWELU0mpnnZZladoE7LkDIfmpanP5tlNbRpLO3BLiQ2vufkPjhGNInuUSrRLRpaC
         7AuqpaVMwd1oQ==
Received: by mail-wr1-f43.google.com with SMTP id f17so27177929wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 12:19:18 -0700 (PDT)
X-Gm-Message-State: AOAM533rP05DvKJ1EXw19IRlkRk2lxy2bUbESTWp55+EK4M/veTCH0VX
        T4ayAn8hcnXukMqWTG1J4Lr5im2nYA+JWoK5yTI=
X-Google-Smtp-Source: ABdhPJwLsIlSzNXoHGHbPM0LbJfaXpfRrLGnxPrv4tF7po0cMh1HRmNRvICJKpig76DaAl1pJrFGmz8P4eJex59tnSM=
X-Received: by 2002:a5d:438c:: with SMTP id i12mr38197403wrq.99.1626808757173;
 Tue, 20 Jul 2021 12:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210626130404.033700863@goodmis.org> <20210626130538.003082428@goodmis.org>
In-Reply-To: <20210626130538.003082428@goodmis.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 20 Jul 2021 21:19:01 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3aXP2+oXQMWE-4tagcy3O+1-K_gt+p10uXaxkBk-sF9w@mail.gmail.com>
Message-ID: <CAK8P3a3aXP2+oXQMWE-4tagcy3O+1-K_gt+p10uXaxkBk-sF9w@mail.gmail.com>
Subject: Re: [for-next][PATCH 19/24] tracing: Add LATENCY_FS_NOTIFY to define
 if latency_fsnotify() is defined
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2021 at 3:10 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>
> With the coming addition of the osnoise tracer, the configs needed to
> include the latency_fsnotify() has become more complex, and to keep the
> declaration in the header file the same as in the C file, just have the
> logic needed to define it in one place, and that defines LATENCY_FS_NOTIFY
> which will be used in the C code.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

This still doesn't seem quite right. I just came across this randconfig build
warning on 5.14-rc2:

kernel/trace/trace.c:1712:13: error: 'trace_create_maxlat_file'
defined but not used [-Werror=unused-function]
 1712 | static void trace_create_maxlat_file(struct trace_array *tr,

See https://pastebin.com/raw/b3DH7hWg for the .config that triggered it.

       Arnd
