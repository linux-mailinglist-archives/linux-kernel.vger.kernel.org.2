Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F189B409E10
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243349AbhIMUUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241893AbhIMUUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:20:52 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A070C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:19:35 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id g1so12164873lfj.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=CXSocbKNp6y3NvY9ucG6LeYMMUtoHNp3xudt7bwh/1Q=;
        b=hHHikTXfU8Wue4ZV784uppdPdR3PGSRYgA+dRwFuQsv5NUgjrUvcp7xhm9sPNrg92M
         9zJYagf8ZGwRYFe006/XWTjn6QvxLiyl1iFW27+apSpFOwT+u2dIKjkEqj12ForzoqmA
         70bq+dVkidI2MW+ST2M6+k2aJGwFqcIJPle5l0t4JI7kiiBDyKp27tWb/zAMD8/Y2Z2E
         fLdG+RkFqVEfNirmC5Fd/H012ZtXeel0foeHTRbiC2PiNfBNM91jQsmxDZeQip19tE00
         PtvMoGFIIl0NPLgcjs1D+9hrY3F+HyHbe2F4BlaMlKzR6jDXULdRMhNic+7j9ZS7Zn/j
         925Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CXSocbKNp6y3NvY9ucG6LeYMMUtoHNp3xudt7bwh/1Q=;
        b=3Q7i8Lyztb9DhVUHYxW6NxsEYJaJTXu7E8ZNOF0jbJ4Fxu821/ME6+Ai03uccvJBJp
         epMObbqPY3agFN+UvQGrnKdGO1XWy51EsNl5hAI3LHBjBNuwK30dKJ9LkG1qFP7RYH3K
         NSRyr/iOc4eS3/Yygz4ECPJIwHyHqupTpIsWsJRWBTxdUVHUt5jgOC74a5y+zI3Fdh12
         tUuVEqH3p5BeD/f16rsLxZCJhxSoHtZyA+fSGsyN6S67ZD8EGvzALoq5FK32ar6faMZg
         ui42nGmJJRlgw22FMmJxk/l3J6gXWCnDnSc+b0dpztaqB3sqtnPPH4UO1XiwcN3p1a5g
         m1yg==
X-Gm-Message-State: AOAM530EOj2ArNSd7w5MvAwmUcovZD0N1y8gPJG8m3Nn6kXRYH8YQpVx
        CB/ppw7n9FBQn/jb8ZxjtBE=
X-Google-Smtp-Source: ABdhPJw2gtipt1LbN8AtinXFoNwwvQvSHFl4+GZJtAW/PskfzxJJVjD0TzOYzlyBmv0ru1D4r0zztw==
X-Received: by 2002:ac2:4c45:: with SMTP id o5mr7323698lfk.620.1631564373884;
        Mon, 13 Sep 2021 13:19:33 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.49])
        by smtp.gmail.com with ESMTPSA id b15sm1099519ljj.16.2021.09.13.13.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 13:19:33 -0700 (PDT)
Message-ID: <384860bb-c56d-a5db-2a31-ac659d89f490@gmail.com>
Date:   Mon, 13 Sep 2021 23:19:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH v4 17/18] staging: r8188eu: Shorten calls chain of
 rtw_read8/16/32()
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
References: <20210913181002.16651-1-fmdefrancesco@gmail.com>
 <20210913181002.16651-18-fmdefrancesco@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20210913181002.16651-18-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/21 21:10, Fabio M. De Francesco wrote:
> Shorten the calls chain of rtw_read8/16/32() down to the actual reads.
> For this purpose unify the three usb_read8/16/32 into the new
> usb_read(); make the latter parameterizable with 'size'; embed most of
> the code of usbctrl_vendorreq() into usb_read() and use in it the new
> usb_control_msg_recv() API of USB Core.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> v3->v4:
> 	Make some changes according to a first review of Greg
> 	Kroah-Hartman; remove unnecessary while loop and a couple of
> 	'if' test; handle the errors returned by usb_control_msg_recv()
> v2->v3:
> 	No changes.
> v1->v2:
> 	No changes.
> 

Hi, maintainers and reviewers!

We have just noticed, that 17 and 18 patches in this series contain 
logic error, so, please, don't waste time reviewing them.

v5 will be posted soon :)


With regards,
Pavel Skripkin
