Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D83533D272
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbhCPLH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237060AbhCPLHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:07:25 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0AFC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 04:07:24 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id jt13so71460570ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 04:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w9abddBpqLJVcwq/yZSJOMSeh2fLBW/uaeu5zmX5HK0=;
        b=d1vPLe6EwY4M1GlCS1kBMqhLkNeuQE3JYieyDurN4YegCZIiEbqLfGLYEGkN9orcyz
         vyc61V51e+JKnHE/bq8z0+m5d5laIBQD2f+4DEXsR4Dp/mUaU/Rp0cs7tTsrwcRVZTbM
         D/W/vZgC/hhaLkg4rjuHnnQW+jD5dLlVKbzuaKzDE6I8Fhs+mVnLubq+Di66w2mdj774
         KuMYxa+0nDF8IIPRwfazvnWtD26BYiFTyetBNR6nXBAIhUa9P/tSLeDpfP6fyARHBiDT
         WXOVwsD0ASOpj9cmjKa/pKYESwWY+a4/3iV61gzjm4woYAN9wEfi2LtCcKgnteCnVQfk
         ct7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w9abddBpqLJVcwq/yZSJOMSeh2fLBW/uaeu5zmX5HK0=;
        b=NEW8Y1C2KLt2pXLoPZP+3Vh07uN9EziRuNJuMkyGqkRHIxFjlS4C16GzMIgnGQPK5R
         DsoZcnlfXmlvxzZI8SXtWd5iSbq90FZG1FJlU7a3ZH/TuWaNlsi2rLxzV44c03eS/J/0
         yhaOMrn++KTAnsUB/42kxlCTGAyPiv1feoXjzRGxq2BtTYn1gGEBJTBmskd353+JoqMV
         QBxfdN7jp06oQTzTnBeEINWOhDCp/IkY9PdvZxfDSVEJ1U+0JofGJ/snIbocGUQqKMuV
         Bo6bOIzL0Wr1gkZYt0syeo7GJIrNDkkVyHXkTL8RfWeF0GDLuGsTdYWYNNzjE2VneppW
         I9Gw==
X-Gm-Message-State: AOAM53232xMDnQmzAwWFN9eefBmxRCXofuNVY3IbY2ct6ROV78FI+Zy9
        A3xn1n1Z3M7+FG4VegYGrRlKlw==
X-Google-Smtp-Source: ABdhPJzsQmd2sfqPJ+a1e6IgeGPuDT6UZst1EyY0SqKUnq5oPBpYP6yWkfSkmXLL/4REnuxiVG01zg==
X-Received: by 2002:a17:906:489:: with SMTP id f9mr28335796eja.428.1615892843410;
        Tue, 16 Mar 2021 04:07:23 -0700 (PDT)
Received: from [192.168.1.19] (hst-221-14.medicom.bg. [84.238.221.14])
        by smtp.googlemail.com with ESMTPSA id n16sm9105447ejy.35.2021.03.16.04.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 04:07:23 -0700 (PDT)
Subject: Re: [PATCH v5 0/5] HDR10 static metadata
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
References: <20210209162425.3970393-1-stanimir.varbanov@linaro.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <24d28844-d7e0-baca-51da-4cd1428bf1da@linaro.org>
Date:   Tue, 16 Mar 2021 13:07:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210209162425.3970393-1-stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hans, any comments?

On 2/9/21 6:24 PM, Stanimir Varbanov wrote:
> Changes since v4:
>   * 1/5 - fixed a typo (Hans)
>   * 2/5 - add some mode info about new colorimetry class (Hans)
>   * 4/5 - correct cd/m2 -> cd/m\ :sup:`2`
>         - change to US spelling for color word
>         - use correct v4l2_ctrl_type in videodev2.h.rst.exceptions
>         - documented p_hdr10_cll and p_hdr10_mastering in vidioc-g-ext-ctrls.rst
> 
> Comments are welcome!        
> 
> regards,
> Stan
>         
> Stanimir Varbanov (5):
>   v4l: Add new Colorimetry Class
>   docs: Document colorimetry class
>   v4l: Add HDR10 static metadata controls
>   docs: Document CLL and Mastering display colorimetry controls
>   venus: venc: Add support for CLL and Mastering display controls
> 
>  .../userspace-api/media/v4l/common.rst        |  1 +
>  .../media/v4l/ext-ctrls-colorimetry.rst       | 93 +++++++++++++++++++
>  .../media/v4l/vidioc-g-ext-ctrls.rst          | 12 +++
>  .../media/videodev2.h.rst.exceptions          |  2 +
>  drivers/media/platform/qcom/venus/core.h      |  2 +
>  drivers/media/platform/qcom/venus/hfi_cmds.c  |  8 ++
>  .../media/platform/qcom/venus/hfi_helper.h    | 20 ++++
>  drivers/media/platform/qcom/venus/venc.c      | 29 ++++++
>  .../media/platform/qcom/venus/venc_ctrls.c    | 16 +++-
>  drivers/media/v4l2-core/v4l2-ctrls.c          | 74 ++++++++++++++-
>  include/media/v4l2-ctrls.h                    |  4 +
>  include/uapi/linux/v4l2-controls.h            | 35 +++++++
>  include/uapi/linux/videodev2.h                |  3 +
>  13 files changed, 297 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/userspace-api/media/v4l/ext-ctrls-colorimetry.rst
> 

-- 
regards,
Stan
