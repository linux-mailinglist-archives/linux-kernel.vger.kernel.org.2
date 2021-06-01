Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8461B397D0F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 01:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbhFAXeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 19:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbhFAXeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 19:34:08 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1947BC061574;
        Tue,  1 Jun 2021 16:32:25 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id c20so638364qkm.3;
        Tue, 01 Jun 2021 16:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=n5qUxNhebxhh1o4S5RsRDnpxOezOtNelOWi74JiDkls=;
        b=cHpjBW28CEKIdPIP96wHCabTM6ov5/xmVJdjvgmDpseY7daumngEmz1fwlBpplgxnY
         FRwdeP94Y8Jg4q3RNDNCV2jkN4elQWGcipiidgSZtRGnG/F7FUtuyU0Ws6W+yf6+RasW
         C/c5sfTswWi8ITgypSmV6IufK5q37mRkjZs6ZZEYo9dUhhs3QpUgIYwsSZ7ZsuN+rbYx
         Sca47SADPVOjfK/aXZgbIFh9iLLX01EkxW95RohaUDLLazl7iDUSjnUF5kkMwbZqHBJ2
         HUoEfJKpcnl9RDRgcBkO+XcPkMCBvfAJ7SlKKQoga4D2ralI7P1B0kjTR1jVs9E34wlm
         Jlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n5qUxNhebxhh1o4S5RsRDnpxOezOtNelOWi74JiDkls=;
        b=nNpM49kCUOaq19pekM8jFGb/NQjANARmsAh7DycV7AgDvbSLOksoqqr/A+zQVSPuJ2
         /9TRaMZ1iCvxutFKc2tQCk3KDkiK/VQKy0+o1TBf1hTUzb7rXEZllR9P8UlyM44B9xdP
         eEmcXpuQHietKUPOuiqY6tdaQ0yadzNRysH18STmm0PKcdps4HGKnNFP4l8hdJTaI4PW
         vw6orR17qOAvGkIWcnxKWoUT5t8bJp2ZD6CLx4/lzggdRhx9uw7nx8obExcu8HpiGxwO
         Qxq5T15O3KQpOvtuz2IqIQGom6rnn0PpFPXkP+SgIkFolMw4mS971vAX0hSr4YAB+uTx
         2amA==
X-Gm-Message-State: AOAM5319h16x20G7EZIgDoUrETlTs46sMOm1QlYwXj2UdhpzAZIzkkHv
        /Cm7j0xliohgO0gjTnNgDQVam0MrywA=
X-Google-Smtp-Source: ABdhPJxBdDt7Cc0D9SHrdNBpxahBph5JPuVp2VNMKdcHmGJ5OgCruLRtn00LXh0CFyQXb4aQ5JHtwA==
X-Received: by 2002:ae9:e716:: with SMTP id m22mr25307355qka.217.1622590344161;
        Tue, 01 Jun 2021 16:32:24 -0700 (PDT)
Received: from ?IPv6:2804:14c:125:811b:fbbc:3360:40c4:fb64? ([2804:14c:125:811b:fbbc:3360:40c4:fb64])
        by smtp.gmail.com with ESMTPSA id t196sm1573728qke.50.2021.06.01.16.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 16:32:23 -0700 (PDT)
Subject: Re: docs: Convert the Speakup guide to rst
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        speakup@linux-speakup.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, grandmaster@al2klimov.de,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210531215737.8431-1-igormtorrente@gmail.com>
 <20210531220754.h4ep2dj65wl6hejf@begin>
 <b8769ad4-9188-a735-3ac4-4a79b9b06487@gmail.com>
 <20210601215536.5rhnbwwt66uyqhze@begin>
From:   Igor Torrente <igormtorrente@gmail.com>
Message-ID: <85969150-6e00-12b8-b56d-5f161436777d@gmail.com>
Date:   Tue, 1 Jun 2021 20:32:20 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210601215536.5rhnbwwt66uyqhze@begin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

On 6/1/21 6:55 PM, Samuel Thibault wrote:
> Hello,
> 
> Igor Torrente, le mar. 01 juin 2021 12:39:01 -0300, a ecrit:
>> I was reading all the emails sent in this thread, but I'm not sure how I
>> should proceed. Do think should I continue to improve the patch with the
>> Jani Nikula suggestions? Or abandon it? Or keep both versions?
> 
> It seems that people are fine with the switch to the .rst format, and
> it'll indeed allow much better distribution of its content, so please
> continue improving the patch with the suggestions from Jani, you have an
> 
> Acked-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> and the review will probably come from Jani, who seems to actually know
> a bit about the rst syntax :)

OK, I will keep improving it.

> 
> Samuel
> 

Thanks,
---
Igor M. A. Torrente
