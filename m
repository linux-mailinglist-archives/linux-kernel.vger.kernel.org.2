Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94739379148
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbhEJOu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240097AbhEJOsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:48:51 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66962C06138A
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 07:06:11 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id 66so8441309vsk.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 07:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFnuGB+WCMGHz+QwS2RJAsJc85f4hduXdUzgwOYUvXg=;
        b=ikSMd3g5O44fa24TXY7ber77UATQvCsJnp3HdelBQZ/3BsWQD4VVrSmqV9ITzwzUnu
         90yn7BZ5dUX9MFAWrnM0kmV+l+qu9YdPV5q6uZ75FIpAjY0bqeWFXkNvt4rhcYB1Gmzk
         7F4cUi1Tdxoy7hKt2+U+U5k+tCGFehJh9N2Ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFnuGB+WCMGHz+QwS2RJAsJc85f4hduXdUzgwOYUvXg=;
        b=Vgx64CTkmyK3eYZN2fj0lzN5AtC/aE4Xa9pqh4dAHo/IxA1nOwtQr9xYhmZROFze+T
         vO7eTqw5j49LdC+vp8gAEPfKq6jwyWGNp42BbMI4oQ0xIeWsX34Tnfylc3uz7fShJzCC
         F3wf2AWVoeFFPtZnmw43YYtKhKhyD8BH7X4T+p9pk3J1B11SkYVq0jTayjYRo0SM8BpY
         9sCcxV6awFLynqtvNp25UiQDX9BO9m6QmId4ujeQwMAjLQgENYwDBHp+zImhnZ7EqLbQ
         MBWabIdTbDrpzcJh097Tb43Me3NcCdXHuIyoZkHMJ5FNtHa/K6ZwytSXVyMooXFY7rqR
         00qg==
X-Gm-Message-State: AOAM533GPy3jSREQbDg/luQO6ibuYCDa8KxvLu1M0qQ7OILaYPnoSHCV
        sYgni318kHbDBbQ169OMMiuB15gWrQxDSMH7lw0qiA==
X-Google-Smtp-Source: ABdhPJyJ38FHmQxketdQoTWrKTzUEYSbJi/KlkryhCGy2mWbGpsFCQMFl+CAeQrokVAKaT2lR1fvGAPJupKRSkTax4s=
X-Received: by 2002:a67:ebd2:: with SMTP id y18mr19369613vso.7.1620655569135;
 Mon, 10 May 2021 07:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <1618582752-26178-1-git-send-email-pragalla@codeaurora.org> <c0c0c33be51672f01d4f7a2e097bb978@codeaurora.org>
In-Reply-To: <c0c0c33be51672f01d4f7a2e097bb978@codeaurora.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 10 May 2021 16:05:58 +0200
Message-ID: <CAJfpegt=QmVvMi=wmYfT1QKD80uV5+uOmLWg=T7W0uh01eDz8w@mail.gmail.com>
Subject: Re: [PATCH V1] fuse: Set fuse request error upon fuse abort connection
To:     pragalla@codeaurora.org
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 9:52 AM <pragalla@codeaurora.org> wrote:
>
> Hi Miklos,
>
> Did you get a chance to look on the below change ?
> could you please review and provide your comments if any.

Hi Pradeep,

Patch looks good at first glance.  Will review properly.

Thanks,
Miklos
