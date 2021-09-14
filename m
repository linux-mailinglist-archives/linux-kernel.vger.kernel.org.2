Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB2740B3BD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbhINPwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 11:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbhINPwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:52:39 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8CAC0613D8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:50:57 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id c8so29857775lfi.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q8e6vYMWtLVlzKilUTUU45LYQ5AtwsMVMMhkibc3Y9M=;
        b=VPtON4P1X5GExo1d6Z5sCnVYLKvvLO0Re2N5FswMDFOHm94KFNCSQXm1LsojcswGFd
         7lS7F4RRELcrCB8z1u8gNMvwZmlI+QPC+BiV3B7cnvHDVAeCZQK6r2tCoJgfCs7Z2Nak
         sV0Tdz/F2v44DRwN6x9q0DQx82ZY2rBsgEjYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q8e6vYMWtLVlzKilUTUU45LYQ5AtwsMVMMhkibc3Y9M=;
        b=XNFXX1TGycsdO8dUuODOJxhhPjtVoT+CieVBF9epEnDTECCw7Lzd7OxL5LNrMhh6NI
         cyJ73DMsZyPirvKERn2p6TUbi5MGGbNOSopAL9VA+FKBMo69SsbxEjotsRz88h3yKve4
         /ul3GrvRvAwgv3BjeRCT8XGJDDFm2JzmTkp3mG+p5jYSBcrCLpypkNQ5weBMd2rbvfxL
         DZkSwF4JkTTNknsfWJ/g0PMnqbI2TuWydXSxRBA06M0wK++9AMUWsh76iKv/V4R6Y1Sl
         +p7X4u/iwQVIALsb9NaTx/9sYbFGRW7Oy5btD0CQIs4z9dORAsKTw0AxIqPY8DXwr0DY
         NTNQ==
X-Gm-Message-State: AOAM530hIjryuN50vD02NCLpWggGJ44ryNeZ4tVB2sSsUnUU13KkkXt7
        mNd2CxQLHbawEPBSk7DcRRtYCBLWUrF/0gMZA+U=
X-Google-Smtp-Source: ABdhPJya9GkuXQLbpOxyg5V8mbFnJb2+0YoefcoF8ERb7n7bxxwkkqg2ILLLZMlPIm86EpzwmFb2aw==
X-Received: by 2002:a19:6b18:: with SMTP id d24mr14185174lfa.84.1631634655122;
        Tue, 14 Sep 2021 08:50:55 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id t15sm1382042ljh.7.2021.09.14.08.50.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 08:50:54 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id l11so29858582lfe.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:50:54 -0700 (PDT)
X-Received: by 2002:a05:6512:3d04:: with SMTP id d4mr13360552lfv.474.1631634653874;
 Tue, 14 Sep 2021 08:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210914092603.18722-1-jslaby@suse.cz>
In-Reply-To: <20210914092603.18722-1-jslaby@suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Sep 2021 08:50:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjctpqFhN1MQKTaGLrb9BrynU8KpRcx1zW32TF_GJ9ChQ@mail.gmail.com>
Message-ID: <CAHk-=wjctpqFhN1MQKTaGLrb9BrynU8KpRcx1zW32TF_GJ9ChQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: remove dead e-mails
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Korsgaard <peter@korsgaard.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 2:26 AM Jiri Slaby <jslaby@suse.cz> wrote:
>
> jacmet@sunsite.dk and linux@prisktech.co.nz are dead:

Please say "these email addresses no longer work" - the "are dead"
makes it sound like the people have died. Which is not impossible, but
not what you verified.

> Remove them from MAINTAINERS.

If the only maintainer email is gone, then you can't reasonably leave these as

  S:     Maintained

and that should be updated too.

          Linus
