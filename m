Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E517A44D700
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 14:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhKKNM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 08:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhKKNMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 08:12:52 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3B9C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 05:10:03 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id e136so14931729ybc.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 05:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nCiU1h64rx5pX1K0fkW1z/FMYz6g6Gjieb21yotPglY=;
        b=CvXVpr5HtggFlBdbWFqbVvGu/TcUumF+KeTkR8hV7DjVrNM0775Vxi+Xum808xoAxz
         sfGB8+5hOMf/CKv2/vfJloeHqG0sEU5WwPXelcbfbAVrWmX1YEq74DObf6zuqtvTRH6K
         rf+EWxk22SvYTa4oXaD34c13hX6QhzCJgIqekgMrX3ICMII2/t9NtrHihSBhHCieWEwN
         ib0/QUiIi3uf/mAFwbctjufNQavhX03KiSqMbSxVZpcjN2mLcs2eVB/kRiNKgGubOEPN
         W58ZdQ3s0TyXEocN5JkZ2Ta6QNzZ5mrobfCxavFvIKJcVgo0hY0BFF9RbF6W9AbKCxT5
         kJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nCiU1h64rx5pX1K0fkW1z/FMYz6g6Gjieb21yotPglY=;
        b=MLTB8nkCqyOQkQhCwQd4rk2JhS97eChK5HKBvLEL2d+n+b9/QrFPDL8NDD8LfQ1qyO
         svxdMO0/k5nrHvkRmeEvhirUQ+mxqvoO+slCJ5DrD6EZYyHOYdUMNNO/pdJCT17CyENd
         1twvEdnlcIh7+O7k1zYhWxOvdFuh9MjRceme7JxINGqtoJkkubKYI9zFIvkMXrHgK3SU
         rhWIk5wNF0dYOVCbO10495vnwXNanWbV/dsEQckGS2/dXsiBF1E6YRL7YjSU5itwv0Nl
         TVKziFDI5exwzkECsIlaNRRR9jhEsiPWEhAUkuR0uD9EEBKEslrH33rDEpJNFQdRpI92
         w9FQ==
X-Gm-Message-State: AOAM5301EjJhnHT7fCkNrOqonzaXrtCli9T44mg1wkcxgZfbP86CPFZt
        DD5nzverAHAC+KWoeWZPxjF4uHRL0bhZQBt8U8V6rg==
X-Google-Smtp-Source: ABdhPJxPCFMFVk/7fCxSyRoEBPf/Z5fAj/TAhaeD/NynAh9WVjJ18XDshk8Rqjz+IEP6VXUyVgq72pfA18fxAcythhc=
X-Received: by 2002:a5b:648:: with SMTP id o8mr8630359ybq.208.1636636202993;
 Thu, 11 Nov 2021 05:10:02 -0800 (PST)
MIME-Version: 1.0
References: <20211111084617.6746-1-ajaygargnsit@gmail.com> <6864f744-ca3e-f328-8793-2adb0146db03@bytedance.com>
 <CAHP4M8VNZY+NLzUAVHTWK6a6pggvv4a-q9nvYAqkkco6id3Tog@mail.gmail.com>
 <CAMZfGtXCFJ3NUw-bBsphLbCtdDAfHERAEkTSMU9k1cfd4DrRMA@mail.gmail.com> <CAHP4M8UY0F3gx0eVYGKHfcoN-=f6ApT0CjA3xsZRrb3HVphK6A@mail.gmail.com>
In-Reply-To: <CAHP4M8UY0F3gx0eVYGKHfcoN-=f6ApT0CjA3xsZRrb3HVphK6A@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 11 Nov 2021 21:09:22 +0800
Message-ID: <CAMZfGtUp6dkT4OWzLhL8whqNnXAbfVw5c6AQogHzY3bbM_k2Qw@mail.gmail.com>
Subject: Re: [PATCH] mm: shmem: do not call PageHWPoison on a ERR-page
To:     Ajay Garg <ajaygargnsit@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 8:21 PM Ajay Garg <ajaygargnsit@gmail.com> wrote:
>
> >
> > What? I put "if (PageHWPoison(page))" into the else branch,
> > it should be added braces since it's not 1-line blocks.
>
> Oh, ok.
>
> > Why do
> > you think it does not address the issue? What am I missing
> > here?
>
> That might work, however I haven't tested it.
>
> Upto the reviewers to see what they see as the best way going forward.

I just suggest, it's up to you.

>
>
>
> Thanks and Regards,
> Ajay
