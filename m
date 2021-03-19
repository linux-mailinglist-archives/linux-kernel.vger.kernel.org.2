Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644B234221C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 17:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhCSQkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 12:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhCSQk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 12:40:28 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D19C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:40:28 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id r8so8595172ilo.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=izIEFz4gKduBvKmkv0L0aVCvw7OwgQkYzS6Mw5t2C08=;
        b=bNcFbS5Km2fEG/UU1TaaX6cCpfZyY3IAamJffzueTP+ovss8uHxLTqrSCv1/usENQp
         c8R0SNEZfTMtJr3up0coiCzFF90HeEvglgPwMb64xSOxhTUjm5NEZpl/KUYDbrbZ249k
         PikiKlqaPgMWvr740PRBeInc9iATG4X7cKueE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=izIEFz4gKduBvKmkv0L0aVCvw7OwgQkYzS6Mw5t2C08=;
        b=Jn0WgTKNYYHO9pr8r6E8I35xSYsDYYC1RqsmgDFm65PIgah5Qj7sSSioFbmoxgI0eK
         OsZudGQtANBJ0MB8RXRpq6HYJGiSxD9r0NFItsmFpmy36YeL/a4eMJhPFE6853yyQUKQ
         kIztXSZGI6T7sSPQAq0+rn2+SsiYZUnmQuXZPOPEm1VtiFQB7eJ3uhefv2P2WC4iTwZm
         QP1iv3n60om8l82h94Q3rjKgf78smeSFLyZ051n2cL1eynNMKVqAceGSoeTbyMZ8eF/Q
         voA0mwruWY3yuxWqcssXzSt+lhHsgBw7CQALoh6t5rdPDAjkbRPCZq9vT50h5WwpJRz2
         8feA==
X-Gm-Message-State: AOAM530t9M1+YJ0K8bDKPzrIqVXuRPdMOGDBG4wrxS1DEGmL2aldbNqU
        T1f4ZXiPH1FrGC6TzaRMK4dTHnHb7xwZUxpa
X-Google-Smtp-Source: ABdhPJzsb0e72LDdAS/lCLgtEy7itAZKX2J/f5OeK8u43OXoExuEAaFSRxO2BOJ6BUjFETpkjd55Gg==
X-Received: by 2002:a05:6e02:1a02:: with SMTP id s2mr3349350ild.48.1616172027432;
        Fri, 19 Mar 2021 09:40:27 -0700 (PDT)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id w6sm2816550ilm.38.2021.03.19.09.40.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 09:40:26 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id v26so6751225iox.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:40:26 -0700 (PDT)
X-Received: by 2002:a05:6602:26c6:: with SMTP id g6mr3372529ioo.150.1616172025834;
 Fri, 19 Mar 2021 09:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210208051749.1785246-1-sergey.senozhatsky@gmail.com>
 <20210208051749.1785246-4-sergey.senozhatsky@gmail.com> <CAPybu_10Uz0Eb2U5ZohNV1t0gf98ZBZOa3KFCzdi1RJ0k3c1yQ@mail.gmail.com>
 <YFFiizDjNBMG3uI+@google.com> <CAPybu_0ruoc-w3402j-vVNs2-xq8=-_XzVKSxiG+iuyB=eNimA@mail.gmail.com>
 <YFLbYjm0VyzaEMkr@google.com> <CANiDSCtCaVUxrYeceWXEJ3o61ze8uNyce69xW_KcQTirhWfZaQ@mail.gmail.com>
 <YFQ4HuavL7R6VPha@google.com>
In-Reply-To: <YFQ4HuavL7R6VPha@google.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 19 Mar 2021 17:40:14 +0100
X-Gmail-Original-Message-ID: <CANiDSCvCL1DirLw5SrBOjNo6ow2hz4jHZ1FQA4ohWUAn=s99zg@mail.gmail.com>
Message-ID: <CANiDSCvCL1DirLw5SrBOjNo6ow2hz4jHZ1FQA4ohWUAn=s99zg@mail.gmail.com>
Subject: Re: [PATCHv2 3/3] media: uvcvideo: add UVC 1.5 ROI control
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey

On Fri, Mar 19, 2021 at 6:35 AM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (21/03/18 22:19), Ricardo Ribalda wrote:
> > >
> > > May I please ask for more opinions on this?
> >
> > Could you try setting the roi in a loop in your device and verify that
> > it accepts all the values with no modification. If so we can implement
> > the set/get as a quirk for other devices.
>
> Tested on two (very) different devices.

Ahoy, Matey ;)

That is great news. Thanks for testing this.


>
> Firmware D:
>
>    CLAP all passed, we are cool
>
> Firmware H:
>
>    CLAP all passed, we are cool
>
>
> Code sample
>
> ---
>        in_selection.target     = V4L2_SEL_TGT_ROI;
>        in_selection.flags      = V4L2_SEL_FLAG_ROI_AUTO_EXPOSURE;
>
>        for (int i = 0; i < 1001; i++) {
>                in_selection.r.left     = 0 + i;
>                in_selection.r.top      = 0 + i;
>                in_selection.r.width    = 42 + i;
>                in_selection.r.height   = 42 + i;
>
>                ret = doioctl(fd, VIDIOC_S_SELECTION, &in_selection);
>                if (ret) {
>                        fprintf(stderr, "BOOM %d\n", ret);
>                        exit(1);
>                }
>
>                ret = doioctl(fd, VIDIOC_G_SELECTION, &in_selection);
>                if (ret) {
>                        fprintf(stderr, "BANG %d\n", ret);
>                        exit(2);
>                }
>
>                if (in_selection.r.left != i ||
>                    in_selection.r.top != i ||
>                    in_selection.r.width != i + 42 ||
>                    in_selection.r.height != i + 42) {
>
>                        fprintf(stderr, "SNAP %d %d %d %d != %d %d %d %d\n",
>                                i, i, i + 42, i + 42,
>                                in_selection.r.left,
>                                in_selection.r.top,
>                                in_selection.r.width,
>                                in_selection.r.height);
>                        exit(3);
>                }
>        }
>
>        fprintf(stderr, "CLAP all passed, we are cool\n");
> ---



-- 
Ricardo Ribalda
