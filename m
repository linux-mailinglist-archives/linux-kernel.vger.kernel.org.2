Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BB83D9841
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 00:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhG1WRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 18:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbhG1WRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 18:17:18 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A912C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 15:17:15 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l19so7416939pjz.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 15:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xt0NXK+H6bJd9bnnm9cvAJ4y45wGQkVige8G5Umi1CA=;
        b=vEaa4dDeac8LD1acoUW9tefGeFHRP/w4agRgkhlQXwXzg34Ehtd7jHBTBFmt+KDzt9
         w+3FYyDN7mQkp9hRCYRkFAol2oq8S0EtTJiRyjDXnEvNbIoT3VyA1y0VxqmPo1WCKg0S
         YoyKegu1GJ/Gc23aQQI5MHRSkeG1FuKs4tQVhWK/VwcRzTZgoHAqevbauG1tIZtSYnbe
         WxE9us2ZJ+b4iKaS0/K8Rzq7VTmDGwKa/LoU7FvjxkuHpIrjxsJTX1W/OL8PJLc5BSBe
         gqajCFdpkWyG5aTzSdWSFnE2M6cNueYKPcTDNp87xWi4PaZwstfSpbmQzkCmqaPJIuqk
         bJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xt0NXK+H6bJd9bnnm9cvAJ4y45wGQkVige8G5Umi1CA=;
        b=Fm5mUrhDtE8Mx7FIx1oieAaS8uHKyOPEfrZrhh6TUTQnUymORSs85kFNblI6Jda/5w
         lHt/zAIF9nI94Utr1WRuAVupvsipVzBqcyLLLrtY+LSDvTlsu6zqJ7egoqsEZYaXSj83
         5HzpYT6eEnsJH8XNQEI+EGwJnxvXXm+n74vu60b/1n8NsxZ93JvxsiQOA0BLklR75Txk
         /Zn1N2DAmF4IGrijX9oeJYfJcTtsBUmehnk/hF0rh4pksTOVCkGix+D2SszpFUS6HfQp
         MpynhdaaRPLD1VvXUGIvM9uV/gE/1Dxk6x41rM3NxLdKjRIBOLH+L2m60esM0AtMuMfo
         USmQ==
X-Gm-Message-State: AOAM533/mmDCQwoqfPR84i+OvKTUawdpfkUOJ+kodTPrj9vYxlRXdGWs
        QlCzsrzvVsKg6ec+1DL2z/LqTdFXynnE9OjE4uvdkg==
X-Google-Smtp-Source: ABdhPJypKjcK2osCbLWCRwN08jcNKfs+sWQUroChMf+l64prEvfgvKosw0q8cVPsVYKppcqSUgvmDLDBSlT6FIx2DV0=
X-Received: by 2002:a17:90a:1b01:: with SMTP id q1mr7887939pjq.162.1627510634892;
 Wed, 28 Jul 2021 15:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210727232219.2948-1-phil@philpotter.co.uk> <YQGenmf2m3Tu7FFg@kroah.com>
 <9902deed-021c-ad37-7fc7-f4279886c683@lwfinger.net> <YQGoLPnL8s2buxFe@kroah.com>
In-Reply-To: <YQGoLPnL8s2buxFe@kroah.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Wed, 28 Jul 2021 23:17:04 +0100
Message-ID: <CAA=Fs0=bQt8Msaw_CjgjAsmQFjm6U3bag76K9uKHVfMPaehtvg@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] staging: r8188eu: add newer/better RTL8188eu driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2021 at 19:55, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 28, 2021 at 01:41:15PM -0500, Larry Finger wrote:
> > On 7/28/21 1:14 PM, Greg KH wrote:
> > > Hm, I thought this would be in better shape than it is.
> > >
> > > Right now we have 107 .c and .h files in drivers/staging/rtl8188eu/ that
> > > come to a total of 44597 lines.
> > >
> > > So we are taking double the size here?
> > >
> > > I'm all for putting a "better" driver in here, but this feels odd to
> > > me...  Is there major new functionality here that is not in the existing
> > > driver to justify this?
> > >
> > > Ok, let's see how this goes, I'll give it a few weeks to see how much
> > > can easily be fixed up to hopefully get back to at least close the
> > > existing driver size...
> >
> > The major new functionality is that the new one uses cfg80211, whereas the
> > old one uses the WEXT calls.
>
> Ok, that's worth it alone.
>
> > It really is an improvement. It just needs a severe cleanup.
> >
> > I warned you that this code was rough. It took me several weeks to get the
> > old one "ready" for staging. I never devoted that effort to the new one, and
> > you wanted it in a place where multiple authors could improve it.
>
> Fair enough, I did ask for it :)
>
> I'll go through and do a license cleanup tomorrow morning to start with,
> that should knock a bunch of lines off right away...
>
> thanks,
>
> greg k-h

Just stripping the debug code out of this version again will free up
quite a few lines I think as well :-) Will get started on that.

Regards,
Phil
