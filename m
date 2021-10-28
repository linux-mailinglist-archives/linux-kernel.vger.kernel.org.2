Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06F443D866
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 03:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhJ1BML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 21:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhJ1BMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 21:12:10 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEA0C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 18:09:44 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id d23so6418534ljj.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 18:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=e3TaODOC5lCFXKHCBumT0K/LOIAxtk0rYOcq07ynEmM=;
        b=OvhgQKa4el91hx2TqzYGajCb/B+yO5QXC0tEAL9e5n/i+wofSFeCWIfim8SU1ewkFB
         RpQjvvrWQRBZGuELyt1x7SMw7aEdQvwP6Rnl3O5EwxDYhqI5OOwDons29FRvxzJCcEcG
         0M22LRmmX5QXd21Iwxo63MFuy7jTtbgIWKjrxyr+SK/evmtOnOCmRD7vbBgV7dLnvPhI
         W74VpSQoehS9s5iftDT9W+yR/m4wS+7J5qIrmhKujtmtbOXbLNccY3E6GPFhmDcH4Mj9
         Ph1vdVWONmVPHaKu6nTSXQw0pBdxgSkB4f36kMvDfSGWmP8yhEPQnanqvf09ZBeip0DW
         qJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=e3TaODOC5lCFXKHCBumT0K/LOIAxtk0rYOcq07ynEmM=;
        b=U4YdqBhh2Ka98+kKoCPWWj9bCkHOVCbItiziPcRQaXBAQMmLRVUDEs6T5oFnnGEu0i
         BCkz4/zp/pMzv0BzCw/7gAY4hLlX3e05uOtBBD0CtQ3+ULJOY7VaU5qwHyreYkf3RPru
         ohXd9vZ9XRhADfg73gOQKeNgP2Ri/9zMRinYOnwlDLPDPYolseSD/8qF1HmZ/b2bwPaW
         8OAxNVWeEpGeaUcix01XQT4PKzZWF0LdSu1wBf++Mn7qq8kyQjwBU3u7L26J21WWnE1V
         8CY6wZSeKRDttxK4tW5ACQ2dRh0PLcewVuzqlviMiNFehgOUzfbYAu8HWLsAhbj+yG01
         cbQQ==
X-Gm-Message-State: AOAM531wcVI5+LxmlzSQdlEa8Sp7tGFZKPuaihleXo2syp/JyYdlJS+x
        BxWPhEydYoWvadFncaTncxhZLIXncXjpBsLKA/Q=
X-Google-Smtp-Source: ABdhPJweTudNKGobz1jPM1rOTq+qN6u4NE9wum9if8tBAQ4VcioeG3h6WRp1L90OFiKua4yeCB7fKWBTZ7d127I3q7M=
X-Received: by 2002:a05:651c:1549:: with SMTP id y9mr1367522ljp.327.1635383382553;
 Wed, 27 Oct 2021 18:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAGTfZH3V=SwDL6Uy6BM++sTnUmvos4vBeJf8_nvso9L6viKPnQ@mail.gmail.com>
 <YXlnUKcAvzuBeFBg@kroah.com>
In-Reply-To: <YXlnUKcAvzuBeFBg@kroah.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Thu, 28 Oct 2021 10:09:06 +0900
Message-ID: <CAGTfZH0zOAP33QVJn9P2UCwh2n3bsSCygjqbrgTVLpyvmbG8cA@mail.gmail.com>
Subject: Re: [GIT PULL] extcon next for 5.16
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

On Wed, Oct 27, 2021 at 11:50 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Oct 27, 2021 at 06:00:44PM +0900, Chanwoo Choi wrote:
> > Dear Greg,
> >
> > This is extcon-next pull request for v5.16. I add detailed description of
> > this pull request on below. Please pull extcon with following updates.
> >
> > Best Regards,
> > Chanwoo Choi
> >
> > The following changes since commit 519d81956ee277b4419c723adfb154603c2565ba:
> >
> > Linux 5.15-rc6 (2021-10-17 20:00:13 -1000)
> >
> > are available in the Git repository at:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git
> > tags/extcon-next-for-5.16
>
> Note, in the future, can you keep this all on one line so I don't have
> to cut/paste from two lines and put it together?

I'm sorry for bothering you with my mistake.
I'll keep in mind. Thank you.

-- 
Best Regards,
Chanwoo Choi
