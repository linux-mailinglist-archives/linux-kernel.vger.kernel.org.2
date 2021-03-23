Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965B2345D13
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhCWLhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhCWLg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:36:58 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264AAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 04:36:58 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u5so26529936ejn.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 04:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eYXwdWJpGgPlbF+IMjlnRK89MycJ6XGBFq/8nML6pC0=;
        b=clFInBkeeScHTmHOP7pOfOTtYcMCWJWsiDjZLLVa3tz9WfsZFCU2Xjz4Rn/Xtgqmf1
         9ni/sA01AyG+pIzAWtzgOP6oyrRg0E4DHIrU5noHCJmgoRl9vqPAvZFKhxMkGyt9Q+GH
         pgmQ1u/7DFmwUyGGCQfEx63QP4keEpp7eyKq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eYXwdWJpGgPlbF+IMjlnRK89MycJ6XGBFq/8nML6pC0=;
        b=GhB3n2JJGXgXBHPJseckGIbRSCwPISkeZdhq4SxOWIS/kyKnfEUReqgm/1ExukMi9i
         Tyw1MNIsbjnp6OI4SzzmP+oLVBxomkjUwcEbw3mGW4bsVWlHwr2siv6vWX8JYewH31By
         F6xX9wHKspzfklK+0I1MqzJ6HaglhVVgkS7dxbhw/z2BphZ+j1TjVvCPCZSebSwxzm/k
         8NIHp2jph3x6HxTK69ZM/WetDv/YvQ0FO3SDYEfEMqW5xTsELbwJZukNjO1rMuQDCGrc
         VemUWw6A9HqARt/sdaV/wMZTUps22Sq4sggBciZ5sCeLYcv6mQBr3MC8T8GOzbqIcHeY
         bH2A==
X-Gm-Message-State: AOAM530FVKBikmMRbWZJDAOdsTyw+Xt98Qb0WkeWAfDzDjq++A57114z
        56Df5GCJks4tjmaQdDQDGoFr+g==
X-Google-Smtp-Source: ABdhPJx3nhkdvqAOxYrDrs1W4d9yEi6lYOlC66pKdx/nfTmq3D74GivKZdkEOzM6bDKovjQpw3O0ng==
X-Received: by 2002:a17:906:b297:: with SMTP id q23mr4498095ejz.315.1616499416873;
        Tue, 23 Mar 2021 04:36:56 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id p3sm11014906ejd.7.2021.03.23.04.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 04:36:56 -0700 (PDT)
Subject: Re: [kbuild-all] Re: include/linux/compiler_types.h:315:38: error:
 call to '__compiletime_assert_536' declared with attribute error:
 BUILD_BUG_ON failed: offsetof(struct can_frame, len) != offsetof(struct
 canfd_frame, len) || offsetof(struct can_frame, data) != offsetof(struc...
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rong Chen <rong.a.chen@intel.com>,
        Patrick Menschel <menschel.p@posteo.de>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
References: <202103210435.I0fiBGAC-lkp@intel.com>
 <dad98ebd-77a4-3305-e681-278cabe38793@hartkopp.net>
 <7f4f7e1c-194b-a903-d474-e3b742556a55@intel.com>
 <f8075a19-10e1-abf9-6d59-1a46454b74b1@hartkopp.net>
 <b10903ca-c424-b305-d981-fe0004500190@intel.com>
 <20210323073437.yo63wreqnubbeqby@pengutronix.de>
 <7ff6bfd3-6b4b-045a-abb7-485927909587@hartkopp.net>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <a5599800-53f4-c53f-abcc-e166ea9028b9@rasmusvillemoes.dk>
Date:   Tue, 23 Mar 2021 12:36:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <7ff6bfd3-6b4b-045a-abb7-485927909587@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2021 08.45, Oliver Hartkopp wrote:

> IMO we facing a compiler problem here - and we should be very happy that
> the BUILD_BUG_ON() triggered an issue after years of silence.
> 
> I do not have a good feeling about what kind of strange effects this
> compiler issue might have in other code of other projects.
> 
> So I would explicitly suggest NOT to change the af_can.c code to work
> around this compiler issue.
> 
> Let the gcc people fix their product and let them thank all of us for
> detecting it.

I'm sure you'd be eligible for a full refund in case this was a bug in
gcc. It is not. It's a pretty clear ABI requirement for (at least some
flavors of) ARM:

https://stackoverflow.com/questions/43786747/struct-layout-in-apcs-gnu-abi

and more directly from the horse's mouth:

https://developer.arm.com/documentation/dui0067/d/arm-compiler-reference/c-and-c---implementation-details/structures--unions--enumerations--and-bitfields

Field alignment

    Structures are arranged with the first-named component at the lowest
address. Fields are aligned as follows:

        A field with a char type is aligned to the next available byte.

        A field with a short type is aligned to the next even-addressed
byte.

        Bitfield alignment depends on how the bitfield is declared. See
Bitfields in packed structures for more information.

        All other types are aligned on word boundaries.

That anonymous union falls into the "All other types" bullet.

__packed is the documented and standard way to overrule the
compiler's/ABI's layout decisions.

Rasmus
