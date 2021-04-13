Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61B735E328
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 17:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346060AbhDMPtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 11:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345974AbhDMPtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:49:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B1DC061756
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 08:49:19 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id s7so16827779wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 08:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PsW0LpLJ+OHoCMT5QibDiVjIFRIsSTW5mUVz9ROm9Ek=;
        b=kO13z57w7JxN4GJv+mAA/cd9x7MNhDzUXMzD4qzANlHEYMc81/IARR+XeaIMbrbuBw
         5VPrPQnEfsOwSQ1I4beRTSvSPSTBB7XZHiCZqzTpRDu2734ZpnUgBuEzgBJJ1/mYet5x
         tTt7YhjEDC3+VxMOLCQCqZ1n98+pQh3NqWUcPAj8Pgb1rjUREYZ5UjSDo57/H5dT4ZGq
         TMc+1Mn1sdHjeToyr6SdHc1XhWqx29JuBC+y0t2l9tTeBmdXfn8GqHTAbsXqmJSUkEZA
         1EDFsXz7IhL09ZrRFadDBSNc6shVf8K8mZal1V5Su0BBQ4gbPMVV2LKyvKu99bXIvB3u
         wzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PsW0LpLJ+OHoCMT5QibDiVjIFRIsSTW5mUVz9ROm9Ek=;
        b=nSjS3YTDf0mag5XPMqqKbJLpVgIEMKggOMj02hox+uerv6VkfJwSTEMQ0uwYefCKnT
         qC7waoUdu0PG09N/aj7zn/SjYsmll7ejldn0J1X3S5yaYTubh4990EbHme57WPeklMJI
         4HLWY6WkY/76+zreeLt+Pm3FW0VoF7QD2xTd2DkmajxNJ4fyLxzl3p4kyNhfa3Fr0KS1
         awv60zfzBT7Q1QR0L0UmxPflMu02mmkzfdyOvu8xkQdJAr/iUuyhJ74uUx207lQwpIcM
         QD6B0DAY23zYe+a8c4Fpssz3mjys1Y0dcU0d5YD+afjZUAUsZsjtgSpM9RlAHykOq7Fs
         aviA==
X-Gm-Message-State: AOAM530F/EYDihlg/2gzPY2yyLcu/Y6+c4TVEQOFjYGE/42jnKfzlB5N
        SomdAHq+McRKYvCvmQH5ErFMkw==
X-Google-Smtp-Source: ABdhPJyF+9Nmae2A35E+099haCMQJXZr77AKTKeOy+sI2cM34f6b049fZ7TlZg95yExarpjoJJZSpQ==
X-Received: by 2002:adf:db52:: with SMTP id f18mr31877255wrj.225.1618328958600;
        Tue, 13 Apr 2021 08:49:18 -0700 (PDT)
Received: from [192.168.1.14] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id w7sm20814515wrt.15.2021.04.13.08.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 08:49:17 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] Intra-refresh period control
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        nicolas.dufresne@collabora.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
References: <20210302095340.3584204-1-stanimir.varbanov@linaro.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <3480b6ee-f442-57be-473f-c90966584d40@linaro.org>
Date:   Tue, 13 Apr 2021 18:49:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210302095340.3584204-1-stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Any comments?

On 3/2/21 11:53 AM, Stanimir Varbanov wrote:
> Hi,
> 
> This series add a new intra-refresh period control for encoders. The
> series is a continuation of [1]. Comments addressed:
>  * A typo in .rst (Hans)
>  * Clarified the relationship with CYCLIC_INTRA_REFRESH_MB (Hans)
> 
> Comments are welcome!
> 
> regards,
> Stan
> 
> [1] https://www.spinics.net/lists/linux-media/msg183019.html
> 
> Stanimir Varbanov (2):
>   media: v4l2-ctrls: Add intra-refresh period control
>   venus: venc: Add support for intra-refresh period
> 
>  .../media/v4l/ext-ctrls-codec.rst             | 12 ++++++++
>  drivers/media/platform/qcom/venus/core.h      |  1 +
>  drivers/media/platform/qcom/venus/venc.c      | 28 +++++++++++++++++++
>  .../media/platform/qcom/venus/venc_ctrls.c    | 13 ++++-----
>  drivers/media/v4l2-core/v4l2-ctrls.c          |  2 ++
>  include/uapi/linux/v4l2-controls.h            |  1 +
>  6 files changed, 50 insertions(+), 7 deletions(-)
> 

-- 
regards,
Stan
