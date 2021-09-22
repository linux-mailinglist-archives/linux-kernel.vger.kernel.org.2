Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C3741509C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 21:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237239AbhIVTpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 15:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236444AbhIVTpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 15:45:13 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D257C061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 12:43:43 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 24so6261120oix.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 12:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=NdfOI4pLAZV9M1l1OIkcn0omvnM6YyDLp+ahHmCFaKQ=;
        b=EK13E1LMKQXDOSrWwiQlV6RXcKUCr0OiIk3fMqxovr8WN7ZCT0unxHinFV8/z7660P
         DVFspN6xL1MRaaxzhYNYmKfBqUcAxP5Isd4q4wnpU9uYrVEOtV/kkLq0LAfykgo32v97
         Ru+99ghTmTyauq73Zti1b50+bLQIdTwFY+i3sPpGz6IDLNeyVc+Yg8hj8HVTH0+oa3Pd
         RROiYotHydbYUO9ynee4RQjKaRAmYYK+HLBp2kyJFigWCfgUNRGRyfUd2hUksT38cLJ0
         BjJGHhjcSSF+hyie99uZXEJYeUFKZusLPOVtPDPaxGV0ZmHrxs8kZfEx+7Xcu9VW6Dro
         U2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=NdfOI4pLAZV9M1l1OIkcn0omvnM6YyDLp+ahHmCFaKQ=;
        b=DGIC5oNLfnG0BawLc23QZP4JdRwyDBGwD/1lbXCWswcrobg/q7YuORaRdRh6W4vujL
         yYvWXo/wRqARbxTSAzK3YcgLV8pnpeyLzPR3KcEcPZzdZRZ1pJEpTZJMoSPUkGFltAvu
         nKZhkpiUrP5uzTaRg9E2dQ8RAgDara5DmpseOg8FzkgcMl6NnvGzALydhSVbhbF69op/
         lw0agDwChX3GALESIkVMLkZRawIb2I90ME+DK7Yd3Pf8q8MTovJJUMg2C+Jo7R9dvU7i
         ik4G+5tA3QFLs2YbAgqP1rPKYM9vtnAIEYfF/i+T2GuO0RnrYM05QaRLhStmI/2Oq36Y
         3BsQ==
X-Gm-Message-State: AOAM53220rAi7yrova8JR43RYPfJMY4SlbjnerJFttEg/zYY3EKMeUtS
        CHA3jthC1oxpL/34MZiJnROL/kYiHi50Dhhk3K0=
X-Google-Smtp-Source: ABdhPJxzTj9QWxaH6Oqy08RShfm9ElKcmlS+rPpTiHk8TNJZosbokoXF9QzDp9XR3imgfc7L93WLh9YFfyJjvJgpcSY=
X-Received: by 2002:aca:6108:: with SMTP id v8mr7319148oib.139.1632339821999;
 Wed, 22 Sep 2021 12:43:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:d038:0:0:0:0 with HTTP; Wed, 22 Sep 2021 12:43:41
 -0700 (PDT)
Reply-To: ahilhim@yandex.com
From:   Kirinec Zlatko <marrylynnwanne1@gmail.com>
Date:   Wed, 22 Sep 2021 12:43:41 -0700
Message-ID: <CAFk1P4SOiuKRszF7joVy=Ba41PzsfNGpaAvvopcgM7SvsDPwGg@mail.gmail.com>
Subject: Von Kirinec Zlatko
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Bitte entschuldigen Sie, dass ich nicht Ihre Erlaubnis eingeholt habe,
bevor Sie diese Mail an Sie senden. Ich bin Aahil Madrigal, wie geht
es dir bitte, es gibt ein sehr wichtiges Thema, das ich sehr dringend
mit dir teilen m=C3=B6chte
Dankesch=C3=B6n.
