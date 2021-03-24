Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3E83483E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 22:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbhCXVm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 17:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbhCXVmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 17:42:31 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB33C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:42:31 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id q5so18473828pfh.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=/BXaCtsyvlKZW37/UqF6Ppelf92+338oWz9hD1Z3Z3I=;
        b=Mf60xk3srwUZdQnWm6wmyQUhN0dF7aatC8IJyWMZonUjaiWaXNKmR8/1vU5s5nduCX
         f4RT8YgmiJAxs+UsHIkci3bnHUd8UeIp1w0kIKXXldUIiizcd+sv43zNUVanMjS+KU+C
         jbO9r4D21aDYXXGAQqZ/G20lV0ZpWhEPZnT/iupA5cnqd2CZc3qdhNKJw4/BIOHsZzUE
         4RNRkvbh052gLptRCqWq++XWL6xwuaQbh3EU9LZ+81YZsPHEdi4WldasOh9yp7xR4xiN
         aybAHTWVTPfNdESNNlfDZ/1+Ld6PDdH1jYJHT2XGZeI2BV1PJETM1mptWfVie8jkAELY
         cFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=/BXaCtsyvlKZW37/UqF6Ppelf92+338oWz9hD1Z3Z3I=;
        b=Pp82udDdom3jUCa97vpoLXjcb7CQWno3Po4CoVKsJv47ruiTRWU04Mw1UcMIk5Sy2E
         PkJBj1iN1Uxea03OtfwRRjFvyBbFxFj/SZr942C0+uDhXX7JSFJinQsUymG0643nVRpv
         fsz0gKZgYoFU4Bmlw5qTTNlOiTSSh3+MimKov2CZjNDSv0KEv744avhp2CMN9cS3NKSL
         aKih0GlGWDKG9yJ1JKT4pHJunUhNc+NOAFM4yIX7xSSpDC8UM3qgI6oLti9i46fWLJhd
         54320/TwQSS+jvl9a5ya8/PNkaQaoo4jxp6oyNREBHuCLHS+RpnOXvIk8R8dVfmpqGCV
         P+QA==
X-Gm-Message-State: AOAM530X4wgWANOiFCA78TeAa8X937GZ0EaSI79VCN4V1nHUl+SI84No
        gtwIn/PSpsQym+hzvN9rAdYctw==
X-Google-Smtp-Source: ABdhPJwy0bfhCVbEOPXXdRIMXYVz+kiyezeQe0KkiTD0LaD9vuCTuEzuUVZBXFxkh1Ub2GjtFNOXfA==
X-Received: by 2002:a05:6a00:2163:b029:216:deaa:e386 with SMTP id r3-20020a056a002163b0290216deaae386mr4992460pff.72.1616622150670;
        Wed, 24 Mar 2021 14:42:30 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:b9f9:ef01:c08a:fb13? ([2601:646:c200:1ef2:b9f9:ef01:c08a:fb13])
        by smtp.gmail.com with ESMTPSA id a20sm3606162pfl.97.2021.03.24.14.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 14:42:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 14/22] x86/fpu/xstate: Expand the xstate buffer on the first use of dynamic user state
Date:   Wed, 24 Mar 2021 14:42:28 -0700
Message-Id: <03F61C1A-0CA1-43BB-B2B5-C9D654943051@amacapital.net>
References: <57fafdfe-0c2c-a5b5-a2b9-744fb9d34be8@intel.com>
Cc:     Len Brown <lenb@kernel.org>,
        "Liu, Jing2" <jing2.liu@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        X86 ML <x86@kernel.org>, Len Brown <len.brown@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
In-Reply-To: <57fafdfe-0c2c-a5b5-a2b9-744fb9d34be8@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: iPhone Mail (18D61)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mar 24, 2021, at 2:30 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> =EF=BB=BFOn 3/24/21 2:26 PM, Andy Lutomirski wrote:
>>> 3. user space always uses fully uncompacted XSAVE buffers.
>>>=20
>> There is no reason we have to do this for new states. Arguably we
>> shouldn=E2=80=99t for AMX to avoid yet another altstack explosion.
>=20
> The thing that's worried me is that the list of OS-enabled states is
> visible to apps via XGETBV.  It doesn't seem too much of a stretch to
> think that apps will see AMX enabled with XGETBV and them assume that
> it's on the signal stack.
>=20
> Please tell me I'm being too paranoid.  If we can break this assumption,
> it would get rid of a lot of future pain.

There are no AMX apps. I sure hope that there are no apps that enumerate xfe=
atures with CPUID and try to decode the mess in the signal stack.

I do think we need to save AMX state *somewhere* if a signal happens unless u=
serspace opts out, but I don=E2=80=99t think it needs to be in the nominally=
 expected spot.=
