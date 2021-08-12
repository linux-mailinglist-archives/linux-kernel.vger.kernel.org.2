Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98C93EA6E9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 16:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237063AbhHLOzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 10:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbhHLOzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 10:55:17 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00794C061756;
        Thu, 12 Aug 2021 07:54:52 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id f3so7628287plg.3;
        Thu, 12 Aug 2021 07:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tgibRt/f2wKyoNLTLvlZ+dzkEGWoJp3j8yuDZzswzZo=;
        b=PVZxFaAmy+kRuU/S6JZNFIBLkMi3hW1r9cBQc8K41XtgvQqQvRMDuL/sngQQ/a64hg
         TchRh8DGyA75NokGldnlLey7vC6T57hL1AXRp2ok3QHjKYWjHK2ZitDUx2ZfRIzSRt2z
         T/hnIM0CiTIkoOVU+59EmxSEGztcdcs5h11NLSwmcJpXwN7xgkMsZHkgK0/+3GiO+qol
         GRuBz+JD4HVLx1ZwNb1tqNfoIKHTxWRHM7qZMr7Jfp0NQpEwCawuzGeKPsx1efWR2Kso
         JMKXnkqxiFgHz6Jz6U7rH6/o4bPXIKT08zwTuXQbJZzVWM9w1NxVuNoczMVJdUAQ2lmY
         avBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tgibRt/f2wKyoNLTLvlZ+dzkEGWoJp3j8yuDZzswzZo=;
        b=Ky3wEXn0GTwY8wBRhnn+zsKo/7USz2BaU5PnmY0FVagR80zJOdWo8/J4TjsQP8Rkll
         5nj5eCo1W/A3l7MM6OJ4K0smCvr2QITt0a6sKZbgjbVW4JHyypjOa22r6+0X9ACjBcUu
         NkZrdp3q3GwgwtY8/KXdF7Q82hG/ZfZtatV81/9gW2hdq0joAnYdzBf00RqbklGiFInx
         Jq5+JmvO2Spw3zEeCoLOLA15psV+F9dOwSYigSnZCVGJ8fxvH8WpOKwwrpsHdW10zaq3
         LvwauzLCp33cECnNR+8wN1ZIpH0HW2nMR8V4qwCUUsO8+B+u8WlepasztS8hNxq+tYJG
         PE5A==
X-Gm-Message-State: AOAM5313s7bl6PBXuWmoRojHGiI3tuWKH/xumpilf7VtKOVQ97z/ea3Y
        GqnihIB26jR9qEPS5sAKnmn01QLL7wM=
X-Google-Smtp-Source: ABdhPJwNeeLBE+F9muHtmv5dhB3UpLqDXSfzOIlRqp9fXWhlZmQPPOv4QaJxK1sMZ1rGXlKVGL/8JA==
X-Received: by 2002:a17:90a:d686:: with SMTP id x6mr4716140pju.227.1628780091439;
        Thu, 12 Aug 2021 07:54:51 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id t5sm3513799pfd.133.2021.08.12.07.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 07:54:51 -0700 (PDT)
Subject: Re: [PATCH v3 6/9] docs: pdfdocs: One-half spacing for CJK
 translations
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <eb8184ab-cfab-680b-f180-1157a7f709b3@gmail.com>
 <a1c19fe1-2960-1c4b-b355-7e6da13b9630@gmail.com>
 <8e70e5ed-c0d9-a0f0-6640-a0f1ebdda6d4@gmail.com>
 <87im0a207r.fsf@meer.lwn.net>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <af64d80c-c1f7-7d32-9b28-e4b883dbe6e8@gmail.com>
Date:   Thu, 12 Aug 2021 23:54:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87im0a207r.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2021 08:42:48 -0600, Jonathan Corbet wrote:
> Akira Yokosawa <akiyks@gmail.com> writes:
> 
>> On Mon, 2 Aug 2021 18:56:16 +0900, Akira Yokosawa wrote:
>>> CJK documents are much easier to read with a wider baseline stretch.
>>> Applying the onehalfspacing option of "setspace" package looks
>>> reasonable.
>>>
>>> Note: \usepackage{setspace} needs to be before that of hyperref in the
>>> preamble.  The 'extrapackages' key (available since Sphinx 2.3) is for
>>> this purpose.
>>
>> Sphinx versions < 2.3 ignore 'extrapackages' and generate LaTeX
>> sources without setspace package.
>> Obviously, building such LaTeX sources will end up in the error of:
>>
>>     ! Undefined control sequence.
>>     \kerneldocCJKoff ...exeCJKinactive \singlespacing
>>
>> Current requirement to build pdfdocs is Sphinx 2.4.4, but LaTeX
>> sources generated by 1.7.9 can at least be built prior to this change.
>>
>> Jon, Mauro, do you think this is a regression?
> 
> Having the build just fail that way isn't really a good thing...it would
> be far better to do the baseline tweaking only with versions of sphinx
> that support it or, failing that, to at least refuse to build with a
> suitably informative message.

Hi Jon,

This issue is fixed in v4 of the patch set.
Can you please consider pulling v4?

I have tested it against Sphinx versions 1.7.9, 2.4.4, and 4.1.2.

v4: https://lore.kernel.org/linux-doc/39d0fb0f-b248-bca4-2dac-df69e8d697b1@gmail.com/T/

        Thanks, Akira
 
> 
> Thanks,
> 
> jon
> 
