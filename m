Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC58381031
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 21:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbhENTBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 15:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhENTBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 15:01:50 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47076C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 12:00:39 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gv8-20020a17090b11c8b029015d47d8ecbbso317931pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 12:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UCybwO0TaczTSlpLwTibNxV8SjBVCUt+aJC9ueKaUsc=;
        b=bhrjbmVoLzZrE0Ye3zSI7lNoZD7nvh/L3Yqq95EI4+CnJ0Syo1J7GFnmqO+AtMBM8/
         DSAbWGDASNfIDYGnB9BKkvavgGmYfk/6erDQCmQsoQ106PaAkQQ3spPJfedq3hnR/Bzy
         8f0VEPWrBOduCQjJsJTse8mAMQi2RJssi2Png=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UCybwO0TaczTSlpLwTibNxV8SjBVCUt+aJC9ueKaUsc=;
        b=Ttp7zz3Xz8SxJPk2AXYE05WypI+0VmjL5nMI4TN8IYZcWr9ZkHwOodeMcJp9+ARSby
         D5Ka1B7jYqnewDQrO1W6QfSLytRvbQ9LAhpOxu4r3MPVkBUkOculBWt6ZI5ACoxnQXzZ
         42q+a3feXK9RtVDKyI5dC1cHox0Oty7jmyxjZyGJjmhJPG6oTObzjOe7UllcT5ytYeIy
         UTv7WJztLf6mZX++1/1JDjX5wFplzoPok05REIKvY8M7KYwJWzVZsinoLKq01nWXh9fx
         TS9Ze6PtrsbRDLH+kUQHYO1fvS+Jce/Ts1gHJlDDbmaNihIY1AEzlEBMyUL7LMIDU2aG
         K6KQ==
X-Gm-Message-State: AOAM532nzfT4DRtjsIldh3ENq7G3uQah0wCsG0QuX0ycHw2i2xDIIQGF
        rHkKDmoykpEJmVir/Wz6JCxwWg==
X-Google-Smtp-Source: ABdhPJzwydOqrNEs8BGiriz1WpXA2XMtZmviya9EPj7XrWMKzuXa+83JaN7GU/Lf5l1HjO2uimqTAA==
X-Received: by 2002:a17:90a:b38c:: with SMTP id e12mr4308880pjr.134.1621018838886;
        Fri, 14 May 2021 12:00:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h4sm10577030pjc.12.2021.05.14.12.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 12:00:38 -0700 (PDT)
Date:   Fri, 14 May 2021 12:00:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v26 03/25] LSM: provide lsm name and id slot mappings
Message-ID: <202105141200.F0001143A@keescook>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
 <20210513200807.15910-4-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513200807.15910-4-casey@schaufler-ca.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 01:07:45PM -0700, Casey Schaufler wrote:
> Provide interfaces to map LSM slot numbers and LSM names.
> Update the LSM registration code to save this information.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Seems a reasonable set of utilities. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
