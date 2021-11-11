Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D68A44D685
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 13:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbhKKMYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 07:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhKKMYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 07:24:06 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79F3C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 04:21:17 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id t19so11294554oij.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 04:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XNCNosYC3u6u2Mjz7khzOIp97EFpsZKMODemK/MK/ZI=;
        b=AXMpIhK/6muumVJud8eHYw6MxUOfdBCuofMOaTKVf6BVuARJVXwn96pmLWIUAaHR94
         MX4P+DHduSzKQQG+4hgdOxGWiH0bkBLa5Ax2d0mSfh8XPOP2AW8+6eO552Nhjgs+V+Gl
         puOv+fA2is+iLY2tZlfChJCNL3zSXYbN2AXWQtGgF3zxarLAO9xGv3JmdBrwG1vG4j1Y
         1cUuWWjukz6hdgOmEBn4COHL9UW2mURMxiWOD8mFid+62uClLy6s35v6nryxVeI4eCT7
         T8zVrAqJSktwbSpMDRl3RKn8HguyvsCqhCbS1mXJshs6AY1wLXrcE8OfoJkFf03nueKj
         21UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XNCNosYC3u6u2Mjz7khzOIp97EFpsZKMODemK/MK/ZI=;
        b=N+KIecFt9NlB5EbdHI5zWksJQyl/pqNecNJlLZ8wcP9Q9Mg0rYAeF9Dzxzo6a9eX+S
         jSAXdf9vdD3lwlMY+4EDvrjHjJ1dbODnGmAtfrHlFwsGW7qAZuznQzno6PBhDWPSIBz+
         GvR/vJJSdpBcLKZLLKP818dsK4sQNivBaHOCPkJxi10Ky3m2SHClDFPxzSgQuEoYlONr
         kC3cez7ZFIHZW8i3+/5+ROsffaM/XD3K9SEoq9GSdPXhfPrgAa94liqHdfnVS4zhamC4
         JAtKk9NY7TUrrcEVFR+00+TGzBPrut+FDQdPFv+ub7B5qSoIhV4yxcelBeGjS/F5k1fO
         kKLw==
X-Gm-Message-State: AOAM5326fHAIfw5TeunmpkBMNxYRdsSO3+GwgX+iFt8JqJz60P6T0MNo
        bJ9Sql8KNXH5IRD5gHRz9fDOg0AWFRmqpa2gMXtY8+6pO7Y=
X-Google-Smtp-Source: ABdhPJxPC+xhOyBF+tcDC+eGVh8fZqAT5jd7ubOPAfbG1qB1LsVtNZ9jo6CnbTauWP/IUdBWzbWnLLAjal/SmsNZOKc=
X-Received: by 2002:aca:a989:: with SMTP id s131mr6048527oie.71.1636633277302;
 Thu, 11 Nov 2021 04:21:17 -0800 (PST)
MIME-Version: 1.0
References: <20211111084617.6746-1-ajaygargnsit@gmail.com> <6864f744-ca3e-f328-8793-2adb0146db03@bytedance.com>
 <CAHP4M8VNZY+NLzUAVHTWK6a6pggvv4a-q9nvYAqkkco6id3Tog@mail.gmail.com> <CAMZfGtXCFJ3NUw-bBsphLbCtdDAfHERAEkTSMU9k1cfd4DrRMA@mail.gmail.com>
In-Reply-To: <CAMZfGtXCFJ3NUw-bBsphLbCtdDAfHERAEkTSMU9k1cfd4DrRMA@mail.gmail.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Thu, 11 Nov 2021 17:51:05 +0530
Message-ID: <CAHP4M8UY0F3gx0eVYGKHfcoN-=f6ApT0CjA3xsZRrb3HVphK6A@mail.gmail.com>
Subject: Re: [PATCH] mm: shmem: do not call PageHWPoison on a ERR-page
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> What? I put "if (PageHWPoison(page))" into the else branch,
> it should be added braces since it's not 1-line blocks.

Oh, ok.

> Why do
> you think it does not address the issue? What am I missing
> here?

That might work, however I haven't tested it.

Upto the reviewers to see what they see as the best way going forward.



Thanks and Regards,
Ajay
