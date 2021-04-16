Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7931336231D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245274AbhDPOqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244605AbhDPOqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:46:36 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C10C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:46:12 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id f15so19162068iob.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yYbdy738YZSLcRHWeIc/rXEkRrBDPjfZ8CjoruCy+gk=;
        b=z2EiDumIKflW5Y2jsMQs3gNynYUnYBkWTKgg4sKgJk8PrTg0hKWCLc+Lr0Gw6iZaSa
         /khUtKGEbnxqEz0l0jyI00PNqA1BkbGTgMujzS7mjAncrN1opi+bmA+qnlSOpysogFWX
         SdFZ/NFRps6pQKTrcfiYFnsyyF/nJp1rkMsmeJ9JmQXgPUA2PczXLyhudbZ+5ZjuqUBD
         4sZ3KFqhjgsJ5ahMQPTzSoDmWptvu/9Fe1PCs5Kh1vr0RkpwYaB0UBtOQpMtwX0VTDZh
         C61Mkjbo5kgwk/Pm45YUycckX8qVHZbgweqk24QAV/70TQzszCuBEwvoKohbLQkc3wjT
         +C3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yYbdy738YZSLcRHWeIc/rXEkRrBDPjfZ8CjoruCy+gk=;
        b=IUBippKdPXqX3x6MI8dvzXVeXtRO0RA59PozTrCRui5T768o5kWZJfyPX+HFZ4LQzf
         4x+w/ZkAzAPRksmfRUdQeJ/uT2uulZSfEli5DgbvVKyIFi0PU9ZbRTkni0j7vJaOV6mC
         pfiH5FEYp4prxQ4KDB/E28J5FbzlwDi6uLhs4mdFLc8Z8uykn2IzEb3swrj23aS25xrP
         DMPkMh5guhphCy69KkvURLJFJ4T/nIcoKUJo/kCk/v5XlK33aTFpN4bZTgTfJ9vYxKkX
         R4lIzz5YC98UXaF4FbOuhq4bQT1E3LTPjbWribcaenRi4fDRMZ8lEcjztTtxtbwP+Iro
         Y8sg==
X-Gm-Message-State: AOAM531ZMwUHp9RszJMyVFpicV0B0onNdB7PnMh/AeNkPLAeoEEcH9yy
        7fSOsGK9mEHwFRChGkeA1b/kUEu8+1cf0hBDaPpqNA==
X-Google-Smtp-Source: ABdhPJx8ZQwst2KNubris3aC1UDWKGesJFlm8qEQTf37aQ0qmaDu6K1V7H7yfOxbRF1YInb4nxFRhFeb4NknxnwERt0=
X-Received: by 2002:a05:6638:3013:: with SMTP id r19mr4449140jak.36.1618584371813;
 Fri, 16 Apr 2021 07:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210415202404.945368-1-mathieu.poirier@linaro.org>
 <YHk0iDnfujBR3mTB@kroah.com> <YHk+jRT/164eCnWa@kroah.com>
In-Reply-To: <YHk+jRT/164eCnWa@kroah.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 16 Apr 2021 08:46:01 -0600
Message-ID: <CANLsYky+tu0a-h1V=1AegXm8UvpfAbSfwYv0TgSQzRj1fZ=1UA@mail.gmail.com>
Subject: Re: [PATCH 0/1] coresight: Fix for v5.12-rc7
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2021 at 01:36, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Apr 16, 2021 at 08:54:00AM +0200, Greg KH wrote:
> > On Thu, Apr 15, 2021 at 02:24:03PM -0600, Mathieu Poirier wrote:
> > > Hi Greg,
> > >
> > > Please consider this patch as a fix for v5.12-rc7.  Applies cleanly
> > > to your char-misc-linus branch (e49d033bddf5).
> >
> > It's too late for 5.12-final, and really my tree should be closed for
> > 5.13-rc1 now.  I can sneak this in for the merge window, is that ok?
>

Yes, definitely.

> I've just taken it for my 5.13-rc1 set of patches and added a cc: stable
> to get it backported to 5.12.1.
>

That will be just fine.

> thanks,
>
> greg k-h
