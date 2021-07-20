Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792563D053B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 01:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbhGTWju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 18:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbhGTWjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 18:39:25 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF6EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 16:20:01 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id j1so522748ljo.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 16:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OX3cTPlOHS78r64AuikOKLsMLcidG71A6iCd80GxJZs=;
        b=Eu7WdxuFOde2o2TIYh3x/lD+3ya1GS/cWVznPYvYgI5vBK55m0hP44Z2KpWY6vrgRA
         ojEkiOk0ncEDgpFkKtdtLL1UTlHojj3LX/vG+3r66zJcZBJSisJS/FU2Semvon9bLD0P
         4TwJyqC7STMmFugYUNELO87FokgMF5wjIYlIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OX3cTPlOHS78r64AuikOKLsMLcidG71A6iCd80GxJZs=;
        b=f5han46bD8ZOMOz+MiebW7rGTdnAhr5J1FKE+7deVxztmJ8bimzZp5vPbqmZknPY6Y
         N5GYdyQHIGJHfbLAV1QhlVwjSI7oFRVif139pdP//c6K0ack8N31BAM8iNRbqyioXzSj
         /0W3Zcekm1pMfH7n1McCfO9SmGRk3gRg01xh2ZmnWC+Gs4EJa9f+RuZIJA4CXCAm7EQv
         7ynnAFvnclZmPu7TlB3FbePLgF1+TviRrWLsh81OL8zCRYr1MZKwCO45+w85Jc44mXty
         NcknbDKCawi/tAn0WahmMbLznc3trR5coGblkFinsAT/03HRDXkBeZA3f+NrUqUHMfL2
         3MmQ==
X-Gm-Message-State: AOAM531veTuxmU0HVLEi/rrDGUgnx/yJcfdZ0BEPqswPKAx3uzZkUE+t
        sGC81jnRrtSR2w3U4eXvJi18O4Vt6l8aGLPo
X-Google-Smtp-Source: ABdhPJxicOWxqMSbYfrPzJl2be/R1fLGQswJRNfvkEQdxrvIa0qYcp+Jc5UZ8fAR4jbzYaNJOSwzwg==
X-Received: by 2002:a2e:a817:: with SMTP id l23mr28494832ljq.86.1626823200055;
        Tue, 20 Jul 2021 16:20:00 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id y8sm1629111lfe.226.2021.07.20.16.19.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 16:19:59 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id h9so553060ljm.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 16:19:59 -0700 (PDT)
X-Received: by 2002:a2e:84c7:: with SMTP id q7mr28166096ljh.61.1626823198993;
 Tue, 20 Jul 2021 16:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210708232522.3118208-1-ndesaulniers@google.com>
 <20210708232522.3118208-3-ndesaulniers@google.com> <CAK7LNARye5Opc0AdXpn+DHB7hTaphoRSCUWxJgXu+sjuNjWUCg@mail.gmail.com>
 <CAHk-=wgGxu4_hgzdYpFuKd95SfnkJbPTWAQ9-fMgmMN1Oxs2xQ@mail.gmail.com>
 <CAKwvOdkvju7heeNpk87brsjkhXHbdKFsUgf63KWhXox9rDkQsA@mail.gmail.com> <CAHk-=wiZe2FuiAOwhbKR_VMmFBKekz0NFREm4fvik25PEdcK_g@mail.gmail.com>
In-Reply-To: <CAHk-=wiZe2FuiAOwhbKR_VMmFBKekz0NFREm4fvik25PEdcK_g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 20 Jul 2021 16:19:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whS1zBU=uhDTk2M1LwkqG7AKLsR0_+XG+saY_s2FHZr-A@mail.gmail.com>
Message-ID: <CAHk-=whS1zBU=uhDTk2M1LwkqG7AKLsR0_+XG+saY_s2FHZr-A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Makefile: infer CROSS_COMPILE from SRCARCH for
 LLVM=1 LLVM_IAS=1
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000e3b1e305c7964a88"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e3b1e305c7964a88
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 20, 2021 at 2:54 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But there are other things that stick around. In particular, I have
> considered simply using git config variables for that.
>
> Something like this in the main Makefile:

A slightly more fleshed-out patch to do this just to see if somebody
wants to work on something like this.

It really would seem to make it very easy to set up any random build
environment, and not have to remember it once it's done.

There are probably better ways to do this, I normally try to avoid
doing Makefile magic, since others have taken it over. Masahiro?

             Linus

--000000000000e3b1e305c7964a88
Content-Type: application/x-patch; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_krcogziu0>
X-Attachment-Id: f_krcogziu0

IE1ha2VmaWxlIHwgNTAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9NYWtlZmlsZSBiL01ha2VmaWxlCmluZGV4IGU0ZjU4OTViYWRiNS4u
MjIxZWIyMDViNDc1IDEwMDY0NAotLS0gYS9NYWtlZmlsZQorKysgYi9NYWtlZmlsZQpAQCAtNDM2
LDI3ICs0MzYsMzkgQEAgS0JVSUxEX0hPU1RDWFhGTEFHUyA6PSAtV2FsbCAtTzIgJChIT1NUX0xG
U19DRkxBR1MpICQoSE9TVENYWEZMQUdTKQogS0JVSUxEX0hPU1RMREZMQUdTICA6PSAkKEhPU1Rf
TEZTX0xERkxBR1MpICQoSE9TVExERkxBR1MpCiBLQlVJTERfSE9TVExETElCUyAgIDo9ICQoSE9T
VF9MRlNfTElCUykgJChIT1NUTERMSUJTKQogCi0jIE1ha2UgdmFyaWFibGVzIChDQywgZXRjLi4u
KQotQ1BQCQk9ICQoQ0MpIC1FCisjIGRlZmF1bHQgYnVpbGQgZW52aXJvbm1lbnQgKCdnaXQgY29u
ZmlnJyBjYW4gb3ZlcnJpZGUpCiBpZm5lcSAoJChMTFZNKSwpCi1DQwkJPSBjbGFuZwotTEQJCT0g
bGQubGxkCi1BUgkJPSBsbHZtLWFyCi1OTQkJPSBsbHZtLW5tCi1PQkpDT1BZCQk9IGxsdm0tb2Jq
Y29weQotT0JKRFVNUAkJPSBsbHZtLW9iamR1bXAKLVJFQURFTEYJCT0gbGx2bS1yZWFkZWxmCi1T
VFJJUAkJPSBsbHZtLXN0cmlwCitERUZfQ0MJCT0gY2xhbmcKK0RFRl9MRAkJPSBsZC5sbGQKK0RF
Rl9BUgkJPSBsbHZtLWFyCitERUZfTk0JCT0gbGx2bS1ubQorREVGX09CSkNPUFkJPSBsbHZtLW9i
amNvcHkKK0RFRl9PQkpEVU1QCT0gbGx2bS1vYmpkdW1wCitERUZfUkVBREVMRgk9IGxsdm0tcmVh
ZGVsZgorREVGX1NUUklQCT0gbGx2bS1zdHJpcAogZWxzZQotQ0MJCT0gJChDUk9TU19DT01QSUxF
KWdjYwotTEQJCT0gJChDUk9TU19DT01QSUxFKWxkCi1BUgkJPSAkKENST1NTX0NPTVBJTEUpYXIK
LU5NCQk9ICQoQ1JPU1NfQ09NUElMRSlubQotT0JKQ09QWQkJPSAkKENST1NTX0NPTVBJTEUpb2Jq
Y29weQotT0JKRFVNUAkJPSAkKENST1NTX0NPTVBJTEUpb2JqZHVtcAotUkVBREVMRgkJPSAkKENS
T1NTX0NPTVBJTEUpcmVhZGVsZgotU1RSSVAJCT0gJChDUk9TU19DT01QSUxFKXN0cmlwCi1lbmRp
ZgorREVGX0NDCQk9ICQoQ1JPU1NfQ09NUElMRSlnY2MKK0RFRl9MRAkJPSAkKENST1NTX0NPTVBJ
TEUpbGQKK0RFRl9BUgkJPSAkKENST1NTX0NPTVBJTEUpYXIKK0RFRl9OTQkJPSAkKENST1NTX0NP
TVBJTEUpbm0KK0RFRl9PQkpDT1BZCT0gJChDUk9TU19DT01QSUxFKW9iamNvcHkKK0RFRl9PQkpE
VU1QCT0gJChDUk9TU19DT01QSUxFKW9iamR1bXAKK0RFRl9SRUFERUxGCT0gJChDUk9TU19DT01Q
SUxFKXJlYWRlbGYKK0RFRl9TVFJJUAk9ICQoQ1JPU1NfQ09NUElMRSlzdHJpcAorZW5kaWYKKwor
YnVpbGQtb3B0aW9uID0gJChzaGVsbCBnaXQgY29uZmlnIC0tZGVmYXVsdCAiJCgyKSIgLS1nZXQg
JCgxKSB8fCBlY2hvICIkKDIpIikKK0NDCQk9ICQoY2FsbCBidWlsZC1vcHRpb24sYnVpbGQuY2Ms
JChERUZfQ0MpKQorTEQJCT0gJChjYWxsIGJ1aWxkLW9wdGlvbixidWlsZC5sZCwkKERFRl9MRCkp
CitBUgkJPSAkKGNhbGwgYnVpbGQtb3B0aW9uLGJ1aWxkLmFyLCQoREVGX0FSKSkKK05NCQk9ICQo
Y2FsbCBidWlsZC1vcHRpb24sYnVpbGQubm0sJChERUZfTk0pKQorT0JKQ09QWQkJPSAkKGNhbGwg
YnVpbGQtb3B0aW9uLGJ1aWxkLm9iamNvcHksJChERUZfT0JKQ09QWSkpCitPQkpEVU1QCQk9ICQo
Y2FsbCBidWlsZC1vcHRpb24sYnVpbGQub2JqZHVtcCwkKERFRl9PQkpEVU1QKSkKK1JFQURFTEYJ
CT0gJChjYWxsIGJ1aWxkLW9wdGlvbixidWlsZC5yZWFkZWxmLCQoREVGX1JFQURFTEYpKQorU1RS
SVAJCT0gJChjYWxsIGJ1aWxkLW9wdGlvbixidWlsZC5zdHJpcCwkKERFRl9TVFJJUCkpCisKKyMg
TWFrZSB2YXJpYWJsZXMgKENDLCBldGMuLi4pCitDUFAJCT0gJChDQykgLUUKIFBBSE9MRQkJPSBw
YWhvbGUKIFJFU09MVkVfQlRGSURTCT0gJChvYmp0cmVlKS90b29scy9icGYvcmVzb2x2ZV9idGZp
ZHMvcmVzb2x2ZV9idGZpZHMKIExFWAkJPSBmbGV4Cg==
--000000000000e3b1e305c7964a88--
