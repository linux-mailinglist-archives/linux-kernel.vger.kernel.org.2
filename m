Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2DF39DD0B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhFGM4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 08:56:53 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:39518 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhFGM4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:56:48 -0400
Received: by mail-qk1-f169.google.com with SMTP id j184so16460614qkd.6;
        Mon, 07 Jun 2021 05:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qAToXXWSsZRmYBJ4nyR6Lux62WzTeaa9/cBKzieftKI=;
        b=au+TNadT6IgMd1oXL+D7zeOnc6/yuE4DPTjMApcvNIcqgZRuT7Vp+g0z2ufp1TDWc+
         wvVb/zRdE8t5IE2/FnCH8KxWclGjrjeLhbjPQRzuJ6INjiye873OGzHBxW8AqToB8bjT
         dVYsZBOgFpQ8V78wszy7o0MN5Y4D9U19p7VRrjq2h+IZWuodqNVR2t8urplHigaW59AD
         3UVyn8q1AGzCzdve0py1q0dYBUql5h6wHupmnU0X0pplyv2MLolmcoT7wtBCLZlf59vi
         sQ4+EQQipeYbidVq7vbqhXBVBYq+k/WP/6u3aJ2BKQ7WEFvnSas/SRV0GSriMhr+K0hu
         kKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qAToXXWSsZRmYBJ4nyR6Lux62WzTeaa9/cBKzieftKI=;
        b=J7ncJcCjiSudVp6DVvam9lbjCMoMk3Kiitr4GeIC0lHFre+UzuWizfsfjPG99Isjay
         80aVd3dcNwGPW9N4kFZ7aC5ayi66EV6secn1S8PAJ4fFAcgWjIKqSUgfNg8obwIcoFU6
         Bcd4FIWCZtsqxRNfFaT8cjWLWV5NQrQI4Ti4gWJpZDcf27b7mLr+9XuarFG4lPrFTa3O
         kG9A257JaNtqUQ68JpQuo3UNPf1V0qrW1RhJsMdRW32G28TJfyLt1tGMVzunxHxA4S2U
         rIFgfoo4jtRoaEuWYdNbaTQl3HSB9gyjtzd+2P3K9oyjJv5KYP78z8T6gXIQFijHZbaz
         41vw==
X-Gm-Message-State: AOAM530v2fATbxN7XQcZCuIqhj/GYOTWC+RRdzV68h3zPbyAbn1lrlXm
        IwGQfRCqGyEnLFGkZhh+279endFxZHE=
X-Google-Smtp-Source: ABdhPJx34do1IiN9AnqGLoDcBWhClEhKt0gtpUg/3h2DFY6MvKz0+WSGeMs+ma9D6h7hsGVzCj8JjA==
X-Received: by 2002:a37:6007:: with SMTP id u7mr10020504qkb.427.1623070437169;
        Mon, 07 Jun 2021 05:53:57 -0700 (PDT)
Received: from ?IPv6:2804:14c:125:811b::1004? ([2804:14c:125:811b::1004])
        by smtp.gmail.com with ESMTPSA id e11sm9650489qkl.28.2021.06.07.05.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 05:53:56 -0700 (PDT)
Subject: Re: [PATCH v3] docs: Convert the Speakup guide to rst
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>, corbet@lwn.net,
        jani.nikula@linux.intel.com, gene@collinsnet.net,
        w.d.hubbs@gmail.com, steve.holmes88@gmail.com,
        speakup@linux-speakup.org, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        chris@the-brannons.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210603145953.10982-1-igormtorrente@gmail.com>
 <20210606123135.idvji5rbvcc5lrai@begin>
From:   Igor Torrente <igormtorrente@gmail.com>
Message-ID: <0245b87e-2ac1-20e7-b8f5-0fce7cd7bdd1@gmail.com>
Date:   Mon, 7 Jun 2021 09:53:52 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210606123135.idvji5rbvcc5lrai@begin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

On 6/6/21 9:31 AM, Samuel Thibault wrote:
> Igor Matheus Andrade Torrente, le jeu. 03 juin 2021 11:59:53 -0300, a ecrit:
>> @@ -0,0 +1,1421 @@
>> +.. SPDX-License-Identifier: GPL-2.0
> 
> People have agreed to dual-licence GFDL and GPL, not only publish under
> GPL. So

Ohh, sorry. I misunderstood the licensing proposal.

> 
> .. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.2-no-invariants-or-later
> 

I will fix it.

> Samuel
> 

Thanks,
---
Igor M. A. Torrente
