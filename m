Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BD730ACD9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhBAQji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 11:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbhBAQjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:39:19 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281DEC0613ED
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 08:38:33 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id c132so12440076pga.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 08:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=o5OegAwYBP7PDdDVCaWSc0Mm4jxXMRKanjN+//S5os4=;
        b=O3CWgP9TAyDK5LPmF4T2q9CV9B0Kz0SQv4SX26ugTFakH5Z7NpbgCSsX8NRm8CrRO1
         nZVtaWJXHMdwPpQBBHDZWq1h4MI+QgroSUupDz+kfvxbDixmIZjpZrwCjeJQERAsZgKc
         eZVg1It1HrEPukVaUWeHKV+099uzFegKWBAtRaNPQtOnvKxnNPDbyC7OPFBWYcxl2piC
         F3WPln8n7tPDTroPasz6GQsr1XpZwdGoYhUWxQ5VQVR7jAYrDYPRbga7T6SCk7iqjF+I
         JwzPb2ISY14r6kgkuY+Raw3hVmNX+3ew/iFVl+plRyFKBy8z0eBjKiI+PZjTfM70oHpc
         FUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=o5OegAwYBP7PDdDVCaWSc0Mm4jxXMRKanjN+//S5os4=;
        b=L3pYDsLhXVD25IxvYLHCN5bRjJ16EcYQOiY3O9/+VaSOhtaK3Dc48gW4bvDP/HERjD
         2td81ozQWkbT01lSestS2qvM9lojwyAmkA2CSJE1YrXiLlsOXVLzVmwxuxOPVf6AV+mb
         MGlKzuesrXlBJcxVJZ6+LWtkSJFfpjf9FCSDa5sE/N13ejG3hhtyvBkOc9JedQ0bfAT2
         BW/dWTRwmEvS/YMJ/b3COgmOhbTF4vpelyVswfERTRpstXstZQIO19hWQihxHUEfzJkt
         Za0O194y+F7Rqxm4JFa7McvClhsKZpIMjidsn3x6OF/kj+Uz+GreO5hkowN12fM7r6i+
         gjIA==
X-Gm-Message-State: AOAM531XYEiDrH15RqqeWRyZlaKIV2CIwr+FgIFWgi4PTavQTrHsdLbx
        GHfatf/9M/bMQ+Ge5grVgIyGfEQqm4FUuQ==
X-Google-Smtp-Source: ABdhPJyCTEYk3E/Io9fOnEjzLf2ujgaSewO5YsDaX6qy2kQ1ru/eTGxs2TRgjt4QlknJu5DaDj27tw==
X-Received: by 2002:a63:2009:: with SMTP id g9mr17698369pgg.219.1612197511466;
        Mon, 01 Feb 2021 08:38:31 -0800 (PST)
Received: from google.com ([2620:15c:f:10:829:fccd:80d7:796f])
        by smtp.gmail.com with ESMTPSA id e12sm19159714pga.13.2021.02.01.08.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 08:38:30 -0800 (PST)
Date:   Mon, 1 Feb 2021 08:38:24 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jmattson@google.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] KVM: x86: Allow guests to see MSR_IA32_TSX_CTRL even
 if tsx=off
Message-ID: <YBgugM03fsEiOxz1@google.com>
References: <20210129101912.1857809-1-pbonzini@redhat.com>
 <YBQ+peAEdX2h3tro@google.com>
 <37be5fb8-056f-8fba-3016-464634e069af@redhat.com>
 <618c5513-5092-f7cd-b47b-933936001180@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <618c5513-5092-f7cd-b47b-933936001180@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021, Paolo Bonzini wrote:
> On 01/02/21 09:46, Paolo Bonzini wrote:
> > > 
> > > This comment be updated to call out the new TSX_CTRL behavior.
> > > 
> > >     /*
> > >      * On TAA affected systems:
> > >      *      - nothing to do if TSX is disabled on the host.
> > >      *      - we emulate TSX_CTRL if present on the host.
> > >      *      This lets the guest use VERW to clear CPU buffers.
> > >      */
> > 
> > Ok.
> 
> Hmm, but the comment is even more accurate now than before, isn't it? It
> said nothing about hiding TSX_CTRL, so now it matches the code below.

Ha, that is technically true.  But it says "nothing to do..." and then clears a
flag.  The other interpretation of "nothing to do... at runtime" is also wrong
as KVM emulates the MSR as a nop.

I guess I just find the whole comment more confusing than the code itself.
