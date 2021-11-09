Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A1F44A840
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 09:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244002AbhKIIXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 03:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbhKIIXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:23:42 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA856C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 00:20:56 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id r28so17796690pga.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 00:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DKVg9sxFF7KkDsYsJ2kyK9iOAkgZCIk72eYOX0sPY7I=;
        b=qcqOzcb+4K1liquhkvg0C6k9R6kPGF+XGZY3Jt57IOJF4Kog3dkDHhVlcIFKj9jUWG
         EkOD5mIo/yMJ1/pDLUKXqhZnaIY1zClvP9oYbhtcf79UtIYa8d8uippHbO5C7n2dBI6D
         iF7NRgtSFKPiEH8s/tuOVmnlpXg/2RBrAwSD+FBt4TnETGDdxp5HeiDH2T+rGuOnC4nq
         F+vvowMTPZrDJ/DXfB6MR6L32XYafWSlhh6Q1DISoxSUoemkEaaaQ8NrUBYN0Bh93df1
         HnQWoVFmv1QQaVZMq+7A1TW5nyEJfOgAfLqCi6qt8Mj2h+gY4xtY/uZA/FQNLdzUIBLm
         zdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DKVg9sxFF7KkDsYsJ2kyK9iOAkgZCIk72eYOX0sPY7I=;
        b=DNwPXFLbzCGsO5n1pf65wea6zka9T+Vl2Gvm3N5iL7HvGHkjVOBESrjYAMRiSa9Asy
         ILx92IZANSaRpD371RsWcT15eLJb/dCvC4gXBpisR7aDSsBsrzg8h9aflBzzRBVOyuIf
         WVnk5u8ZPHbv+iG4VsrblX1KeD9CKefgMyQSaBtQ6+ZVuaR67x54pje5CkyGTRqiPdXu
         8bUbM0WLpdRfe6lhp5T0VU50Ct1L4ce5YzNXjDSOPcWsFZKcK5eobetK/dXHVr+eruti
         RmRS7U5stIOb/AfELV3FIBnYWpwCgkvAtbj2lsOHdaWpfwEg8TyOvDkd+4bwRnHtrJkP
         YEpw==
X-Gm-Message-State: AOAM533550vNZ8exqTlK6JdiOh1QU5xL8zhKz3ea6Ex3xCIn6Rsj6Z9W
        v13gstH41su9rhqbCSt4HwcORTMRC6sMEE/+ozM=
X-Google-Smtp-Source: ABdhPJzJUjRLlyo7JdDdyBu3gcVbAsM6kHhBtoT1Aw3Ze+/090Iz9heLoRZeZ4XrugWpuCyngZl+ic8HFm4NJBmP1r8=
X-Received: by 2002:a05:6a00:15ca:b0:49f:d22b:afff with SMTP id
 o10-20020a056a0015ca00b0049fd22bafffmr6214367pfu.35.1636446056399; Tue, 09
 Nov 2021 00:20:56 -0800 (PST)
MIME-Version: 1.0
References: <20211109003742.GA5423@raspberrypi> <s5h5yt1c0di.wl-tiwai@suse.de>
In-Reply-To: <s5h5yt1c0di.wl-tiwai@suse.de>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Tue, 9 Nov 2021 17:20:47 +0900
Message-ID: <CADLLry6o=NmreEhe1BF2czW4dhKAUyi271uQEfUrGoObjpy7QQ@mail.gmail.com>
Subject: Re: [PATCH] ALSA: missing check for possible NULL after the call to kstrdup
To:     Takashi Iwai <tiwai@suse.de>
Cc:     tiwai@suse.com, perex@perex.cz, alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?6rmA64+Z7ZiE?= <austin.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2021=EB=85=84 11=EC=9B=94 9=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 3:24, T=
akashi Iwai <tiwai@suse.de>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, 09 Nov 2021 01:37:42 +0100,
> Austin Kim wrote:
> >
> > From: Austin Kim <austin.kim@lge.com>
> >
> > If kcalloc() return NULL due to memory starvation, it is possible for
> > kstrdup() to return NULL in similar case. So add null check after the c=
all
> > to kstrdup() is made.
> >
> > Signed-off-by: Austin Kim <austin.kim@lge.com>
>
> Thanks, applied now with a minor coding-style fix (we need no extra
> parentheses), the correction of the subject line with the proper
> prefix, and the addition of Cc-to-stable.
>

Great, Thanks

BR,
Austin Kim

>
> Takashi
