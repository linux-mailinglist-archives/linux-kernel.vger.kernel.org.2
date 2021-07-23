Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F399E3D3AD7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 15:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbhGWMYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbhGWMY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:24:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D8AC061757
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 06:05:02 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b7so2277480wri.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 06:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CScnrJv6DM1l/GyT2F7M4STWfOPo8zjPQsEF1iUbnH8=;
        b=pR359CZFThBQXx+RGAdzrSNm+hjKs+k3/Z8qg/279n6hfh0zH6rG2p8aopBgzt/8AR
         yMfEx+YyL86rBJN1nVMQ7ZxGBD0V8oiQ1KHc1lRskOiY864aTXRiZa28hc3qg+uSFA6n
         KB6xJgvNODuqyx2r7p/h5nu3CayR/cPZf01BVpwEkOc2KNTvBC7bf9rYE5hxo6kgOkh7
         sWK0+oMbfEL6kP+iAZygyKzTLC63wvMXa6x2X5YJ1fBlhpgwlj9+E8SYcl999OZcTSDF
         fmpAFhAoDwP+202GOpHnMcruXC72JJ86skPJk+cC/YLoyVgzeTIeTZBe3wVL4d/N+BFi
         9+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CScnrJv6DM1l/GyT2F7M4STWfOPo8zjPQsEF1iUbnH8=;
        b=EHDITtAZEuyPeHOG6UT47YQLa2LRjyHXyl46Rfr95kp10ZL18zO6QB33uOtilr/7Pv
         MaLEee4BdQ8ZWYLJGyi5tckZ0OeXlxyJ0648i3/ifXm4o+VhfnFMOycmW2O1JPnJpWEn
         lNw4lvX1U/e/6EJutdf2tQJvYSy0WWhsTOlrj9dnNNretvWyoYqJ61tWTHNRl8NxxZZw
         vqrTMx79acAB/IJdf4s3G02DA1qmGnSrTCTbvknVqr5iYsMPnyMAO29dQnnpuWWwG/7k
         I+HguLNCbJvOyRiDq2rZBbB7knAbt5tvomIxFOUrSQ/DcjU897a0CdN68XCXgGpXCOfe
         TQfw==
X-Gm-Message-State: AOAM531zL8T5TwI1jMVYJgs+25b58h7Yi8pkvGzDx4XYJBR3TFyLqmoX
        CFhit/QHSef4dw3+h9rTqZU=
X-Google-Smtp-Source: ABdhPJw9dNXpLiJi9Pj58WjglIrkMDrfUWmhHj8agQNbnnF0vTtUjz42Tc+gEicXpbvA+6VqqLPj0w==
X-Received: by 2002:adf:a1c4:: with SMTP id v4mr5154351wrv.217.1627045501040;
        Fri, 23 Jul 2021 06:05:01 -0700 (PDT)
Received: from [192.168.1.211] ([2.29.20.106])
        by smtp.gmail.com with ESMTPSA id y11sm5286318wmi.33.2021.07.23.06.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 06:05:00 -0700 (PDT)
Subject: Re: [PATCH 1/2] device property: Check fwnode->secondary in
 fwnode_graph_get_next_endpoint()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, laurent.pinchart@ideasonboard.com
References: <20210722201929.3585671-1-djrscally@gmail.com>
 <20210722201929.3585671-2-djrscally@gmail.com>
 <YPq28BNOmqZPdRqq@smile.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <acf4838d-3c70-20c1-5fce-ee36765b06c4@gmail.com>
Date:   Fri, 23 Jul 2021 14:04:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPq28BNOmqZPdRqq@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/07/2021 13:32, Andy Shevchenko wrote:
> On Thu, Jul 22, 2021 at 09:19:28PM +0100, Daniel Scally wrote:
>> Sensor drivers often check for an endpoint to make sure that they're
>> connected to a consuming device like a CIO2 during .probe(). Some of
>> those endpoints might be in the form of software_nodes assigned as
>> a secondary to the device's fwnode_handle. Account for this possibility
>> in fwnode_graph_get_next_endpoint() to avoid having to do it in the
>> sensor drivers themselves.
> ...
>
>> +	ep = fwnode_call_ptr_op(parent, graph_get_next_endpoint, prev);
>> +
>> +	if (IS_ERR_OR_NULL(ep) && !IS_ERR_OR_NULL(parent) &&
>> +	    !IS_ERR_OR_NULL(parent->secondary))
> Nit-pick, I would put it like:
>
> 	if (!IS_ERR_OR_NULL(parent->secondary) && !IS_ERR_OR_NULL(parent) &&
> 	    IS_ERR_OR_NULL(ep))
>
> or
>
> 	if (IS_ERR_OR_NULL(ep) &&
> 	    !IS_ERR_OR_NULL(parent->secondary) && !IS_ERR_OR_NULL(parent))
>
> for the sake of logical split.


OK; I'll do the second one, feel like it's better to have ep as the
first check.

>
>> +		ep = fwnode_graph_get_next_endpoint(parent->secondary, NULL);
