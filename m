Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A70944AEE5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 14:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbhKINlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 08:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhKINlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 08:41:44 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700E8C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 05:38:58 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id m5so18044842ljp.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 05:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xf2lmT83dSNiE9eWoGnGn4bhukTvP6d6+kM7Kc5CSqo=;
        b=amJfQ8sHmRSWmPUArZTLQgn5LsrKQ3Iz9PAqbKRjFJpXbf+kZpMG6JSvCpmru6i7Rd
         supmpPHjE8ZTeFLsO8zkQmFLqRA6qpil0n5vTTnEVu+BWFDVuFo4HDC2AtMhX9/XpoJg
         QEzzNuL1CD0AEWInEWjMkWz6sbLRj/qqj3NSkdwEmfKi+uwiJLPz1CyR8avIX884fQYD
         Uld/5FlkCls2GOKfZ0YXgvI5peWZTTrtJLVhUWwPy9yMp2aq3kjLKVlFwQQ92jOMlR98
         VqjDIvuTfaUad4WKoH6o8hhEK/upQXqobvJRL8cbE/pF9dT0TL0J6tMAb4QxeJkJO9fr
         Fk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xf2lmT83dSNiE9eWoGnGn4bhukTvP6d6+kM7Kc5CSqo=;
        b=XQjCJGl6fxIehyElA1T/KwloUyO5lRcZvyUG9epTyN7jCNCLkWlRqjyHo/ibT+8I2b
         XmM/uZPBrKZ/jchuEK7W07g+9iiMMsJnjys+w9GXzl4kQ/OVsglQ3/P9mYZS1RrrAtbG
         2/70j02bfgj6RkkZL2qkExNq+RXTx4LmlxDal+MPSLBbV1hfkFPtoSu/neRmclq54lAZ
         kCHZCrsIsB8j7aLJ765ui13MAw0rlOFFVN7zZ9Q9Qy/lQYMImM1Uk+KYCSx9WxVkglyf
         uO+zt3DV6ZTf2HL3yXBRiC123wQTHyFe//DeNjSTCCBU9YaAC+L30K6pf6ExYRTm85a8
         7C+Q==
X-Gm-Message-State: AOAM53366g73H01N+azNR8KjeNmVksZ43CrIv9cIl0Nlbv2MF7J8dW3O
        pwVPOfM8BJUTDeHsAqfjZTyDA9fxnYnXHFD+MtI=
X-Google-Smtp-Source: ABdhPJwp/3yR0aKJzyyxnYPME8tdzmJXZFeiF4l88QOLnGXZJ0FpMU2lEfm3EzN+wCWR9J78xt3O+jujs2yYlAiq3d0=
X-Received: by 2002:a2e:890d:: with SMTP id d13mr7561859lji.396.1636465136748;
 Tue, 09 Nov 2021 05:38:56 -0800 (PST)
MIME-Version: 1.0
References: <1636439024-15877-1-git-send-email-u0084500@gmail.com>
 <1636439024-15877-2-git-send-email-u0084500@gmail.com> <YYp2+gqjn6+M/hZ7@sirena.org.uk>
In-Reply-To: <YYp2+gqjn6+M/hZ7@sirena.org.uk>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 9 Nov 2021 21:38:45 +0800
Message-ID: <CADiBU38kyx6hA-xPp-EH34YmvDfXRtOBr3Zuzj2Yc7Sx+HJWcw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: rt9120: Update internal setting and fix auto
 sync problem
To:     Mark Brown <broonie@kernel.org>
Cc:     perex@perex.cz, tiwai@suse.com, oder_chiou@realtek.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, lkml <linux-kernel@vger.kernel.org>,
        cy_huang <cy_huang@richtek.com>,
        allen lin <allen_lin@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> =E6=96=BC 2021=E5=B9=B411=E6=9C=889=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=889:26=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Nov 09, 2021 at 02:23:43PM +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > - Update internal setting to fix issue.
> > - Disable auto sync if fs is divided by 48.
>
> Please submit one patch per change, each with a clear changelog, as
> covered in SubmittingPatches.  This makes it much easier to review
> things since it's easier to tell if the patch does what it was intended
> to do.  When splitting patches up git gui can be helpful, you can stage
> and unstage individual lines by right clicking on them.

OK, I'll split it with two changes to make it more clear.
