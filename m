Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098A13D2F8E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 00:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhGVVbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 17:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbhGVVbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 17:31:46 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B86C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 15:12:19 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id a14so986985plh.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 15:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5JK1mRcn2HByH4E2JRUJGVuJhe+9CP6yUJGUebrttsA=;
        b=ZNBSRX8bhkGG5T5bLXeM04DElb+bgHe+jbY+bW4x4oTBS9/9UCAX61gn2f8p6Z7scd
         rc+WpKhrBtPcXMO9qacHy2VI8KCwe7KYotrgMsD+HuGNvnhpt/o5oxDfg4QwQGLJLDrc
         I14vDCXp7gygG3as8wIf7XH1zS6GnNmMRIrtvEPM/Hqx2TaGJIvZz5+RYYIq1rasrLKG
         +9Vdgmn448YuVpRAWP30hFxMYnqvg7itvM53VJDu+uyG85x7voI1bRNgZtDsVlHH4XWL
         QIPJsVigXF78rW+dCSSUZQD9ddsf9dKHLr20gisiFIEAVpCrJ0WYUWHNb5AKClhrQOds
         UOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5JK1mRcn2HByH4E2JRUJGVuJhe+9CP6yUJGUebrttsA=;
        b=JigCHxzV8wmnckzrCPEf6+lzR1A+YkOlBte0jlQW1m5dUESOMTHqwqZ3g8k9jbMAZ5
         k87XwQQer69ipEx/2xnjGiD2yNFpXnccN4CvnZX4AG/zpEnY186HwKk7fsz3Xzjdngcp
         3qi/IFxchP6mpUQLJ9gbffquboKutEkhfiKzSHMqCK3AGMpEx/9HJ1mMdseumnqMdSsS
         O1qY9Omnq05/lsgPLJ9yG96tw/sXuqVyoJ11z5ANA4VEttevGhgOiJls/MwSNbZls6gc
         xAIjlh651bnNSzkok8yL7zQIJrGG2TFPsfnPqBg7K3PtoxArlmCunpRCfQxohqsFSjKk
         Fi3g==
X-Gm-Message-State: AOAM532wqdjDIozAlX0Mo36LOin7Fe1ms4DO1H/3iO33mQBtAPAL0upS
        2/DUhmbqP+nhbX9KxW5aS0WXIyEGmGS5mTgoRY3hF/SRHSzUu9TF
X-Google-Smtp-Source: ABdhPJxNKrTn9YS3DIlzxQPd0zAPpU+qGdyfLaKWjAsSxBtxRNon+epeJyJ6C3cRciFPCeRG098cnl0FTsUGlyRzgSc=
X-Received: by 2002:a65:578a:: with SMTP id b10mr2027126pgr.208.1626991939409;
 Thu, 22 Jul 2021 15:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210719224601.255364-1-phil@philpotter.co.uk>
 <7bc43fb0-2dab-190b-c480-9e77cff863d4@lwfinger.net> <20210720090035.GB1406@agape.jhs>
 <08a8b372-8ec2-afcc-cc54-305d1dd74a59@lwfinger.net> <YPfRf8dgFd+u5hzm@equinox>
 <0c2d97fa-e1e1-3564-98b8-37d5b9a1a9cb@lwfinger.net> <20210721182836.GX1931@kadam>
 <ed7b7d93-f754-dce9-ca4f-425e49c972ba@lwfinger.net> <CAA=Fs0nvhxEhJhCTWH_KkYyB3Jz7Pi-t2a+6zL3K=O-_3-sLGg@mail.gmail.com>
 <YPlyZsuRJpkUwWiJ@kroah.com> <e91cf326-f393-4ad5-568a-dbdd7cc759db@lwfinger.net>
In-Reply-To: <e91cf326-f393-4ad5-568a-dbdd7cc759db@lwfinger.net>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Thu, 22 Jul 2021 23:12:08 +0100
Message-ID: <CAA=Fs0=bgZj6jtS3NsfB1kk4TX5BuoN3S5pg9jmnkPPVFYYgpQ@mail.gmail.com>
Subject: Re: [PATCH resend] staging: rtl8188eu: move all source files from
 core subdirectory
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, Fabio Aiuto <fabioaiuto83@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jul 2021 at 17:31, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> On 7/22/21 8:28 AM, Greg KH wrote:
> > If the code looks "better", I have no objection to just adding it to
> > drivers/staging/ and deleting the existing one here, so that everyone
> > can work on this together in one single place.
> >
> > Larry, any objection to that?
>
> I am not opposed to that. Do you want me to supply the new driver as a set of
> patches, or would someone else like to do it?
>
> Larry
>
I am happy to do it. Two patches seems sensible - one to remove the
current driver from staging and another to introduce the new one.

Regards,
Phil
