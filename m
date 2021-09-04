Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD88A400C74
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 20:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbhIDSCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 14:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237178AbhIDSCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 14:02:06 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE660C061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 11:01:04 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so1688236pjc.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 11:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gSmgT3Ly1e+vklnGQmTDdpxyIzH++5rrmK8Wq9/Y2xw=;
        b=kvi5yjsPE68qmU5k6A9kXdZFV+7mWxixHJJ5pfZxMMgpfSnK46cnALob9kAjPWi2iU
         gTjV/YX1wGAyfOlKGxpKSplEVHScOIzjrbC/+PCpsToLYdrmTwg5atLsEqpF93UxmY7I
         ycQlnkVQDc/zCVCt+fIh5nOSYVkCNDMBUFVWKsO/2741yg8pQbWSYQrjw64vSG2fatl0
         q3PRgm2L83d0Z/D8kozVEAENrhqYSp/j561vEw4CskBtfdw2sfKUfzPqybeym+whn3ej
         viwuqFLKoZb2VJN/20oliBidu2AdvhyCLa80P7hPSXB9UU+yom3GPgAfEUxvPxu5wcXF
         IaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gSmgT3Ly1e+vklnGQmTDdpxyIzH++5rrmK8Wq9/Y2xw=;
        b=IaOZbowJffjnuNp/DhYTmXtepoldRtKLYZ6m4Q8WItxQgZx5HqcURJOT7uilXdLARx
         akylu+Jx0L8m1sHEND0l2kcrvwBrsxaCi7Z2HQmnbodGiD6Q1GGbW5mAo0FInj4nlUin
         D63UiJIiknaAY4Kh0I//JmUqBhjWU0l2zkNirUhrXS1w5zY+/wMX6K/8EhDOBOUH0ZoW
         0y7Uubl+DkJE1hDqDYChG+uORBV4oh8t5Lw789VeCD+6iTHII3bBNNq02Tqmd692AFG+
         2BpHBBxP2WMBG09fgk0lrXiSYW8zfW5dAm3sM0E684aFscxa+TGL5UGx8q2/E+IHU62Z
         CE9Q==
X-Gm-Message-State: AOAM530HyJGopl8SuW2lidnij39qc81x4j2K8mGHMcimEBed1IOKdNAk
        mHdIUSWBsDsl5TEiWxeU0NDWScW9ZGDo00h8ZghkYDFti6sxJA==
X-Google-Smtp-Source: ABdhPJwQlyXwwwA5y78EpGvc9g1P77mhCYjxmBx9xfm1UyzqSKNtv7DwAYJQlbZUmgIFT8WB3/AY5Dq1Skg/7oVM/Lo=
X-Received: by 2002:a17:902:6b84:b029:ee:f966:1911 with SMTP id
 p4-20020a1709026b84b02900eef9661911mr3973567plk.69.1630778464151; Sat, 04 Sep
 2021 11:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210904174030.1103-1-phil@philpotter.co.uk> <ea1cf28e-bb38-94a3-5032-4302cec4c30d@kernel.dk>
In-Reply-To: <ea1cf28e-bb38-94a3-5032-4302cec4c30d@kernel.dk>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sat, 4 Sep 2021 19:00:53 +0100
Message-ID: <CAA=Fs0n2EPaCL+kHxpQKYMoguFjkNW84sQOMUF47j0Nu+NdXUw@mail.gmail.com>
Subject: Re: [PATCH v2] cdrom: update uniform CD-ROM maintainership in
 MAINTAINERS file
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Sept 2021 at 18:48, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/4/21 11:40 AM, Phillip Potter wrote:
> > Update maintainership for the uniform CD-ROM driver from Jens Axboe to
> > Phillip Potter in MAINTAINERS file, to reflect the attempt to pass on
> > maintainership of this driver to a different individual. Also remove
> > URL to site which is no longer active.
>
> Applied, thanks.
>
> --
> Jens Axboe
>

Dear Jens,

Many thanks, I will try my hardest to do a good job :-)

Regards,
Phil
