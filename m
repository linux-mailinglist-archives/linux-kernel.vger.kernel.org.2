Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5365F3F15A1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhHSIzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 04:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhHSIzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:55:37 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8297AC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:55:01 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so4261041pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=gywVlIY+YAjIgxJm+mzM0vRV01mih4OUlQhYHWTpuM8=;
        b=mWUTppjZAlVKZPZ9xHpOoIFiewf9qLSr9hlUR9msIURe0yTfZ8KLi2daorQEP3TenY
         x4h4gTiWYHUVWJtukEkYjIGftxUsXB9XHgKF3/TpVq7vOPU8Viurf6+bR5kE8P8mSlmY
         fivnY4yzp4zzOpTc6VwKey2hukOEhyBZYb9UXkaW0SII8xeNGCwJJQNR/5kmCnizLqi7
         qZihPA0UfG0KmC73xqvjiJxTb9m3Ro+j6hUve2yi6ul8YMEzSuvvNpqkl6IVJJ1sQ11x
         GshIHwM2WQclnUKbPobm5GgIyxVmVlZukeEaIxQDUkk0sfGHBA5pmn3jJLXugTT5g19p
         tZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=gywVlIY+YAjIgxJm+mzM0vRV01mih4OUlQhYHWTpuM8=;
        b=b3W6QxEtIHIAi1UNmfUYJC8BlsEywdUlT6mASswJOC20/ybpaqbEEZC4MSGF4hFlIV
         p7eJRf3Gq/PK3jpe30ZfE+B0k4e6Os3clJIoa4F8+ALAQ/60RExSO/GvDJs5gbrNgz/6
         mwe1gZ/yWpLFF79KHUrO524Z2RFnfU34gUZWTNHI5y4H+mBlnNTFbzNjXJVp5aJkmqr/
         2c9u+3tCSKSw5Q33gqSMd/1r4JcgI8iAwuRKDYEPgHQioc4lqu5i9YalkydiuPvSD9RE
         0r64I+y1CUK8m2+EqApIf021/iUl12eL1id2VuigBkZHVbRZfOjOZeLgK8gej9mo8RsT
         d84A==
X-Gm-Message-State: AOAM530+qpIEIA11knHRp4T+6Wuq+I4skWuvILfkEDpDi8kNKoj0Ywqh
        EdhwSvHMu9xoYAitdTGCjhhXtrXDg7A=
X-Google-Smtp-Source: ABdhPJwrbKPsQiwDHz3T9qC4vgMId6360khFp+69YXyp+WCBKhXrTY21kbVBrsJuIk5UgL/RccGDvg==
X-Received: by 2002:a17:902:bc84:b029:12c:f9b9:db98 with SMTP id bb4-20020a170902bc84b029012cf9b9db98mr11049581plb.19.1629363300687;
        Thu, 19 Aug 2021 01:55:00 -0700 (PDT)
Received: from [166.111.139.106] ([166.111.139.106])
        by smtp.gmail.com with ESMTPSA id gl12sm7711777pjb.40.2021.08.19.01.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 01:55:00 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] fs: dlm: possible ABBA deadlock
To:     ccaulfie@redhat.com, teigland@redhat.com
Cc:     cluster-devel@redhat.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <79f8d302-f53f-3891-965a-bcb460ab15ca@gmail.com>
Date:   Thu, 19 Aug 2021 16:54:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My static analysis tool reports a possible ABBA deadlock in the dlm 
filesystem in Linux 5.10:

dlm_recover_waiters_pre()
   mutex_lock(&ls->ls_waiters_mutex); --> line 5130
   recover_convert_waiter()
     _receive_convert_reply()
       lock_rsb()
         mutex_lock(&r->res_mutex); --> line 69

dlm_recover_waiters_post()
   lock_rsb()
     mutex_lock(&r->res_mutex); --> line 69
   mutex_lock(&ls->ls_waiters_mutex); --> line 5307

When dlm_recover_waiters_pre() and dlm_recover_waiters_post() are 
concurrently executed, the deadlock can occur.

I am not quite sure whether this possible deadlock is real and how to 
fix it if it is real.
Any feedback would be appreciated, thanks :)

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>


Best wishes,
Jia-Ju Bai
