Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06253AE4C0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhFUIaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhFUI3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:29:44 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310B4C061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 01:27:04 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id c17so6052084uao.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 01:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nLuy59A8PMwLhpgDGZXgcrV7ZMJJmmat7Q8wB6T7lcs=;
        b=VoGeBo628y2FREohTV7mjqkFeTdK5lIrqZn/zJWPIjrRvUmGElbTINfxBxAjVgI3Pu
         +Km7vM/lPHpFPtnKMiNb6+hYAKFrkbuPqRvDWxk5aGZZCRxf7xg/2Qj5hCQbWl9SlkmW
         70Y1LxP+pSCugL3BIMwZ0SY1O/7HW+EnP2vpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nLuy59A8PMwLhpgDGZXgcrV7ZMJJmmat7Q8wB6T7lcs=;
        b=pu2G8WwXBtj9tmosIgpvoZrYLnvgi2qNyMA89nGIazxKY7PCzw36geDGnEhyleL2CN
         7tRJI+CTHOvaXOicuWd5h8PYjyYKueY08ah0LGjGG2gvPODCb6yfd8jPuDg5sSZXz9Ay
         qaW+cJRP6vNmzJOOXCKSZNSXpQ2ftjjuWzpnvrGJkrIePGUcN9fg+/6/sAUpQPFA0vbH
         83LpESmE7ANEjgqE5k5HrcThkzQ+CyT4eCwtdNcHqydGp0JijJQZKBrPoyZfB+M2HD6X
         1hUnOJ6YPPfcBvZv2Fv7Ck0ppqGGjY9F70TocwC6SJx4zuZD6VGny76RIUgUWapoD8NU
         Jw4A==
X-Gm-Message-State: AOAM532DIZzmgEqXNu3G3LmFy8pcmM6qy+mQVOYJC38h3raz5CDG9Uh0
        X24PVLOcnYfoRVfg+lJAz0HKRFUA9EjHmVt2nyUlKTioBr/vAvzo
X-Google-Smtp-Source: ABdhPJyCyHjO5agNFI9f6KyDk4d5nVl9SK+W+k1J8lkmwB3vka3xV9O/3exMBXZwkimpRefHNFeMhvmx0fnPbVAX2Fc=
X-Received: by 2002:ab0:23c3:: with SMTP id c3mr607783uan.11.1624264022971;
 Mon, 21 Jun 2021 01:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210423151919.195033-1-ckuehl@redhat.com>
In-Reply-To: <20210423151919.195033-1-ckuehl@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 21 Jun 2021 10:26:52 +0200
Message-ID: <CAJfpegsXXGcZDbbtDoXG8sQqHrAS1fs-TsRz5ndQ62sse1Av_w@mail.gmail.com>
Subject: Re: [PATCH] fuse: Send FUSE_WRITE_KILL_SUIDGID for killpriv v1
To:     Connor Kuehl <ckuehl@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Apr 2021 at 17:19, Connor Kuehl <ckuehl@redhat.com> wrote:
>
> FUSE doesn't seem to be adding the FUSE_WRITE_KILL_SUIDGID flag on write
> requests for FUSE connections that support FUSE_HANDLE_KILLPRIV but not
> FUSE_HANDLE_KILLPRIV_V2.
>
> However, the FUSE userspace header states:
>
>         FUSE_HANDLE_KILLPRIV: fs handles killing suid/sgid/cap on
>         write/chown/trunc
>         ^^^^^
>
> To improve backwards compatibility with file servers that don't support
> FUSE_HANDLE_KILLPRIV_V2, add the FUSE_WRITE_KILL_SUIDGID flag to write
> requests if FUSE_HANDLE_KILLPRIV has been negotiated -OR- if the
> conditions for FUSE_HANDLE_KILLPRIV_V2 support are met.


If server does not support FUSE_HANDLE_KILLPRIV_V2, then it does not
support FUSE_WRITE_KILL_SUIDGID either.  The two were introduced
together and the latter is only meaningful if the
FUSE_HANDLE_KILLPRIV_V2 feature was negotiated.

What am I missing?

Thanks,
Miklos
