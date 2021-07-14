Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628233C91EE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 22:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbhGNUUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 16:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240869AbhGNUT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 16:19:29 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00A2C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 13:16:37 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id n14so5729407lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 13:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hlHm/WzQNtMTs2K3EbF6yImoGudX8KZZjDbB1a1VAPU=;
        b=TJTslZ/O+mclDLyRLs2Na1rFxTJK1Iewbo87ZSvuPcjDK0QE9NyY4zBD1Aa0Nv12/R
         JjTx9SO0K3ry/IAISAwGDN2Yfuz/mSyt9m/7wS+AlmRKGrcQONETWxym1Qs2Mxe+yFgt
         gJqp/XYelzQhWhBoX8LaXPClxypV3t0kVyBbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hlHm/WzQNtMTs2K3EbF6yImoGudX8KZZjDbB1a1VAPU=;
        b=K+QPB8+o0vwjsNgxp2LKV3EdwmAhSUc6H9295vzGTU2pQf/WI0mNLKMGDuhOkemsHF
         29/lC1aKUbhea+BWP020qxCFm++GRHTNXqcT6bh0NDutaUlzbvUW1e9Y9PC8gbBJb6NQ
         a+4bezJM57SWns8lSPLdwwzCxH6qkUPvD4A0w75hCC9UEiGfCORvwKbxmNks0BJ5XHjV
         XF9PdVUolBG4sUsTjlon2zutqXxAkhsu2cximOmHGGU3/TdnsEAix2iVSg/mn4WB9r10
         fG65urwzNvy6UCwFdvBlfsP0ceTY5PGrdvySEsw4AJhXvPx+tW/yGkxskWM9JivJ37H1
         AhMA==
X-Gm-Message-State: AOAM5331bmX7o2AtANWkGk/4wqpfltzx89yvQ7s0PziduVaVSYRQVp4b
        qDTYuHR4VSspt5dR/yJQZr+quf+YJtHmtHLp
X-Google-Smtp-Source: ABdhPJw3c6hshzphFthpfxOP9ghuR00ph1U9GVFlQuGpG4omCB/SCiWWCX7B4s4YP3UUx8Tgbro3wQ==
X-Received: by 2002:ac2:59db:: with SMTP id x27mr22460lfn.547.1626293795885;
        Wed, 14 Jul 2021 13:16:35 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id c17sm239772lfr.88.2021.07.14.13.16.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 13:16:35 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id y7so4875499ljm.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 13:16:35 -0700 (PDT)
X-Received: by 2002:a2e:9c58:: with SMTP id t24mr10417152ljj.411.1626293795142;
 Wed, 14 Jul 2021 13:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <YO8Rw23KxCDjzKeA@infradead.org> <CAHk-=wjuDBQdUvaO=XaptgmvE_qeg_EuZjsUZf2vVoXPUMgAvg@mail.gmail.com>
In-Reply-To: <CAHk-=wjuDBQdUvaO=XaptgmvE_qeg_EuZjsUZf2vVoXPUMgAvg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Jul 2021 13:16:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiaGVapioim31weBWs4bnzt7+wdyAx8GNFVgrFCLc-YXg@mail.gmail.com>
Message-ID: <CAHk-=wiaGVapioim31weBWs4bnzt7+wdyAx8GNFVgrFCLc-YXg@mail.gmail.com>
Subject: Re: [GIT PULL] configfs fix for Linux 5.14
To:     Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 1:05 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I hope/think that we always end up checking 'pos' in the VFS layer so
> that this isn't a bug in practice

Yeah, we seem to make sure everything is fine in rw_verify_area().

We do allow negative 'pos' things, but only for files marked with
FMODE_UNSIGNED_OFFSET, which is basically just for variations of
/dev/mem and /proc/<pid>/mem that need the whole 64-bit range.

So it _shouldn't_ be an issue here, but the points about just doing
the legible and safe version stands.

               Linus
