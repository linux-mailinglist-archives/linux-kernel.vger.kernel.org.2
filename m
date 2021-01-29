Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F9430844A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 04:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhA2DjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 22:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbhA2DjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 22:39:21 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898B5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 19:38:41 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id m22so1521179ljj.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 19:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PuwJteoXwJBHsZo/AeV/9OQpx+tnLiPJLnbPShZBUBc=;
        b=NG1kV18DBBmRpbuQdSU1iwTNhIM+0aoPpvwgB24STtrCB9udnCanFVWj42c2rrto06
         gTg2jdx72Ip8d4XpMkqdw/eiXvAnxeFLydyB7IELtDRRjl6nI92tDzn+x33PpZ+QG8ek
         78HO7td9x1VnR+7mugl5BtiGYCHSrS9OocjsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PuwJteoXwJBHsZo/AeV/9OQpx+tnLiPJLnbPShZBUBc=;
        b=SGSBVtMOI9SeUcsz/+d/FviXozfe3c5mbYLh1+44DxtxgSPs6gBKwqW4psmNWR9mpE
         DbMaTK5QjviFt/l4BYtlyknFpMEleKapEDRrwY7DCECbNIX/Q4Pqkpy3gQy6Sa1mCpuD
         yny6rNdmt5EHIttWO1ec7JVDMeBNSz4Lhwh5Dpu889Tj1VMEoM7jd/z957+/nAz5v2NE
         PG+0uTWSHV0fbhh2CG5mJV650ilzzeZgGGDJIxhcsbQEk1JRzlv4wY3zjM+gAKdpHiXf
         0h50dvZ5OF32b8VkIOtHHVo8mD7VRxLqgqXXUujm4K4zjOyB1/SGLYe3DgF4Bw5TCsS8
         eUKQ==
X-Gm-Message-State: AOAM530KguxOKbejh55jRMzXVud8JMOQkAzWKagk6oqqVLIZuDobtDCm
        Hi1O1C1P9kwkSYWhDN3CsnJBcAXi5rNXSg==
X-Google-Smtp-Source: ABdhPJxnDufbDoSdmbLDZ3jCf0zMkhj/kk/HAjvhLNDUDf+mO2I+aiw4wG4XiaZtPnGvT+3/a9K93g==
X-Received: by 2002:a2e:7a18:: with SMTP id v24mr1285956ljc.55.1611891519231;
        Thu, 28 Jan 2021 19:38:39 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id o11sm1855141lfu.157.2021.01.28.19.38.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 19:38:38 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id m22so10557434lfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 19:38:37 -0800 (PST)
X-Received: by 2002:a05:6512:516:: with SMTP id o22mr689075lfb.487.1611891517411;
 Thu, 28 Jan 2021 19:38:37 -0800 (PST)
MIME-Version: 1.0
References: <YBNcv8jLEDE8C/IW@kernel.org>
In-Reply-To: <YBNcv8jLEDE8C/IW@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Jan 2021 19:38:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjk7zEOFEjGWZmGF8_dcitBQ_dPUMSkr-g7B7cYcXGvSQ@mail.gmail.com>
Message-ID: <CAHk-=wjk7zEOFEjGWZmGF8_dcitBQ_dPUMSkr-g7B7cYcXGvSQ@mail.gmail.com>
Subject: Re: [GIT PULL] tpmdd updates for v5.12-rc1
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Morris James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 4:54 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> This contains bug fixes for tpm_tis driver, which had a racy wait for
> hardware state change to be ready to send a command to the TPM chip. The
> bug has existed already since 2006, but has only made itself known in
> recent past.

Hmm. Is this for the next merge window? The subject line implies that,
as does the addition of the cr50 driver.

But the commentary about fixes implies that at least part of it should
be in 5.11?

            Linus
