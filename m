Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2FA3E4E7A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 23:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbhHIV1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 17:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbhHIV1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 17:27:34 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0A9C061799
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 14:27:13 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id n7so749042ljq.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 14:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jggCUuylUTp8Qazkw4vyHQk7Sx27WnHOaFstAIevKbw=;
        b=ahusbhrQOwPDpp9d7umFODX39riwpah9xsJFNwdPYjW/4+UDVTFy/QrRYOBOclHXAu
         UHM/hA3SaIXz8Vcb8Cfiy84Yqm/VgSkEy88uT4fFKLuWgcfwrFLk5f0x7mzSBcZgc1uu
         Xb+wv2gYe2MI+DuWdQnYwvY8TTDG7CPECRQHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jggCUuylUTp8Qazkw4vyHQk7Sx27WnHOaFstAIevKbw=;
        b=TUG3EG3u6pnDE7DY1k/DR73DMHTQRLw289yVB+ujfI0WWunnYC6Xn6d6GBYCEhmlRR
         4cO/UYoTtB6Eb5avubNODQ1p9e5lEW1nOVJx6b94DS5LKzioiUI2y0qrH8ox94UAlzBf
         YNF3pzi/18hmuaIhWGOJmHyzm2mYF65m51ibDi3hrqYWNBljXCrb1784icDGe+fgfYJE
         RjBtKWlu4dTasTqt98QovvTXwKZlGSgzgUrzSxPUMr4JUIBsarVlJdt9q94AlIfSr6qV
         A1zbrfppcKPfpPCJxeAQ4j6fDMZsjH0b6UcABWXF97zOLL2bpeXFjSO8N/Q6mGtnowG1
         FRpw==
X-Gm-Message-State: AOAM530xMQJglHPUkg6i4k6v3ZN6NXGVmABbACO34j1+Ksk0gTFE9BmX
        ppZ9pcYoJBf81VUexV5dhjuq4FEAp/jdhYrE
X-Google-Smtp-Source: ABdhPJywM5OG8ZJLYcpyNaidM4qXn1S7D63sd5IhV79gKTD2XleRGiWqkhmUH517ecvpRVGyo5z0+w==
X-Received: by 2002:a2e:82cf:: with SMTP id n15mr17024750ljh.294.1628544432157;
        Mon, 09 Aug 2021 14:27:12 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id u15sm1848521lfk.12.2021.08.09.14.27.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 14:27:12 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id n6so12446480ljp.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 14:27:11 -0700 (PDT)
X-Received: by 2002:a2e:80cb:: with SMTP id r11mr3942175ljg.48.1628544431464;
 Mon, 09 Aug 2021 14:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <YRFfGk5lHL0W27oU@miu.piliscsaba.redhat.com> <CAHk-=wigKQqEqt9ev_1k5b_DwFGp7JmCdCR1xFSJjOyisEJ61A@mail.gmail.com>
In-Reply-To: <CAHk-=wigKQqEqt9ev_1k5b_DwFGp7JmCdCR1xFSJjOyisEJ61A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Aug 2021 14:26:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhm9CV+sLiA9wWUJS2mQ1ZUcbr1B_jm7Wv8fJdGJbVYA@mail.gmail.com>
Message-ID: <CAHk-=wjhm9CV+sLiA9wWUJS2mQ1ZUcbr1B_jm7Wv8fJdGJbVYA@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs fixes for 5.14-rc6
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 2:25 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I've pulled this,

Actually, I take that back.

None of those things have been in linux-next either, and considering
my worries about it, I want to see more actual testing of this.

                Linus
