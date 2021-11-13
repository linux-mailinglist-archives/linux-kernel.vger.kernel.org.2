Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B060344F5B6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 00:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhKMXXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 18:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhKMXXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 18:23:31 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D455C061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 15:20:38 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id r12so53682276edt.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 15:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uYXYvX3lQN+4CmLJKYnO/NxLt8YDnJHWgNGhZhL3hQE=;
        b=Zd//V0Bv4dOljddH6L9rcdZv+LkO8DvZZqyrsUMwBh15miSAPf/U+kY5JgHayJcHFu
         3iT+cHl0rK34NLFWtRYTNfd9mjDdrPHjp7qVKglcDdlOBRpx94uBKMS/14ueXkhP8Yhi
         17zo3S6pQq81EBsJLf3YX9KI7CHWT9UeGYrFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uYXYvX3lQN+4CmLJKYnO/NxLt8YDnJHWgNGhZhL3hQE=;
        b=d1Cy8ri7fSpTctIXd/Xcuhv7ZRfDrNVEpJjh1+47CyYwnGYqD7WpwGsQO6qE8hsq/g
         wCCCnV2tXcLAj+/jRrhIdUGpGTNTfiLm4V1qwwk/FqtdDrKA92h/dJhurRHvRSUb2O7Y
         ApSuxOycaQPqeVQZXs7YbbUxp3e6HFGbmrCmsx2EY97YBE2riBBPIG61d/wUuIdCxeKV
         8aCWgNdnRqj7kIIcfdK2jhLSVgrbIpaMgYDKsYTwshC94Ue2rrk1lSF13s7bnEb2FDSb
         //TYk5y3/b4qu7/TMGn0LkN0j8sTobQOltQa/ea5VPTagXpm8Uv3BYTSvGNaVXrGWsHa
         5RVw==
X-Gm-Message-State: AOAM531j9evlR7gAQgnacCDF9xHWeBGJKd8baQC262Cn3enpos7QlmB3
        SV/HhlACRZ26qOh9Y9p3LUupHURsv8zb11vLtTI=
X-Google-Smtp-Source: ABdhPJwFwtA7N/40eSw3wXYMxyJxifvWsvMB4cHKyIVgf3aOJ6PK1qsp4nDGSCJGpuwmwNzHgw15Ng==
X-Received: by 2002:a50:fd16:: with SMTP id i22mr29732189eds.224.1636845636604;
        Sat, 13 Nov 2021 15:20:36 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id o14sm4984419edj.15.2021.11.13.15.20.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Nov 2021 15:20:35 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id n29so22406774wra.11
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 15:20:35 -0800 (PST)
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr32369933wrm.229.1636845635529;
 Sat, 13 Nov 2021 15:20:35 -0800 (PST)
MIME-Version: 1.0
References: <20211113214125.GA23640@embeddedor>
In-Reply-To: <20211113214125.GA23640@embeddedor>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Nov 2021 15:20:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj-yyR1s1LcnTspgpcriyX-nDruzSmEneA2U=bOj9gCuQ@mail.gmail.com>
Message-ID: <CAHk-=wj-yyR1s1LcnTspgpcriyX-nDruzSmEneA2U=bOj9gCuQ@mail.gmail.com>
Subject: Re: [GIT PULL] Enable -Wimplicit-fallthrough for Clang for 5.16-rc1
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a8b11e05d0b3d28f"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000a8b11e05d0b3d28f
Content-Type: text/plain; charset="UTF-8"

On Sat, Nov 13, 2021 at 1:36 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> This patch has been baking in linux-next for a couple of developement
> cycles, now. So, I think we are pretty much ready to merge it into
> mainline.

Ugh. It's also very ugly.

Wouldn't something like this (TOTALLY UNTESTED!) work and do the right thing?

This seems like a natural for a Kconfig decision.

Also, does -Wimplicit-fallthrough=5 work with clang too? That would
simplify things a bit, and then we could just use a regular boolean
and do

  KBUILD_CFLAGS-$(CC_IMPLICIT_FALLTHROUGH) += -Wimplicit-fallthrough=5

in the Makefile, which is more in like with what we do for other
config-time cflags..

           Linus

--000000000000a8b11e05d0b3d28f
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kvyfj3pd0>
X-Attachment-Id: f_kvyfj3pd0

