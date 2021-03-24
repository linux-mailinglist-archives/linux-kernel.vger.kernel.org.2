Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F13B3476B2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 12:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhCXLAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 07:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhCXLAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 07:00:02 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2E5C0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 04:00:01 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u5so32109596ejn.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 04:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vq6UvNXDWrZTNsMJP/Ia1HW3F97MuZUnuthiX1bxGtU=;
        b=cqmCCRie2CdDl1S1YgCHBGW+OkgqMG5N0dTNLJPsxgsJ7/+26XxfT7PFvafVoyNfjB
         6nloQCQBP0YfyDSQVs9bDrEpT2pjWCzI/zmmZi1GXEHnXHH4yFsFeilTi1UifygghMZF
         pclqUkLGeig18HyqBW3ow5NRhiCIExL3m4Yxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vq6UvNXDWrZTNsMJP/Ia1HW3F97MuZUnuthiX1bxGtU=;
        b=kbmssIEFckm7mGVvdI9btHO2w6cSYSES2gg5te+y5Z3+oMZuE4on9BnUU26vLfZdKS
         TNpfoueMq/k5hKrXcrBYuCT2I1cKJLHdEk9OLPaRPRaGxClMo7/PPskGPEeqaLiAwHr4
         ug73lrWZp1oTowDKW/h6Onsxw7fz6CPNftV75Cgb6C3+1x7LoVgAsb/zHNPYcqMDCgQJ
         GpSyaXmagJoVz+/WCarDVN+VuOkAVAkJuPkmZZJmrkOMsP2x5M74dmQAFFLAkt/dDEUp
         tOzqNmP4wTkbBaOWes5AT9Wparf2zTpR1Trz/syboAIlBto6HwRc3ah4jisbn3eIu9LP
         S1bQ==
X-Gm-Message-State: AOAM530J33zOKQZQr97nEdw2+zt7PnI7cXpqrWXLInkWAX/ZncOecak7
        2/xTIP+dASTNQ6Y16W+wYM4hPb0TMwIB2aUx
X-Google-Smtp-Source: ABdhPJyfh90JecszOnCBMD0SmB+1HexRYEBzI5l+UU/eO0GM01GwpxlKrXSd47LJXxk7YIAsaQZESg==
X-Received: by 2002:a17:906:489b:: with SMTP id v27mr2972817ejq.1.1616583599964;
        Wed, 24 Mar 2021 03:59:59 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id l10sm951179edr.87.2021.03.24.03.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 03:59:59 -0700 (PDT)
Subject: Re: [PATCH v2] editorconfig: Add automatic editor configuration file
To:     Jonathan Corbet <corbet@lwn.net>, Danny Lin <danny@kdrag0n.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <16043769.gqpzGLO8mG@pinwheel>
 <20200703073143.423557-1-danny@kdrag0n.dev> <20200703062950.5e8c1785@lwn.net>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <9486d1ab-580a-0819-10c9-a62354a255e1@rasmusvillemoes.dk>
Date:   Wed, 24 Mar 2021 11:59:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20200703062950.5e8c1785@lwn.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2020 14.29, Jonathan Corbet wrote:

[doing a bit of necromancy here]

> On Fri,  3 Jul 2020 00:31:43 -0700
> Danny Lin <danny@kdrag0n.dev> wrote:
> 
>> EditorConfig is a standard for defining basic editor configuration in
>> projects. There is support available for 47 code editors as of writing,
>> including both built-in and extension support. Many notable projects
>> have adopted the standard already, including zsh, htop, and qemu.
>>
>> While this isn't a full-fledged C code style specifier, it does set some
>> basic ground rules that make it more convenient for contributors to use
>> any editor of their choice and not have to worry about indentation, line
>> endings, encoding, final newlines, etc. This should make it
>> significantly easier to conform to the kernel's general code style when
>> used in combination with clang-format.
>>
>> For more information, check the official EditorConfig website:
>> https://editorconfig.org/
>>
>> Signed-off-by: Danny Lin <danny@kdrag0n.dev>
>> ---
> 
> So I worry a bit that not everybody will welcome the addition of a dotfile
> that may be magically interpreted by their editor.

I would suppose that one would have to enable editorconfig support
explicitly in one's editor, so this would have no effect for people that
haven't done so (though there are almost certainly exceptions).

> I also worry that the
> file itself could become a battleground for people wanting to argue about
> style issues.

I don't think so, not any more than the coding-style document is, and
that seems to be pretty solid (but as doc maintainer, you'd know better).

> 
> Perhaps I worry a bit too much...?

As someone who regularly needs to submit patches to random upstream
projects to fix bugs or implement minor features, I for one would really
welcome more widespread use of editorconfig. While I mostly work with
the linux kernel (and other projects using the same C style), so my
default C style setting is "linux", even for the kernel this would be
helpful to me when I poke around in none-C files (shell scripts, for
example).

Rasmus
