Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4CC342074
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 16:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhCSPCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 11:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhCSPCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:02:39 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88EAC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:02:38 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id hq27so10232533ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vUoOu7agSTM4o48gPJLYLcyZ5QlQnr4TzAJ4RXshIiA=;
        b=JinUrHEY3FUG3OBWYgdkbr0nNigXWVhQbYi/zz2Lyw2IQscLLz+ylaA59Vz2ZQIaj2
         XFWDWbhnWISuQXmnhJ37LtdkNW00EcCi7y6vq1DmMb9OsXX+aEjgyJpHFwqTHeVXhOl2
         uK+Qa21XBNANTUm/wEPUOZga/pcdojyhH1bTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vUoOu7agSTM4o48gPJLYLcyZ5QlQnr4TzAJ4RXshIiA=;
        b=a1di7OyHVoYlGyrJbYpISwnqeoYBxfttMKu+ERuNgbzpezRU5dnNIx+SN7QgbG7gui
         D2akjSjzGlEotEc1Vm8kRUV9+3L23G6pq777HkZEAXtu520yttpH0/yBRMF/drDqFJnA
         BNAkQ7Cxnh6gxgDP3D72q5lG/Z/k5d+NKJbirhtRUcjk1ob4ZPNctkl8frdkmnblqNfV
         n+bUF02uJH3W8U4vAR37+31cFJsc7DBHorrIAJPxFSFLR738egQ1lecxQrmzq+xVlOen
         SB5MplVQ6YaGhiUurN/HYCuevlXJH5EcxojR8Avxrjj+HYE+0XFBTNpjlBgG0JmO32fn
         3dfg==
X-Gm-Message-State: AOAM532P1211RmfVnBD2uFSehCQf9qoELgp6fJPqON4DorMteoBWLy2z
        5s9ccYpw8sGKBdiM2zNB3y2VXA==
X-Google-Smtp-Source: ABdhPJyUA/30/66Jrqj8l7qBqYGrm5xt5nwCoPgbzhEV3H6DWZV55EC2udDYKycYf6M3J8cLgJ5CmQ==
X-Received: by 2002:a17:906:7f01:: with SMTP id d1mr4992321ejr.136.1616166155402;
        Fri, 19 Mar 2021 08:02:35 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:fa59:71ff:fe7e:8d21])
        by smtp.gmail.com with ESMTPSA id sb4sm3858358ejb.71.2021.03.19.08.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 08:02:35 -0700 (PDT)
Date:   Fri, 19 Mar 2021 15:02:34 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-nfs@vger.kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] SUNRPC: Output oversized frag reclen as ASCII if
 printable
Message-ID: <YFS9CuBO/FxJdRGB@chrisdown.name>
References: <YFS7L4FIQBDtIY9d@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YFS7L4FIQBDtIY9d@chrisdown.name>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks,

Let me know if you'd like more evidence that this is a persisting problem. Also 
more than happy to change the generation of the whole debug string to go into 
svc_sock_reclen_ascii or use LOG_CONT if you'd prefer to avoid the multiple 
ternaries (but the latter probably needs some thought about how it interacts 
with ratelimit).

Thanks,

Chris
