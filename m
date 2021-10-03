Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D6442002F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 07:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhJCFVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 01:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhJCFVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 01:21:39 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86438C0613EC;
        Sat,  2 Oct 2021 22:19:52 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id s16so11657175pfk.0;
        Sat, 02 Oct 2021 22:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nep5fLCBAXvNuSVtvdbN0K5uSpGq+D1AUxpB4YF2LyI=;
        b=l2/Qck6khC+SLkA6p8D4A5IlhsJ971qX2EYpOpx7aRhH343lqJMTWPYvdjlg7EsQ4A
         ZIS6HsFx+NplFYsHmvLRFv2dH+5vGysCX/ClMV1W2sTrJvMO3DLcgPrxLUknBSfSwc5w
         lxJaSvV3as1ravK7dhvZPqwCjBQOnE+TPM6NhYRt1oMrW86x3ankICvh2xbgSJPGc94t
         cmZQmGCHgHib0Nj5WOgOhyWoz9jijWHE2rqWiFRbtbrCvpzg9n/b1POu/EXTjIc1bDJV
         maSb0Pm6R/FMqshaZcCnRpJqfwjs6IwWzN71d0roW5Xsh79ZPLXd1AjIJjqvxYmEjBW+
         Gl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nep5fLCBAXvNuSVtvdbN0K5uSpGq+D1AUxpB4YF2LyI=;
        b=LrqTG4tKw9XNBHaE8IDzuWhLEpgGorN83Qx4gG9modU6sIZymaABGmcM2Bk1AvQKQh
         FLdkd1K4Dl56AXaKNlvPs5b2/S5Nr2cRGGmETXVKN+raUfwY+gDBfxL0XaO6UlSfeX5b
         iuq+fLV6euWnOm+yMI98cHheN/PuU9c2WdObh6GR7Lk6wuwqwo5yvaTSVNuLx3nRdql9
         gZ3MmZTa8COwfKpr2gq2MYUdilLDUy/ohCXh/JFQo9Ck5qbUWigCn5Lko9J5PinGGi29
         S9OLVj4QUtXqV8GxkV2MwrvlU5kBUxqWw6e+mMpR5/GNBKvPVZWd4zXP6uhSL20cXHMa
         V2yA==
X-Gm-Message-State: AOAM533L3Kh/9kov6cM3kaZfAZkQY1pg/aBjhCyvA2gLorI4DHoNTcYA
        wYhqbdkplyLZ1c4semRz6xJHavp/q3Q7l1riHjQ=
X-Google-Smtp-Source: ABdhPJxc6oYZWj1yz7CK+XirK2A4I6fM68DZOqHzTS7DUlsofFi1sC1fHrWBD5creD2UXOLf0jyeoA==
X-Received: by 2002:aa7:9739:0:b0:449:56c4:4268 with SMTP id k25-20020aa79739000000b0044956c44268mr18166497pfg.43.1633238391910;
        Sat, 02 Oct 2021 22:19:51 -0700 (PDT)
Received: from uver-machine ([2405:201:6006:a148:3549:857c:c627:c3bc])
        by smtp.gmail.com with ESMTPSA id v26sm10454933pfm.175.2021.10.02.22.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 22:19:51 -0700 (PDT)
Date:   Sun, 3 Oct 2021 10:49:35 +0530
From:   Utkarsh Verma <utkarshverma294@gmail.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: checkpatch: add UNNECESSARY_ELSE message
Message-ID: <20211003051935.GA2687@uver-machine>
References: <20211001120218.28751-1-utkarshverma294@gmail.com>
 <20211002144506.29974-1-utkarshverma294@gmail.com>
 <CABJPP5Bpc_0c=b8kymo0fgXZARNZJ8EM5F=Gpx1=y+vOfPWM8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABJPP5Bpc_0c=b8kymo0fgXZARNZJ8EM5F=Gpx1=y+vOfPWM8Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03, 2021 at 10:08:17AM +0530, Dwaipayan Ray wrote:
