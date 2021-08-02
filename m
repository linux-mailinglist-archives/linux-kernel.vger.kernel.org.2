Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE1D3DD5C9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 14:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhHBMi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 08:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbhHBMi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 08:38:56 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C292C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 05:38:46 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u15so10328226wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 05:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=+iwG4dwu630d56k0IddJZl8d8Tb26J8/7JwX5jp3IJ8=;
        b=AOI8xE+J1IgNBqVmvWL0kunhRPa8Tm8fgJY7mMSBDDyWGgcWFeFYvOmrLlbAM+Pyi9
         Blg+XG/hoDX9btv1U/uWh8hvyb8Yyt72/6iIWDemCO9d8FV/i9hRk81WEXcoll8G6e1P
         AId9XTJvNYN4uukyfryosNRSlzf4xF1bAuIPJwCYa3jksjy/Q7zpaIrkMWhH7SJarode
         LTJxMbIuoM7QPHn4q87KHnaTWWspiwaAbRkr1DAZQjnVwdoi2l4kSJnAlT3JiDSuNHzR
         PJZK1MU6D6UvYk1s2T8Ov58X74KLNBe6xvKfE3jFzYslltBvnCW/4FcRO/ed3LaUOF2R
         L48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+iwG4dwu630d56k0IddJZl8d8Tb26J8/7JwX5jp3IJ8=;
        b=FGsfVzTY4c9MpkotvmWoUZ3w7IysgfS9MT45FDTHI9GFgtYmdwoSmTWv+UpHxXhAjG
         Y0NVoURT1Dol84iccb6u0/e7ETo+4O8eldI1k1r96itSg1AYfldQJ/Nm0i6+dV0Xuvox
         Fx+z+KVuUpeHCV4waS8aSOUfD/M1cZ3R4SHLyMqpg47oSBqIw6s22wGOR9phXF2AdU9Q
         WqpF5UU2yFGFGcdxGBgLPISFZMgpQNO7aOV1CVJzxdWyCCQLQgnyE76ze+lY0oiV80ac
         3x03cg2sZ+fPmMrHpyOeRZV+qG4nK68hhh4fSnHugTM2R+dG0EQfjvbpGdgISZDCt6Xu
         AJAA==
X-Gm-Message-State: AOAM531I9qsnEIoutbOHr/y9Y26B7G/hQMtGpRKOj0LvGV5kxH/BnppC
        LEbOealpePPg0+XqGHIzqJY=
X-Google-Smtp-Source: ABdhPJziT2hGn88fhyV5m6uDGOZe4vRiWnpKzETiW6DtTKbGsi5lbt+/ti5aGWb1djGpfbimwkssQw==
X-Received: by 2002:a05:600c:304a:: with SMTP id n10mr16999122wmh.79.1627907924730;
        Mon, 02 Aug 2021 05:38:44 -0700 (PDT)
Received: from [10.8.0.10] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id s2sm9992886wmh.46.2021.08.02.05.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 05:38:44 -0700 (PDT)
To:     Glibc <libc-alpha@sourceware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Subject: Document the types "struct termios" and "struct termios2"
Message-ID: <ef6a352d-4926-9cdc-9894-e387866a00c4@gmail.com>
Date:   Mon, 2 Aug 2021 14:38:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 From a few patches of Pali and their subsequent discussions, it was 
clear that those types need to be documented (the most appropriate place 
being system_data_types(7), with link pages termios-struct(3) and 
termios2-struct(3)).

The most important part (the one we had problems with) being which 
headers should be included for each type (and for each version of the 
type (kernel/glibc)).  That includes the recommended header, and other 
headers that _shall_ also provide the type.

Is there someone that knows those types enough to write such 
documentation and wants to do it? :)

Thanks,

Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
