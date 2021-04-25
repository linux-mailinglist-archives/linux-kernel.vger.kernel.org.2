Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C368C36A5A1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 10:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhDYIBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 04:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhDYIBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 04:01:14 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E333C061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 01:00:33 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a5so23449934ljk.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 01:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wO5bRVcyt6yZoz6NLAkY2DduZypjGZo15T9PtBh9i8s=;
        b=cAhp0WT7d7J+4pFI+vBcQTlxZcaTldrIsJ9XYCVKupmFC/fCcLgMENRzugC2IJ5T9S
         Dvr1N01QlHGOJhZNBnUDOh2KFtF7GNbF7pWPRvHf2DiC0F2KwLSNtVKg51476nN/nJ02
         SbE94R5eoVLifGKELbNUL9qJJYpxMTXduETvpKWiYQfatWc1B5gYzft1VlibnMPvPt3x
         1DIHhgX3Vp02gEuYGb7Dv3QA3MMu4KuJYqqCdF3oDt0tlbGkeUqPEcb9n8Wjq1ltOOa2
         otWY1kBsgvzUY9/UoKQDuDZFPOcW6ePKBg2qzefc1olk/yAgfa16khJL0m2coJhh/zGP
         fJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wO5bRVcyt6yZoz6NLAkY2DduZypjGZo15T9PtBh9i8s=;
        b=txt1afsDLEdrsk+AASUffcYh7SucCm4H2hZbMWMB47yaYZRUqb/iLotyJNfYFa3sQz
         0Sr4g6UWjP8M5fFkUtQltRFqoZwtuKI3n1qpuseRF+12c7XEtz49iNNikZl+0Mng/7vU
         vBEpn6L3rphmd4xSOD0cyf75lgLwS7E7qCTGQyMV42cXp6OEnl9PNxRP4N6opEx1rRRc
         RkAq9NKp1GOES4Lv46FDZm8RNMd3qmSRNYE6Pu/9vxTGInXiMDs9DKFe+ZYvRIoZY+p4
         WcT8AY8HiXhA5WQtSITgkk4GUFZP4fIVy64xZoEyc1w/rKfRSCvtsaTTIzi9AlOHJktN
         Q1qQ==
X-Gm-Message-State: AOAM530q9yz0k0mDQyIomH02XXNM4AI3jYDojYQcuUHuQTZsiV/2PYng
        9k73gcERm20nYWMS9NypDvcTTb9Jy1cQDaopOSM=
X-Google-Smtp-Source: ABdhPJyjOh/6dhXQykPOrsI7n3ZdZ17Y1IBcC+zADLLdiN4xRp7tgW7vcM6d4iHg1Bi+wC2K80a779B/34dp34Shp/w=
X-Received: by 2002:a2e:8256:: with SMTP id j22mr9019755ljh.284.1619337631808;
 Sun, 25 Apr 2021 01:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210425074450.6902-1-dwaipayanray1@gmail.com>
In-Reply-To: <20210425074450.6902-1-dwaipayanray1@gmail.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sun, 25 Apr 2021 13:30:28 +0530
Message-ID: <CABJPP5CGCagfP1NTO5ci-wWNN9AOx2j-4i0Bj6G2mPXeja2jEg@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: fix uninitialized return value in raw_line subroutine
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 1:14 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
>
> In case the second argument to raw_line subroutine is 0,
> $line remains uninitialized and is returned back to the caller.
> If the caller then tries to perform string concatenation with
> that value, checkpatch throws an error:
>
> Use of uninitialized value in concatenation (.) or string at
> ./scripts/checkpatch.pl line 1960.
>
> Fix it by providing an empty string as the initial value
> for $line.
>

Please ignore this patch. There was a different problem which
caused the error.

The following line triggers the errors:
DEVICE_ATTR(foo, 0777, foo_show, foo_store)
(notice the missing semicolon)

Perl throws the following errors when checkpatch is run on
a file containing that line:

Use of uninitialized value in concatenation (.) or string at
./scripts/checkpatch.pl line 1960.
Use of uninitialized value in concatenation (.) or string at
./scripts/checkpatch.pl line 1960.
Use of uninitialized value in concatenation (.) or string at
./scripts/checkpatch.pl line 1960.
Use of uninitialized value in concatenation (.) or string at
./scripts/checkpatch.pl line 1960.
Use of uninitialized value in concatenation (.) or string at
./scripts/checkpatch.pl line 1960.
Use of uninitialized value in concatenation (.) or string at
./scripts/checkpatch.pl line 1960.
Use of uninitialized value in concatenation (.) or string at
./scripts/checkpatch.pl line 1960.
Use of uninitialized value in concatenation (.) or string at
./scripts/checkpatch.pl line 1960.
Use of uninitialized value in concatenation (.) or string at
./scripts/checkpatch.pl line 1960.
Use of uninitialized value in concatenation (.) or string at
./scripts/checkpatch.pl line 1960.

Setting $line to "" in raw_line fixed it. Probably -1 is being
sent as the second argument to raw_line which results
in the uninitialized thing.

Thanks,
Dwaipayan
