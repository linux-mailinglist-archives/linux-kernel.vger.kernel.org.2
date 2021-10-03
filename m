Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8568420386
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 21:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhJCTE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 15:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhJCTE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 15:04:58 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D303C061780
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 12:03:10 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id e15so62269470lfr.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 12:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ow30GBGQA1FAf/xboEkwAx7IjJ8fqjrJnjZ63QrUg98=;
        b=PsVtQSWnnY/4YamDEyNsnpVIzr5MUbSbCWQPZ/ppZWC9x8MYs8QH53oXmI93For3ux
         R7iK+U0wKzxNwOj4vl+zEWfx77R1rzeCHRXMDa0CZ05gVBKEF6AYgPv0t7q8j3rD1DUe
         ldhnswIxr5U/ECr0CCiNTXBFY6GNcgOX+yVfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ow30GBGQA1FAf/xboEkwAx7IjJ8fqjrJnjZ63QrUg98=;
        b=BUq1s+pWQ34sIVKo4ZVAS9Wv3dZt3BgjyWR+R6iA6XXyoQyy5wy2EPU5RhaG8lWPuz
         wyvTgvGHGCe3sxMs34Ws5aXcLauTm/jVvbxt1Jg4EfEJ+dA54mJHlfE9n6+L5jJBisL9
         tXpa6AwKdH8Ngh9g32iNl5wqZegtjHGvr4utNhEitTa2M/wljfpLKPozeKGNBxYbShwR
         QF5t1ZjyaG6mbyxP/B5q0f86sdl6SMHRIqne60YlHwUZxyJdkPQhjGVRM98O6KmomItU
         ap1tjLbS+OThHlKYDZEi95/0b7gR4XVVogtOhgvliphBL/OurXE9enZkCRLFRiBKAPP4
         grDQ==
X-Gm-Message-State: AOAM5304/WNF4AHqwhBxjh5ZikveS8X/VpQqBpduDZpPlGllGxv4Hq5V
        +bgiL2i29zGKNqXLMXBSC0eGkgr5DB1ZD0TS
X-Google-Smtp-Source: ABdhPJxC2tOhLSyIYbWxaG9xpDttmVcvXQ3wyKlToMQ1oMnwHh40qvw5VtLVjf953TNpwEBH/u84ng==
X-Received: by 2002:a2e:5749:: with SMTP id r9mr11397534ljd.91.1633287788037;
        Sun, 03 Oct 2021 12:03:08 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id d26sm88855lfi.154.2021.10.03.12.03.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Oct 2021 12:03:06 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id i24so13971556lfj.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 12:03:05 -0700 (PDT)
X-Received: by 2002:ac2:58cb:: with SMTP id u11mr5355853lfo.402.1633287785686;
 Sun, 03 Oct 2021 12:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <YVl7RR5NcbPyiXgO@zn.tnic> <CAHk-=wh9JzLmwAqA2+cA=Y4x_TYNBZv_OM4eSEDFPF8V_GAPug@mail.gmail.com>
In-Reply-To: <CAHk-=wh9JzLmwAqA2+cA=Y4x_TYNBZv_OM4eSEDFPF8V_GAPug@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Oct 2021 12:02:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZwq-0LknKhXN4M+T8jbxn_2i9mcKpO+OaBSSq_Eh7tg@mail.gmail.com>
Message-ID: <CAHk-=wiZwq-0LknKhXN4M+T8jbxn_2i9mcKpO+OaBSSq_Eh7tg@mail.gmail.com>
Subject: Re: [GIT PULL] objtool/urgent for v5.15-rc4
To:     Borislav Petkov <bp@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000048555d05cd77728a"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000048555d05cd77728a
Content-Type: text/plain; charset="UTF-8"

On Sun, Oct 3, 2021 at 11:38 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Looking at the kvm code, that kvm_fastop_exception thing is some funky sh*t.
>
> I _think_ the problem is that 'kvm_fastop_exception' is done with bare
> asm at the top-level and that triggers some odd interaction with other
> section data, but I really don't know.

No, it's the fact that it is marked as a global function (why?) that
it then causes problems.

Now, I don't actually see why it would cause problems (the same way I
don't see why it's marked global). But removing that

     ".global kvm_fastop_exception \n"

works.

I suspect it makes the linker do the relocation for us before objtool
runs, because now that it's a local name, there is no worry about
multiply defined symbols of the same name or anything like that.

I also suspect that the reason for the warning is that the symbol type
has never been declared, so it's not marked as a STT_FUNC in the
relocation information.

