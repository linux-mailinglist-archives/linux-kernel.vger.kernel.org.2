Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5570E337EA8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 21:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhCKUDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 15:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhCKUDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 15:03:14 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BBBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 12:03:13 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id u20so3761322lja.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 12:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eLt3FZMYBFKZlInRy7JD98xQ4Ni9WYT3aJdTTfIURcE=;
        b=Xs5yC5Ipbzjtv2d4w9FsSh9KccXVUwH3zC9z8r9WUcwkho4AQ44B/FSWfKFbirD0QW
         UXmkg676KDPnso5aWfqsjhzazMG3AkzPn5REpPpm9yALjSeO7/5qLSQPKfc2U+WWTq6b
         m/x8AnMO22p4v6hagF40p78UAHKleQH46EHd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eLt3FZMYBFKZlInRy7JD98xQ4Ni9WYT3aJdTTfIURcE=;
        b=WBLAijFPRJS9qWivpci9pHUc7dYbWTrVPu25RTEpgBu37Uh7W7mQReLev9DUI5E4sj
         ZZRBfPupvZmQF7fRV14uuvy8BHyF6UfBRg597lOUysKRLPH5cem6cMe/vLqxrmt8mwST
         mD1bQu7lBlprkxLLIZ66Qfc4AJaGrUnIsw0JGekCsQske1GZ5q305IYsHcuHSllV67Yl
         pTsujTc1Ia28NwW7TdEZjarVk98aJjFs6AnaQTHZh7Jq6PpC2jVcUvrva5TPqRxck+2I
         VS/cf/yG9WrQmNpEBXSrgSO0lR/qBhPhAb4EVvUblCh17BTTPIhw2YbfT8rVK0QEmHLY
         KBbg==
X-Gm-Message-State: AOAM530Eds243/T0ZSWwV++XZSNwSZIUk4NRf7Ib3Jc1VyXRnTEeMQvL
        hJAfsj4smWR2oDP2akS7waeAGyfLStg+6Q==
X-Google-Smtp-Source: ABdhPJxYRalYaBIu7ocBqG9mUDmBQolCcuQ23WZFENco73Vh19ghV4hR/pKB890Rw62R/kbMZoAN9Q==
X-Received: by 2002:a05:651c:200b:: with SMTP id s11mr298313ljo.177.1615492991735;
        Thu, 11 Mar 2021 12:03:11 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id t23sm1110709lfl.130.2021.03.11.12.03.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 12:03:10 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id z8so3762523ljm.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 12:03:10 -0800 (PST)
X-Received: by 2002:a2e:b6c6:: with SMTP id m6mr292522ljo.411.1615492990184;
 Thu, 11 Mar 2021 12:03:10 -0800 (PST)
MIME-Version: 1.0
References: <20210311130328.2859337-1-oberpar@linux.ibm.com> <202103120329.VU4uJ0yZ-lkp@intel.com>
In-Reply-To: <202103120329.VU4uJ0yZ-lkp@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 Mar 2021 12:02:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=whmwEJ-4tGamqOCw4BDJ-yjYrLRYxaFq5YurVc-XXO+hg@mail.gmail.com>
Message-ID: <CAHk-=whmwEJ-4tGamqOCw4BDJ-yjYrLRYxaFq5YurVc-XXO+hg@mail.gmail.com>
Subject: Re: [PATCH] gcov: fail build on gcov_info size mismatch
To:     kernel test robot <lkp@intel.com>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 11:34 AM kernel test robot <lkp@intel.com> wrote:
>
> >> kernel/gcov/geninfosize.sh: 13: [: =: unexpected operator

Wth? I'm not seeing how this can fail on nds32 - doesn't look like a
bashism, everything is properly quoted, etc etc. Plus it's a
cross-compile anyway, so the shell in question should be the same as
on all the other architectures.

Presumably the nds32 assembly contains something odd and unexpected,
but with the quoting, I can't see how even that could matter.

Yeah, the test itself could probably be simplified to testing both
conditions at the same time:

  [ "$a $b" = ".size .LPBX0," ]

but that's a separate issue.

Funky. What am I missing? Presumably something really stupid.

               Linus
