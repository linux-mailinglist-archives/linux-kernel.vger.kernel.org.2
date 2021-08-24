Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EB43F5C12
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbhHXK13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236139AbhHXK11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:27:27 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F157C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 03:26:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so1988005wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 03:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/8erZYE2cD+Vlo7X+889l81VIhNHRmt0/HRXy3thEP4=;
        b=Yh6K5HwtU/khm1gO+RRAN+TGZ0nBSSC7pXNJxX93WV+FQUWbn0oUjpL+00M4f9DdYz
         XXttERFqS/lakjHgdflBnvPvi6jAz1zNDvZkJwV0SAWsHMUz16GcUJlz0BLi3fI6rJwJ
         OfuZ0ts0Y3VmLq1ayJ+4j9q0FchnfHlSJfdClXNNlEkYHBgtaWBdB9tDXfXPnpjl09ei
         x5DZfu0Ye+SkkkSxUyrTwJvUgz7Lnuj6bbia7WDs8O6YYX2DbQ9jakPA6cDM6kvjsVss
         wb88i9JHTxzng6SJ1nNY+ymnVqC2qQIWxXM0HyMqbAXv5Jx8AVlHxKP6vBPMpPOdlEqn
         9WjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/8erZYE2cD+Vlo7X+889l81VIhNHRmt0/HRXy3thEP4=;
        b=PzrCGfWJjZ+sc863Uc8VXJVICNUY8hvRbT/Mt60/8+gaWXTJmhQuL/whL42V8sTMJN
         QNKo4CsCtPyV1GS5xZLjtCvTISKzT9nUan7uEN401+h6rPotieMOPaCdcjwr9a4PNpjY
         cyzjSwcO7Mp6fQZHRCum/cNGZwlsDtXaqzuXeiI9lir3WP7r+nl29LMwHdvey+De3I2V
         VXkG7lhb7JS/07OJ68MD6RWZAOgdi0P4GR21SfHP+/Gw+EwRqmR4V7ufHqwqZQOKUd55
         c9c5Yksk21HIsCekhF2NS0MAQ9AjDmA5fxoa6F8BYLQVbdQhj8wmdtQw18x7Pm2j+USa
         PLCA==
X-Gm-Message-State: AOAM532NPFNVKwz30dFHB1lOEG4q+XjHVzyixaBBzKZ40k3gwQV7nl9K
        9W/2RGVEB5ZvKT1nnvlerecQcZfH+NE=
X-Google-Smtp-Source: ABdhPJwklu7zScEE++H2vJFMMEwUnTUfcuRtS3eTwxnayYyZu8KhOnVMHdbKX+47IK8zw9D7SjJe4Q==
X-Received: by 2002:a05:600c:3795:: with SMTP id o21mr1638535wmr.130.1629800802336;
        Tue, 24 Aug 2021 03:26:42 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::5d87? ([2a02:8108:96c0:3b88::5d87])
        by smtp.gmail.com with ESMTPSA id z7sm1857033wmi.4.2021.08.24.03.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 03:26:41 -0700 (PDT)
Subject: Re: [PATCH 00/23] staging: r8188eu: clean up spacing style issues in
 core dir
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, martin@kaiser.cx, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210816155818.24005-1-straube.linux@gmail.com>
 <20210824085845.GN1931@kadam>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <bfd22fe0-27d4-4248-bef4-bad43f464fad@gmail.com>
Date:   Tue, 24 Aug 2021 12:25:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210824085845.GN1931@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 10:58 AM, Dan Carpenter wrote:
> Thanks!  This was very nicely broken up so it was easy to review.
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> regards,
> dan carpenter
> 

Has been merged already. But many thanks for taking the time
to review it!

Thanks,
Michael

