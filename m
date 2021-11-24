Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF8645CC12
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243315AbhKXSbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243256AbhKXSa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:30:56 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99679C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:27:46 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id r11so14450264edd.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vPmd5sfhkAM85zvuSdlRQSQ/Hh0Fqn66uMpVcY2xX7g=;
        b=F9O2lAj+FoLFks+Ooj5m0Fvkprbd42KfBK0uCIRHMhCeD3HLog674LSYtqBzo/4zn0
         T/r5aVlx7hEduYR9LyaqpzSgXETKSuHEXcUGvzhvtrkhhmnwAVrNzQZ01gmAf497o6Y/
         NwcPD/2ru62MbG7U82qsRffuRqxVX4z4s/Qzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vPmd5sfhkAM85zvuSdlRQSQ/Hh0Fqn66uMpVcY2xX7g=;
        b=Kp/c3ksbqe0voIMhS+203fTth380d2bCEsGoqwWpQKbe+BnvvF2H009cPflZUPUHw9
         bttFBVmvw0W/H65nOy2WTRYHD25gcEjVctOaJCc305dwT6cW/jF8Kq5Q/t6VgYrlQojg
         7ViF6jfM0QEELgZ2+AWjHRwgzoe4rFoC0mgTbe50TlFephk0Y83alUf1743ZNWnhi9mf
         abuWOFVlXlsiqAG3XodGYQzbC6ldA5iACkzE+bFz3gOR4Cen9GWCKpJddbTNL4dMJZ2H
         jQmJa1aoiekuF1P6Hzcf6k/g4kHDnVxeQYN7WKL+dn02xcleE2viD4QIU/VbXVP1uMap
         /Pww==
X-Gm-Message-State: AOAM5302b0FZ61LieiyVfD2fpqznA4XsSxWOi69HYXAiWk604U0ZgOlJ
        sU/jqBkUd4zDVwE8fzTxKVyMpBB9GNyWIgvn
X-Google-Smtp-Source: ABdhPJwTeD+5dKni3bAoxs0XA1wDfW+s5eIuSAu9f3RQkYfFQR3Fklnqw4UdE8ul94v8qr31bInHzg==
X-Received: by 2002:a17:907:7ba8:: with SMTP id ne40mr23898672ejc.391.1637778464772;
        Wed, 24 Nov 2021 10:27:44 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id v13sm301821ejo.36.2021.11.24.10.27.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 10:27:43 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso6277657wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:27:43 -0800 (PST)
X-Received: by 2002:a1c:7405:: with SMTP id p5mr17281990wmc.152.1637778463548;
 Wed, 24 Nov 2021 10:27:43 -0800 (PST)
MIME-Version: 1.0
References: <20211124100956.6905a198@gandalf.local.home>
In-Reply-To: <20211124100956.6905a198@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Nov 2021 10:27:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjakjw6-rDzDDBsuMoDCqd+9ogifR_EE1F0K-jYek1CdA@mail.gmail.com>
Message-ID: <CAHk-=wjakjw6-rDzDDBsuMoDCqd+9ogifR_EE1F0K-jYek1CdA@mail.gmail.com>
Subject: Re: [GIT PULL] tracing/uprobe: Fix uprobe_perf_open probes iteration
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: multipart/mixed; boundary="0000000000008a890f05d18d0305"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000008a890f05d18d0305
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 24, 2021 at 7:10 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> tracing: Fix wrong uprobe variable in iterator

I've pulled this, but:

>         list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
> +               tu = container_of(pos, struct trace_uprobe, tp);

honestly, the "list_for_each_entry()" followed by a "container_of()"
like this makes me think you used the wrong entry to walk the list in.

You actually don't want to ever use that

        struct trace_probe *pos;

at all, and I think you should remove it.

Instead, you should do something like

        list_for_each_entry(pu, trace_probe_probe_list(tp), tp.list) {

ie simply walk the list _as_ the uprobe entry, not as some
intermediate internal probe list entry only to convert to the uprobe.

Now, I may be entirely off my meds here, and maybe there is something
I'm missing, but I _think_ the attached patch should work, and avoid
all that indirection through 'pos' that you don't care about and that
seems to just have been a mistake.

Feel free to call me funny names for when I missed some detail.

Again - I *have* pulled your fix, and in fact the attached patch is
relative to your fix. That fix isn't _wrong_. I just think it's a bit
silly, and I think the cause of the bug in the first place was that
unnecessary intermediate pointer.

               Linus

--0000000000008a890f05d18d0305
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kwduy8s10>
X-Attachment-Id: f_kwduy8s10

IGtlcm5lbC90cmFjZS90cmFjZV91cHJvYmUuYyB8IDUgKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEva2VybmVsL3RyYWNl
L3RyYWNlX3Vwcm9iZS5jIGIva2VybmVsL3RyYWNlL3RyYWNlX3Vwcm9iZS5jCmluZGV4IGY1ZjAw
MzlkMzFlNS4uZWU1NDA4ZjJhNjhhIDEwMDY0NAotLS0gYS9rZXJuZWwvdHJhY2UvdHJhY2VfdXBy
b2JlLmMKKysrIGIva2VybmVsL3RyYWNlL3RyYWNlX3Vwcm9iZS5jCkBAIC0xMzAwLDcgKzEzMDAs
NyBAQCBzdGF0aWMgaW50IHVwcm9iZV9wZXJmX2Nsb3NlKHN0cnVjdCB0cmFjZV9ldmVudF9jYWxs
ICpjYWxsLAogc3RhdGljIGludCB1cHJvYmVfcGVyZl9vcGVuKHN0cnVjdCB0cmFjZV9ldmVudF9j
YWxsICpjYWxsLAogCQkJICAgIHN0cnVjdCBwZXJmX2V2ZW50ICpldmVudCkKIHsKLQlzdHJ1Y3Qg
dHJhY2VfcHJvYmUgKnBvcywgKnRwOworCXN0cnVjdCB0cmFjZV9wcm9iZSAqdHA7CiAJc3RydWN0
IHRyYWNlX3Vwcm9iZSAqdHU7CiAJaW50IGVyciA9IDA7CiAKQEAgLTEzMTIsOCArMTMxMiw3IEBA
IHN0YXRpYyBpbnQgdXByb2JlX3BlcmZfb3BlbihzdHJ1Y3QgdHJhY2VfZXZlbnRfY2FsbCAqY2Fs
bCwKIAlpZiAodHJhY2VfdXByb2JlX2ZpbHRlcl9hZGQodHUtPnRwLmV2ZW50LT5maWx0ZXIsIGV2
ZW50KSkKIAkJcmV0dXJuIDA7CiAKLQlsaXN0X2Zvcl9lYWNoX2VudHJ5KHBvcywgdHJhY2VfcHJv
YmVfcHJvYmVfbGlzdCh0cCksIGxpc3QpIHsKLQkJdHUgPSBjb250YWluZXJfb2YocG9zLCBzdHJ1
Y3QgdHJhY2VfdXByb2JlLCB0cCk7CisJbGlzdF9mb3JfZWFjaF9lbnRyeSh0dSwgdHJhY2VfcHJv
YmVfcHJvYmVfbGlzdCh0cCksIHRwLmxpc3QpIHsKIAkJZXJyID0gdXByb2JlX2FwcGx5KHR1LT5p
bm9kZSwgdHUtPm9mZnNldCwgJnR1LT5jb25zdW1lciwgdHJ1ZSk7CiAJCWlmIChlcnIpIHsKIAkJ
CXVwcm9iZV9wZXJmX2Nsb3NlKGNhbGwsIGV2ZW50KTsK
--0000000000008a890f05d18d0305--
