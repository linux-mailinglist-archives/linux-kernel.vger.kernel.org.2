Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4303144DB65
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 18:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbhKKSCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 13:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhKKSCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 13:02:00 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC964C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 09:59:10 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id y16so7950896ioc.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 09:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9wdeu4qIC+yfREjKTiwyWvTzajt12tvZegHkKd/EMSg=;
        b=PuTaajKNYQTz2Sbid6HOloefAWWzFBkmQaweOFAzYi7kcu5mKEPIKjpQykn0aAtUSM
         AQqxcu6qBk8oNLhoOJrde2pG86tJwDZCw3xTJi1wznfaqu/3587+QXZ8xitbsbV9pQfI
         tiY41a4zwP4kr6aedG8OZ9ll0ZLa+NqxsvngnjVIuIrMI6KiBw4mU+U6rlPdDwDn8QE8
         4SJCOcR7ANbG62cf75MPM1Jdhu41RGfg6Ftt1YIvwneAWgpb1R260ao0C8nmkbB9hC9/
         rFZdaZr443oAkk1jeBFquU+J7rosgxHeyWU5Iht/eEfomqngUqouQTfxC9ZBbT7nRZIy
         Cqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9wdeu4qIC+yfREjKTiwyWvTzajt12tvZegHkKd/EMSg=;
        b=YumbZPxWUQpMdBwuGozxVTo5W8NWdBacpX0lW9wC/0EG3/NSgnyux4bO4lsMKW+5iC
         xsFx/rXJG5o88GFqSBsAqQu1ZBQTlYQVjPxhwrzCNAdLlQ27KwAJuUt0Sjzm1+IK5JjG
         q1e4n+j5DE/S4VP0gfMvF/wZTjgiCZ3h3im5EpqVZKKXXIaRvf6FlVokVfq9vxH5M8ZV
         ntZ0AUHm6Q5mtdHWFYwwdysFuJXsRG+PsdWgzCsyFwsU/xyWf8EjqAjrmfZ53QuBvL7W
         Yf7hjliK40Av7h9Ugx9/8tauTJ6gZgtgsrYlJb3QC0ZVDtZZiloRJW0Y++5LNNf6Onph
         HndQ==
X-Gm-Message-State: AOAM533KXOhrM6T63sBESlbhuPjMZVt55MihmtOWtSMb6UWR9EyhYiqg
        mrLn318e4Y73+VzDXZWDLfJuL9Oe42BJk/Tt
X-Google-Smtp-Source: ABdhPJxeFXaFmjxc0tJdtkcMfg0691ruN0HVdCSB9akoHT6mzQpLhi63vd8NyzOS5M6GP9ZD9tsLGQ==
X-Received: by 2002:a05:6602:1cc:: with SMTP id w12mr6054311iot.63.1636653550087;
        Thu, 11 Nov 2021 09:59:10 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m2sm1887818iob.21.2021.11.11.09.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 09:59:09 -0800 (PST)
Subject: Re: [PATCH] mm: shmem: do not call PageHWPoison on a ERR-page
To:     Ajay Garg <ajaygargnsit@gmail.com>, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211111084617.6746-1-ajaygargnsit@gmail.com>
 <CAHP4M8V2WEQ0LgHp7PHdBMYFp+_frn=7GLQVF7=faqapojQ+2g@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <628a49dc-f6f7-5aa4-8a4d-4f2ed19b7f3f@kernel.dk>
Date:   Thu, 11 Nov 2021 10:59:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHP4M8V2WEQ0LgHp7PHdBMYFp+_frn=7GLQVF7=faqapojQ+2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/21 10:45 AM, Ajay Garg wrote:
> Another report of the issue (different call-flow, but the same error
> at "shmem_read_mapping_page_gfp") at :
> https://lore.kernel.org/lkml/6bb8c25c-cdcf-8bca-3db2-9871a90d518f@kernel.dk/T/#m52d98b6bdb05764524a118b15cec048b34e5ca76
> 
> with a tentative approval for the patch :
> https://lore.kernel.org/lkml/6bb8c25c-cdcf-8bca-3db2-9871a90d518f@kernel.dk/T/#m24c2888a879d428cde5b34c43838301de544eb7e

Andrew, I've hit this multiple times on resume on my laptop, and it's
a very apparent bug in that b9d02f1bdd98 commit that it doesn't factor
in error pointers. My oops clearly shows it being one too, with ...fff4
being the dereference address.

Can we get this pushed upstream asap if you're fine with this patch?

-- 
Jens Axboe

