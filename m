Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0683396D6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbhCLSoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbhCLSoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:44:13 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998C3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 10:44:13 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id o10so142008plg.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 10:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=QDSP7c2qvYAnd+CExDCeh1/VNiYoT8vx8tm/R4nmJf0=;
        b=XJha8F9KbbN/9ltvDlnROPjENtAzhqA25ox6ACIl7IumOPB69edxYScvj+aKFr/YgS
         65l3Ki1e8HqVvIiYbg5iWdBL+pUY0jmhQOE2eff0y8K/QQmcO7rlgj82CFQpxDHXYBhf
         DEof/pZ+sGDcm5ePwaXDxfU6phwCLXit7TSGQp03tMqG581oBdIw7ABq25CzZkSgZpEz
         69PhOw0gWmtXTVorf/UGBT8fcW9fZquEbJXOd9ILq5Y3pTn7ITD2cF9GqzQjRWLKg3cF
         RvLJv9VY97rP6me4hMu1AAEqaU6b4jA2NTLRpyoGGFkQUJpIc8eAOzzKxmy+f2ESeVIK
         b9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=QDSP7c2qvYAnd+CExDCeh1/VNiYoT8vx8tm/R4nmJf0=;
        b=gt3rjqmG5yzLFb+sgw23rab24TEzP0gB1ReL3dBBzqsg6UWfNPz7tTuosARvv59Q1o
         EWxdDSp73b7cQUCAm5C8x0gTwDMkF2fXwryXpFnIfmWaCSMe3bN8moHeCiH4YYUi2LoR
         DD/01SNl+Dvmi+kTgUaOdidWkmNGJACB3DgPKR3GdhKTd7dkXbgPDdzOjGJDxlkbtltG
         FINlM2+H5VDGHgdqlWl9XtUl90AFjxfl4Rpm8q6ot72nfUo8h/Rdu6tqzNwV1cAftqVx
         YFjHmw6T7ROlz3F30WQTQ1d97L+SFeXymrRYi1hzP/K5SxCtR1XutIyXMfmMM+Gi6L7I
         0PoQ==
X-Gm-Message-State: AOAM532Oh3TOlFE0L00haj2i28ohdp9NKnjic4TdimHv2aLdTip8DdCC
        odKFNT4g8W/IaXwwTlZe3kol3GziMGXu3fiGhRq0eVOPcbWepQ==
X-Google-Smtp-Source: ABdhPJyGpFUjVQyGjZJ6pFaquR3mfZFsKF/xwOWpGBfCPfNxE83U3y4lGk2nUVVANOwk1r11vFT4p++6BCmQcr+qe8Y=
X-Received: by 2002:a17:902:ee02:b029:e6:5397:d79c with SMTP id
 z2-20020a170902ee02b02900e65397d79cmr405564plb.21.1615574653056; Fri, 12 Mar
 2021 10:44:13 -0800 (PST)
MIME-Version: 1.0
References: <CAHp75Vcraa-E_6CV33f7CypVmFSM-57krpbBPgbqKSQ9D0A9Yw@mail.gmail.com>
In-Reply-To: <CAHp75Vcraa-E_6CV33f7CypVmFSM-57krpbBPgbqKSQ9D0A9Yw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 12 Mar 2021 20:43:57 +0200
Message-ID: <CAHp75Vfn0Ub5Z0PpDiCB0sMPpNCwziqK-TL2RUwRCPc8dczRLw@mail.gmail.com>
Subject: Fwd: localized LD version
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Masahiro!

Are you aware about this [1] bug report?

I have stumbled recently on the same issue on my home laptop. What is
the suggested workaround or fix?

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=212105

-- 
With Best Regards,
Andy Shevchenko
