Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB6037906B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbhEJORN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:17:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46351 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhEJOMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:12:50 -0400
Received: from mail-qv1-f72.google.com ([209.85.219.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lg6dM-00041Q-Sb
        for linux-kernel@vger.kernel.org; Mon, 10 May 2021 14:11:44 +0000
Received: by mail-qv1-f72.google.com with SMTP id l19-20020a0ce5130000b02901b6795e3304so12691373qvm.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 07:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h35WOBP5h4HddLBJoty0i4QfjszSoqEipqZNaH8aj/8=;
        b=s380Y6M+j/paDx/+GviOxPEcjqsgrvdmjFdThLRELfTrzPP+hpFo+93RwFM+6nLp1R
         F5GzkAYL+7m8wnKALCNiF5mp1DzcHy73dE9E+tIBt6m5qOg7EarHpeCf3u1L0fLn7xLs
         hzSuV8VV5FgE6z/uQgDF0VnvVz+ZlpweucmsDhYfwp/gC+x+7BwjpH3F4sdM9tBUTbzX
         z9lCg8NAWsc394+L2J8HE2t7KnCSg+FnTVUTeULzedkpUX2SKIxHZzDKl6uAdIVZzGnq
         5lx6BlPENBLzxMnoxVxdXsV6Fj5zav5/zareT/wCaLKJY8gb2/LqDlqYBOeWXQwDSxK8
         EyBQ==
X-Gm-Message-State: AOAM532KbTRxDmQqep0OcK/jWOKsAISUOLrcn/LgahuSBNDOzAPBnmwW
        gy0sbjuASy1fC8E1ut6lpC/MKY4ClGkPhsPj3GFUYtQLtpJ0yebjEpFe40HkL2vTxugPTTMHv+j
        9H6ZgeYL1h6bvnXAsqBoQsjaccodVfC6PtBGmSRftPA==
X-Received: by 2002:a05:6214:18d:: with SMTP id q13mr24089841qvr.60.1620655903138;
        Mon, 10 May 2021 07:11:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxy8ZwW1iu4ovlCwEton77jZuwwKBvvIJDlX/BzVUmOl1ShXrSVZnlCSpAl8OVBg5MzqOErkA==
X-Received: by 2002:a05:6214:18d:: with SMTP id q13mr24089813qvr.60.1620655902981;
        Mon, 10 May 2021 07:11:42 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.49.2])
        by smtp.gmail.com with ESMTPSA id a26sm12571221qtg.60.2021.05.10.07.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 07:11:42 -0700 (PDT)
Subject: Re: [PATCH 1/4] devm-helpers: Add resource managed version of work
 init
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
References: <cover.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
 <82a9670d02ae96de4976c655d97b74c4a137f145.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <021e3e2c-f0f5-32fe-50b4-7ae7882a85b3@canonical.com>
Date:   Mon, 10 May 2021 10:11:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <82a9670d02ae96de4976c655d97b74c4a137f145.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2021 04:10, Matti Vaittinen wrote:
> A few drivers which need a work-queue must cancel work at driver detach.
> Some of those implement remove() solely for this purpose. Help drivers to
> avoid unnecessary remove and error-branch implementation by adding managed
> verision of work initialization. This will also help drivers to avoid
> mixing manual and devm based unwinding when other resources are handled by
> devm.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  include/linux/devm-helpers.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
