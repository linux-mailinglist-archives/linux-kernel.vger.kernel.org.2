Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F853DBB69
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239302AbhG3Ox2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239244AbhG3OxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:53:25 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2238FC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:53:20 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id r26so18468425lfp.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WwILEX7NR1VzEi/uBdrHjZ2rhekLFtKl+IjEJ6PsRbo=;
        b=eSRscB5LQZ42d/wJxzzYPB1M2Ev+d8TH1pk1kq7FZs6bBPalAKZ3cFxeJSuSpu3dN0
         Em59MuepSMmpBso4Ynu1+27CaFcZ/iVxU8JvxIa1juSCTwjR6YMwx9wll3fjX5aCGryx
         45DqbbN+Vkr/RNTQXWcM1pYi75BmOfzzVzQXBH9/jduPm+5mKvBVTvWDtNNS2TWuLZA7
         SjJ+vWgQYQe8cUdVUakQ72OAzF+V4E0mXkB/PO+kFm4hQvjmJr/4XUmQZIE0UtBv6/no
         Cz6pNjN2L+umPZr0BsmaHwqvuBPvKfnA6X6V143fY0lGA+TJgx0m3RbMz7Vh66AHtjOK
         lPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WwILEX7NR1VzEi/uBdrHjZ2rhekLFtKl+IjEJ6PsRbo=;
        b=a2bVbLCAhCKvp6ul9WwZJm450X5MYwTL37AOyhx7LuvNDcq8f7a0eJUr93f2w95awr
         tursUwIO5laedikgNX2oJuQUcJq/76sMBPjbefWtf/I7Vc98OKH2IukeNx/CUBjLHnTD
         udmP/O1piNRLoibJqUZuR5EjppjvobT5sgjx5PfZipKVLM8SxhSbUXdW6B0PwqWQfRm/
         WdtuxfzVbnQU0tkFyubod/WPyM0/rhEI9rfOm6VJYMYqtWsToWIUiZOnFd92xMX6xdcc
         dk+ov7sM3NhDO/dTt0plR0qzwjCqEhuzZDYJ2UIU0HAj7mn3HN0Kv18mTow7c9tA5m1G
         QjMg==
X-Gm-Message-State: AOAM530T8yR2i29bFPwx5ysSIYjTZK9dY6iaMjlei0hzsoQjxKlCQmmC
        HrQWR5VDXPUH+ytgah8dneXilQ0PtmF73kMW24zbpw==
X-Google-Smtp-Source: ABdhPJwjcrWpoUYw/qBMqmhargQPTVX8q6Pq2/amq2QpdOcbNvK2a9I91gSNOQFdTDGdy12DFX+Mc+m7GdywLBd8974=
X-Received: by 2002:a19:4803:: with SMTP id v3mr1839747lfa.83.1627656798290;
 Fri, 30 Jul 2021 07:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210730051605.2626-1-caihuoqing@baidu.com> <0516372e-0120-ff52-bf9a-cf1cda9a633f@email.cn>
In-Reply-To: <0516372e-0120-ff52-bf9a-cf1cda9a633f@email.cn>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 30 Jul 2021 07:53:07 -0700
Message-ID: <CALvZod6sUh0XQGVb4wEfzGNDcrLabgmjEdu+wh0g1c=cvvci4Q@mail.gmail.com>
Subject: Re: [PATCH] cgroup: Fix typo in comments and documents
To:     Hu Haowen <src.res@email.cn>
Cc:     Cai Huoqing <caihuoqing@baidu.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Cgroups <cgroups@vger.kernel.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 6:44 AM Hu Haowen <src.res@email.cn> wrote:
>
>
> =E5=9C=A8 2021/7/30 =E4=B8=8B=E5=8D=881:16, Cai Huoqing =E5=86=99=E9=81=
=93:
> > Fix typo: iff  =3D=3D> if

This is not a typo. 'iff' means 'if and only if'. For details see
https://en.wikipedia.org/wiki/If_and_only_if.
