Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DE93A048E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238099AbhFHTho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238529AbhFHTfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:35:38 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0557C061280
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 12:23:09 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id x14so14177981ljp.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 12:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XNx3px6nlkS3axSHpAq2ksethvIjNf8tQ51A6uKqGH8=;
        b=MmsGIRmp5+AW+Pu7wvdm2P41041Za82ArNc164IeRST/CukpxNHxNqGmarWeGn43ex
         /h1Ic6Xf1m5ksR6gTLOX6PDQCzaDeruXEXULiN4mQPCP3T3dfgewer95vtV4IQ7h9DKL
         re80+DFBHOpTCF8Iqmv2juKvvH8o6N24g82I8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XNx3px6nlkS3axSHpAq2ksethvIjNf8tQ51A6uKqGH8=;
        b=YpmXmbmoSl2AL07bXE2L1Z4Lh26dg4V8ernDmkyf2gV39DCcSAE5JZi6Ln3etOx+gu
         iUaG+i6NXvuSb6Q4yvm4OeX3G+zXDh20gSpCT4vggOeJTjpZMyddhAm90e/UX45plfd8
         njwsL/wjRMwrPovA8qzZtwPhhX+efmX7xzvHuVj3fQosESFQr87TR1sB2a1IkI3tdB7h
         PVkgt4d7n0/O6Y7pw80r+OCdmU4nJN49SEPArQnynUfQzs3NLUGcjO+dByuh2qRjWwqu
         1vJxo1iE3fWY4XZVz1fMw3m0QyDlL4MlAV1VSHj2UJUsEh4dgZ92QwIMVRuR+kvxGvBK
         VSlg==
X-Gm-Message-State: AOAM532DhmpgfjZJb2j+JUjx6n1/0PjSH/xMfBmEwl7mWGkrX6c90wac
        N9O4tuBFsnKic9a6MkrQdDhH+L8xDmMCXwinqtI=
X-Google-Smtp-Source: ABdhPJxxme2YOEQ/burhOS0RKk6y9HNJQ9aW6lHjvXytqc1LBfAqAUtzcstmPCS7j/rnZ8Uc+L2SBg==
X-Received: by 2002:a2e:155e:: with SMTP id 30mr3428696ljv.316.1623180187898;
        Tue, 08 Jun 2021 12:23:07 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id d2sm62360lfg.229.2021.06.08.12.23.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 12:23:07 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id i10so33879181lfj.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 12:23:07 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr15915332lfs.377.1623180186850;
 Tue, 08 Jun 2021 12:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <YLx/iA8xeRzwhXJn@zn.tnic> <CAHk-=wjXKsJVk+LPiOSiBACchPJLne7O+U+jmvw8CaLBYn-3=Q@mail.gmail.com>
 <YL029aQZb09G3ShY@linux.ibm.com> <CAHk-=wg7+-Q-jvrwQmyZtQ3pirAUcAQmvUpiLu=0nJv8NObntg@mail.gmail.com>
 <YL1HLdmh55uGAIs/@zn.tnic> <YL1UucKH0GfXddZo@sashalap> <eaf8e14-12d6-6e3a-f5e5-8b504647eb48@namei.org>
 <MWHPR21MB159330952629D36EEDE706B3D7379@MWHPR21MB1593.namprd21.prod.outlook.com>
 <YL+368+oKRORwUzx@zn.tnic>
In-Reply-To: <YL+368+oKRORwUzx@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Jun 2021 12:22:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1nz4=72vk3+q5TuPwBF2HMY4SnBOZr6WSLp=s4KExSA@mail.gmail.com>
Message-ID: <CAHk-=wh1nz4=72vk3+q5TuPwBF2HMY4SnBOZr6WSLp=s4KExSA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/urgent for v5.13-rc5
To:     Borislav Petkov <bp@alien8.de>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        James Morris <James.Morris@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 11:33 AM Borislav Petkov <bp@alien8.de> wrote:
>
> Linus, maybe we should at least give it a try and see whether someone
> complains and revert, potentially...?

I already merged the change that did that.

It might be worth adding a comment about the verified Windows behavior
here, but I think otherwise we're all done.

Unless somebody complains, as you say.

            Linus
