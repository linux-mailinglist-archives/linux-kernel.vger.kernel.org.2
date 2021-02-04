Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032BF30FA80
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238397AbhBDSAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 13:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237298AbhBDRrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:47:53 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6248C061788
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 09:47:12 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id m22so4460445ljj.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 09:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=woT4EcanspMxi+tLgo5zu289z1fYHa+hWmfqeG3qkHY=;
        b=cK9zBfgczjwFXqWMZAulT+ncGwSzHToziY5hlPItL62ja0GEmwfdsgA4WMA3FK0J36
         7/sObzy9kycaakEDX8PdGiybAoyPHEwI8m8hO5yPqSE6FbY8aWyUjtTxi4dR5FEq/e6a
         einqkEJ8I0AefCWsVHcUQKEtsborqCJOSRD6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=woT4EcanspMxi+tLgo5zu289z1fYHa+hWmfqeG3qkHY=;
        b=MIJmN07airPFCPP0D6NrQDtr815UAbu4v6V2D8BpqSKrUJfEGVyOeNZnI9uS/ymlgw
         iu3WtMGhVQ+xZG1AefgFevvZ3rcddVHxhTemoAKXMSJl9H+gUYJRsMb1ZcP4PO+ti3OP
         fAgi2KQIb03qLbEUYd5PhPoZGwapoZknCGjki72s4HFZ5l7wROIpLzfR4UZtCQR+IQqV
         4DwGWSM5T0KS0bXDViFNhD5fxZftHBWRmewfwy3onlculyA+ar12LlzL7ycrcnc/HRug
         wFCM36sTlvgnuKKvnHmv/8mATPfVglZJZICOSg3TyRLuz0jKKaevTU+rtMNMGce1pVGe
         pvMQ==
X-Gm-Message-State: AOAM531QXdRtc6QsNIUUd/jWhbE/2D3qALV4iO6QXnv5jvpe2I+Ol560
        WiF/CwOQNsg+5TCKkk9FvbcwvFshZpUEXg==
X-Google-Smtp-Source: ABdhPJyIPtNE7N49fIav4jWE2NkhVkcG8pDFuKMEVbs/P70C8TunU4ahwXlB0Dm3m4vs6m2vdjvCEw==
X-Received: by 2002:a2e:9d8e:: with SMTP id c14mr279173ljj.477.1612460830812;
        Thu, 04 Feb 2021 09:47:10 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id w16sm689825lfq.181.2021.02.04.09.47.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 09:47:09 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id y14so4433166ljn.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 09:47:08 -0800 (PST)
X-Received: by 2002:a2e:b1c8:: with SMTP id e8mr273260lja.251.1612460828596;
 Thu, 04 Feb 2021 09:47:08 -0800 (PST)
MIME-Version: 1.0
References: <CAP045Ao_Zb0HGg0=bvUeV6GjX=-3fz0ScsvM_jE7VsZcVk_-tg@mail.gmail.com>
 <C479ACCB-A1A5-4422-8120-999E8D54314B@amacapital.net> <CAP045AoMRNjvVd1PdHvdf-nn3LNpTDp66sp+SAmZgNU888iFQQ@mail.gmail.com>
 <CAP045ApWnr=UQrBrv3fHj-C6EweukMWEyrCgsiY6Bt_i1Vdj6A@mail.gmail.com>
 <CAHk-=wgqRgk0hjvpjHNixK7xSOS_F3fpt3bL9ZUJVhCL3oGgyw@mail.gmail.com>
 <CAHk-=wgOp10DO9jtMC=B=RoTLWe7MFTS5pH4JeZ78-tbqTY1vw@mail.gmail.com>
 <87h7mtc9pr.fsf_-_@collabora.com> <CAP045Ao=WK7whYP2mT5Nx4zxsJTO=8A4eXWdeB4MM=MOYDoGTQ@mail.gmail.com>
 <CAP045ApGeWQDJXbMUm230aRceJpSX46dfyjX7G7iypNe93Kc9Q@mail.gmail.com>
In-Reply-To: <CAP045ApGeWQDJXbMUm230aRceJpSX46dfyjX7G7iypNe93Kc9Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Feb 2021 09:46:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9UdLOGfZZ3whVkHV1BjwNPEKCGDMp2HVH1FbNyciAcg@mail.gmail.com>
Message-ID: <CAHk-=wj9UdLOGfZZ3whVkHV1BjwNPEKCGDMp2HVH1FbNyciAcg@mail.gmail.com>
Subject: Re: [PATCH] entry: Fix missed trap after single-step on system call return
To:     Kyle Huey <me@kylehuey.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 3:55 PM Kyle Huey <me@kylehuey.com> wrote:
>
> I have verified that a) the test case I sent earlier passes now and b)
> all rr tests pass now.

Thanks for keeping on top of this.

Thomas/Andy - the patch looks straightforward and obvious enough, and
I don't see any issues with it, so I assume I'll get it through the
normal channels and will archive this whole discussion.

No huge hurry, as long as it hits 5.11 final so that we don't end up
with a regression.

Thanks,
               Linus
