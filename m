Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E28D39E830
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 22:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhFGURf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 16:17:35 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:41884 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhFGURd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 16:17:33 -0400
Received: by mail-pg1-f177.google.com with SMTP id r1so14699440pgk.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 13:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L7rpankvGLItroXIy6lBPDNJd2uTfY22CCQPQ/XjOqw=;
        b=D4+dK8IR3YTVfzG/TXJ7zk/9sZWwjoSz+w+pbNpf62hi2i64DAyD0x5Sw0Awu48SEw
         tEmEwpTou/M6xrq3m8/EIxaQ0kli67rT9g/dH63ahpj7sGjT+mZNZWdUSwoidLKJCNni
         SSRuIZ70/Svn2YCnMtEfMVx9ITWcpBN05YM6BurUupEYDaW8/R1bZEefCaCgbZ4ER+dp
         i9ZV7IRigciiqx4POmv+JD85qZGr16tNzrp2t368bwyhIiS0pnLwDv5NaVEmVLws9Fok
         FMARqnrbxSs1uR3IV+thlGXifoe68/ac8wRrjjmsROVh3D7dAcLBmYIJkAjorc/gl5lu
         1Gzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L7rpankvGLItroXIy6lBPDNJd2uTfY22CCQPQ/XjOqw=;
        b=Y4iuB5N8m46rvkAAIUW0wbXLcqIzNdyO8elsb+1WkkSzjTC3K/4pFuFGT46uYS2vGG
         w8Vqv8edD0CwL5BMTf6TOHxkg1oBZLO4eqVfYZfjOtctKF7i5wf4fe/rApHpV3q+bUeb
         ynJB1bQqoQ6W0teJhUYVQWAxVyzlWgy8Qf/o3skrQ1Ehl0uF9oTHgorUWat6jfOX70v5
         au/Wil3m7enwpNYUSvVr4wfFuqLOR7iNINIZ8IZa+0VhdJyyLNeK+A+U7jfgI22HWWpF
         9bdIFw9SJQBHJkn6H2q3OrYvSRnt8KnW0iU8Chd2kxfCAW99RbxAdQ3ogJg+vaxldXZ8
         zpIw==
X-Gm-Message-State: AOAM533CaOx8ZJ8mnBdFD22ykW64eSTzPJ/dofv/ttDJyUufr8ckX0VT
        aBuYfI47nPSBlKEaAVV4qrnjAKAm81ydUuf834gDvQ==
X-Google-Smtp-Source: ABdhPJzEw8cm/NrkBFDUDuy7jVAtclHleIKn0U4xudYPyuV1EIQL8Sj2oL1noGD8zsxB8+Luzqlj6umWBD2LDr8hSbg=
X-Received: by 2002:a63:d0d:: with SMTP id c13mr5466147pgl.384.1623096866188;
 Mon, 07 Jun 2021 13:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622898327.git.mchehab+huawei@kernel.org> <08ac283ac5bdc2664255a7ad34514e50d3ed85d8.1622898327.git.mchehab+huawei@kernel.org>
In-Reply-To: <08ac283ac5bdc2664255a7ad34514e50d3ed85d8.1622898327.git.mchehab+huawei@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 7 Jun 2021 13:14:15 -0700
Message-ID: <CAFd5g45i-TPESs-cDosU29vcvjnjr1L0WvNqX6ZgD_-QvHW82Q@mail.gmail.com>
Subject: Re: [PATCH 02/34] docs: dev-tools: kunit: don't use a table for docs name
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 5, 2021 at 6:18 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> We'll be replacing :doc:`foo` references to
> Documentation/foo.rst. Yet, here it happens inside a table.
> Doing a search-and-replace would break it.
>
> Yet, as there's no good reason to use a table there,
> let's just convert it into a list.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks!

Acked-by: Brendan Higgins <brendanhiggins@google.com>
