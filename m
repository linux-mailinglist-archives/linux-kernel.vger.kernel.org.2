Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8943BBA67
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 11:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhGEJn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 05:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhGEJn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:43:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9D0C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 02:41:19 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p17-20020a17090b0111b02901723ab8d11fso11467580pjz.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 02:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p6TZn0pkcrohcFlzQ6B5a1UXee/0wUIqAanNPpbpYxY=;
        b=uw1MTYYdbcLOELgs2jigWYEeV1o8X6Ol1GQ0tTEFDy1ioqGaj+151xmsO2EZ35+NQj
         UUurQPGY5Hm7h6uYIOLK+sz1XG0WK4pIlHWkSoEmm7CUGQPvp9OV73fsXBxKUOywW5TO
         kht4kSFJxdwNCkkULth6ftnfe0wX1ZPQUv61LR3poblw0FUbpSSkO02gdoYJd7kIrOuq
         ghuDu+WAnY+jS3poWdCNdSPCpSiHOTuDiEQVvKiR6+nHKoiVA1QxZ4gYcazPNmBe85Vj
         aIWcSCVO6wbp/PXGjqPidGVmlmRxtM7nFv8QmZzLmKcHxVjigiuJTisM7EKrwkV77LVj
         JLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p6TZn0pkcrohcFlzQ6B5a1UXee/0wUIqAanNPpbpYxY=;
        b=tLq0K/aCL4SyS2B6BFCxWn8qbO2+dLocSrG9GZt8HIaHazRoSG6mWlMzkGlzQKp5XY
         GaZVFMBTavkKaLuns3WjwO9KIRGOlz7EzMnk9OwmJiqB0c5UetAEf8ih60eAqaDcmEV1
         viFC/gOjukkqdnm1v17THsJAQPbOZzcd5h6bgoqL4TyTy5Ngv8Xp/i1i04qZmUcbeZP4
         SPItM/lhliVXeqABABN9mun9PlYupJMwjSOo3pIdAMkfO3rV4j4lHbbUvCwn40j+7ckk
         1OXpNe/1jiWcIqM+8fqqP6qW/T5CQUhrh16wxWBIjDloAjAP4pCS+3KQejuNfsaJWqZC
         yDGg==
X-Gm-Message-State: AOAM531EYldj3LVSt9IwQTrtsG1Vha7xY+YIwk0joF+p91nMqGP8nDik
        HPaWXoDiGySMD+49ikzAkLepiA==
X-Google-Smtp-Source: ABdhPJzjxeYwiQ48kETRpE7tMsMr3QlzW/XaT/X4Z+Cp/UJKBtL3paBM0nQfK91MoPQnH0Hv9Tu9WQ==
X-Received: by 2002:a17:90b:3ec7:: with SMTP id rm7mr14629902pjb.214.1625478079109;
        Mon, 05 Jul 2021 02:41:19 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id a15sm12283460pff.128.2021.07.05.02.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 02:41:18 -0700 (PDT)
Date:   Mon, 5 Jul 2021 15:11:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jie Deng <jie.deng@intel.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jason Wang <jasowang@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        yu1.wang@intel.com, shuo.a.liu@intel.com, conghui.chen@intel.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v13] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210705094116.mxzi262n4tpmcjgm@vireshk-i7>
References: <8908f35a741e25a630d521e1012494e67d31ea64.1625466616.git.jie.deng@intel.com>
 <20210705080245.yabjlrgje5l7vndt@vireshk-i7>
 <CAHp75Vf0_8+KW_cp2g0V1miMx1cegBdjLzBjTbtpmcmdCHQJxA@mail.gmail.com>
 <20210705085610.okcvnhwhwehjiehy@vireshk-i7>
 <CAHp75VeE4Du29XJV54VWR4CH4yfCEqokRUFFRY_sdMKsp1oXyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeE4Du29XJV54VWR4CH4yfCEqokRUFFRY_sdMKsp1oXyQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-07-21, 12:38, Andy Shevchenko wrote:
> Because we do not have "uapi" in the path in /usr/include on the real
> system where the linux-headers (or kernel-headers) package is
> installed.
> 
> It's still possible that our installation hooks will remove that
> "uapi" from the headers, but I think it makes things too complicated.

Ahh, right. Yeah, I completely missed that part.

-- 
viresh
