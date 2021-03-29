Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6D234C313
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhC2Fk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 01:40:29 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:45676 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhC2Fjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 01:39:53 -0400
Received: by mail-ed1-f45.google.com with SMTP id bx7so12792813edb.12;
        Sun, 28 Mar 2021 22:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z9Bqy7y/SBHZ7sSlA5wHS9gkRIG83fq3eksdfvugY4Q=;
        b=OH58VUGSMCu3WWUyleT5KpIkmufKMRALVDe6id4HRHqZuIiAPiGYMBC4pIV6BPnDL6
         NDBm4NaspO9QEwzDjTzk23DApCJg1PyD/x3lBYXsrYhNufd8daUdOlwLWyJ6kMXsf9gr
         PyDYLcbN2MaMWJLsPg3znSC1hFqMuR5ERoiVJp7U/9YlxTD6R3WG4/W27Rbe6IzPlUjD
         JCjcwNxbihqlVHRZN747RMazsbgG8+24CBWnxpPs6E8E3yrW8PvrQqG6mDYpXCYGQHNo
         8/mCs/D97fhkO2hV/8zvsazOXlYmqgtqTWQBHQoSMsSRRmNRua10OhiWGvDksjKQ+9Lr
         qEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z9Bqy7y/SBHZ7sSlA5wHS9gkRIG83fq3eksdfvugY4Q=;
        b=YKhcCEaAD9R/EgulGu5NlZPTV4Sj6nksz+uoCFuD3ACGlG/wjy0NSrKEXxnMHIinKr
         Srj2SEsIBG8UKx3Dm03gSDE9g78MfOqMdCVKbm4xwaVMRolE1jIn45mMQQOHCZM49+FM
         ErLPcyUzdER4yfUr2IH5IkdWqbByu+0151eUDZr7Q0RyW+u0L9D4k6E2BAi8oJXZC4sa
         snGqsOgFHhIlfq2JSmHiXI7E9YxWn2SGE5GIJ+Prtwd6cibozHjK70MD/jUi/8IarPDB
         f8mBh8wNhvzaNaV0+UaRQyGbq5SSoX2GD8fcsplb5A/JMClVMcaByXUn9qm++9Ht8UEa
         Gj4w==
X-Gm-Message-State: AOAM533OCFS4WIV6xyB4g/LSipxCSh2aMHBs+ZiH/5hk3S5E38C/OwYc
        amZyWkuX6BChINm9bcZYptECa3LFIphOoQRdRZTMoF2X
X-Google-Smtp-Source: ABdhPJzTGHZphqnGn3YUkycxCQXTd+W+LHOCjmCH8aE59y5YHgK1jjtsUkGsfsJ2JjCwln/jBUJ0ip9rLv0+t1LsjeA=
X-Received: by 2002:a05:6402:2552:: with SMTP id l18mr26344232edb.71.1616996326717;
 Sun, 28 Mar 2021 22:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616992679.git.unixbhaskar@gmail.com> <b103bd6a8bcdad7f90806dbe7680017235cf1d9c.1616992679.git.unixbhaskar@gmail.com>
 <CAMo8BfKj+ojEbc1ZJ6QL+f9Sq+7oZeqVNMu6nTP=OSbrqD2XOg@mail.gmail.com>
In-Reply-To: <CAMo8BfKj+ojEbc1ZJ6QL+f9Sq+7oZeqVNMu6nTP=OSbrqD2XOg@mail.gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sun, 28 Mar 2021 22:38:35 -0700
Message-ID: <CAMo8BfL8bzsVCSez8WUy5E7_izKmhYFB1O2gOXsqcsok65sM=w@mail.gmail.com>
Subject: Re: [PATCH 01/23] atomctl.rst: A typo fix
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2021 at 10:37 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Sun, Mar 28, 2021 at 10:18 PM Bhaskar Chowdhury
> <unixbhaskar@gmail.com> wrote:
> >
> > s/controlers/controllers/
> >
> > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> > ---
> >  Documentation/xtensa/atomctl.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/xtensa/atomctl.rst b/Documentation/xtensa/atomctl.rst
> > index 1ecbd0ba9a2e..a0efab2abe8f 100644
> > --- a/Documentation/xtensa/atomctl.rst
> > +++ b/Documentation/xtensa/atomctl.rst
> > @@ -23,7 +23,7 @@ doing a Cached (WB) transaction and use the Memory RCW for un-cached
> >  operations.
> >
> >  For systems without an coherent cache controller, non-MX, we always
> > -use the memory controllers RCW, thought non-MX controlers likely
> > +use the memory controllers RCW, thought non-MX controllers likely
>
> In this line you could also do s/thought/though/.

...and s/memory controllers/memory controller's/

-- 
Thanks.
-- Max
