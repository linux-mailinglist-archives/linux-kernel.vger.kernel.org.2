Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB5143FC0D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 14:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhJ2MLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 08:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbhJ2MLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 08:11:09 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24040C061714
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 05:08:41 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id x9so2758237ilu.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 05:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S3e8pqbxO9kRMVq8vTunu1hvd4DX3hvFiOfDtzQfJiw=;
        b=vDb11hdP7H142tuAwbW3fpRhtcsPF8+mDNWdkpY8XDnvO54fGT4iV2BLa1A2nTyboS
         9YfOqV622Xaiww6i1aDyRsh1x4jvfyd8V3kOdmf7OFJ7Q9KR86zwKzVfaKSqmxxTCve8
         FdT5PePhvMq0J/UvD+j5pvJECeiHON0NUCu+/ovOjNRAkK0Ns+GThHxybtl/xIu4PBKl
         Bc1lXbseEXeud9gSkwXsCqIQGq/R1MkybMwALEelm4/LVOet5K53Oc+z32vZaoxfHq5S
         H7vH1XN98l8vZFb4H/jAIAvaaUX/W579IFlqPoMAckwB0xdNZ60jtcK2Pt0EKPbntJz0
         fjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S3e8pqbxO9kRMVq8vTunu1hvd4DX3hvFiOfDtzQfJiw=;
        b=QwT4z968nyRQ44Mu25Ue4vLPcAWLAnMDSYEMRO95TsGmCmG3NjYa/O9AABgNUFtqon
         +9D8ApwQp7nLjAfqq21JcopE/tDg5jV93FPgez67h3136ehI+/hqqiXkWWjEdPeaaK0p
         TYB1k76dIy4S8ez87zyHic7Z2PfGdDu5CIHydQaiXe0ZimGv/f1eFxlAWx5d+2eP5qI+
         yXkOj8n0floDaoFFuZ61FvYm28brsOXWuiSPIe+pfKZcJNKaB0XmW70gTdrBtTj0AkWz
         /1WWSZv4bT0+QOVQagxKlNqaLBY4buugGJiuOUpI7fhJHRFCnvI9wuR61XS7ccraHimo
         rUJw==
X-Gm-Message-State: AOAM530KRuEkpyz1FGzKUOYCq1Rb3nqpy+hp9/PMe2a03aXjIiw00zfQ
        t0Hd99M+d9Z9UsUQjPzRfc7h8DgvYUejnFtOF2m0XQ==
X-Google-Smtp-Source: ABdhPJw7l9tTUHM1yjutTmZWrPVU1tYWmwCykIMHpGpIY9tktiGxDmCCtsSRhTXKzw5/yB3eWydyUujIuks7RoqM8kM=
X-Received: by 2002:a05:6e02:1d9d:: with SMTP id h29mr4170466ila.29.1635509320573;
 Fri, 29 Oct 2021 05:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <YXlxhpZWf2mxJaMi@fedora> <20211028064513.guziv6uaivzlk6ki@pengutronix.de>
 <20211028091442.GA16514@gofer.mess.org> <20211028111535.x7xgz7domx2lpyfh@pengutronix.de>
 <20211028122610.GA18767@gofer.mess.org> <20211028180516.t2tpfbzztm7s6cqm@pengutronix.de>
 <20211029071608.GA28997@gofer.mess.org> <20211029110602.uugnbm5vtfpghiwh@pengutronix.de>
 <20211029115412.GA32383@gofer.mess.org>
In-Reply-To: <20211029115412.GA32383@gofer.mess.org>
From:   =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>
Date:   Fri, 29 Oct 2021 09:08:29 -0300
Message-ID: <CAH7FV3njgZ7sOnZZF88KZ2C4UwqxoodpUuLsnucvBxYXmaZo1Q@mail.gmail.com>
Subject: Re: [PATCH v4] media: rc: pwm-ir-tx: Switch to atomic PWM API
To:     Sean Young <sean@mess.org>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        kernel test robot <lkp@intel.com>, mchehab@kernel.org,
        thierry.reding@gmail.com, Lee Jones <lee.jones@linaro.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to thank you guys for the attention and this interesting
discussion. I'm looking for some work in the kernel and I would like
to know if you guys have any suggestions for beginner tasks in this
subsystem. I have solid knowledge in C programming, but I started in
the kernel a couple of weeks ago. Anyway, thank you for all the
feedback.

Ma=C3=ADra
