Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3D040EEA6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 03:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242100AbhIQBOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 21:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhIQBOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 21:14:18 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1ABC061764
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 18:12:57 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id b10so10185759ioq.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 18:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=COgu+Smzr2YqzR6tkm3PXZN/dACB/9XYE3hlM4YA6dw=;
        b=cV4WEVACT1XlzzF99FIFhp8x5uYBhSgMe7jqweUbWVmc1Ry9Tr/CEjKSNdLYNE3aqG
         AgovWF3HfeOjv/aLlDvNZe2sMbZaUhQCbPK7KKdNi3Pkp2jiJWLlg/QrBiyLBU1yWKCl
         we25+Dwpx+oGwkkPGprDKrERAXzmTjbmaY6esh8vk7xKKBvTgkA+ql7KCPJ5U9sGUzW9
         STNUpFpQ5OSqzlwTEZnRUJU/gvDdpAXCfJLZg0noYSkNHx2A0medx5FSSDcR198qtrF+
         MNs/du/6gPDaqPw2Qm9kWpIddxIVyXH69lrR4DMgpCMGhfBQ8iWtBZIhJ9ScJXkwB6Un
         tKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=COgu+Smzr2YqzR6tkm3PXZN/dACB/9XYE3hlM4YA6dw=;
        b=FnIj5ozeJD9JmWJboo1SQ/9lFGTA7I8d2Lzhq1Z1uj2PR/j6tKmkJZ78DpGTjFUcGe
         z5FbRd8S9DtycW6qtqmgmUzJBdbstmXT/lRhbvWSWL8qbHms41d0KZ+bLTQ2RM8eGMCZ
         rWQsqU+9rz4kvQ/ROLunY9uw4ggJRKH6WNb6pUq22dwdgI1f8VIHks6UDqwwmkpMzwOc
         w7f3H0KzODdWxuMdaMlznzrmTOFYeY2lS6Dz0jJkK6/utyZvrOWrpS0TKvDN+QOM3veE
         AwwRjOSNw7/T8dVz8oefOnN3MNyCZpjGm7BDxV/jfvwCTyn4FqSi0Boa9EU15kzySBvT
         AxZw==
X-Gm-Message-State: AOAM5303ZAUc3a1OnKT6/2Y09gpqfY22Kc6RwrkTzPbSdd/qMj3g0kH3
        JBiClXJ3KDPDK+vZiOh45qSGJYLd1+lJBg==
X-Google-Smtp-Source: ABdhPJy9lqKWDc2vVJ1gP4OMkSbqb54JEPrZrf+SC60tX+YO99loypj7WK7n8H+TA7khKxnjc+uaTQ==
X-Received: by 2002:a5e:a70c:: with SMTP id b12mr6478854iod.119.1631841176222;
        Thu, 16 Sep 2021 18:12:56 -0700 (PDT)
Received: from [192.168.5.221] ([172.58.140.85])
        by smtp.gmail.com with ESMTPSA id x16sm2561006ile.63.2021.09.16.18.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 18:12:55 -0700 (PDT)
Subject: Re: [PATCH] sh: pgtable-3level: Fix cast to pointer from integer of
 different size
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Daniel Palmer <daniel@0x0f.com>, linux-sh@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <2c2eef3c9a2f57e5609100a4864715ccf253d30f.1631713483.git.geert+renesas@glider.be>
From:   Rob Landley <rob@landley.net>
Message-ID: <1acace03-4273-a5ad-50b4-5ab8e3baa551@landley.net>
Date:   Thu, 16 Sep 2021 20:32:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <2c2eef3c9a2f57e5609100a4864715ccf253d30f.1631713483.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/21 8:50 AM, Geert Uytterhoeven wrote:
>     arch/sh/include/asm/pgtable-3level.h:37:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
...
> The truncation to "unsigned long" has been there since forever, so
> probably it still works fine ;-)

1) Linux is LP64 so sizeof(long) and sizeof(pointer) always match, so it's not
truncating.

2) The sh5 only ever shipped evaluation units, it never had a production run,
and we haven't implemented j64 yet, so all superh targets are currently 32 bit.
(I.E. it's complaining about _expanding_ the pointer, which shouldn't be a
problem as long as endianness is respected.)

Rob
