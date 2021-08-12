Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B043E9E27
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 07:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbhHLFuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 01:50:46 -0400
Received: from mx.ucr.edu ([138.23.62.67]:1743 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231382AbhHLFup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 01:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1628747422; x=1660283422;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=l3zfLLXduZiIZzfIz0+CTNmC/Omgz4giYTeAfSD4EzE=;
  b=crCt8NFqPoZgcuiiTJtWeRn+8FguBHuHxtDXi2s83FGKNXPYAroIavo3
   fDI+vpdvTQQ/3MbTatQdCvx380J8fSW41lfUMLopOhgtSC/aYhdjgdDbE
   iJ37XFARTBV9J32Xh390ftRVzT9qcPsY6h6bis4/GVgx5EjFTInxgmsrv
   Vr9D32jh7/AmI4bQSa+WYd3k5UpNeb+x7L2CKvs+5UfWe/z3s/bfzBP/d
   Q8kyT31RumLZNa7J+GOwlaEttQ36256IaCOFt6k5x8NiLzOhFfslkUJ4J
   wMplc8wJHqj8YkdtKaChmX79C7FyDZXKf6QBiv2C6ZDysm7dMjCcPwcDB
   w==;
IronPort-SDR: YRSKKDIx56y5WpGHJVp0jb5pwFeX/z5HNlIX91MLs2+gAyJ1Lh5I84eU18ux/klRf/ucpyTEhA
 5suZ+CVj7y5Uw8hsEDOvC3MruVOJgfWROwkG1avlLOokD98AQtdS+EiDQ3hBxL7GXMqmpH6pA9
 oFtAZJY+xTr3zfYGIDjuglSboVClU+rikIOPlpIarUfnYiVUBnmL62Sek/1t+ivyiubFecJNQd
 FA8s3Ht+59LKjmA/prDDOftVu+13LEwESt7FPFfUNkIfJNHRbHB+Zv9sNeyRD7qLuifvIPsRjP
 D8wx3jiOYxBkMb5xhN1neTZP
X-IPAS-Result: =?us-ascii?q?A2EqAwBQthRhf0jYVdFaHgE8DAILFYFZg3hshEiRcJtjg?=
 =?us-ascii?q?XwCCQEBAQ9BBAEBhFkCgmcCJTUIDgECBAEBAQEDAgMBAQEBAQEDAQEGAQEBA?=
 =?us-ascii?q?QEBBQQBAQIQAQGBIgtZC2OBT4F5BgQ9gjUpAYNsAQEBAQMSEVYQCwsKAwICJ?=
 =?us-ascii?q?gICIhIBBQEcBhMihVcFnhuBBD2KOHqBMYEBiBwBCQ2BYxJ+KocMhmQngimBS?=
 =?us-ascii?q?4JvPodbgmQEhUQPggOBGwEBAZNbiU2CCZsGghEBBgKDDhySS4wCK4NTox27R?=
 =?us-ascii?q?hAjgT8CghEzGiV/BmeBS00BAgECAQwCAQIBAgECAQIIAQEChmKWKiQvOAIGC?=
 =?us-ascii?q?wEBAwmJFgEB?=
IronPort-PHdr: A9a23:jcLKYRCVTCoRcWtoqCkMUyQUekMY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZua81yg+TFtWHo9t/yMPu+5j6XmIB5ZvT+FsjS7drEyE/tMMNggY7C9SEA0CoZNTjbig9A
 dgQHAQ9pyLzPkdaAtvxaEPPqXOu8zESBg//NQ1oLejpB4Lelcu62/6u95HJYAhEmjWxbLB9I
 R6rsQjfq84ajJd4JK0s0BXJuHxIe+pXxWNsO12emgv369mz8pB+7Sleouot+MFcX6r0eaQ4V
 qFYAy89M28p/s3rtALMQhWJ63ABT2gZiBtIAwzC7BHnQpf8tzbxu+Rh1CWGO8D9UKs5Uiq+4
 ah1VBDoiT8HNz8n/2HRlsxwl79QrBa4qxBi34LYfISZOfxjda3fYNwaX3JMUclfVyNDAo2yY
 YgBAfcfM+lEtIT9u0cCoAGiCQWwGO/iyDlFjWL2060g1OQhFBnL0w4hH9MPsHTUsdL1P7oRX
 uC11qbIzCjIYvRW2Db86IjHaBEhre2QUb9+asfR1FUgFxnfglqOtIPlIiqY2+IQuGeU8+RuT
 /igi3I7qw5vuDivwN8hh4bNi48Ryl3K+zt1zYkxKNO3S0N2btCpHZteuiyGNoZ7XsIvTm9rt
 Son17AKpJ22cTYExZkoxBPSdvKJfpWU7x/lSe2fIi94iWp7dL6jgxu+60utx+3mWsWqzVpHr
 zBJn9vSun0Lyhfd8NKISuFn8UekwTuP0gfT5fxaLk0sjqrbLoIhwqY3lpoOrUTPBi/2l1vyj
 K+Rbkgk//Kn6+XjYrn/vp+cNZJ4hhjwMqkshMCzG+s4Mg8JX2iU/eSzyqfv8lH+QLVPlvE2k
 6/Zv47GJckDuKK1HwtY3pwg5hu/FTuqzskUkHgdIF9HZh6Ll43pNEvPIPD8A/e/mVOskDJzy
 vHGP7zhAo/CLnnfnLv9c7tw8FNcxxYpzdxF+Z1bF6wBLOrpWkDtrNzYEgM5MwuszubjCdV90
 J4eWG2WDq+aLqzSq1mI6fwrI+SXeo8VtyjyK+I/6/7tk3A5g1kdcret3ZcNb3C4BPtmcA2lZ
 i/DmNoOWUQQuQM+CczjkkGHWDgbM3moUq0/5hk/CYS7HYnEW4ahiaCA2yH9GYdZMDNoEFeJR
 EbpZYWZXL8+aCuTaptwgDwNVOD5EKc83gvouQPnnek0ZtHI8zEV4MqwnON+4PfewFRrrWQcM
 g==
IronPort-HdrOrdr: A9a23:ozsvWamZD/OkTHJZRIZBJOxNszHpDfIX3DAbv31ZSRFFG/FwWf
 re5cjztCWE8Ar5N0tQ/OxoVJPwI080sKQFgrX5Xo3CYOCFghrNEGgK1+KLqAEIWRefygc379
 YGT0ERMqyXMbG4t6vHCcuDeerIDOPpzElgv4ux80tQ
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.84,315,1620716400"; 
   d="scan'208";a="231701847"
Received: from mail-pj1-f72.google.com ([209.85.216.72])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Aug 2021 22:50:21 -0700
Received: by mail-pj1-f72.google.com with SMTP id m3-20020a17090b0683b0290178cb50bc1aso4228267pjz.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 22:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+4OvCfZOoMFqcsG6QeShyHGwKu7LE5OaUGDpdUOU7Sw=;
        b=rjwx3A3naz6dPyA6ya/O5A5WhBQHs47OzyNSDmGl/F6aF+ADKeoNGqNX+6ctOWxbt2
         4E4YndJ2huCWbt+m3Nk8Hm/ei47DSY1RL9QEZgj7ThfBbiYfu15R3FebVGtfhrHHAzLo
         zSgLBkquxRDRA/3VeQM27JtRhGtBbVCpawofFF6h2RgprxvtxzPFkHJiPSXqhk2BYrdT
         i/CuSVqEtdt5/OU/ZdlFYEoO1PeFVZ2z/sqoLT5cTeEqi3bQDY9s4JOk2PeM8mVgalD6
         iMcRJy5gmcovFVJ+8agQyFp5QpY7fWbzGUJGtltDyig28e5rTyNy1gzz8qF3z/uNr3bF
         Vncg==
X-Gm-Message-State: AOAM5339/hhHvFaI2NLG629fqtcsjB9jouhU/0LXwSFr2/hEPY4/6ujh
        qPvxl57yrDcHyY6PiA+2bjyuxrQEf8X1qJKByn15TIO6gHs7qC1ZHBijYCOQn32vSyMLbw0MsWn
        bAt/QJIVr/49qqasFZqCTi7hSw5OfCqVkknt9MJVqbw==
X-Received: by 2002:a17:902:6a82:b029:12d:2431:94c1 with SMTP id n2-20020a1709026a82b029012d243194c1mr2218880plk.63.1628747419505;
        Wed, 11 Aug 2021 22:50:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziwkiqjDIjmuU3dBBadKSg7FwSBsBGxojfwp4aZ97za34xeBhSer8/cICJlIdqG3lupuTxRl5mIIhZQ1ByBGw=
X-Received: by 2002:a17:902:6a82:b029:12d:2431:94c1 with SMTP id
 n2-20020a1709026a82b029012d243194c1mr2218856plk.63.1628747419252; Wed, 11 Aug
 2021 22:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210723003607.64179-1-yzhai003@ucr.edu> <20210811035405.17382-1-yzhai003@ucr.edu>
 <YRN11JOX/JHpq8Yn@kroah.com>
In-Reply-To: <YRN11JOX/JHpq8Yn@kroah.com>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Wed, 11 Aug 2021 22:50:08 -0700
Message-ID: <CABvMjLSFKVV_uC3n02t=p6X+qaptgZiCrVmy2875OMybN=e+Jw@mail.gmail.com>
Subject: Re: [PATCH v4] media: atomisp: fix the uninitialized use and rename "retvalue"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Juan Antonio Aldea-Armenteros <juant.aldea@gmail.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg:
Sorry for the inconvenience, let me fix this issue and send a new one, thanks.

On Wed, Aug 11, 2021 at 12:01 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 10, 2021 at 08:54:03PM -0700, Yizhuo Zhai wrote:
> > From: Yizhuo <yzhai003@ucr.edu>
>
> This name is not matching the name you use in your signed-off-by line :(



-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
