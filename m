Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE5437B4B0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 05:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhELDui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 23:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhELDuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 23:50:37 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12576C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 20:49:30 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id m190so17281062pga.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 20:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IzgGu9R0ARwDBsD+F2+JiW3x3zuHRQ4yrRZwYSnXu+o=;
        b=gBKUHOq8bXXc4gcmvChqsaFwzXmCzVaMbuxGaRF2zoU+2K9H8RWm99PIaivtkqwvbN
         9VWicYA33/yyz1ikMIL5uUDsNKBqrVc5xKHfNf/LCAKV2zULY5hdHnvpV0tJh7M8z9z/
         EpVCUCDWBdySe55vmMY/ducax5q8LvjK9PGwT0zfFFW7IRsuMV4hpZh8SVdothpAQcNk
         Iclsx/8GGQO9tqUqb7Z2b9OUCU5VcwhP6wac/gASXrinZZ0U/fkQpz/hconVGRTuhywk
         gAEJpKrDpnGq04SrJ1eJ84sBdqLVjTBegeTqAU/xW4dI7NfHVkUYsRmeQY7FSbbPTnfB
         6iwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IzgGu9R0ARwDBsD+F2+JiW3x3zuHRQ4yrRZwYSnXu+o=;
        b=f1YoeQaBf3lRh+x5DdW78oMAiWD++1AZM8YoEITLVGD4/TmCiXkyvXegEZXbv3gZtx
         qSN5VXIAoXFb+MjqyLdSETuGRRbpdHH4uBse8zY7KUqQEagAyQOCxQhfkgqTQ+n2ygza
         a6As/fNMMLISYuZbzQ85rqpcfzku5eMPefyTBzKrIbSo5AA1xXhrGh2zbD5IKmZyjgyQ
         B3OYTzpDcDyMP1YOHQnrdV1Mjvk8c072d/b7Y/om+d6BIiSSLppdD2W/fdNKrwlLYJP5
         aIiy/9CamKFR3vnrwbZx+cyGizsmixamFfhOfD9/Q06PBLliXG99bFojIs1glfX+SbEl
         gKog==
X-Gm-Message-State: AOAM5327e4U20GwqbkNGLVHX94t2kiC8dTHEuM/WK8foiOI+1hBeG6if
        Pne/x/dH7B56bZIIR+C7R3dUmw==
X-Google-Smtp-Source: ABdhPJxECYSxNbvtoCjLInxxaXIyELrqBbGqdhrt2f9UsjwHdNJpJRoX9OeikLS7FyqRho+D5sZ8NA==
X-Received: by 2002:aa7:864c:0:b029:2cd:558:dbb8 with SMTP id a12-20020aa7864c0000b02902cd0558dbb8mr2932500pfo.78.1620791369439;
        Tue, 11 May 2021 20:49:29 -0700 (PDT)
Received: from localhost (110-175-254-242.static.tpgi.com.au. [110.175.254.242])
        by smtp.gmail.com with UTF8SMTPSA id c6sm3225014pjs.11.2021.05.11.20.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 20:49:28 -0700 (PDT)
Message-ID: <80ae1561-ed8d-cf3a-f3bb-d89cd07bfc24@ozlabs.ru>
Date:   Wed, 12 May 2021 13:48:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:88.0) Gecko/20100101
 Thunderbird/88.0
Subject: Re: [PATCH kernel v2] powerpc/makefile: Do not redefine $(CPP) for
 preprocessor
Content-Language: en-US
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux@googlegroups.com, linuxppc-dev@lists.ozlabs.org
References: <20210511044812.267965-1-aik@ozlabs.ru>
 <20210511112019.GK10366@gate.crashing.org>
 <1795b9efa40.27bb.1ca38dd7e845b990cd13d431eb58563d@ozlabs.ru>
 <20210511231635.GR10366@gate.crashing.org>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <20210511231635.GR10366@gate.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/12/21 09:16, Segher Boessenkool wrote:
> On Tue, May 11, 2021 at 11:30:17PM +1000, Alexey Kardashevskiy wrote:
>>> In any case, please mention the reasoning (and the fact that you are
>>> removing these flags!) in the commit message.  Thanks!
>>
>> but i did mention this, the last paragraph... they are duplicated.
> 
> Oh!  I completely missed those few lines.  Sorry for that :-(

Well, I probably should have made it a separate patch anyway, I'll 
repost separately.


> To compensate a bit:
> 
>> It still puzzles me why we need -C
>> (preserve comments in the preprocessor output) flag here.
> 
> It is so that a human can look at the output and read it.  Comments are
> very significant to human readers :-)

I seriously doubt anyone ever read those :) I suspect this is to pull 
all the licenses in one place and do some checking but I did not dig deep.


-- 
Alexey
