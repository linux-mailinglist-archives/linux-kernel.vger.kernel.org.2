Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0ACB40D302
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 08:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhIPGCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 02:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbhIPGCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 02:02:20 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581F9C061764
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 23:01:00 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id x7so4851382pfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 23:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=/ZVUbtz7S16pRgDYuTweMrf8Kk4C7hs/yI2e1WlLQQE=;
        b=eEULdqOkMWS/tnuLfThi/1lJZq5BxMgW1zKFb38BIBcAf8+Op7wJj3fEtx1yWkfZWM
         H09DRgqqDC49VM5mNkZ1UF0Ec+aPAKo3/LfE738Hm5HfT4LPPoP30Lf80j7ovYAlnVYI
         +n56pSNyzWwtRb4RWUaw6+drZ9KjserNiVbU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=/ZVUbtz7S16pRgDYuTweMrf8Kk4C7hs/yI2e1WlLQQE=;
        b=O8UuXUACAbJPFi/M2G8AzQnGZVRKr80ZPx2yB0aul4nwwQfoDlpw0E82nsibPmsd/Z
         4yU1OQUdWDDNzeBbwQRR/+7oCezlTmnZXjgDac7+al+yVwaetPc3bN5+0MNc7WLpLduF
         u1Mvnm9YtT4d/b0rT/DpC+WEVNxatgRn0ZRLYUPFdWrqR+UQF0BBeJbJ9StnlkPr2c/c
         ZM93/MekfP0J48eDMTL2bGHTJlcX3C83h7eQuwYv4lX/qe1sRkWexnwATux+DUHEZV5L
         8ar9yCaBunJ5nk+fArwTKEKYRO+ZgylUkZ1Z1vDy7GQtZ7GGYyPAg2tudG0IDrMb7ul2
         HvSw==
X-Gm-Message-State: AOAM533r0xwQyxIDwFRgvFA3bnsSaFWeb/aKIBAZsfR/Gkqei6ShYTIR
        ZxwLaoJy2b/NAt+d7ZqPt5YQtQ==
X-Google-Smtp-Source: ABdhPJwGp5KotmtYZzkcaYcLKzPRyW6SsIEju51OabkSxgN/5erCAO0kxcpsI8jnsdsRvT373FRvMQ==
X-Received: by 2002:a63:cf44:: with SMTP id b4mr3471621pgj.215.1631772059839;
        Wed, 15 Sep 2021 23:00:59 -0700 (PDT)
Received: from [127.0.0.1] (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id p13sm1401788pjo.9.2021.09.15.23.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 23:00:59 -0700 (PDT)
Date:   Wed, 15 Sep 2021 23:00:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
User-Agent: K-9 Mail for Android
In-Reply-To: <20210916133433.3b309895@canb.auug.org.au>
References: <20210916133433.3b309895@canb.auug.org.au>
Message-ID: <023CC3E1-3776-44B7-9546-7306E49DDB9C@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On September 15, 2021 8:34:33 PM PDT, Stephen Rothwell <sfr@canb=2Eauug=2E=
org=2Eau> wrote:
>Hi all,
>
>After merging the kspp tree, today's linux-next build (powerpc
>ppc64_defconfig) failed like this:
>
>In file included from include/linux/compiler_types=2Eh:85,
>                 from <command-line>:
>include/linux/compiler-gcc=2Eh:44: warning: "__compiletime_warning" redef=
ined
>   44 | #define __compiletime_warning(message) __attribute__((__warning__=
(message)))
>      |=20
>
>And many more=2E
>
>Caused by commit
>
>  0fc9374deb67 ("compiler_types=2Eh: Remove __compiletime_object_size()")
>
>Something went badly wrong in the rebase :-(

Ieeeee! Thank you=2E Fixing=2E=2E=2E

-Kees

>
>I have used the kspp tree from next-20210916 for today=2E
>
