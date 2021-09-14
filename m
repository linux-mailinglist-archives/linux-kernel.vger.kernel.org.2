Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F2F40BB67
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbhINWa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbhINWaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:30:25 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DDFC061574;
        Tue, 14 Sep 2021 15:29:07 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bq5so1672201lfb.9;
        Tue, 14 Sep 2021 15:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OOGSJMiHA0GrsheLPjqZOApUIXPheFNmd6HaQBlmI6I=;
        b=NNcYyS7n3cxhdsmKNyNkWrRNCtdUVe+k005bVrKWPhkxeKYJGDY7JQItsGKP0R9ag7
         OF+scHQFB5sD+jQDhuOe3nOtvvfvUuMtkvYC/bL7WEhlnv9VayfRoIia/JDeqdIvRpT0
         nf+ouQMJ3XmxzytlJ82aHi5DVAbyQiCs8016ZBqVMJwDeSo/JNzCKUs8/Ky0shyBhgPO
         NJfelis94P6JIDsDFPz/m+mydSHi4sdw8ZvVGDTjn9ZFY5TPB/gikmi6MK0Ldf+XqdWj
         w2ymYG3Ykr64kMAOzTDhi15hF7mluus045/hquIPHuGz52xvc1+4LgfWCKBNeA0zhVpW
         1UrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OOGSJMiHA0GrsheLPjqZOApUIXPheFNmd6HaQBlmI6I=;
        b=hW19RyCSQ8eeNXLf45HxW/7yUmKzkvcExNxYSzTogYPuUSg2fUKoVh5NJuqQSkafJx
         uKXJO3sMt8m+e4ooRNKUvvAS1Phwv7R9+XfsbpDSC83wUvHD8IN/wf4cUElOJvm4LugP
         pH44ISYEJZaJ7/w8H/uZ3PZrCESngZqI10E5hWwE1lvD865ycvW/QL9J1m8w204HiZJH
         3tpNk1hzvQ9O2SruAYuXbKtABIWZDbjFTaRed24QVD5RAM770CmdpcO0Yi0gtjP79xD7
         CLsQ+pKjszeGDC/Heha6Dz1aNV+aD8ZVqclEI9SdqUPjC+oYPUMw7QkKMym45yqoX3sB
         cYyA==
X-Gm-Message-State: AOAM530PTohr6hyrROPMLHVYql9baYYVYqwZn4htp1E3EZscO7cstRC5
        DwRAnR71pOpp95ZxXQ4DQ5J9rewijclxhb1IkhIy4VM9hhQ=
X-Google-Smtp-Source: ABdhPJxJRmrTSph3hEv5MyeNd4gzes70mmgLByycynCqyyqbKeWk3vdJZkpOYkAbqWNKa+I8G1dibBpNsazFoGIk7X4=
X-Received: by 2002:a05:6512:3f91:: with SMTP id x17mr15108290lfa.518.1631658545482;
 Tue, 14 Sep 2021 15:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAKXUXMyRKM9Ev_Yyyup-T=AZe2aYcN-ZneXsLmHtUC7as67zNQ@mail.gmail.com>
 <20210904082330.14864-1-utkarshverma294@gmail.com> <CABJPP5DyppeW=_XXJKn_NnQahOn=k0oBi-dDdcyxN8rygwusEw@mail.gmail.com>
 <87ee9qdft1.fsf@meer.lwn.net>
In-Reply-To: <87ee9qdft1.fsf@meer.lwn.net>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Wed, 15 Sep 2021 03:58:54 +0530
Message-ID: <CABJPP5DjazfiTUe3wvnKyk86hN+SUK7aP9K5GP0L5tRW_TD_xw@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: checkpatch: Add SYMBOLIC_PERMS message
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Utkarsh Verma <utkarshverma294@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 2:40 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Dwaipayan Ray <dwaipayanray1@gmail.com> writes:
>
> > On Sat, Sep 4, 2021 at 1:53 PM Utkarsh Verma <utkarshverma294@gmail.com> wrote:
> >>
> >> Add a new message type SYMBOLIC_PERMS under the 'Permissions'
> >> subsection. Octal permission bits are easier to read and understand
> >> instead of their symbolic macro names.
> >>
> >> Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> >> Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
> >> Acked-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> >> Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> >> ---
> >>  Documentation/dev-tools/checkpatch.rst | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> >> index f0956e9ea2d8..41037594ec24 100644
> >> --- a/Documentation/dev-tools/checkpatch.rst
> >> +++ b/Documentation/dev-tools/checkpatch.rst
> >> @@ -957,6 +957,17 @@ Permissions
> >>      Permission bits should use 4 digit octal permissions (like 0700 or 0444).
> >>      Avoid using any other base like decimal.
> >>
> >> +  **SYMBOLIC_PERMS**
> >> +    Permission bits in the octal form are more readable and easier to
> >> +    understand than their symbolic counterparts because many command-line
> >> +    tools use this notation only. Experienced kernel developers have been using
> >
> > Let's remove "only".
> >
> >> +    this traditional Unix permission bits for decades and so they find it
> >
> > Maybe you meant "these" here.
> >
> > With these changes made,
> > Acked-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
>
> I took the liberty of apply the patch with those changes made.
>

Thanks Jonathan.

Utkarsh, you can start working on your next patches after submitting, you don't
have to wait for the existing patches to be first accepted. They will follow
the same review -> changes -> review cycle until they are good for
acceptance.

Like lukas said, try preparing a batch of say 3 to 5 rules and let's
review it and get it in.

Thanks,
Dwaipayan.
