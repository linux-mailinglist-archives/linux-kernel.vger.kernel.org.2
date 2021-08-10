Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36823E861C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 00:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbhHJWgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 18:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231380AbhHJWgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 18:36:47 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C315EC061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 15:36:24 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso1475730pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 15:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KyLzU1jfaVAOmtKaZRdXJ+6c2xTKLNopZF4d/eV+on0=;
        b=cwVgqrNxO6fUitc37W7Flhdj8P26vPMPrmosnYTS9KIhGzFjr3bz/EeTrgW5aEZnBH
         Nd+EuhmOdeFiMgwjawwPNMgtGrz9G2qiIwDTRI8jLeYySXGlCRl2q3qfWbldXsUlzUBt
         38EIYKZYr+s46ZqhsvxSsXWsxFN5KeQvXgBQSPiM30SbqOI2sfbxxNL9C/eLU02T2I7B
         AzCIlBGLQsls5Ra0KLlchhEhPsxtXCXUF7z7kc3LACrU3rWgImlyTrUCcZNa5erz2rdX
         Q3VR1YcpIAfJUUYmJMg07hId6dZpWiFOGZMM9oXFugbrgjp9rbyb11pXNiCojTlk0iOa
         2DFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KyLzU1jfaVAOmtKaZRdXJ+6c2xTKLNopZF4d/eV+on0=;
        b=J5qvUoJwfmDgelsz72sJYejER1mLz528y7nNi2dJ1a40KxdT4xtptQvWBXnN18YU6X
         VlyZz1iqkn7Y7TfSYctKQfuJevN/oS0iA9b9YDoet9PL0K8AjgXmW2xZWjY0jYe2BVWj
         8AgUVwvRx6SL/d4DNimYm37KK00x7ikpsb3c0xO/CEdr8BZPbbFxKOOxfPe7Ik7sXCXo
         zevzAFCjipJANFuyYBzCWV8KIynVzC6iZOIZMeC5D/62SSYsG7RIlzELhzPMotEXhMBK
         P0qyQyEIZmz4UluhuE6334EOi/pGV61PXVCClmSt9nS1DVH9ASllk77YXhGqkms/1G97
         I7ig==
X-Gm-Message-State: AOAM531a5VJ9Od/i7mbN2aeqzaUOTyCjUXxj0V2OTZYbkWMxtS4YhgL4
        02ZxJde3T2QW4QnU3JhTdegPCYI2F0YyGChQNujvPw==
X-Google-Smtp-Source: ABdhPJyV8FUMwdMg8PfFOJwCLAIrusVoyrcLD9RjjfO2tkmyno5xATT7Mc/YJO4XHPQG9iC1bnxBPZLYbWQgAGb/xOU=
X-Received: by 2002:a62:5c6:0:b029:341:e0b1:a72c with SMTP id
 189-20020a6205c60000b0290341e0b1a72cmr31080061pff.71.1628634984338; Tue, 10
 Aug 2021 15:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210810074504.957-1-phil@philpotter.co.uk> <20210810080640.GV1931@kadam>
In-Reply-To: <20210810080640.GV1931@kadam>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Tue, 10 Aug 2021 23:36:13 +0100
Message-ID: <CAA=Fs0k04m-4ySt7eWfrKTPBdUHTguT9j08pgYJUbDOYE1yuyA@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: remove rtw_ioctl function
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2021 at 09:07, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Phillip, Michael, and Martin,
>
> You are all working on this this same driver.  Could you Ack each
> other's patches?
>
> regards,
> dan carpenter
>
>

Dear Dan,

Certainly, will do. Will keep a look out for Michael and Martin's
future patches in particular.

Regards,
Phil
