Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF18B30BC11
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 11:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhBBKcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 05:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhBBKcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 05:32:18 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D74C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 02:31:38 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id s24so9144885iob.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 02:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tPdWi+1T3ztUzlnN8yjB/oPmxXYXNfRoTAThbMXnPgQ=;
        b=RRZ5Vd938ncCdZoiFKgt+V4lgoyNzF751ORfRaNDfRZaM4ZZcz1kC4sSzGtuMITRzr
         OnHE+UZ7ErpU+qEWDMjTz/IM7QCCYRJvGM9GUUaBs8VqiF7Zw74TZl9mnhyazmILjeS5
         h2aWU8ycvcb/HJQTI9uWU3mzLTz9afITIgV+hYb73xQMGvRMtnSW/8xE75jEKaWc+ANu
         8fXC/99NBHmjBv7CgH+NBvYuMfLzMngcRQLJxnGpkFSrxswssITH2W7VQW963hpaeWmS
         rg7aIslhRyVCgW18ka8c3eXqbAgDdkINtTDN3oVTf9usVlVIaeanBsX3GTIPBV2qrz2N
         6rwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tPdWi+1T3ztUzlnN8yjB/oPmxXYXNfRoTAThbMXnPgQ=;
        b=EMo2H4PFbrzks7ZSLuD08BPQnNITpCa3VBEUeXLo6yRXb4MAn0L/vw6xNaUvKpbIev
         kafHLQB63Qr1zJUXx5RVP9QV07Z1kXvODel9zKQWkrYN1+TXkT+7JbFyI9DuOOcNL8JT
         cx+fB4hkipNk4YTXfJAHoHwIgNiWI+fiuWsw023sUhDIkCPKdkseqG+mdmXfMe5ihUhN
         4V18OrbyYpYKtbroLsxfkdELDv2UqE20erVEaLtsfiebvxOQoWCtJMZY/cJXJucyOfZa
         RT0nGuWDE6AQr2Aw0pZBTi7e1WNuU3w23wKvwZsA1W0tp+FVFtDySphPWGqxmzf+njah
         TBfw==
X-Gm-Message-State: AOAM531LnE2F6X8CWh5BC0ae43IC2MhAP1OpvWxOCtwAjfRjInWPDX1J
        Cai0TzzgcOHKGWGIdtGZ3ydgPp56GJhA8jgaOCleLA==
X-Google-Smtp-Source: ABdhPJwGOPijijllSBfWY5WuohVWWzDfsQjgHUCcjn2nlZbTk/AAdmib+X80sAnxerzZvyJGuBskSOj+C2/jkFumb4s=
X-Received: by 2002:a6b:7b06:: with SMTP id l6mr17018406iop.199.1612261897820;
 Tue, 02 Feb 2021 02:31:37 -0800 (PST)
MIME-Version: 1.0
References: <20210201150028.2279522-1-jackmanb@google.com> <CAADnVQKAaoiVM6=VGxKh=T1PWUNWLKFx+3zKf3Ehud6+LsJB3w@mail.gmail.com>
In-Reply-To: <CAADnVQKAaoiVM6=VGxKh=T1PWUNWLKFx+3zKf3Ehud6+LsJB3w@mail.gmail.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Tue, 2 Feb 2021 11:31:26 +0100
Message-ID: <CA+i-1C2ZWUbGxWJ8kAxbri9rBboyuMaVj_BBhg+2Zf_Su9BOJA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Propagate memory bounds to registers in
 atomics w/ BPF_FETCH
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        John Fastabend <john.fastabend@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Feb 2021 at 00:27, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Feb 1, 2021 at 7:00 AM Brendan Jackman <jackmanb@google.com> wrote:
> > +
> > +SEC("fentry/bpf_fentry_test1")
> > +int BPF_PROG(sub, int x)
> > +{
> > +       int a = 0;
> > +       int b = __sync_fetch_and_add(&a, 1);
>
> It probably needs ENABLE_ATOMICS_TESTS ?
>
> Otherwise clang without -mcpu=v3 will complain:
> "fatal error: error in backend: Invalid usage of the XADD return value"

Ah yep of course, thanks for spotting. v3 incoming...
