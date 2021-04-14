Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E480D35FAD2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352862AbhDNSbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352047AbhDNSbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:31:02 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE20C061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:30:41 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id i22so13252883ila.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GSVZulurztEIDpsvLgnH0S/lLQGg76QIVX9BgE5+U8w=;
        b=EFpytYWN2VnOFuIdwbqUT/TFmTrUeqlTlgURImphJPv1xOxmT2TJNpJMwo/ofmTFms
         CtAszqE3HIbdYeb434Hs9FGgu34u+WJUZYvvllo7KJF0iPueiFSLDbOBhWryG/DjfvL5
         aIoD32p960Ir1xAn4KRqj8s3RahPz/Ro1ba4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GSVZulurztEIDpsvLgnH0S/lLQGg76QIVX9BgE5+U8w=;
        b=FbDSpl40ydGoZgKKxlemisSZszJG7ykd6z+g5iNIX4PW9J0QkILbIWThfOAcVPoUIT
         dbtCfOxOiJMIi62eb/5mgaDhwounx056ewFSs4ceFLRy4jfvMH4IC6CnVpiz/btP3CKb
         qlivG5NqLSBvsDVuPPd93YjJAFdcEH+8vNE2W7ezEU0CrMD+wYlAhl+boHAjd5FC4YB7
         ++y51lcWgaz/sgf5tSHiCB1rkSpGXxg1xCwOV2DbAVZLyR1BspuGoQusMrlTl2CjrZFm
         2mbffrqRsuhpHaNaEc88SYZjVvLSe4E3cihjcGXpEWTBCg859VnC64UdQTXufJxv7T6J
         RQVA==
X-Gm-Message-State: AOAM533qBYirEZzDgL1N4KSW1A8xjBkqM/LEkSgSmGbxNrgxA/X0kTD0
        gLjN7546fgdhrAtTvIy8JUTHqZAxmiEX4cGOFAtIew==
X-Google-Smtp-Source: ABdhPJwidopytC6IhNqasB6wdNQ8zczQF884T9qeHg1BY4dzYWodXhx3yvtKeoyDQA1uYDjlv0e3F0UVE24Vt1SiWHg=
X-Received: by 2002:a92:ce90:: with SMTP id r16mr203960ilo.220.1618425040629;
 Wed, 14 Apr 2021 11:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210412153754.235500-1-revest@chromium.org> <20210412153754.235500-4-revest@chromium.org>
 <CAEf4BzZCR2JMXwNvJikfWYnZa-CyCQTQsW+Xs_5w9zOT3kbVSA@mail.gmail.com> <CAMuHMdUQOi8h31D_Qtnv_E1vsEu6RO8sHy-DArQ0jQt5v_JoVA@mail.gmail.com>
In-Reply-To: <CAMuHMdUQOi8h31D_Qtnv_E1vsEu6RO8sHy-DArQ0jQt5v_JoVA@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 14 Apr 2021 20:30:29 +0200
Message-ID: <CABRcYmK597zCNs_ay6BUjxCuxGJazKn4iujYtOUxcZC0J=xVPg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Add a bpf_snprintf helper
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Geert! :)

On Wed, Apr 14, 2021 at 8:02 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Apr 14, 2021 at 9:41 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Mon, Apr 12, 2021 at 8:38 AM Florent Revest <revest@chromium.org> wrote:
> > > +       fmt = (char *)fmt_addr + fmt_map_off;
> > > +
> >
> > bot complained about lack of (long) cast before fmt_addr, please address
>
> (uintptr_t), I assume?

(uintptr_t) seems more correct to me as well. However, I just had a
look at the rest of verifier.c and (long) casts are already used
pretty much everywhere whereas uintptr_t isn't used yet.
I'll send a v4 with a long cast for the sake of consistency with the
rest of the verifier.
