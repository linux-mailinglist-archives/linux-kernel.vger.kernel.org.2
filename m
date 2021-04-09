Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA9435A7EC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 22:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbhDIUff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 16:35:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49299 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234240AbhDIUfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 16:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618000516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=koMhPMwHT2lbb7QqoyG15e3gGwjcJZXavVfrNMzB8XI=;
        b=Qs5+cyf/dyGm4/dQBuLyFu7OtEL7zvrdWJzdTWMSRz7hng6QdNeMPcZiCRwi5pRlLjbdfb
        /9qADd6BuDbpycYpXHVvoxmcsd87iLXEGKyla17IGbFwZcSE88q7bc8jBfcYFeFyx6KEHC
        KQyN0hQP+AQHwOf2IebFnI4B06L9bRE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-vJCbjNa_MeONauWokJ4H9Q-1; Fri, 09 Apr 2021 16:35:15 -0400
X-MC-Unique: vJCbjNa_MeONauWokJ4H9Q-1
Received: by mail-wr1-f71.google.com with SMTP id y14so2765521wro.23
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 13:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=koMhPMwHT2lbb7QqoyG15e3gGwjcJZXavVfrNMzB8XI=;
        b=so2G6ns9yMch1t5TDwet2CyyKqHpW9K3q1kmyWjPJp9tOu0rr8Cb3GyDyWS3EHMCow
         9zNEvxUR93dGBmB871rB5eVn+tcvPi1tOftNudz8S5uyZxPPJJD2GHc03h+CmxFA23+d
         r+aIM2DgTChR30OT5THmkDPfUsOgf/Sb62k+OI7ey6jkkbAubaxvZspE4RkB9pEyD7JT
         WOLmpMbMyzK56sJdHlkeduBrMcnZXZfzxsHF6+U+dc0HszwL/GuTojQIN2f6ihhxdN/b
         r8zM/LwJNPUT8kmIdQoqOoMi4RoMG1oBW3m2tBYiOjmteAE1Lm//7EJQ4l++2N0+v5rN
         AeYg==
X-Gm-Message-State: AOAM532rnz4Mz4+hADtOrzVYdPjvxyYE+IcKcn+DIu1YEE6dVP2Edxq5
        Z8k5ZZINlfOP9eMMNNSDkrlxrf6buF5zJZFP+sBpedXyKHZ48gxSlZKPFwQnxjB7VIE7vXV+hCG
        fvB3zc5amLLK8MZYNruKCH528GqMwlmV9zA3/esNG
X-Received: by 2002:a1c:a985:: with SMTP id s127mr15404378wme.164.1618000514072;
        Fri, 09 Apr 2021 13:35:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsoEtyHgL80LtPo7DmcPOTI+OKxn7AZBWny2gilTwCjCQXS23npaN31Bqpni3+JGbrKuTm9+4Na/fg+TwFdPs=
X-Received: by 2002:a1c:a985:: with SMTP id s127mr15404372wme.164.1618000513940;
 Fri, 09 Apr 2021 13:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210326091151.311647-1-lee.jones@linaro.org> <20210406091126.GT2916463@dell>
 <468723920.4255981.1617709446972.JavaMail.zimbra@redhat.com> <20210406115434.GU2916463@dell>
In-Reply-To: <20210406115434.GU2916463@dell>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 9 Apr 2021 22:35:02 +0200
Message-ID: <CAHc6FU4bH91pWgFMytuvhgkr9YJs_VdggZdjEC6EwQJ-9Jj+3Q@mail.gmail.com>
Subject: Re: [PATCH 00/18] Rid W=1 warnings from GFS2
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On Tue, Apr 6, 2021 at 1:54 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > These have been on the list for a couple of weeks now.

thanks for your fixes, I've gone through them now. I've fixed up some
comments instead of "demoting" them to make the patch somewhat less
destructive, and I found a few more minor issues along the way. Those
changes are now all in the following commit:

  https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/commit/?id=c551f66c5dfef

Thanks,
Andreas

