Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153EC3C62AB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 20:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbhGLSeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 14:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbhGLSeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 14:34:19 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3863FC0613E5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 11:31:30 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id k16so23824017ios.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 11:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=LgizhMtK9J0wIVIMFU3xipTGuHnEvtr8IUFF/Ttb7XQ=;
        b=P0ksw+vlwVta+6sykFVSvdgotDV2Ib4mvz9CazIitN8WqC62CGc26VJjIWLL5HrDRx
         Gm+fTShmINE+dnzCsGfEbq0BvadYCsjJj2bXKlpPlNixXaqFAjfvns5UeV2gZtMn/qIH
         OVN4mgJycmzX0WSjzL+UgEmfz1pD+t6emBQ0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=LgizhMtK9J0wIVIMFU3xipTGuHnEvtr8IUFF/Ttb7XQ=;
        b=DkqNVVgLGzRRT4RUYUtxteTdMgCB6OwLJl0sNbwrLkt4M99DM+WNML33jKinanTrva
         bDuylm5AaopKh3E3UBIdv2aK7feFf0IQpDIQxWA3GE6OoQw3PiCUc/pqC5628lL2yah3
         LycsnwLAJGMK1ZUwtbMDClatMpqB8Zj0OabAOHei12xo2kVtRDdjut1xJK48xAuuhkBk
         78kSgo9sIwQ6qr1yxLfWp23/3Ny35IHY89C34GBxp7+mzxXzeIVxlZXXY5GIMiB5Y0vD
         RbflpEpzN+J9k+R+7ux8ZAwyM0ZPEjSiWPcp/7zAZ8RU4KLCkfEIAMTNjlvTf8Qh/QFv
         yTNg==
X-Gm-Message-State: AOAM532bKanO+Y2H4bfSio1ARm65Ogz17cfUE/K8NwitQxrLxoSSowa8
        Zo+QNNHBZIp/s8aKCIAYw1fQZw==
X-Google-Smtp-Source: ABdhPJwgR47turz9PqCQknUdJuTqQOEvWs0Zy2zl48axnG9Z6QY5OInQZJ2yOMTpEOEcb2DMfyxqKA==
X-Received: by 2002:a5e:9e4a:: with SMTP id j10mr215619ioq.29.1626114689487;
        Mon, 12 Jul 2021 11:31:29 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h12sm8674093ilj.6.2021.07.12.11.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 11:31:28 -0700 (PDT)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: BUG: lkdtm stack-entropy.sh test hangs
Message-ID: <38ca8e69-1385-6035-5ac4-2ef45cfc8141@linuxfoundation.org>
Date:   Mon, 12 Jul 2021 12:31:28 -0600
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