So independently of this kvm_fastop_exception issue, I'd suggest the
attached patch for objtool to make the warning more informative for
people who try to debug this.

So I have a fix ("remove the global declaration"), but I really don't
like how random this is.

I also tried to instead keep the symbol global, and just mark
kvm_fastop_exception as a function (and add the proper size
annotation), but that only causes more objtool warnings for the
(generated asm) functions that *use* that symbol. Because they also
don't seem to be properly annotated.

Again, removing the global annotation works around the problem, but
the real underlying issue does seem to be that "funky sh*t" going on
in arch/x86/kvm/emulate.c.

So I'd like more people to look at this.

In the meantime, I think the exception handling for kvm
divide/multiply emulation is badly broken right now. Hmm?

                Linus

--00000000000048555d05cd77728a
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kubl14rm0>
X-Attachment-Id: f_kubl14rm0

IHRvb2xzL29ianRvb2wvc3BlY2lhbC5jIHwgMTIgKysrKysrKystLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rvb2xzL29i
anRvb2wvc3BlY2lhbC5jIGIvdG9vbHMvb2JqdG9vbC9zcGVjaWFsLmMKaW5kZXggZjU4ZWNjNTBm
YjEwLi5mMTQyOGUzMmE1MDUgMTAwNjQ0Ci0tLSBhL3Rvb2xzL29ianRvb2wvc3BlY2lhbC5jCisr
KyBiL3Rvb2xzL29ianRvb2wvc3BlY2lhbC5jCkBAIC0xMTAsOCArMTEwLDEwIEBAIHN0YXRpYyBp
bnQgZ2V0X2FsdF9lbnRyeShzdHJ1Y3QgZWxmICplbGYsIHN0cnVjdCBzcGVjaWFsX2VudHJ5ICpl
bnRyeSwKIAkJcmV0dXJuIC0xOwogCX0KIAlpZiAoIXJlbG9jMnNlY19vZmYob3JpZ19yZWxvYywg
JmFsdC0+b3JpZ19zZWMsICZhbHQtPm9yaWdfb2ZmKSkgewotCQlXQVJOX0ZVTkMoImRvbid0IGtu
b3cgaG93IHRvIGhhbmRsZSByZWxvYyBzeW1ib2wgdHlwZTogJXMiLAotCQkJICAgc2VjLCBvZmZz
ZXQgKyBlbnRyeS0+b3JpZywgb3JpZ19yZWxvYy0+c3ltLT5uYW1lKTsKKwkJV0FSTl9GVU5DKCJk
b24ndCBrbm93IGhvdyB0byBoYW5kbGUgcmVsb2Mgc3ltYm9sIHR5cGUgJWQ6ICVzIiwKKwkJCSAg
IHNlYywgb2Zmc2V0ICsgZW50cnktPm9yaWcsCisJCQkgICBvcmlnX3JlbG9jLT5zeW0tPnR5cGUs
CisJCQkgICBvcmlnX3JlbG9jLT5zeW0tPm5hbWUpOwogCQlyZXR1cm4gLTE7CiAJfQogCkBAIC0x
MzIsOCArMTM0LDEwIEBAIHN0YXRpYyBpbnQgZ2V0X2FsdF9lbnRyeShzdHJ1Y3QgZWxmICplbGYs
IHN0cnVjdCBzcGVjaWFsX2VudHJ5ICplbnRyeSwKIAkJCXJldHVybiAxOwogCiAJCWlmICghcmVs
b2Myc2VjX29mZihuZXdfcmVsb2MsICZhbHQtPm5ld19zZWMsICZhbHQtPm5ld19vZmYpKSB7Ci0J
CQlXQVJOX0ZVTkMoImRvbid0IGtub3cgaG93IHRvIGhhbmRsZSByZWxvYyBzeW1ib2wgdHlwZTog
JXMiLAotCQkJCSAgc2VjLCBvZmZzZXQgKyBlbnRyeS0+bmV3LCBuZXdfcmVsb2MtPnN5bS0+bmFt
ZSk7CisJCQlXQVJOX0ZVTkMoImRvbid0IGtub3cgaG93IHRvIGhhbmRsZSByZWxvYyBzeW1ib2wg
dHlwZSAlZDogJXMiLAorCQkJCSAgc2VjLCBvZmZzZXQgKyBlbnRyeS0+bmV3LAorCQkJCSAgbmV3
X3JlbG9jLT5zeW0tPnR5cGUsCisJCQkJICBuZXdfcmVsb2MtPnN5bS0+bmFtZSk7CiAJCQlyZXR1
cm4gLTE7CiAJCX0KIAo=
--00000000000048555d05cd77728a--