IE1ha2VmaWxlICAgICB8IDYgKy0tLS0tCiBpbml0L0tjb25maWcgfCA1ICsrKysrCiAyIGZpbGVz
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9N
YWtlZmlsZSBiL01ha2VmaWxlCmluZGV4IGQ4M2Q3MmMyNmFhYS4uOWNmOWQ1YzFlZDhmIDEwMDY0
NAotLS0gYS9NYWtlZmlsZQorKysgYi9NYWtlZmlsZQpAQCAtNzg5LDcgKzc4OSw3IEBAIHN0YWNr
cC1mbGFncy0kKENPTkZJR19TVEFDS1BST1RFQ1RPUl9TVFJPTkcpICAgICAgOj0gLWZzdGFjay1w
cm90ZWN0b3Itc3Ryb25nCiBLQlVJTERfQ0ZMQUdTICs9ICQoc3RhY2twLWZsYWdzLXkpCiAKIEtC
VUlMRF9DRkxBR1MtJChDT05GSUdfV0VSUk9SKSArPSAtV2Vycm9yCi1LQlVJTERfQ0ZMQUdTICs9
ICQoS0JVSUxEX0NGTEFHUy15KQorS0JVSUxEX0NGTEFHUyArPSAkKEtCVUlMRF9DRkxBR1MteSkg
JChDT05GSUdfQ0NfSU1QTElDSVRfRkFMTFRIUk9VR0gpCiAKIGlmZGVmIENPTkZJR19DQ19JU19D
TEFORwogS0JVSUxEX0NQUEZMQUdTICs9IC1RdW51c2VkLWFyZ3VtZW50cwpAQCAtODAxLDEwICs4
MDEsNiBAQCBLQlVJTERfQ0ZMQUdTICs9IC1Xbm8tZ251CiBLQlVJTERfQ0ZMQUdTICs9IC1tbm8t
Z2xvYmFsLW1lcmdlCiBlbHNlCiAKLSMgV2FybiBhYm91dCB1bm1hcmtlZCBmYWxsLXRocm91Z2hz
IGluIHN3aXRjaCBzdGF0ZW1lbnQuCi0jIERpc2FibGVkIGZvciBjbGFuZyB3aGlsZSBjb21tZW50
IHRvIGF0dHJpYnV0ZSBjb252ZXJzaW9uIGhhcHBlbnMgYW5kCi0jIGh0dHBzOi8vZ2l0aHViLmNv
bS9DbGFuZ0J1aWx0TGludXgvbGludXgvaXNzdWVzLzYzNiBpcyBkaXNjdXNzZWQuCi1LQlVJTERf
Q0ZMQUdTICs9ICQoY2FsbCBjYy1vcHRpb24sLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD01LCkKICMg
Z2NjIGluYW5lbHkgd2FybnMgYWJvdXQgbG9jYWwgdmFyaWFibGVzIGNhbGxlZCAnbWFpbicKIEtC
VUlMRF9DRkxBR1MgKz0gLVduby1tYWluCiBlbmRpZgpkaWZmIC0tZ2l0IGEvaW5pdC9LY29uZmln
IGIvaW5pdC9LY29uZmlnCmluZGV4IDQ1YmNhYThlNzQ4MS4uMDM2Yjc1MGU4ZDhhIDEwMDY0NAot
LS0gYS9pbml0L0tjb25maWcKKysrIGIvaW5pdC9LY29uZmlnCkBAIC04ODUsNiArODg1LDExIEBA
IGNvbmZpZyBBUkNIX1dBTlRfQkFUQ0hFRF9VTk1BUF9UTEJfRkxVU0gKIGNvbmZpZyBDQ19IQVNf
SU5UMTI4CiAJZGVmX2Jvb2wgISQoY2Mtb3B0aW9uLCQobTY0LWZsYWcpIC1EX19TSVpFT0ZfSU5U
MTI4X189MCkgJiYgNjRCSVQKIAorY29uZmlnIENDX0lNUExJQ0lUX0ZBTExUSFJPVUdICisJc3Ry
aW5nCisJZGVmYXVsdCAiLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD01IiBpZiBDQ19JU19HQ0MKKwlk
ZWZhdWx0ICItV2ltcGxpY2l0LWZhbGx0aHJvdWdoIiBpZiBDQ19JU19DTEFORyAmJiAkKGNjLW9w
dGlvbiwtV3VucmVhY2hhYmxlLWNvZGUtZmFsbHRocm91Z2gpCisKICMKICMgRm9yIGFyY2hpdGVj
dHVyZXMgdGhhdCBrbm93IHRoZWlyIEdDQyBfX2ludDEyOCBzdXBwb3J0IGlzIHNvdW5kCiAjCg==
--000000000000a8b11e05d0b3d28f--
