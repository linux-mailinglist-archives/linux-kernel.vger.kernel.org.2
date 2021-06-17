Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB873AAB00
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 07:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhFQFX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 01:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhFQFXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 01:23:49 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D52AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 22:21:42 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o88-20020a17090a0a61b029016eeb2adf66so5205940pjo.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 22:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=IiEIjleBusGBa/AVKIhB+ojZDFic8IqFpbVO6kSE2bs=;
        b=M4DsVPWi6V9ABVD4/wFHuv+DtK7vdPAeuGt4q68xjhSO+27cxKtMKV6eFaDsUwXxE8
         sNCnMWFgnh2TiYqv8T2YiRTfJNpFBRgdpY2amsy1JgdkP+AVEQEEblnsTrBr1/i6M232
         sc7HaBi1vN7BKaEMM7Ol+6TxXIwj415XBEGu+9OhJ1Qrc19NMT6w6NTbH+X+XDaiUE8W
         QZiBJHopzLXOwxepkcpl/dWbDWNVzXYFYKOEXc++VBvm2xZ1zwz7C34aBkQ5yflGd4a4
         J+lEQwF5ftbL/hXQqkolhPTLn2IFXl8mrY/aJCDPd0rt08qTMWum+5dP5X0RXSMvlFAe
         Jo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=IiEIjleBusGBa/AVKIhB+ojZDFic8IqFpbVO6kSE2bs=;
        b=DtLX4k80zDDQWUtIQtDUqs4HdN14qNsogHwRYWmbDatJk3OM/Xu2tqouuWSQZzS2eM
         hykg/FoFTSeWxkFONrOWSpuYHd9llx69HshllIfHJDblJdt7FJuKYo9UmlnQBXJCARt/
         +VDZxUkOkG/I4+YUP+iFT3Becqr3yQgUivgblIeVQ3+ZQwAlw9Zs9cOPakzy3fz3wX7N
         bFGBaLtUgv44bcp/68uxut/91413GWQBBbZVIqci1m5u2vtOvYPZa092UmwWzLRllBCN
         ZgtBinUp750EmwlHc7puoIaLgcowtDIONBuNtfvY++wbrEdTg0vwNTJ58hFdep/VOfRM
         EBQA==
X-Gm-Message-State: AOAM532wqJH5gOvzb9WYRVyHL0g1w4C8IVkasCCQLOx3hUCIWdd6PeuE
        iPW3Ak9lX0ZvMHNWwrEVd3I=
X-Google-Smtp-Source: ABdhPJzBkr0iJz5bdOnzNSpA9OOHOaTorvnhWBgBCxf7FNmiUP5c7fPfcObhierQgxNTP26VcJWpJw==
X-Received: by 2002:a17:902:8493:b029:11a:faa6:5bf6 with SMTP id c19-20020a1709028493b029011afaa65bf6mr2979254plo.42.1623907301768;
        Wed, 16 Jun 2021 22:21:41 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id d6sm4011456pgq.88.2021.06.16.22.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 22:21:41 -0700 (PDT)
Date:   Thu, 17 Jun 2021 15:21:36 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 1/2] module: add elf_check_module_arch for module
 specific elf arch checks
To:     Jessica Yu <jeyu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal =?iso-8859-1?q?Such=E1nek?= <msuchanek@suse.de>
References: <20210611093959.821525-1-npiggin@gmail.com>
        <20210611093959.821525-2-npiggin@gmail.com>
        <YMdGWjBOmcstBwOl@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
        <1623722110.amu32mwaqs.astroid@bobo.none>
        <YMiaZOqhHck9iy0n@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
        <1623805495.qdikm5ks8v.astroid@bobo.none> <YMn0cvhTyRtsE7xu@linux.fritz.box>
In-Reply-To: <YMn0cvhTyRtsE7xu@linux.fritz.box>
MIME-Version: 1.0
Message-Id: <1623907147.4k0ms3i41v.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Jessica Yu's message of June 16, 2021 10:54 pm:
> +++ Nicholas Piggin [16/06/21 11:18 +1000]:
>>Excerpts from Jessica Yu's message of June 15, 2021 10:17 pm:
>>> +++ Nicholas Piggin [15/06/21 12:05 +1000]:
>>>>Excerpts from Jessica Yu's message of June 14, 2021 10:06 pm:
>>>>> +++ Nicholas Piggin [11/06/21 19:39 +1000]:
>>>>>>The elf_check_arch() function is used to test usermode binaries, but
>>>>>>kernel modules may have more specific requirements. powerpc would lik=
e
>>>>>>to test for ABI version compatibility.
>>>>>>
>>>>>>Add an arch-overridable function elf_check_module_arch() that default=
s
>>>>>>to elf_check_arch() and use it in elf_validity_check().
>>>>>>
>>>>>>Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>>>>>[np: split patch, added changelog]
>>>>>>Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>>>>---
>>>>>> include/linux/moduleloader.h | 5 +++++
>>>>>> kernel/module.c              | 2 +-
>>>>>> 2 files changed, 6 insertions(+), 1 deletion(-)
>>>>>>
>>>>>>diff --git a/include/linux/moduleloader.h b/include/linux/moduleloade=
r.h
>>>>>>index 9e09d11ffe5b..fdc042a84562 100644
>>>>>>--- a/include/linux/moduleloader.h
>>>>>>+++ b/include/linux/moduleloader.h
>>>>>>@@ -13,6 +13,11 @@
>>>>>>  * must be implemented by each architecture.
>>>>>>  */
>>>>>>
>>>>>>+// Allow arch to optionally do additional checking of module ELF hea=
der
>>>>>>+#ifndef elf_check_module_arch
>>>>>>+#define elf_check_module_arch elf_check_arch
>>>>>>+#endif
>>>>>
>>>>> Hi Nicholas,
>>>>>
>>>>> Why not make elf_check_module_arch() consistent with the other
>>>>> arch-specific functions? Please see module_frob_arch_sections(),
>>>>> module_{init,exit}_section(), etc in moduleloader.h. That is, they ar=
e
>>>>> all __weak functions that are overridable by arches. We can maybe mak=
e
>>>>> elf_check_module_arch() a weak symbol, available for arches to
>>>>> override if they want to perform additional elf checks. Then we don't
>>>>> have to have this one-off #define.
>>>>
>>>>
>>>>Like this? I like it. Good idea.
>>>
>>> Yeah! Also, maybe we can alternatively make elf_check_module_arch() a
>>> separate check entirely so that the powerpc implementation doesn't
>>> have to include that extra elf_check_arch() call. Something like this m=
aybe?
>>
>>Yeah we can do that. Would you be okay if it goes via powerpc tree? If
>>yes, then we should get your Ack (or SOB because it seems to be entirely
>>your patch now :D)
>=20
> This can go through the powerpc tree. Will you do another respin
> of this patch? And yes, feel free to take my SOB for this one -
>=20
>      Signed-off-by: Jessica Yu <jeyu@kernel.org>

You're maintainer so let's go with your preference. We can always adjust=20
the arch hooks later if a need comes up. And yes I'll re post with you=20
cc'ed.

Thanks,
Nick