> On Sat, Oct 2, 2021 at 8:15 PM Utkarsh Verma <utkarshverma294@gmail.com> wrote:
> >
> > Added and documented UNNECESSARY_ELSE message type.
> >
> > Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
> > ---
> > Changes in v2:
> >   - Included the continue statement.
> >
> >  Documentation/dev-tools/checkpatch.rst | 77 ++++++++++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> >
> > diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> > index f0956e9ea2d8..b7c41e876d1d 100644
> > --- a/Documentation/dev-tools/checkpatch.rst
> > +++ b/Documentation/dev-tools/checkpatch.rst
> > @@ -1166,3 +1166,80 @@ Others
> >
> >    **TYPO_SPELLING**
> >      Some words may have been misspelled.  Consider reviewing them.
> > +
> > +  **UNNECESSARY_ELSE**
> > +    Using an else statement just after a return/break/continue statement is
> > +    unnecessary. For example::
> > +
> > +      for (i = 0; i < 100; i++) {
> > +              int foo = bar();
> > +              if (foo < 1)
> > +                      break;
> > +              else
> > +                      usleep(1);
> > +      }
> > +
> > +    is generally better written as::
> > +
> > +      for (i = 0; i < 100; i++) {
> > +              int foo = bar();
> > +              if (foo < 1)
> > +                      break;
> > +              usleep(1);
> > +      }
> > +
> > +    It helps to reduce the indentation and removes the unnecessary else
> > +    statement. But note, there can be some false positives because of the
> > +    way it is implemented in the checkpatch script. The checkpatch script
> > +    throws this warning message if it finds an else statement and the line
> > +    above it is a break/continue/return statement indented at one tab more
> > +    than the else statement. So there can be some false positives like::
> > +
> > +      int n = 15;
> > +      if (n > 10)
> > +              n--;
> > +      else if (n == 10)
> > +              return 0;
> > +      else
> > +              n++;
> > +
> > +    Now the checkpatch will give a warning for the use of else after return
> > +    statement. If the else statement is removed then::
> > +
> > +      int n = 15;
> > +      if (n > 10)
> > +              n--;
> > +      else if (n == 10)
> > +              return 0;
> > +      n++;
> > +
> > +    Now both the n-- and n++ statements will be executed which is different
> > +    from the logic in the first case. As the if block doesn't have a return
> > +    statement, so removing the else statement is wrong.
> > +
> > +    Always check the previous if/else if blocks, for break/continue/return
> > +    statements, and do not blindly follow the checkpatch advice. One
> > +    patch (https://lore.kernel.org/all/20200615155131.GA4563@sevic69/)
> > +    even made it to the mainline, which was again reverted and fixed.
> > +    Commit 98fe05e21a6e ("staging: rtl8712: Remove unnecesary else
> 
> s/unnecesary/unnecessary

It is a spelling mistake in the commit message itself, and I have quoted
that message, so I didn't change the message.

> > +    after return statement.")
> > +
> > +    Also, do not change the code if there is only a single return statement
> > +    inside if-else block, like::
> > +
> > +      if (a > b)
> > +              return a;
> > +      else
> > +              return b;
> > +
> > +    now if the else statement is removed::
> > +
> > +      if (a > b)
> > +              return a;
> > +      return b;
> > +
> > +    there is no considerable increase in the readability and one can argue
> > +    that the first form is more readable because of the indentation. So
> > +    do not remove the else statement in case of a single return statement
> > +    inside the if-else block.
> > +    See: https://lore.kernel.org/lkml/20140925032215.GK7996@ZenIV.linux.org.uk/
> > --
> > 2.25.1
> >
> 
> I think this message is unnecessarily long for a warning that's understandable
> at best without the verbose part. Try to shorten it up with only what's
> required for a user to understand why the warning is there.
> 

Okay, I will try writing it more precisely as Lukas said.

> Dwaipayan.
