Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112313D5649
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhGZIfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbhGZIfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:35:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94097C061757;
        Mon, 26 Jul 2021 02:15:34 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a4-20020a17090aa504b0290176a0d2b67aso10354697pjq.2;
        Mon, 26 Jul 2021 02:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zs6AH0K1yxcjVhQIJzgvDOlFx1BtJHEutjltuHXdrIM=;
        b=E/1N2grUDWvVzyvF3S3mM97tdfIpp+QMwHwk/MAvarDWJpYX+LiufbNxO3DWU3BLOn
         LWYFVr73XIwRadqNzhsQM1awGDBK3kPtwDTKo1T44rXIBqWIj/xeQ6aRWtfmwvbG9Z7u
         HSCRo5250gXWasbBznBnrABmS6M5FI9TyE6owD2czrWML/bBibZAu8BfkDhsGKWD4ivN
         WA6Vs68YeUCKFPv+52aHO3/j04uvDCM3k82ZAQtspUxPFpdNDPjpvTQi8Oc/B00pJJkc
         LRYOxvcKBmSHb4A2VMzuTdZ/wOYUWDl6cXS8tTCZ2eqMUp47c+TrmYnSSLaAcQhNnst9
         e1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zs6AH0K1yxcjVhQIJzgvDOlFx1BtJHEutjltuHXdrIM=;
        b=R/J5nyhZpm52d7DRd8kFy9SeNpcqEIX5hEaof2S3/cJ6dW8dg9Devkt+Mgi7w3m7+N
         Wx0lpuJg+HC6XM8EvU6LcTvLt584dtSWCsc7ms4/q1N4mEOXKBzeYmXr4p/V6mWWUETj
         75txdgd21LVWJ5nQdRypIQzdY0401gpPq2+vdYYFsS1E4VFTgRiQ4i8JvJDRyGuMps+e
         BNmn/13zVQDsefLZ5xfn0st2RXK/ysNSP23JZBcy6qjJ1nNStG4uhs6isA6gy3E/E0wK
         veXukRaN+41M/ql9YAi1IeFaazDUraPmdrET7ibD1Km3KwEOIz/36f/1VrH9cSlikPAU
         ol3g==
X-Gm-Message-State: AOAM531mtD2Qu6OHQf5r3bAUVDjykmYjaVhXfktZRJXd88ufHUUKfQM+
        BfVQjcl/11wW6La6Co3sb3SQNkQ/0Zc=
X-Google-Smtp-Source: ABdhPJxfbL1x424R86tpM29aDBYfR96D8eT96rowFyR9X3Oqp8ohYJKCMZmn6QHfoAY3jfL23Bp1jg==
X-Received: by 2002:a63:1110:: with SMTP id g16mr16886929pgl.111.1627290934080;
        Mon, 26 Jul 2021 02:15:34 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id c7sm45572966pgq.22.2021.07.26.02.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 02:15:33 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/7] docs: pdfdocs: Improve font choice in CJK
 translations
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>
Cc:     Hu Haowen <src.res@email.cn>,
        Shinwoo Lee <shinwoo.lee.us@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20ff8a65-6a5c-c062-fe1a-0f5c5ddc813c@gmail.com>
 <875ywyunwp.fsf@meer.lwn.net>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <5bd79349-3103-7680-e6dd-e9c510d278e9@gmail.com>
Date:   Mon, 26 Jul 2021 18:15:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <875ywyunwp.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jul 2021 14:41:26 -0600, Jonathan Corbet wrote:
> Akira Yokosawa <akiyks@gmail.com> writes:
> 
>> Hi all,
>>
>> I'm calling this patch set "RFC PATCH v2", but the approach has changed
>> a lot since "RFC PATCH 0/3 docs: pdfdocs: Improve alignment of CJK
>> ascii-art" [1], hence the different title.
> 
> Given the RFC nature, I'm assuming you're not ready to have these
> applied yet.  Please do let me know when that changes...

Will do.

As mentioned in the cover letter:

> As for the to-be-merged zh_TW translations, the same approach should
> work by choosing "Noto xxxx CJK TC" fonts.

, I'll wait until the zh_TW translations are merged (hopefully in v6)
and update this patch set so that it can cover all of zh_CN, zh_TW,
ko_KR, and ja_JP translations.

My expectation was to collect a few "Tested-by:" and "Reviewed-by"
tags, but failed so far.

Especially, I think 6/7 and 7/7 need explicit acks.
In the cover-letter, I said:

> Mauro, isn't the header comment in conf.py added in Patch 6/7 good enough?
> I don't think those nice-to-have fonts are pre-reqs that should be
> taken care of by the sphinx-pre-install script.
> 
> On the other hand, as having heard of nothing from SeongJae, who is
> the maintainer of Korean memory-barrier.txt, there might be nobody
> who cares the Korean chapter in translations.pdf.
> Patches 6/7 and 7/7 need explicit Acks of someone who reads it, I guess.

Also, I'm thinking of splitting 2/7 into smaller chunks.
It (1) introduces LaTeX macros for each CJK language, (2) changes CJKmainfont
to Serif, (3) adds translations specific conf.py to localize monospace
font choice for Latin letters, and (4) restores inter-phrase spaces in
Korean translations.

        Thanks, Akira

> 
> Thanks,
> 
> jon
> 
