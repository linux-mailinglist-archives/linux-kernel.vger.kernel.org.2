Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305A835ADD1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 15:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbhDJNx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 09:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbhDJNx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 09:53:56 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E66C06138B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 06:53:41 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s15so9730112edd.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 06:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bv2vUSAnN3p10ry0IvtHE0T+2d/JPvTUdYnOAvNQIfM=;
        b=Z5q6J/B/RehQpXADwE8ru8iJSam25LnH1sQlgPRhW/X8zGcawKP/h0JMmw611R9Z2y
         FYRd8V9JKBCqbGRY8s6aVaz9IuB61CD9SYVuyRnR71XmDWDydhMxrjWuEWKIUinKo6HJ
         CEb0SRjlM0WLAsZDnybvK16NP5tKzBhWXM2D4foXvUQJYFcme2PEQNvLYKzyP09yVJdY
         YHTNzGxLMQ+zm/nb+2/QOqsnuJ2r23z9yCThKZI4bL7FF6DDC+RCnwsHZu5nTYJbh16R
         zQM83k/gg7PSuOH0s52vCceihWfdjGEbpW6gRw6Iu91s2OVFQe1FFm0QdOPAEuS7rC7x
         Ueug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bv2vUSAnN3p10ry0IvtHE0T+2d/JPvTUdYnOAvNQIfM=;
        b=PSfte/Oqb0SGdkv8oPgoTh5am9GFCIe7RLx2bp0lsSWncmz251pTe3/HrRzJCupThD
         /sLgNgM/tt94tB7sIt9UNqN6Fy8yoMqkfgJAMDegbCWlzL72ib8jaL1kxnPwrbujJ+Qd
         zc+J1JX56ZvqSZ5vjzpIWOOe2sP94MH6NmzcNX+tsa/PueAIWxslxsABJ3EAqMVXRG7q
         GLK/S5AseCANrhjxvm/D68dKBV7rYNl4yhf0SI7skOxN6NTmTeTqxvCxnFay4lhUPPNT
         hDY+8gCAp9DRJkMQ0r2SQ5E8KuYaKg05wjWP/sgsNHhOIx2GzU3z5xe25m+zaDi7RBPY
         cuMg==
X-Gm-Message-State: AOAM533yF/g2S0pAbsZbxsFHPoU5wShp/N6V9MyIZOlDYw56IM60+R/A
        K8kbggssGw9EX7nuY2GThYE=
X-Google-Smtp-Source: ABdhPJxeA/Xint5gQd7Fq2TpE4bCqqRtNYIpTOjTgiJwZ5DD9gz58ffVZ6KeZP8VJD33qhMRPRhVQQ==
X-Received: by 2002:aa7:dc0b:: with SMTP id b11mr22171923edu.124.1618062819950;
        Sat, 10 Apr 2021 06:53:39 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id lj21sm600651ejb.74.2021.04.10.06.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 06:53:39 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 4/4] staging: rtl8723bs: Change the type and use of a variable
Date:   Sat, 10 Apr 2021 15:53:38 +0200
Message-ID: <3114102.qbl0ZuBMXl@localhost.localdomain>
In-Reply-To: <alpine.DEB.2.22.394.2104101524260.2975@hadrien>
References: <20210410092232.15155-1-fmdefrancesco@gmail.com> <2186059.xkuF2sVEJi@localhost.localdomain> <alpine.DEB.2.22.394.2104101524260.2975@hadrien>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, April 10, 2021 3:24:43 PM CEST Julia Lawall wrote:
> On Sat, 10 Apr 2021, Fabio M. De Francesco wrote:
> > On Saturday, April 10, 2021 2:12:28 PM CEST Julia Lawall wrote:
> > > On Sat, 10 Apr 2021, Fabio M. De Francesco wrote:
> > > > On Saturday, April 10, 2021 1:37:30 PM CEST Julia Lawall wrote:
> > > > > > That variable has global scope and is assigned at least in:
> > > > > What do you mean by global scope?  None of the following look
> > > > > like
> > > > > references to global variables.
> > > > > 
> > > > > julia
> > > > 
> > > > I just mean that fw_current_in_ps_mode is a field of a struct in a
> > > > .h
> > > > file included everywhere in this driver and that the functions whom
> > > > the following assignments belong to have not the "static" type
> > > > modifier.
> > > 
> > > OK, but a field in a structure is not a variable, and this is not
> > > what
> > > scope means.
> > 
> > You're right, a field in a structure is not a variable.
> > 
> > > int x;
> > > 
> > > outside of anything is a global variable (global scope).
> > > 
> > > int foo() {
> > > 
> > >   int x;
> > >   ...
> > > 
> > > }
> > > 
> > > Here x is a local variable.  Its scope is the body of the function.
> > > 
> > > int foo() {
> > > 
> > >   if (abc) {
> > >   
> > >     int x;
> > >     ...
> > >   
> > >   }
> > > 
> > > }
> > > 
> > > Here x is a local variable, but its scope is only in the if branch.
> > 
> > And you're right again: I needed a little refresh of my knowledge of C.
> > 
> > I've searched again in the code for the purpose of finding out if that
> > struct is initialized with global scope but I didn't find anything. I
> > didn't even find any dynamic allocation within functions that returns
> > pointers to that struct.
> > 
> > Therefore, according to Greg's request, I'll delete that stupid 'if'
> > statement in the patch series v2 that I'm about to submit.
> 
> I'm really not clear on why the if should be deleted.
> 
> julia
>
I'm supposed to delete it because of the review made by Greg. In a couple 
of previous messages he wrote:

"If this is only checked, how can it ever be true?  Who ever sets this 
value?"

and then:

"Just delete the variable from the structure entirely and when it is
used.".

However, like you, I'm not sure yet.

Thanks,

Fabio
> 
> > I've really appreciated your help.
> > 
> > Thanks,
> > 
> > Fabio
> > 
> > > julia
> > > 
> > > > Thanks,
> > > > 
> > > > Fabio
> > > > 
> > > > > > drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:368:
> > > > > > pwrpriv->fw_current_in_ps_mode = false;
> > > > > > 
> > > > > > drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:380:
> > > > > > pwrpriv->fw_current_in_ps_mode = true;
> > > > > > 
> > > > > > drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:433:
> > > > > > adapter_to_pwrctl(padapter)->fw_current_in_ps_mode = false;
> > > > > > 
> > > > > > drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:981:
> > > > > > pwrctrlpriv->fw_current_in_ps_mode = false;




