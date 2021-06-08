Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D953A057C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 23:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhFHVGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 17:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhFHVGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 17:06:46 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995A2C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 14:04:37 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d5-20020a17090ab305b02901675357c371so117387pjr.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 14:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PvyOvUvI785U/qpRDvpJIFwyWccIcKVL5z2hCAuLUNU=;
        b=HvEwF4sNujlx8OzDpldXk+IQO+SNNpx+K4P2SIt/YqB1gd6kRQnk3LJvJCXVWQU4D0
         onB+nJUGA9taNeiWJPqRUJ3AiBWE45Adzv58nsNaa4QTNOHPQCd3WH8fr6nw2KiOug7u
         rKqWFkRphcEdjRBQquFrR9k6PJF8n6trBpV6UUN0mEB3SZixybprg4FIf4WkxmTwfzVk
         4sA9ZbS+9Iatg6iDuTfBgIyyXcMx0+9FRimi8l1SKNp7wSEuWxSAwo0h9X+j5tBuvk4N
         wFEqFXjkjlGdUL3iSGL/UkYSkIou4OhJUk+m4ior9qRi9vcMS6sw73xvAK2JuuRWpW5v
         750Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PvyOvUvI785U/qpRDvpJIFwyWccIcKVL5z2hCAuLUNU=;
        b=dxzkm5PLyWeEGjx7zNv0usR0g4DOGLddLOQd5vwKaPRhZjhpaOPGgABcYFZp6bZSHL
         ydTxJJY8HteyIo+yj+yELtg8UChAWHbY7/VzoSikpzYvm2MU2kogqPuwLnPMyjsJMCmV
         pNrnXsoIVJwvyq+LAKXNXa7Utd5voH9etc1rpl06CKMyq5qZ4rq2ffOovS9gY1uyLxBd
         DfaQgMy9WiNTrPHKnEr/MOnFxw7areU1w5Pk6UyYtqbdIAukuSPTGUZ5O4/Ky1YsQTl9
         gkO7tLXDJE3/J2r3Ov1WrLu6MlIwChK8aHhhn7A9ImD7J7AQLbcpoS2UGGd1y+A0LTwd
         vubg==
X-Gm-Message-State: AOAM533lY6/Cpz+SDH5j0w0DSRBwjaTPk9qWVbNXV8W/L9zjIvut1m7z
        yUFi5mfrHDah0p9mC4pIwEFl3w==
X-Google-Smtp-Source: ABdhPJyn7nt9+WHxI2BzrNERrluNVAP/em4T2g9rucG5fW7XQOQ0hi0aIT9IxlKo9nNzPFmV7tb9sg==
X-Received: by 2002:a17:90a:8c14:: with SMTP id a20mr27714031pjo.167.1623186277024;
        Tue, 08 Jun 2021 14:04:37 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id s13sm6734111pgi.36.2021.06.08.14.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 14:04:36 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Use libata platform drivers to replace deprecated
 m68k IDE drivers
To:     Christoph Hellwig <hch@infradead.org>,
        Finn Thain <fthain@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "David S. Miller" <davem@davemloft.net>,
        Joshua Thompson <funaho@jurai.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Richard Zidlicky <rz@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>
References: <cover.1623131194.git.fthain@linux-m68k.org>
 <YL+AqIEPjMgG519L@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d3c70f7a-368a-ad9a-6575-8289234b0ce0@kernel.dk>
Date:   Tue, 8 Jun 2021 15:04:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YL+AqIEPjMgG519L@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/21 8:37 AM, Christoph Hellwig wrote:
> On Tue, Jun 08, 2021 at 03:46:34PM +1000, Finn Thain wrote:
>> This patch series allows m68k platforms to switch from deprecated IDE
>> drivers to libata drivers.
> 
> Thanks, this looks good to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Jens, any chance you could pick this up quickly to prepare for the
> legacy IDE removal series?

I can, but had assumed it'd go through the IDE tree. But not that
important I guess. I've queued it up for now.

-- 
Jens Axboe

