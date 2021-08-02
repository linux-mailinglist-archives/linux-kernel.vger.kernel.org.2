Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998043DDC64
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbhHBP1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhHBP1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:27:19 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35D2C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 08:27:09 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b7so25043928edu.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 08:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kUFl9hAIN8lvCQA5YPKWnJI4Gz3za3JFaNPbXmZ8AK0=;
        b=WUpp5ubyxqNvDpB2nne9zl3iv+RK+siCwm7zWe4sjPE0yERrqxd1OoPqajXgzpm0wB
         zm88Vjj0fD+R23LidqDisxTggfv64kJT9MhIA8zRAFAhi7eQvjosWIv+JSlbNNEAuqqN
         ms8VVHUvfF6UVl8kq8o4YPxX7mjSkO2eVd80pnKpuvRtK7iFmXuMV63n6T8XHXdmX7hg
         dFygzT2+iwF3+q6enLxmRzcLuGAgg2C0asfpqedxZ9STOnEKCgAfY26eLFf+UpYWn+T7
         u8s6/ppZihpobZ6QShK0aK1qKdw6eiE8dVr/bqbiMumngnqOcrpNwKujm2ILegnNk2FE
         1Ddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kUFl9hAIN8lvCQA5YPKWnJI4Gz3za3JFaNPbXmZ8AK0=;
        b=q+FmOKdjQp/GX8dST8crqvETOvpV4Pde8E1Zg2oybr+DDVmPI44zUFjjG6MXIDQwGp
         MY+ozZCzKMnvIoVXMXc62SmnqhOKXmBaXd6N2M/WSynsowtWIf1qK9wHSlWwgoA+7WDr
         Om+mz9+vnV7lHw7PYfpdNImq5ni84xAxuiXLvYzx47CIWvDeSvA5EXZck/oW2MwsyXfG
         VTHOE/64fepYbBcVQGCef1ZUiY8nniYfFHORSQKYWWOU4iE1IKPXHpLSAFf4WB/B+Qhs
         HJZ9M3PZrWwI2FWmDdEoyuL7S3MZiJa8FuPqLEVkLCRTJ1RGT9AGBDZfgVeNx2lYxEs3
         dOTg==
X-Gm-Message-State: AOAM531No/w/OHZdcAoy96YbTxOz1Z03wqTJ4YCZG1OSCc5xf/oS29Al
        YNe/kymoqtuAHZdWCDAwMgZ2wKWkD7wbS4uOcxgZmw==
X-Google-Smtp-Source: ABdhPJxhDn6ZpCBmuDgar+9Ku9A9rJ17ctbY4fI34T93D8S8II3xubVHiIpCRBiLFHBi+mDYN59xAWFh+HcL0oRCGjs=
X-Received: by 2002:aa7:c857:: with SMTP id g23mr19626574edt.100.1627918028334;
 Mon, 02 Aug 2021 08:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210731192637.3653796-1-lrizzo@google.com> <YQf9h+qvWCx6D7XT@8bytes.org>
 <CAMOZA0LEr+xM6RrsJErPMqHP7-0GdLmNDqbGVKbKTn92=Ncejg@mail.gmail.com> <YQgDfIcFW5h9TH+n@8bytes.org>
In-Reply-To: <YQgDfIcFW5h9TH+n@8bytes.org>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Mon, 2 Aug 2021 17:26:57 +0200
Message-ID: <CAMOZA0J7B=rnVpaa6WiMf3Hpr6=tk1QZeDRWjRFFW04FLx4n=A@mail.gmail.com>
Subject: Re: [PATCH] amd/iommu: fix logic bug in amd_iommu_report_page_fault()
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        Luigi Rizzo <rizzo.unipi@gmail.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 2, 2021 at 4:39 PM Joerg Roedel <joro@8bytes.org> wrote:
>
> On Mon, Aug 02, 2021 at 04:30:50PM +0200, Luigi Rizzo wrote:
> > Ah didn't realize that. Thank you!
> >
> > Two questions on the topic:
> > 1. how comes only the AMD driver is so verbose in reporting io page faults?
> >    Neither intel nor other iommu drivers seem to log anything
>
> What do you mean by 'verbose'? It is only a line per fault, and at least
> the Intel driver also logs DMAR faults with one line per fault :)

Ah never mind, I was grep'ing keywords from the amd message and
there is almost zero overlap!

thanks
luigi
