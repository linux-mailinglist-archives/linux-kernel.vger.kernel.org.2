Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DBA31B23F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 20:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhBNTgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 14:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhBNTgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 14:36:36 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A0EC061756
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 11:35:55 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id c8so3106155ljd.12
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 11:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RbvCfMxOWqMpSP+VwP8T3vlMh+uVuY1n7ujnc/XcM88=;
        b=ccjzpZtHRJY+es2JuDho5q0htQTKjsB1P/wHbFNcnHGiaQCwf/BlM3TdHld1OGor2E
         KacLI5WAD7LkqPBFeOKwHjZtwYGCxiPFhUU/GMbN7N+O7oGc/+syYfbFYh6a4dcqR+Ln
         hX2gIyJ65bNumi31UoWqq8c4UoQzdQtXppA1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RbvCfMxOWqMpSP+VwP8T3vlMh+uVuY1n7ujnc/XcM88=;
        b=TDTCCcdEi7WbMcuEcBuExvPsc6Ff27IqYq6jCLReWJBHHC22Zwdx7d0xyP0vKX886X
         dW6PWpfsEXP6lbEHQGnKm180vaRcnTK/EfYPg/HpCjXOh2t86zTwbfOxdv5NaNo/eGXq
         AVzIqT8TW0wtO6MPoskOfumaWWsdPvp4oQVQOHYPL7emvpS0SO68f3WjfEe0CLzSq74s
         nAhTxFd5qxnlSqIBLWYOVcWpnMVmN19SHxZDySKQD0lFyH7p77bVD05VPgt/5LbZ3Yv6
         tzGBnBnuREHiJN1kZVyfOGbfe/zQFceuEVfPOUhyu1G0YKu9kJAM2RzO5JhqXroqQr+t
         Ot1A==
X-Gm-Message-State: AOAM533nadPcdR0wLHT55Uqxx2Ve8DzAGS9040eHWyGu2xxh3V2XIW2G
        b3dWejG7Zvbr5X0OXyteXT7W26aFZ2utmQ==
X-Google-Smtp-Source: ABdhPJznGHvvIunTFXM58TFsxHcv9o6XOO7AEXIKvu1o7Pox4OhERNIvAdNJHh3TCCapRzMcQqtRYA==
X-Received: by 2002:a05:651c:10b:: with SMTP id a11mr7729242ljb.352.1613331352862;
        Sun, 14 Feb 2021 11:35:52 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id y15sm3355763ljn.97.2021.02.14.11.35.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Feb 2021 11:35:52 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id d24so7092045lfs.8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 11:35:52 -0800 (PST)
X-Received: by 2002:ac2:54ac:: with SMTP id w12mr6606496lfk.487.1613331352177;
 Sun, 14 Feb 2021 11:35:52 -0800 (PST)
MIME-Version: 1.0
References: <YCk/f0efY5OhibCn@zeniv-ca.linux.org.uk>
In-Reply-To: <YCk/f0efY5OhibCn@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Feb 2021 11:35:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiyaja6TKL1+HGXMXNE2EkqfjjKV6oQAOKfTTacc=mq5Q@mail.gmail.com>
Message-ID: <CAHk-=wiyaja6TKL1+HGXMXNE2EkqfjjKV6oQAOKfTTacc=mq5Q@mail.gmail.com>
Subject: Re: [git pull] sendfile fixes
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 7:19 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Making sendfile() to pipe destination do the right thing, should
> make "fs/pipe: allow sendfile() to pipe again" redundant.  Sat in -next
> for 3 weeks...

Just to clarify: this says "fixes", but I get the feeling that you
meant for me to pull tomorrow in the 5.12 merge window?

I like the patches, but they don't seem to be anything hugely urgent.
They should make "sendfile to pipe" more efficient, but the current
hack is _workable_ (and not any worse than what we historically did)
even if it's not optimal.

Right?

Oh, and it looks like the first line of the commit message of
313d64a35d36 ("do_splice_to(): move the logics for limiting the read
length in") got truncated somehow..

          Linus
