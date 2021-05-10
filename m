Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AC2378173
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhEJK0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhEJKZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:25:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5808FC061763
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:24:32 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d11so16015762wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6qT6M6ncipCt/7pPJOS0xmck1g2J13iYmtTOxl1Xuos=;
        b=f/dGRHyj5BIKadY6degO/5EKNGsTacO8jsgMxx9ckDzDgeJn7fEu9AIW+EMqMWwU6t
         26OZxhHnWZ03QaxGTQsNiAw+QLjH4uX0atqp4tfCC5UmzavWLUbsgDdd7GoMHvR5v1cA
         LNV1tctfP+XdOiBxUdYQwlkxfGTGxXfwbINIho+dCGNgij0rAXjsxpDJSW1iuA+0uyL+
         j60POf94ylWBPvC1/65EiPAAaxNdUmc5kQ8+4PgFmX0EW8qDNFsgGxvD7Od0jvodpV7x
         lWLCtLdZONS5rEJ0Dvi0nXDlpVpE4suHM2cXa/BvKpYVRHVpubruTaugJnMQKj66UWjV
         qBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6qT6M6ncipCt/7pPJOS0xmck1g2J13iYmtTOxl1Xuos=;
        b=hNIplz3mcaWmhKMig1LtBEL5lF0mgA7ar/dMpefCH7JiSmOjMK/QfwvJ/4eupfALJB
         hxeHL7r/TGSgx68nfPybK5IpwoK3PfLGX7YpqWIRX46+xqO7sl8Vjkm0vLhIloupbpjT
         V79m4GxFZTROPqjb6mas+kKuVflTNxohkhNascLjJKRwID8R5+7x7PwUrXKoOrW8WDMp
         GXOrHj9uUSlqC8W5F0MAKAHCjpJO6MZZiWypUJ6p5bJkQfZwdexJhBNLy72M+4Z0WVGD
         VlxWNP5pXNPlTXa9tgalTV7TV5yTY9oQhgC/VsDf+ic3WejDjtdByxMj43gaRIMHQlgw
         nWxw==
X-Gm-Message-State: AOAM532cmz9mLzb2fxzMkDk8loHR/puvZarVQgHsneJjyGOMvc2/sVXW
        jNG/xGJ3waAY1M1MmXFUm3UHnhIh+FHaCA==
X-Google-Smtp-Source: ABdhPJzLG/1exw2EEssR0ArrxHqcDvCjJ1jBbOMf8L95Zrcxydi6iFtPRDMtTw13l3JUT6x9N9kiPA==
X-Received: by 2002:a5d:6811:: with SMTP id w17mr30283903wru.348.1620642270939;
        Mon, 10 May 2021 03:24:30 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id k6sm24748677wmi.42.2021.05.10.03.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 03:24:30 -0700 (PDT)
Date:   Mon, 10 May 2021 10:24:27 +0000
From:   Quentin Perret <qperret@google.com>
To:     gregkh@linuxfoundation.org, masahiroy@kernel.org
Cc:     linux-kernel@vger.kernel.org, maennich@google.com,
        gprocida@google.com, kernel-team@android.com
Subject: Re: [PATCH] export: Make CRCs robust to symbol trimming
Message-ID: <YJkJ21n71SIkUppu@google.com>
References: <20210408180105.2496212-1-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408180105.2496212-1-qperret@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 08 Apr 2021 at 18:01:05 (+0000), Quentin Perret wrote:
> The CRC calculation done by genksyms is triggered when the parser hits
> EXPORT_SYMBOL*() macros. At this point, genksyms recursively expands the
> types, and uses that as the input for the CRC calculation. In the case
> of forward-declared structs, the type expands to 'UNKNOWN'. Next, the
> result of the expansion of each type is cached, and is re-used when/if
> the same type is seen again for another exported symbol in the file.
> 
> Unfortunately, this can cause CRC 'stability' issues when a struct
> definition becomes visible in the middle of a C file. For example, let's
> assume code with the following pattern:
> 
>     struct foo;
> 
>     int bar(struct foo *arg)
>     {
> 	/* Do work ... */
>     }
>     EXPORT_SYMBOL_GPL(bar);
> 
>     /* This contains struct foo's definition */
>     #include "foo.h"
> 
>     int baz(struct foo *arg)
>     {
> 	/* Do more work ... */
>     }
>     EXPORT_SYMBOL_GPL(baz);
> 
> Here, baz's CRC will be computed using the expansion of struct foo that
> was cached after bar's CRC calculation ('UNKOWN' here). But if
> EXPORT_SYMBOL_GPL(bar) is removed from the file (because of e.g. symbol
> trimming using CONFIG_TRIM_UNUSED_KSYMS), struct foo will be expanded
> late, during baz's CRC calculation, which now has visibility over the
> full struct definition, hence resulting in a different CRC for baz.
> 
> This can cause annoying issues for distro kernel (such as the Android
> Generic Kernel Image) which use CONFIG_UNUSED_KSYMS_WHITELIST. Indeed,
> as per the above, adding a symbol to the whitelist can change the CRC of
> symbols that are already kept exported. As such, modules built against a
> kernel with a trimmed ABI may not load against the same kernel built
> with an extended whitelist, even though they are still strictly binary
> compatible. While rebuilding the modules would obviously solve the
> issue, I believe this classifies as an odd genksyms corner case, and it
> gets in the way of kernel updates in the GKI context.
> 
> To work around the issue, make sure to keep issuing the
> __GENKSYMS_EXPORT_SYMBOL macros for all trimmed symbols, hence making
> the genksyms parsing insensitive to symbol trimming.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>

Gentle ping.

Is there anything else I should do in this one?

Thanks,
Quentin
