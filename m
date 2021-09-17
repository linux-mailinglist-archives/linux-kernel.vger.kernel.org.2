Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19390410178
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 00:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244721AbhIQWrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 18:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbhIQWrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 18:47:12 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0BDC061757
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 15:45:50 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id q14so11926415ils.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 15:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=s8oIHj/9NV18y7Efw1SPbOXztrTlc/2JIRRHKj00s8o=;
        b=GEV1lp1FWsl9aCGq/lYX6WjdxzlGJNJNJk+XXeP6TBFDv+1s1hMpLwhVbIHBX0gHW1
         KFfu6nrtKr92XGR18HJu6nD5t1fy0ZSB8+ofV5t9GKDpCVxoAP2JLLNLkO2DWtFcyY20
         PwbGDYD+DVnKDRV4qIez7x9rKcI7s8GLMThQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=s8oIHj/9NV18y7Efw1SPbOXztrTlc/2JIRRHKj00s8o=;
        b=dSLXVAmqK874YrECiIx64rWIXSXqPMSHmmRnUOyrgX3Er+IxYTpKU1eCWrBc6n5AwY
         txgLjIeBSjUO3y3tczbRVTnt1E1ITWAwv8mzDOlxRm+NFheSIXuydl+bW3z8qwHowB51
         wf404ndMNyC7ZeUHDU+BFZ44OrWty02ECoj3szgqQfySH+b4siZQZoVVcFJYI5gtMHaP
         5Y66hLoIE5pj0LtjgRF3DWfkTcTy6CTOQCtLk2HtY6OdyJaDANxM/LfIOoYoySfYxAvG
         /5LWy4Fi3a/p+9gX1cfqLCu3bXm96y2il/mohjlWRq1SSmTZwkgZWc6/nbktsWSl+4xj
         wqIA==
X-Gm-Message-State: AOAM533yPiUf0b8JWTG0qN5EEvh3SECvTzDCDBfMr2c0OajwYMtu7Gcd
        Cvr7UNyobCb4WpcYFHIeWBtHCw==
X-Google-Smtp-Source: ABdhPJylHR3n8gVPmxcCHcbnvnfV/4UGWy0eJTkCtam3aFRjDRpd5MsCL0miGgcspW8EJqzJSJFxNw==
X-Received: by 2002:a92:cb43:: with SMTP id f3mr10037558ilq.261.1631918749788;
        Fri, 17 Sep 2021 15:45:49 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s12sm4474952ilo.70.2021.09.17.15.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 15:45:49 -0700 (PDT)
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: selftests/vm madv_populate.c test
Message-ID: <b703a326-66f7-bf35-58ee-f60e504ea5ef@linuxfoundation.org>
Date:   Fri, 17 Sep 2021 16:45:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

I am running into the following warning when try to build this test:

madv_populate.c:334:2: warning: #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition" [-Wcpp]
   334 | #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
       |  ^~~~~~~


I see that the following handling is in place. However there is no
other information to explain why the check is necessary.

#if defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE)

#else /* defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE) */

#warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"

I do see these defined in:

include/uapi/asm-generic/mman-common.h:#define MADV_POPULATE_READ       22
include/uapi/asm-generic/mman-common.h:#define MADV_POPULATE_WRITE      23

Is this the case of missing include from madv_populate.c?

thanks,
-- Shuah
