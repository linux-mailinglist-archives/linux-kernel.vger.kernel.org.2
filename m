Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE93A36EF95
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 20:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241231AbhD2SlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 14:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbhD2SlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 14:41:06 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12C3C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 11:40:19 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 4so46448594lfp.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 11:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G/KA65uTHXCFFTvYw/s+9OOU27f6naykvVdcXil6GOU=;
        b=aHxExwWXXbA/M5Hyk4ia6tZYum0w84GdKsM12BxKMnqB2asxDMO0y+/4iLsq30XkAW
         B4ihRiA4mKWbIVjIoc3Oc+lciP59SGk3F4wXp3z5JAJ+tmyboPyIrh/eHTodWgWcvfDJ
         RfHSDJh0NHOZGt+t07tpAZyksUn92HOIfThIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G/KA65uTHXCFFTvYw/s+9OOU27f6naykvVdcXil6GOU=;
        b=lOKnAcjByFnL9YxQrI7lZ5zaJn13/jeptcubPm+9T9+e/CH4EUI8qtpsKpvAe/6tlI
         aF06Adb1Vj6mC0+HaI8fQTAwr2yVSbIa1SMfCQRYk1RMUC2lXh454Qi7iYVFLhGcWv57
         LVf/A7/uo8ubaNZJjaxKe0+OTbSzNUCUhJUw9iE7OXIzo/mvbBhXrbcKpj9S3RY7HqDJ
         aru5C8T795Qjnh46miKhwMju0b3GXjIymBhJe7p6DqqCmP/4w4nOUrcOcpejWFjoKGQD
         mWD8lmM2g9wn8EdoBNqc3enrfXiHeYz+WMVOO+Tk6ZvsmmiMYfP954ZCqK0BVrM+uYG0
         +YrA==
X-Gm-Message-State: AOAM530gVwUiS3RkfNF/iRQFH3+IWSeUwnozYgpDvB9zV8j1286hymto
        4kiyQcfnewiZtBXalY1g8h92EMEJZTrwSXpL
X-Google-Smtp-Source: ABdhPJzoAColm/02fV+06uWAL5LpVTfTIKuO8xP+WtpKCqLJoZCjXgQEjfJZx939b58nv8PWDRR0oQ==
X-Received: by 2002:a05:6512:1051:: with SMTP id c17mr49492lfb.661.1619721618009;
        Thu, 29 Apr 2021 11:40:18 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id t12sm52692lfl.254.2021.04.29.11.40.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 11:40:17 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id j10so13209009lfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 11:40:17 -0700 (PDT)
X-Received: by 2002:a19:c30b:: with SMTP id t11mr596231lff.421.1619721616882;
 Thu, 29 Apr 2021 11:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <ffad0699-7966-f601-3d88-8ad1157bf2b8@monstr.eu>
In-Reply-To: <ffad0699-7966-f601-3d88-8ad1157bf2b8@monstr.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Apr 2021 11:40:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whyvvZO3M9=4AP7Ci9ge2wQAjvdDrkr36bYt=Ux_rx_wA@mail.gmail.com>
Message-ID: <CAHk-=whyvvZO3M9=4AP7Ci9ge2wQAjvdDrkr36bYt=Ux_rx_wA@mail.gmail.com>
Subject: Re: [GIT PULL] arch/microblaze patches for 5.13-rc1
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 12:52 AM Michal Simek <monstr@monstr.eu> wrote:
>
> please pull these patches to your tree. There is no new feature added
> but it just about cleaning up some code and moving to generic syscall
> solution used by other architectures.

Hmm. This ended up being based on the v5.12-rc1-dontuse tag.

I guess it doesn't matter all that much, but it would have been good
to try to avoid that.

               Linus
