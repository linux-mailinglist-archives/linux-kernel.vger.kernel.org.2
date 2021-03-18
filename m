Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2346340C2D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhCRRwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbhCRRwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:52:16 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12DDC06174A;
        Thu, 18 Mar 2021 10:52:16 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id v3so3201762ioq.2;
        Thu, 18 Mar 2021 10:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZzB7p1mrH7Ut3wO2SVOFyueQFUpspybATe+7N0GIt5E=;
        b=nlPMmM1nr7ne9QnqA2MOiSNWZJAp0UGD6TTtjFevPK2dYkM4NZPqpoGrOf8VuzU8A1
         cOGMALs1RmCKHTTn1dCIJFc9rmoc9wE5GlMk5ROz0NJlKbE7hM6FxCOGjWSFfGDyaP7x
         4Y0OtmnWlT0/C5uiOo4Oeo5qFJBITt2foM1il26KjttwX/rc+KyPlPDEmMZ53lUi4D9n
         fbghgbFC0ZEnFK2vTHwdMm5cfMODBLMPpGKzDR3CiZs/ZMElLJkpJfN4eF9s8Jo6lLEi
         jYEuXDgsgRWSWPxk65e5YtouL4WNZMBwPqaSdm8yg9u6bQS6k6n+nGUgQJud2Lz930LL
         QDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZzB7p1mrH7Ut3wO2SVOFyueQFUpspybATe+7N0GIt5E=;
        b=I7P5Jsm7peGHkNH9XwKsU3b9kMfzen3ZcvyJo+7dQNdSC1xnt8hPW3qlLwx8TKamAz
         gM8WiYqKEKbvnN8mPoEQ1cJkHYMg+/cAxc/p4EDtUVs2WxWkkgK7tzcYmR14L+qhHH5w
         dNtsM8haoFjT5dQkdFoWh37QlA9f7PLyein1NMf7qrN+I/X025DrlsQmhv1I4DWvjz8N
         +3L3+CK7679qhXhVrR2EnCfoP6gzxpz8rTDU7yPqcuZdknLLJYkrTlkG6xox/c+X/ub6
         AQ8zLpmR9LkZNweDEoUQZgKld89uNKSGGPqqWwz4yt2ELkJ+lmSKlX78rdEFvn/4LLAW
         AMkQ==
X-Gm-Message-State: AOAM530mQaajrZsOjr9Jwk9gtlhgrNkZAiJ5gPkczv5pbwvZLR6DKxWK
        IR7mlHK1DRL397vLSTQmNfCxfHSH1O3OuCdQ/usrThxS
X-Google-Smtp-Source: ABdhPJz0q7mAqubSJL6bw761i7nrOQaEBtfa+ohfLNR3XIF8GLlyxWZakMPiS/4d1zpr0iXS278aTJHm9JVkUjtNWx4=
X-Received: by 2002:a5e:cb4c:: with SMTP id h12mr10762093iok.183.1616089935999;
 Thu, 18 Mar 2021 10:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210309125324.4456-1-yashsri421@gmail.com> <8959bf29-9ee1-6a1d-da18-f440232864f3@darmarit.de>
 <c673e76f-72db-bbee-39d6-f5428e765173@gmail.com> <871rcg2p8g.fsf@meer.lwn.net>
 <CAKXUXMzwTp1H_vokVEAJSnmm7jNHfWzhhmLfpcrrBD9b8ak+dA@mail.gmail.com> <878s6kto3g.fsf@meer.lwn.net>
In-Reply-To: <878s6kto3g.fsf@meer.lwn.net>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 18 Mar 2021 18:52:05 +0100
Message-ID: <CAKXUXMxWOvM5HRwmAAWEsqQc2k6_ReqRw0uD=VANLO5D7OpFtg@mail.gmail.com>
Subject: Re: [RFC] scripts: kernel-doc: avoid warnings due to initial
 commented lines in file
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Aditya <yashsri421@gmail.com>,
        Markus Heiser <markus.heiser@darmarit.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 5:37 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:
>
> > I wonder if we could extend kernel-doc (not your preferred option as
> > it seems) for a new dedicated warning message or maintain a separate
> > kernel-doc sanity checking script to emit a dedicated warning based on
> > some heuristics that suggests when a "header comment" is probably
> > unintentionally declared as a "kernel-doc comment" when it really
> > should not be.
> >
> > Jonathan, would you then prefer to have a separate kernel-doc sanity
> > checking script that then allows us to maintain checking for patterns
> > we already cleaned up?
>
> Having a warning in kernel-doc for "This comment starts with /** but
> isn't a kerneldoc comment" could be useful, I guess.  That is the real
> problem, not the fact that it appears at the top of the file.  I'm all
> for tools that help us to clean things up, but let's not add
> line-counting hacks to try to paper it over.
>

Yeah, and as this line-counting is really just a poor man's
heuristics, we might just be better to really turn this heuristics
into a dedicated cleanup warning script, then we can check for more
indicators, such as "does it contain the word Copyright" somewhere in
the kernel-doc comment, which tells us even more that this is not a
kernel-doc as we would expect it.

Aditya, would you like to try to turn this check into a separate script instead?

Lukas
