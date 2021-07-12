Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777093C62AE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 20:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbhGLSeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 14:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbhGLSeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 14:34:24 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A67C0613E8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 11:31:35 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id l18so18916242iow.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 11:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=LgizhMtK9J0wIVIMFU3xipTGuHnEvtr8IUFF/Ttb7XQ=;
        b=fiWYk3Qgti2nJDBisADC1y5QatwEJAPoalQmvvprxStFE6LcBHAB9TfS1PEQcVjraL
         NHM8IKT8DyZxm8wQDGGmvbDP1ChwouB+WCPz0oxoPNsY5TKr9Ll5fUL570zFJqK5ILWA
         Z1wK+pWsYrF/4CsF/JB8IlTEBK6oq19g/q75M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=LgizhMtK9J0wIVIMFU3xipTGuHnEvtr8IUFF/Ttb7XQ=;
        b=dHDg4KrP5jvJgunq3tjs2AYEUHcJwm1QZNPXdUqRnlmrxn0Js88OT3qcsmloiMouvQ
         Soyof6X37EV9EtdOqYEfKs3HZseDEHYkStwKhUzHTzfEdgsuXzHYvBADJ8rJy7h/ayS3
         iyJ8pCXhONeCaVg1Jne47S2FoezYEoTv68vkp/j9P6c8dSBQtGxYsNSJjrWlq++3MYPR
         moH9tbSkESB0CjzPZRYf3A3amOJxHv1VE1WhjlT0BHSqcEd2zcrOTgku3rbBVhTFc8RO
         yKAlJ2biNqtHbUu31QCcN9p6+pPn8lUecjD2RxTtzYcAECtIku5R/KDWr/xZL+AFsc7p
         bXQw==
X-Gm-Message-State: AOAM532fqPkEQG+LTna5hEI+56aUxb6XlMyIFFaaxPd3F3Mp+7JuME27
        R7JIUtPeJW/+0XU4Cg/62rRV3A==
X-Google-Smtp-Source: ABdhPJxULu9RcAOrhMI5KxkMU4BX+rJYn1a9lYVMLnheRhZkJQANESlazqXStOjdtDPZJVwrmUeDJA==
X-Received: by 2002:a5d:8198:: with SMTP id u24mr212178ion.81.1626114695237;
        Mon, 12 Jul 2021 11:31:35 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c19sm8163490iod.46.2021.07.12.11.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 11:31:34 -0700 (PDT)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: BUG: lkdtm stack-entropy.sh test hangs
Message-ID: <2836f48a-d4e2-7f00-f06c-9f556fbd6332@linuxfoundation.org>
Date:   Mon, 12 Jul 2021 12:31:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

lkdtm stack-entropy.sh test hangs on Linux 5,14-rc1 - I tried
root and non-root cases. Both hang.
  
# selftests: lkdtm: stack-entropy.sh
# ./stack-entropy.sh: 13: cannot create /sys/kernel/debug/provoke-crash/DIRECT: Permission denied

If you have a fix for this, I would like to get this in soon.

thanks,
-- Shuah
