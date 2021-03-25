Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDC134947E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhCYOrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhCYOrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:47:20 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412BFC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:47:20 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id dm8so2733405edb.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3m9zvm/uNXQp4Nhn3WtheY2obop3zeU7t0enahEMFMY=;
        b=D/yF501s1/e/qxWHddNUFGHsQkb/eUOCko7GrSZ4vz8udmBvAXZ0yfxgrkg0mgdtAD
         O26PtrbHEl0qxoy7/ZuOUmMgYUyPMsYuvJ3DPoqDvyeIY1kApo1iGSXwdqtIpX9pYg10
         mYgRWNd6n1uXm/k+H+UQY+4myVZ6V7DaHnr7N4Ur1JPZIRcDZHqDzCIrbofomN90AbwB
         fQ/i0W3UTSZjnPjdGNfdHBZ5zdGTDO/BKjgAcTkPdKzZrhutzVco1OxxSjREuIvosw2Q
         tcIvv/h5560nwWeKoUSuHVqxtmML6FsNXObeXs7+r3n/+ycMqtpnr/VBbZxD4K7RKijO
         d3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3m9zvm/uNXQp4Nhn3WtheY2obop3zeU7t0enahEMFMY=;
        b=DrWaSPlgmQPRFKmTW2YP+zQJTFOF65liZBeUaYfKwvriyUH7nrhs68tr0TG81wIUdo
         bCvzFg1X29J8aRM03n4JRz2qb8Teg8P2bV/66UVbKKpkdO8OC2AQx4uhCmMOps6QyXs/
         PkoAGLVWQezCzWyYJcLyhEDTigk6QoNmnR4dY2Ggw3j5/1xtB0QpLbZfC3XAXjMwKBan
         A2eURbxjhPc85wQvmMvQr+B1zkyleDoRbx0aDdqc60KNYRcYWuZXeMewJYRgItaRyf7q
         ZsvcpYUXnfES5DgO/yCW2Hy/Cf649DYM8RiKDwsircZJCxBgrb9qFJPvAypJF9R2gOCG
         POJg==
X-Gm-Message-State: AOAM530J2pTuZS9c+2VM+RoXCFo57pyP1jOUVHfZygQjo3j3QUEZSdw2
        pSgfTu8g51KFJZ74/ZOtpr/2guNdUVZmIvANyg==
X-Google-Smtp-Source: ABdhPJyI4mmVPIK/XpB8N8Xr76HppNjUJrjQoiu3Tt92psheShuoJUX/a7DoAV66TZJAIutDHyvwZOx7eU34c8HF8DY=
X-Received: by 2002:aa7:c98f:: with SMTP id c15mr9719993edt.231.1616683639014;
 Thu, 25 Mar 2021 07:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210316141916.447493-1-rsalvaterra@gmail.com>
In-Reply-To: <20210316141916.447493-1-rsalvaterra@gmail.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Thu, 25 Mar 2021 14:47:07 +0000
Message-ID: <CALjTZvaX8miSycr4oGmF_rGN4KWWBzfyBj1-7jefT=Uz3w9Oww@mail.gmail.com>
Subject: Re: [RFC PATCH v2] jffs2: add support for zstd compression
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     lizhe67@huawei.com, christian.brauner@ubuntu.com,
        gustavoars@kernel.org, trix@redhat.com, keescook@chromium.org,
        dwmw2@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping (and also cc'ing dwmw2).

On Tue, 16 Mar 2021 at 14:19, Rui Salvaterra <rsalvaterra@gmail.com> wrote:
>
> Implement support for zstd compression in jffs2 at the default compression
> level (3).
>
> Lightly tested in OpenWrt, on a single CPU embedded MIPS32 system (AirGrid M2).
