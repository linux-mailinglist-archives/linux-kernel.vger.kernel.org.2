Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5433B67BB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 19:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbhF1RhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 13:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbhF1RhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 13:37:12 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DA0C061760
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 10:34:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a15so26176944lfr.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 10:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HJDbCx+qi4xW555r0qRFKAgiEIbkRlABSN+3WwDGl3k=;
        b=Q6k+QvZ0eciuIKA/C8b0AX6T6lJtu9hoWk6TJBvASBRaCclEZBY9DzvAkNdv8DtHxA
         9nUE5g6ZRWzitkvPxQhbeN114x21BfWIDIM3OCz3wmqOhePIIq/qJHoERvi5s1IATprq
         hAb1fofRdlQMGhGRb4hfi96qWpWlCMpkOvsco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJDbCx+qi4xW555r0qRFKAgiEIbkRlABSN+3WwDGl3k=;
        b=SlCLLMwUtsrufmKapB7Nh2fAcycIb4153LSd3xLVvAekY4PJ8m8nLZS99DEmpaWCKu
         37SKsIWfTHm4LiWnsYkv14GKGyoHGWngAN2FiwNVgR5iSm+9cu+thfCyqZgs3/9/j/kn
         IgZ5xCNvJ841rLZ17jvvN5fSazYY2hzyvufkcmaslkHUKcuwMFw1qmMSZeNukTOeEI8c
         VR2lnM/QWs4WVrVq9yAlKbqPnwHkcv2qQLMaFIfBFLuCzNQOLskO4ChObUKInHL1P58j
         7Fwob9TO71fgrsqmPGef7m9aMye+Ym1jYGjMCg+LjF0nkYOOlZy++9SVZ3cGBsqjbKAe
         9X4g==
X-Gm-Message-State: AOAM532H5yyM9sBWOvELGTnblFA4vSVsEeUK6tEW8Vz8OiEyIQx1P4xt
        FTDjqCIcYE3LmsdQ/rcw8nB94+J04WZkkJuq
X-Google-Smtp-Source: ABdhPJwuxdNzsQKuL6Y2nHgRGaCRT3IUom+DYt//7FGeRycOgs1/Zmz2V9K9CA0UXs9whmk9oaAslw==
X-Received: by 2002:ac2:420d:: with SMTP id y13mr19504221lfh.304.1624901683163;
        Mon, 28 Jun 2021 10:34:43 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id w17sm1369304lft.285.2021.06.28.10.34.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 10:34:42 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id d16so33958442lfn.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 10:34:42 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr19235333lfs.377.1624901682120;
 Mon, 28 Jun 2021 10:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210623135600.n343aglmvu272fsg@kernel.org>
In-Reply-To: <20210623135600.n343aglmvu272fsg@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Jun 2021 10:34:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=whhEf=xJz=rdcLWNnRU1uR6Ft-mn6xNrOg3OcQ=5cX6BQ@mail.gmail.com>
Message-ID: <CAHk-=whhEf=xJz=rdcLWNnRU1uR6Ft-mn6xNrOg3OcQ=5cX6BQ@mail.gmail.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER changes for v5.14
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Morris James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 6:56 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> Contains bug fixes for TPM, and support for signing modules using elliptic
> curve keys, which I promised to pick up to my tree.

I pulled this, but then I looked at the key type changes, and that
made me so scared that I unpulled it again.

In particular, that code will do

    shell rm -f $(CONFIG_MODULE_SIG_KEY)

from the Makefile if some config options have changed.

That just seems too broken for words. Maybe I misunderstand this, but
this really seems like an easy mistake might cause the kernel build to
actively start removing some random user key files that the user
pointed at previously.

                  Linus
