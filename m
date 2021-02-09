Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A056E315C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbhBJB02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbhBIXLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 18:11:37 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225ACC0617A7
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 15:10:12 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id v5so28780145lft.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 15:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ZNP9oz5bawbiWyvKNCerRloH9liuWCWlO54Vz0FurTM=;
        b=ceWOjbfI9nubwvgj43exuTO6jYrlseP66oSflEwA//cGATTN03o6Ny8pphRSs/nKrO
         pFw1CxgLEyLrnEYNrpKyM2qVFaDA2yZqYD4+uC8F4c0gu5hPu2JHDNa9DFZ+0C3TTKku
         WxxSzfpmeqgdrE0t24C0HKxC1SAXkx2VkuhpDM5tW4DHKLUfjCDe63Y0pUQ54WnNC20S
         34c73NxZQTiajGnn/rnINPVCsMwVOVk/Q+IbT7dzyhLtOKpZQcHWd7cTFeRgi63j+oRX
         6GmtJISu6vf1eKpDq6jt3HgIQvlK02HqZWcB5S7T05BBnOmFW7Mvn/w1dYBHplqJ0h/w
         BuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ZNP9oz5bawbiWyvKNCerRloH9liuWCWlO54Vz0FurTM=;
        b=ab59H3CovKg0YtJ5LgzQGOBgzoXge2M158qXfLuuBBMDNOLnWelWXh1YoD4nssxtB3
         pE6tJV7XzRO2dF642wf2nW6szoUY1FB0pZz8PDgEnwVsltWSL5ml3tsbeGqcqtYH54cy
         nHgEfTAkl2OaK0hRRMD55FUL2R5sr6voengA5xvG0kwY9MmQoLDw+Ta1Fi2nrqrzZLr/
         s5JyQi/kDEJk3P6/JzroqS0/clLnd6ouWuy57a4CEGRxeew05gXb38fTp5zl5W4hCMcn
         t6TIBBi21+VLjW+FdnMkZdnW7yamr+VjmkOHF0gcvtXn3QgOxFWhHhxLje5Fq6PBnKbi
         PXPA==
X-Gm-Message-State: AOAM533qhe402wcdR9I6fALawF9E+BSu63Ms0qnWmlRyCk5AR8cgXePF
        QpTbV5dx0NXl2wiZANPiu/iaiBG1/WeAfsJFLfM=
X-Google-Smtp-Source: ABdhPJx07psJrkZQadF+VANMoB9HPoHDXCthxMDOrwfOPgEEke3az44/Fxf3cTphUcT2ypemeAk24vXgz6nnpLbwZkE=
X-Received: by 2002:a05:6512:516:: with SMTP id o22mr99255lfb.487.1612912210627;
 Tue, 09 Feb 2021 15:10:10 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210209103356epcas1p35b1c52bf4f7597feadec360f6b7c3ae9@epcas1p3.samsung.com>
 <199cf833-c46e-de3f-0996-492adc18eda3@samsung.com> <YCJnSfvAMACmVfG5@kroah.com>
In-Reply-To: <YCJnSfvAMACmVfG5@kroah.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Wed, 10 Feb 2021 08:09:34 +0900
Message-ID: <CAGTfZH2OPu0nuv0DPMoSb=O=nhRRA6MToUAD0iu=UE3a3p7g3A@mail.gmail.com>
Subject: Re: [GIT PULL] extcon next for v5.12
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

On Tue, Feb 9, 2021 at 7:43 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Feb 09, 2021 at 07:49:59PM +0900, Chanwoo Choi wrote:
> > Dear Greg,
> >
> > This is extcon-next pull request for v5.12. I add detailed description of
> > this pull request on below. Please pull extcon with following updates.
> >
> > Best Regards,
> > Chanwoo Choi
>
> I see the following error in this repo when trying to pull it:
>
> Commit d8cc19be483a ("extcon: sm5502: Detect OTG when USB_ID is connected to ground")
>         committer Signed-off-by missing
>         author email:    nikitos.tr@gmail.com
>         committer email: cw00.choi@samsung.com
>         Signed-off-by: Nikita Travkin <nikitos.tr@gmail.com>
>
> Please fix up.

It's my fault. I'm sorry. I'll resend the pull request.

Best Regards,
Chanwoo Choi
