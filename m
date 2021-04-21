Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A48A366E65
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbhDUOlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbhDUOlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:41:40 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A50C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 07:41:07 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id v123so35422638ioe.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 07:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rmcIp8hExvshUmuxud6m+2Q4GE1q+35u3HrSpv655d4=;
        b=rZOVLf/3q0LjQMBRCKi5fQW3wr51MXgFe5LxWyOtZmopdW4Ld1ivWmmexjoWbgPR0H
         Y4E1Zyw2tzKgnsOUxKYd2TcnA8gR5afITfeUKeyHLe8YNMsNAN2RG1AphJkE85GP7h4J
         O/DqxWP9N8A+3+gSQ+MeKkNFxy1hb1I3IVSJCb2gLKimqHZfCtLg3qA42Mhn+jAufRJ4
         i9XammwUzCt6bX3u+SKF4nDdmCmDmPx7JDptEQxkuw8KO+HFbxY0eGxNZKY6KpGUt5zQ
         75OsBSKZO7LIrk1n5fP9wisg2tQw8xnCSUQhsKYPeOfF7rUmrIuAL21WpKL714X3kZBA
         hoQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rmcIp8hExvshUmuxud6m+2Q4GE1q+35u3HrSpv655d4=;
        b=RTa1gYEjhNPDOcbEl3UiYpWooG5b731fQGaix1rdo0t7ehTwco9Xz/W2ZqZG78sbMg
         0Dl02NrirRn9SSpVGBK2Oal9OOViupltuTde263e0AZTJPhY5Xg1dksrfZLc5586JNFh
         7Ms5p27LomxxZn1VGoHmY9738jkQk9OQXTmwWz2XXrVujlwQ5hoyeGal2/jyHoBJ9Aq7
         lWBy2Gh/AoKCzMeO1i0Sau4Tw4MVQvNRsfD2vq1nEehNj+fxa9HfDoaGt4ljuqYU1j8i
         Dg30YRBSDbHWbUObAM0piFuTK1cT7vltskyryurtOU122g+Et1EYjR48lkq6XCzwuBfB
         4UBg==
X-Gm-Message-State: AOAM531FB99w/4kR9ZdI124yJUrp9n4g5zTGRuUCuschIV00cdewLhFo
        18sKmtmznuqOXfh2xR8lxcTCfjpRLfpnWcnIZbqWhg==
X-Google-Smtp-Source: ABdhPJzEmGdHBGSvBbgO9QFOoTY2Qy0HtiRroFoIy/rzgEN9Yy+q+rK3mO+pzt1NG+76QYoxfCvok6n8sOVkHxNlg2Y=
X-Received: by 2002:a5e:930d:: with SMTP id k13mr23645312iom.61.1619016066306;
 Wed, 21 Apr 2021 07:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAHo-OowM2jRNuvyDf-T8rzr6ZgUztXqY7m_JhuFvQ+uB8N3ZrQ@mail.gmail.com>
 <YHXRWoVIYLL4rYG9@kroah.com> <CAKD1Yr1DnDTELUX2DQtPDtAoDMqCz6dV+TZbBuC1CFm32O8MrA@mail.gmail.com>
 <87r1jbv6jc.ffs@nanos.tec.linutronix.de> <CAKD1Yr1o=zN5K9PaB3wag5xOS2oY6AzEsV6dmL7pnTysK_GOhA@mail.gmail.com>
 <87eef5qbrx.ffs@nanos.tec.linutronix.de> <CAKD1Yr2qeXseNLcQ9r4niob02jGOXdVeta6OwWF3Ta1dyp1V2Q@mail.gmail.com>
In-Reply-To: <CAKD1Yr2qeXseNLcQ9r4niob02jGOXdVeta6OwWF3Ta1dyp1V2Q@mail.gmail.com>
From:   Lorenzo Colitti <lorenzo@google.com>
Date:   Wed, 21 Apr 2021 23:40:54 +0900
Message-ID: <CAKD1Yr1TOd1XKFdWK2Wr_Pw2rKciSapCM8ATEirxpCApZZzZmQ@mail.gmail.com>
Subject: Re: [PATCH] hrtimer: Update softirq_expires_next correctly after __hrtimer_get_next_event()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        mikael.beckius@windriver.com,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 11:08 PM Lorenzo Colitti <lorenzo@google.com> wrote:
> load the timer will almost never fire since there will always be
> another packet coming. So the speed of adding/updating the timer is
> much more important than the accuracy. We will try to move it to
> timer_list.

... but actually, that's not acceptable, because AFAICS timer_list
counts in jiffies so its resolution might be as low as 10ms. It's not
acceptable to delay network traffic by up to 10ms under load. Not sure
if there is another timer API that can be used here.
