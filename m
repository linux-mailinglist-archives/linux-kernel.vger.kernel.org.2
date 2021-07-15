Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04363CAFCD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 01:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhGOX4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 19:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhGOX4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 19:56:31 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E65C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 16:53:37 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id z11so8623104iow.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 16:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1GpqK9OxeadSXN90xS62GQ/KYjYIKi/46Pw83OZV7u0=;
        b=ZGYbC12qqAw5KUKV8EhvgR9U6zH8FZJeqVesNulzVYcW4qNDj9IqdVuRQPTKtP2OsS
         YCXWj/Ac3ifud2+YdtofuE/RVew1WmQlgIbkVzwrt3pxPJD3FsQVACTb+4WEsOHxThKc
         iAbJQN1OniLVVEW0hqTf8xSVXFE9BrDJRaTFS65WgRIYF7KhBXiPbiOElkd46pEKBuP1
         UDvWtmoGdWV6pdyMAmiOT4JNcgw5nc913vdybuEPkIYfv0iYICMy076PbGb/+n0p62qf
         JFVYYaMsgznbZGt4GKCE9pQv7/ZxwDMsZh45pT9xpxHloiSe0SwGuheUgC+5Yqn68MsI
         K57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1GpqK9OxeadSXN90xS62GQ/KYjYIKi/46Pw83OZV7u0=;
        b=dgcvIkFc8qA33orcWByMkkwia07X4REGTqadlE8QFfPXc8tEE+vEvJJmJ1I88k1VxD
         fapb2sT4GxGveuooI4+07CVlc+vKI3Nd1AAcv6ZDa9gmJMp13nwlllVQDo85x8ZrusQS
         E62vRD8DvyMcCKagw7yGYP9ozUxXccSZi23crc4fG2eRblBWrIiEJg/PRmlPCf+KA4q1
         EPXytmykd8kiPysyNzc8XCeB8iv5a56X0byIJCmcttjJNXZTAEouYKp5OunIq0WKa3wN
         0mCZR1EukIrpwlBMsvZQVBMO6g1p55Xor90bR/pFucRkiwPyKOXM/07p75+OWq250N1F
         +xJg==
X-Gm-Message-State: AOAM530S7dWvPsGAfsqw7ojGZGZPK0Ce9W9q9H15sc9Qu3ea4ZkIYDaI
        ztKb0IG8C66v6FtgaTqXsQyJpLZeanWJYHAYbGs=
X-Google-Smtp-Source: ABdhPJxylKn3HYbNxCk8g88TdjsAEd5qhqNQPcx/eT7dXEZpPv96QOeJ/NYwwvbZ37pnG6XR9FiKUcL4o04PnmPjSfc=
X-Received: by 2002:a6b:6412:: with SMTP id t18mr4960477iog.64.1626393216800;
 Thu, 15 Jul 2021 16:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210626101538.54482-1-wjc@cdjrlc.com>
In-Reply-To: <20210626101538.54482-1-wjc@cdjrlc.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 16 Jul 2021 01:53:25 +0200
Message-ID: <CANiq72nkk6ABeVRBx4w8or7TDg1xjg5pVE7abqKb8P6mTayGCQ@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: Replace symbolic permissions with octal permissions
To:     wjc@cdjrlc.com
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2021 at 12:16 PM Jinchao Wang <wjc@cdjrlc.com> wrote:
>
> Resolve following checkpatch issue,
> Replace symbolic permissions with octal permissions
>
> Signed-off-by: Jinchao Wang <wjc@cdjrlc.com>

Thanks -- queued.

Cheers,
Miguel
