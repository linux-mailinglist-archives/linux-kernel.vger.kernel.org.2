Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4AE03D8C44
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 12:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbhG1KyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 06:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbhG1KyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 06:54:23 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29B6C061765
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 03:54:21 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id l17so2575756ljn.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 03:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y7BSRF2BV2wKYMpkMU6AInonSJrtXWVBGV0wA+UfcSQ=;
        b=HvxZxKORsgd1u77vvKkzSHVmzDZnFgdXGSifvV+HmSIPnClkA6lYo7Qz7nvYlLjejZ
         PK9B0U1dzVIDM4JKLg5sSHucPcc5bP4ZeDpjmSTAFJSiF4x48AfpDxMdOGxhIAJqc77U
         oc7qawDYmcTBtp40SM72ZiIXxtcm1lp5rspVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y7BSRF2BV2wKYMpkMU6AInonSJrtXWVBGV0wA+UfcSQ=;
        b=nGPQxRaKG3Rw44pSgcrTP8zVU6iW+Jzj6hIRbqBl2+bgrPXX2/c+bShrrTGlpArf0z
         qQvwEM3yFuaJtNld0y3jKnChLHLoBBUrYZwmsKXifpQAOCJBV4fc0BvgK4Zk7wXkduNC
         OOQH4AdXEHrbIe8vwsLiw/wDMUlK22R9O1lIN2lHGgAqDz13M/CBI8cl7qO8r2dHP2In
         hA7JKy/C/MwJ3DqWpuZ/2TSR1qvBdxcotVykYEd0VFwJnBQM1FlN1ZOWokI4pYWPBvSt
         SeOa6xXHiLt2HMXSFfyVN7D6zuMovV3CVXs9NFkzd9KqFIGbNK1Ohh2EidbE/Rz7BXjn
         AlFQ==
X-Gm-Message-State: AOAM5327SWvOs2S0zutn3tK7/kNCUogABNOJbIkDNY1xRjZ3Ute/TuCA
        XTaO02xWlMWw3peIDES1MLe/pw==
X-Google-Smtp-Source: ABdhPJzsNcjtwcC6XUZJ5ZJ1M5kI8nrl9w1bOGQ6hWCdCY07r8K6xPGQ9TuYLQLsRgK+FjENio3Z4w==
X-Received: by 2002:a05:651c:1144:: with SMTP id h4mr18097576ljo.396.1627469659652;
        Wed, 28 Jul 2021 03:54:19 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o1sm555702lfk.298.2021.07.28.03.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 03:54:19 -0700 (PDT)
Subject: Re: [PATCH 04/64] stddef: Introduce struct_group() helper macro
To:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc:     Keith Packard <keithpac@amazon.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20210727205855.411487-1-keescook@chromium.org>
 <20210727205855.411487-5-keescook@chromium.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <41183a98-bdb9-4ad6-7eab-5a7292a6df84@rasmusvillemoes.dk>
Date:   Wed, 28 Jul 2021 12:54:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210727205855.411487-5-keescook@chromium.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2021 22.57, Kees Cook wrote:

> In order to have a regular programmatic way to describe a struct
> region that can be used for references and sizing, can be examined for
> bounds checking, avoids forcing the use of intermediate identifiers,
> and avoids polluting the global namespace, introduce the struct_group()
> macro. This macro wraps the member declarations to create an anonymous
> union of an anonymous struct (no intermediate name) and a named struct
> (for references and sizing):
> 
> 	struct foo {
> 		int one;
> 		struct_group(thing,
> 			int two,
> 			int three,
> 		);
> 		int four;
> 	};

That example won't compile, the commas after two and three should be
semicolons.

And your implementation relies on MEMBERS not containing any comma
tokens, but as

  int a, b, c, d;

is a valid way to declare multiple members, consider making MEMBERS
variadic

#define struct_group(NAME, MEMBERS...)

to have it slurp up every subsequent argument and make that work.

> 
> Co-developed-by: Keith Packard <keithpac@amazon.com>
> Signed-off-by: Keith Packard <keithpac@amazon.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/stddef.h | 34 ++++++++++++++++++++++++++++++++++

Bikeshedding a bit, but do we need to add 34 lines that need to be
preprocessed to virtually each and every translation unit [as opposed to
adding a struct_group.h header]? Oh well, you need it for struct
skbuff.h, so it would be pulled in by a lot regardless :(

Rasmus
