Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041823EAFCD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 07:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238687AbhHMFyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 01:54:23 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:41583 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238753AbhHMFyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 01:54:21 -0400
Received: by mail-wm1-f44.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so4692334wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 22:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kDicGygeeiPHvZ/oC8eypBw+MyBw86cziX0DHpCxNAc=;
        b=LeF2J1D+ZhGE0+6mPR8WrDr7dxgIwkxAfb7WNPaHK9BmUIavbEXr6L5SxDJNYAuDcy
         fDiy3QTNhJoqytFScaUM5dOtDk39pTiSb4zsKjv+3nJ8ZgEf0G6mdI2FjKKO38vK+wyN
         fcUJWXI0gQGNyfj8QhcoO/aUJgMCyN6v1FFftJz18Q5XAsAwFdh/BrI84shjcMk9VAoo
         FBocbW4TWfRaXUxERt9/Nw3R4j91ikPHmpx1TcwRXw1Rh8iAeKiefWu9sXBPnKhVHOb8
         IojXGgIy6I/TA6FSakGNb5YLmkp8Cx/2hRKeF9FuyYIW/1Fy9wy8lbC/bosLYk0N92uS
         5/zA==
X-Gm-Message-State: AOAM533DFtqTIfUMU+ulV7SVUOyaKHXoH+Zi8Bj+bi1hLL+m7MFvRanN
        g68t1mCbqaGu7xu8u8iajMniH2qonwar6Q==
X-Google-Smtp-Source: ABdhPJy8wAfKyM+oLt0Q9y4Hp5Drbt085CfMeHVfhn6+xq33iBgJferYKQ07teGjmNfJzUb9YyPx7g==
X-Received: by 2002:a7b:c399:: with SMTP id s25mr917659wmj.180.1628834033697;
        Thu, 12 Aug 2021 22:53:53 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id l7sm388877wmj.9.2021.08.12.22.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 22:53:52 -0700 (PDT)
Subject: Re: [PATCH v6 1/2] tty: hvc: pass DMA capable memory to put_chars()
To:     kernel test robot <lkp@intel.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        gregkh@linuxfoundation.org, amit@kernel.org, arnd@arndb.de,
        osandov@fb.com
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210812094532.145497-2-xianting.tian@linux.alibaba.com>
 <202108122040.lBf24DNp-lkp@intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <0c808001-7643-fdcf-66ba-738654ec0c21@kernel.org>
Date:   Fri, 13 Aug 2021 07:53:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <202108122040.lBf24DNp-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12. 08. 21, 14:26, kernel test robot wrote:
>>> drivers/tty/hvc/hvc_console.c:190:26: warning: variable 'hp' is uninitialized when used here [-Wuninitialized]
>             spin_unlock_irqrestore(&hp->c_lock, flags);
>                                     ^~
>     drivers/tty/hvc/hvc_console.c:149:23: note: initialize the variable 'hp' to silence this warning
>             struct hvc_struct *hp;
>                                  ^
>                                   = NULL

So you clearly didn't test your change as it would crash quite 
instantly. I wonder, where do you intend to get hp from in the 
console::print() hook?

thanks,
-- 
js
suse labs
