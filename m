Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D39D42EFEA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 13:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238545AbhJOLsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 07:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbhJOLsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 07:48:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A967C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 04:46:05 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y15so40560350lfk.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 04:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kb1x9tsGXaYeNovFWGdEXry3yHSkE+lL9wmnxYr/M0g=;
        b=Bq4tlA+uaiVDOAMaQlhWb6N1uJGXs0377YAXJi+mSLJBdZP7u2gejSataJoCZ8f4pc
         MnZSVOVGrtxx0rudmcxPom5LsH6e49Ev6XAs2VB50w1QVnr9gmraFdv3o5d7k39Qw08K
         6htYVsZR65vgZJtlMn2TwQ9VpI2v2zKOxmL8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kb1x9tsGXaYeNovFWGdEXry3yHSkE+lL9wmnxYr/M0g=;
        b=Vk7G3p8pee3o6QEx0PgaPImgT+X4wXtzSbwvdpgarOsbBuoQks+0kUlb0ZG5IfwWIm
         maPeVVq8parf1Pw8nr6p6KbN+iG5iLn0hm7lGS8FDBkdZXyxuJOLO4vNP8WQVwL/4QMN
         URuPY1qbeREC+25vaQbAXyl4nEKlxH5YMh/nwtRr7CB0DPsaYJ93nSIXzEDPsW1+g/87
         epLzQfyDIakIuqHengNkyayvfZoxW9TdHN2qAzaCpX/kmTydL9Ize4qa4mIvowQPjhKK
         HrQfLQG50jbJdaJEQvhTAUaKnIniA5F82MWrhbFDf9GdVENSFuOyzveJfwQU4TEcaJMP
         Nz+w==
X-Gm-Message-State: AOAM532S0jsxAPklktGPZk9ksp3kxeTmEQDijP4s75moGrqHCrUyZjAZ
        nagkblqq0n8xXVhtEbn3p4NHR8mUmbhJ88+F
X-Google-Smtp-Source: ABdhPJwpADafh9MgvOGIeqy5I8FHUrijOCDNksaupBgbhvEfjlLDsHXebD1WiTooMAfl+zWM9xhMaQ==
X-Received: by 2002:a05:6512:118a:: with SMTP id g10mr11924978lfr.662.1634298363790;
        Fri, 15 Oct 2021 04:46:03 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id s17sm526594lfe.10.2021.10.15.04.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 04:46:03 -0700 (PDT)
Subject: Re: [PATCH] linux/container_of.h: switch to static_assert
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     akpm@linux-foundation.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
References: <20211015090530.2774079-1-linux@rasmusvillemoes.dk>
 <YWl95fZ69qpECxqi@smile.fi.intel.com> <YWl+hQTa4Pd1A7zg@smile.fi.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <63cb6259-ea8e-46a8-63fc-d942c2225fcc@rasmusvillemoes.dk>
Date:   Fri, 15 Oct 2021 13:46:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YWl+hQTa4Pd1A7zg@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/2021 15.13, Andy Shevchenko wrote:

> Btw, shouldn't we also remove build_bug.h in the container_of.h with this?
> (Or if this goes first, do we still need bug.h?)
> 

We absolutely need build_bug.h, as that is where static_assert is defined.

container_of.h doesn't include bug.h AFAICT, nor should it need to.

(We should still find a quiet place for __same_type and have
container_of include that header, but that's unrelated to this patch.)

Rasmus
