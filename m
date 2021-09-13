Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BE1409D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 21:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242469AbhIMTjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 15:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240113AbhIMTjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:39:52 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A81EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:38:36 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d21so8702386wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=c6DbKWeeuhyIQk/sjR5gJ2Num3qwAgw1fKp51/8HpbY=;
        b=Q8+5Fs8fNNTZntiKDFNbaSpGrjYmQD7GVzFqb6ch5BoIw0spXXKGxehoszaG80RNTz
         hhMxqj6D0QZjaYR8f0LhVvzVtczxcldm0lWur3fRndY8bKFt1MnHVZ0jWe/mDr6IgS4C
         yJAOnWfyT1nEnMDfvyNesKRTBjovnmyfKEtnD5IQKVDvLyCnHqKOqjMHeYqZXBEkYwk0
         cYTYAY63t8JchWXbwcTZ7yTkgTN+OVX1QpXvoyNV18YTZsulKtZ55x8vO11aSDK6TU51
         W4yCZTjPKDTVZpgk8xgydcxFOs34xXCgEar0pFlwnlTKhcWL6PXum3lVGetE4opx2I0g
         /1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c6DbKWeeuhyIQk/sjR5gJ2Num3qwAgw1fKp51/8HpbY=;
        b=U1Z+bkFRBjACOURBVWtRhWVbinKjXhg/mAHPNzG+AE1Nda1D20cYRSvtW4mjbEQAW1
         YEUoSSgB8hzGSnjc5A06J5cFv0Rh/5hci8Nika6w3u+G1j4Dsj/6D6m/aQCGXEA3y6I9
         lQ0M13FZQ/DvUzgfepbynwJbk9dRi7fPLGZAj32D+Cz/U46YB2Q0cr2C3iCKk+X4ZFbg
         oPVL1LgfF6Wzh73kvfUkud/jGA4Nb2/IGJCoiGhpE8xTu+LGXQCAxC7fr/HD6jpWu/yo
         lfwWEluaGgpO3XWMKBzaQ7vyYLcDCfFSgdG75a53TiNKMJ8QfKBwcP3xSXHrx0cAOI1R
         mipw==
X-Gm-Message-State: AOAM533Aumm5CK9HeygmC5lsaSR+B+Mj7Z1g0TmXFmJ+V1faXHeJnUBO
        ydvwBVzcOSli7OxYWGIrzKs=
X-Google-Smtp-Source: ABdhPJyeNb/QodalatxHQ8M39Shvt3YxxNv1ndi5rl5f7lljsUhavpCTCWIs/1+XcvvnU0ACRJxvRA==
X-Received: by 2002:a5d:4591:: with SMTP id p17mr14483338wrq.59.1631561914937;
        Mon, 13 Sep 2021 12:38:34 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::1db2? ([2a02:8108:96c0:3b88::1db2])
        by smtp.gmail.com with ESMTPSA id n26sm5745365wmi.43.2021.09.13.12.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 12:38:34 -0700 (PDT)
Message-ID: <1feb008a-d13b-6b27-5e1f-e56fed37cd3e@gmail.com>
Date:   Mon, 13 Sep 2021 21:38:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH v2 3/8] staging: r8188eu: _free_pwrlock is empty
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210911141521.24901-1-martin@kaiser.cx>
 <20210913185110.3065-1-martin@kaiser.cx>
 <20210913185110.3065-4-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20210913185110.3065-4-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 9/13/21 20:51, Martin Kaiser wrote:
> -void rtw_free_pwrctrl_priv(struct adapter *adapter)
> -{
> -	struct pwrctrl_priv *pwrctrlpriv = &adapter->pwrctrlpriv;
> -
> -	_free_pwrlock(&pwrctrlpriv->lock);
> -
> -}

the prototype of rtw_free_pwrctrl_priv can also be removed
from rtw_pwrctrl.h,

Thanks,
Michael
