Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA004256B9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 17:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241253AbhJGPjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 11:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhJGPi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 11:38:59 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA58FC061570;
        Thu,  7 Oct 2021 08:37:05 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j5so26595800lfg.8;
        Thu, 07 Oct 2021 08:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3oI1BPN+nka/fzeeDadlYPWTNRGu2uv1un/7jFglctU=;
        b=hI6IAHPtxsN/zUMag/AikB2qPujAq4WmyQDQZ6or4zGzt/r2JuQ5UcFxpxPK14VFbG
         qC6IB/grAoBRIXdRKWZLe94jlo0BL+H7Mw/2A2wiilSJmU2UMbqjZcRj4ZYMear3J9It
         +qHolatwuCCfjYDpBJ8f0dyt5sKUIuf9EQN3tPpusw5hocpHreYiTWTIUDB8eVSKdqvS
         CawyN0ZigfaZ5+ClhjAereXSKGWt1hfm0YKdFMBwLcHdROMl3Epe1wnhVcYZfn9GdOw6
         VH8cwOJf9cc9UAMRIhUP5EC+ZEyhbE4ZJdpTE34PZHWH7UvcaTgV8NJ1c+41GoFbjubU
         IF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3oI1BPN+nka/fzeeDadlYPWTNRGu2uv1un/7jFglctU=;
        b=VyZK1yRyRXs1bHYvzYDvxItd0QpwzdGgMSEoIriIKkS1q0++rF4iLW2GC3XfOToV+r
         Bm5fInSi9FjBmenpmvWjORraYwtS8Zt8qLiEfScFKpUML+1OW3p5Q6hY+PFkXpu67LUA
         G0plVy0hZBP/1Gzl/OEYrDO/oxB/H9gyM9fBqLVSLsfSnkV7AHXsyjzcCets66czDCyb
         xfXoL065WTJs7hiSCmiDxDjgpO3eQzJgTNTptxN6yJkNz2iwjSL8XLkJhotuowINSQCQ
         9r2nH05C4tEKsXhX9QB3bi/omlOWXDXeZ0977ImEwE0B++T/qWph+HRJZWZpczQs6TKz
         o8WA==
X-Gm-Message-State: AOAM530uaEr+Wyxnarlcr655G5a9/1GxAY4dcMm0xC2IktXUHP6uyoeI
        ttWD33ZDiqLMGIMvtydt6zU=
X-Google-Smtp-Source: ABdhPJyARJ/nKHhgnikSZL7H8U8sQ+ssnKQmOurxR2oCACf+suwYGrpPEbIpNifyRUQ03wbT2B/UCQ==
X-Received: by 2002:a2e:701a:: with SMTP id l26mr5074473ljc.101.1633621024016;
        Thu, 07 Oct 2021 08:37:04 -0700 (PDT)
Received: from penguin.lxd ([94.153.6.46])
        by smtp.gmail.com with ESMTPSA id s4sm2577792ljp.115.2021.10.07.08.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 08:37:03 -0700 (PDT)
Date:   Thu, 7 Oct 2021 18:36:53 +0300
From:   Denis Pauk <pauk.denis@gmail.com>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     andy.shevchenko@gmail.com, Ed Brindley <kernel@maidavale.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 3/3] hwmon: (asus_wmi_sensors) Support X370 Asus WMI.
Message-ID: <20211007183653.7f951658@penguin.lxd>
In-Reply-To: <CAB95QASyv0MGiPGeu3ie7VSK_EjOR7x6kRsK57J5W-56dU0Nxw@mail.gmail.com>
References: <20211006222502.645003-1-pauk.denis@gmail.com>
        <20211006222502.645003-4-pauk.denis@gmail.com>
        <CAB95QASyv0MGiPGeu3ie7VSK_EjOR7x6kRsK57J5W-56dU0Nxw@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugene,

On Thu, 7 Oct 2021 12:56:09 +0200
Eugene Shalygin <eugene.shalygin@gmail.com> wrote:

> Hello, Denis,
> 
> On Thu, 7 Oct 2021 at 00:25, Denis Pauk <pauk.denis@gmail.com> wrote:
> 
> > +MODULE_AUTHOR("Eugene Shalygin <eugene.shalygin@gmail.com>");  
> 
> No, I am not.
I will remove.

> 
> Best regards,
> Eugene
> 
> P.S. You stripped module aliases for this one too. Why? This driver
> certainly can benefit from them, because the presence of the specific
> WMI UUIDs unambiguously defines its condition to work.
I looked complicated to support two kind of WMI interfaces with UUID.
As we split big support module to two separate - I will look to such
change also.

Best regards,
     Denis. 
