Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08EA367426
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 22:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244966AbhDUU2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 16:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235950AbhDUU2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 16:28:52 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB3FC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 13:28:17 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id d21so30740089edv.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 13:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BTxeOvItUf/hQPVBleOY5zaWBy/5NEeiG69sqLNw6SY=;
        b=QUhudc+dY9APEI3AjukEm29Vkwfr1+uMFpQkygQuzbzuEExw3Mzqx3Tl2om/LIMLai
         e/HS28L4pkXhkSqAEiiOTRxppDsXU8BnothjmlPFUs87t3Ky6o3b8ihwLa69YN+CKLH1
         llQTXExEG+4PXMyea3MC68ZmGDygYPpueTZDgDMDnvN1ABrcWZsUhW73Rb4MEaJhVF9U
         vO3U6ZSyl7Bngc/vQmc8TFpa7gpM3SR/UFfnJNaOpqTbDDFCS1hqgXnTIa6nxAr1KM8E
         8BTJOhpyR3b7ASdcRWL71ERupi93wSpq/zuQUi91kRuiTWH7AYgAo1LGeeETuIqlPDX4
         IQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BTxeOvItUf/hQPVBleOY5zaWBy/5NEeiG69sqLNw6SY=;
        b=gHrgD6DET5HW8tFuzygbkBnD+jl2ACLYDy1FXh5rKQ8bIRd1srnRoMvwzy6aCE5rsB
         NxfjH7iUBC6Bz+GpMskXgC+4TXIdo7tppqdY2CxNK8ImzE/ojwmMRb1UzleCDe8Uwk05
         egRdpUHSti/IhaMih7z45+2PERbA53zvmH5g4er/RRiRV8QkXL+8XGra3wJL+3LORQ2z
         LKxFQwxM4NCt4Pp3W+FzdPNXTvcje2xrMTUL2W54wSB05zU90IRqP0rGbRL17ECBKE9d
         tJ6LqSPqnsLoXxUyWZSiSW4hpPGM5f5TCuXH2ClcxKDBayWzxEeFM4/cJ3TUk+kbuCKu
         9LSw==
X-Gm-Message-State: AOAM530XTb/7+HeKmjK5TZ46EU8AHSNb77XF4Ltz+jMOtpx4bjKoyVvB
        gPIZhgKHm6W6yLwBI7ejubeV6aqrJREAsSOJzVM0zw==
X-Google-Smtp-Source: ABdhPJzsQJ7ViNL2kufuHFGKH/tMM4GjkaL36Yv5Pr1Wfer7c9HJJdpBWIPu4Z65zWBVeRiPSBN56etGEDkVg7HhE24=
X-Received: by 2002:aa7:cb90:: with SMTP id r16mr41647616edt.139.1619036896139;
 Wed, 21 Apr 2021 13:28:16 -0700 (PDT)
MIME-Version: 1.0
From:   Weikeng Chen <w.k@berkeley.edu>
Date:   Wed, 21 Apr 2021 13:27:40 -0700
Message-ID: <CAHr+ZK8xp5QU8wQHzuNkJdsP20fC=nW4B33gwMUwHY82f_u5WA@mail.gmail.com>
Subject: Re: [PATCH] SUNRPC: Add a check for gss_release_msg
To:     tytso@mit.edu
Cc:     anna.schumaker@netapp.com, bfields@fieldses.org,
        chuck.lever@oracle.com, davem@davemloft.net, dwysocha@redhat.com,
        gregkh@linuxfoundation.org, kuba@kernel.org, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, pakki001@umn.edu,
        trond.myklebust@hammerspace.com, w.k@berkeley.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[This is the email that Theodore Ts'o replied to, but it fails to
reach the email server due to not using plain mode. Here I resent.]

(Note: this thread has become a hot Internet discussion on China's Twitter.)

I am a graduate student working in applied crypto, and CoI: I know one
of the authors of the S&P paper.
Some thoughts.

[1] I think the UMN IRB makes an incorrect assertion that the research
is not human research,
and that starts the entire problem and probably continues to be.

It clearly affects humans. I think UMN IRB lacks experience regarding
human experiments in CS research,
and should be informed that their decisions that this is not human
research are fundamentally wrong---
it misled the reviewers as well as misled the researchers.

---

[2] Banning UMN seems to be a temporary solution. I don't disagree.
But it still might not prevent such proof-of-concept efforts: one
could use a non-campus address.

It might be helpful to inform the PC chairs of major security
conferences, S&P, USENIX Security, CCS, and NDSS,
regarding the need to discourage software security papers from making
proofs-of-concept in the real world in wild
that may be hurtful, as well as concerns on the sufficiency of IRB
review---some IRB may lack experience for CS research.

Some conferences have been being more careful about this recently. For
example, NDSS accepts a paper on
a browser bug but attaches a statement saying that the PC has ethical concerns.
See: "Tales of Favicons and Caches: Persistent Tracking in Modern
Browsers", NDSS '21

---

[3] Let us not forget that the author is using their real campus
address and is open to such pressure.
Thus, I think the authors, as students and researchers, have no bad faith;
but they are misled that this experimental procedure is acceptable,
which is not.

Sorry for jumping in...

Weikeng
