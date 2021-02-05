Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3035631052F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 07:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhBEGvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 01:51:25 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48776 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhBEGvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 01:51:12 -0500
Received: from mail-lj1-f197.google.com ([209.85.208.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1l7uwl-00065i-Un
        for linux-kernel@vger.kernel.org; Fri, 05 Feb 2021 06:50:28 +0000
Received: by mail-lj1-f197.google.com with SMTP id q8so5062032ljj.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 22:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jrPFbtDQsFf+eCKFtIVPRYyTFi/LPQugYwt0EUGsKy8=;
        b=DqZ3l9cJcnXrrvFfoIkhrlRlCjX2WZBUaLqik3EW9KPmHlroBiMCBe61AkfFjl8VUF
         XRc5BW5L+vh/0ffme293T6IwxrJj/3acbvKyd+VeYOjWbLxVyHtuCr6+XqIs200cXwGF
         U+nrmaePO7sI+EDKBFSH3kA0dDAfLeDvRlCX2javzQ0+PjGowfHcYZ9lb9QdXKZx4hsr
         MsHoaDTk9nq8vzQmbIGBcOwacjIkESgwUbV7pP0rejmCfBZhyBWbLMYWmaZL02/Ia8gf
         qww+oAAKnOj6vJggWl79ugEbbd+AqdKZR6iLw7eXDyW8s47k8mOOvVGCNmKKRa4TjGqL
         3/uw==
X-Gm-Message-State: AOAM533ExMpMCtW9U37YfzKrGUXCb7rihs2iy+hm6LOPmb9yxNJPyFLs
        AqJd4VaN08YN56wXGTryK4Oikn3BwlemrKKvu4JbtZ2Jlb9XIMwA4/wg3GlA0zINdK7MlxDEuI3
        J+pfGI8MT3MrJlI+NVnlsSzqU6LYkN//sxZExnt5Obrg/iOgasxNj9iE67Q==
X-Received: by 2002:a19:7001:: with SMTP id h1mr1709127lfc.513.1612507827406;
        Thu, 04 Feb 2021 22:50:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzl73IbLy1fwn/PAGrPXI17t3pVODRhmH0RDwiZEA7fC882L644FgBfcoZ6bn4IJEJPdGRUfz1WXaRX2Xl7MK0=
X-Received: by 2002:a19:7001:: with SMTP id h1mr1709116lfc.513.1612507827118;
 Thu, 04 Feb 2021 22:50:27 -0800 (PST)
MIME-Version: 1.0
References: <20210204051850.64857-1-aaron.ma@canonical.com>
 <CAAd53p4euFiw7pfDnD2H8oMVeeTqQ_c+wOFDLM2xPccn5MewiA@mail.gmail.com> <cd4595e6-67da-885c-1a67-6dfd71425b8c@canonical.com>
In-Reply-To: <cd4595e6-67da-885c-1a67-6dfd71425b8c@canonical.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 5 Feb 2021 14:50:15 +0800
Message-ID: <CAAd53p4z1ydFi5pwOZJnsrBDPNVLKU0ygqa0+kdZdXWYocPLgQ@mail.gmail.com>
Subject: Re: [PATCH] xhci-pci: Set AMD Renoir USB controller to D3 when shutdown
To:     Aaron Ma <aaron.ma@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lee Jones <lee.jones@linaro.org>, peter.chen@nxp.com,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 2:45 PM Aaron Ma <aaron.ma@canonical.com> wrote:
>
>
> On 2/5/21 12:27 PM, Kai-Heng Feng wrote:
> > Can you please test the following patch, which should address the root cause:
> > https://lore.kernel.org/linux-acpi/20201201213019.1558738-1-furquan@google.com/
> >
> > It also helps another AMD laptop on S5:
> > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1912935
> >
>
> No, this patch doesn't help on ThinkPad AMD platform.

Thanks for the confirmation!

Acked-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

>
> Aaron
>
> > We don't need to put bandage on drivers one by one once the patch with
> > alternative approach is in upstream.
> >
> > Kai-Heng
